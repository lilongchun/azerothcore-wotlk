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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::OnDatabasesLoading()
{
    auto ret = IsValidBoolScript<DatabaseScript>([&](DatabaseScript* script)
    {
        return !script->OnDatabasesLoading();
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnAfterDatabasesLoaded(uint32 updateFlags)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnAfterDatabasesLoaded(updateFlags);
    });
}

void ScriptMgr::OnDatabasesKeepAlive()
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnDatabasesKeepAlive();
    });
}

void ScriptMgr::OnDatabasesClosing()
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnDatabasesClosing();
    });
}

void ScriptMgr::OnDatabaseWarnAboutSyncQueries(bool apply)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnDatabaseWarnAboutSyncQueries(apply);
    });
}

void ScriptMgr::OnDatabaseSelectIndexLogout(Player* player, uint32& statementIndex, uint32& statementParam)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnDatabaseSelectIndexLogout(player, statementIndex, statementParam);
    });
}

void ScriptMgr::OnDatabaseGetDBRevision(std::string& revision)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnDatabaseGetDBRevision(revision);
    });
}

void ScriptMgr::OnAfterDatabaseLoadCreatureTemplates(std::vector<CreatureTemplate*> creatureTemplates)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnAfterDatabaseLoadCreatureTemplates(creatureTemplates);
    });
}
