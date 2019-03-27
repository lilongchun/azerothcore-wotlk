/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBCSTORE_H
#define DBCSTORE_H

#include "DBCFileLoader.h"
#include "Logging/Log.h"
#include "Field.h"
#include "DatabaseWorkerPool.h"
#include "Implementation/WorldDatabase.h"
#include "DatabaseEnv.h"
#include <unordered_map>

struct SqlDbc
{
    std::string const* formatString;
    std::string const* indexName;
    std::string sqlTableName;
    int32 indexPos;
    int32 sqlIndexPos;
    SqlDbc(std::string const* _filename, std::string const* _format, std::string const* _idname, char const* fmt)
        : formatString(_format), indexName (_idname), sqlIndexPos(0)
    {
        // Convert dbc file name to sql table name
        sqlTableName = *_filename;
        for (uint32 i = 0; i< sqlTableName.size(); ++i)
        {
            if (isalpha(sqlTableName[i]))
                sqlTableName[i] = char(tolower(sqlTableName[i]));
            else if (sqlTableName[i] == '.')
                sqlTableName[i] = '_';
        }

        // Get sql index position
        DBCFileLoader::GetFormatRecordSize(fmt, &indexPos);
        if (indexPos >= 0)
        {
            uint32 uindexPos = uint32(indexPos);
            for (uint32 x = 0; x < formatString->size(); ++x)
            {
                // Count only fields present in sql
                if ((*formatString)[x] == FT_SQL_PRESENT)
                {
                    if (x == uindexPos)
                        break;
                    ++sqlIndexPos;
                }
            }
        }
    }
};

template<class T>
class DBCStorage
{
    typedef std::list<char*> StringPoolList;
    public:
        explicit DBCStorage(char const* f)
#ifndef ELUNA
            : fmt(f), nCount(0), fieldCount(0), dataTable(NULL)
#else
            : fmt(f), nCount(0), fieldCount(0), dataTable(NULL), maxdatacount(0), mindatacount(std::numeric_limits<uint32>::max())
#endif
        {
            indexTable.asT = NULL;
        }

        ~DBCStorage() { Clear(); }

        T const* LookupEntry(uint32 id) const
        {
#ifdef ELUNA
            if (id <= maxdatacount && id >= mindatacount)
            {
                typename std::unordered_map<uint32, T const*>::const_iterator it = data.find(id);
                if (it != data.end())
                    return it->second;
            }
#endif
            return (id >= nCount) ? NULL : indexTable.asT[id];
        }

#ifdef ELUNA
        void SetEntry(uint32 id, T* t)
        {
            delete data[id];
            data[id] = t;
            maxdatacount = std::max(maxdatacount, id);
            mindatacount = std::min(mindatacount, id);
        }
#endif

#ifndef ELUNA
        uint32  GetNumRows() const { return nCount; }
#else
        uint32  GetNumRows() const { return std::max(maxdatacount + 1, nCount); }
#endif
        char const* GetFormat() const { return fmt; }
        uint32 GetFieldCount() const { return fieldCount; }

        bool Load(char const* fn, SqlDbc* sql)
        {
            DBCFileLoader dbc;
            // Check if load was sucessful, only then continue
            if (!dbc.Load(fn, fmt))
                return false;

            uint32 sqlRecordCount = 0;
            uint32 sqlHighestIndex = 0;
            Field* fields = NULL;
            QueryResult result = QueryResult(NULL);
            // Load data from sql
            if (sql)
            {
                std::string query = "SELECT * FROM " + sql->sqlTableName;
                if (sql->indexPos >= 0)
                    query +=" ORDER BY " + *sql->indexName + " DESC";
                query += ';';


                result = WorldDatabase.Query(query.c_str());
                if (result)
                {
                    sqlRecordCount = uint32(result->GetRowCount());
                    if (sql->indexPos >= 0)
                    {
                        fields = result->Fetch();
                        sqlHighestIndex = fields[sql->sqlIndexPos].GetUInt32();
                    }

                    // Check if sql index pos is valid
                    if (int32(result->GetFieldCount() - 1) < sql->sqlIndexPos)
                    {
                        sLog.outError("Invalid index pos for dbc:'%s'", sql->sqlTableName.c_str());
                        return false;
                    }
                }
            }

            char* sqlDataTable = NULL;
            fieldCount = dbc.GetCols();

            dataTable = reinterpret_cast<T*>(dbc.AutoProduceData(fmt, nCount, indexTable.asChar,
                sqlRecordCount, sqlHighestIndex, sqlDataTable));

            stringPoolList.push_back(dbc.AutoProduceStrings(fmt, reinterpret_cast<char*>(dataTable)));

            // Insert sql data into arrays
            if (result)
            {
                if (indexTable.asT)
                {
                    uint32 offset = 0;
                    uint32 rowIndex = dbc.GetNumRows();
                    do
                    {
                        if (!fields)
                            fields = result->Fetch();

                        if (sql->indexPos >= 0)
                        {
                            uint32 id = fields[sql->sqlIndexPos].GetUInt32();
                            if (indexTable.asT[id])
                            {
                                sLog.outError("Index %d already exists in dbc:'%s'", id, sql->sqlTableName.c_str());
                                return false;
                            }

                            indexTable.asT[id] = reinterpret_cast<T*>(&sqlDataTable[offset]);
                        }
                        else
                            indexTable.asT[rowIndex]= reinterpret_cast<T*>(&sqlDataTable[offset]);

                        uint32 columnNumber = 0;
                        uint32 sqlColumnNumber = 0;

                        for (; columnNumber < sql->formatString->size(); ++columnNumber)
                        {
                            if ((*sql->formatString)[columnNumber] == FT_SQL_ABSENT)
                            {
                                switch (fmt[columnNumber])
                                {
                                    case FT_FLOAT:
                                        *reinterpret_cast<float*>(&sqlDataTable[offset]) = 0.0f;
                                        offset += 4;
                                        break;
                                    case FT_IND:
                                    case FT_INT:
                                        *reinterpret_cast<uint32*>(&sqlDataTable[offset]) = uint32(0);
                                        offset += 4;
                                        break;
                                    case FT_BYTE:
                                        *reinterpret_cast<uint8*>(&sqlDataTable[offset]) = uint8(0);
                                        offset += 1;
                                        break;
                                    case FT_STRING:
                                        // Beginning of the pool - empty string
                                        *reinterpret_cast<char**>(&sqlDataTable[offset]) = stringPoolList.back();
                                        offset += sizeof(char*);
                                        break;
                                }
                            }
                            else if ((*sql->formatString)[columnNumber] == FT_SQL_PRESENT)
                            {
                                bool validSqlColumn = true;
                                switch (fmt[columnNumber])
                                {
                                    case FT_FLOAT:
                                        *reinterpret_cast<float*>(&sqlDataTable[offset]) = fields[sqlColumnNumber].GetFloat();
                                        offset += 4;
                                        break;
                                    case FT_IND:
                                    case FT_INT:
                                        *reinterpret_cast<uint32*>(&sqlDataTable[offset]) = fields[sqlColumnNumber].GetUInt32();
                                        offset += 4;
                                        break;
                                    case FT_BYTE:
                                        *reinterpret_cast<uint8*>(&sqlDataTable[offset]) = fields[sqlColumnNumber].GetUInt8();
                                        offset += 1;
                                        break;
                                    case FT_STRING:
                                        sLog.outError("Unsupported data type in table '%s' at char %d", sql->sqlTableName.c_str(), columnNumber);
                                        return false;
                                    case FT_SORT:
                                        break;
                                    default:
                                        validSqlColumn = false;
                                        break;
                                }
                                if (validSqlColumn && (columnNumber != (sql->formatString->size()-1)))
                                    sqlColumnNumber++;
                            }
                            else
                            {
                                sLog.outError("Incorrect sql format string '%s' at char %d", sql->sqlTableName.c_str(), columnNumber);
                                return false;
                            }
                        }

                        if (sqlColumnNumber != (result->GetFieldCount() - 1))
                        {
                            sLog.outError("SQL and DBC format strings are not matching for table: '%s'", sql->sqlTableName.c_str());
                            return false;
                        }

                        fields = NULL;
                        ++rowIndex;
                    } while (result->NextRow());
                }
            }

            // error in dbc file at loading if NULL
            return indexTable.asT != NULL;
        }

        bool LoadStringsFrom(char const* fn)
        {
            // DBC must be already loaded using Load
            if (!indexTable.asT)
                return false;

            DBCFileLoader dbc;
            // Check if load was successful, only then continue
            if (!dbc.Load(fn, fmt))
                return false;

            stringPoolList.push_back(dbc.AutoProduceStrings(fmt, reinterpret_cast<char*>(dataTable)));

            return true;
        }

        void Clear()
        {
#ifdef ELUNA
            data.clear();
            maxdatacount = 0;
            mindatacount = std::numeric_limits<uint32>::max();
#endif
            if (!indexTable.asT)
                return;

            delete[] reinterpret_cast<char*>(indexTable.asT);
            indexTable.asT = NULL;
            delete[] reinterpret_cast<char*>(dataTable);
            dataTable = NULL;

            while (!stringPoolList.empty())
            {
                delete[] stringPoolList.front();
                stringPoolList.pop_front();
            }

            nCount = 0;
        }

    private:
        char const* fmt;
        uint32 nCount;
        uint32 fieldCount;

        union
        {
            T** asT;
            char** asChar;
        }
        indexTable;

        T* dataTable;
        StringPoolList stringPoolList;

#ifdef ELUNA
        uint32 maxdatacount;
        uint32 mindatacount;
        std::unordered_map<uint32, T const*> data;
#endif
};

#endif
