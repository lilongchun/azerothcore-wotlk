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

#ifndef AZEROTHCORE_CREATUREDATA_H
#define AZEROTHCORE_CREATUREDATA_H

#include "Cell.h"
#include "Common.h"
#include "DBCEnums.h"
#include "DatabaseEnv.h"
#include "ItemTemplate.h"
#include "LootMgr.h"
#include "Unit.h"
#include "UpdateMask.h"
#include "World.h"
#include <list>

#define MAX_AGGRO_RESET_TIME 10 // in seconds

#define MAX_KILL_CREDIT 2
#define CREATURE_REGEN_INTERVAL 2 * IN_MILLISECONDS

#define MAX_CREATURE_QUEST_ITEMS 6

#define MAX_EQUIPMENT_ITEMS 3

constexpr Milliseconds PET_FOCUS_REGEN_INTERVAL = 4s;

enum class VisibilityDistanceType : uint8;

// TODO: Implement missing flags from TC in places that custom flags from xinef&pussywizzard use flag values.
// EnumUtils: DESCRIBE THIS
enum CreatureFlagsExtra : uint32
{
    CREATURE_FLAG_EXTRA_INSTANCE_BIND                   = 0x00000001,   // creature kill bind instance with killer and killer's group
    CREATURE_FLAG_EXTRA_CIVILIAN                        = 0x00000002,   // not aggro (ignore faction/reputation hostility)
    CREATURE_FLAG_EXTRA_NO_PARRY                        = 0x00000004,   // creature can't parry
    CREATURE_FLAG_EXTRA_NO_PARRY_HASTEN                 = 0x00000008,   // creature can't counter-attack at parry
    CREATURE_FLAG_EXTRA_NO_BLOCK                        = 0x00000010,   // creature can't block
    CREATURE_FLAG_EXTRA_NO_CRUSHING_BLOWS               = 0x00000020,   // creature can't do crush attacks
    CREATURE_FLAG_EXTRA_NO_XP                           = 0x00000040,   // creature kill does not provide XP
    CREATURE_FLAG_EXTRA_TRIGGER                         = 0x00000080,   // trigger creature
    CREATURE_FLAG_EXTRA_NO_TAUNT                        = 0x00000100,   // creature is immune to taunt auras and 'attack me' effects
    CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE            = 0x00000200,   // creature won't update movement flags
    CREATURE_FLAG_EXTRA_GHOST_VISIBILITY                = 0x00000400,   // creature will only be visible to dead players
    CREATURE_FLAG_EXTRA_UNUSED_12                       = 0x00000800,   // TODO: Implement CREATURE_FLAG_EXTRA_USE_OFFHAND_ATTACK (creature will use offhand attacks)
    CREATURE_FLAG_EXTRA_NO_SELL_VENDOR                  = 0x00001000,   // players can't sell items to this vendor
    CREATURE_FLAG_EXTRA_IGNORE_COMBAT                   = 0x00002000,
    CREATURE_FLAG_EXTRA_WORLDEVENT                      = 0x00004000,   // custom flag for world event creatures (left room for merging)
    CREATURE_FLAG_EXTRA_GUARD                           = 0x00008000,   // Creature is guard
    CREATURE_FLAG_EXTRA_IGNORE_FEIGN_DEATH              = 0x00010000,   // creature ignores feign death
    CREATURE_FLAG_EXTRA_NO_CRIT                         = 0x00020000,   // creature can't do critical strikes
    CREATURE_FLAG_EXTRA_NO_SKILL_GAINS                  = 0x00040000,   // creature won't increase weapon skills
    CREATURE_FLAG_EXTRA_OBEYS_TAUNT_DIMINISHING_RETURNS = 0x00080000,   // Taunt is subject to diminishing returns on this creature
    CREATURE_FLAG_EXTRA_ALL_DIMINISH                    = 0x00100000,   // creature is subject to all diminishing returns as players are
    CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ            = 0x00200000,   // creature does not need to take player damage for kill credit
    CREATURE_FLAG_EXTRA_AVOID_AOE                       = 0x00400000,   // pussywizard: ignored by aoe attacks (for icc blood prince council npc - Dark Nucleus)
    CREATURE_FLAG_EXTRA_NO_DODGE                        = 0x00800000,   // xinef: target cannot dodge
    CREATURE_FLAG_EXTRA_UNUSED_25                       = 0x01000000,
    CREATURE_FLAG_EXTRA_UNUSED_26                       = 0x02000000,
    CREATURE_FLAG_EXTRA_UNUSED_27                       = 0x04000000,
    CREATURE_FLAG_EXTRA_UNUSED_28                       = 0x08000000,
    CREATURE_FLAG_EXTRA_DUNGEON_BOSS                    = 0x10000000,   // creature is a dungeon boss (SET DYNAMICALLY, DO NOT ADD IN DB)
    CREATURE_FLAG_EXTRA_IGNORE_PATHFINDING              = 0x20000000,   // creature ignore pathfinding
    CREATURE_FLAG_EXTRA_IMMUNITY_KNOCKBACK              = 0x40000000,   // creature is immune to knockback effects
    CREATURE_FLAG_EXTRA_HARD_RESET                      = 0x80000000,

    // Masks
    CREATURE_FLAG_EXTRA_UNUSED                          = (CREATURE_FLAG_EXTRA_UNUSED_12 | CREATURE_FLAG_EXTRA_UNUSED_25 | CREATURE_FLAG_EXTRA_UNUSED_26 |
                                                           CREATURE_FLAG_EXTRA_UNUSED_27 | CREATURE_FLAG_EXTRA_UNUSED_28), // SKIP

    CREATURE_FLAG_EXTRA_DB_ALLOWED                      = (0xFFFFFFFF & ~(CREATURE_FLAG_EXTRA_UNUSED | CREATURE_FLAG_EXTRA_DUNGEON_BOSS)) // SKIP
};

// from `creature_template` table
struct CreatureTemplate
{
    uint32  Entry;
    uint32  DifficultyEntry[MAX_DIFFICULTY - 1];
    uint32  KillCredit[MAX_KILL_CREDIT];
    uint32  Modelid1;
    uint32  Modelid2;
    uint32  Modelid3;
    uint32  Modelid4;
    std::string  Name;
    std::string  SubName;
    std::string  IconName;
    uint32  GossipMenuId;
    uint8   minlevel;
    uint8   maxlevel;
    uint32  expansion;
    uint32  faction;
    uint32  npcflag;
    float   speed_walk;
    float   speed_run;
    float   detection_range;                                // Detection Range for Line of Sight aggro
    float   scale;
    uint32  rank;
    uint32  dmgschool;
    float   DamageModifier;
    uint32  BaseAttackTime;
    uint32  RangeAttackTime;
    float   BaseVariance;
    float   RangeVariance;
    uint32  unit_class;                                     // enum Classes. Note only 4 classes are known for creatures.
    uint32  unit_flags;                                     // enum UnitFlags mask values
    uint32  unit_flags2;                                    // enum UnitFlags2 mask values
    uint32  dynamicflags;
    uint32  family;                                         // enum CreatureFamily values (optional)
    uint32  trainer_type;
    uint32  trainer_spell;
    uint32  trainer_class;
    uint32  trainer_race;
    uint32  type;                                           // enum CreatureType values
    uint32  type_flags;                                     // enum CreatureTypeFlags mask values
    uint32  lootid;
    uint32  pickpocketLootId;
    uint32  SkinLootId;
    int32   resistance[MAX_SPELL_SCHOOL];
    uint32  spells[MAX_CREATURE_SPELLS];
    uint32  PetSpellDataId;
    uint32  VehicleId;
    uint32  mingold;
    uint32  maxgold;
    std::string AIName;
    uint32  MovementType;
    uint32  InhabitType;
    float   HoverHeight;
    float   ModHealth;
    float   ModMana;
    float   ModArmor;
    float   ModExperience;
    bool    RacialLeader;
    uint32  movementId;
    bool    RegenHealth;
    uint32  MechanicImmuneMask;
    uint8   SpellSchoolImmuneMask;
    uint32  flags_extra;
    uint32  ScriptID;
    WorldPacket queryData; // pussywizard
    [[nodiscard]] auto  GetRandomValidModelId() const -> uint32;
    [[nodiscard]] auto  GetFirstValidModelId() const -> uint32;

    // helpers
    [[nodiscard]] auto GetRequiredLootSkill() const -> SkillType
    {
        if (type_flags & CREATURE_TYPE_FLAG_SKIN_WITH_HERBALISM)
            return SKILL_HERBALISM;
        else if (type_flags & CREATURE_TYPE_FLAG_SKIN_WITH_MINING)
            return SKILL_MINING;
        else if (type_flags & CREATURE_TYPE_FLAG_SKIN_WITH_ENGINEERING)
            return SKILL_ENGINEERING;
        else
            return SKILL_SKINNING;                          // normal case
    }

    [[nodiscard]] auto IsExotic() const -> bool
    {
        return (type_flags & CREATURE_TYPE_FLAG_TAMEABLE_EXOTIC) != 0;
    }

    [[nodiscard]] auto IsTameable(bool exotic) const -> bool
    {
        if (type != CREATURE_TYPE_BEAST || family == 0 || (type_flags & CREATURE_TYPE_FLAG_TAMEABLE) == 0)
            return false;

        // if can tame exotic then can tame any tameable
        return exotic || (type_flags & CREATURE_TYPE_FLAG_TAMEABLE_EXOTIC) == 0;
    }

    [[nodiscard]] auto HasFlagsExtra (uint32 flag) const -> bool { return (flags_extra & flag) != 0; }

    void InitializeQueryData();
};

typedef std::vector<uint32> CreatureQuestItemList;
typedef std::unordered_map<uint32, CreatureQuestItemList> CreatureQuestItemMap;

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint32, CreatureTemplate> CreatureTemplateContainer;

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

// Defines base stats for creatures (used to calculate HP/mana/armor/attackpower/rangedattackpower/all damage).
struct CreatureBaseStats
{
    uint32 BaseHealth[MAX_EXPANSIONS];
    uint32 BaseMana;
    uint32 BaseArmor;
    uint32 AttackPower;
    uint32 RangedAttackPower;
    float BaseDamage[MAX_EXPANSIONS];

    // Helpers

    auto GenerateHealth(CreatureTemplate const* info) const -> uint32
    {
        return uint32(ceil(BaseHealth[info->expansion] * info->ModHealth));
    }

    auto GenerateMana(CreatureTemplate const* info) const -> uint32
    {
        // Mana can be 0.
        if (!BaseMana)
            return 0;

        return uint32(ceil(BaseMana * info->ModMana));
    }

    auto GenerateArmor(CreatureTemplate const* info) const -> uint32
    {
        return uint32(ceil(BaseArmor * info->ModArmor));
    }

    auto GenerateBaseDamage(CreatureTemplate const* info) const -> float
    {
        return BaseDamage[info->expansion];
    }

    static auto GetBaseStats(uint8 level, uint8 unitClass) -> CreatureBaseStats const*;
};

typedef std::unordered_map<uint16, CreatureBaseStats> CreatureBaseStatsContainer;

struct CreatureLocale
{
    std::vector<std::string> Name;
    std::vector<std::string> Title;
};

struct GossipMenuItemsLocale
{
    std::vector<std::string> OptionText;
    std::vector<std::string> BoxText;
};

struct PointOfInterestLocale
{
    std::vector<std::string> Name;
};

struct EquipmentInfo
{
    uint32  ItemEntry[MAX_EQUIPMENT_ITEMS];
};

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint8, EquipmentInfo> EquipmentInfoContainerInternal;
typedef std::unordered_map<uint32, EquipmentInfoContainerInternal> EquipmentInfoContainer;

// from `creature` table
struct CreatureData
{
    CreatureData()  = default;
    uint32 id{0};                                              // entry in creature_template
    uint16 mapid{0};
    uint32 phaseMask{0};
    uint32 displayid{0};
    int8 equipmentId{0};
    float posX{0.0f};
    float posY{0.0f};
    float posZ{0.0f};
    float orientation{0.0f};
    uint32 spawntimesecs{0};
    float wander_distance{0.0f};
    uint32 currentwaypoint{0};
    uint32 curhealth{0};
    uint32 curmana{0};
    uint8 movementType{0};
    uint8 spawnMask{0};
    uint32 npcflag{0};
    uint32 unit_flags{0};                                      // enum UnitFlags mask values
    uint32 dynamicflags{0};
    uint32 ScriptId;
    bool dbData{true};
    bool overwrittenZ{false};
};

struct CreatureModelInfo
{
    float bounding_radius;
    float combat_reach;
    uint8 gender;
    uint32 modelid_other_gender;
};

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint16, CreatureModelInfo> CreatureModelContainer;

enum InhabitTypeValues
{
    INHABIT_GROUND = 1,
    INHABIT_WATER  = 2,
    INHABIT_AIR    = 4,
    INHABIT_ROOT   = 8,
    INHABIT_ANYWHERE = INHABIT_GROUND | INHABIT_WATER | INHABIT_AIR | INHABIT_ROOT
};

// Enums used by StringTextData::Type (CreatureEventAI)
enum ChatType
{
    CHAT_TYPE_SAY               = 0,
    CHAT_TYPE_YELL              = 1,
    CHAT_TYPE_TEXT_EMOTE        = 2,
    CHAT_TYPE_BOSS_EMOTE        = 3,
    CHAT_TYPE_WHISPER           = 4,
    CHAT_TYPE_BOSS_WHISPER      = 5,
    CHAT_TYPE_ZONE_YELL         = 6,
    CHAT_TYPE_END               = 255
};

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// `creature_addon` table
struct CreatureAddon
{
    uint32 path_id;
    uint32 mount;
    uint32 bytes1;
    uint32 bytes2;
    uint32 emote;
    bool isLarge;
    std::vector<uint32> auras;
    VisibilityDistanceType visibilityDistanceType;
};

typedef std::unordered_map<uint32, CreatureAddon> CreatureAddonContainer;

// Vendors
struct VendorItem
{
    VendorItem(uint32 _item, int32 _maxcount, uint32 _incrtime, uint32 _ExtendedCost)
        : item(_item), maxcount(_maxcount), incrtime(_incrtime), ExtendedCost(_ExtendedCost) {}

    uint32 item;
    uint32  maxcount;                                       // 0 for infinity item amount
    uint32 incrtime;                                        // time for restore items amount if maxcount != 0
    uint32 ExtendedCost;

    //helpers
    auto IsGoldRequired(ItemTemplate const* pProto) const -> bool { return pProto->Flags2 & ITEM_FLAGS_EXTRA_EXT_COST_REQUIRES_GOLD || !ExtendedCost; }
};
typedef std::vector<VendorItem*> VendorItemList;

struct VendorItemData
{
    VendorItemList m_items;

    [[nodiscard]] auto GetItem(uint32 slot) const -> VendorItem*
    {
        if (slot >= m_items.size())
            return nullptr;

        return m_items[slot];
    }
    [[nodiscard]] auto Empty() const -> bool { return m_items.empty(); }
    [[nodiscard]] auto GetItemCount() const -> uint8 { return m_items.size(); }
    void AddItem(uint32 item, int32 maxcount, uint32 ptime, uint32 ExtendedCost)
    {
        m_items.push_back(new VendorItem(item, maxcount, ptime, ExtendedCost));
    }
    auto RemoveItem(uint32 item_id) -> bool;
    [[nodiscard]] auto FindItemCostPair(uint32 item_id, uint32 extendedCost) const -> VendorItem const*;
    void Clear()
    {
        for (VendorItemList::const_iterator itr = m_items.begin(); itr != m_items.end(); ++itr)
            delete (*itr);
        m_items.clear();
    }
};

struct VendorItemCount
{
    explicit VendorItemCount(uint32 _item, uint32 _count)
        : itemId(_item), count(_count), lastIncrementTime(time(nullptr)) {}

    uint32 itemId;
    uint32 count;
    time_t lastIncrementTime;
};

typedef std::list<VendorItemCount> VendorItemCounts;

struct TrainerSpell
{
    TrainerSpell()
    {
        for (unsigned int & i : learnedSpell)
            i = 0;
    }

    uint32 spell{0};
    uint32 spellCost{0};
    uint32 reqSkill{0};
    uint32 reqSkillValue{0};
    uint32 reqLevel{0};
    uint32 learnedSpell[3];
    uint32 reqSpell{0};

    // helpers
    [[nodiscard]] auto IsCastable() const -> bool { return learnedSpell[0] != spell; }
};

typedef std::unordered_map<uint32 /*spellid*/, TrainerSpell> TrainerSpellMap;

struct TrainerSpellData
{
    TrainerSpellData()  = default;
    ~TrainerSpellData() { spellList.clear(); }

    TrainerSpellMap spellList;
    uint32 trainerType{0};                                     // trainer type based at trainer spells, can be different from creature_template value.
    // req. for correct show non-prof. trainers like weaponmaster, allowed values 0 and 2.
    [[nodiscard]] auto Find(uint32 spell_id) const -> TrainerSpell const*;
};

struct CreatureSpellCooldown
{
    CreatureSpellCooldown()  = default;
    CreatureSpellCooldown(uint16 categoryId, uint32 endTime) : category(categoryId), end(endTime) { }

    uint16 category{0};
    uint32 end{0};
};

typedef std::map<uint32, CreatureSpellCooldown> CreatureSpellCooldowns;

#endif // AZEROTHCORE_CREATUREDATA_H
