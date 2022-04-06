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

#include "GameEventMgr.h"
#include "BattlegroundMgr.h"
#include "DisableMgr.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "Language.h"
#include "Log.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "Transport.h"
#include "UnitAI.h"
#include "Util.h"
#include "World.h"
#include "WorldStatePackets.h"
#include <time.h>

GameEventMgr* GameEventMgr::instance()
{
    static GameEventMgr instance;
    return &instance;
}

bool GameEventMgr::CheckOneGameEvent(uint16 entry) const
{
    switch (mGameEvent[entry].state)
    {
        default:
        case GAMEEVENT_NORMAL:
            {
                time_t currenttime = GameTime::GetGameTime().count();
                // Get the event information
                return mGameEvent[entry].start < currenttime
                       && currenttime < mGameEvent[entry].end
                       && (currenttime - mGameEvent[entry].start) % (mGameEvent[entry].occurence * MINUTE) < mGameEvent[entry].length * MINUTE;
            }
        // if the state is conditions or nextphase, then the event should be active
        case GAMEEVENT_WORLD_CONDITIONS:
        case GAMEEVENT_WORLD_NEXTPHASE:
            return true;
        // finished world events are inactive
        case GAMEEVENT_WORLD_FINISHED:
        case GAMEEVENT_INTERNAL:
            return false;
        // if inactive world event, check the prerequisite events
        case GAMEEVENT_WORLD_INACTIVE:
            {
                time_t currenttime = GameTime::GetGameTime().count();
                for (std::set<uint16>::const_iterator itr = mGameEvent[entry].prerequisite_events.begin(); itr != mGameEvent[entry].prerequisite_events.end(); ++itr)
                {
                    if ((mGameEvent[*itr].state != GAMEEVENT_WORLD_NEXTPHASE && mGameEvent[*itr].state != GAMEEVENT_WORLD_FINISHED) ||   // if prereq not in nextphase or finished state, then can't start this one
                            mGameEvent[*itr].nextstart > currenttime)               // if not in nextphase state for long enough, can't start this one
                        return false;
                }
                // all prerequisite events are met
                // but if there are no prerequisites, this can be only activated through gm command
                return !(mGameEvent[entry].prerequisite_events.empty());
            }
    }
}

uint32 GameEventMgr::NextCheck(uint16 entry) const
{
    time_t currenttime = GameTime::GetGameTime().count();

    // for NEXTPHASE state world events, return the delay to start the next event, so the followup event will be checked correctly
    if ((mGameEvent[entry].state == GAMEEVENT_WORLD_NEXTPHASE || mGameEvent[entry].state == GAMEEVENT_WORLD_FINISHED) && mGameEvent[entry].nextstart >= currenttime)
        return uint32(mGameEvent[entry].nextstart - currenttime);

    // for CONDITIONS state world events, return the length of the wait period, so if the conditions are met, this check will be called again to set the timer as NEXTPHASE event
    if (mGameEvent[entry].state == GAMEEVENT_WORLD_CONDITIONS)
    {
        if (mGameEvent[entry].length)
            return mGameEvent[entry].length * 60;
        else
            return max_ge_check_delay;
    }

    // outdated event: we return max
    if (currenttime > mGameEvent[entry].end)
        return max_ge_check_delay;

    // never started event, we return delay before start
    if (mGameEvent[entry].start > currenttime)
        return uint32(mGameEvent[entry].start - currenttime);

    uint32 delay;
    // in event, we return the end of it
    if ((((currenttime - mGameEvent[entry].start) % (mGameEvent[entry].occurence * 60)) < (mGameEvent[entry].length * 60)))
        // we return the delay before it ends
        delay = (mGameEvent[entry].length * MINUTE) - ((currenttime - mGameEvent[entry].start) % (mGameEvent[entry].occurence * MINUTE));
    else                                                    // not in window, we return the delay before next start
        delay = (mGameEvent[entry].occurence * MINUTE) - ((currenttime - mGameEvent[entry].start) % (mGameEvent[entry].occurence * MINUTE));
    // In case the end is before next check
    if (mGameEvent[entry].end  < time_t(currenttime + delay))
        return uint32(mGameEvent[entry].end - currenttime);
    else
        return delay;
}

void GameEventMgr::StartInternalEvent(uint16 event_id)
{
    if (event_id < 1 || event_id >= mGameEvent.size())
        return;

    if (!mGameEvent[event_id].isValid())
        return;

    if (m_ActiveEvents.find(event_id) != m_ActiveEvents.end())
        return;

    StartEvent(event_id);
}

bool GameEventMgr::StartEvent(uint16 event_id, bool overwrite)
{
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_GAME_EVENT, event_id, nullptr) && !overwrite)
    {
        return false;
    }

    GameEventData& data = mGameEvent[event_id];
    if (data.state == GAMEEVENT_NORMAL || data.state == GAMEEVENT_INTERNAL)
    {
        AddActiveEvent(event_id);
        ApplyNewEvent(event_id);
        if (overwrite)
        {
            mGameEvent[event_id].start = GameTime::GetGameTime().count();
            if (data.end <= data.start)
                data.end = data.start + data.length;
        }

        if (IsActiveEvent(event_id))
            sScriptMgr->OnGameEventStart(event_id);

        // When event is started, set its worldstate to current time
        auto itr = _gameEventSeasonalQuestsMap.find(event_id);
        if (itr != _gameEventSeasonalQuestsMap.end() && !itr->second.empty())
        {
            sWorld->setWorldState(event_id, GameTime::GetGameTime().count());
        }

        return false;
    }
    else
    {
        if (data.state == GAMEEVENT_WORLD_INACTIVE)
            // set to conditions phase
            data.state = GAMEEVENT_WORLD_CONDITIONS;

        // add to active events
        AddActiveEvent(event_id);
        // add spawns
        ApplyNewEvent(event_id);

        // check if can go to next state
        bool conditions_met = CheckOneGameEventConditions(event_id);
        // save to db
        SaveWorldEventStateToDB(event_id);
        // force game event update to set the update timer if conditions were met from a command
        // this update is needed to possibly start events dependent on the started one
        // or to scedule another update where the next event will be started
        if (overwrite && conditions_met)
            sWorld->ForceGameEventUpdate();

        if (IsActiveEvent(event_id))
            sScriptMgr->OnGameEventStart(event_id);

        return conditions_met;
    }
}

void GameEventMgr::StopEvent(uint16 event_id, bool overwrite)
{
    GameEventData& data = mGameEvent[event_id];
    bool serverwide_evt = data.state != GAMEEVENT_NORMAL && data.state != GAMEEVENT_INTERNAL;

    RemoveActiveEvent(event_id);
    UnApplyEvent(event_id);

     // When event is stopped, clean up its worldstate
    sWorld->setWorldState(event_id, 0);

    if (overwrite && !serverwide_evt)
    {
        data.start = GameTime::GetGameTime().count() - data.length * MINUTE;
        if (data.end <= data.start)
            data.end = data.start + data.length;
    }
    else if (serverwide_evt)
    {
        // if finished world event, then only gm command can stop it
        if (overwrite || data.state != GAMEEVENT_WORLD_FINISHED)
        {
            // reset conditions
            data.nextstart = 0;
            data.state = GAMEEVENT_WORLD_INACTIVE;
            GameEventConditionMap::iterator itr;
            for (itr = data.conditions.begin(); itr != data.conditions.end(); ++itr)
                itr->second.done = 0;

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ALL_GAME_EVENT_CONDITION_SAVE);
            stmt->SetData(0, uint8(event_id));
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_SAVE);
            stmt->SetData(0, uint8(event_id));
            trans->Append(stmt);

            CharacterDatabase.CommitTransaction(trans);
        }
    }

    if (!IsActiveEvent(event_id))
        sScriptMgr->OnGameEventStop(event_id);
}

void GameEventMgr::LoadFromDB()
{
    {
        uint32 oldMSTime = getMSTime();
        //                                                    1                 2                           3                  4        5        6          7             8            9          10
        QueryResult result = WorldDatabase.Query("SELECT eventEntry, UNIX_TIMESTAMP(start_time), UNIX_TIMESTAMP(end_time), occurence, length, holiday, holidayStage, description, world_event, announce FROM game_event");
        if (!result)
        {
            mGameEvent.clear();
            LOG_WARN("server.loading", ">> Loaded 0 game events. DB table `game_event` is empty.");
            LOG_INFO("server.loading", " ");
            return;
        }

        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint8 event_id = fields[0].Get<uint8>();
            if (event_id == 0)
            {
                LOG_ERROR("sql.sql", "`game_event` game event entry 0 is reserved and can't be used.");
                continue;
            }

            GameEventData& pGameEvent = mGameEvent[event_id];
            pGameEvent.eventId      = fields[0].Get<uint32>();
            uint64 starttime        = fields[1].Get<uint64>();
            pGameEvent.start        = time_t(starttime);
            uint64 endtime          = fields[2].Get<uint64>();
            if (fields[2].IsNull())
                endtime             = GameTime::GetGameTime().count() + 63072000; // add 2 years to current date
            pGameEvent.end          = time_t(endtime);
            pGameEvent.occurence    = fields[3].Get<uint64>();
            pGameEvent.length       = fields[4].Get<uint64>();
            pGameEvent.holiday_id   = HolidayIds(fields[5].Get<uint32>());

            pGameEvent.holidayStage = fields[6].Get<uint8>();
            pGameEvent.description  = fields[7].Get<std::string>();
            pGameEvent.state        = (GameEventState)(fields[8].Get<uint8>());
            pGameEvent.announce     = fields[9].Get<uint8>();
            pGameEvent.nextstart    = 0;

            ++count;

            if (pGameEvent.length == 0 && pGameEvent.state == GAMEEVENT_NORMAL)                            // length>0 is validity check
            {
                LOG_ERROR("sql.sql", "`game_event` game event id ({}) isn't a world event and has length = 0, thus it can't be used.", event_id);
                continue;
            }

            if (pGameEvent.holiday_id != HOLIDAY_NONE)
            {
                if (!sHolidaysStore.LookupEntry(pGameEvent.holiday_id))
                {
                    LOG_ERROR("sql.sql", "`game_event` game event id ({}) have not existed holiday id {}.", event_id, pGameEvent.holiday_id);
                    pGameEvent.holiday_id = HOLIDAY_NONE;
                }

                SetHolidayEventTime(pGameEvent);
            }
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }

    LOG_INFO("server.loading", "Loading Game Event Saves Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                       0       1        2
        QueryResult result = CharacterDatabase.Query("SELECT eventEntry, state, next_start FROM game_event_save");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 game event saves in game events. DB table `game_event_save` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint8 event_id = fields[0].Get<uint8>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_save` game event entry ({}) is out of range compared to max event entry in `game_event`", event_id);
                    continue;
                }

                if (mGameEvent[event_id].state != GAMEEVENT_NORMAL && mGameEvent[event_id].state != GAMEEVENT_INTERNAL)
                {
                    mGameEvent[event_id].state = (GameEventState)(fields[1].Get<uint8>());
                    mGameEvent[event_id].nextstart    = time_t(fields[2].Get<uint32>());
                }
                else
                {
                    LOG_ERROR("sql.sql", "game_event_save includes event save for non-worldevent id {}", event_id);
                    continue;
                }

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} game event saves in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Prerequisite Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                   0             1
        QueryResult result = WorldDatabase.Query("SELECT eventEntry, prerequisite_event FROM game_event_prerequisite");
        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 game event prerequisites in game events. DB table `game_event_prerequisite` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint16 event_id = fields[0].Get<uint8>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_prerequisite` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                if (mGameEvent[event_id].state != GAMEEVENT_NORMAL && mGameEvent[event_id].state != GAMEEVENT_INTERNAL)
                {
                    uint16 prerequisite_event = fields[1].Get<uint32>();
                    if (prerequisite_event >= mGameEvent.size())
                    {
                        LOG_ERROR("sql.sql", "`game_event_prerequisite` game event prerequisite id ({}) is out of range compared to max event id in `game_event`", prerequisite_event);
                        continue;
                    }
                    mGameEvent[event_id].prerequisite_events.insert(prerequisite_event);
                }
                else
                {
                    LOG_ERROR("sql.sql", "game_event_prerequisiste includes event entry for non-worldevent id {}", event_id);
                    continue;
                }

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} game event prerequisites in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Creature Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                 0        1
        QueryResult result = WorldDatabase.Query("SELECT guid, eventEntry FROM game_event_creature");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 creatures in game events. DB table `game_event_creature` is empty");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                int16 event_id = fields[1].Get<int8>();

                CreatureData const* data = sObjectMgr->GetCreatureData(guid);
                if (!data)
                {
                    LOG_ERROR("sql.sql", "`game_event_creature` contains creature (GUID: {}) not found in `creature` table.", guid);
                    continue;
                }

                int32 internal_event_id = mGameEvent.size() + event_id - 1;

                if (internal_event_id < 0 || internal_event_id >= int32(mGameEventCreatureGuids.size()))
                {
                    LOG_ERROR("sql.sql", "`game_event_creature` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                GuidLowList& crelist = mGameEventCreatureGuids[internal_event_id];
                crelist.push_back(guid);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} creatures in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event GO Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                0         1
        QueryResult result = WorldDatabase.Query("SELECT guid, eventEntry FROM game_event_gameobject");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 gameobjects in game events. DB table `game_event_gameobject` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                int16 event_id = fields[1].Get<int8>();

                int32 internal_event_id = mGameEvent.size() + event_id - 1;

                GameObjectData const* data = sObjectMgr->GetGOData(guid);
                if (!data)
                {
                    LOG_ERROR("sql.sql", "`game_event_gameobject` contains gameobject (GUID: {}) not found in `gameobject` table.", guid);
                    continue;
                }

                if (internal_event_id < 0 || internal_event_id >= int32(mGameEventGameobjectGuids.size()))
                {
                    LOG_ERROR("sql.sql", "`game_event_gameobject` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                GuidLowList& golist = mGameEventGameobjectGuids[internal_event_id];
                golist.push_back(guid);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} gameobjects in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Model/Equipment Change Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                     0              1             2            3                         4                               5                                 6
        QueryResult result = WorldDatabase.Query("SELECT creature.guid, creature.id1, creature.id2, creature.id3, game_event_model_equip.eventEntry, game_event_model_equip.modelid, game_event_model_equip.equipment_id "
                             "FROM creature JOIN game_event_model_equip ON creature.guid=game_event_model_equip.guid");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 model/equipment changes in game events. DB table `game_event_model_equip` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                uint32 entry = fields[1].Get<uint32>();
                uint32 entry2 = fields[2].Get<uint32>();
                uint32 entry3 = fields[3].Get<uint32>();
                uint16 event_id = fields[4].Get<uint8>();

                if (event_id >= mGameEventModelEquip.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_model_equip` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                ModelEquipList& equiplist = mGameEventModelEquip[event_id];
                ModelEquip newModelEquipSet;
                newModelEquipSet.modelid = fields[5].Get<uint32>();
                newModelEquipSet.equipment_id = fields[6].Get<uint8>();
                newModelEquipSet.equipement_id_prev = 0;
                newModelEquipSet.modelid_prev = 0;

                if (newModelEquipSet.equipment_id > 0)
                {
                    int8 equipId = static_cast<int8>(newModelEquipSet.equipment_id);
                    if ((!sObjectMgr->GetEquipmentInfo(entry, equipId)) || (entry2 && !sObjectMgr->GetEquipmentInfo(entry2, equipId)) || (entry3 && !sObjectMgr->GetEquipmentInfo(entry3, equipId)))
                    {
                        LOG_ERROR("sql.sql", "Table `game_event_model_equip` have creature (Guid: {}) with equipment_id {} not found in table `creature_equip_template`, set to no equipment.",
                                         guid, newModelEquipSet.equipment_id);
                        continue;
                    }
                }

                equiplist.push_back(std::pair<ObjectGuid::LowType, ModelEquip>(guid, newModelEquipSet));

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} model/equipment changes in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Quest Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                               0     1      2
        QueryResult result = WorldDatabase.Query("SELECT id, quest, eventEntry FROM game_event_creature_quest");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 quests additions in game events. DB table `game_event_creature_quest` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint32 id       = fields[0].Get<uint32>();
                uint32 quest    = fields[1].Get<uint32>();
                uint16 event_id = fields[2].Get<uint8>();

                if (event_id >= mGameEventCreatureQuests.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_creature_quest` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                QuestRelList& questlist = mGameEventCreatureQuests[event_id];
                questlist.push_back(QuestRelation(id, quest));

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} quests additions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event GO Quest Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                               0     1      2
        QueryResult result = WorldDatabase.Query("SELECT id, quest, eventEntry FROM game_event_gameobject_quest");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 go quests additions in game events. DB table `game_event_gameobject_quest` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint32 id       = fields[0].Get<uint32>();
                uint32 quest    = fields[1].Get<uint32>();
                uint16 event_id = fields[2].Get<uint8>();

                if (event_id >= mGameEventGameObjectQuests.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_gameobject_quest` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                QuestRelList& questlist = mGameEventGameObjectQuests[event_id];
                questlist.push_back(QuestRelation(id, quest));

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} quests additions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Quest Condition Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                 0       1         2             3
        QueryResult result = WorldDatabase.Query("SELECT quest, eventEntry, condition_id, num FROM game_event_quest_condition");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 quest event conditions in game events. DB table `game_event_quest_condition` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint32 quest     = fields[0].Get<uint32>();
                uint16 event_id  = fields[1].Get<uint8>();
                uint32 condition = fields[2].Get<uint32>();
                float num       = fields[3].Get<float>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_quest_condition` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                mQuestToEventConditions[quest].event_id = event_id;
                mQuestToEventConditions[quest].condition = condition;
                mQuestToEventConditions[quest].num = num;

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} quest event conditions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Condition Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                  0          1            2             3                      4
        QueryResult result = WorldDatabase.Query("SELECT eventEntry, condition_id, req_num, max_world_state_field, done_world_state_field FROM game_event_condition");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 conditions in game events. DB table `game_event_condition` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint16 event_id  = fields[0].Get<uint8>();
                uint32 condition = fields[1].Get<uint32>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_condition` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                mGameEvent[event_id].conditions[condition].reqNum = fields[2].Get<float>();
                mGameEvent[event_id].conditions[condition].done = 0;
                mGameEvent[event_id].conditions[condition].max_world_state = fields[3].Get<uint16>();
                mGameEvent[event_id].conditions[condition].done_world_state = fields[4].Get<uint16>();

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} conditions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Condition Save Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                      0           1         2
        QueryResult result = CharacterDatabase.Query("SELECT eventEntry, condition_id, done FROM game_event_condition_save");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 condition saves in game events. DB table `game_event_condition_save` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint16 event_id  = fields[0].Get<uint8>();
                uint32 condition = fields[1].Get<uint32>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_condition_save` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                GameEventConditionMap::iterator itr = mGameEvent[event_id].conditions.find(condition);
                if (itr != mGameEvent[event_id].conditions.end())
                {
                    itr->second.done = fields[2].Get<float>();
                }
                else
                {
                    LOG_ERROR("sql.sql", "game_event_condition_save contains not present condition evt id {} cond id {}", event_id, condition);
                    continue;
                }

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} condition saves in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event NPCflag Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                0       1        2
        QueryResult result = WorldDatabase.Query("SELECT guid, eventEntry, npcflag FROM game_event_npcflag");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 npcflags in game events. DB table `game_event_npcflag` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                uint16 event_id = fields[1].Get<uint8>();
                uint32 npcflag = fields[2].Get<uint32>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_npcflag` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                mGameEventNPCFlags[event_id].push_back(GuidNPCFlagPair(guid, npcflag));

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} npcflags in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Seasonal Quest Relations...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                  0          1
        QueryResult result = WorldDatabase.Query("SELECT questId, eventEntry FROM game_event_seasonal_questrelation");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 seasonal quests additions in game events. DB table `game_event_seasonal_questrelation` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint32 questId  = fields[0].Get<uint32>();
                uint32 eventEntry = fields[1].Get<uint32>(); // TODO: Change to uint8

                Quest* questTemplate = const_cast<Quest*>(sObjectMgr->GetQuestTemplate(questId));

                if (!questTemplate)
                {
                    LOG_ERROR("sql.sql", "`game_event_seasonal_questrelation` quest id ({}) does not exist in `quest_template`", questId);
                    continue;
                }

                if (eventEntry >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_seasonal_questrelation` event id ({}) is out of range compared to max event in `game_event`", eventEntry);
                    continue;
                }

                questTemplate->SetEventIdForQuest((uint16)eventEntry);
                _gameEventSeasonalQuestsMap[eventEntry].push_back(questId);
                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} quests additions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Vendor Additions Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                    0        1    2       3         4          5
        QueryResult result = WorldDatabase.Query("SELECT eventEntry, guid, item, maxcount, incrtime, ExtendedCost FROM game_event_npc_vendor ORDER BY guid, slot ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 vendor additions in game events. DB table `game_event_npc_vendor` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint8 event_id  = fields[0].Get<uint8>();

                if (event_id >= mGameEventVendors.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_npc_vendor` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                NPCVendorList& vendors = mGameEventVendors[event_id];
                NPCVendorEntry newEntry;
                ObjectGuid::LowType guid = fields[1].Get<uint32>();
                newEntry.item = fields[2].Get<uint32>();
                newEntry.maxcount = fields[3].Get<uint32>();
                newEntry.incrtime = fields[4].Get<uint32>();
                newEntry.ExtendedCost = fields[5].Get<uint32>();
                // get the event npc flag for checking if the npc will be vendor during the event or not
                uint32 event_npc_flag = 0;
                NPCFlagList& flist = mGameEventNPCFlags[event_id];
                for (NPCFlagList::const_iterator itr = flist.begin(); itr != flist.end(); ++itr)
                {
                    if (itr->first == guid)
                    {
                        event_npc_flag = itr->second;
                        break;
                    }
                }
                // get creature entry
                newEntry.entry = 0;

                if (CreatureData const* data = sObjectMgr->GetCreatureData(guid))
                    newEntry.entry = data->id1;

                // check validity with event's npcflag
                if (!sObjectMgr->IsVendorItemValid(newEntry.entry, newEntry.item, newEntry.maxcount, newEntry.incrtime, newEntry.ExtendedCost, nullptr, nullptr, event_npc_flag))
                    continue;

                vendors.push_back(newEntry);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} vendor additions in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Battleground Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                   0         1
        QueryResult result = WorldDatabase.Query("SELECT eventEntry, bgflag FROM game_event_battleground_holiday");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 battleground holidays in game events. DB table `game_event_battleground_holiday` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint16 event_id = fields[0].Get<uint8>();

                if (event_id >= mGameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_battleground_holiday` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                mGameEventBattlegroundHolidays[event_id] = fields[1].Get<uint32>();

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} battleground holidays in game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Game Event Pool Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                               0                         1
        QueryResult result = WorldDatabase.Query("SELECT pool_template.entry, game_event_pool.eventEntry FROM pool_template"
                             " JOIN game_event_pool ON pool_template.entry = game_event_pool.pool_entry");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 pools for game events. DB table `game_event_pool` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();

                uint32 entry   = fields[0].Get<uint32>();
                int16 event_id = fields[1].Get<int8>();

                int32 internal_event_id = mGameEvent.size() + event_id - 1;

                if (internal_event_id < 0 || internal_event_id >= int32(mGameEventPoolIds.size()))
                {
                    LOG_ERROR("sql.sql", "`game_event_pool` game event id ({}) is out of range compared to max event id in `game_event`", event_id);
                    continue;
                }

                if (!sPoolMgr->CheckPool(entry))
                {
                    LOG_ERROR("sql.sql", "Pool Id ({}) has all creatures or gameobjects with explicit chance sum <>100 and no equal chance defined. The pool system cannot pick one to spawn.", entry);
                    continue;
                }

                IdList& poollist = mGameEventPoolIds[internal_event_id];
                poollist.push_back(entry);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} pools for game events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }
}

void GameEventMgr::LoadHolidayDates()
{
    uint32 oldMSTime = getMSTime();

    //                                               0   1        2           3
    QueryResult result = WorldDatabase.Query("SELECT id, date_id, date_value, holiday_duration FROM holiday_dates");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 holiday dates. DB table `holiday_dates` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 holidayId = fields[0].Get<uint32>();
        HolidaysEntry* entry = const_cast<HolidaysEntry*>(sHolidaysStore.LookupEntry(holidayId));
        if (!entry)
        {
            LOG_ERROR("sql.sql", "holiday_dates entry has invalid holiday id {}.", holidayId);
            continue;
        }

        uint8 dateId = fields[1].Get<uint8>();
        if (dateId >= MAX_HOLIDAY_DATES)
        {
            LOG_ERROR("sql.sql", "holiday_dates entry has out of range date_id {}.", dateId);
            continue;
        }
        entry->Date[dateId] = fields[2].Get<uint32>();

        if (uint32 duration = fields[3].Get<uint32>())
            entry->Duration[0] = duration;

        auto itr = std::lower_bound(modifiedHolidays.begin(), modifiedHolidays.end(), entry->Id);
        if (itr == modifiedHolidays.end() || *itr != entry->Id)
        {
            modifiedHolidays.insert(itr, entry->Id);
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} holiday dates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
}

uint32 GameEventMgr::GetNPCFlag(Creature* cr)
{
    uint32 mask = 0;
    ObjectGuid::LowType spawnId = cr->GetSpawnId();

    for (ActiveEvents::iterator e_itr = m_ActiveEvents.begin(); e_itr != m_ActiveEvents.end(); ++e_itr)
    {
        for (NPCFlagList::iterator itr = mGameEventNPCFlags[*e_itr].begin(); itr != mGameEventNPCFlags[*e_itr].end(); ++ itr)
            if (itr->first == spawnId)
                mask |= itr->second;
    }

    return mask;
}

void GameEventMgr::Initialize()
{
    QueryResult result = WorldDatabase.Query("SELECT MAX(eventEntry) FROM game_event");
    if (result)
    {
        Field* fields = result->Fetch();

        uint32 maxEventId = fields[0].Get<uint8>();

        // Id starts with 1 and vector with 0, thus increment
        maxEventId++;

        mGameEvent.resize(maxEventId);
        mGameEventCreatureGuids.resize(maxEventId * 2 - 1);
        mGameEventGameobjectGuids.resize(maxEventId * 2 - 1);
        mGameEventCreatureQuests.resize(maxEventId);
        mGameEventGameObjectQuests.resize(maxEventId);
        mGameEventVendors.resize(maxEventId);
        mGameEventBattlegroundHolidays.resize(maxEventId, 0);
        mGameEventPoolIds.resize(maxEventId * 2 - 1);
        mGameEventNPCFlags.resize(maxEventId);
        mGameEventModelEquip.resize(maxEventId);
    }
}

uint32 GameEventMgr::StartSystem()                           // return the next event delay in ms
{
    m_ActiveEvents.clear();
    uint32 delay = Update();
    isSystemInit = true;
    return delay;
}

void GameEventMgr::StartArenaSeason()
{
    uint8 season = sWorld->getIntConfig(CONFIG_ARENA_SEASON_ID);
    QueryResult result = WorldDatabase.Query("SELECT eventEntry FROM game_event_arena_seasons WHERE season = '{}'", season);

    if (!result)
    {
        LOG_ERROR("gameevent", "ArenaSeason ({}) must be an existant Arena Season", season);
        return;
    }

    Field* fields = result->Fetch();
    uint16 eventId = fields[0].Get<uint8>();

    if (eventId >= mGameEvent.size())
    {
        LOG_ERROR("gameevent", "EventEntry {} for ArenaSeason ({}) does not exists", eventId, season);
        return;
    }

    StartEvent(eventId, true);
    LOG_INFO("server.loading", "Arena Season {} started...", season);
    LOG_INFO("server.loading", " ");
}

uint32 GameEventMgr::Update()                               // return the next event delay in ms
{
    time_t currenttime = GameTime::GetGameTime().count();
    uint32 nextEventDelay = max_ge_check_delay;             // 1 day
    uint32 calcDelay;
    std::set<uint16> activate, deactivate;
    for (uint16 itr = 1; itr < mGameEvent.size(); ++itr)
    {
        // must do the activating first, and after that the deactivating
        // so first queue it
        //LOG_ERROR("sql.sql", "Checking event {}", itr);

        sScriptMgr->OnGameEventCheck(itr);

        if (CheckOneGameEvent(itr))
        {
            // if the world event is in NEXTPHASE state, and the time has passed to finish this event, then do so
            if (mGameEvent[itr].state == GAMEEVENT_WORLD_NEXTPHASE && mGameEvent[itr].nextstart <= currenttime)
            {
                // set this event to finished, null the nextstart time
                mGameEvent[itr].state = GAMEEVENT_WORLD_FINISHED;
                mGameEvent[itr].nextstart = 0;
                // save the state of this gameevent
                SaveWorldEventStateToDB(itr);
                // queue for deactivation
                if (IsActiveEvent(itr))
                    deactivate.insert(itr);
                // go to next event, this no longer needs an event update timer
                continue;
            }
            else if (mGameEvent[itr].state == GAMEEVENT_WORLD_CONDITIONS && CheckOneGameEventConditions(itr))
                // changed, save to DB the gameevent state, will be updated in next update cycle
                SaveWorldEventStateToDB(itr);

            // queue for activation
            if (!IsActiveEvent(itr))
                activate.insert(itr);
        }
        else
        {
            // If event is inactive, periodically clean up its worldstate
            sWorld->setWorldState(itr, 0);

            if (IsActiveEvent(itr))
            {
                // Xinef: do not deactivate internal events on whim
                if (mGameEvent[itr].state != GAMEEVENT_INTERNAL)
                    deactivate.insert(itr);
            }
            else
            {
                if (!isSystemInit)
                {
                    int16 event_nid = (-1) * (itr);
                    // spawn all negative ones for this event
                    GameEventSpawn(event_nid);
                }
            }
        }
        calcDelay = NextCheck(itr);
        if (calcDelay < nextEventDelay)
            nextEventDelay = calcDelay;
    }
    // now activate the queue
    // a now activated event can contain a spawn of a to-be-deactivated one
    // following the activate - deactivate order, deactivating the first event later will leave the spawn in (wont disappear then reappear clientside)
    for (std::set<uint16>::iterator itr = activate.begin(); itr != activate.end(); ++itr)
        // start the event
        // returns true the started event completed
        // in that case, initiate next update in 1 second
        if (StartEvent(*itr))
            nextEventDelay = 0;
    for (std::set<uint16>::iterator itr = deactivate.begin(); itr != deactivate.end(); ++itr)
        StopEvent(*itr);

    LOG_DEBUG("gameevent", "Next game event check in {} seconds.", nextEventDelay + 1);
    return (nextEventDelay + 1) * IN_MILLISECONDS;           // Add 1 second to be sure event has started/stopped at next call
}

void GameEventMgr::UnApplyEvent(uint16 event_id)
{
    LOG_DEBUG("gameevent", "GameEvent {} \"{}\" removed.", event_id, mGameEvent[event_id].description);
    //! Run SAI scripts with SMART_EVENT_GAME_EVENT_END
    RunSmartAIScripts(event_id, false);
    // un-spawn positive event tagged objects
    GameEventUnspawn(event_id);
    // spawn negative event tagget objects
    int16 event_nid = (-1) * event_id;
    GameEventSpawn(event_nid);
    // restore equipment or model
    ChangeEquipOrModel(event_id, false);
    // Remove quests that are events only to non event npc
    UpdateEventQuests(event_id, false);
    UpdateWorldStates(event_id, false);
    // update npcflags in this event
    UpdateEventNPCFlags(event_id);
    // remove vendor items
    UpdateEventNPCVendor(event_id, false);
    // update bg holiday
    UpdateBattlegroundSettings();
}

void GameEventMgr::ApplyNewEvent(uint16 event_id)
{
    uint8 announce = mGameEvent[event_id].announce;
    if (announce == 1 || (announce == 2 && sWorld->getIntConfig(CONFIG_EVENT_ANNOUNCE)))
        sWorld->SendWorldText(LANG_EVENTMESSAGE, mGameEvent[event_id].description.c_str());

    LOG_DEBUG("gameevent", "GameEvent {} \"{}\" started.", event_id, mGameEvent[event_id].description);

    // spawn positive event tagget objects
    GameEventSpawn(event_id);
    // un-spawn negative event tagged objects
    int16 event_nid = (-1) * event_id;
    GameEventUnspawn(event_nid);
    // Change equipement or model
    ChangeEquipOrModel(event_id, true);
    // Add quests that are events only to non event npc
    UpdateEventQuests(event_id, true);
    UpdateWorldStates(event_id, true);
    // update npcflags in this event
    UpdateEventNPCFlags(event_id);
    // add vendor items
    UpdateEventNPCVendor(event_id, true);
    // update bg holiday
    UpdateBattlegroundSettings();

    //! Run SAI scripts with SMART_EVENT_GAME_EVENT_START
    RunSmartAIScripts(event_id, true);

    // If event's worldstate is 0, it means the event hasn't been started yet. In that case, reset seasonal quests.
    // When event ends (if it expires or if it's stopped via commands) worldstate will be set to 0 again, ready for another seasonal quest reset.
    if (sWorld->getWorldState(event_id) == 0)
    {
        sWorld->ResetEventSeasonalQuests(event_id);
    }
}

void GameEventMgr::UpdateEventNPCFlags(uint16 event_id)
{
    std::unordered_map<uint32, std::unordered_set<ObjectGuid::LowType>> creaturesByMap;

    // go through the creatures whose npcflags are changed in the event
    for (NPCFlagList::iterator itr = mGameEventNPCFlags[event_id].begin(); itr != mGameEventNPCFlags[event_id].end(); ++itr)
    {
        // get the creature data from the low guid to get the entry, to be able to find out the whole guid
        if (CreatureData const* data = sObjectMgr->GetCreatureData(itr->first))
            creaturesByMap[data->mapid].insert(itr->first);
    }

    for (auto const& p : creaturesByMap)
    {
        sMapMgr->DoForAllMapsWithMapId(p.first, [this, &p](Map* map)
        {
            for (auto& spawnId : p.second)
            {
                auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(spawnId);
                for (auto itr = creatureBounds.first; itr != creatureBounds.second; ++itr)
                {
                    Creature* creature = itr->second;
                    uint32 npcflag = GetNPCFlag(creature);
                    if (CreatureTemplate const* creatureTemplate = creature->GetCreatureTemplate())
                        npcflag |= creatureTemplate->npcflag;

                    creature->ReplaceAllNpcFlags(NPCFlags(npcflag));
                    // reset gossip options, since the flag change might have added / removed some
                    //cr->ResetGossipOptions();
                }
            }
        });
    }
}

void GameEventMgr::UpdateBattlegroundSettings()
{
    uint32 mask = 0;
    for (ActiveEvents::const_iterator itr = m_ActiveEvents.begin(); itr != m_ActiveEvents.end(); ++itr)
        mask |= mGameEventBattlegroundHolidays[*itr];
    sBattlegroundMgr->SetHolidayWeekends(mask);
}

void GameEventMgr::UpdateEventNPCVendor(uint16 event_id, bool activate)
{
    for (NPCVendorList::iterator itr = mGameEventVendors[event_id].begin(); itr != mGameEventVendors[event_id].end(); ++itr)
    {
        if (activate)
            sObjectMgr->AddVendorItem(itr->entry, itr->item, itr->maxcount, itr->incrtime, itr->ExtendedCost, false);
        else
            sObjectMgr->RemoveVendorItem(itr->entry, itr->item, false);
    }
}

void GameEventMgr::GameEventSpawn(int16 event_id)
{
    int32 internal_event_id = mGameEvent.size() + event_id - 1;

    if (internal_event_id < 0 || internal_event_id >= int32(mGameEventCreatureGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range mGameEventCreatureGuids element {} (size: {})",
                       internal_event_id, mGameEventCreatureGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = mGameEventCreatureGuids[internal_event_id].begin(); itr != mGameEventCreatureGuids[internal_event_id].end(); ++itr)
    {
        // Add to correct cell
        if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr))
        {
            sObjectMgr->AddCreatureToGrid(*itr, data);

            // Spawn if necessary (loaded grids only)
            Map* map = sMapMgr->CreateBaseMap(data->mapid);
            // We use spawn coords to spawn
            if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
            {
                Creature* creature = new Creature;
                if (!creature->LoadCreatureFromDB(*itr, map))
                    delete creature;
            }
        }
    }

    if (internal_event_id >= int32(mGameEventGameobjectGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range mGameEventGameobjectGuids element {} (size: {})",
                       internal_event_id, mGameEventGameobjectGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = mGameEventGameobjectGuids[internal_event_id].begin(); itr != mGameEventGameobjectGuids[internal_event_id].end(); ++itr)
    {
        // Add to correct cell
        if (GameObjectData const* data = sObjectMgr->GetGOData(*itr))
        {
            sObjectMgr->AddGameobjectToGrid(*itr, data);
            // Spawn if necessary (loaded grids only)
            // this base map checked as non-instanced and then only existed
            Map* map = sMapMgr->CreateBaseMap(data->mapid);
            // We use current coords to unspawn, not spawn coords since creature can have changed grid
            if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
            {
                GameObject* pGameobject = sObjectMgr->IsGameObjectStaticTransport(data->id) ? new StaticTransport() : new GameObject();
                //TODO: find out when it is add to map
                if (!pGameobject->LoadGameObjectFromDB(*itr, map, false))
                    delete pGameobject;
                else
                {
                    if (pGameobject->isSpawnedByDefault())
                        map->AddToMap(pGameobject);
                }
            }
        }
    }

    if (internal_event_id >= int32(mGameEventPoolIds.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range mGameEventPoolIds element {} (size: {})",
                       internal_event_id, mGameEventPoolIds.size());
        return;
    }

    for (IdList::iterator itr = mGameEventPoolIds[internal_event_id].begin(); itr != mGameEventPoolIds[internal_event_id].end(); ++itr)
        sPoolMgr->SpawnPool(*itr);
}

void GameEventMgr::GameEventUnspawn(int16 event_id)
{
    int32 internal_event_id = mGameEvent.size() + event_id - 1;

    if (internal_event_id < 0 || internal_event_id >= int32(mGameEventCreatureGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range mGameEventCreatureGuids element {} (size: {})",
                       internal_event_id, mGameEventCreatureGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = mGameEventCreatureGuids[internal_event_id].begin(); itr != mGameEventCreatureGuids[internal_event_id].end(); ++itr)
    {
        // check if it's needed by another event, if so, don't remove
        if (event_id > 0 && hasCreatureActiveEventExcept(*itr, event_id))
            continue;

        // Remove the creature from grid
        if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr))
        {
            sObjectMgr->RemoveCreatureFromGrid(*itr, data);

            sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr](Map* map)
            {
                auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(*itr);
                for (auto itr2 = creatureBounds.first; itr2 != creatureBounds.second;)
                {
                    Creature* creature = itr2->second;
                    ++itr2;
                    creature->AddObjectToRemoveList();
                }
            });
        }
    }

    if (internal_event_id >= int32(mGameEventGameobjectGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range mGameEventGameobjectGuids element {} (size: {})",
                       internal_event_id, mGameEventGameobjectGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = mGameEventGameobjectGuids[internal_event_id].begin(); itr != mGameEventGameobjectGuids[internal_event_id].end(); ++itr)
    {
        // check if it's needed by another event, if so, don't remove
        if (event_id > 0 && hasGameObjectActiveEventExcept(*itr, event_id))
            continue;
        // Remove the gameobject from grid
        if (GameObjectData const* data = sObjectMgr->GetGOData(*itr))
        {
            sObjectMgr->RemoveGameobjectFromGrid(*itr, data);

            sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr](Map* map)
            {
                auto gameobjectBounds = map->GetGameObjectBySpawnIdStore().equal_range(*itr);
                for (auto itr2 = gameobjectBounds.first; itr2 != gameobjectBounds.second;)
                {
                    GameObject* go = itr2->second;
                    ++itr2;
                    go->AddObjectToRemoveList();
                }
            });
        }
    }
    if (internal_event_id >= int32(mGameEventPoolIds.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range mGameEventPoolIds element {} (size: {})", internal_event_id, mGameEventPoolIds.size());
        return;
    }

    for (IdList::iterator itr = mGameEventPoolIds[internal_event_id].begin(); itr != mGameEventPoolIds[internal_event_id].end(); ++itr)
    {
        sPoolMgr->DespawnPool(*itr);
    }
}

void GameEventMgr::ChangeEquipOrModel(int16 event_id, bool activate)
{
    for (ModelEquipList::iterator itr = mGameEventModelEquip[event_id].begin(); itr != mGameEventModelEquip[event_id].end(); ++itr)
    {
        // Remove the creature from grid
        CreatureData const* data = sObjectMgr->GetCreatureData(itr->first);
        if (!data)
            continue;

        // Update if spawned
        sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr, activate](Map* map)
        {
            auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(itr->first);
            for (auto itr2 = creatureBounds.first; itr2 != creatureBounds.second; ++itr2)
            {
                Creature* creature = itr2->second;
                if (activate)
                {
                    itr->second.equipement_id_prev = creature->GetCurrentEquipmentId();
                    itr->second.modelid_prev = creature->GetDisplayId();
                    creature->LoadEquipment(itr->second.equipment_id, true);
                    if (itr->second.modelid > 0 && itr->second.modelid_prev != itr->second.modelid && sObjectMgr->GetCreatureModelInfo(itr->second.modelid))
                    {
                        creature->SetDisplayId(itr->second.modelid);
                        creature->SetNativeDisplayId(itr->second.modelid);
                    }
                }
                else
                {
                    creature->LoadEquipment(itr->second.equipement_id_prev, true);
                    if (itr->second.modelid_prev > 0 && itr->second.modelid_prev != itr->second.modelid && sObjectMgr->GetCreatureModelInfo(itr->second.modelid_prev))
                    {
                        creature->SetDisplayId(itr->second.modelid_prev);
                        creature->SetNativeDisplayId(itr->second.modelid_prev);
                    }
                }
            }
        });

        // now last step: put in data
        // just to have write access to it
        CreatureData& data2 = sObjectMgr->NewOrExistCreatureData(itr->first);
        if (activate)
        {
            itr->second.modelid_prev = data2.displayid;
            itr->second.equipement_id_prev = data2.equipmentId;
            data2.displayid = itr->second.modelid;
            data2.equipmentId = itr->second.equipment_id;
        }
        else
        {
            data2.displayid = itr->second.modelid_prev;
            data2.equipmentId = itr->second.equipement_id_prev;
        }
    }
}

bool GameEventMgr::hasCreatureQuestActiveEventExcept(uint32 quest_id, uint16 event_id)
{
    for (ActiveEvents::iterator e_itr = m_ActiveEvents.begin(); e_itr != m_ActiveEvents.end(); ++e_itr)
    {
        if ((*e_itr) != event_id)
            for (QuestRelList::iterator itr = mGameEventCreatureQuests[*e_itr].begin();
                    itr != mGameEventCreatureQuests[*e_itr].end();
                    ++ itr)
                if (itr->second == quest_id)
                    return true;
    }
    return false;
}

bool GameEventMgr::hasGameObjectQuestActiveEventExcept(uint32 quest_id, uint16 event_id)
{
    for (ActiveEvents::iterator e_itr = m_ActiveEvents.begin(); e_itr != m_ActiveEvents.end(); ++e_itr)
    {
        if ((*e_itr) != event_id)
            for (QuestRelList::iterator itr = mGameEventGameObjectQuests[*e_itr].begin();
                    itr != mGameEventGameObjectQuests[*e_itr].end();
                    ++ itr)
                if (itr->second == quest_id)
                    return true;
    }
    return false;
}
bool GameEventMgr::hasCreatureActiveEventExcept(ObjectGuid::LowType creature_guid, uint16 event_id)
{
    for (ActiveEvents::iterator e_itr = m_ActiveEvents.begin(); e_itr != m_ActiveEvents.end(); ++e_itr)
    {
        if ((*e_itr) != event_id)
        {
            int32 internal_event_id = mGameEvent.size() + (*e_itr) - 1;
            for (GuidLowList::iterator itr = mGameEventCreatureGuids[internal_event_id].begin(); itr != mGameEventCreatureGuids[internal_event_id].end(); ++ itr)
                if (*itr == creature_guid)
                    return true;
        }
    }
    return false;
}
bool GameEventMgr::hasGameObjectActiveEventExcept(ObjectGuid::LowType go_guid, uint16 event_id)
{
    for (ActiveEvents::iterator e_itr = m_ActiveEvents.begin(); e_itr != m_ActiveEvents.end(); ++e_itr)
    {
        if ((*e_itr) != event_id)
        {
            int32 internal_event_id = mGameEvent.size() + (*e_itr) - 1;
            for (GuidLowList::iterator itr = mGameEventGameobjectGuids[internal_event_id].begin(); itr != mGameEventGameobjectGuids[internal_event_id].end(); ++ itr)
                if (*itr == go_guid)
                    return true;
        }
    }
    return false;
}

void GameEventMgr::UpdateEventQuests(uint16 event_id, bool activate)
{
    QuestRelList::iterator itr;
    for (itr = mGameEventCreatureQuests[event_id].begin(); itr != mGameEventCreatureQuests[event_id].end(); ++itr)
    {
        QuestRelations* CreatureQuestMap = sObjectMgr->GetCreatureQuestRelationMap();
        if (activate)                                           // Add the pair(id, quest) to the multimap
            CreatureQuestMap->insert(QuestRelations::value_type(itr->first, itr->second));
        else
        {
            if (!hasCreatureQuestActiveEventExcept(itr->second, event_id))
            {
                // Remove the pair(id, quest) from the multimap
                QuestRelations::iterator qitr = CreatureQuestMap->find(itr->first);
                if (qitr == CreatureQuestMap->end())
                    continue;
                QuestRelations::iterator lastElement = CreatureQuestMap->upper_bound(itr->first);
                for (; qitr != lastElement; ++qitr)
                {
                    if (qitr->second == itr->second)
                    {
                        CreatureQuestMap->erase(qitr);          // iterator is now no more valid
                        break;                                  // but we can exit loop since the element is found
                    }
                }
            }
        }
    }
    for (itr = mGameEventGameObjectQuests[event_id].begin(); itr != mGameEventGameObjectQuests[event_id].end(); ++itr)
    {
        QuestRelations* GameObjectQuestMap = sObjectMgr->GetGOQuestRelationMap();
        if (activate)                                           // Add the pair(id, quest) to the multimap
            GameObjectQuestMap->insert(QuestRelations::value_type(itr->first, itr->second));
        else
        {
            if (!hasGameObjectQuestActiveEventExcept(itr->second, event_id))
            {
                // Remove the pair(id, quest) from the multimap
                QuestRelations::iterator qitr = GameObjectQuestMap->find(itr->first);
                if (qitr == GameObjectQuestMap->end())
                    continue;
                QuestRelations::iterator lastElement = GameObjectQuestMap->upper_bound(itr->first);
                for (; qitr != lastElement; ++qitr)
                {
                    if (qitr->second == itr->second)
                    {
                        GameObjectQuestMap->erase(qitr);        // iterator is now no more valid
                        break;                                  // but we can exit loop since the element is found
                    }
                }
            }
        }
    }
}

void GameEventMgr::UpdateWorldStates(uint16 event_id, bool Activate)
{
    GameEventData const& event = mGameEvent[event_id];
    if (event.holiday_id != HOLIDAY_NONE)
    {
        BattlegroundTypeId bgTypeId = BattlegroundMgr::WeekendHolidayIdToBGType(event.holiday_id);
        if (bgTypeId != BATTLEGROUND_TYPE_NONE)
        {
            BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
            if (bl && bl->HolidayWorldStateId)
            {
                WorldPackets::WorldState::UpdateWorldState worldstate;
                worldstate.VariableID = bl->HolidayWorldStateId;
                worldstate.Value = Activate ? 1 : 0;
                sWorld->SendGlobalMessage(worldstate.Write());
            }
        }
    }
}

GameEventMgr::GameEventMgr() : isSystemInit(false)
{
}

void GameEventMgr::HandleQuestComplete(uint32 quest_id)
{
    // translate the quest to event and condition
    QuestIdToEventConditionMap::iterator itr = mQuestToEventConditions.find(quest_id);
    // quest is registered
    if (itr != mQuestToEventConditions.end())
    {
        uint16 event_id = itr->second.event_id;
        uint32 condition = itr->second.condition;
        float num = itr->second.num;

        // the event is not active, so return, don't increase condition finishes
        if (!IsActiveEvent(event_id))
            return;
        // not in correct phase, return
        if (mGameEvent[event_id].state != GAMEEVENT_WORLD_CONDITIONS)
            return;
        GameEventConditionMap::iterator citr = mGameEvent[event_id].conditions.find(condition);
        // condition is registered
        if (citr != mGameEvent[event_id].conditions.end())
        {
            // increase the done count, only if less then the req
            if (citr->second.done < citr->second.reqNum)
            {
                citr->second.done += num;
                // check max limit
                if (citr->second.done > citr->second.reqNum)
                    citr->second.done = citr->second.reqNum;
                // save the change to db
                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_CONDITION_SAVE);
                stmt->SetData(0, uint8(event_id));
                stmt->SetData(1, condition);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GAME_EVENT_CONDITION_SAVE);
                stmt->SetData(0, uint8(event_id));
                stmt->SetData(1, condition);
                stmt->SetData(2, citr->second.done);
                trans->Append(stmt);
                CharacterDatabase.CommitTransaction(trans);
                // check if all conditions are met, if so, update the event state
                if (CheckOneGameEventConditions(event_id))
                {
                    // changed, save to DB the gameevent state
                    SaveWorldEventStateToDB(event_id);
                    // force update events to set timer
                    sWorld->ForceGameEventUpdate();
                }
            }
        }
    }
}

bool GameEventMgr::CheckOneGameEventConditions(uint16 event_id)
{
    for (GameEventConditionMap::const_iterator itr = mGameEvent[event_id].conditions.begin(); itr != mGameEvent[event_id].conditions.end(); ++itr)
        if (itr->second.done < itr->second.reqNum)
            // return false if a condition doesn't match
            return false;
    // set the phase
    mGameEvent[event_id].state = GAMEEVENT_WORLD_NEXTPHASE;
    // set the followup events' start time
    if (!mGameEvent[event_id].nextstart)
    {
        time_t currenttime = GameTime::GetGameTime().count();
        mGameEvent[event_id].nextstart = currenttime + mGameEvent[event_id].length * 60;
    }
    return true;
}

void GameEventMgr::SaveWorldEventStateToDB(uint16 event_id)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_SAVE);
    stmt->SetData(0, uint8(event_id));
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GAME_EVENT_SAVE);
    stmt->SetData(0, uint8(event_id));
    stmt->SetData(1, mGameEvent[event_id].state);
    stmt->SetData(2, mGameEvent[event_id].nextstart ? uint32(mGameEvent[event_id].nextstart) : 0);
    trans->Append(stmt);
    CharacterDatabase.CommitTransaction(trans);
}

void GameEventMgr::SendWorldStateUpdate(Player* player, uint16 event_id)
{
    GameEventConditionMap::const_iterator itr;
    for (itr = mGameEvent[event_id].conditions.begin(); itr != mGameEvent[event_id].conditions.end(); ++itr)
    {
        if (itr->second.done_world_state)
            player->SendUpdateWorldState(itr->second.done_world_state, (uint32)(itr->second.done));
        if (itr->second.max_world_state)
            player->SendUpdateWorldState(itr->second.max_world_state, (uint32)(itr->second.reqNum));
    }
}

class GameEventAIHookWorker
{
public:
    GameEventAIHookWorker(uint16 eventId, bool activate) : _eventId(eventId), _activate(activate) { }

    void Visit(std::unordered_map<ObjectGuid, Creature*>& creatureMap)
    {
        for (auto const& p : creatureMap)
            if (p.second->IsInWorld() && !p.second->IsDuringRemoveFromWorld() && p.second->FindMap() && p.second->IsAIEnabled && p.second->AI())
                p.second->AI()->sOnGameEvent(_activate, _eventId);
    }

    void Visit(std::unordered_map<ObjectGuid, GameObject*>& gameObjectMap)
    {
        for (auto const& p : gameObjectMap)
            if (p.second->IsInWorld() && p.second->FindMap() && p.second->AI())
                p.second->AI()->OnGameEvent(_activate, _eventId);
    }

    template<class T>
    void Visit(std::unordered_map<ObjectGuid, T*>&) { }

private:
    uint16 _eventId;
    bool _activate;
};

void GameEventMgr::RunSmartAIScripts(uint16 event_id, bool activate)
{
    //! Iterate over every supported source type (creature and gameobject)
    //! Not entirely sure how this will affect units in non-loaded grids.
    sMapMgr->DoForAllMaps([event_id, activate](Map* map)
    {
        GameEventAIHookWorker worker(event_id, activate);
        TypeContainerVisitor<GameEventAIHookWorker, MapStoredObjectTypesContainer> visitor(worker);
        visitor.Visit(map->GetObjectsStore());
    });
}

void GameEventMgr::SetHolidayEventTime(GameEventData& event)
{
    if (!event.holidayStage) // Ignore holiday
        return;

    const HolidaysEntry* holiday = sHolidaysStore.LookupEntry(event.holiday_id);

    if (!holiday->Date[0] || !holiday->Duration[0]) // Invalid definitions
    {
        LOG_ERROR("sql.sql", "Missing date or duration for holiday {}.", event.holiday_id);
        return;
    }

    uint8 stageIndex = event.holidayStage - 1;
    event.length = holiday->Duration[stageIndex] * HOUR / MINUTE;

    time_t stageOffset = 0;
    for (uint8 i = 0; i < stageIndex; ++i)
    {
        stageOffset += holiday->Duration[i] * HOUR;
    }

    switch (holiday->CalendarFilterType)
    {
        case -1: // Yearly
            event.occurence = YEAR / MINUTE; // Not all too useful
            break;
        case 0: // Weekly
            event.occurence = WEEK / MINUTE;
            break;
        case 1: // Defined dates only (Darkmoon Faire)
            break;
        case 2: // Only used for looping events (Call to Arms)
            break;
    }

    if (holiday->Looping)
    {
        event.occurence = 0;
        for (uint8 i = 0; i < MAX_HOLIDAY_DURATIONS && holiday->Duration[i]; ++i)
        {
            event.occurence += holiday->Duration[i] * HOUR / MINUTE;
        }
    }

    bool singleDate = ((holiday->Date[0] >> 24) & 0x1F) == 31; // Events with fixed date within year have - 1

    time_t curTime = GameTime::GetGameTime().count();
    for (uint8 i = 0; i < MAX_HOLIDAY_DATES && holiday->Date[i]; ++i)

    {
        uint32 date = holiday->Date[i];

        tm timeInfo;
        if (singleDate)
        {
            timeInfo = Acore::Time::TimeBreakdown(curTime);
            timeInfo.tm_year -= 1; // First try last year (event active through New Year)
        }
        else
        {
            timeInfo.tm_year = ((date >> 24) & 0x1F) + 100;
        }

        timeInfo.tm_mon = (date >> 20) & 0xF;
        timeInfo.tm_mday = ((date >> 14) & 0x3F) + 1;
        timeInfo.tm_hour = (date >> 6) & 0x1F;
        timeInfo.tm_min = date & 0x3F;
        timeInfo.tm_sec = 0;
        timeInfo.tm_isdst = -1;

        // try to get next start time (skip past dates)
        time_t startTime = mktime(&timeInfo);
        if (curTime < startTime + event.length * MINUTE)
        {
            event.start = startTime + stageOffset;
            break;
        }
        else if (singleDate)
        {
            tm tmCopy = Acore::Time::TimeBreakdown(curTime);
            int year = tmCopy.tm_year; // This year
            tmCopy = timeInfo;
            tmCopy.tm_year = year;
            event.start = mktime(&tmCopy) + stageOffset;
            break;
        }
        else
        {
            // date is due and not a singleDate event, try with next DBC date (modified by holiday_dates)
            // if none is found we don't modify start date and use the one in game_event
        }
    }
}

uint32 GameEventMgr::GetHolidayEventId(uint32 holidayId) const
{
    auto const& events = sGameEventMgr->GetEventMap();

    for (auto const& eventEntry : events)
    {
        if (eventEntry.holiday_id == holidayId)
        {
            return eventEntry.eventId;
        }
    }

    return 0;
}

bool IsHolidayActive(HolidayIds id)
{
    if (id == HOLIDAY_NONE)
        return false;

    GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
    GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();

    for (GameEventMgr::ActiveEvents::const_iterator itr = ae.begin(); itr != ae.end(); ++itr)
        if (events[*itr].holiday_id == id)
            return true;

    return false;
}

bool IsEventActive(uint16 event_id)
{
    GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
    return ae.find(event_id) != ae.end();
}
