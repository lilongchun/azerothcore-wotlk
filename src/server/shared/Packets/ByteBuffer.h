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

#ifndef _BYTEBUFFER_H
#define _BYTEBUFFER_H

#include "ByteConverter.h"
#include "Define.h"
#include <array>
#include <cstring>
#include <string>
#include <vector>

class MessageBuffer;

// Root of ByteBuffer exception hierarchy
class AC_SHARED_API ByteBufferException : public std::exception
{
public:
    ~ByteBufferException() noexcept override = default;

    [[nodiscard]] auto what() const noexcept -> char const* override { return msg_.c_str(); }

protected:
    auto message() noexcept -> std::string & { return msg_; }

private:
    std::string msg_;
};

class AC_SHARED_API ByteBufferPositionException : public ByteBufferException
{
public:
    ByteBufferPositionException(bool add, size_t pos, size_t size, size_t valueSize);

    ~ByteBufferPositionException() noexcept override = default;
};

class AC_SHARED_API ByteBufferSourceException : public ByteBufferException
{
public:
    ByteBufferSourceException(size_t pos, size_t size, size_t valueSize);

    ~ByteBufferSourceException() noexcept override = default;
};

class AC_SHARED_API ByteBufferInvalidValueException : public ByteBufferException
{
public:
    ByteBufferInvalidValueException(char const* type, char const* value);

    ~ByteBufferInvalidValueException() noexcept override = default;
};

class AC_SHARED_API ByteBuffer
{
public:
    constexpr static size_t DEFAULT_SIZE = 0x1000;

    // constructor
    ByteBuffer()  
    {
        _storage.reserve(DEFAULT_SIZE);
    }

    ByteBuffer(size_t reserve) : _rpos(0), _wpos(0)
    {
        _storage.reserve(reserve);
    }

    ByteBuffer(ByteBuffer&& buf) noexcept :
        _rpos(buf._rpos), _wpos(buf._wpos), _storage(std::move(buf._storage))
    {
        buf._rpos = 0;
        buf._wpos = 0;
    }

    ByteBuffer(ByteBuffer const& right) = default;
    ByteBuffer(MessageBuffer&& buffer);
    virtual ~ByteBuffer() = default;

    auto operator=(ByteBuffer const& right) -> ByteBuffer&
    {
        if (this != &right)
        {
            _rpos = right._rpos;
            _wpos = right._wpos;
            _storage = right._storage;
        }

        return *this;
    }

    auto operator=(ByteBuffer&& right) noexcept -> ByteBuffer&
    {
        if (this != &right)
        {
            _rpos = right._rpos;
            right._rpos = 0;
            _wpos = right._wpos;
            right._wpos = 0;
            _storage = std::move(right._storage);
        }

        return *this;
    }

    void clear()
    {
        _storage.clear();
        _rpos = _wpos = 0;
    }

    template <typename T>
    void append(T value)
    {
        static_assert(std::is_fundamental<T>::value, "append(compound)");
        EndianConvert(value);
        append((uint8*)&value, sizeof(value));
    }

    template <typename T>
    void put(std::size_t pos, T value)
    {
        static_assert(std::is_fundamental<T>::value, "append(compound)");
        EndianConvert(value);
        put(pos, (uint8*)&value, sizeof(value));
    }

    auto operator<<(bool value) -> ByteBuffer&
    {
        append<uint8>(value ? 1 : 0);
        return *this;
    }

    auto operator<<(uint8 value) -> ByteBuffer&
    {
        append<uint8>(value);
        return *this;
    }

    auto operator<<(uint16 value) -> ByteBuffer&
    {
        append<uint16>(value);
        return *this;
    }

    auto operator<<(uint32 value) -> ByteBuffer&
    {
        append<uint32>(value);
        return *this;
    }

    auto operator<<(uint64 value) -> ByteBuffer&
    {
        append<uint64>(value);
        return *this;
    }

    // signed as in 2e complement
    auto operator<<(int8 value) -> ByteBuffer&
    {
        append<int8>(value);
        return *this;
    }

    auto operator<<(int16 value) -> ByteBuffer&
    {
        append<int16>(value);
        return *this;
    }

    auto operator<<(int32 value) -> ByteBuffer&
    {
        append<int32>(value);
        return *this;
    }

    auto operator<<(int64 value) -> ByteBuffer&
    {
        append<int64>(value);
        return *this;
    }

    // floating points
    auto operator<<(float value) -> ByteBuffer&
    {
        append<float>(value);
        return *this;
    }

    auto operator<<(double value) -> ByteBuffer&
    {
        append<double>(value);
        return *this;
    }

    auto operator<<(std::string_view value) -> ByteBuffer&
    {
        if (size_t len = value.length())
        {
            append(reinterpret_cast<uint8 const*>(value.data()), len);
        }

        append(static_cast<uint8>(0));
        return *this;
    }

    auto operator<<(std::string const& str) -> ByteBuffer&
    {
        return operator<<(std::string_view(str));
    }

    auto operator<<(char const* str) -> ByteBuffer&
    {
        return operator<<(std::string_view(str ? str : ""));
    }

    auto operator>>(bool& value) -> ByteBuffer&
    {
        value = read<char>() > 0;
        return *this;
    }

    auto operator>>(uint8& value) -> ByteBuffer&
    {
        value = read<uint8>();
        return *this;
    }

    auto operator>>(uint16& value) -> ByteBuffer&
    {
        value = read<uint16>();
        return *this;
    }

    auto operator>>(uint32& value) -> ByteBuffer&
    {
        value = read<uint32>();
        return *this;
    }

    auto operator>>(uint64& value) -> ByteBuffer&
    {
        value = read<uint64>();
        return *this;
    }

    //signed as in 2e complement
    auto operator>>(int8& value) -> ByteBuffer&
    {
        value = read<int8>();
        return *this;
    }

    auto operator>>(int16& value) -> ByteBuffer&
    {
        value = read<int16>();
        return *this;
    }

    auto operator>>(int32& value) -> ByteBuffer&
    {
        value = read<int32>();
        return *this;
    }

    auto operator>>(int64& value) -> ByteBuffer&
    {
        value = read<int64>();
        return *this;
    }

    auto operator>>(float& value) -> ByteBuffer&;
    auto operator>>(double& value) -> ByteBuffer&;

    auto operator>>(std::string& value) -> ByteBuffer&
    {
        value = ReadCString(true);
        return *this;
    }

    auto operator[](size_t const pos) -> uint8&
    {
        if (pos >= size())
        {
            throw ByteBufferPositionException(false, pos, 1, size());
        }

        return _storage[pos];
    }

    auto operator[](size_t const pos) const -> uint8 const&
    {
        if (pos >= size())
        {
            throw ByteBufferPositionException(false, pos, 1, size());
        }

        return _storage[pos];
    }

    [[nodiscard]] auto rpos() const -> size_t { return _rpos; }

    auto rpos(size_t rpos_) -> size_t
    {
        _rpos = rpos_;
        return _rpos;
    }

    void rfinish()
    {
        _rpos = wpos();
    }

    [[nodiscard]] auto wpos() const -> size_t { return _wpos; }

    auto wpos(size_t wpos_) -> size_t
    {
        _wpos = wpos_;
        return _wpos;
    }

    template<typename T>
    void read_skip() { read_skip(sizeof(T)); }

    void read_skip(size_t skip)
    {
        if (_rpos + skip > size())
        {
            throw ByteBufferPositionException(false, _rpos, skip, size());
        }

        _rpos += skip;
    }

    template <typename T> auto read() -> T
    {
        T r = read<T>(_rpos);
        _rpos += sizeof(T);
        return r;
    }

    template <typename T> [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] [[nodiscard]] auto read(size_t pos) const -> T
    {
        if (pos + sizeof(T) > size())
        {
            throw ByteBufferPositionException(false, pos, sizeof(T), size());
        }

        T val = *((T const*)&_storage[pos]);
        EndianConvert(val);
        return val;
    }

    void read(uint8* dest, size_t len)
    {
        if (_rpos  + len > size())
        {
            throw ByteBufferPositionException(false, _rpos, len, size());
        }

        std::memcpy(dest, &_storage[_rpos], len);
        _rpos += len;
    }

    template <size_t Size>
    void read(std::array<uint8, Size>& arr)
    {
        read(arr.data(), Size);
    }

    void readPackGUID(uint64& guid)
    {
        if (rpos() + 1 > size())
        {
            throw ByteBufferPositionException(false, _rpos, 1, size());
        }

        guid = 0;

        uint8 guidmark = 0;
        (*this) >> guidmark;

        for (int i = 0; i < 8; ++i)
        {
            if (guidmark & (uint8(1) << i))
            {
                if (rpos() + 1 > size())
                {
                    throw ByteBufferPositionException(false, _rpos, 1, size());
                }

                uint8 bit;
                (*this) >> bit;
                guid |= (uint64(bit) << (i * 8));
            }
        }
    }

    auto ReadCString(bool requireValidUtf8 = true) -> std::string;
    auto ReadPackedTime() -> uint32;

    auto ReadPackedTime(uint32& time) -> ByteBuffer&
    {
        time = ReadPackedTime();
        return *this;
    }

    auto contents() -> uint8*
    {
        if (_storage.empty())
        {
            throw ByteBufferException();
        }

        return _storage.data();
    }

    [[nodiscard]] auto contents() const -> uint8 const*
    {
        if (_storage.empty())
        {
            throw ByteBufferException();
        }

        return _storage.data();
    }

    [[nodiscard]] auto size() const -> size_t { return _storage.size(); }
    [[nodiscard]] auto empty() const -> bool { return _storage.empty(); }

    void resize(size_t newsize)
    {
        _storage.resize(newsize, 0);
        _rpos = 0;
        _wpos = size();
    }

    void reserve(size_t ressize)
    {
        if (ressize > size())
        {
            _storage.reserve(ressize);
        }
    }

    void shrink_to_fit()
    {
        _storage.shrink_to_fit();
    }

    void append(const char *src, size_t cnt)
    {
        return append((const uint8 *)src, cnt);
    }

    template<class T> void append(const T* src, size_t cnt)
    {
        return append((const uint8*)src, cnt * sizeof(T));
    }

    void append(uint8 const* src, size_t cnt);

    void append(ByteBuffer const& buffer)
    {
        if (buffer.wpos())
        {
            append(buffer.contents(), buffer.wpos());
        }
    }

    template <size_t Size>
    void append(std::array<uint8, Size> const& arr)
    {
        append(arr.data(), Size);
    }

    // can be used in SMSG_MONSTER_MOVE opcode
    void appendPackXYZ(float x, float y, float z)
    {
        uint32 packed = 0;
        packed |= ((int)(x / 0.25f) & 0x7FF);
        packed |= ((int)(y / 0.25f) & 0x7FF) << 11;
        packed |= ((int)(z / 0.25f) & 0x3FF) << 22;
        *this << packed;
    }

    void appendPackGUID(uint64 guid)
    {
        uint8 packGUID[8 + 1];
        packGUID[0] = 0;
        size_t size = 1;

        for (uint8 i = 0; guid != 0;++i)
        {
            if (guid & 0xFF)
            {
                packGUID[0] |= uint8(1 << i);
                packGUID[size] =  uint8(guid & 0xFF);
                ++size;
            }

            guid >>= 8;
        }

        append(packGUID, size);
    }

    void AppendPackedTime(time_t time);
    void put(size_t pos, const uint8 *src, size_t cnt);
    void print_storage() const;
    void textlike() const;
    void hexlike() const;

protected:
    size_t _rpos{0}, _wpos{0};
    std::vector<uint8> _storage;
};

/// @todo Make a ByteBuffer.cpp and move all this inlining to it.
template<>
inline auto ByteBuffer::read<std::string>() -> std::string
{
    std::string tmp;
    *this >> tmp;
    return tmp;
}

template<>
inline void ByteBuffer::read_skip<char*>()
{
    std::string temp;
    *this >> temp;
}

template<>
inline void ByteBuffer::read_skip<char const*>()
{
    read_skip<char*>();
}

template<>
inline void ByteBuffer::read_skip<std::string>()
{
    read_skip<char*>();
}

#endif
