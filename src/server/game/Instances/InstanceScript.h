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

#ifndef ACORE_INSTANCE_DATA_H
#define ACORE_INSTANCE_DATA_H

#include "CreatureAI.h"
#include "ObjectMgr.h"
#include "TaskScheduler.h"
#include "World.h"
#include "ZoneScript.h"
#include "ChallengeModeCriteria.h"
#include <set>

#define OUT_SAVE_INST_DATA             LOG_DEBUG("scripts.ai", "Saving Instance Data for Instance {} (Map {}, Instance Id {})", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_SAVE_INST_DATA_COMPLETE    LOG_DEBUG("scripts.ai", "Saving Instance Data for Instance {} (Map {}, Instance Id {}) completed.", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_LOAD_INST_DATA(a)          LOG_DEBUG("scripts.ai", "Loading Instance Data for Instance {} (Map {}, Instance Id {}). Input is '{}'", instance->GetMapName(), instance->GetId(), instance->GetInstanceId(), a)
#define OUT_LOAD_INST_DATA_COMPLETE    LOG_DEBUG("scripts.ai", "Instance Data Load for Instance {} (Map {}, Instance Id: {}) is complete.", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_LOAD_INST_DATA_FAIL        LOG_ERROR("scripts.ai", "Unable to load Instance Data for Instance {} (Map {}, Instance Id: {}).", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())

class Map;
class Unit;
class Player;
class GameObject;
class Creature;

typedef std::set<GameObject*> DoorSet;
typedef std::set<Creature*> MinionSet;

enum EncounterFrameType
{
    ENCOUNTER_FRAME_ENGAGE              = 0,
    ENCOUNTER_FRAME_DISENGAGE           = 1,
    ENCOUNTER_FRAME_UPDATE_PRIORITY     = 2,
    ENCOUNTER_FRAME_ADD_TIMER           = 3,
    ENCOUNTER_FRAME_ENABLE_OBJECTIVE    = 4,
    ENCOUNTER_FRAME_UPDATE_OBJECTIVE    = 5,
    ENCOUNTER_FRAME_DISABLE_OBJECTIVE   = 6,
    ENCOUNTER_FRAME_REFRESH_FRAMES      = 7,    // Xinef: can be used to refresh frames after unit was destroyed from client and send back (phase changes)
};

enum EncounterState
{
    NOT_STARTED   = 0,
    IN_PROGRESS   = 1,
    FAIL          = 2,
    DONE          = 3,
    SPECIAL       = 4,
    TO_BE_DECIDED = 5,
};

enum DoorType
{
    DOOR_TYPE_ROOM          = 0,    // Door can open if encounter is not in progress
    DOOR_TYPE_PASSAGE       = 1,    // Door can open if encounter is done
    DOOR_TYPE_SPAWN_HOLE    = 2,    // Door can open if encounter is in progress, typically used for spawning places
    MAX_DOOR_TYPES,
};

enum ChallengeMode
{
    GOB_CHALLENGER_DOOR = 239408,

    SPELL_CHALLENGER_MIGHT = 100101,
    SPELL_CHALLENGER_BURDEN = 100102
};

struct DoorData
{
    uint32 entry, bossId;
    DoorType type;
};

struct BossBoundaryEntry
{
    uint32 const bossId;
    AreaBoundary const* const boundary;
};

struct BossBoundaryData
{
    typedef std::vector<BossBoundaryEntry> StorageType;
    typedef StorageType::const_iterator const_iterator;

    BossBoundaryData(std::initializer_list<BossBoundaryEntry> data) : _data(data) { }
    ~BossBoundaryData();
    const_iterator begin() const { return _data.begin(); }
    const_iterator end() const { return _data.end(); }

private:
    StorageType _data;
};

struct MinionData
{
    uint32 entry, bossId;
};

struct ObjectData
{
    uint32 entry;
    uint32 type;
};

struct BossInfo
{
    BossInfo() : state(TO_BE_DECIDED) {}
    EncounterState state;
    DoorSet door[MAX_DOOR_TYPES];
    MinionSet minion;
    CreatureBoundary boundary;
};

struct DoorInfo
{
    explicit DoorInfo(BossInfo* _bossInfo, DoorType _type)
            : bossInfo(_bossInfo), type(_type) { }
    BossInfo* bossInfo;
    DoorType type;
};

struct MinionInfo
{
    explicit MinionInfo(BossInfo* _bossInfo) : bossInfo(_bossInfo) {}
    BossInfo* bossInfo;
};

typedef std::multimap<uint32 /*entry*/, DoorInfo> DoorInfoMap;
typedef std::pair<DoorInfoMap::const_iterator, DoorInfoMap::const_iterator> DoorInfoMapBounds;

typedef std::map<uint32 /*entry*/, MinionInfo> MinionInfoMap;
typedef std::map<uint32 /*type*/, ObjectGuid /*guid*/> ObjectGuidMap;
typedef std::map<uint32 /*entry*/, uint32 /*type*/> ObjectInfoMap;

class InstanceScript : public ZoneScript
{
public:
    InstanceScript(Map* map) : instance(map), completedEncounters(0), _entranceId(0), _temporaryEntranceId(0),
        _challengeModeStarted(false), _challengeModeLevel(0), _challengeModeStartTime(0), _challengeModeDeathCount(0) {}

    ~InstanceScript() override {}

    Map* instance;
    Position _challengeEntranceLoc;

    //On creation, NOT load.
    virtual void Initialize() {}

    // On load
    virtual void Load(char const* data);

    //Called when creature is Looted
    virtual void CreatureLooted(Creature* /*creature*/, LootType) {}

    // When save is needed, this function generates the data
    virtual std::string GetSaveData();

    void SaveToDB();

    virtual void Update(uint32 /*diff*/);

    //Used by the map's CanEnter function.
    //This is to prevent players from entering during boss encounters.
    virtual bool IsEncounterInProgress() const;

    // Called when a creature/gameobject is added to map or removed from map.
    // Insert/Remove objectguid to dynamic guid store
    void OnCreatureCreate(Creature* creature) override;
    void OnCreatureRemove(Creature* creature) override;

    void OnGameObjectCreate(GameObject* go) override;
    void OnGameObjectRemove(GameObject* go) override;

    ObjectGuid GetObjectGuid(uint32 type) const;
    ObjectGuid GetGuidData(uint32 type) const override;

    Creature* GetCreature(uint32 type);
    GameObject* GetGameObject(uint32 type);

    //Called when a player successfully enters the instance.
    void OnPlayerEnter(Player* /*player*/) override;
    void OnPlayerExit(Player*) override;
    void OnPlayerDeath(Player*) override;

    virtual void OnPlayerAreaUpdate(Player* /*player*/, uint32 /*oldArea*/, uint32 /*newArea*/) {}

    //Handle open / close objects
    //use HandleGameObject(ObjectGuid::Empty, boolen, GO); in OnObjectCreate in instance scripts
    //use HandleGameObject(GUID, boolen, nullptr); in any other script
    void HandleGameObject(ObjectGuid guid, bool open, GameObject* go = nullptr);

    void UpdateOperations(uint32 const diff);

    //change active state of doors or buttons
    void DoUseDoorOrButton(ObjectGuid guid, uint32 withRestoreTime = 0, bool useAlternativeState = false);

    //Respawns a GO having negative spawntimesecs in gameobject-table
    void DoRespawnGameObject(ObjectGuid guid, uint32 timeToDespawn = MINUTE);

    // Respawns a creature.
    void DoRespawnCreature(ObjectGuid guid, bool force = false);

    // Respawns a creature from the creature object storage.
    void DoRespawnCreature(uint32 type, bool force = false);

    //sends world state update to all players in instance
    void DoUpdateWorldState(uint32 worldstateId, uint32 worldstateValue);

    // Send Notify to all players in instance
    void DoSendNotifyToInstance(char const* format, ...);

    // Update Achievement Criteria for all players in instance
    void DoUpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0, Unit* unit = nullptr);

    // Start/Stop Timed Achievement Criteria for all players in instance
    void DoStartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);
    void DoStopTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);

    // Remove Auras due to Spell on all players in instance
    void DoRemoveAurasDueToSpellOnPlayers(uint32 spell);

    // Cast spell on all players in instance
    void DoCastSpellOnPlayers(uint32 spell, Unit* caster = nullptr, bool triggered = true);

    // hater: m+
    void DoOnPlayers(std::function<void(Player*)>&& function);
    void DoNearTeleportPlayers(const Position pos, bool casting = false);

    // Cast spell on player
    void DoCastSpellOnPlayer(Player* player, uint32 spell, bool includePets = false, bool includeControlled = false);

    // Return wether server allow two side groups or not
    bool ServerAllowsTwoSideGroups() { return sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP); }

    virtual bool SetBossState(uint32 id, EncounterState state);
    EncounterState GetBossState(uint32 id) const { return id < bosses.size() ? bosses[id].state : TO_BE_DECIDED; }
    static std::string GetBossStateName(uint8 state);
    CreatureBoundary const* GetBossBoundary(uint32 id) const { return id < bosses.size() ? &bosses[id].boundary : nullptr; }
    BossInfo const* GetBossInfo(uint32 id) const { return &bosses[id]; }

    uint32 GetPersistentData(uint32 index) const { return index < persistentData.size() ? persistentData[index] : 0; };
    void StorePersistentData(uint32 index, uint32 data);

    // Achievement criteria additional requirements check
    // NOTE: not use this if same can be checked existed requirement types from AchievementCriteriaRequirementType
    virtual bool CheckAchievementCriteriaMeet(uint32 /*criteria_id*/, Player const* /*source*/, Unit const* /*target*/ = nullptr, uint32 /*miscvalue1*/ = 0);

    // Checks boss requirements (one boss required to kill other)
    virtual bool CheckRequiredBosses(uint32 /*bossId*/, Player const* /*player*/ = nullptr) const { return true; }

    void SetCompletedEncountersMask(uint32 newMask, bool save);

    // Returns completed encounters mask for packets
    uint32 GetCompletedEncounterMask() const { return completedEncounters; }

    void SendEncounterUnit(uint32 type, Unit* unit = nullptr, uint8 param1 = 0, uint8 param2 = 0);

    virtual void FillInitialWorldStates(WorldPacket& /*data*/) {}

    uint32 GetEncounterCount() const { return bosses.size(); }

    // Sets the entrance location (WorldSafeLoc) id
    void SetEntranceLocation(uint32 worldSafeLocationId);

    // Sets a temporary entrance that does not get saved to db
    void SetTemporaryEntranceLocation(uint32 worldSafeLocationId) { _temporaryEntranceId = worldSafeLocationId; }

    // Get's the current entrance id
    uint32 GetEntranceLocation() const { uint32 locationId = _temporaryEntranceId ? _temporaryEntranceId : _entranceId; OnGetEntranceLocation(locationId); return locationId; }

    virtual void OnGetEntranceLocation(uint32& /*worldSafeLocationId*/) const { }

    void AddTimedDelayedOperation(uint32 timeout, std::function<void()>&& function)
    {
        emptyWarned = false;
        timedDelayedOperations.push_back(std::pair<uint32, std::function<void()>>(timeout, function));
    }

    /// Called after last delayed operation was deleted
    /// Do whatever you want
    virtual void LastOperationCalled() { }

    std::vector<std::pair<int32, std::function<void()>>>    timedDelayedOperations;   ///< Delayed operations
    bool                                                    emptyWarned;              ///< Warning when there are no more delayed operations

    // Only used by areatriggers that inherit from OnlyOnceAreaTriggerScript
    void MarkAreaTriggerDone(uint32 id) { _activatedAreaTriggers.insert(id); }
    void ResetAreaTriggerDone(uint32 id) { _activatedAreaTriggers.erase(id); }
    bool IsAreaTriggerDone(uint32 id) const { return _activatedAreaTriggers.find(id) != _activatedAreaTriggers.end(); }

    // Allows to perform particular actions
    virtual void DoAction(int32 /*action*/) {}

    // Allows executing code using all creatures registered in the instance script as minions
    void DoForAllMinions(uint32 id, std::function<void(Creature*)> exec);

    // hater: Challenge Modes
    void StartChallengeMode(Player* player, KeyInfo* key, uint8 level, uint32 affixOne, uint32 affixTwo = 0, uint32 affixThree = 0);
    void CompleteChallengeMode(Position);

    bool IsChallengeModeStarted() const { return _challengeModeStarted; }
    uint8 GetChallengeModeLevel() const { return _challengeModeLevel; }
    uint32 GetChallengeModeCurrentDuration();

    void SendChallengeModeStart(Player* player = nullptr);
    void SendChallengeModeDeathCount(Player* player = nullptr);
    void SendChallengeModeElapsedTimer(Player* player = nullptr);
    void SendChallengeModeCriteria(Player* player = nullptr);
    void CastChallengeCreatureSpell(Creature* creature);
    void CastChallengePlayerSpell(Player* player);

    void SetChallengeDoorPos(Position pos) { _challengeModeDoorPosition = pos; }
    void SpawnChallengeModeRewardChest(Position);

    ChallengeModeCriteria* GetCriteria() {
        return _challengeModeCriteria;
    }

    TaskScheduler scheduler;
protected:
    void SetHeaders(std::string const& dataHeaders);
    void SetBossNumber(uint32 number) { bosses.resize(number); }
    void SetPersistentDataCount(uint32 number) { persistentData.resize(number); }
    void LoadBossBoundaries(BossBoundaryData const& data);
    void LoadDoorData(DoorData const* data);
    void LoadMinionData(MinionData const* data);
    void LoadObjectData(ObjectData const* creatureData, ObjectData const* gameObjectData);

    void AddObject(Creature* obj, bool add);
    void AddObject(GameObject* obj, bool add);
    void AddObject(WorldObject* obj, uint32 type, bool add);

    void AddDoor(GameObject* door, bool add);
    void AddMinion(Creature* minion, bool add);

    void UpdateDoorState(GameObject* door);
    void UpdateMinionState(Creature* minion, EncounterState state);

    // Instance Load and Save
    bool ReadSaveDataHeaders(std::istringstream& data);
    void ReadSaveDataBossStates(std::istringstream& data);
    void ReadSavePersistentData(std::istringstream& data);
    virtual void ReadSaveDataMore(std::istringstream& /*data*/) { }
    void WriteSaveDataHeaders(std::ostringstream& data);
    void WriteSaveDataBossStates(std::ostringstream& data);
    void WritePersistentData(std::ostringstream& data);
    virtual void WriteSaveDataMore(std::ostringstream& /*data*/) { }

private:
    static void LoadObjectData(ObjectData const* creatureData, ObjectInfoMap& objectInfo);

    std::vector<char> headers;
    std::vector<BossInfo> bosses;
    std::vector<uint32> persistentData;
    DoorInfoMap doors;
    MinionInfoMap minions;
    ObjectInfoMap _creatureInfo;
    ObjectInfoMap _gameObjectInfo;
    ObjectGuidMap _objectGuids;
    uint32 completedEncounters; // completed encounter mask, bit indexes are DungeonEncounter.dbc boss numbers, used for packets
    std::unordered_set<uint32> _activatedAreaTriggers;
    uint32 _entranceId;
    uint32 _temporaryEntranceId;

    bool _challengeModeStarted;
    uint8 _challengeModeLevel = 1;
    uint32 _challengeModeStartTime;
    uint32 _challengeModeDeathCount;
    Optional<Position> _challengeModeDoorPosition;
    ChallengeModeCriteria* _challengeModeCriteria;
    Player* _challengeOwner;
    KeyInfo* _challengeKey;
    uint32 _challengeModeTimerMax;

    uint32 tierOneAffix;
    uint32 tierTwoAffix = 0;
    uint32 tierThreeAffix = 0;
};

#endif
