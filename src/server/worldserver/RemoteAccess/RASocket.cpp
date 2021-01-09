/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \file
    \ingroup Trinityd
*/

#include "Common.h"
#include "Configuration/Config.h"
#include "Database/DatabaseEnv.h"
#include "AccountMgr.h"
#include "Log.h"
#include "RASocket.h"
#include "Util.h"
#include "Duration.h"
#include "World.h"
#include "SHA1.h"
#include "ServerMotd.h"
#include <thread>

RASocket::RASocket()
{
    _minLevel = uint8(sConfigMgr->GetIntDefault("RA.MinLevel", 3));
    _commandExecuting = false;
}

int RASocket::open(void*)
{
    ACE_INET_Addr remoteAddress;

    if (peer().get_remote_addr(remoteAddress) == -1)
    {
        sLog->outError("RASocket::open: peer().get_remote_addr error is %s", ACE_OS::strerror(errno));
        return -1;
    }

    sLog->outRemote("Incoming connection from %s", remoteAddress.get_host_addr());

    return activate();
}

int RASocket::handle_close(ACE_HANDLE /*handle*/, ACE_Reactor_Mask /*mask*/)
{
    sLog->outRemote("Closing connection");
    peer().close_reader();
    wait();
    // While the above wait() will wait for the ::svc() to finish, it will not wait for the async event
    // RASocket::commandfinished to be completed. Calling destroy() before the latter function ends
    // will lead to using a freed pointer -> crash.
    while (_commandExecuting)
        std::this_thread::sleep_for(1s);

    destroy();
    return 0;
}

int RASocket::send(const std::string& line)
{
#ifdef MSG_NOSIGNAL
    ssize_t n = peer().send(line.c_str(), line.length(), MSG_NOSIGNAL);
#else
    ssize_t n = peer().send(line.c_str(), line.length());
#endif // MSG_NOSIGNAL

    return n == ssize_t(line.length()) ? 0 : -1;
}

int RASocket::recv_line(ACE_Message_Block& buffer)
{
    char byte;
    for (;;)
    {
        ssize_t n = peer().recv(&byte, sizeof(byte));

        if (n < 0)
            return -1;

        if (n == 0)
        {
            // EOF, connection was closed
            errno = ECONNRESET;
            return -1;
        }

        ACE_ASSERT(n == sizeof(byte));

        if (byte == '\n')
            break;
        else if (byte == '\r') /* Ignore CR */
            continue;
        else if (buffer.copy(&byte, sizeof(byte)) == -1)
            return -1;
    }

    const char nullTerm = '\0';
    if (buffer.copy(&nullTerm, sizeof(nullTerm)) == -1)
        return -1;

    return 0;
}

int RASocket::recv_line(std::string& out_line)
{
    char buf[4096];

    ACE_Data_Block db(sizeof (buf),
                      ACE_Message_Block::MB_DATA,
                      buf,
                      0,
                      0,
                      ACE_Message_Block::DONT_DELETE,
                      0);

    ACE_Message_Block message_block(&db,
                                    ACE_Message_Block::DONT_DELETE,
                                    0);

    if (recv_line(message_block) == -1)
    {
        sLog->outRemote("Recv error %s", ACE_OS::strerror(errno));
        return -1;
    }

    out_line = message_block.rd_ptr();

    return 0;
}

int RASocket::process_command(const std::string& command)
{
    if (command.length() == 0)
        return 0;

    sLog->outRemote("Got command: %s", command.c_str());

    // handle quit, exit and logout commands to terminate connection
    if (command == "quit" || command == "exit" || command == "logout")
    {
        (void) send("Bye\r\n");
        return -1;
    }

    _commandExecuting = true;
    CliCommandHolder* cmd = new CliCommandHolder(this, command.c_str(), &RASocket::zprint, &RASocket::commandFinished);
    sWorld->QueueCliCommand(cmd);

    // wait for result
    ACE_Message_Block* mb;
    for (;;)
    {
        if (getq(mb) == -1)
            return -1;

        if (mb->msg_type() == ACE_Message_Block::MB_BREAK)
        {
            mb->release();
            break;
        }

        if (send(std::string(mb->rd_ptr(), mb->length())) == -1)
        {
            mb->release();
            return -1;
        }

        mb->release();
    }

    return 0;
}

int RASocket::check_access_level(const std::string& user)
{
    std::string safeUser = user;

    Utf8ToUpperOnlyLatin(safeUser);

    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ACCESS);
    stmt->setString(0, safeUser);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        sLog->outRemote("User %s does not exist in database", user.c_str());
        return -1;
    }

    Field* fields = result->Fetch();

    if (fields[1].GetUInt8() < _minLevel)
    {
        sLog->outRemote("User %s has no privilege to login", user.c_str());
        return -1;
    }
    else if (fields[2].GetInt32() != -1)
    {
        sLog->outRemote("User %s has to be assigned on all realms (with RealmID = '-1')", user.c_str());
        return -1;
    }

    return 0;
}

int RASocket::check_password(const std::string& user, const std::string& pass)
{
    std::string safe_user = user;
    Utf8ToUpperOnlyLatin(safe_user);

    std::string safe_pass = pass;
    Utf8ToUpperOnlyLatin(safe_pass);

    std::string hash = AccountMgr::CalculateShaPassHash(safe_user, safe_pass);

    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_CHECK_PASSWORD_BY_NAME);

    stmt->setString(0, safe_user);
    stmt->setString(1, hash);

    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        sLog->outRemote("Wrong password for user: %s", user.c_str());
        return -1;
    }

    return 0;
}

int RASocket::authenticate()
{
    if (send(std::string("Username: ")) == -1)
        return -1;

    std::string user;
    if (recv_line(user) == -1)
        return -1;

    if (send(std::string("Password: ")) == -1)
        return -1;

    std::string pass;
    if (recv_line(pass) == -1)
        return -1;

    sLog->outRemote("Login attempt for user: %s", user.c_str());

    if (check_access_level(user) == -1)
        return -1;

    if (check_password(user, pass) == -1)
        return -1;

    sLog->outRemote("User login: %s", user.c_str());

    return 0;
}

int RASocket::subnegotiate()
{
    char buf[1024];

    ACE_Data_Block db(sizeof (buf),
                      ACE_Message_Block::MB_DATA,
                      buf,
                      0,
                      0,
                      ACE_Message_Block::DONT_DELETE,
                      0);

    ACE_Message_Block message_block(&db,
                                    ACE_Message_Block::DONT_DELETE,
                                    0);

    const size_t recv_size = message_block.space();

    // Wait a maximum of 1000ms for negotiation packet - not all telnet clients may send it
    ACE_Time_Value waitTime = ACE_Time_Value(1);
    const ssize_t n = peer().recv(message_block.wr_ptr(),
                                  recv_size, &waitTime);

    if (n <= 0)
        return int(n);

    if (n >= 1024)
    {
        sLog->outRemote("RASocket::subnegotiate: allocated buffer 1024 bytes was too small for negotiation packet, size: %u", uint32(n));
        return -1;
    }

    buf[n] = '\0';

#ifdef _DEBUG
    for (uint8 i = 0; i < n; )
    {
        uint8 iac = buf[i];
        if (iac == 0xFF)   // "Interpret as Command" (IAC)
        {
            uint8 command = buf[++i];
            std::stringstream ss;
            switch (command)
            {
                case 0xFB:        // WILL
                    ss << "WILL ";
                    break;
                case 0xFC:        // WON'T
                    ss << "WON'T ";
                    break;
                case 0xFD:        // DO
                    ss << "DO ";
                    break;
                case 0xFE:        // DON'T
                    ss << "DON'T ";
                    break;
                default:
                    return -1;      // not allowed
            }

            uint8 param = buf[++i];
            ss << uint32(param);
            sLog->outRemote(ss.str().c_str());
        }
        ++i;
    }
#endif

    //! Just send back end of subnegotiation packet
    uint8 const reply[2] = {0xFF, 0xF0};

#ifdef MSG_NOSIGNAL
    return int(peer().send(reply, 2, MSG_NOSIGNAL));
#else
    return int(peer().send(reply, 2));
#endif // MSG_NOSIGNAL
}

int RASocket::svc(void)
{
    //! Subnegotiation may differ per client - do not react on it
    subnegotiate();

    if (send("Authentication required\r\n") == -1)
        return -1;

    if (authenticate() == -1)
    {
        (void) send("Authentication failed\r\n");
        return -1;
    }

    // send motd
    if (send(std::string(Motd::GetMotd()) + "\r\n") == -1)
        return -1;

    for (;;)
    {
        // show prompt
        if (send("AC> ") == -1)
            return -1;

        std::string line;

        if (recv_line(line) == -1)
            return -1;

        if (process_command(line) == -1)
            return -1;
    }

    return 0;
}

void RASocket::zprint(void* callbackArg, const char* szText)
{
    if (!szText || !callbackArg)
        return;

    RASocket* socket = static_cast<RASocket*>(callbackArg);
    size_t sz = strlen(szText);

    ACE_Message_Block* mb = new ACE_Message_Block(sz);
    mb->copy(szText, sz);

    ACE_Time_Value tv = ACE_Time_Value::zero;
    if (socket->putq(mb, &tv) == -1)
    {
        sLog->outRemote("Failed to enqueue message, queue is full or closed. Error is %s", ACE_OS::strerror(errno));
        mb->release();
    }
}

void RASocket::commandFinished(void* callbackArg, bool /*success*/)
{
    if (!callbackArg)
        return;

    RASocket* socket = static_cast<RASocket*>(callbackArg);

    ACE_Message_Block* mb = new ACE_Message_Block();

    mb->msg_type(ACE_Message_Block::MB_BREAK);

    // the message is 0 size control message to tell that command output is finished
    // hence we don't put timeout, because it shouldn't increase queue size and shouldn't block
    if (socket->putq(mb->duplicate()) == -1)
    {
        // getting here is bad, command can't be marked as complete
        //sLog->outDebug(LOG_FILTER_REMOTECOMMAND, "Failed to enqueue command end message. Error is %s", ACE_OS::strerror(errno));
    }

    mb->release();

    socket->_commandExecuting = false;
}
