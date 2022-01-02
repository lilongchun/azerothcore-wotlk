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

#ifndef _OBJECTMGR_H
#define _OBJECTMGR_H

#include "Bag.h"
#include "ConditionMgr.h"
#include "Corpse.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "ItemTemplate.h"
#include "Log.h"
#include "Mail.h"
#include "Map.h"
#include "NPCHandler.h"
#include "Object.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include "QuestDef.h"
#include "TemporarySummon.h"
#include "VehicleDefines.h"
#include <functional>
#include <limits>
#include <map>
#include <string>

class Item;
struct DungeonProgressionRequirements;
struct PlayerClassInfo;
struct PlayerClassLevelInfo;
struct PlayerInfo;
struct PlayerLevelInfo;

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

struct PageText
{
    std::string Text;
    uint16 NextPage;
};

/// Key for storing temp summon data in TempSummonDataContainer
struct TempSummonGroupKey
{
    TempSummonGroupKey(uint32 summonerEntry, SummonerType summonerType, uint8 group)
        : _summonerEntry(summonerEntry), _summonerType(summonerType), _summonGroup(group)
    {
    }

    auto operator<(TempSummonGroupKey const& rhs) const -> bool
    {
        return std::tie(_summonerEntry, _summonerType, _summonGroup) <
               std::tie(rhs._summonerEntry, rhs._summonerType, rhs._summonGroup);
    }

private:
    uint32 _summonerEntry;      ///< Summoner's entry
    SummonerType _summonerType; ///< Summoner's type, see SummonerType for available types
    uint8 _summonGroup;         ///< Summon's group id
};

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// DB scripting commands
enum ScriptCommands
{
    SCRIPT_COMMAND_TALK                  = 0,                // source/target = Creature, target = any, datalong = talk type (0=say, 1=whisper, 2=yell, 3=emote text, 4=boss emote text), datalong2 & 1 = player talk (instead of creature), dataint = string_id
    SCRIPT_COMMAND_EMOTE                 = 1,                // source/target = Creature, datalong = emote id, datalong2 = 0: set emote state; > 0: play emote state
    SCRIPT_COMMAND_FIELD_SET             = 2,                // source/target = Creature, datalong = field id, datalog2 = value
    SCRIPT_COMMAND_MOVE_TO               = 3,                // source/target = Creature, datalong2 = time to reach, x/y/z = destination
    SCRIPT_COMMAND_FLAG_SET              = 4,                // source/target = Creature, datalong = field id, datalog2 = bitmask
    SCRIPT_COMMAND_FLAG_REMOVE           = 5,                // source/target = Creature, datalong = field id, datalog2 = bitmask
    SCRIPT_COMMAND_TELEPORT_TO           = 6,                // source/target = Creature/Player (see datalong2), datalong = map_id, datalong2 = 0: Player; 1: Creature, x/y/z = destination, o = orientation
    SCRIPT_COMMAND_QUEST_EXPLORED        = 7,                // target/source = Player, target/source = GO/Creature, datalong = quest id, datalong2 = distance or 0
    SCRIPT_COMMAND_KILL_CREDIT           = 8,                // target/source = Player, datalong = creature entry, datalong2 = 0: personal credit, 1: group credit
    SCRIPT_COMMAND_RESPAWN_GAMEOBJECT    = 9,                // source = WorldObject (summoner), datalong = GO guid, datalong2 = despawn delay
    SCRIPT_COMMAND_TEMP_SUMMON_CREATURE  = 10,               // source = WorldObject (summoner), datalong = creature entry, datalong2 = despawn delay, x/y/z = summon position, o = orientation
    SCRIPT_COMMAND_OPEN_DOOR             = 11,               // source = Unit, datalong = GO guid, datalong2 = reset delay (min 15)
    SCRIPT_COMMAND_CLOSE_DOOR            = 12,               // source = Unit, datalong = GO guid, datalong2 = reset delay (min 15)
    SCRIPT_COMMAND_ACTIVATE_OBJECT       = 13,               // source = Unit, target = GO
    SCRIPT_COMMAND_REMOVE_AURA           = 14,               // source (datalong2 != 0) or target (datalong2 == 0) = Unit, datalong = spell id
    SCRIPT_COMMAND_CAST_SPELL            = 15,               // source and/or target = Unit, datalong2 = cast direction (0: s->t 1: s->s 2: t->t 3: t->s 4: s->creature with dataint entry), dataint & 1 = triggered flag
    SCRIPT_COMMAND_PLAY_SOUND            = 16,               // source = WorldObject, target = none/Player, datalong = sound id, datalong2 (bitmask: 0/1=anyone/player, 0/2=without/with distance dependency, so 1|2 = 3 is target with distance dependency)
    SCRIPT_COMMAND_CREATE_ITEM           = 17,               // target/source = Player, datalong = item entry, datalong2 = amount
    SCRIPT_COMMAND_DESPAWN_SELF          = 18,               // target/source = Creature, datalong = despawn delay

    SCRIPT_COMMAND_LOAD_PATH             = 20,               // source = Unit, datalong = path id, datalong2 = is repeatable
    SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT    = 21,               // source = WorldObject (if present used as a search center), datalong = script id, datalong2 = unit lowguid, dataint = script table to use (see ScriptsType)
    SCRIPT_COMMAND_KILL                  = 22,               // source/target = Creature, dataint = remove corpse attribute

    // AzerothCore only
    SCRIPT_COMMAND_ORIENTATION           = 30,               // source = Unit, target (datalong > 0) = Unit, datalong = > 0 turn source to face target, o = orientation
    SCRIPT_COMMAND_EQUIP                 = 31,               // soucre = Creature, datalong = equipment id
    SCRIPT_COMMAND_MODEL                 = 32,               // source = Creature, datalong = model id
    SCRIPT_COMMAND_CLOSE_GOSSIP          = 33,               // source = Player
    SCRIPT_COMMAND_PLAYMOVIE             = 34,               // source = Player, datalong = movie id
    SCRIPT_COMMAND_MOVEMENT              = 35                // soucre = Creature, datalong = MovementType, datalong2 = MovementDistance (wander_distance f.ex.), dataint = pathid
};

// Benchmarked: Faster than std::unordered_map (insert/find)
typedef std::map<uint32, PageText> PageTextContainer;

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint16, InstanceTemplate> InstanceTemplateContainer;

struct GameTele
{
    float  position_x;
    float  position_y;
    float  position_z;
    float  orientation;
    uint32 mapId;
    std::string name;
    std::wstring wnameLow;
};

typedef std::unordered_map<uint32, GameTele > GameTeleContainer;

enum ScriptsType
{
    SCRIPTS_FIRST = 1,

    SCRIPTS_SPELL = SCRIPTS_FIRST,
    SCRIPTS_EVENT,
    SCRIPTS_WAYPOINT,

    SCRIPTS_LAST
};

enum eScriptFlags
{
    // Talk Flags
    SF_TALK_USE_PLAYER          = 0x1,

    // Emote flags
    SF_EMOTE_USE_STATE          = 0x1,

    // TeleportTo flags
    SF_TELEPORT_USE_CREATURE    = 0x1,

    // KillCredit flags
    SF_KILLCREDIT_REWARD_GROUP  = 0x1,

    // RemoveAura flags
    SF_REMOVEAURA_REVERSE       = 0x1,

    // CastSpell flags
    SF_CASTSPELL_SOURCE_TO_TARGET = 0,
    SF_CASTSPELL_SOURCE_TO_SOURCE = 1,
    SF_CASTSPELL_TARGET_TO_TARGET = 2,
    SF_CASTSPELL_TARGET_TO_SOURCE = 3,
    SF_CASTSPELL_SEARCH_CREATURE  = 4,
    SF_CASTSPELL_TRIGGERED      = 0x1,

    // PlaySound flags
    SF_PLAYSOUND_TARGET_PLAYER  = 0x1,
    SF_PLAYSOUND_DISTANCE_SOUND = 0x2,

    // Orientation flags
    SF_ORIENTATION_FACE_TARGET  = 0x1,
};

struct ScriptInfo
{
    ScriptsType type;
    uint32 id;
    uint32 delay;
    ScriptCommands command;

    union
    {
        struct
        {
            uint32 nData[3];
            float  fData[4];
        } Raw;

        struct                      // SCRIPT_COMMAND_TALK (0)
        {
            uint32 ChatType;        // datalong
            uint32 Flags;           // datalong2
            int32  TextID;          // dataint
        } Talk;

        struct                      // SCRIPT_COMMAND_EMOTE (1)
        {
            uint32 EmoteID;         // datalong
            uint32 Flags;           // datalong2
        } Emote;

        struct                      // SCRIPT_COMMAND_FIELD_SET (2)
        {
            uint32 FieldID;         // datalong
            uint32 FieldValue;      // datalong2
        } FieldSet;

        struct                      // SCRIPT_COMMAND_MOVE_TO (3)
        {
            uint32 Unused1;         // datalong
            uint32 TravelTime;      // datalong2
            int32  Unused2;         // dataint

            float DestX;
            float DestY;
            float DestZ;
        } MoveTo;

        struct                      // SCRIPT_COMMAND_FLAG_SET (4)
        // SCRIPT_COMMAND_FLAG_REMOVE (5)
        {
            uint32 FieldID;         // datalong
            uint32 FieldValue;      // datalong2
        } FlagToggle;

        struct                      // SCRIPT_COMMAND_TELEPORT_TO (6)
        {
            uint32 MapID;           // datalong
            uint32 Flags;           // datalong2
            int32  Unused1;         // dataint

            float DestX;
            float DestY;
            float DestZ;
            float Orientation;
        } TeleportTo;

        struct                      // SCRIPT_COMMAND_QUEST_EXPLORED (7)
        {
            uint32 QuestID;         // datalong
            uint32 Distance;        // datalong2
        } QuestExplored;

        struct                      // SCRIPT_COMMAND_KILL_CREDIT (8)
        {
            uint32 CreatureEntry;   // datalong
            uint32 Flags;           // datalong2
        } KillCredit;

        struct                      // SCRIPT_COMMAND_RESPAWN_GAMEOBJECT (9)
        {
            uint32 GOGuid;          // datalong
            uint32 DespawnDelay;    // datalong2
        } RespawnGameobject;

        struct                      // SCRIPT_COMMAND_TEMP_SUMMON_CREATURE (10)
        {
            uint32 CreatureEntry;   // datalong
            uint32 DespawnDelay;    // datalong2
            uint32 CheckIfExists;   // dataint

            float PosX;
            float PosY;
            float PosZ;
            float Orientation;
        } TempSummonCreature;

        struct                      // SCRIPT_COMMAND_CLOSE_DOOR (12)
        // SCRIPT_COMMAND_OPEN_DOOR (11)
        {
            uint32 GOGuid;          // datalong
            uint32 ResetDelay;      // datalong2
        } ToggleDoor;

        // SCRIPT_COMMAND_ACTIVATE_OBJECT (13)

        struct                      // SCRIPT_COMMAND_REMOVE_AURA (14)
        {
            uint32 SpellID;         // datalong
            uint32 Flags;           // datalong2
        } RemoveAura;

        struct                      // SCRIPT_COMMAND_CAST_SPELL (15)
        {
            uint32 SpellID;         // datalong
            uint32 Flags;           // datalong2
            int32  CreatureEntry;   // dataint

            float SearchRadius;
        } CastSpell;

        struct                      // SCRIPT_COMMAND_PLAY_SOUND (16)
        {
            uint32 SoundID;         // datalong
            uint32 Flags;           // datalong2
        } PlaySound;

        struct                      // SCRIPT_COMMAND_CREATE_ITEM (17)
        {
            uint32 ItemEntry;       // datalong
            uint32 Amount;          // datalong2
        } CreateItem;

        struct                      // SCRIPT_COMMAND_DESPAWN_SELF (18)
        {
            uint32 DespawnDelay;    // datalong
        } DespawnSelf;

        struct                      // SCRIPT_COMMAND_LOAD_PATH (20)
        {
            uint32 PathID;          // datalong
            uint32 IsRepeatable;    // datalong2
        } LoadPath;

        struct                      // SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT (21)
        {
            uint32 CreatureEntry;   // datalong
            uint32 ScriptID;        // datalong2
            uint32 ScriptType;      // dataint
        } CallScript;

        struct                      // SCRIPT_COMMAND_KILL (22)
        {
            uint32 Unused1;         // datalong
            uint32 Unused2;         // datalong2
            int32  RemoveCorpse;    // dataint
        } Kill;

        struct                      // SCRIPT_COMMAND_ORIENTATION (30)
        {
            uint32 Flags;           // datalong
            uint32 Unused1;         // datalong2
            int32  Unused2;         // dataint

            float Unused3;
            float Unused4;
            float Unused5;
            float Orientation;
        } Orientation;

        struct                      // SCRIPT_COMMAND_EQUIP (31)
        {
            uint32 EquipmentID;     // datalong
        } Equip;

        struct                      // SCRIPT_COMMAND_MODEL (32)
        {
            uint32 ModelID;         // datalong
        } Model;

        // SCRIPT_COMMAND_CLOSE_GOSSIP (33)

        struct                      // SCRIPT_COMMAND_PLAYMOVIE (34)
        {
            uint32 MovieID;         // datalong
        } PlayMovie;

        struct                       // SCRIPT_COMMAND_MOVEMENT (35)
        {
            uint32 MovementType;     // datalong
            uint32 MovementDistance; // datalong2
            int32  Path;             // dataint
        } Movement;
    };

    [[nodiscard]] auto GetDebugInfo() const -> std::string;
};

typedef std::multimap<uint32, ScriptInfo> ScriptMap;
typedef std::map<uint32, ScriptMap > ScriptMapMap;
typedef std::multimap<uint32, uint32> SpellScriptsContainer;
typedef std::pair<SpellScriptsContainer::iterator, SpellScriptsContainer::iterator> SpellScriptsBounds;
extern ScriptMapMap sSpellScripts;
extern ScriptMapMap sEventScripts;
extern ScriptMapMap sWaypointScripts;

auto GetScriptsTableNameByType(ScriptsType type) -> std::string;
auto GetScriptsMapByType(ScriptsType type) -> ScriptMapMap*;
auto GetScriptCommandName(ScriptCommands command) -> std::string;

struct SpellClickInfo
{
    uint32 spellId;
    uint8 castFlags;
    SpellClickUserTypes userType;

    // helpers
    auto IsFitToRequirements(Unit const* clicker, Unit const* clickee) const -> bool;
};

typedef std::multimap<uint32, SpellClickInfo> SpellClickInfoContainer;
typedef std::pair<SpellClickInfoContainer::const_iterator, SpellClickInfoContainer::const_iterator> SpellClickInfoMapBounds;

struct AreaTriggerTeleport
{
    uint32 target_mapId;
    float  target_X;
    float  target_Y;
    float  target_Z;
    float  target_Orientation;
};

struct AreaTrigger
{
    uint32 entry;
    uint32 map;
    float x;
    float y;
    float z;
    float radius;
    float length;
    float width;
    float height;
    float orientation;
};

struct BroadcastText
{
    BroadcastText()
    {
        MaleText.resize(DEFAULT_LOCALE + 1);
        FemaleText.resize(DEFAULT_LOCALE + 1);
    }

    uint32 Id{0};
    uint32 LanguageID{0};
    std::vector<std::string> MaleText;
    std::vector<std::string> FemaleText;
    uint32 EmoteId0{0};
    uint32 EmoteId1{0};
    uint32 EmoteId2{0};
    uint32 EmoteDelay0{0};
    uint32 EmoteDelay1{0};
    uint32 EmoteDelay2{0};
    uint32 SoundId{0};
    uint32 Unk1{0};
    uint32 Unk2{0};
    // uint32 VerifiedBuild;

    [[nodiscard]] auto GetText(LocaleConstant locale = DEFAULT_LOCALE, uint8 gender = GENDER_MALE, bool forceGender = false) const -> std::string const&
    {
        if (gender == GENDER_FEMALE && (forceGender || !FemaleText[DEFAULT_LOCALE].empty()))
        {
            if (FemaleText.size() > size_t(locale) && !FemaleText[locale].empty())
                return FemaleText[locale];
            return FemaleText[DEFAULT_LOCALE];
        }
        // else if (gender == GENDER_MALE)
        {
            if (MaleText.size() > size_t(locale) && !MaleText[locale].empty())
                return MaleText[locale];
            return MaleText[DEFAULT_LOCALE];
        }
    }
};

typedef std::unordered_map<uint32, BroadcastText> BroadcastTextContainer;

typedef std::set<ObjectGuid::LowType> CellGuidSet;

struct CellObjectGuids
{
    CellGuidSet creatures;
    CellGuidSet gameobjects;
};

typedef std::unordered_map<uint32/*cell_id*/, CellObjectGuids> CellObjectGuidsMap;
typedef std::unordered_map<uint32/*(mapid, spawnMode) pair*/, CellObjectGuidsMap> MapObjectGuids;

// Acore string ranges
#define MIN_ACORE_STRING_ID           1                    // 'acore_string'
#define MAX_ACORE_STRING_ID           2000000000
#define MIN_CREATURE_AI_TEXT_STRING_ID (-1)                 // 'creature_ai_texts'
#define MAX_CREATURE_AI_TEXT_STRING_ID (-1000000)

// Acore Trainer Reference start range
#define ACORE_TRAINER_START_REF      200000

struct AcoreString
{
    std::vector<std::string> Content;
};

typedef std::map<ObjectGuid, ObjectGuid> LinkedRespawnContainer;
typedef std::unordered_map<ObjectGuid::LowType, CreatureData> CreatureDataContainer;
typedef std::unordered_map<ObjectGuid::LowType, GameObjectData> GameObjectDataContainer;
typedef std::map<TempSummonGroupKey, std::vector<TempSummonData> > TempSummonDataContainer;
typedef std::unordered_map<uint32, CreatureLocale> CreatureLocaleContainer;
typedef std::unordered_map<uint32, GameObjectLocale> GameObjectLocaleContainer;
typedef std::unordered_map<uint32, ItemLocale> ItemLocaleContainer;
typedef std::unordered_map<uint32, ItemSetNameLocale> ItemSetNameLocaleContainer;
typedef std::unordered_map<uint32, QuestLocale> QuestLocaleContainer;
typedef std::unordered_map<uint32, QuestOfferRewardLocale> QuestOfferRewardLocaleContainer;
typedef std::unordered_map<uint32, QuestRequestItemsLocale> QuestRequestItemsLocaleContainer;
typedef std::unordered_map<uint32, NpcTextLocale> NpcTextLocaleContainer;
typedef std::unordered_map<uint32, PageTextLocale> PageTextLocaleContainer;
typedef std::unordered_map<int32, AcoreString> AcoreStringContainer;
typedef std::unordered_map<uint32, GossipMenuItemsLocale> GossipMenuItemsLocaleContainer;
typedef std::unordered_map<uint32, PointOfInterestLocale> PointOfInterestLocaleContainer;

typedef std::multimap<uint32, uint32> QuestRelations;
typedef std::pair<QuestRelations::const_iterator, QuestRelations::const_iterator> QuestRelationBounds;

struct PetLevelInfo
{
    PetLevelInfo() { for (unsigned short & stat : stats) stat = 0; }

    uint16 stats[MAX_STATS];
    uint16 health{0};
    uint16 mana{0};
    uint32 armor{0};
    uint16 min_dmg{0};
    uint16 max_dmg{0};
};

struct MailLevelReward
{
    MailLevelReward()  = default;
    MailLevelReward(uint32 _raceMask, uint32 _mailTemplateId, uint32 _senderEntry) : raceMask(_raceMask), mailTemplateId(_mailTemplateId), senderEntry(_senderEntry) {}

    uint32 raceMask{0};
    uint32 mailTemplateId{0};
    uint32 senderEntry{0};
};

typedef std::list<MailLevelReward> MailLevelRewardList;
typedef std::unordered_map<uint8, MailLevelRewardList> MailLevelRewardContainer;

// We assume the rate is in general the same for all three types below, but chose to keep three for scalability and customization
struct RepRewardRate
{
    float questRate;            // We allow rate = 0.0 in database. For this case, it means that
    float questDailyRate;
    float questWeeklyRate;
    float questMonthlyRate;
    float questRepeatableRate;
    float creatureRate;         // no reputation are given at all for this faction/rate type.
    float spellRate;
};

struct ReputationOnKillEntry
{
    uint32 RepFaction1;
    uint32 RepFaction2;
    uint32 ReputationMaxCap1;
    int32 RepValue1;
    uint32 ReputationMaxCap2;
    int32 RepValue2;
    bool IsTeamAward1;
    bool IsTeamAward2;
    bool TeamDependent;
};

struct RepSpilloverTemplate
{
    uint32 faction[MAX_SPILLOVER_FACTIONS];
    float faction_rate[MAX_SPILLOVER_FACTIONS];
    uint32 faction_rank[MAX_SPILLOVER_FACTIONS];
};

struct PointOfInterest
{
    uint32 ID;
    float PositionX;
    float PositionY;
    uint32 Icon;
    uint32 Flags;
    uint32 Importance;
    std::string Name;
};

struct GossipMenuItems
{
    uint32          MenuID;
    uint32          OptionID;
    uint8           OptionIcon;
    std::string     OptionText;
    uint32          OptionBroadcastTextID;
    uint32          OptionType;
    uint32          OptionNpcFlag;
    uint32          ActionMenuID;
    uint32          ActionPoiID;
    bool            BoxCoded;
    uint32          BoxMoney;
    std::string     BoxText;
    ConditionList   Conditions;
    uint32          BoxBroadcastTextID;
};

struct GossipMenus
{
    uint32          MenuID;
    uint32          TextID;
    ConditionList   Conditions;
};

typedef std::multimap<uint32, GossipMenus> GossipMenusContainer;
typedef std::pair<GossipMenusContainer::const_iterator, GossipMenusContainer::const_iterator> GossipMenusMapBounds;
typedef std::pair<GossipMenusContainer::iterator, GossipMenusContainer::iterator> GossipMenusMapBoundsNonConst;
typedef std::multimap<uint32, GossipMenuItems> GossipMenuItemsContainer;
typedef std::pair<GossipMenuItemsContainer::const_iterator, GossipMenuItemsContainer::const_iterator> GossipMenuItemsMapBounds;
typedef std::pair<GossipMenuItemsContainer::iterator, GossipMenuItemsContainer::iterator> GossipMenuItemsMapBoundsNonConst;

struct QuestPOIPoint
{
    int32 x{0};
    int32 y{0};

    QuestPOIPoint()  = default;
    QuestPOIPoint(int32 _x, int32 _y) : x(_x), y(_y) {}
};

struct QuestPOI
{
    uint32 Id{0};
    int32 ObjectiveIndex{0};
    uint32 MapId{0};
    uint32 AreaId{0};
    uint32 FloorId{0};
    uint32 Unk3{0};
    uint32 Unk4{0};
    std::vector<QuestPOIPoint> points;

    QuestPOI()  = default;
    QuestPOI(uint32 id, int32 objIndex, uint32 mapId, uint32 areaId, uint32 floorId, uint32 unk3, uint32 unk4) : Id(id), ObjectiveIndex(objIndex), MapId(mapId), AreaId(areaId), FloorId(floorId), Unk3(unk3), Unk4(unk4) {}
};

typedef std::vector<QuestPOI> QuestPOIVector;
typedef std::unordered_map<uint32, QuestPOIVector> QuestPOIContainer;

typedef std::unordered_map<uint32, VendorItemData> CacheVendorItemContainer;
typedef std::unordered_map<uint32, TrainerSpellData> CacheTrainerSpellContainer;

enum SkillRangeType
{
    SKILL_RANGE_LANGUAGE,                                   // 300..300
    SKILL_RANGE_LEVEL,                                      // 1..max skill for level
    SKILL_RANGE_MONO,                                       // 1..1, grey monolite bar
    SKILL_RANGE_RANK,                                       // 1..skill for known rank
    SKILL_RANGE_NONE,                                       // 0..0 always
};

auto GetSkillRangeType(SkillRaceClassInfoEntry const* rcEntry) -> SkillRangeType;

#define MAX_PLAYER_NAME          12                         // max allowed by client name length
#define MAX_INTERNAL_PLAYER_NAME 15                         // max server internal player name length (> MAX_PLAYER_NAME for support declined names)
#define MAX_PET_NAME             12                         // max allowed by client name length
#define MAX_CHARTER_NAME         24                         // max allowed by client name length
#define MAX_CHANNEL_NAME         50                         // pussywizard

auto normalizePlayerName(std::string& name) -> bool;

struct LanguageDesc
{
    Language lang_id;
    uint32   spell_id;
    uint32   skill_id;
};

extern LanguageDesc lang_description[LANGUAGES_COUNT];
auto GetLanguageDescByID(uint32 lang) -> LanguageDesc const*;

struct DungeonEncounter
{
    DungeonEncounter(DungeonEncounterEntry const* _dbcEntry, EncounterCreditType _creditType, uint32 _creditEntry, uint32 _lastEncounterDungeon)
        : dbcEntry(_dbcEntry), creditType(_creditType), creditEntry(_creditEntry), lastEncounterDungeon(_lastEncounterDungeon) { }

    DungeonEncounterEntry const* dbcEntry;
    EncounterCreditType creditType;
    uint32 creditEntry;
    uint32 lastEncounterDungeon;
};

typedef std::list<DungeonEncounter const*> DungeonEncounterList;
typedef std::unordered_map<uint32, DungeonEncounterList> DungeonEncounterContainer;

static constexpr uint32 MAX_QUEST_MONEY_REWARDS = 10;
typedef std::array<uint32, MAX_QUEST_MONEY_REWARDS> QuestMoneyRewardArray;
typedef std::unordered_map<uint32, QuestMoneyRewardArray> QuestMoneyRewardStore;

class PlayerDumpReader;

class ObjectMgr
{
    friend class PlayerDumpReader;

private:
    ObjectMgr();
    ~ObjectMgr();

public:
    static auto instance() -> ObjectMgr*;

    typedef std::unordered_map<uint32, Item*> ItemMap;

    typedef std::unordered_map<uint32, Quest*> QuestMap;

    typedef std::unordered_map<uint32, AreaTrigger> AreaTriggerContainer;

    typedef std::unordered_map<uint32, AreaTriggerTeleport> AreaTriggerTeleportContainer;

    typedef std::unordered_map<uint32, uint32> AreaTriggerScriptContainer;

    typedef std::unordered_map<uint32, std::unordered_map<uint8, DungeonProgressionRequirements*>> DungeonProgressionRequirementsContainer;

    typedef std::unordered_map<uint32, RepRewardRate > RepRewardRateContainer;
    typedef std::unordered_map<uint32, ReputationOnKillEntry> RepOnKillContainer;
    typedef std::unordered_map<uint32, RepSpilloverTemplate> RepSpilloverTemplateContainer;

    typedef std::unordered_map<uint32, PointOfInterest> PointOfInterestContainer;

    typedef std::vector<std::string> ScriptNameContainer;

    typedef std::map<uint32, uint32> CharacterConversionMap;

    auto GetGameObjectTemplate(uint32 entry) -> GameObjectTemplate const*;
    auto IsGameObjectStaticTransport(uint32 entry) -> bool;
    [[nodiscard]] auto GetGameObjectTemplates() const -> GameObjectTemplateContainer const* { return &_gameObjectTemplateStore; }
    auto LoadReferenceVendor(int32 vendor, int32 item_id, std::set<uint32>* skip_vendors) -> int;

    void LoadGameObjectTemplate();
    void LoadGameObjectTemplateAddons();
    void AddGameobjectInfo(GameObjectTemplate* goinfo);

    auto GetCreatureTemplate(uint32 entry) -> CreatureTemplate const*;
    [[nodiscard]] auto GetCreatureTemplates() const -> CreatureTemplateContainer const* { return &_creatureTemplateStore; }
    auto GetCreatureModelInfo(uint32 modelId) -> CreatureModelInfo const*;
    auto GetCreatureModelRandomGender(uint32* displayID) -> CreatureModelInfo const*;
    static auto ChooseDisplayId(CreatureTemplate const* cinfo, CreatureData const* data = nullptr) -> uint32;
    static void ChooseCreatureFlags(CreatureTemplate const* cinfo, uint32& npcflag, uint32& unit_flags, uint32& dynamicflags, CreatureData const* data = nullptr);
    auto GetEquipmentInfo(uint32 entry, int8& id) -> EquipmentInfo const*;
    auto GetCreatureAddon(ObjectGuid::LowType lowguid) -> CreatureAddon const*;
    auto GetGameObjectAddon(ObjectGuid::LowType lowguid) -> GameObjectAddon const*;
    [[nodiscard]] auto GetGameObjectTemplateAddon(uint32 entry) const -> GameObjectTemplateAddon const*;
    auto GetCreatureTemplateAddon(uint32 entry) -> CreatureAddon const*;
    auto GetItemTemplate(uint32 entry) -> ItemTemplate const*;
    [[nodiscard]] auto GetItemTemplateStore() const -> ItemTemplateContainer const* { return &_itemTemplateStore; }
    [[nodiscard]] auto GetItemTemplateStoreFast() const -> std::vector<ItemTemplate*> const* { return &_itemTemplateStoreFast; }

    auto GetItemSetNameEntry(uint32 itemId) -> ItemSetNameEntry const*
    {
        ItemSetNameContainer::iterator itr = _itemSetNameStore.find(itemId);
        if (itr != _itemSetNameStore.end())
            return &itr->second;
        return nullptr;
    }

    auto GetInstanceTemplate(uint32 mapId) -> InstanceTemplate const*;

    [[nodiscard]] auto GetPetLevelInfo(uint32 creature_id, uint8 level) const -> PetLevelInfo const*;

    [[nodiscard]] auto GetPlayerClassInfo(uint32 class_) const -> PlayerClassInfo const*
    {
        if (class_ >= MAX_CLASSES)
            return nullptr;
        return _playerClassInfo[class_];
    }
    void GetPlayerClassLevelInfo(uint32 class_, uint8 level, PlayerClassLevelInfo* info) const;

    [[nodiscard]] auto GetPlayerInfo(uint32 race, uint32 class_) const -> PlayerInfo const*;

    void GetPlayerLevelInfo(uint32 race, uint32 class_, uint8 level, PlayerLevelInfo* info) const;

    auto GetNearestTaxiNode(float x, float y, float z, uint32 mapid, uint32 teamId) -> uint32;
    void GetTaxiPath(uint32 source, uint32 destination, uint32& path, uint32& cost);
    auto GetTaxiMountDisplayId(uint32 id, TeamId teamId, bool allowed_alt_team = false) -> uint32;

    [[nodiscard]] auto GetGameObjectQuestItemList(uint32 id) const -> GameObjectQuestItemList const*
    {
        GameObjectQuestItemMap::const_iterator itr = _gameObjectQuestItemStore.find(id);
        if (itr != _gameObjectQuestItemStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] auto GetGameObjectQuestItemMap() const -> GameObjectQuestItemMap const* { return &_gameObjectQuestItemStore; }

    [[nodiscard]] auto GetCreatureQuestItemList(uint32 id) const -> CreatureQuestItemList const*
    {
        CreatureQuestItemMap::const_iterator itr = _creatureQuestItemStore.find(id);
        if (itr != _creatureQuestItemStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] auto GetCreatureQuestItemMap() const -> CreatureQuestItemMap const* { return &_creatureQuestItemStore; }

    [[nodiscard]] auto GetQuestTemplate(uint32 quest_id) const -> Quest const*
    {
        return quest_id < _questTemplatesFast.size() ? _questTemplatesFast[quest_id] : nullptr;
    }

    [[nodiscard]] auto GetQuestTemplates() const -> QuestMap const& { return _questTemplates; }

    [[nodiscard]] auto GetQuestForAreaTrigger(uint32 Trigger_ID) const -> uint32
    {
        QuestAreaTriggerContainer::const_iterator itr = _questAreaTriggerStore.find(Trigger_ID);
        if (itr != _questAreaTriggerStore.end())
            return itr->second;
        return 0;
    }

    [[nodiscard]] auto IsTavernAreaTrigger(uint32 Trigger_ID) const -> bool
    {
        return _tavernAreaTriggerStore.find(Trigger_ID) != _tavernAreaTriggerStore.end();
    }

    [[nodiscard]] auto GetGossipText(uint32 Text_ID) const -> GossipText const*;

    [[nodiscard]] auto GetAreaTrigger(uint32 trigger) const -> AreaTrigger const*
    {
        AreaTriggerContainer::const_iterator itr = _areaTriggerStore.find(trigger);
        if (itr != _areaTriggerStore.end())
            return &itr->second;
        return nullptr;
    }

    [[nodiscard]] auto GetAreaTriggerTeleport(uint32 trigger) const -> AreaTriggerTeleport const*
    {
        AreaTriggerTeleportContainer::const_iterator itr = _areaTriggerTeleportStore.find(trigger);
        if (itr != _areaTriggerTeleportStore.end())
            return &itr->second;
        return nullptr;
    }

    [[nodiscard]] auto GetAccessRequirement(uint32 mapid, Difficulty difficulty) const -> DungeonProgressionRequirements const*
    {
        DungeonProgressionRequirementsContainer::const_iterator itr = _accessRequirementStore.find(mapid);
        if (itr != _accessRequirementStore.end())
        {
            std::unordered_map<uint8, DungeonProgressionRequirements*> difficultiesProgressionRequirements = itr->second;
            auto difficultiesItr = difficultiesProgressionRequirements.find(difficulty);
            if (difficultiesItr != difficultiesProgressionRequirements.end())
            {
                return difficultiesItr->second;
            }
        }
        return nullptr;
    }

    [[nodiscard]] auto GetGoBackTrigger(uint32 Map) const -> AreaTriggerTeleport const*;
    [[nodiscard]] auto GetMapEntranceTrigger(uint32 Map) const -> AreaTriggerTeleport const*;

    auto GetAreaTriggerScriptId(uint32 trigger_id) -> uint32;
    auto GetSpellScriptsBounds(uint32 spell_id) -> SpellScriptsBounds;

    [[nodiscard]] auto GetRepRewardRate(uint32 factionId) const -> RepRewardRate const*
    {
        RepRewardRateContainer::const_iterator itr = _repRewardRateStore.find(factionId);
        if (itr != _repRewardRateStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] auto GetReputationOnKilEntry(uint32 id) const -> ReputationOnKillEntry const*
    {
        RepOnKillContainer::const_iterator itr = _repOnKillStore.find(id);
        if (itr != _repOnKillStore.end())
            return &itr->second;
        return nullptr;
    }

    auto GetBaseReputationOf(FactionEntry const* factionEntry, uint8 race, uint8 playerClass) -> int32;

    [[nodiscard]] auto GetRepSpilloverTemplate(uint32 factionId) const -> RepSpilloverTemplate const*
    {
        RepSpilloverTemplateContainer::const_iterator itr = _repSpilloverTemplateStore.find(factionId);
        if (itr != _repSpilloverTemplateStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] auto GetPointOfInterest(uint32 id) const -> PointOfInterest const*
    {
        PointOfInterestContainer::const_iterator itr = _pointsOfInterestStore.find(id);
        if (itr != _pointsOfInterestStore.end())
            return &itr->second;
        return nullptr;
    }

    auto GetQuestPOIVector(uint32 questId) -> QuestPOIVector const*
    {
        QuestPOIContainer::const_iterator itr = _questPOIStore.find(questId);
        if (itr != _questPOIStore.end())
            return &itr->second;
        return nullptr;
    }

    auto GetVehicleAccessoryList(Vehicle* veh) const -> VehicleAccessoryList const*;

    auto GetDungeonEncounterList(uint32 mapId, Difficulty difficulty) -> DungeonEncounterList const*
    {
        std::unordered_map<uint32, DungeonEncounterList>::const_iterator itr = _dungeonEncounterStore.find(MAKE_PAIR32(mapId, difficulty));
        if (itr != _dungeonEncounterStore.end())
            return &itr->second;
        return nullptr;
    }

    void LoadQuests();
    void LoadQuestMoneyRewards();
    void LoadQuestStartersAndEnders()
    {
        LOG_INFO("server.loading", "Loading GO Start Quest Data...");
        LoadGameobjectQuestStarters();
        LOG_INFO("server.loading", "Loading GO End Quest Data...");
        LoadGameobjectQuestEnders();
        LOG_INFO("server.loading", "Loading Creature Start Quest Data...");
        LoadCreatureQuestStarters();
        LOG_INFO("server.loading", "Loading Creature End Quest Data...");
        LoadCreatureQuestEnders();
    }
    void LoadGameobjectQuestStarters();
    void LoadGameobjectQuestEnders();
    void LoadCreatureQuestStarters();
    void LoadCreatureQuestEnders();

    auto GetGOQuestRelationMap() -> QuestRelations*
    {
        return &_goQuestRelations;
    }

    auto GetGOQuestInvolvedRelationMap() -> QuestRelations*
    {
        return &_goQuestInvolvedRelations;
    }

    auto GetGOQuestRelationBounds(uint32 go_entry) -> QuestRelationBounds
    {
        return _goQuestRelations.equal_range(go_entry);
    }

    auto GetGOQuestInvolvedRelationBounds(uint32 go_entry) -> QuestRelationBounds
    {
        return _goQuestInvolvedRelations.equal_range(go_entry);
    }

    auto GetCreatureQuestRelationMap() -> QuestRelations*
    {
        return &_creatureQuestRelations;
    }

    auto GetCreatureQuestInvolvedRelationMap() -> QuestRelations*
    {
        return &_creatureQuestInvolvedRelations;
    }

    auto GetCreatureQuestRelationBounds(uint32 creature_entry) -> QuestRelationBounds
    {
        return _creatureQuestRelations.equal_range(creature_entry);
    }

    auto GetCreatureQuestInvolvedRelationBounds(uint32 creature_entry) -> QuestRelationBounds
    {
        return _creatureQuestInvolvedRelations.equal_range(creature_entry);
    }

    void LoadEventScripts();
    void LoadSpellScripts();
    void LoadWaypointScripts();

    void LoadSpellScriptNames();
    void ValidateSpellScripts();
    void InitializeSpellInfoPrecomputedData();

    auto LoadAcoreStrings() -> bool;
    void LoadBroadcastTexts();
    void LoadBroadcastTextLocales();
    void LoadCreatureClassLevelStats();
    void LoadCreatureLocales();
    void LoadCreatureTemplates();
    void LoadCreatureTemplate(Field* fields);
    void LoadCreatureTemplateAddons();
    void LoadCreatureTemplateResistances();
    void LoadCreatureTemplateSpells();
    void CheckCreatureTemplate(CreatureTemplate const* cInfo);
    void LoadGameObjectQuestItems();
    void LoadCreatureQuestItems();
    void LoadTempSummons();
    void LoadCreatures();
    void LoadLinkedRespawn();
    auto SetCreatureLinkedRespawn(ObjectGuid::LowType guid, ObjectGuid::LowType linkedGuid) -> bool;
    void LoadCreatureAddons();
    void LoadGameObjectAddons();
    void LoadCreatureModelInfo();
    void LoadEquipmentTemplates();
    void LoadGameObjectLocales();
    void LoadGameobjects();
    void LoadItemTemplates();
    void LoadItemLocales();
    void LoadItemSetNames();
    void LoadItemSetNameLocales();
    void LoadQuestLocales();
    void LoadNpcTextLocales();
    void LoadQuestOfferRewardLocale();
    void LoadQuestRequestItemsLocale();
    void LoadPageTextLocales();
    void LoadGossipMenuItemsLocales();
    void LoadPointOfInterestLocales();
    void LoadInstanceTemplate();
    void LoadInstanceEncounters();
    void LoadMailLevelRewards();
    void LoadVehicleTemplateAccessories();
    void LoadVehicleAccessories();

    void LoadGossipText();

    void LoadAreaTriggers();
    void LoadAreaTriggerTeleports();
    void LoadAccessRequirements();
    void LoadQuestAreaTriggers();
    void LoadAreaTriggerScripts();
    void LoadTavernAreaTriggers();
    void LoadGameObjectForQuests();

    void LoadPageTexts();
    auto GetPageText(uint32 pageEntry) -> PageText const*;

    void LoadPlayerInfo();
    void LoadPetLevelInfo();
    void LoadExplorationBaseXP();
    void LoadPetNames();
    void LoadPetNumber();
    void LoadFishingBaseSkillLevel();
    void ChangeFishingBaseSkillLevel(uint32 entry, int32 skill);

    void LoadReputationRewardRate();
    void LoadReputationOnKill();
    void LoadReputationSpilloverTemplate();

    void LoadPointsOfInterest();
    void LoadQuestPOI();

    void LoadNPCSpellClickSpells();

    void LoadGameTele();

    void LoadGossipMenu();
    void LoadGossipMenuItems();

    void LoadVendors();
    void LoadTrainerSpell();
    void AddSpellToTrainer(uint32 entry, uint32 spell, uint32 spellCost, uint32 reqSkill, uint32 reqSkillValue, uint32 reqLevel, uint32 reqSpell);

    auto GeneratePetName(uint32 entry) -> std::string;
    auto GetBaseXP(uint8 level) -> uint32;
    [[nodiscard]] auto GetXPForLevel(uint8 level) const -> uint32;

    [[nodiscard]] auto GetFishingBaseSkillLevel(uint32 entry) const -> int32
    {
        FishingBaseSkillContainer::const_iterator itr = _fishingBaseForAreaStore.find(entry);
        return itr != _fishingBaseForAreaStore.end() ? itr->second : 0;
    }

    void ReturnOrDeleteOldMails(bool serverUp);

    auto GetCreatureBaseStats(uint8 level, uint8 unitClass) -> CreatureBaseStats const*;

    void SetHighestGuids();

    template<HighGuid type>
    inline auto GetGenerator() -> ObjectGuidGeneratorBase&
    {
        static_assert(ObjectGuidTraits<type>::Global, "Only global guid can be generated in ObjectMgr context");
        return GetGuidSequenceGenerator<type>();
    }

    auto GenerateAuctionID() -> uint32;
    auto GenerateEquipmentSetGuid() -> uint64;
    auto GenerateMailID() -> uint32;
    auto GeneratePetNumber() -> uint32;
    auto GenerateCreatureSpawnId() -> ObjectGuid::LowType;
    auto GenerateGameObjectSpawnId() -> ObjectGuid::LowType;

    typedef std::multimap<int32, uint32> ExclusiveQuestGroups;
    typedef std::pair<ExclusiveQuestGroups::const_iterator, ExclusiveQuestGroups::const_iterator> ExclusiveQuestGroupsBounds;

    ExclusiveQuestGroups mExclusiveQuestGroups;

    auto GetMailLevelReward(uint32 level, uint32 raceMask) -> MailLevelReward const*
    {
        MailLevelRewardContainer::const_iterator map_itr = _mailLevelRewardStore.find(level);
        if (map_itr == _mailLevelRewardStore.end())
            return nullptr;

        for (const auto & set_itr : map_itr->second)
            if (set_itr.raceMask & raceMask)
                return &set_itr;

        return nullptr;
    }

    auto GetCellObjectGuids(uint16 mapid, uint8 spawnMode, uint32 cell_id) -> CellObjectGuids const&
    {
        MapObjectGuids::const_iterator itr1 = _mapObjectGuidsStore.find(MAKE_PAIR32(mapid, spawnMode));
        if (itr1 != _mapObjectGuidsStore.end())
        {
            CellObjectGuidsMap::const_iterator itr2 = itr1->second.find(cell_id);
            if (itr2 != itr1->second.end())
                return itr2->second;
        }
        return _emptyCellObjectGuids;
    }

    auto GetMapObjectGuids(uint16 mapid, uint8 spawnMode) -> CellObjectGuidsMap const&
    {
        MapObjectGuids::const_iterator itr1 = _mapObjectGuidsStore.find(MAKE_PAIR32(mapid, spawnMode));
        if (itr1 != _mapObjectGuidsStore.end())
            return itr1->second;
        return _emptyCellObjectGuidsMap;
    }

    /**
     * Gets temp summon data for all creatures of specified group.
     *
     * @param summonerId   Summoner's entry.
     * @param summonerType Summoner's type, see SummonerType for available types.
     * @param group        Id of required group.
     *
     * @return null if group was not found, otherwise reference to the creature group data
     */
    [[nodiscard]] auto GetSummonGroup(uint32 summonerId, SummonerType summonerType, uint8 group) const -> std::vector<TempSummonData> const*
    {
        TempSummonDataContainer::const_iterator itr = _tempSummonDataStore.find(TempSummonGroupKey(summonerId, summonerType, group));
        if (itr != _tempSummonDataStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] auto GetBroadcastText(uint32 id) const -> BroadcastText const*
    {
        BroadcastTextContainer::const_iterator itr = _broadcastTextStore.find(id);
        if (itr != _broadcastTextStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] auto GetAllCreatureData() const -> CreatureDataContainer const& { return _creatureDataStore; }
    [[nodiscard]] auto GetCreatureData(ObjectGuid::LowType spawnId) const -> CreatureData const*
    {
        CreatureDataContainer::const_iterator itr = _creatureDataStore.find(spawnId);
        if (itr == _creatureDataStore.end()) return nullptr;
        return &itr->second;
    }
    auto NewOrExistCreatureData(ObjectGuid::LowType spawnId) -> CreatureData& { return _creatureDataStore[spawnId]; }
    void DeleteCreatureData(ObjectGuid::LowType spawnId);
    [[nodiscard]] auto GetLinkedRespawnGuid(ObjectGuid guid) const -> ObjectGuid
    {
        LinkedRespawnContainer::const_iterator itr = _linkedRespawnStore.find(guid);
        if (itr == _linkedRespawnStore.end())
            return ObjectGuid::Empty;
        return itr->second;
    }

    [[nodiscard]] auto GetAllGOData() const -> GameObjectDataContainer const& { return _gameObjectDataStore; }
    [[nodiscard]] auto GetGOData(ObjectGuid::LowType spawnId) const -> GameObjectData const*
    {
        GameObjectDataContainer::const_iterator itr = _gameObjectDataStore.find(spawnId);
        if (itr == _gameObjectDataStore.end()) return nullptr;
            return &itr->second;
    }
    [[nodiscard]] auto GetCreatureLocale(uint32 entry) const -> CreatureLocale const*
    {
        CreatureLocaleContainer::const_iterator itr = _creatureLocaleStore.find(entry);
        if (itr == _creatureLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetGameObjectLocale(uint32 entry) const -> GameObjectLocale const*
    {
        GameObjectLocaleContainer::const_iterator itr = _gameObjectLocaleStore.find(entry);
        if (itr == _gameObjectLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetItemLocale(uint32 entry) const -> ItemLocale const*
    {
        ItemLocaleContainer::const_iterator itr = _itemLocaleStore.find(entry);
        if (itr == _itemLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetItemSetNameLocale(uint32 entry) const -> ItemSetNameLocale const*
    {
        ItemSetNameLocaleContainer::const_iterator itr = _itemSetNameLocaleStore.find(entry);
        if (itr == _itemSetNameLocaleStore.end())return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetPageTextLocale(uint32 entry) const -> PageTextLocale const*
    {
        PageTextLocaleContainer::const_iterator itr = _pageTextLocaleStore.find(entry);
        if (itr == _pageTextLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetQuestLocale(uint32 entry) const -> QuestLocale const*
    {
        QuestLocaleContainer::const_iterator itr = _questLocaleStore.find(entry);
        if (itr == _questLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetGossipMenuItemsLocale(uint32 entry) const -> GossipMenuItemsLocale const*
    {
        GossipMenuItemsLocaleContainer::const_iterator itr = _gossipMenuItemsLocaleStore.find(entry);
        if (itr == _gossipMenuItemsLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetPointOfInterestLocale(uint32 poi_id) const -> PointOfInterestLocale const*
    {
        PointOfInterestLocaleContainer::const_iterator itr = _pointOfInterestLocaleStore.find(poi_id);
        if (itr == _pointOfInterestLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetQuestOfferRewardLocale(uint32 entry) const -> QuestOfferRewardLocale const*
    {
        auto itr = _questOfferRewardLocaleStore.find(entry);
        if (itr == _questOfferRewardLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetQuestRequestItemsLocale(uint32 entry) const -> QuestRequestItemsLocale const*
    {
        auto itr = _questRequestItemsLocaleStore.find(entry);
        if (itr == _questRequestItemsLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetNpcTextLocale(uint32 entry) const -> NpcTextLocale const*
    {
        NpcTextLocaleContainer::const_iterator itr = _npcTextLocaleStore.find(entry);
        if (itr == _npcTextLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    auto NewGOData(ObjectGuid::LowType guid) -> GameObjectData& { return _gameObjectDataStore[guid]; }
    void DeleteGOData(ObjectGuid::LowType guid);

    [[nodiscard]] auto GetAcoreString(uint32 entry) const -> AcoreString const*
    {
        AcoreStringContainer::const_iterator itr = _acoreStringStore.find(entry);
        if (itr == _acoreStringStore.end())
            return nullptr;

        return &itr->second;
    }
    [[nodiscard]] auto GetAcoreString(uint32 entry, LocaleConstant locale) const -> char const*;
    [[nodiscard]] auto GetAcoreStringForDBCLocale(uint32 entry) const -> char const* { return GetAcoreString(entry, DBCLocaleIndex); }
    [[nodiscard]] auto GetDBCLocaleIndex() const -> LocaleConstant { return DBCLocaleIndex; }
    void SetDBCLocaleIndex(LocaleConstant locale) { DBCLocaleIndex = locale; }

    // grid objects
    void AddCreatureToGrid(ObjectGuid::LowType guid, CreatureData const* data);
    void RemoveCreatureFromGrid(ObjectGuid::LowType guid, CreatureData const* data);
    void AddGameobjectToGrid(ObjectGuid::LowType guid, GameObjectData const* data);
    void RemoveGameobjectFromGrid(ObjectGuid::LowType guid, GameObjectData const* data);
    auto AddGOData(uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimedelay = 0, float rotation0 = 0, float rotation1 = 0, float rotation2 = 0, float rotation3 = 0) -> uint32;
    auto AddCreData(uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimedelay = 0) -> uint32;

    // reserved names
    void LoadReservedPlayersNames();
    [[nodiscard]] auto IsReservedName(std::string_view name) const -> bool;
    void AddReservedPlayerName(std::string const& name);

    // name with valid structure and symbols
    static auto CheckPlayerName(std::string_view name, bool create = false) -> uint8;
    static auto CheckPetName(std::string_view name) -> PetNameInvalidReason;
    static auto IsValidCharterName(std::string_view name) -> bool;
    static auto IsValidChannelName(std::string const& name) -> bool;

    static auto CheckDeclinedNames(std::wstring w_ownname, DeclinedName const& names) -> bool;

    [[nodiscard]] auto GetGameTele(uint32 id) const -> GameTele const*
    {
        GameTeleContainer::const_iterator itr = _gameTeleStore.find(id);
        if (itr == _gameTeleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] auto GetGameTele(std::string_view name) const -> GameTele const*;
    [[nodiscard]] auto GetGameTeleMap() const -> GameTeleContainer const& { return _gameTeleStore; }
    auto AddGameTele(GameTele& data) -> bool;
    auto DeleteGameTele(std::string_view name) -> bool;

    [[nodiscard]] auto GetNpcTrainerSpells(uint32 entry) const -> TrainerSpellData const*
    {
        CacheTrainerSpellContainer::const_iterator  iter = _cacheTrainerSpellStore.find(entry);
        if (iter == _cacheTrainerSpellStore.end())
            return nullptr;

        return &iter->second;
    }

    [[nodiscard]] auto GetNpcVendorItemList(uint32 entry) const -> VendorItemData const*
    {
        CacheVendorItemContainer::const_iterator iter = _cacheVendorItemStore.find(entry);
        if (iter == _cacheVendorItemStore.end())
            return nullptr;

        return &iter->second;
    }

    void AddVendorItem(uint32 entry, uint32 item, int32 maxcount, uint32 incrtime, uint32 extendedCost, bool persist = true); // for event
    auto RemoveVendorItem(uint32 entry, uint32 item, bool persist = true) -> bool; // for event
    auto IsVendorItemValid(uint32 vendor_entry, uint32 item, int32 maxcount, uint32 ptime, uint32 ExtendedCost, Player* player = nullptr, std::set<uint32>* skip_vendors = nullptr, uint32 ORnpcflag = 0) const -> bool;

    void LoadScriptNames();
    auto GetScriptNames() -> ScriptNameContainer& { return _scriptNamesStore; }
    [[nodiscard]] auto GetScriptName(uint32 id) const -> std::string const&;
    auto GetScriptId(std::string const& name) -> uint32;

    [[nodiscard]] auto GetSpellClickInfoMapBounds(uint32 creature_id) const -> SpellClickInfoMapBounds
    {
        return _spellClickInfoStore.equal_range(creature_id);
    }

    [[nodiscard]] auto GetGossipMenusMapBounds(uint32 uiMenuId) const -> GossipMenusMapBounds
    {
        return _gossipMenusStore.equal_range(uiMenuId);
    }

    auto GetGossipMenusMapBoundsNonConst(uint32 uiMenuId) -> GossipMenusMapBoundsNonConst
    {
        return _gossipMenusStore.equal_range(uiMenuId);
    }

    [[nodiscard]] auto GetGossipMenuItemsMapBounds(uint32 uiMenuId) const -> GossipMenuItemsMapBounds
    {
        return _gossipMenuItemsStore.equal_range(uiMenuId);
    }
    auto GetGossipMenuItemsMapBoundsNonConst(uint32 uiMenuId) -> GossipMenuItemsMapBoundsNonConst
    {
        return _gossipMenuItemsStore.equal_range(uiMenuId);
    }

    static void AddLocaleString(std::string&& s, LocaleConstant locale, std::vector<std::string>& data);
    static auto GetLocaleString(std::vector<std::string> const& data, size_t locale) -> std::string_view
    {
        if (locale < data.size())
            return data[locale];
        else
            return {};
    }
    static inline void GetLocaleString(const std::vector<std::string>& data, int loc_idx, std::string& value)
    {
        if (data.size() > size_t(loc_idx) && !data[loc_idx].empty())
            value = data[loc_idx];
    }

    CharacterConversionMap FactionChangeAchievements;
    CharacterConversionMap FactionChangeItems;
    CharacterConversionMap FactionChangeQuests;
    CharacterConversionMap FactionChangeReputation;
    CharacterConversionMap FactionChangeSpells;
    CharacterConversionMap FactionChangeTitles;

    void LoadFactionChangeAchievements();
    void LoadFactionChangeItems();
    void LoadFactionChangeQuests();
    void LoadFactionChangeReputations();
    void LoadFactionChangeSpells();
    void LoadFactionChangeTitles();

    [[nodiscard]] auto IsTransportMap(uint32 mapId) const -> bool { return _transportMaps.count(mapId) != 0; }

    [[nodiscard]] auto GetQuestMoneyReward(uint8 level, uint32 questMoneyDifficulty) const -> uint32;

private:
    // first free id for selected id type
    uint32 _auctionId; // pussywizard: accessed by a single thread
    uint64 _equipmentSetGuid; // pussywizard: accessed by a single thread
    uint32 _mailId;
    std::mutex _mailIdMutex;
    uint32 _hiPetNumber;
    std::mutex _hiPetNumberMutex;

    ObjectGuid::LowType _creatureSpawnId;
    ObjectGuid::LowType _gameObjectSpawnId;

    // first free low guid for selected guid type
    template<HighGuid high>
    inline auto GetGuidSequenceGenerator() -> ObjectGuidGeneratorBase&
    {
        auto itr = _guidGenerators.find(high);
        if (itr == _guidGenerators.end())
            itr = _guidGenerators.insert(std::make_pair(high, std::unique_ptr<ObjectGuidGenerator<high>>(new ObjectGuidGenerator<high>()))).first;

        return *itr->second;
    }

    std::map<HighGuid, std::unique_ptr<ObjectGuidGeneratorBase>> _guidGenerators;

    QuestMap _questTemplates;
    std::vector<Quest*> _questTemplatesFast; // pussywizard

    typedef std::unordered_map<uint32, GossipText> GossipTextContainer;
    typedef std::unordered_map<uint32, uint32> QuestAreaTriggerContainer;
    typedef std::set<uint32> TavernAreaTriggerContainer;

    QuestAreaTriggerContainer _questAreaTriggerStore;
    TavernAreaTriggerContainer _tavernAreaTriggerStore;
    GossipTextContainer _gossipTextStore;
    AreaTriggerContainer _areaTriggerStore;
    AreaTriggerTeleportContainer _areaTriggerTeleportStore;
    AreaTriggerScriptContainer _areaTriggerScriptStore;
    DungeonProgressionRequirementsContainer _accessRequirementStore;
    DungeonEncounterContainer _dungeonEncounterStore;

    RepRewardRateContainer _repRewardRateStore;
    RepOnKillContainer _repOnKillStore;
    RepSpilloverTemplateContainer _repSpilloverTemplateStore;

    GossipMenusContainer _gossipMenusStore;
    GossipMenuItemsContainer _gossipMenuItemsStore;
    PointOfInterestContainer _pointsOfInterestStore;

    QuestPOIContainer _questPOIStore;

    QuestRelations _goQuestRelations;
    QuestRelations _goQuestInvolvedRelations;
    QuestRelations _creatureQuestRelations;
    QuestRelations _creatureQuestInvolvedRelations;

    //character reserved names
    typedef std::set<std::wstring> ReservedNamesContainer;
    ReservedNamesContainer _reservedNamesStore;

    GameTeleContainer _gameTeleStore;

    ScriptNameContainer _scriptNamesStore;

    SpellClickInfoContainer _spellClickInfoStore;

    SpellScriptsContainer _spellScriptsStore;

    VehicleAccessoryContainer _vehicleTemplateAccessoryStore;
    VehicleAccessoryContainer _vehicleAccessoryStore;

    LocaleConstant DBCLocaleIndex;

    PageTextContainer _pageTextStore;
    InstanceTemplateContainer _instanceTemplateStore;

private:
    void LoadScripts(ScriptsType type);
    void LoadQuestRelationsHelper(QuestRelations& map, std::string const& table, bool starter, bool go);
    void PlayerCreateInfoAddItemHelper(uint32 race_, uint32 class_, uint32 itemId, int32 count);

    MailLevelRewardContainer _mailLevelRewardStore;

    CreatureBaseStatsContainer _creatureBaseStatsStore;

    typedef std::map<uint32, PetLevelInfo*> PetLevelInfoContainer;
    // PetLevelInfoContainer[creature_id][level]
    PetLevelInfoContainer _petInfoStore;                            // [creature_id][level]

    PlayerClassInfo* _playerClassInfo[MAX_CLASSES];

    void BuildPlayerLevelInfo(uint8 race, uint8 class_, uint8 level, PlayerLevelInfo* plinfo) const;

    PlayerInfo* _playerInfo[MAX_RACES][MAX_CLASSES];

    typedef std::vector<uint32> PlayerXPperLevel;       // [level]
    PlayerXPperLevel _playerXPperLevel;

    typedef std::map<uint32, uint32> BaseXPContainer;          // [area level][base xp]
    BaseXPContainer _baseXPTable;

    typedef std::map<uint32, int32> FishingBaseSkillContainer; // [areaId][base skill level]
    FishingBaseSkillContainer _fishingBaseForAreaStore;

    typedef std::map<uint32, std::vector<std::string>> HalfNameContainer;
    HalfNameContainer _petHalfName0;
    HalfNameContainer _petHalfName1;

    typedef std::unordered_map<uint32, ItemSetNameEntry> ItemSetNameContainer;
    ItemSetNameContainer _itemSetNameStore;

    MapObjectGuids _mapObjectGuidsStore;
    CellObjectGuidsMap _emptyCellObjectGuidsMap;
    CellObjectGuids _emptyCellObjectGuids;
    CreatureDataContainer _creatureDataStore;
    CreatureTemplateContainer _creatureTemplateStore;
    std::vector<CreatureTemplate*> _creatureTemplateStoreFast; // pussywizard
    CreatureModelContainer _creatureModelStore;
    CreatureAddonContainer _creatureAddonStore;
    CreatureAddonContainer _creatureTemplateAddonStore;
    GameObjectAddonContainer _gameObjectAddonStore;
    GameObjectQuestItemMap _gameObjectQuestItemStore;
    CreatureQuestItemMap _creatureQuestItemStore;
    EquipmentInfoContainer _equipmentInfoStore;
    LinkedRespawnContainer _linkedRespawnStore;
    CreatureLocaleContainer _creatureLocaleStore;
    GameObjectDataContainer _gameObjectDataStore;
    GameObjectLocaleContainer _gameObjectLocaleStore;
    GameObjectTemplateContainer _gameObjectTemplateStore;
    GameObjectTemplateAddonContainer _gameObjectTemplateAddonStore;
    /// Stores temp summon data grouped by summoner's entry, summoner's type and group id
    TempSummonDataContainer _tempSummonDataStore;

    BroadcastTextContainer _broadcastTextStore;
    ItemTemplateContainer _itemTemplateStore;
    std::vector<ItemTemplate*> _itemTemplateStoreFast; // pussywizard
    ItemLocaleContainer _itemLocaleStore;
    ItemSetNameLocaleContainer _itemSetNameLocaleStore;
    QuestLocaleContainer _questLocaleStore;
    QuestOfferRewardLocaleContainer _questOfferRewardLocaleStore;
    QuestRequestItemsLocaleContainer _questRequestItemsLocaleStore;
    NpcTextLocaleContainer _npcTextLocaleStore;
    PageTextLocaleContainer _pageTextLocaleStore;
    AcoreStringContainer _acoreStringStore;
    GossipMenuItemsLocaleContainer _gossipMenuItemsLocaleStore;
    PointOfInterestLocaleContainer _pointOfInterestLocaleStore;

    CacheVendorItemContainer _cacheVendorItemStore;
    CacheTrainerSpellContainer _cacheTrainerSpellStore;

    std::set<uint32> _difficultyEntries[MAX_DIFFICULTY - 1]; // already loaded difficulty 1 value in creatures, used in CheckCreatureTemplate
    std::set<uint32> _hasDifficultyEntries[MAX_DIFFICULTY - 1]; // already loaded creatures with difficulty 1 values, used in CheckCreatureTemplate

    enum CreatureLinkedRespawnType
    {
        CREATURE_TO_CREATURE,
        CREATURE_TO_GO,         // Creature is dependant on GO
        GO_TO_GO,
        GO_TO_CREATURE,         // GO is dependant on creature
    };

    std::set<uint32> _transportMaps; // Helper container storing map ids that are for transports only, loaded from gameobject_template

    QuestMoneyRewardStore _questMoneyRewards;
};

#define sObjectMgr ObjectMgr::instance()

#endif
