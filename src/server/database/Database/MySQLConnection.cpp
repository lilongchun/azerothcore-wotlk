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

#include "MySQLConnection.h"
#include "DatabaseWorker.h"
#include "Log.h"
#include "MySQLHacks.h"
#include "MySQLPreparedStatement.h"
#include "MySQLWorkaround.h"
#include "PreparedStatement.h"
#include "QueryResult.h"
#include "StringConvert.h"
#include "Timer.h"
#include "Tokenize.h"
#include "Transaction.h"
#include <errmsg.h>
#include <mysql.h>
#include <mysqld_error.h>

MySQLConnectionInfo::MySQLConnectionInfo(std::string_view infoString)
{
    std::vector<std::string_view> tokens = Acore::Tokenize(infoString, ';', true);

    if (tokens.size() != 5 && tokens.size() != 6)
        return;

    host.assign(tokens.at(0));
    port_or_socket.assign(tokens.at(1));
    user.assign(tokens.at(2));
    password.assign(tokens.at(3));
    database.assign(tokens.at(4));

    if (tokens.size() == 6)
        ssl.assign(tokens.at(5));
}

MySQLConnection::MySQLConnection(MySQLConnectionInfo& connInfo) :
    m_reconnecting(false),
    m_prepareError(false),
    m_Mysql(nullptr),
    m_queue(nullptr),
    m_connectionInfo(connInfo),
    m_connectionFlags(CONNECTION_SYNCH) { }

MySQLConnection::MySQLConnection(ProducerConsumerQueue<SQLOperation*>* queue, MySQLConnectionInfo& connInfo) :
    m_reconnecting(false),
    m_prepareError(false),
    m_Mysql(nullptr),
    m_queue(queue),
    m_connectionInfo(connInfo),
    m_connectionFlags(CONNECTION_ASYNC)
{
    m_worker = std::make_unique<DatabaseWorker>(m_queue, this);
}

MySQLConnection::~MySQLConnection()
{
    Close();
}

void MySQLConnection::Close()
{
    // Stop the worker thread before the statements are cleared
    m_worker.reset();
    m_stmts.clear();

    if (m_Mysql)
    {
        mysql_close(m_Mysql);
        m_Mysql = nullptr;
    }
}

uint32 MySQLConnection::Open()
{
    MYSQL* mysqlInit = mysql_init(nullptr);
    if (!mysqlInit)
    {
        LOG_ERROR("sql.driver", "Could not initialize Mysql connection to database `{}`", m_connectionInfo.database);
        return CR_UNKNOWN_ERROR;
    }

    uint32 port;
    char const* unix_socket;

    mysql_options(mysqlInit, MYSQL_SET_CHARSET_NAME, "utf8");

#ifdef _WIN32
    if (m_connectionInfo.host == ".")                                           // named pipe use option (Windows)
    {
        unsigned int opt = MYSQL_PROTOCOL_PIPE;
        mysql_options(mysqlInit, MYSQL_OPT_PROTOCOL, (char const*)&opt);
        port = 0;
        unix_socket = 0;
    }
    else                                                    // generic case
    {
        port = *Acore::StringTo<uint32>(m_connectionInfo.port_or_socket);
        unix_socket = 0;
    }
#else
    if (m_connectionInfo.host == ".")                                           // socket use option (Unix/Linux)
    {
        unsigned int opt = MYSQL_PROTOCOL_SOCKET;
        mysql_options(mysqlInit, MYSQL_OPT_PROTOCOL, (char const*)&opt);
        m_connectionInfo.host = "localhost";
        port = 0;
        unix_socket = m_connectionInfo.port_or_socket.c_str();
    }
    else                                                    // generic case
    {
        port = *Acore::StringTo<uint32>(m_connectionInfo.port_or_socket);
        unix_socket = nullptr;
    }
#endif

    if (m_connectionInfo.ssl != "")
    {
#if !defined(MARIADB_VERSION_ID) && MYSQL_VERSION_ID >= 80000
        mysql_ssl_mode opt_use_ssl = SSL_MODE_DISABLED;
        if (m_connectionInfo.ssl == "ssl")
        {
            opt_use_ssl = SSL_MODE_REQUIRED;
        }

        mysql_options(mysqlInit, MYSQL_OPT_SSL_MODE, (char const*)&opt_use_ssl);
#else
        MySQLBool opt_use_ssl = MySQLBool(0);
        if (m_connectionInfo.ssl == "ssl")
        {
            opt_use_ssl = MySQLBool(1);
        }

        mysql_options(mysqlInit, MYSQL_OPT_SSL_ENFORCE, (char const*)&opt_use_ssl);
#endif
    }

    m_Mysql = reinterpret_cast<MySQLHandle*>(mysql_real_connect(mysqlInit, m_connectionInfo.host.c_str(), m_connectionInfo.user.c_str(),
        m_connectionInfo.password.c_str(), m_connectionInfo.database.c_str(), port, unix_socket, 0));

    if (m_Mysql)
    {
        if (!m_reconnecting)
        {
            LOG_INFO("sql.sql", "MySQL client library: {}", mysql_get_client_info());
            LOG_INFO("sql.sql", "MySQL server ver: {} ", mysql_get_server_info(m_Mysql));
        }

        LOG_INFO("sql.sql", "Connected to MySQL database at {}", m_connectionInfo.host);
        mysql_autocommit(m_Mysql, 1);

        // set connection properties to UTF8 to properly handle locales for different
        // server configs - core sends data in UTF8, so MySQL must expect UTF8 too
        mysql_set_character_set(m_Mysql, "utf8mb4");
        return 0;
    }
    else
    {
        LOG_ERROR("sql.driver", "Could not connect to MySQL database at {}: {}", m_connectionInfo.host, mysql_error(mysqlInit));
        uint32 errorCode = mysql_errno(mysqlInit);
        mysql_close(mysqlInit);
        return errorCode;
    }
}

bool MySQLConnection::PrepareStatements()
{
    DoPrepareStatements();
    return !m_prepareError;
}

bool MySQLConnection::Execute(std::string_view sql)
{
    if (!m_Mysql)
        return false;

    {
        uint32 _s = getMSTime();

        if (mysql_query(m_Mysql, std::string(sql).c_str()))
        {
            uint32 lErrno = mysql_errno(m_Mysql);

            LOG_INFO("sql.sql", "SQL: {}", sql);
            LOG_ERROR("sql.sql", "[{}] {}", lErrno, mysql_error(m_Mysql));

            if (_HandleMySQLErrno(lErrno))  // If it returns true, an error was handled successfully (i.e. reconnection)
                return Execute(sql);       // Try again

            return false;
        }
        else
            LOG_DEBUG("sql.sql", "[{} ms] SQL: {}", getMSTimeDiff(_s, getMSTime()), sql);
    }

    return true;
}

bool MySQLConnection::Execute(PreparedStatementBase* stmt)
{
    if (!m_Mysql)
        return false;

    uint32 index = stmt->GetIndex();

    MySQLPreparedStatement* m_mStmt = GetPreparedStatement(index);
    ASSERT(m_mStmt); // Can only be null if preparation failed, server side error or bad query

    m_mStmt->BindParameters(stmt);

    MYSQL_STMT* msql_STMT = m_mStmt->GetSTMT();
    MYSQL_BIND* msql_BIND = m_mStmt->GetBind();

    uint32 _s = getMSTime();

#ifdef __APPLE__
    if mysql_stmt_bind_named_param(msql_STMT, msql_BIND))
#else
    if (mysql_stmt_bind_param(msql_STMT, msql_BIND))
#endif
    {
        uint32 lErrno = mysql_errno(m_Mysql);
        LOG_ERROR("sql.sql", "SQL(p): {}\n [ERROR]: [{}] {}", m_mStmt->getQueryString(), lErrno, mysql_stmt_error(msql_STMT));

        if (_HandleMySQLErrno(lErrno))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return Execute(stmt);       // Try again

        m_mStmt->ClearParameters();
        return false;
    }

    if (mysql_stmt_execute(msql_STMT))
    {
        uint32 lErrno = mysql_errno(m_Mysql);
        LOG_ERROR("sql.sql", "SQL(p): {}\n [ERROR]: [{}] {}", m_mStmt->getQueryString(), lErrno, mysql_stmt_error(msql_STMT));

        if (_HandleMySQLErrno(lErrno))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return Execute(stmt);       // Try again

        m_mStmt->ClearParameters();
        return false;
    }

    LOG_DEBUG("sql.sql", "[{} ms] SQL(p): {}", getMSTimeDiff(_s, getMSTime()), m_mStmt->getQueryString());

    m_mStmt->ClearParameters();
    return true;
}

bool MySQLConnection::_Query(PreparedStatementBase* stmt, MySQLPreparedStatement** mysqlStmt, MySQLResult** pResult, uint64* pRowCount, uint32* pFieldCount)
{
    if (!m_Mysql)
        return false;

    uint32 index = stmt->GetIndex();

    MySQLPreparedStatement* m_mStmt = GetPreparedStatement(index);
    ASSERT(m_mStmt);            // Can only be null if preparation failed, server side error or bad query

    m_mStmt->BindParameters(stmt);
    *mysqlStmt = m_mStmt;

    MYSQL_STMT* msql_STMT = m_mStmt->GetSTMT();
    MYSQL_BIND* msql_BIND = m_mStmt->GetBind();

    uint32 _s = getMSTime();

    if (mysql_stmt_bind_param(msql_STMT, msql_BIND))
    {
        uint32 lErrno = mysql_errno(m_Mysql);
        LOG_ERROR("sql.sql", "SQL(p): {}\n [ERROR]: [{}] {}", m_mStmt->getQueryString(), lErrno, mysql_stmt_error(msql_STMT));

        if (_HandleMySQLErrno(lErrno))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return _Query(stmt, mysqlStmt, pResult, pRowCount, pFieldCount);       // Try again

        m_mStmt->ClearParameters();
        return false;
    }

    if (mysql_stmt_execute(msql_STMT))
    {
        uint32 lErrno = mysql_errno(m_Mysql);
        LOG_ERROR("sql.sql", "SQL(p): {}\n [ERROR]: [{}] {}", m_mStmt->getQueryString(), lErrno, mysql_stmt_error(msql_STMT));

        if (_HandleMySQLErrno(lErrno))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return _Query(stmt, mysqlStmt, pResult, pRowCount, pFieldCount);      // Try again

        m_mStmt->ClearParameters();
        return false;
    }

    LOG_DEBUG("sql.sql", "[{} ms] SQL(p): {}", getMSTimeDiff(_s, getMSTime()), m_mStmt->getQueryString());

    m_mStmt->ClearParameters();

    *pResult = reinterpret_cast<MySQLResult*>(mysql_stmt_result_metadata(msql_STMT));
    *pRowCount = mysql_stmt_affected_rows(msql_STMT);
    *pFieldCount = mysql_stmt_field_count(msql_STMT);

    return true;
}

ResultSet* MySQLConnection::Query(std::string_view sql)
{
    if (sql.empty())
        return nullptr;

    MySQLResult* result = nullptr;
    MySQLField* fields = nullptr;
    uint64 rowCount = 0;
    uint32 fieldCount = 0;

    if (!_Query(sql, &result, &fields, &rowCount, &fieldCount))
        return nullptr;

    return new ResultSet(result, fields, rowCount, fieldCount);
}

bool MySQLConnection::_Query(std::string_view sql, MySQLResult** pResult, MySQLField** pFields, uint64* pRowCount, uint32* pFieldCount)
{
    if (!m_Mysql)
        return false;

    {
        uint32 _s = getMSTime();

        if (mysql_query(m_Mysql, std::string(sql).c_str()))
        {
            uint32 lErrno = mysql_errno(m_Mysql);
            LOG_INFO("sql.sql", "SQL: {}", sql);
            LOG_ERROR("sql.sql", "[{}] {}", lErrno, mysql_error(m_Mysql));

            if (_HandleMySQLErrno(lErrno)) // If it returns true, an error was handled successfully (i.e. reconnection)
                return _Query(sql, pResult, pFields, pRowCount, pFieldCount);    // We try again

            return false;
        }
        else
            LOG_DEBUG("sql.sql", "[{} ms] SQL: {}", getMSTimeDiff(_s, getMSTime()), sql);

        *pResult = reinterpret_cast<MySQLResult*>(mysql_store_result(m_Mysql));
        *pRowCount = mysql_affected_rows(m_Mysql);
        *pFieldCount = mysql_field_count(m_Mysql);
    }

    if (!*pResult)
        return false;

    if (!*pRowCount)
    {
        mysql_free_result(*pResult);
        return false;
    }

    *pFields = reinterpret_cast<MySQLField*>(mysql_fetch_fields(*pResult));

    return true;
}

void MySQLConnection::BeginTransaction()
{
    Execute("START TRANSACTION");
}

void MySQLConnection::RollbackTransaction()
{
    Execute("ROLLBACK");
}

void MySQLConnection::CommitTransaction()
{
    Execute("COMMIT");
}

int MySQLConnection::ExecuteTransaction(std::shared_ptr<TransactionBase> transaction)
{
    std::vector<SQLElementData> const& queries = transaction->m_queries;
    if (queries.empty())
        return -1;

    BeginTransaction();

    for (auto const& data : queries)
    {
        switch (data.type)
        {
            case SQL_ELEMENT_PREPARED:
            {
                PreparedStatementBase* stmt = nullptr;

                try
                {
                    stmt = std::get<PreparedStatementBase*>(data.element);
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("sql.sql", "> PreparedStatementBase not found in SQLElementData. {}", ex.what());
                    ABORT();
                }

                ASSERT(stmt);

                if (!Execute(stmt))
                {
                    LOG_WARN("sql.sql", "Transaction aborted. {} queries not executed.", queries.size());
                    int errorCode = GetLastError();
                    RollbackTransaction();
                    return errorCode;
                }
            }
            break;
            case SQL_ELEMENT_RAW:
            {
                std::string sql{};

                try
                {
                    sql = std::get<std::string>(data.element);
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("sql.sql", "> std::string not found in SQLElementData. {}", ex.what());
                    ABORT();
                }

                ASSERT(!sql.empty());

                if (!Execute(sql))
                {
                    LOG_WARN("sql.sql", "Transaction aborted. {} queries not executed.", queries.size());
                    uint32 errorCode = GetLastError();
                    RollbackTransaction();
                    return errorCode;
                }
            }
            break;
        }
    }

    // we might encounter errors during certain queries, and depending on the kind of error
    // we might want to restart the transaction. So to prevent data loss, we only clean up when it's all done.
    // This is done in calling functions DatabaseWorkerPool<T>::DirectCommitTransaction and TransactionTask::Execute,
    // and not while iterating over every element.

    CommitTransaction();
    return 0;
}

size_t MySQLConnection::EscapeString(char* to, const char* from, size_t length)
{
    return mysql_real_escape_string(m_Mysql, to, from, length);
}

void MySQLConnection::Ping()
{
    mysql_ping(m_Mysql);
}

uint32 MySQLConnection::GetLastError()
{
    return mysql_errno(m_Mysql);
}

bool MySQLConnection::LockIfReady()
{
    return m_Mutex.try_lock();
}

void MySQLConnection::Unlock()
{
    m_Mutex.unlock();
}

uint32 MySQLConnection::GetServerVersion() const
{
    return mysql_get_server_version(m_Mysql);
}

std::string MySQLConnection::GetServerInfo() const
{
    return mysql_get_server_info(m_Mysql);
}

MySQLPreparedStatement* MySQLConnection::GetPreparedStatement(uint32 index)
{
    ASSERT(index < m_stmts.size(), "Tried to access invalid prepared statement index {} (max index {}) on database `{}`, connection type: {}",
        index, m_stmts.size(), m_connectionInfo.database, (m_connectionFlags & CONNECTION_ASYNC) ? "asynchronous" : "synchronous");

    MySQLPreparedStatement* ret = m_stmts[index].get();

    if (!ret)
        LOG_ERROR("sql.sql", "Could not fetch prepared statement {} on database `{}`, connection type: {}.",
            index, m_connectionInfo.database, (m_connectionFlags & CONNECTION_ASYNC) ? "asynchronous" : "synchronous");

    return ret;
}

void MySQLConnection::PrepareStatement(uint32 index, std::string_view sql, ConnectionFlags flags)
{
    // Check if specified query should be prepared on this connection
    // i.e. don't prepare async statements on synchronous connections
    // to save memory that will not be used.
    if (!(m_connectionFlags & flags))
    {
        m_stmts[index].reset();
        return;
    }

    MYSQL_STMT* stmt = mysql_stmt_init(m_Mysql);
    if (!stmt)
    {
        LOG_ERROR("sql.sql", "In mysql_stmt_init() id: {}, sql: \"{}\"", index, sql);
        LOG_ERROR("sql.sql", "{}", mysql_error(m_Mysql));
        m_prepareError = true;
    }
    else
    {
        if (mysql_stmt_prepare(stmt, std::string(sql).c_str(), static_cast<unsigned long>(sql.size())))
        {
            LOG_ERROR("sql.sql", "In mysql_stmt_prepare() id: {}, sql: \"{}\"", index, sql);
            LOG_ERROR("sql.sql", "{}", mysql_stmt_error(stmt));
            mysql_stmt_close(stmt);
            m_prepareError = true;
        }
        else
            m_stmts[index] = std::make_unique<MySQLPreparedStatement>(reinterpret_cast<MySQLStmt*>(stmt), sql);
    }
}

PreparedResultSet* MySQLConnection::Query(PreparedStatementBase* stmt)
{
    MySQLPreparedStatement* mysqlStmt = nullptr;
    MySQLResult* result = nullptr;
    uint64 rowCount = 0;
    uint32 fieldCount = 0;

    if (!_Query(stmt, &mysqlStmt, &result, &rowCount, &fieldCount))
        return nullptr;

    if (mysql_more_results(m_Mysql))
    {
        mysql_next_result(m_Mysql);
    }

    return new PreparedResultSet(mysqlStmt->GetSTMT(), result, rowCount, fieldCount);
}

bool MySQLConnection::_HandleMySQLErrno(uint32 errNo, uint8 attempts /*= 5*/)
{
    switch (errNo)
    {
        case CR_SERVER_GONE_ERROR:
        case CR_SERVER_LOST:
        case CR_SERVER_LOST_EXTENDED:
        {
            if (m_Mysql)
            {
                LOG_ERROR("sql.sql", "Lost the connection to the MySQL server!");

                mysql_close(m_Mysql);
                m_Mysql = nullptr;
            }
            [[fallthrough]];
        }
        case CR_CONN_HOST_ERROR:
        {
            LOG_INFO("sql.sql", "Attempting to reconnect to the MySQL server...");

            m_reconnecting = true;

            uint32 const lErrno = Open();
            if (!lErrno)
            {
                // Don't remove 'this' pointer unless you want to skip loading all prepared statements...
                if (!this->PrepareStatements())
                {
                    LOG_FATAL("sql.sql", "Could not re-prepare statements!");
                    std::this_thread::sleep_for(10s);
                    ABORT();
                }

                LOG_INFO("sql.sql", "Successfully reconnected to {} @{}:{} ({}).",
                    m_connectionInfo.database, m_connectionInfo.host, m_connectionInfo.port_or_socket,
                        (m_connectionFlags & CONNECTION_ASYNC) ? "asynchronous" : "synchronous");

                m_reconnecting = false;
                return true;
            }

            if ((--attempts) == 0)
            {
                // Shut down the server when the mysql server isn't
                // reachable for some time
                LOG_FATAL("sql.sql", "Failed to reconnect to the MySQL server, terminating the server to prevent data corruption!");

                // We could also initiate a shutdown through using std::raise(SIGTERM)
                std::this_thread::sleep_for(10s);
                ABORT();
            }
            else
            {
                // It's possible this attempted reconnect throws 2006 at us.
                // To prevent crazy recursive calls, sleep here.
                std::this_thread::sleep_for(3s); // Sleep 3 seconds
                return _HandleMySQLErrno(lErrno, attempts); // Call self (recursive)
            }
        }

        case ER_LOCK_DEADLOCK:
            return false; // Implemented in TransactionTask::Execute and DatabaseWorkerPool<T>::DirectCommitTransaction

        // Query related errors - skip query
        case ER_WRONG_VALUE_COUNT:
        case ER_DUP_ENTRY:
            return false;

        // Outdated table or database structure - terminate core
        case ER_BAD_FIELD_ERROR:
        case ER_NO_SUCH_TABLE:
            LOG_ERROR("sql.sql", "Your database structure is not up to date. Please make sure you've executed all queries in the sql/updates folders.");
            std::this_thread::sleep_for(10s);
            ABORT();
            return false;
        case ER_PARSE_ERROR:
            LOG_ERROR("sql.sql", "Error while parsing SQL. Core fix required.");
            std::this_thread::sleep_for(10s);
            ABORT();
            return false;
        default:
            LOG_ERROR("sql.sql", "Unhandled MySQL errno {}. Unexpected behaviour possible.", errNo);
            return false;
    }
}
