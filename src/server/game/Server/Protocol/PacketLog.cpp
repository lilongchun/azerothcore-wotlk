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

#include "PacketLog.h"
#include "Config.h"
#include "GameTime.h"
#include "IpAddress.h"
#include "Timer.h"
#include "WorldPacket.h"

#pragma pack(push, 1)

// Packet logging structures in PKT 3.1 format
struct LogHeader
{
    char Signature[3];
    uint16 FormatVersion;
    uint8 SnifferId;
    uint32 Build;
    char Locale[4];
    uint8 SessionKey[40];
    uint32 SniffStartUnixtime;
    uint32 SniffStartTicks;
    uint32 OptionalDataSize;
};

struct PacketHeader
{
    // used to uniquely identify a connection
    struct OptionalData
    {
        uint8 SocketIPBytes[16];
        uint32 SocketPort;
    };

    uint32 Direction;
    uint32 ConnectionId;
    uint32 ArrivalTicks;
    uint32 OptionalDataSize;
    uint32 Length;
    OptionalData OptionalData;
    uint32 Opcode;
};

#pragma pack(pop)

PacketLog::PacketLog() : _file(nullptr)
{
    std::call_once(_initializeFlag, &PacketLog::Initialize, this);
}

PacketLog::~PacketLog()
{
    if (_file)
    {
        fclose(_file);
    }

    _file = nullptr;
}

PacketLog* PacketLog::instance()
{
    static PacketLog instance;
    return &instance;
}

void PacketLog::Initialize()
{
    std::string logsDir = sConfigMgr->GetOption<std::string>("LogsDir", "");

    if (!logsDir.empty() && (logsDir.at(logsDir.length() - 1) != '/') && (logsDir.at(logsDir.length() - 1) != '\\'))
    {
        logsDir.push_back('/');
    }

    std::string logname = sConfigMgr->GetOption<std::string>("PacketLogFile", "");
    if (!logname.empty())
    {
        _file = fopen((logsDir + logname).c_str(), "wb");

        LogHeader header;
        header.Signature[0] = 'P'; header.Signature[1] = 'K'; header.Signature[2] = 'T';
        header.FormatVersion = 0x0301;
        header.SnifferId = 'T';
        header.Build = 12340;
        header.Locale[0] = 'e'; header.Locale[1] = 'n'; header.Locale[2] = 'U'; header.Locale[3] = 'S';
        std::memset(header.SessionKey, 0, sizeof(header.SessionKey));
        header.SniffStartUnixtime = GameTime::GetGameTime().count();
        header.SniffStartTicks = getMSTime();
        header.OptionalDataSize = 0;

        if (CanLogPacket())
        {
            fwrite(&header, sizeof(header), 1, _file);
        }
    }
}

void PacketLog::LogPacket(WorldPacket const& packet, Direction direction, boost::asio::ip::address const& addr, uint16 port)
{
    std::lock_guard<std::mutex> lock(_logPacketLock);

    PacketHeader header;
    header.Direction = direction == CLIENT_TO_SERVER ? 0x47534d43 : 0x47534d53;
    header.ConnectionId = 0;
    header.ArrivalTicks = getMSTime();

    header.OptionalDataSize = sizeof(header.OptionalData);
    memset(header.OptionalData.SocketIPBytes, 0, sizeof(header.OptionalData.SocketIPBytes));

    if (addr.is_v4())
    {
        auto bytes = addr.to_v4().to_bytes();
        memcpy(header.OptionalData.SocketIPBytes, bytes.data(), bytes.size());
    }
    else if (addr.is_v6())
    {
        auto bytes = addr.to_v6().to_bytes();
        memcpy(header.OptionalData.SocketIPBytes, bytes.data(), bytes.size());
    }

    header.OptionalData.SocketPort = port;
    header.Length = packet.size() + sizeof(header.Opcode);
    header.Opcode = packet.GetOpcode();

    fwrite(&header, sizeof(header), 1, _file);

    if (!packet.empty())
    {
        fwrite(packet.contents(), 1, packet.size(), _file);
    }

    fflush(_file);
}
