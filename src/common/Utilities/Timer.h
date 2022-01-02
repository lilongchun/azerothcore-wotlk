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

#ifndef ACORE_TIMER_H
#define ACORE_TIMER_H

#include "Common.h"
#include "Duration.h"

inline auto GetApplicationStartTime() -> TimePoint
{
    using namespace std::chrono;

    static const steady_clock::time_point ApplicationStartTime = steady_clock::now();

    return ApplicationStartTime;
}

inline auto getMSTime() -> uint32
{
    using namespace std::chrono;

    return uint32(duration_cast<milliseconds>(steady_clock::now() - GetApplicationStartTime()).count());
}

inline auto getMSTimeDiff(uint32 oldMSTime, uint32 newMSTime) -> uint32
{
    // getMSTime() have limited data range and this is case when it overflow in this tick
    if (oldMSTime > newMSTime)
    {
        return (0xFFFFFFFF - oldMSTime) + newMSTime;
    }
    else
    {
        return newMSTime - oldMSTime;
    }
}

inline auto getMSTimeDiff(uint32 oldMSTime, TimePoint newTime) -> uint32
{
    using namespace std::chrono;

    uint32 newMSTime = uint32(duration_cast<milliseconds>(newTime - GetApplicationStartTime()).count());
    return getMSTimeDiff(oldMSTime, newMSTime);
}

inline auto GetMSTimeDiffToNow(uint32 oldMSTime) -> uint32
{
    return getMSTimeDiff(oldMSTime, getMSTime());
}

struct IntervalTimer
{
public:
    IntervalTimer()

    = default;

    void Update(time_t diff)
    {
        _current += diff;
        if (_current < 0)
        {
            _current = 0;
        }
    }

    auto Passed() -> bool
    {
        return _current >= _interval;
    }

    void Reset()
    {
        if (_current >= _interval)
        {
            _current %= _interval;
        }
    }

    void SetCurrent(time_t current)
    {
        _current = current;
    }

    void SetInterval(time_t interval)
    {
        _interval = interval;
    }

    [[nodiscard]] auto GetInterval() const -> time_t
    {
        return _interval;
    }

    [[nodiscard]] auto GetCurrent() const -> time_t
    {
        return _current;
    }

private:
    time_t _interval{0};
    time_t _current{0};
};

struct TimeTracker
{
public:
    TimeTracker(time_t expiry)
        : i_expiryTime(expiry)
    {
    }

    void Update(time_t diff)
    {
        i_expiryTime -= diff;
    }

    [[nodiscard]] auto Passed() const -> bool
    {
        return i_expiryTime <= 0;
    }

    void Reset(time_t interval)
    {
        i_expiryTime = interval;
    }

    [[nodiscard]] auto GetExpiry() const -> time_t
    {
        return i_expiryTime;
    }

private:
    time_t i_expiryTime;
};

struct TimeTrackerSmall
{
public:
    TimeTrackerSmall(uint32 expiry = 0)
        : i_expiryTime(expiry)
    {
    }

    void Update(int32 diff)
    {
        i_expiryTime -= diff;
    }

    [[nodiscard]] auto Passed() const -> bool
    {
        return i_expiryTime <= 0;
    }

    void Reset(uint32 interval)
    {
        i_expiryTime = interval;
    }

    [[nodiscard]] auto GetExpiry() const -> int32
    {
        return i_expiryTime;
    }

private:
    int32 i_expiryTime;
};

struct PeriodicTimer
{
public:
    PeriodicTimer(int32 period, int32 start_time)
        : i_period(period), i_expireTime(start_time)
    {
    }

    auto Update(const uint32 diff) -> bool
    {
        if ((i_expireTime -= diff) > 0)
        {
            return false;
        }

        i_expireTime += i_period > int32(diff) ? i_period : diff;
        return true;
    }

    void SetPeriodic(int32 period, int32 start_time)
    {
        i_expireTime = start_time;
        i_period = period;
    }

    // Tracker interface
    void TUpdate(int32 diff) { i_expireTime -= diff; }
    [[nodiscard]] auto TPassed() const -> bool { return i_expireTime <= 0; }
    void TReset(int32 diff, int32 period)  { i_expireTime += period > diff ? period : diff; }

private:
    int32 i_period;
    int32 i_expireTime;
};

#endif
