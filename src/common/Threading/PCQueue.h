/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _PCQ_H
#define _PCQ_H

#include <atomic>
#include <condition_variable>
#include <mutex>
#include <queue>
#include <type_traits>

template <typename T>
class ProducerConsumerQueue
{
private:
    std::mutex _queueLock;
    std::queue<T> _queue;
    std::condition_variable _condition;
    std::atomic<bool> _shutdown;

public:
    ProducerConsumerQueue<T>() : _shutdown(false) = default;

    void Push(const T& value)
    {
        std::lock_guard<std::mutex> lock(_queueLock);
        _queue.push(std::move(value));

        _condition.notify_one();
    }

    auto Empty() -> bool
    {
        std::lock_guard<std::mutex> lock(_queueLock);

        return _queue.empty();
    }

    [[nodiscard]] auto Size() const -> size_t
    {
        return _queue.size();
    }

    auto Pop(T& value) -> bool
    {
        std::lock_guard<std::mutex> lock(_queueLock);

        if (_queue.empty() || _shutdown)
        {
            return false;
        }

        value = _queue.front();

        _queue.pop();

        return true;
    }

    void WaitAndPop(T& value)
    {
        std::unique_lock<std::mutex> lock(_queueLock);

        // we could be using .wait(lock, predicate) overload here but it is broken
        // https://connect.microsoft.com/VisualStudio/feedback/details/1098841
        while (_queue.empty() && !_shutdown)
        {
            _condition.wait(lock);
        }

        if (_queue.empty() || _shutdown)
        {
            return;
        }

        value = _queue.front();

        _queue.pop();
    }

    void Cancel()
    {
        std::unique_lock<std::mutex> lock(_queueLock);

        while (!_queue.empty())
        {
            T& value = _queue.front();

            DeleteQueuedObject(value);

            _queue.pop();
        }

        _shutdown = true;

        _condition.notify_all();
    }

private:
    template<typename E = T>
    auto DeleteQueuedObject(E& obj) -> typename std::enable_if<std::is_pointer<E>::value>::type { delete obj; }

    template<typename E = T>
    auto DeleteQueuedObject(E const& /*packet*/) -> typename std::enable_if<!std::is_pointer<E>::value>::type { }
};

#endif
