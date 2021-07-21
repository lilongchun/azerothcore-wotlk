/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _MYSQLCONNECTION_H
#define _MYSQLCONNECTION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

template <typename T>
class ProducerConsumerQueue;

class DatabaseWorker;
class MySQLPreparedStatement;
class SQLOperation;

enum ConnectionFlags
{
    CONNECTION_ASYNC = 0x1,
    CONNECTION_SYNCH = 0x2,
    CONNECTION_BOTH = CONNECTION_ASYNC | CONNECTION_SYNCH
};

struct AC_DATABASE_API MySQLConnectionInfo
{
    explicit MySQLConnectionInfo(std::string const& infoString);

    std::string user;
    std::string password;
    std::string database;
    std::string host;
    std::string port_or_socket;
    std::string ssl;
};

class AC_DATABASE_API MySQLConnection
{
template <class T> friend class DatabaseWorkerPool;
friend class PingOperation;

public:
    MySQLConnection(MySQLConnectionInfo& connInfo);                               //! Constructor for synchronous connections.
    MySQLConnection(ProducerConsumerQueue<SQLOperation*>* queue, MySQLConnectionInfo& connInfo);  //! Constructor for asynchronous connections.
    virtual ~MySQLConnection();

    virtual uint32 Open();
    void Close();

    bool PrepareStatements();

    bool Execute(char const* sql);
    bool Execute(PreparedStatementBase* stmt);
    ResultSet* Query(char const* sql);
    PreparedResultSet* Query(PreparedStatementBase* stmt);
    bool _Query(char const* sql, MySQLResult** pResult, MySQLField** pFields, uint64* pRowCount, uint32* pFieldCount);
    bool _Query(PreparedStatementBase* stmt, MySQLPreparedStatement** mysqlStmt, MySQLResult** pResult, uint64* pRowCount, uint32* pFieldCount);

    void BeginTransaction();
    void RollbackTransaction();
    void CommitTransaction();
    int ExecuteTransaction(std::shared_ptr<TransactionBase> transaction);
    size_t EscapeString(char* to, const char* from, size_t length);
    void Ping();

    uint32 GetLastError();

protected:
    /// Tries to acquire lock. If lock is acquired by another thread
    /// the calling parent will just try another connection
    bool LockIfReady();

    /// Called by parent databasepool. Will let other threads access this connection
    void Unlock();

    uint32 GetServerVersion() const;
    MySQLPreparedStatement* GetPreparedStatement(uint32 index);
    void PrepareStatement(uint32 index, std::string const& sql, ConnectionFlags flags);

    virtual void DoPrepareStatements() = 0;

    typedef std::vector<std::unique_ptr<MySQLPreparedStatement>> PreparedStatementContainer;

    PreparedStatementContainer           m_stmts;         //! PreparedStatements storage
    bool                                 m_reconnecting;  //! Are we reconnecting?
    bool                                 m_prepareError;  //! Was there any error while preparing statements?

private:
    bool _HandleMySQLErrno(uint32 errNo, uint8 attempts = 5);

    ProducerConsumerQueue<SQLOperation*>* m_queue;      //! Queue shared with other asynchronous connections.
    std::unique_ptr<DatabaseWorker> m_worker;           //! Core worker task.
    MySQLHandle*          m_Mysql;                      //! MySQL Handle.
    MySQLConnectionInfo&  m_connectionInfo;             //! Connection info (used for logging)
    ConnectionFlags       m_connectionFlags;            //! Connection flags (for preparing relevant statements)
    std::mutex            m_Mutex;

    MySQLConnection(MySQLConnection const& right) = delete;
    MySQLConnection& operator=(MySQLConnection const& right) = delete;
};

#endif
