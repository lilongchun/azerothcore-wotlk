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

#ifndef ACORE_GAMEEVENT_MGR_H
#define ACORE_GAMEEVENT_MGR_H

#include "Common.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include <map>

#define max_ge_check_delay DAY  // 1 day in seconds

enum GameEventState
{
    GAMEEVENT_NORMAL = 0,   // standard game events
    GAMEEVENT_WORLD_INACTIVE = 1,   // not yet started
    GAMEEVENT_WORLD_CONDITIONS = 2,  // condition matching phase
    GAMEEVENT_WORLD_NEXTPHASE = 3,   // conditions are met, now 'length' timer to start next event
    GAMEEVENT_WORLD_FINISHED = 4,    // next events are started, unapply this one
    GAMEEVENT_INTERNAL = 5, // never handled in update
};

struct GameEventFinishCondition
{
    float reqNum;  // required number // use float, since some events use percent
    float done;    // done number
    uint32 max_world_state;  // max resource count world state update id
    uint32 done_world_state; // done resource count world state update id
};

struct GameEventQuestToEventConditionNum
{
    uint16 event_id;
    uint32 condition;
    float num;
};

typedef std::map<uint32 /*condition id*/, GameEventFinishCondition> GameEventConditionMap;

struct GameEventData
{
    GameEventData()  = default;
    uint32 eventId;
    time_t start{1};           // occurs after this time
    time_t end{0};             // occurs before this time
    time_t nextstart{0};       // after this time the follow-up events count this phase completed
    uint32 occurence{0};       // time between end and start
    uint32 length{0};          // length of the event (minutes) after finishing all conditions
    HolidayIds holiday_id{HOLIDAY_NONE};
    uint8 holidayStage;
    GameEventState state{GAMEEVENT_NORMAL};   // state of the game event, these are saved into the game_event table on change!
    GameEventConditionMap conditions;  // conditions to finish
    std::set<uint16 /*gameevent id*/> prerequisite_events;  // events that must be completed before starting this event
    std::string description;
    uint8 announce;         // if 0 dont announce, if 1 announce, if 2 take config value

    [[nodiscard]] auto isValid() const -> bool { return length > 0 || state > GAMEEVENT_NORMAL; }
};

struct ModelEquip
{
    uint32 modelid;
    uint32 modelid_prev;
    uint8 equipment_id;
    uint8 equipement_id_prev;
};

struct NPCVendorEntry
{
    uint32 entry;                                           // creature entry
    uint32 item;                                            // item id
    int32  maxcount;                                        // 0 for infinite
    uint32 incrtime;                                        // time for restore items amount if maxcount != 0
    uint32 ExtendedCost;
};

class Player;
class Creature;
class Quest;

class GameEventMgr
{
private:
    GameEventMgr();
    ~GameEventMgr() = default;

public:
    static auto instance() -> GameEventMgr*;

    typedef std::set<uint16> ActiveEvents;
    typedef std::vector<GameEventData> GameEventDataMap;
    [[nodiscard]] auto GetActiveEventList() const -> ActiveEvents const& { return m_ActiveEvents; }
    [[nodiscard]] auto GetEventMap() const -> GameEventDataMap const& { return mGameEvent; }
    [[nodiscard]] auto CheckOneGameEvent(uint16 entry) const -> bool;
    [[nodiscard]] auto NextCheck(uint16 entry) const -> uint32;
    void LoadFromDB();
    void LoadHolidayDates();
    auto Update() -> uint32;
    auto IsActiveEvent(uint16 event_id) -> bool { return (m_ActiveEvents.find(event_id) != m_ActiveEvents.end()); }
    auto StartSystem() -> uint32;
    void Initialize();
    void StartArenaSeason();
    void StartInternalEvent(uint16 event_id);
    auto StartEvent(uint16 event_id, bool overwrite = false) -> bool;
    void StopEvent(uint16 event_id, bool overwrite = false);
    void HandleQuestComplete(uint32 quest_id);  // called on world event type quest completions
    auto GetNPCFlag(Creature* cr) -> uint32;
    [[nodiscard]] auto GetHolidayEventId(uint32 holidayId) const -> uint32;
private:
    void SendWorldStateUpdate(Player* player, uint16 event_id);
    void AddActiveEvent(uint16 event_id) { m_ActiveEvents.insert(event_id); }
    void RemoveActiveEvent(uint16 event_id) { m_ActiveEvents.erase(event_id); }
    void ApplyNewEvent(uint16 event_id);
    void UnApplyEvent(uint16 event_id);
    void GameEventSpawn(int16 event_id);
    void GameEventUnspawn(int16 event_id);
    void ChangeEquipOrModel(int16 event_id, bool activate);
    void UpdateEventQuests(uint16 event_id, bool activate);
    void UpdateWorldStates(uint16 event_id, bool Activate);
    void UpdateEventNPCFlags(uint16 event_id);
    void UpdateEventNPCVendor(uint16 event_id, bool activate);
    void UpdateBattlegroundSettings();
    void RunSmartAIScripts(uint16 event_id, bool activate);    //! Runs SMART_EVENT_GAME_EVENT_START/_END SAI
    auto CheckOneGameEventConditions(uint16 event_id) -> bool;
    void SaveWorldEventStateToDB(uint16 event_id);
    auto hasCreatureQuestActiveEventExcept(uint32 quest_id, uint16 event_id) -> bool;
    auto hasGameObjectQuestActiveEventExcept(uint32 quest_id, uint16 event_id) -> bool;
    auto hasCreatureActiveEventExcept(ObjectGuid::LowType creature_guid, uint16 event_id) -> bool;
    auto hasGameObjectActiveEventExcept(ObjectGuid::LowType go_guid, uint16 event_id) -> bool;
    void SetHolidayEventTime(GameEventData& event);

    typedef std::list<ObjectGuid::LowType> GuidLowList;
    typedef std::list<uint32> IdList;
    typedef std::vector<GuidLowList> GameEventGuidMap;
    typedef std::vector<IdList> GameEventIdMap;
    typedef std::pair<ObjectGuid::LowType, ModelEquip> ModelEquipPair;
    typedef std::list<ModelEquipPair> ModelEquipList;
    typedef std::vector<ModelEquipList> GameEventModelEquipMap;
    typedef std::pair<uint32, uint32> QuestRelation;
    typedef std::list<QuestRelation> QuestRelList;
    typedef std::vector<QuestRelList> GameEventQuestMap;
    typedef std::list<NPCVendorEntry> NPCVendorList;
    typedef std::vector<NPCVendorList> GameEventNPCVendorMap;
    typedef std::map<uint32 /*quest id*/, GameEventQuestToEventConditionNum> QuestIdToEventConditionMap;
    typedef std::pair<ObjectGuid::LowType /*guid*/, uint32 /*npcflag*/> GuidNPCFlagPair;
    typedef std::list<GuidNPCFlagPair> NPCFlagList;
    typedef std::vector<NPCFlagList> GameEventNPCFlagMap;
    typedef std::vector<uint32> GameEventBitmask;
    GameEventQuestMap mGameEventCreatureQuests;
    GameEventQuestMap mGameEventGameObjectQuests;
    GameEventNPCVendorMap mGameEventVendors;
    GameEventModelEquipMap mGameEventModelEquip;
    //GameEventGuidMap  mGameEventCreatureGuids;
    //GameEventGuidMap  mGameEventGameobjectGuids;
    GameEventIdMap    mGameEventPoolIds;
    GameEventDataMap  mGameEvent;
    GameEventBitmask  mGameEventBattlegroundHolidays;
    QuestIdToEventConditionMap mQuestToEventConditions;
    GameEventNPCFlagMap mGameEventNPCFlags;
    ActiveEvents m_ActiveEvents;
    bool isSystemInit;
public:
    GameEventGuidMap  mGameEventCreatureGuids;
    GameEventGuidMap  mGameEventGameobjectGuids;
    std::vector<uint32> modifiedHolidays;
};

#define sGameEventMgr GameEventMgr::instance()

auto IsHolidayActive(HolidayIds id) -> bool;
auto IsEventActive(uint16 event_id) -> bool;

#endif
