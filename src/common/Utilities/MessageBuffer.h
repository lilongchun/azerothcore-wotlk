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

#ifndef __MESSAGEBUFFER_H_
#define __MESSAGEBUFFER_H_

#include "Define.h"
#include <cstring>
#include <vector>

class MessageBuffer
{
    using size_type = std::vector<uint8>::size_type;

public:
    MessageBuffer() :  _storage()
    {
        _storage.resize(4096);
    }

    explicit MessageBuffer(std::size_t initialSize) : _wpos(0), _rpos(0), _storage()
    {
        _storage.resize(initialSize);
    }

    MessageBuffer(MessageBuffer const& right) :
        _wpos(right._wpos), _rpos(right._rpos), _storage(right._storage) { }

    MessageBuffer(MessageBuffer&& right) noexcept :
        _wpos(right._wpos), _rpos(right._rpos), _storage(right.Move()) { }

    void Reset()
    {
        _wpos = 0;
        _rpos = 0;
    }

    void Resize(size_type bytes)
    {
        _storage.resize(bytes);
    }

    auto GetBasePointer() -> uint8* { return _storage.data(); }
    auto GetReadPointer() -> uint8* { return GetBasePointer() + _rpos; }
    auto GetWritePointer() -> uint8* { return GetBasePointer() + _wpos; }

    void ReadCompleted(size_type bytes) { _rpos += bytes; }
    void WriteCompleted(size_type bytes) { _wpos += bytes; }

    [[nodiscard]] size_type GetActiveSize() const { return _wpos - _rpos; }
    [[nodiscard]] size_type GetRemainingSpace() const { return _storage.size() - _wpos; }
    [[nodiscard]] size_type GetBufferSize() const { return _storage.size(); }

    // Discards inactive data
    void Normalize()
    {
        if (_rpos)
        {
            if (_rpos != _wpos)
            {
                memmove(GetBasePointer(), GetReadPointer(), GetActiveSize());
            }

            _wpos -= _rpos;
            _rpos = 0;
        }
    }

    // Ensures there's "some" free space, make sure to call Normalize() before this
    void EnsureFreeSpace()
    {
        // resize buffer if it's already full
        if (GetRemainingSpace() == 0)
        {
            _storage.resize(_storage.size() * 3 / 2);
        }
    }

    void Write(void const* data, std::size_t size)
    {
        if (size)
        {
            memcpy(GetWritePointer(), data, size);
            WriteCompleted(size);
        }
    }

    std::vector<uint8>&& Move()
    {
        _wpos = 0;
        _rpos = 0;

        return std::move(_storage);
    }

    auto operator=(MessageBuffer const& right) -> MessageBuffer&
    {
        if (this != &right)
        {
            _wpos = right._wpos;
            _rpos = right._rpos;
            _storage = right._storage;
        }

        return *this;
    }

    auto operator=(MessageBuffer&& right) noexcept -> MessageBuffer&
    {
        if (this != &right)
        {
            _wpos = right._wpos;
            _rpos = right._rpos;
            _storage = right.Move();
        }

        return *this;
    }

private:
    size_type _wpos{0};
    size_type _rpos{0};
    std::vector<uint8> _storage;
};

#endif /* __MESSAGEBUFFER_H_ */
