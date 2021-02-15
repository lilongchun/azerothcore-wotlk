/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "CreatureTextMgr.h"
#include "icecrown_citadel.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "Vehicle.h"

enum Texts
{
    // High Overlord Saurfang
    SAY_SAURFANG_INTRO_1                = 0,
    SAY_SAURFANG_INTRO_2                = 1,
    SAY_SAURFANG_INTRO_3                = 2,
    SAY_SAURFANG_INTRO_4                = 3,
    SAY_SAURFANG_INTRO_5                = 4,
    SAY_SAURFANG_INTRO_6                = 5,
    SAY_SAURFANG_INTRO_A                = 6,
    SAY_SAURFANG_BOARD                  = 7,
    SAY_SAURFANG_ENTER_SKYBREAKER       = 8,
    SAY_SAURFANG_AXETHROWERS            = 9,
    SAY_SAURFANG_ROCKETEERS             = 10,
    SAY_SAURFANG_MAGES                  = 11,
    SAY_SAURFANG_VICTORY                = 12,
    SAY_SAURFANG_WIPE                   = 13,

    // Muradin Bronzebeard
    SAY_MURADIN_INTRO_1                 = 0,
    SAY_MURADIN_INTRO_2                 = 1,
    SAY_MURADIN_INTRO_3                 = 2,
    SAY_MURADIN_INTRO_4                 = 3,
    SAY_MURADIN_INTRO_5                 = 4,
    SAY_MURADIN_INTRO_6                 = 5,
    SAY_MURADIN_INTRO_7                 = 6,
    SAY_MURADIN_INTRO_H                 = 7,
    SAY_MURADIN_BOARD                   = 8,
    SAY_MURADIN_ENTER_ORGRIMMS_HAMMER   = 9,
    SAY_MURADIN_RIFLEMAN                = 10,
    SAY_MURADIN_MORTAR                  = 11,
    SAY_MURADIN_SORCERERS               = 12,
    SAY_MURADIN_VICTORY                 = 13,
    SAY_MURADIN_WIPE                    = 14,

    SAY_ZAFOD_ROCKET_PACK_ACTIVE        = 0,
    SAY_ZAFOD_ROCKET_PACK_DISABLED      = 1,

    SAY_OVERHEAT                        = 0
};

enum Events
{
    // High Overlord Saurfang
    EVENT_INTRO_H_1                 = 1,
    EVENT_INTRO_H_2                 = 2,
    EVENT_INTRO_SUMMON_SKYBREAKER   = 3,
    EVENT_INTRO_H_3                 = 4,
    EVENT_INTRO_H_4                 = 5,
    EVENT_INTRO_H_5                 = 6,
    EVENT_INTRO_H_6                 = 7,

    // Muradin Bronzebeard
    EVENT_INTRO_A_1                 = 1,
    EVENT_INTRO_A_2                 = 2,
    EVENT_INTRO_SUMMON_ORGRIMS_HAMMER = 3,
    EVENT_INTRO_A_3                 = 4,
    EVENT_INTRO_A_4                 = 5,
    EVENT_INTRO_A_5                 = 6,
    EVENT_INTRO_A_6                 = 7,
    EVENT_INTRO_A_7                 = 8,

    EVENT_KEEP_PLAYER_IN_COMBAT     = 9,
    EVENT_SUMMON_MAGE               = 10,
    EVENT_ADDS                      = 11,
    EVENT_ADDS_BOARD_YELL           = 12,
    EVENT_CHECK_RIFLEMAN            = 13,
    EVENT_CHECK_MORTAR              = 14,
    EVENT_CLEAVE                    = 15,
    EVENT_BLADESTORM                = 16,
    EVENT_WOUNDING_STRIKE           = 17
};

#define EVENT_CHARGE_PREPATH 13371337

enum Spells
{
    // Applied on friendly transport NPCs
    SPELL_FRIENDLY_BOSS_DAMAGE_MOD          = 70339,
    SPELL_CHECK_FOR_PLAYERS                 = 70332,
    SPELL_GUNSHIP_FALL_TELEPORT             = 67335,
    SPELL_TELEPORT_PLAYERS_ON_RESET_A       = 70446,
    SPELL_TELEPORT_PLAYERS_ON_RESET_H       = 71284,
    SPELL_TELEPORT_PLAYERS_ON_VICTORY       = 72340,
    SPELL_ACHIEVEMENT                       = 72959,
    SPELL_AWARD_REPUTATION_BOSS_KILL        = 73843,

    // Gunship Hull
    SPELL_EXPLOSION_WIPE                    = 72134,
    SPELL_EXPLOSION_VICTORY                 = 72137,
    SPELL_BURNING_PITCH_A                   = 70403,
    SPELL_BURNING_PITCH_H                   = 70397,
    SPELL_BURNING_PITCH                     = 69660,
    SPELL_BURNING_PITCH_DAMAGE_A            = 70383,
    SPELL_BURNING_PITCH_DAMAGE_H            = 70374,

    // Murading Bronzebeard
    // High Overlord Saurfang
    SPELL_CLEAVE                            = 15284,
    SPELL_BATTLE_FURY                       = 69637,

    // Skybreaker Sorcerer
    // Kor'kron Battle-Mage
    SPELL_SHADOW_CHANNELING                 = 43897,

    // Skybreaker Rifleman
    // Kor'kron Axethrower
    SPELL_SHOOT                             = 70162,
    SPELL_HURL_AXE                          = 70161,

    // Skybreaker Sorcerer
    // Kor'kron Battle-Mage
    SPELL_BELOW_ZERO                        = 69705,

    // Skybreaker Mortar Soldier
    // Kor'kron Rocketeer
    SPELL_ROCKET_ARTILLERY_A                = 70609,
    SPELL_ROCKET_ARTILLERY_H                = 69678,

    // Murading Bronzebeard
    // High Overlord Saurfang
    SPELL_RENDING_THROW                     = 70309,
    SPELL_TASTE_OF_BLOOD                    = 69634,

    // Hostile NPCs
    SPELL_TELEPORT_TO_ENEMY_SHIP            = 70104,
    SPELL_BATTLE_EXPERIENCE                 = 71201,
    SPELL_EXPERIENCED                       = 71188,
    SPELL_VETERAN                           = 71193,
    SPELL_ELITE                             = 71195,
    SPELL_ADDS_BERSERK                      = 72525,

    // Skybreaker Sergeant
    // Kor'kron Sergeant
    SPELL_BLADESTORM                        = 69652,
    SPELL_WOUNDING_STRIKE                   = 69651,
    SPELL_DESPERATE_RESOLVE                 = 69647,

    //
    SPELL_LOCK_PLAYERS_AND_TAP_CHEST        = 72347,
    SPELL_ON_SKYBREAKER_DECK                = 70120,
    SPELL_ON_ORGRIMS_HAMMER_DECK            = 70121,

    // Rocket Pack
    SPELL_ROCKET_PACK_DAMAGE                = 69193,
    SPELL_ROCKET_BURST                      = 69192,
    SPELL_ROCKET_PACK_USEABLE               = 70348,

    // Alliance Gunship Cannon
    // Horde Gunship Cannon
    SPELL_OVERHEAT                          = 69487,
    SPELL_EJECT_ALL_PASSENGERS              = 68576,
};

enum MiscData
{
    MUSIC_ENCOUNTER         = 17289
};

enum EncounterActions
{
    ACTION_SPAWN_MAGE           = 1,
    ACTION_SPAWN_ALL_ADDS       = 2,
    ACTION_CLEAR_SLOT           = 3,
    ACTION_SET_SLOT             = 4,
    ACTION_SHIP_VISITS_SELF     = 5,
    ACTION_SHIP_VISITS_ENEMY    = 6,
    ACTION_SHIP_VISITS_SELF_2   = 7,
    ACTION_SHIP_VISITS_ENEMY_2  = 8
};

Position const SkybreakerAddsSpawnPos = { 15.91131f, 0.0f, 20.4628f, M_PI };
Position const OrgrimsHammerAddsSpawnPos = { 60.728395f, 0.0f, 38.93467f, M_PI };

// Horde encounter
Position const SkybreakerTeleportPortal  = { 6.666975f, 0.013001f, 20.87888f, 0.0f };
Position const OrgrimsHammerTeleportExit = { 7.461699f, 0.158853f, 35.72989f, 0.0f };

// Alliance encounter
Position const OrgrimsHammerTeleportPortal = { 47.550990f, -0.101778f, 37.61111f, 0.0f };
Position const SkybreakerTeleportExit      = { -17.55738f, -0.090421f, 21.18366f, 0.0f };

uint32 const MuradinExitPathSize = 10;
Position const MuradinExitPath[MuradinExitPathSize] =
{
    { 8.130936f, -0.2699585f, 20.31728f, 0.0f },
    { 6.380936f, -0.2699585f, 20.31728f, 0.0f },
    { 3.507703f, 0.02986573f, 20.78463f, 0.0f },
    { -2.767633f, 3.743143f, 20.37663f, 0.0f },
    { -4.017633f, 4.493143f, 20.12663f, 0.0f },
    { -7.242224f, 6.856013f, 20.03468f, 0.0f },
    { -7.742224f, 8.606013f, 20.78468f, 0.0f },
    { -7.992224f, 9.856013f, 21.28468f, 0.0f },
    { -12.24222f, 23.10601f, 21.28468f, 0.0f },
    { -14.88477f, 25.20844f, 21.59985f, 0.0f },
};

uint32 const SaurfangExitPathSize = 13;
Position const SaurfangExitPath[SaurfangExitPathSize] =
{
    { 30.43987f, 0.1475817f, 36.10674f, 0.0f },
    { 21.36141f, -3.056458f, 35.42970f, 0.0f },
    { 19.11141f, -3.806458f, 35.42970f, 0.0f },
    { 19.01736f, -3.299440f, 35.39428f, 0.0f },
    { 18.6747f, -5.862823f, 35.66611f, 0.0f },
    { 18.6747f, -7.862823f, 35.66611f, 0.0f },
    { 18.1747f, -17.36282f, 35.66611f, 0.0f },
    { 18.1747f, -22.61282f, 35.66611f, 0.0f },
    { 17.9247f, -24.36282f, 35.41611f, 0.0f },
    { 17.9247f, -26.61282f, 35.66611f, 0.0f },
    { 17.9247f, -27.86282f, 35.66611f, 0.0f },
    { 17.9247f, -29.36282f, 35.66611f, 0.0f },
    { 15.33203f, -30.42621f, 35.93796f, 0.0f }
};

enum PassengerSlots
{
    // Freezing the cannons
    SLOT_FREEZE_MAGE    = 0,

    // Channeling the portal, refilled with adds that board player's ship
    SLOT_MAGE_1         = 1,
    SLOT_MAGE_2         = 2,

    // Rifleman
    SLOT_RIFLEMAN_1     = 3,
    SLOT_RIFLEMAN_2     = 4,
    SLOT_RIFLEMAN_3     = 5,
    SLOT_RIFLEMAN_4     = 6,

    // Additional Rifleman on 25 man
    SLOT_RIFLEMAN_5     = 7,
    SLOT_RIFLEMAN_6     = 8,
    SLOT_RIFLEMAN_7     = 9,
    SLOT_RIFLEMAN_8     = 10,

    // Mortar
    SLOT_MORTAR_1       = 11,
    SLOT_MORTAR_2       = 12,

    // Additional spawns on 25 man
    SLOT_MORTAR_3       = 13,
    SLOT_MORTAR_4       = 14,

    // Marines
    SLOT_MARINE_1       = 15,
    SLOT_MARINE_2       = 16,

    // Additional spawns on 25 man
    SLOT_MARINE_3       = 17,
    SLOT_MARINE_4       = 18,

    // Sergeants
    SLOT_SERGEANT_1     = 19,

    // Additional spawns on 25 man
    SLOT_SERGEANT_2     = 20,

    MAX_SLOTS
};

struct SlotInfo
{
    uint32 Entry;
    Position TargetPosition;
    uint32 Cooldown;
};

SlotInfo const SkybreakerSlotInfo[MAX_SLOTS] =
{
    { NPC_SKYBREAKER_SORCERER, { -9.479858f, 0.05663967f, 20.77026f, 4.729842f }, 0 },

    { NPC_SKYBREAKER_SORCERER, { 6.385986f,  4.978760f, 20.55417f, 4.694936f }, 0 },
    { NPC_SKYBREAKER_SORCERER, { 6.579102f, -4.674561f, 20.55060f, 1.553343f }, 0 },

    { NPC_SKYBREAKER_RIFLEMAN, { -29.563900f, -17.95801f, 20.73837f, 4.747295f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -18.017210f, -18.82056f, 20.79150f, 4.747295f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -9.1193850f, -18.79102f, 20.58887f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -0.3364258f, -18.87183f, 20.56824f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_RIFLEMAN, { -34.705810f, -17.67261f, 20.51523f, 4.729842f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -23.562010f, -18.28564f, 20.67859f, 4.729842f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -13.602780f, -18.74268f, 20.59622f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -4.3350220f, -18.84619f, 20.58234f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -31.70142f, 18.02783f, 20.77197f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -9.368652f, 18.75806f, 20.65335f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -20.40851f, 18.40381f, 20.50647f, 4.694936f }, 30 },
    { NPC_SKYBREAKER_MORTAR_SOLDIER, { 0.1585693f, 18.11523f, 20.41949f, 4.729842f }, 30 },

    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },
    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },
    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_SERGEANT, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_SERGEANT, SkybreakerTeleportPortal, 0 }
};

SlotInfo const OrgrimsHammerSlotInfo[MAX_SLOTS] =
{
    { NPC_KOR_KRON_BATTLE_MAGE, { 13.58548f, 0.3867192f, 34.99243f, 1.53589f }, 0 },

    { NPC_KOR_KRON_BATTLE_MAGE, { 47.29290f, -4.308941f, 37.55550f, 1.570796f }, 0 },
    { NPC_KOR_KRON_BATTLE_MAGE, { 47.34621f,  4.032004f, 37.70952f, 4.817109f }, 0 },

    { NPC_KOR_KRON_AXETHROWER, { -12.09280f, 27.65942f, 33.58557f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { -3.170555f, 28.30652f, 34.21082f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 14.928040f, 26.18018f, 35.47803f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 24.703310f, 25.36584f, 35.97845f, 1.53589f }, 30 },

    { NPC_KOR_KRON_AXETHROWER, { -16.65302f, 27.59668f, 33.18726f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { -8.084572f, 28.21448f, 33.93805f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, {  7.594765f, 27.41968f, 35.00775f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 20.763390f, 25.58215f, 35.75287f, 1.53589f }, 30 },

    { NPC_KOR_KRON_ROCKETEER, { -11.44849f, -25.71838f, 33.64343f, 1.518436f }, 30 },
    { NPC_KOR_KRON_ROCKETEER, {  12.30336f, -25.69653f, 35.32373f, 1.518436f }, 30 },

    { NPC_KOR_KRON_ROCKETEER, { -0.05931854f, -25.46399f, 34.50592f, 1.518436f }, 30 },
    { NPC_KOR_KRON_ROCKETEER, { 27.62149000f, -23.48108f, 36.12708f, 1.518436f }, 30 },

    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },
    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },
    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_SERGEANT, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_SERGEANT, OrgrimsHammerTeleportPortal, 0 }
};

class BattleExperienceEvent : public BasicEvent
{
public:
    static uint32 const ExperiencedSpells[5];
    static uint32 const ExperiencedTimes[5];

    BattleExperienceEvent(Creature* creature) : _creature(creature), _level(0) { }

    bool Execute(uint64 timer, uint32 /*diff*/) override
    {
        if (!_creature->IsAlive())
            return true;

        _creature->RemoveAurasDueToSpell(ExperiencedSpells[_level]);
        ++_level;

        _creature->CastSpell(_creature, ExperiencedSpells[_level], true);
        if (_level < (_creature->GetMap()->IsHeroic() ? 4 : 3))
        {
            _creature->m_Events.AddEvent(this, timer + ExperiencedTimes[_level]);
            return false;
        }

        return true;
    }

private:
    Creature* _creature;
    int32 _level;
};

uint32 const BattleExperienceEvent::ExperiencedSpells[5] = { 0, SPELL_EXPERIENCED, SPELL_VETERAN, SPELL_ELITE, SPELL_ADDS_BERSERK };
uint32 const BattleExperienceEvent::ExperiencedTimes[5] = { 100000, 70000, 60000, 90000, 0 };

class PassengerController
{
public:
    PassengerController()
    {
        ResetSlots(TEAM_HORDE, nullptr);
    }

    void ResetSlots(TeamId teamId, MotionTransport* t)
    {
        _transport = t;
        memset(_controlledSlots, 0, sizeof(uint64)* MAX_SLOTS);
        memset(_respawnCooldowns, 0, sizeof(time_t)* MAX_SLOTS);
        _spawnPoint = teamId == TEAM_HORDE ? &OrgrimsHammerAddsSpawnPos : &SkybreakerAddsSpawnPos;
        _slotInfo = teamId == TEAM_HORDE ? OrgrimsHammerSlotInfo : SkybreakerSlotInfo;
    }

    bool SummonCreatures(Creature* summoner, PassengerSlots first, PassengerSlots last)
    {
        if (!_transport)
            return false;

        bool summoned = false;
        time_t now = time(nullptr);
        for (int32 i = first; i <= last; ++i)
        {
            if (_respawnCooldowns[i] > now)
                continue;

            if (_controlledSlots[i])
            {
                Creature* current = ObjectAccessor::GetCreature(*_transport, _controlledSlots[i]);
                if (current && current->IsAlive())
                    continue;
            }

            Position spawnPos = SelectSpawnPoint();
            if (Creature* passenger = summoner->SummonCreature(_slotInfo[i].Entry, spawnPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
            {
                if (!passenger->GetTransport())
                    _transport->AddPassenger(passenger, true);
                passenger->ApplySpellImmune(0, IMMUNITY_ID, 49576, true); // death grip

                if (i >= SLOT_MAGE_1 && i <= SLOT_MORTAR_4) // only these npcs are pooled
                {
                    _controlledSlots[i] = passenger->GetGUID();
                    _respawnCooldowns[i] = time_t(0);
                }
                passenger->AI()->SetData(ACTION_SET_SLOT, i);
                summoned = true;
            }
        }

        return summoned;
    }

    void ClearSlot(PassengerSlots slot)
    {
        _controlledSlots[slot] = 0;
        _respawnCooldowns[slot] = time(nullptr) + _slotInfo[slot].Cooldown;
    }

private:
    Position SelectSpawnPoint() const
    {
        float angle = frand(-M_PI * 0.5f, M_PI * 0.5f);
        Position newPos;
        newPos.m_positionX = _spawnPoint->GetPositionX() + 2.0f * std::cos(angle);
        newPos.m_positionY = _spawnPoint->GetPositionY() + 2.0f * std::sin(angle);
        newPos.m_positionZ = _spawnPoint->GetPositionZ();
        newPos.SetOrientation(_spawnPoint->GetOrientation());
        _transport->CalculatePassengerPosition(newPos.m_positionX, newPos.m_positionY, newPos.m_positionZ, &(newPos.m_orientation));
        return newPos;
    }

    uint64 _controlledSlots[MAX_SLOTS];
    time_t _respawnCooldowns[MAX_SLOTS];
    MotionTransport* _transport;
    Position const* _spawnPoint;
    SlotInfo const* _slotInfo;
};

class DelayedMovementEvent : public BasicEvent
{
public:
    DelayedMovementEvent(Creature* owner, Position const& dest) : _owner(owner), _dest(dest) { }

    bool Execute(uint64, uint32) override
    {
        if (!_owner->IsAlive() || !_owner->GetTransport())
            return true;

        float x, y, z, o;
        _dest.GetPosition(x, y, z, o);
        _owner->GetTransport()->CalculatePassengerPosition(x, y, z, &o);
        _owner->GetMotionMaster()->MovePoint(EVENT_CHARGE_PREPATH, x, y, z, false);
        return true;
    }

private:
    Creature* _owner;
    Position const& _dest;
};

class ResetEncounterEvent : public BasicEvent
{
public:
    ResetEncounterEvent(Unit* caster, uint32 spellId, uint64 otherTransport) : _caster(caster), _spellId(spellId), _otherTransport(otherTransport) { }

    bool Execute(uint64, uint32) override
    {
        _caster->CastSpell(_caster, _spellId, true);
        _caster->GetTransport()->ToMotionTransport()->UnloadNonStaticPassengers();
        _caster->GetTransport()->AddObjectToRemoveList();

        if (GameObject* go = HashMapHolder<GameObject>::Find(_otherTransport))
        {
            go->ToMotionTransport()->UnloadNonStaticPassengers();
            go->AddObjectToRemoveList();
        }

        return true;
    }

private:
    Unit* _caster;
    uint32 _spellId;
    uint64 _otherTransport;
};

class npc_gunship : public CreatureScript
{
public:
    npc_gunship() : CreatureScript("npc_gunship") { }

    struct npc_gunshipAI : public NullCreatureAI
    {
        npc_gunshipAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript()), _teamIdInInstance(TeamId(creature->GetInstanceScript()->GetData(DATA_TEAMID_IN_INSTANCE))), _died(false), _summonedFirstMage(false)
        {
            me->SetRegeneratingHealth(false);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
            {
                damage = 0;
                return;
            }

            if (damage >= me->GetHealth())
            {
                JustDied(nullptr);
                damage = me->GetHealth() - 1;
                return;
            }

            if (_summonedFirstMage)
                return;

            if (me->GetTransport()->GetEntry() != uint32(_teamIdInInstance == TEAM_HORDE ? GO_THE_SKYBREAKER_H : GO_ORGRIMS_HAMMER_A))
                return;

            if (!me->HealthBelowPctDamaged(90, damage))
                return;

            _summonedFirstMage = true;
            if (Creature* captain = me->FindNearestCreature(_teamIdInInstance == TEAM_HORDE ? NPC_IGB_MURADIN_BRONZEBEARD : NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                captain->AI()->DoAction(ACTION_SPAWN_MAGE);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (_died || _instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            _died = true;

            bool isVictory = me->GetTransport()->GetEntry() == GO_THE_SKYBREAKER_H || me->GetTransport()->GetEntry() == GO_ORGRIMS_HAMMER_A;
            _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, isVictory ? DONE : FAIL);
            me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, 0);

            if (Creature* creature = me->FindNearestCreature(me->GetEntry() == NPC_ORGRIMS_HAMMER ? NPC_THE_SKYBREAKER : NPC_ORGRIMS_HAMMER, 200.0f))
            {
                _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, creature);
                if (Aura* a = creature->GetAura(SPELL_CHECK_FOR_PLAYERS))
                    a->SetDuration(0);
            }
            _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            if (Aura* a = me->GetAura(SPELL_CHECK_FOR_PLAYERS))
                a->SetDuration(0);

            uint32 explosionSpell = isVictory ? SPELL_EXPLOSION_VICTORY : SPELL_EXPLOSION_WIPE;
            if (MotionTransport* t = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
            {
                Transport::PassengerSet const& passengers = t->GetStaticPassengers();
                for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                {
                    if ((*itr)->GetTypeId() != TYPEID_UNIT || (*itr)->GetEntry() != NPC_GUNSHIP_HULL)
                        continue;
                    (*itr)->ToCreature()->CastSpell((*itr)->ToCreature(), explosionSpell, true);
                }
            }

            uint32 cannonEntry = _teamIdInInstance == TEAM_HORDE ? NPC_HORDE_GUNSHIP_CANNON : NPC_ALLIANCE_GUNSHIP_CANNON;
            if (GameObject* go = _instance->instance->GetGameObject(_instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE)))
                if (MotionTransport* t = go->ToMotionTransport())
                {
                    Transport::PassengerSet const& passengers = t->GetStaticPassengers();
                    for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                    {
                        if ((*itr)->GetTypeId() != TYPEID_UNIT || (*itr)->GetEntry() != cannonEntry)
                            continue;
                        Creature* cannon = (*itr)->ToCreature();
                        cannon->CastSpell(cannon, SPELL_EJECT_ALL_PASSENGERS, true);

                        WorldPacket data(SMSG_PLAYER_VEHICLE_DATA, cannon->GetPackGUID().size() + 4);
                        data.append(cannon->GetPackGUID());
                        data << uint32(0);
                        cannon->SendMessageToSet(&data, true);

                        cannon->RemoveVehicleKit();
                    }
                }

            uint32 creatureEntry = NPC_IGB_MURADIN_BRONZEBEARD;
            uint8 textId = isVictory ? SAY_MURADIN_VICTORY : SAY_MURADIN_WIPE;
            if (_teamIdInInstance == TEAM_HORDE)
            {
                creatureEntry = NPC_IGB_HIGH_OVERLORD_SAURFANG;
                textId = isVictory ? SAY_SAURFANG_VICTORY : SAY_SAURFANG_WIPE;
            }
            if (Creature* creature = me->FindNearestCreature(creatureEntry, 200.0f))
                creature->AI()->Talk(textId);

            if (isVictory)
            {
                if (GameObject* go = HashMapHolder<GameObject>::Find(_instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE)))
                    if (MotionTransport* otherTransport = go->ToMotionTransport())
                        otherTransport->EnableMovement(true);

                me->GetTransport()->ToMotionTransport()->EnableMovement(true);

                if (Creature* ship = me->FindNearestCreature(_teamIdInInstance == TEAM_HORDE ? NPC_ORGRIMS_HAMMER : NPC_THE_SKYBREAKER, 200.0f))
                {
                    ship->CastSpell(ship, SPELL_TELEPORT_PLAYERS_ON_VICTORY, true);
                    ship->CastSpell(ship, SPELL_ACHIEVEMENT, true);
                    ship->CastSpell(ship, SPELL_AWARD_REPUTATION_BOSS_KILL, true);
                }

                for (uint8 i = 0; i < 2; ++i)
                    if (GameObject* go = _instance->instance->GetGameObject(_instance->GetData64(i == 0 ? DATA_ICECROWN_GUNSHIP_BATTLE : DATA_ENEMY_GUNSHIP)))
                        if (MotionTransport* t = go->ToMotionTransport())
                        {
                            Transport::PassengerSet const& passengers = t->GetPassengers();
                            for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                            {
                                if ((*itr)->GetTypeId() != TYPEID_UNIT)
                                    continue;
                                Creature* c = (*itr)->ToCreature();
                                if (c->GetEntry() == NPC_SKYBREAKER_MARINE || c->GetEntry() == NPC_SKYBREAKER_SERGEANT || c->GetEntry() == NPC_KOR_KRON_REAVER || c->GetEntry() == NPC_KOR_KRON_SERGEANT)
                                    c->DespawnOrUnsummon(1);
                            }
                        }
            }
            else
            {
                uint32 teleportSpellId = _teamIdInInstance == TEAM_HORDE ? SPELL_TELEPORT_PLAYERS_ON_RESET_H : SPELL_TELEPORT_PLAYERS_ON_RESET_A;
                me->m_Events.AddEvent(new ResetEncounterEvent(me, teleportSpellId, _instance->GetData64(DATA_ENEMY_GUNSHIP)), me->m_Events.CalculateTime(8000));
            }
        }

        void SetGUID(uint64 guid, int32 id/* = 0*/) override
        {
            if (id != ACTION_SHIP_VISITS_ENEMY && id != ACTION_SHIP_VISITS_SELF)
                return;

            std::map<uint64, uint32>::iterator itr = _shipVisits.find(guid);
            if (itr == _shipVisits.end())
            {
                if (id == ACTION_SHIP_VISITS_ENEMY)
                    _shipVisits[guid] = ACTION_SHIP_VISITS_ENEMY;
            }
            else if (itr->second) // if 0 then achiev already failed
            {
                if (id == ACTION_SHIP_VISITS_SELF)
                {
                    if (itr->second == ACTION_SHIP_VISITS_ENEMY)
                        itr->second = ACTION_SHIP_VISITS_SELF;
                    else if (itr->second == ACTION_SHIP_VISITS_ENEMY_2)
                        itr->second = ACTION_SHIP_VISITS_SELF_2;
                }
                else
                {
                    if (itr->second == ACTION_SHIP_VISITS_SELF)
                    {
                        if (me->GetMap()->Is25ManRaid())
                            itr->second = 0;
                        else
                            itr->second = ACTION_SHIP_VISITS_ENEMY_2;
                    }
                    else if (itr->second == ACTION_SHIP_VISITS_SELF_2)
                        itr->second = 0;
                }
            }
        }

        uint32 GetData(uint32 id) const override
        {
            if (id != ACTION_SHIP_VISITS_ENEMY)
                return 0;

            for (std::map<uint64, uint32>::const_iterator itr = _shipVisits.begin(); itr != _shipVisits.end(); ++itr)
                if (itr->second == 0)
                    return 0;

            return 1;
        }

    private:
        InstanceScript* _instance;
        TeamId _teamIdInInstance;
        std::map<uint64, uint32> _shipVisits;
        bool _died;
        bool _summonedFirstMage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        if (!creature->GetTransport())
            return nullptr;

        return GetIcecrownCitadelAI<npc_gunshipAI>(creature);
    }
};

class npc_high_overlord_saurfang_igb : public CreatureScript
{
public:
    npc_high_overlord_saurfang_igb() : CreatureScript("npc_high_overlord_saurfang_igb") { }

    struct npc_high_overlord_saurfang_igbAI : public ScriptedAI
    {
        npc_high_overlord_saurfang_igbAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            _events.Reset();
            _controller.ResetSlots(TEAM_HORDE, creature->GetTransport()->ToMotionTransport());
            me->SetRegeneratingHealth(false);
            me->m_CombatDistance = 70.0f;
            _firstMageCooldown = time(nullptr) + 45;
            _axethrowersYellCooldown = time_t(0);
            _rocketeersYellCooldown = time_t(0);
            checkTimer = 1000;
        }

        void sGossipSelect(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/) override
        {
            if (!me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                return;
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            me->GetTransport()->setActive(true);
            me->GetTransport()->ToMotionTransport()->EnableMovement(true);
            _events.ScheduleEvent(EVENT_INTRO_H_1, 5000);
            _events.ScheduleEvent(EVENT_INTRO_H_2, 16000);
            _events.ScheduleEvent(EVENT_INTRO_SUMMON_SKYBREAKER, 24600);
            _events.ScheduleEvent(EVENT_INTRO_H_3, 29600);
            _events.ScheduleEvent(EVENT_INTRO_H_4, 39200);
        }

        void EnterCombat(Unit* /*target*/) override
        {
            if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE && !me->HasAura(SPELL_FRIENDLY_BOSS_DAMAGE_MOD))
                me->CastSpell(me, SPELL_FRIENDLY_BOSS_DAMAGE_MOD, true);
            if (!me->HasAura(SPELL_BATTLE_FURY))
                me->CastSpell(me, SPELL_BATTLE_FURY, true);
            _events.CancelEvent(EVENT_CLEAVE);
            _events.ScheduleEvent(EVENT_CLEAVE, urand(3000, 6000));
        }

        void EnterEvadeMode() override
        {
            if (!me->IsAlive())
                return;
            me->DeleteThreatList();
            me->CombatStop(true);
            me->GetMotionMaster()->MoveTargetedHome();
            Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENEMY_GUNSHIP_TALK)
            {
                _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, IN_PROGRESS);
                me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, MUSIC_ENCOUNTER);

                if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                    muradin->AI()->DoAction(ACTION_SPAWN_ALL_ADDS);

                Talk(SAY_SAURFANG_INTRO_5);
                _events.ScheduleEvent(EVENT_INTRO_H_5, 4000);
                _events.ScheduleEvent(EVENT_INTRO_H_6, 11000);
                _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 1);

                if (Creature* skybreaker = me->FindNearestCreature(NPC_THE_SKYBREAKER, 200.0f))
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, skybreaker, 1);
                if (Creature* orgrimsHammer = me->FindNearestCreature(NPC_ORGRIMS_HAMMER, 200.0f))
                {
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, orgrimsHammer, 2);
                    orgrimsHammer->CastSpell(orgrimsHammer, SPELL_CHECK_FOR_PLAYERS, true);
                }
            }
            else if (action == ACTION_SPAWN_MAGE)
            {
                time_t now = time(nullptr);
                if (_firstMageCooldown > now)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, (_firstMageCooldown - now) * IN_MILLISECONDS);
                else
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 1);
            }
            else if (action == ACTION_SPAWN_ALL_ADDS)
            {
                _events.ScheduleEvent(EVENT_ADDS, 12000);
                _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 13000);
                _events.ScheduleEvent(EVENT_CHECK_MORTAR, 13000);
                if (Is25ManRaid())
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MORTAR_4);
                else
                {
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MORTAR_1, SLOT_MORTAR_2);
                    _controller.SummonCreatures(me, SLOT_RIFLEMAN_1, SLOT_RIFLEMAN_4);
                }
            }
            else if (action == ACTION_EXIT_SHIP)
            {
                G3D::Vector3 points[SaurfangExitPathSize];
                for (uint8 i = 0; i < SaurfangExitPathSize; ++i)
                {
                    points[i].x = SaurfangExitPath[i].GetPositionX();
                    points[i].y = SaurfangExitPath[i].GetPositionY();
                    points[i].z = SaurfangExitPath[i].GetPositionZ();
                }
                Movement::PointsArray path(points, points + SaurfangExitPathSize);
                me->SetWalk(true);
                Movement::MoveSplineInit init(me);
                init.DisableTransportPathTransformations();
                init.MovebyPath(path, 0);
                init.Launch();
                me->DespawnOrUnsummon(18000);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == ACTION_CLEAR_SLOT)
            {
                _controller.ClearSlot(PassengerSlots(data));
                if (data == SLOT_FREEZE_MAGE)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, urand(30000, 33500));
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HealthBelowPctDamaged(65, damage) && !me->HasAura(SPELL_TASTE_OF_BLOOD))
                me->CastSpell(me, SPELL_TASTE_OF_BLOOD, true);

            if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
            {
                if (me->GetVictim())
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                    {
                        if (me->GetVictim()->GetPositionZ() >= 478.0f)
                        {
                            float x, y, z, o;
                            me->GetHomePosition(x, y, z, o);
                            me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                        }
                    }
                    else
                    {
                        if (me->GetVictim()->GetPositionZ() < 478.0f)
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                    }
                }

                if (checkTimer <= diff)
                {
                    checkTimer = 1000;
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                            {
                                me->SetInCombatWith(p);
                                p->SetInCombatWith(me);
                                me->AddThreat(p, 0.0f);
                            }
                }
                else
                    checkTimer -= diff;
            }

            UpdateVictim();
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_H_1:
                    Talk(SAY_SAURFANG_INTRO_1);
                    break;
                case EVENT_INTRO_H_2:
                    Talk(SAY_SAURFANG_INTRO_2);
                    break;
                case EVENT_INTRO_SUMMON_SKYBREAKER:
                    sTransportMgr->CreateTransport(GO_THE_SKYBREAKER_H, 0, me->GetMap());
                    break;
                case EVENT_INTRO_H_3:
                    Talk(SAY_SAURFANG_INTRO_3);
                    break;
                case EVENT_INTRO_H_4:
                    Talk(SAY_SAURFANG_INTRO_4);
                    break;
                case EVENT_INTRO_H_5:
                    if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        muradin->AI()->Talk(SAY_MURADIN_INTRO_H);
                    break;
                case EVENT_INTRO_H_6:
                    Talk(SAY_SAURFANG_INTRO_6);
                    break;
                case EVENT_KEEP_PLAYER_IN_COMBAT:
                    if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
                    {
                        //_instance->DoCastSpellOnPlayers(SPELL_LOCK_PLAYERS_AND_TAP_CHEST);
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (!p->IsGameMaster())
                                    p->SetInCombatState(true);
                        _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 4000);
                    }
                    break;

                case EVENT_SUMMON_MAGE:
                    Talk(SAY_SAURFANG_MAGES);
                    _controller.SummonCreatures(me, SLOT_FREEZE_MAGE, SLOT_FREEZE_MAGE);
                    break;
                case EVENT_ADDS:
                    Talk(SAY_SAURFANG_ENTER_SKYBREAKER);
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MARINE_1, Is25ManRaid() ? SLOT_MARINE_4 : SLOT_MARINE_2);
                    _controller.SummonCreatures(me, SLOT_SERGEANT_1, Is25ManRaid() ? SLOT_SERGEANT_2 : SLOT_SERGEANT_1);
                    if (MotionTransport* orgrimsHammer = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
                    {
                        float x, y, z, o;
                        OrgrimsHammerTeleportPortal.GetPosition(x, y, z, o);
                        orgrimsHammer->CalculatePassengerPosition(x, y, z, &o);
                        me->SummonCreature(NPC_TELEPORT_PORTAL, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 21000);
                    }

                    if (GameObject* go = HashMapHolder<GameObject>::Find(_instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE)))
                        if (MotionTransport* skybreaker = go->ToMotionTransport())
                        {
                            float x, y, z, o;
                            SkybreakerTeleportExit.GetPosition(x, y, z, o);
                            skybreaker->CalculatePassengerPosition(x, y, z, &o);
                            me->SummonCreature(NPC_TELEPORT_EXIT, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 23000);
                        }

                    _events.ScheduleEvent(EVENT_ADDS_BOARD_YELL, 6000);
                    _events.ScheduleEvent(EVENT_ADDS, 60000);
                    break;
                case EVENT_ADDS_BOARD_YELL:
                    if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        muradin->AI()->Talk(SAY_MURADIN_BOARD);
                    break;
                case EVENT_CHECK_RIFLEMAN:
                    if (_controller.SummonCreatures(me, SLOT_RIFLEMAN_1, Is25ManRaid() ? SLOT_RIFLEMAN_8 : SLOT_RIFLEMAN_4))
                    {
                        if (_axethrowersYellCooldown < time(nullptr))
                        {
                            Talk(SAY_SAURFANG_AXETHROWERS);
                            _axethrowersYellCooldown = time(nullptr) + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 1500);
                    break;
                case EVENT_CHECK_MORTAR:
                    if (_controller.SummonCreatures(me, SLOT_MORTAR_1, Is25ManRaid() ? SLOT_MORTAR_4 : SLOT_MORTAR_2))
                    {
                        if (_rocketeersYellCooldown < time(nullptr))
                        {
                            Talk(SAY_SAURFANG_ROCKETEERS);
                            _rocketeersYellCooldown = time(nullptr) + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_MORTAR, 1500);
                    break;
                case EVENT_CLEAVE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    _events.ScheduleEvent(EVENT_CLEAVE, urand(4000, 8000));
                    break;

                default:
                    break;
            }

            if (!me->GetVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
                DoMeleeAttackIfReady();
            else if (me->isAttackReady())
            {
                me->SetOrientation(me->GetAngle(me->GetVictim()));
                me->CastSpell(me->GetVictim(), SPELL_RENDING_THROW, false);
                me->resetAttackTimer();
            }
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
            {
                if (victim->GetPositionZ() < 478.0f)
                    me->GetMotionMaster()->MoveChase(victim);
                else
                {
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                }
            }
        }

        bool CanAIAttack(const Unit* target) const override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return false;
            if (target->GetEntry() == NPC_SKYBREAKER_MARINE || target->GetEntry() == NPC_SKYBREAKER_SERGEANT)
                return target->ToCreature()->GetReactState() != REACT_PASSIVE;
            return target->GetTransport() == me->GetTransport() && target->GetPositionY() < (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? 2431.0f : 2025.0f);
        }

    private:
        EventMap _events;
        PassengerController _controller;
        InstanceScript* _instance;
        time_t _firstMageCooldown;
        time_t _axethrowersYellCooldown;
        time_t _rocketeersYellCooldown;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_high_overlord_saurfang_igbAI>(creature);
    }
};

class npc_muradin_bronzebeard_igb : public CreatureScript
{
public:
    npc_muradin_bronzebeard_igb() : CreatureScript("npc_muradin_bronzebeard_igb") { }

    struct npc_muradin_bronzebeard_igbAI : public ScriptedAI
    {
        npc_muradin_bronzebeard_igbAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            _events.Reset();
            _controller.ResetSlots(TEAM_ALLIANCE, creature->GetTransport()->ToMotionTransport());
            me->SetRegeneratingHealth(false);
            me->m_CombatDistance = 70.0f;
            _firstMageCooldown = time(nullptr) + 45;
            _riflemanYellCooldown = time_t(0);
            _mortarYellCooldown = time_t(0);
            checkTimer = 1000;
        }

        void sGossipSelect(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/) override
        {
            if (!me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                return;
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            me->GetTransport()->setActive(true);
            me->GetTransport()->ToMotionTransport()->EnableMovement(true);
            _events.ScheduleEvent(EVENT_INTRO_A_1, 5000);
            _events.ScheduleEvent(EVENT_INTRO_A_2, 10000);
            _events.ScheduleEvent(EVENT_INTRO_SUMMON_ORGRIMS_HAMMER, 28000);
            _events.ScheduleEvent(EVENT_INTRO_A_3, 33000);
            _events.ScheduleEvent(EVENT_INTRO_A_4, 39000);
            _events.ScheduleEvent(EVENT_INTRO_A_5, 45000);
        }

        void EnterCombat(Unit* /*target*/) override
        {
            if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE && !me->HasAura(SPELL_FRIENDLY_BOSS_DAMAGE_MOD))
                me->CastSpell(me, SPELL_FRIENDLY_BOSS_DAMAGE_MOD, true);
            if (!me->HasAura(SPELL_BATTLE_FURY))
                me->CastSpell(me, SPELL_BATTLE_FURY, true);
            _events.CancelEvent(EVENT_CLEAVE);
            _events.ScheduleEvent(EVENT_CLEAVE, urand(3000, 6000));
        }

        void EnterEvadeMode() override
        {
            if (!me->IsAlive())
                return;
            me->DeleteThreatList();
            me->CombatStop(true);
            me->GetMotionMaster()->MoveTargetedHome();
            Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENEMY_GUNSHIP_TALK)
            {
                _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, IN_PROGRESS);
                me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, MUSIC_ENCOUNTER);

                if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                    saurfang->AI()->DoAction(ACTION_SPAWN_ALL_ADDS);

                Talk(SAY_MURADIN_INTRO_6);
                _events.ScheduleEvent(EVENT_INTRO_A_6, 5000);
                _events.ScheduleEvent(EVENT_INTRO_A_7, 11000);
                _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 1);

                if (Creature* orgrimsHammer = me->FindNearestCreature(NPC_ORGRIMS_HAMMER, 200.0f))
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, orgrimsHammer, 1);
                if (Creature* skybreaker = me->FindNearestCreature(NPC_THE_SKYBREAKER, 200.0f))
                {
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, skybreaker, 2);
                    skybreaker->CastSpell(skybreaker, SPELL_CHECK_FOR_PLAYERS, true);
                }
            }
            else if (action == ACTION_SPAWN_MAGE)
            {
                time_t now = time(nullptr);
                if (_firstMageCooldown > now)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, (_firstMageCooldown - now) * IN_MILLISECONDS);
                else
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 1);
            }
            else if (action == ACTION_SPAWN_ALL_ADDS)
            {
                _events.ScheduleEvent(EVENT_ADDS, 12000);
                _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 13000);
                _events.ScheduleEvent(EVENT_CHECK_MORTAR, 13000);
                if (Is25ManRaid())
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MORTAR_4);
                else
                {
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MORTAR_1, SLOT_MORTAR_2);
                    _controller.SummonCreatures(me, SLOT_RIFLEMAN_1, SLOT_RIFLEMAN_4);
                }
            }
            else if (action == ACTION_EXIT_SHIP)
            {
                G3D::Vector3 points[MuradinExitPathSize];
                for (uint8 i = 0; i < MuradinExitPathSize; ++i)
                {
                    points[i].x = MuradinExitPath[i].GetPositionX();
                    points[i].y = MuradinExitPath[i].GetPositionY();
                    points[i].z = MuradinExitPath[i].GetPositionZ();
                }
                Movement::PointsArray path(points, points + MuradinExitPathSize);
                me->SetWalk(true);
                Movement::MoveSplineInit init(me);
                init.DisableTransportPathTransformations();
                init.MovebyPath(path, 0);
                init.Launch();
                me->DespawnOrUnsummon(18000);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == ACTION_CLEAR_SLOT)
            {
                _controller.ClearSlot(PassengerSlots(data));
                if (data == SLOT_FREEZE_MAGE)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, urand(30000, 33500));
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HealthBelowPctDamaged(65, damage) && !me->HasAura(SPELL_TASTE_OF_BLOOD))
                me->CastSpell(me, SPELL_TASTE_OF_BLOOD, true);

            if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
            {
                if (me->GetVictim())
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                    {
                        if (me->GetVictim()->GetPositionZ() >= 478.0f)
                        {
                            float x, y, z, o;
                            me->GetHomePosition(x, y, z, o);
                            me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                        }
                    }
                    else
                    {
                        if (me->GetVictim()->GetPositionZ() < 478.0f)
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                    }
                }

                if (checkTimer <= diff)
                {
                    checkTimer = 1000;
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                            {
                                me->SetInCombatWith(p);
                                p->SetInCombatWith(me);
                                me->AddThreat(p, 0.0f);
                            }
                }
                else
                    checkTimer -= diff;
            }

            UpdateVictim();
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_A_1:
                    Talk(SAY_MURADIN_INTRO_1);
                    break;
                case EVENT_INTRO_A_2:
                    Talk(SAY_MURADIN_INTRO_2);
                    break;
                case EVENT_INTRO_SUMMON_ORGRIMS_HAMMER:
                    sTransportMgr->CreateTransport(GO_ORGRIMS_HAMMER_A, 0, me->GetMap());
                    break;
                case EVENT_INTRO_A_3:
                    Talk(SAY_MURADIN_INTRO_3);
                    break;
                case EVENT_INTRO_A_4:
                    Talk(SAY_MURADIN_INTRO_4);
                    break;
                case EVENT_INTRO_A_5:
                    Talk(SAY_MURADIN_INTRO_5);
                    break;
                case EVENT_INTRO_A_6:
                    if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                        saurfang->AI()->Talk(SAY_SAURFANG_INTRO_A);
                    break;
                case EVENT_INTRO_A_7:
                    Talk(SAY_MURADIN_INTRO_7);
                    break;
                case EVENT_KEEP_PLAYER_IN_COMBAT:
                    if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
                    {
                        //_instance->DoCastSpellOnPlayers(SPELL_LOCK_PLAYERS_AND_TAP_CHEST);
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (!p->IsGameMaster())
                                    p->SetInCombatState(true);
                        _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 4000);
                    }
                    break;

                case EVENT_SUMMON_MAGE:
                    Talk(SAY_MURADIN_SORCERERS);
                    _controller.SummonCreatures(me, SLOT_FREEZE_MAGE, SLOT_FREEZE_MAGE);
                    break;
                case EVENT_ADDS:
                    Talk(SAY_MURADIN_ENTER_ORGRIMMS_HAMMER);
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MARINE_1, Is25ManRaid() ? SLOT_MARINE_4 : SLOT_MARINE_2);
                    _controller.SummonCreatures(me, SLOT_SERGEANT_1, Is25ManRaid() ? SLOT_SERGEANT_2 : SLOT_SERGEANT_1);
                    if (MotionTransport* skybreaker = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
                    {
                        float x, y, z, o;
                        SkybreakerTeleportPortal.GetPosition(x, y, z, o);
                        skybreaker->CalculatePassengerPosition(x, y, z, &o);
                        me->SummonCreature(NPC_TELEPORT_PORTAL, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 21000);
                    }

                    if (GameObject* go = HashMapHolder<GameObject>::Find(_instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE)))
                        if (MotionTransport* orgrimsHammer = go->ToMotionTransport())
                        {
                            float x, y, z, o;
                            OrgrimsHammerTeleportExit.GetPosition(x, y, z, o);
                            orgrimsHammer->CalculatePassengerPosition(x, y, z, &o);
                            me->SummonCreature(NPC_TELEPORT_EXIT, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 23000);
                        }

                    _events.ScheduleEvent(EVENT_ADDS_BOARD_YELL, 6000);
                    _events.ScheduleEvent(EVENT_ADDS, 60000);
                    break;
                case EVENT_ADDS_BOARD_YELL:
                    if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                        saurfang->AI()->Talk(SAY_SAURFANG_BOARD);
                    break;
                case EVENT_CHECK_RIFLEMAN:
                    if (_controller.SummonCreatures(me, SLOT_RIFLEMAN_1, Is25ManRaid() ? SLOT_RIFLEMAN_8 : SLOT_RIFLEMAN_4))
                    {
                        if (_riflemanYellCooldown < time(nullptr))
                        {
                            Talk(SAY_MURADIN_RIFLEMAN);
                            _riflemanYellCooldown = time(nullptr) + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 1500);
                    break;
                case EVENT_CHECK_MORTAR:
                    if (_controller.SummonCreatures(me, SLOT_MORTAR_1, Is25ManRaid() ? SLOT_MORTAR_4 : SLOT_MORTAR_2))
                    {
                        if (_mortarYellCooldown < time(nullptr))
                        {
                            Talk(SAY_MURADIN_MORTAR);
                            _mortarYellCooldown = time(nullptr) + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_MORTAR, 1500);
                    break;
                case EVENT_CLEAVE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    _events.ScheduleEvent(EVENT_CLEAVE, urand(4000, 8000));
                    break;

                default:
                    break;
            }

            if (!me->GetVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
                DoMeleeAttackIfReady();
            else if (me->isAttackReady())
            {
                me->SetOrientation(me->GetAngle(me->GetVictim()));
                me->CastSpell(me->GetVictim(), SPELL_RENDING_THROW, false);
                me->resetAttackTimer();
            }
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
            {
                if (victim->GetPositionZ() < 478.0f)
                    me->GetMotionMaster()->MoveChase(victim);
                else
                {
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                }
            }
        }

        bool CanAIAttack(const Unit* target) const override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return false;
            if (target->GetEntry() == NPC_KOR_KRON_REAVER || target->GetEntry() == NPC_KOR_KRON_SERGEANT)
                return target->ToCreature()->GetReactState() != REACT_PASSIVE;
            return target->GetTransport() == me->GetTransport() && target->GetPositionY() > (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE ? 2042.0f : 2445.0f);
        }

    private:
        EventMap _events;
        PassengerController _controller;
        InstanceScript* _instance;
        time_t _firstMageCooldown;
        time_t _riflemanYellCooldown;
        time_t _mortarYellCooldown;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_muradin_bronzebeard_igbAI>(creature);
    }
};

class npc_zafod_boombox : public CreatureScript
{
public:
    npc_zafod_boombox() : CreatureScript("npc_zafod_boombox") { }

    struct npc_zafod_boomboxAI : public NullCreatureAI
    {
        npc_zafod_boomboxAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
        {
            player->AddItem(ITEM_GOBLIN_ROCKET_PACK, 1);
            player->PlayerTalkClass->SendCloseGossip();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_zafod_boomboxAI>(creature);
    }
};

class npc_igb_ship_crew : public CreatureScript
{
public:
    npc_igb_ship_crew() : CreatureScript("npc_igb_ship_crew") { }

    struct npc_igb_ship_crewAI : public ScriptedAI
    {
        npc_igb_ship_crewAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        bool CanAIAttack(const Unit* target) const override
        {
            return _instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() == me->GetTransport() && target->GetPositionZ() < 478.0f && (me->GetEntry() == NPC_SKYBREAKER_DECKHAND ? (target->GetPositionY() > 2042.0f) : (target->GetPositionY() < 2431.0f));
        }
    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_igb_ship_crewAI>(creature);
    }
};

void TriggerBurningPitch(Creature* c)
{
    InstanceScript* i = c->GetInstanceScript();
    uint32 spellId = i->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SPELL_BURNING_PITCH_A : SPELL_BURNING_PITCH_H;
    if (!c->HasSpellCooldown(spellId))
    {
        c->CastSpell((Unit*)NULL, spellId, false);
        c->_AddCreatureSpellCooldown(spellId, urand(3000, 4000));
    }
}

struct gunship_npc_AI : public ScriptedAI
{
    gunship_npc_AI(Creature* creature) : ScriptedAI(creature), Instance(creature->GetInstanceScript()), Slot(nullptr), Index(uint32(-1))
    {
        me->SetRegeneratingHealth(false);
    }

    void SetData(uint32 type, uint32 data) override
    {
        if (type == ACTION_SET_SLOT)
        {
            SetSlotInfo(data);
            me->SetReactState(REACT_PASSIVE);
            float x, y, z, o;
            Slot->TargetPosition.GetPosition(x, y, z, o);
            me->SetTransportHomePosition(Slot->TargetPosition);
            me->GetTransport()->CalculatePassengerPosition(x, y, z, &o);
            me->SetHomePosition(x, y, z, o);
            me->GetMotionMaster()->MovePoint(EVENT_CHARGE_PREPATH, x, y, z, false);
        }
    }

    void EnterEvadeMode() override
    {
        if (!me->IsAlive() || !me->IsInCombat())
            return;
        me->DeleteThreatList();
        me->CombatStop(true);
        me->GetMotionMaster()->MoveTargetedHome();
        Reset();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Slot)
            if (Creature* captain = me->FindNearestCreature(Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? NPC_IGB_MURADIN_BRONZEBEARD : NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                captain->AI()->SetData(ACTION_CLEAR_SLOT, Index);
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
        {
            me->SetFacingTo(Slot->TargetPosition.GetOrientation());
            me->m_Events.AddEvent(new BattleExperienceEvent(me), me->m_Events.CalculateTime(BattleExperienceEvent::ExperiencedTimes[0]));
            me->CastSpell(me, SPELL_BATTLE_EXPERIENCE, true);
            me->SetReactState(REACT_AGGRESSIVE);
        }
    }

protected:
    void SetSlotInfo(uint32 index)
    {
        Index = index;
        Slot = &((Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SkybreakerSlotInfo : OrgrimsHammerSlotInfo)[Index]);
    }

    InstanceScript* Instance;
    SlotInfo const* Slot;
    uint32 Index;
};

struct npc_gunship_boarding_addAI : public ScriptedAI
{
    npc_gunship_boarding_addAI(Creature* creature) : ScriptedAI(creature), Instance(creature->GetInstanceScript()), Slot(nullptr), Index(uint32(-1))
    {
        anyValid = true;
        checkTimer = 1000;
        _usedDesperateResolve = false;
        me->m_CombatDistance = 70.0f;
        me->SetRegeneratingHealth(false);
    }

    void SetData(uint32 type, uint32 data) override
    {
        if (type == ACTION_SET_SLOT)
        {
            SetSlotInfo(data);
            me->SetReactState(REACT_PASSIVE);
            me->m_Events.AddEvent(new DelayedMovementEvent(me, Slot->TargetPosition), me->m_Events.CalculateTime(3000 * (Index - SLOT_MARINE_1)));
        }
    }

    void EnterEvadeMode() override
    {
        if (!me->IsAlive() || !me->IsInCombat())
            return;
        me->DeleteThreatList();
        me->CombatStop(true);
        me->GetMotionMaster()->MoveTargetedHome();
        Reset();
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (_usedDesperateResolve)
            return;
        if (!me->HealthBelowPctDamaged(25, damage))
            return;
        _usedDesperateResolve = true;
        me->CastSpell(me, SPELL_DESPERATE_RESOLVE, true);
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
        {
            me->SetFacingTo(Slot->TargetPosition.GetOrientation());
            me->m_Events.AddEvent(new BattleExperienceEvent(me), me->m_Events.CalculateTime(BattleExperienceEvent::ExperiencedTimes[0]));
            me->CastSpell(me, SPELL_BATTLE_EXPERIENCE, true);
            me->SetReactState(REACT_AGGRESSIVE);

            Position const& otherTransportPos = Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? OrgrimsHammerTeleportExit : SkybreakerTeleportExit;
            float x, y, z, o;
            otherTransportPos.GetPosition(x, y, z, o);

            Transport* myTransport = me->GetTransport();
            if (!myTransport)
                return;

            if (GameObject* go = HashMapHolder<GameObject>::Find(Instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE)))
                if (Transport* destTransport = go->ToTransport())
                    destTransport->CalculatePassengerPosition(x, y, z, &o);

            float angle = frand(0, M_PI * 2.0f);
            x += 2.0f * std::cos(angle);
            y += 2.0f * std::sin(angle);

            me->SetHomePosition(x, y, z, o);
            myTransport->CalculatePassengerOffset(x, y, z, &o);
            me->SetTransportHomePosition(x, y, z, o);

            me->CastSpell(me, SPELL_TELEPORT_TO_ENEMY_SHIP, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (checkTimer <= diff)
        {
            checkTimer = 1000;
            anyValid = false;
            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* p = itr->GetSource())
                    if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                    {
                        anyValid = true;
                        me->SetInCombatWith(p);
                        p->SetInCombatWith(me);
                        me->AddThreat(p, 0.0f);
                    }
        }
        else
            checkTimer -= diff;
    }

    bool CanAIAttack(const Unit* target) const override
    {
        return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() && target->GetTransport() != me->GetTransport() && target->GetPositionZ() < 478.0f && (me->GetEntry() == NPC_SKYBREAKER_SERGEANT || me->GetEntry() == NPC_SKYBREAKER_MARINE ? (target->GetPositionY() < 2431.0f) : (target->GetPositionY() > 2042.0f));
    }

protected:
    void SetSlotInfo(uint32 index)
    {
        Index = index;
        Slot = &((Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SkybreakerSlotInfo : OrgrimsHammerSlotInfo)[Index]);
    }

    bool anyValid;
    uint16 checkTimer;
    bool _usedDesperateResolve;
    InstanceScript* Instance;
    SlotInfo const* Slot;
    uint32 Index;
};

class npc_gunship_boarding_leader : public CreatureScript
{
public:
    npc_gunship_boarding_leader() : CreatureScript("npc_gunship_boarding_leader") { }

    struct npc_gunship_boarding_leaderAI : public npc_gunship_boarding_addAI
    {
        npc_gunship_boarding_leaderAI(Creature* creature) : npc_gunship_boarding_addAI(creature)
        {
        }

        void EnterCombat(Unit*  /*target*/) override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BLADESTORM, urand(13000, 18000));
            _events.ScheduleEvent(EVENT_WOUNDING_STRIKE, urand(5000, 10000));
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            npc_gunship_boarding_addAI::UpdateAI(diff);
            _events.Update(diff);
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasAura(SPELL_BLADESTORM))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_BLADESTORM:
                    me->CastSpell(me->GetVictim(), SPELL_BLADESTORM, false);
                    _events.ScheduleEvent(EVENT_BLADESTORM, urand(25000, 30000));
                    break;
                case EVENT_WOUNDING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_WOUNDING_STRIKE, false);
                    _events.ScheduleEvent(EVENT_WOUNDING_STRIKE, urand(7000, 13000));
                    break;
                default:
                    break;
            }
            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_boarding_leaderAI>(creature);
    }
};

class npc_gunship_boarding_add : public CreatureScript
{
public:
    npc_gunship_boarding_add() : CreatureScript("npc_gunship_boarding_add") { }

    struct npc_gunship_boarding_add_realAI : public npc_gunship_boarding_addAI
    {
        npc_gunship_boarding_add_realAI(Creature* creature) : npc_gunship_boarding_addAI(creature)
        {
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            npc_gunship_boarding_addAI::UpdateAI(diff);
            _events.Update(diff);
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_boarding_add_realAI>(creature);
    }
};

class npc_gunship_mage : public CreatureScript
{
public:
    npc_gunship_mage() : CreatureScript("npc_gunship_mage") { }

    struct npc_gunship_mageAI : public gunship_npc_AI
    {
        npc_gunship_mageAI(Creature* creature) : gunship_npc_AI(creature)
        {
            me->m_CombatDistance = 70.0f;
        }

        void AttackStart(Unit* target) override
        {
            me->Attack(target, false);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
            {
                me->SetFacingTo(Slot->TargetPosition.GetOrientation());
                switch (Index)
                {
                    case SLOT_FREEZE_MAGE:
                        if (Player* player = me->SelectNearestPlayer(50.0f))
                        {
                            me->SetInCombatWithZone();
                            me->AddThreat(player, 1.0f);
                        }
                        me->CastSpell((Unit*)NULL, SPELL_BELOW_ZERO, false);
                        break;
                    case SLOT_MAGE_1:
                    case SLOT_MAGE_2:
                        me->CastSpell((Unit*)NULL, SPELL_SHADOW_CHANNELING, false);
                        break;
                    default:
                        break;
                }

                me->SetControlled(true, UNIT_STATE_ROOT);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            gunship_npc_AI::UpdateAI(diff);
        }

        bool CanAIAttack(const Unit*  /*target*/) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_mageAI>(creature);
    }
};

class npc_gunship_gunner : public CreatureScript
{
public:
    npc_gunship_gunner() : CreatureScript("npc_gunship_gunner") { }

    struct npc_gunship_gunnerAI : public gunship_npc_AI
    {
        npc_gunship_gunnerAI(Creature* creature) : gunship_npc_AI(creature)
        {
            anyValid = true;
            checkTimer = 1000;
            creature->m_CombatDistance = 150.0f;
        }

        void AttackStart(Unit* target) override
        {
            me->Attack(target, false);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            gunship_npc_AI::MovementInform(type, pointId);
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH)
                me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            if (checkTimer <= diff)
            {
                checkTimer = 1000;
                anyValid = false;
                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                    if (Player* p = itr->GetSource())
                        if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                        {
                            anyValid = true;
                            me->SetInCombatWith(p);
                            p->SetInCombatWith(me);
                            me->AddThreat(p, 0.0f);
                        }
            }
            else
                checkTimer -= diff;
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            DoSpellAttackIfReady(me->GetEntry() == NPC_SKYBREAKER_RIFLEMAN ? SPELL_SHOOT : SPELL_HURL_AXE);
        }

        bool CanAIAttack(const Unit* target) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() && target->GetTransport() != me->GetTransport();
        }

    protected:
        bool anyValid;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_gunnerAI>(creature);
    }
};

class npc_gunship_rocketeer : public CreatureScript
{
public:
    npc_gunship_rocketeer() : CreatureScript("npc_gunship_rocketeer") { }

    struct npc_gunship_rocketeerAI : public gunship_npc_AI
    {
        npc_gunship_rocketeerAI(Creature* creature) : gunship_npc_AI(creature)
        {
            creature->m_CombatDistance = 150.0f;
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            gunship_npc_AI::MovementInform(type, pointId);
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH)
                me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;

            UpdateVictim();

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            uint32 spellId = me->GetEntry() == NPC_SKYBREAKER_MORTAR_SOLDIER ? SPELL_ROCKET_ARTILLERY_A : SPELL_ROCKET_ARTILLERY_H;
            if (me->HasSpellCooldown(spellId))
                return;

            me->CastSpell((Unit*)NULL, spellId, true);
            me->_AddCreatureSpellCooldown(spellId, 9000);
        }

        bool CanAIAttack(const Unit*  /*target*/) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_rocketeerAI>(creature);
    }
};

class spell_igb_rocket_pack : public SpellScriptLoader
{
public:
    spell_igb_rocket_pack() : SpellScriptLoader("spell_igb_rocket_pack") { }

    class spell_igb_rocket_pack_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_rocket_pack_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo(
                {
                    SPELL_ROCKET_PACK_DAMAGE,
                    SPELL_ROCKET_BURST
                });
        }

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            if (GetTarget()->movespline->Finalized())
                Remove(AURA_REMOVE_BY_EXPIRE);
        }

        void HandleRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            SpellInfo const* damageInfo = sSpellMgr->GetSpellInfo(SPELL_ROCKET_PACK_DAMAGE);
            GetTarget()->CastCustomSpell(SPELL_ROCKET_PACK_DAMAGE, SPELLVALUE_BASE_POINT0, 2 * (damageInfo->Effects[EFFECT_0].CalcValue() + aurEff->GetTickNumber() * aurEff->GetAmplitude()), NULL, true);
            GetTarget()->CastSpell((Unit*)NULL, SPELL_ROCKET_BURST, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_rocket_pack_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectRemove += AuraEffectRemoveFn(spell_igb_rocket_pack_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_rocket_pack_AuraScript();
    }
};

class spell_igb_rocket_pack_useable : public SpellScriptLoader
{
public:
    spell_igb_rocket_pack_useable() : SpellScriptLoader("spell_igb_rocket_pack_useable") { }

    class spell_igb_rocket_pack_useable_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_rocket_pack_useable_AuraScript);

        bool Load() override
        {
            return GetOwner()->GetInstanceScript();
        }

        bool CheckAreaTarget(Unit* target)
        {
            return target->GetTypeId() == TYPEID_PLAYER && GetOwner()->GetInstanceScript()->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != DONE;
        }

        void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* owner = GetOwner()->ToCreature())
                if (Player* target = GetTarget()->ToPlayer())
                    if (target->HasItemCount(ITEM_GOBLIN_ROCKET_PACK, 1))
                        sCreatureTextMgr->SendChat(owner, SAY_ZAFOD_ROCKET_PACK_ACTIVE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
        }

        void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* owner = GetOwner()->ToCreature())
                if (Player* target = GetTarget()->ToPlayer())
                    if (target->HasItemCount(ITEM_GOBLIN_ROCKET_PACK, 1))
                        sCreatureTextMgr->SendChat(owner, SAY_ZAFOD_ROCKET_PACK_DISABLED, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
        }

        void Register() override
        {
            DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_igb_rocket_pack_useable_AuraScript::CheckAreaTarget);
            AfterEffectApply += AuraEffectApplyFn(spell_igb_rocket_pack_useable_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_igb_rocket_pack_useable_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_rocket_pack_useable_AuraScript();
    }
};

class spell_igb_teleport_to_enemy_ship : public SpellScriptLoader
{
public:
    spell_igb_teleport_to_enemy_ship() : SpellScriptLoader("spell_igb_teleport_to_enemy_ship") { }

    class spell_igb_teleport_to_enemy_ship_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_teleport_to_enemy_ship_SpellScript);

        void RelocateTransportOffset(SpellEffIndex /*effIndex*/)
        {
            WorldLocation const* dest = GetHitDest();
            Unit* target = GetHitUnit();
            if (!dest || !target || !target->GetTransport())
                return;

            float x, y, z, o;
            dest->GetPosition(x, y, z, o);
            target->GetTransport()->CalculatePassengerOffset(x, y, z, &o);
            target->m_movementInfo.transport.pos.Relocate(x, y, z, o);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_igb_teleport_to_enemy_ship_SpellScript::RelocateTransportOffset, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_teleport_to_enemy_ship_SpellScript();
    }
};

class spell_igb_check_for_players : public SpellScriptLoader
{
public:
    spell_igb_check_for_players() : SpellScriptLoader("spell_igb_check_for_players") { }

    class spell_igb_check_for_players_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_check_for_players_SpellScript);

        bool Load() override
        {
            _playerCount = 0;
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void CountTargets(std::list<WorldObject*>& targets)
        {
            _playerCount = targets.size();
        }

        void TriggerWipe()
        {
            if (!_playerCount)
                GetCaster()->ToCreature()->AI()->JustDied(nullptr);
        }

        void TeleportPlayer(SpellEffIndex /*effIndex*/)
        {
            if (GetHitUnit()->GetPositionZ() < GetCaster()->GetPositionZ() - 10.0f)
                GetHitUnit()->CastSpell(GetHitUnit(), SPELL_GUNSHIP_FALL_TELEPORT, true);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_check_for_players_SpellScript::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            AfterCast += SpellCastFn(spell_igb_check_for_players_SpellScript::TriggerWipe);
            OnEffectHitTarget += SpellEffectFn(spell_igb_check_for_players_SpellScript::TeleportPlayer, EFFECT_0, SPELL_EFFECT_DUMMY);
        }

        uint32 _playerCount;
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_check_for_players_SpellScript();
    }
};

class spell_igb_gunship_fall_teleport : public SpellScriptLoader
{
public:
    spell_igb_gunship_fall_teleport() : SpellScriptLoader("spell_igb_gunship_fall_teleport") { }

    class spell_igb_gunship_fall_teleport_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_gunship_fall_teleport_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetInstanceScript();
        }

        void SelectTransport(WorldObject*& target)
        {
            if (InstanceScript* instance = target->GetInstanceScript())
                target = HashMapHolder<GameObject>::Find(instance->GetData64(DATA_ICECROWN_GUNSHIP_BATTLE));
        }

        void RelocateDest(SpellEffIndex /*effIndex*/)
        {
            Position offset = {0.0f, 0.0f, 0.0f, 0.0f};
            offset.m_positionZ = GetCaster()->GetInstanceScript()->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? 36.0f : 21.0f;
            GetHitDest()->RelocateOffset(offset);
        }

        void Register() override
        {
            OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_igb_gunship_fall_teleport_SpellScript::SelectTransport, EFFECT_0, TARGET_DEST_NEARBY_ENTRY);
            OnEffectLaunch += SpellEffectFn(spell_igb_gunship_fall_teleport_SpellScript::RelocateDest, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_gunship_fall_teleport_SpellScript();
    }
};

class spell_igb_explosion_main : public SpellScriptLoader
{
public:
    spell_igb_explosion_main() : SpellScriptLoader("spell_igb_explosion_main") { }

    class spell_igb_explosion_main_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_explosion_main_AuraScript);

        bool Load() override
        {
            tickNo = urand(0, 3);
            return true;
        }

        void PeriodicTick(AuraEffect const* aurEff)
        {
            if ((aurEff->GetTickNumber() % 4) != tickNo)
                PreventDefaultAction();
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_explosion_main_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }

        uint32 tickNo;
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_explosion_main_AuraScript();
    }
};

class IgbExplosionCheck
{
public:
    IgbExplosionCheck(Unit* source) : _source(source) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTransport() != _source->GetTransport();
    }

private:
    Unit* _source;
};

class spell_igb_explosion : public SpellScriptLoader
{
public:
    spell_igb_explosion() : SpellScriptLoader("spell_igb_explosion") { }

    class spell_igb_explosion_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_explosion_SpellScript);

        void SelectTarget(std::list<WorldObject*>& targets)
        {
            targets.remove_if(IgbExplosionCheck(GetCaster()));
            acore::Containers::RandomResizeList(targets, 1);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_explosion_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_explosion_SpellScript();
    }
};

class IgbTeleportOnVictoryCheck
{
public:
    IgbTeleportOnVictoryCheck(InstanceScript* inst) : _inst(inst) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTransGUID() != _inst->GetData64(DATA_ENEMY_GUNSHIP);
    }

private:
    InstanceScript* _inst;
};

class spell_igb_teleport_players_on_victory : public SpellScriptLoader
{
public:
    spell_igb_teleport_players_on_victory() : SpellScriptLoader("spell_igb_teleport_players_on_victory") { }

    class spell_igb_teleport_players_on_victory_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_teleport_players_on_victory_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetInstanceScript();
        }

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            InstanceScript* instance = GetCaster()->GetInstanceScript();
            targets.remove_if(IgbTeleportOnVictoryCheck(instance));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_teleport_players_on_victory_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_teleport_players_on_victory_SpellScript();
    }
};

class spell_igb_periodic_trigger_with_power_cost : public SpellScriptLoader
{
public:
    spell_igb_periodic_trigger_with_power_cost() : SpellScriptLoader("spell_igb_periodic_trigger_with_power_cost") { }

    class spell_igb_periodic_trigger_with_power_cost_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_periodic_trigger_with_power_cost_AuraScript);

        void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            GetTarget()->CastSpell(GetTarget(), GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_periodic_trigger_with_power_cost_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_periodic_trigger_with_power_cost_AuraScript();
    }
};

class spell_igb_overheat : public SpellScriptLoader
{
public:
    spell_igb_overheat() : SpellScriptLoader("spell_igb_overheat") { }

    class spell_igb_overheat_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_overheat_AuraScript);

        bool Load() override
        {
            if (GetAura()->GetType() != UNIT_AURA_TYPE)
                return false;
            return GetUnitOwner()->IsVehicle();
        }

        void SendClientControl(uint8 value)
        {
            if (Vehicle* vehicle = GetUnitOwner()->GetVehicleKit())
            {
                if (Unit* passenger = vehicle->GetPassenger(0))
                {
                    if (Player* player = passenger->ToPlayer())
                    {
                        WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, GetUnitOwner()->GetPackGUID().size() + 1);
                        data.append(GetUnitOwner()->GetPackGUID());
                        data << uint8(value);
                        player->GetSession()->SendPacket(&data);
                    }
                }
            }
        }

        void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            SendClientControl(0);
        }

        void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            SendClientControl(1);
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_igb_overheat_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_igb_overheat_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_overheat_AuraScript();
    }
};

class spell_igb_cannon_blast : public SpellScriptLoader
{
public:
    spell_igb_cannon_blast() : SpellScriptLoader("spell_igb_cannon_blast") { }

    class spell_igb_cannon_blast_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_cannon_blast_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void CheckEnergy()
        {
            if (GetCaster()->GetPower(POWER_ENERGY) >= 100)
            {
                GetCaster()->CastSpell(GetCaster(), SPELL_OVERHEAT, true);
                if (Vehicle* vehicle = GetCaster()->GetVehicleKit())
                    if (Unit* passenger = vehicle->GetPassenger(0))
                        sCreatureTextMgr->SendChat(GetCaster()->ToCreature(), SAY_OVERHEAT, passenger);
            }
        }

        void Register() override
        {
            AfterHit += SpellHitFn(spell_igb_cannon_blast_SpellScript::CheckEnergy);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_cannon_blast_SpellScript();
    }
};

class spell_igb_incinerating_blast : public SpellScriptLoader
{
public:
    spell_igb_incinerating_blast() : SpellScriptLoader("spell_igb_incinerating_blast") { }

    class spell_igb_incinerating_blast_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_incinerating_blast_SpellScript);

        void StoreEnergy()
        {
            _energyLeft = GetCaster()->GetPower(POWER_ENERGY) - 10;
        }

        void RemoveEnergy()
        {
            GetCaster()->SetPower(POWER_ENERGY, 0);
        }

        void CalculateDamage(SpellEffIndex /*effIndex*/)
        {
            PreventHitEffect(EFFECT_0);
            const SpellInfo* si = sSpellMgr->GetSpellInfo(GetSpellInfo()->Effects[0].TriggerSpell);
            if (!si)
                return;
            SpellCastTargets targets;
            Position dest;
            GetExplTargetDest()->GetPosition(&dest);
            targets.SetDst(dest);
            CustomSpellValues values;
            int32 damage = si->Effects[0].CalcValue() + _energyLeft * _energyLeft * 8;
            values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
            values.AddSpellMod(SPELLVALUE_BASE_POINT1, damage);
            values.AddSpellMod(SPELLVALUE_BASE_POINT2, damage);
            GetCaster()->CastSpell(targets, si, &values, TRIGGERED_FULL_MASK);
            //SetEffectValue(GetEffectValue() + _energyLeft * _energyLeft * 8);
        }

        void Register() override
        {
            OnCast += SpellCastFn(spell_igb_incinerating_blast_SpellScript::StoreEnergy);
            AfterCast += SpellCastFn(spell_igb_incinerating_blast_SpellScript::RemoveEnergy);
            OnEffectHit += SpellEffectFn(spell_igb_incinerating_blast_SpellScript::CalculateDamage, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
        }

        uint32 _energyLeft;
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_incinerating_blast_SpellScript();
    }
};

class BurningPitchFilterCheck
{
public:
    BurningPitchFilterCheck(uint32 entry) : _entry(entry) {}

    bool operator()(WorldObject* unit)
    {
        if (Transport* transport = unit->GetTransport())
            return transport->GetEntry() != _entry;
        return true;
    }

private:
    uint32 _entry;
};

class spell_igb_burning_pitch_selector : public SpellScriptLoader
{
public:
    spell_igb_burning_pitch_selector() : SpellScriptLoader("spell_igb_burning_pitch_selector") { }

    class spell_igb_burning_pitch_selector_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_burning_pitch_selector_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            TeamId teamId = TEAM_HORDE;
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                teamId = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));

            targets.remove_if(BurningPitchFilterCheck(teamId == TEAM_HORDE ? GO_ORGRIMS_HAMMER_H : GO_THE_SKYBREAKER_A));
            if (!targets.empty())
            {
                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }
        }

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), TRIGGERED_NONE);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_burning_pitch_selector_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            OnEffectHitTarget += SpellEffectFn(spell_igb_burning_pitch_selector_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_burning_pitch_selector_SpellScript();
    }
};

class spell_igb_burning_pitch : public SpellScriptLoader
{
public:
    spell_igb_burning_pitch() : SpellScriptLoader("spell_igb_burning_pitch") { }

    class spell_igb_burning_pitch_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_burning_pitch_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->CastCustomSpell(uint32(GetEffectValue()), SPELLVALUE_BASE_POINT0, 8000, NULL, TRIGGERED_FULL_MASK);
            GetHitUnit()->CastSpell(GetHitUnit(), SPELL_BURNING_PITCH, TRIGGERED_FULL_MASK);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_igb_burning_pitch_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_burning_pitch_SpellScript();
    }
};

class IgbArtilleryCheck
{
public:
    IgbArtilleryCheck(uint32 entry) : _entry(entry) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTypeId() != TYPEID_PLAYER || unit->GetPositionZ() > 478.0f || !unit->GetTransport() || unit->GetTransport()->GetEntry() != _entry
        || unit->GetMapHeight(unit->GetPhaseMask(), unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ()) < 465.0f;
    }

private:
    uint32 _entry;
};

class spell_igb_rocket_artillery : public SpellScriptLoader
{
public:
    spell_igb_rocket_artillery() : SpellScriptLoader("spell_igb_rocket_artillery") { }

    class spell_igb_rocket_artillery_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_rocket_artillery_SpellScript);

        void SelectRandomTarget(std::list<WorldObject*>& targets)
        {
            TeamId teamId = TEAM_HORDE;
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                teamId = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));
            targets.remove_if(IgbArtilleryCheck(teamId == TEAM_HORDE ? GO_ORGRIMS_HAMMER_H : GO_THE_SKYBREAKER_A));

            if (!targets.empty())
            {
                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }
        }

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->CastSpell(GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(),
                GetHitUnit()->GetMapHeight(GetCaster()->GetPhaseMask(), GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(), GetHitUnit()->GetPositionZ()),
                uint32(GetEffectValue()), TRIGGERED_NONE);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_rocket_artillery_SpellScript::SelectRandomTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_igb_rocket_artillery_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_rocket_artillery_SpellScript();
    }
};

class spell_igb_rocket_artillery_explosion : public SpellScriptLoader
{
public:
    spell_igb_rocket_artillery_explosion() : SpellScriptLoader("spell_igb_rocket_artillery_explosion") { }

    class spell_igb_rocket_artillery_explosion_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_rocket_artillery_explosion_SpellScript);

        void DamageGunship(SpellEffIndex /*effIndex*/)
        {
            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                GetCaster()->CastCustomSpell(instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SPELL_BURNING_PITCH_DAMAGE_A : SPELL_BURNING_PITCH_DAMAGE_H, SPELLVALUE_BASE_POINT0, 5000, NULL, TRIGGERED_FULL_MASK);
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_igb_rocket_artillery_explosion_SpellScript::DamageGunship, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_rocket_artillery_explosion_SpellScript();
    }
};

class spell_igb_below_zero : public SpellScriptLoader
{
public:
    spell_igb_below_zero() : SpellScriptLoader("spell_igb_below_zero") { }

    class spell_igb_below_zero_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_igb_below_zero_SpellScript);

        void RemovePassengers()
        {
            GetHitUnit()->SetPower(POWER_ENERGY, 0);
            GetHitUnit()->CastSpell(GetHitUnit(), SPELL_EJECT_ALL_PASSENGERS, TRIGGERED_FULL_MASK);
        }

        void Register() override
        {
            BeforeHit += SpellHitFn(spell_igb_below_zero_SpellScript::RemovePassengers);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_igb_below_zero_SpellScript();
    }
};

class spell_igb_on_gunship_deck : public SpellScriptLoader
{
public:
    spell_igb_on_gunship_deck() : SpellScriptLoader("spell_igb_on_gunship_deck") { }

    class spell_igb_on_gunship_deck_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_igb_on_gunship_deck_AuraScript);

        bool Load() override
        {
            if (InstanceScript* instance = GetOwner()->GetInstanceScript())
                _teamIdInInstance = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));
            else
                _teamIdInInstance = TEAM_ALLIANCE;
            return true;
        }

        bool CheckAreaTarget(Unit* unit)
        {
            return unit->GetTypeId() == TYPEID_PLAYER;
        }

        void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            bool enemy = GetSpellInfo()->Id == uint32(_teamIdInInstance == TEAM_HORDE ? SPELL_ON_SKYBREAKER_DECK : SPELL_ON_ORGRIMS_HAMMER_DECK);
            if (Creature* gunship = GetOwner()->FindNearestCreature(_teamIdInInstance == TEAM_HORDE ? NPC_ORGRIMS_HAMMER : NPC_THE_SKYBREAKER, 200.0f))
                gunship->AI()->SetGUID(GetTarget()->GetGUID(), enemy ? ACTION_SHIP_VISITS_ENEMY : ACTION_SHIP_VISITS_SELF);
        }

        void Register() override
        {
            DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_igb_on_gunship_deck_AuraScript::CheckAreaTarget);
            AfterEffectApply += AuraEffectApplyFn(spell_igb_on_gunship_deck_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }

        TeamId _teamIdInInstance;
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_igb_on_gunship_deck_AuraScript();
    }
};

class achievement_im_on_a_boat : public AchievementCriteriaScript
{
public:
    achievement_im_on_a_boat() : AchievementCriteriaScript("achievement_im_on_a_boat") { }

    bool OnCheck(Player* /*source*/, Unit* target) override
    {
        return target->GetAI() && target->GetAI()->GetData(ACTION_SHIP_VISITS_ENEMY) == 1;
    }
};

void AddSC_boss_icecrown_gunship_battle()
{
    new npc_gunship();
    new npc_high_overlord_saurfang_igb();
    new npc_muradin_bronzebeard_igb();
    new npc_zafod_boombox();
    new npc_igb_ship_crew();
    new npc_gunship_boarding_leader();
    new npc_gunship_boarding_add();
    new npc_gunship_mage();
    new npc_gunship_gunner();
    new npc_gunship_rocketeer();
    new spell_igb_rocket_pack();
    new spell_igb_rocket_pack_useable();
    new spell_igb_teleport_to_enemy_ship();
    new spell_igb_check_for_players();
    new spell_igb_gunship_fall_teleport();
    new spell_igb_explosion_main();
    new spell_igb_explosion();
    new spell_igb_teleport_players_on_victory();
    new spell_igb_periodic_trigger_with_power_cost();
    new spell_igb_overheat();
    new spell_igb_cannon_blast();
    new spell_igb_incinerating_blast();
    new spell_igb_burning_pitch_selector();
    new spell_igb_burning_pitch();
    new spell_igb_rocket_artillery();
    new spell_igb_rocket_artillery_explosion();
    new spell_igb_below_zero();
    new spell_igb_on_gunship_deck();
    new achievement_im_on_a_boat();
}
