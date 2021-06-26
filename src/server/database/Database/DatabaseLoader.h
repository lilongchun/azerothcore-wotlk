/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef DatabaseLoader_h__
#define DatabaseLoader_h__

#include "Define.h"
#include <functional>
#include <queue>
#include <stack>
#include <string>

template <class T>
class DatabaseWorkerPool;

// A helper class to initiate all database worker pools,
// handles updating, delays preparing of statements and cleans up on failure.
class AC_DATABASE_API DatabaseLoader
{
public:
    DatabaseLoader(std::string const& logger);

    // Register a database to the loader (lazy implemented)
    template <class T>
    DatabaseLoader& AddDatabase(DatabaseWorkerPool<T>& pool, std::string const& name);

    // Load all databases
    bool Load();

    enum DatabaseTypeFlags
    {
        DATABASE_NONE       = 0,

        DATABASE_LOGIN      = 1,
        DATABASE_CHARACTER  = 2,
        DATABASE_WORLD      = 4,

        DATABASE_MASK_ALL   = DATABASE_LOGIN | DATABASE_CHARACTER | DATABASE_WORLD
    };

private:
    bool OpenDatabases();
    bool PrepareStatements();

    using Predicate = std::function<bool()>;
    using Closer = std::function<void()>;

    // Invokes all functions in the given queue and closes the databases on errors.
    // Returns false when there was an error.
    bool Process(std::queue<Predicate>& queue);

    std::string const _logger;

    std::queue<Predicate> _open, _prepare;
    std::stack<Closer> _close;
};

#endif // DatabaseLoader_h__
