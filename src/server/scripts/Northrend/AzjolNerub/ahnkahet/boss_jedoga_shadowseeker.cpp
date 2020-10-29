/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "Containers.h"
#include "ObjectAccessor.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "TemporarySummon.h"

enum Yells
{
    TEXT_AGGRO          = 0,
    TEXT_SACRIFICE_1    = 1,
    TEXT_SACRIFICE_2    = 2,
    TEXT_SLAY           = 3,
    TEXT_DEATH          = 4,
    TEXT_PREACHING      = 5,

    // Initiate
    SAY_CHOSEN          = 0,
    SAY_SACRIFICED      = 1,
};

enum Spells
{
    // VISUALS
    SPELL_SPHERE_VISUAL                     = 56075,
    SPELL_WHITE_SPHERE                      = 56102,
    SPELL_LIGHTNING_BOLTS                   = 56327,
    SPELL_ACTIVATE_INITIATE                 = 56868,
    SPELL_SACRIFICE_VISUAL                  = 56133,
    SPELL_SACRIFICE_BEAM                    = 56150,
    SPELL_HOVER_FALL                        = 56100,
    SPELL_BEAM_VISUAL_JEDOGA                = 56312,

    // FIGHT
    SPELL_GIFT_OF_THE_HERALD                = 56219,
    SPELL_CYCLONE_STRIKE                    = 56855, // Self
    SPELL_CYCLONE_STRIKE_H                  = 60030,
    SPELL_LIGHTNING_BOLT                    = 56891, // 40Y
    SPELL_LIGHTNING_BOLT_H                  = 60032, // 40Y
    SPELL_THUNDERSHOCK                      = 56926, // 30Y
    SPELL_THUNDERSHOCK_H                    = 60029  // 30Y
};

enum Events
{
    // Jedoga
    EVENT_JEDOGA_CYCLONE                    = 1,
    EVENT_JEDOGA_LIGHTNING_BOLT             = 2,
    EVENT_JEDOGA_THUNDERSHOCK               = 3,
    EVENT_JEDOGA_PREPARE_RITUAL             = 4,
    EVENT_JEDOGA_MOVE_UP                    = 5,
    EVENT_JEDOGA_MOVE_DOWN                  = 6,

    // Initiate
    EVENT_RITUAL_BEGIN_MOVE                 = 7,
};

enum Creatures
{
    NPC_TWILIGHT_INITIATE                   = 30114,
    NPC_TWILIGHT_VOLUNTEER                  = 30385,
};

enum Misc
{
    MAX_COMBAT_INITIATES                    = 25,
    DATA_VOLUNTEER_WORK                     = 1,
};

enum SummonGroups
{
    SUMMON_GROUP_OOC                        = 0,
    SUMMON_GROUP_OOC_TRIGGERS               = 1,
};

enum Points
{
    POINT_DOWN                              = 1,
    POINT_UP                                = 2,
    POINT_RITUAL                            = 3,
    POINT_INITIAL                           = 4,
};

enum Phases
{
    PHASE_NORMAL                            = 0x01,
    PHASE_RITUAL                            = 0x02,
};

enum Actions
{
    ACTION_RITUAL_BEGIN                     = 1,
    ACTION_SACRAFICE                        = 2,
};

const Position JedogaPosition[3] =
{
    { 372.330994f, -705.278015f, -2.459692f },      // POINT_DOWN
    { 372.330994f, -705.278015f, -16.179716f },     // POINT_UP
    { 373.48f, -706.00f, -16.18f, 0.0f }            // POINT_RITUAL and POINT_INITIAL. This positions also is used for visual trigger used for ritual
};

// Combat summon locations
const Position VolunteerSpotPositions[MAX_COMBAT_INITIATES][2] =
{
        //        Spawn position           ||            Move position
    { { 400.7701f, -784.8928f, -31.60143f }, { 365.9514f, -719.1235f, -16.17974f } },
    { { 397.3595f, -788.5157f, -31.59679f }, { 359.7433f, -715.017f,  -16.17974f } },
    { { 399.3177f, -787.2599f, -31.59631f }, { 362.0263f, -719.1036f, -16.17974f } },
    { { 460.4623f, -719.2227f, -31.58718f }, { 389.266f,  -679.3693f, -16.17973f } },
    { { 456.0909f, -724.3412f, -31.58718f }, { 400.5992f, -691.7954f, -16.17973f } },
    { { 452.6613f, -726.9518f, -31.58718f }, { 400.3423f, -701.5115f, -16.17974f } },
    { { 447.8852f, -732.3298f, -31.58718f }, { 389.861f,  -710.6993f, -16.17974f } },
    { { 457.562f,  -721.1855f, -31.58718f }, { 395.4494f, -684.5345f, -16.17973f } },
    { { 451.7243f, -730.2181f, -31.58718f }, { 397.0945f, -708.4188f, -15.99747f } },
    { { 413.9582f, -777.132f,  -31.58716f }, { 388.1394f, -723.124f,  -15.9938f  } },
    { { 411.5661f, -781.2356f, -31.58716f }, { 381.7102f, -730.0745f, -15.99554f } },
    { { 407.395f,  -786.793f,  -31.58716f }, { 366.9791f, -737.3303f, -16.17974f } },
    { { 404.9166f, -788.3472f, -31.58716f }, { 358.6124f, -735.9944f, -15.9855f  } },
    { { 401.5697f, -791.2033f, -31.58717f }, { 351.9383f, -729.6436f, -16.17974f } },
    { { 410.1105f, -785.4691f, -31.58716f }, { 373.1659f, -736.2893f, -16.17974f } },
    { { 442.5644f, -730.2499f, -31.59826f }, { 390.5955f, -714.6851f, -16.17974f } },
    { { 445.5233f, -725.9542f, -31.60173f }, { 393.9694f, -708.1727f, -16.17974f } },
    { { 448.5531f, -722.5888f, -31.60066f }, { 395.2702f, -702.556f,  -16.17974f } },
    { { 449.8521f, -719.7265f, -31.58849f }, { 394.5757f, -695.1004f, -16.17974f } },
    { { 453.5134f, -717.7018f, -31.59883f }, { 387.6152f, -690.1782f, -16.17974f } },
    { { 457.8564f, -711.7424f, -31.59773f }, { 378.6874f, -687.1343f, -16.17973f } },
    { { 410.0583f, -774.4119f, -31.60115f }, { 383.8151f, -723.4276f, -16.17974f } },
    { { 408.7458f, -777.955f,  -31.59873f }, { 376.9857f, -725.0735f, -16.17974f } },
    { { 405.2404f, -779.6614f, -31.60512f }, { 373.3736f, -722.7498f, -16.17974f } },
    { { 404.0797f, -783.829f,  -31.59497f }, { 367.8631f, -722.5212f, -16.17974f } }
};

class boss_jedoga_shadowseeker : public CreatureScript
{
public:
    boss_jedoga_shadowseeker() : CreatureScript("boss_jedoga_shadowseeker") { }

    struct boss_jedoga_shadowseekerAI : public BossAI
    {
        boss_jedoga_shadowseekerAI(Creature* pCreature) : BossAI(pCreature, DATA_JEDOGA_SHADOWSEEKER),
            combatSummonsSummoned(false),
            ritualTriggered(false),
            volunteerWork(true)
        {
        }

        void Reset() override
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);

            _Reset();
            events.SetPhase(PHASE_NORMAL);
            ReschedulleCombatEvents();

            DespawnOOCSummons();
            std::list<TempSummon*> tempOOCSummons;
            me->SummonCreatureGroup(SUMMON_GROUP_OOC, &tempOOCSummons);
            if (!tempOOCSummons.empty())
            {
                for (TempSummon* summon : tempOOCSummons)
                {
                    if (summon)
                    {
                        summon->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
                        summon->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_MAGIC, false);
                        summon->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                        summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                        summon->SetStandState(UNIT_STAND_STATE_KNEEL);
                        oocSummons.push_back(summon->GetGUID());
                    }
                }
            }

            tempOOCSummons.clear();

            me->SummonCreatureGroup(SUMMON_GROUP_OOC_TRIGGERS, &tempOOCSummons);
            if (!tempOOCSummons.empty())
            {
                for (TempSummon* trigger : tempOOCSummons)
                {
                    if (trigger)
                    {
                        oocTriggers.push_back(trigger->GetGUID());
                    }
                }
            }

            sacraficeTarget_GUID = 0;
            ritualTriggered = false;
            volunteerWork = true;
            combatSummonsSummoned = false;

            me->SetDisableGravity(true);
            me->SetHover(true);
            me->GetMotionMaster()->MovePoint(POINT_INITIAL, JedogaPosition[0], false);
        }

        // Disabled events
        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_JEDOGA_CONTROLLER)
            {
                summons.Summon(summon);
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void SummonedCreatureDies(Creature* summon, Unit* killer) override
        {
            switch (summon->GetEntry())
            {
                case NPC_TWILIGHT_INITIATE:
                {
                    std::list<uint64>::iterator itr = std::find(oocSummons.begin(), oocSummons.end(), summon->GetGUID());
                    if (itr == oocSummons.end())
                    {
                        break;
                    }

                    oocSummons.erase(itr);
                    if (!oocSummons.empty())
                    {
                        break;
                    }

                    DespawnOOCSummons();
                    DoCastSelf(SPELL_HOVER_FALL);
                    me->GetMotionMaster()->MoveIdle();
                    me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);

                    if (!combatSummonsSummoned)
                    {
                        summons.DespawnEntry(NPC_TWILIGHT_VOLUNTEER);
                        for (uint8 i = 0; i < MAX_COMBAT_INITIATES; ++i)
                        {
                            if (TempSummon* summon = me->SummonCreature(NPC_TWILIGHT_VOLUNTEER, VolunteerSpotPositions[i][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                            {
                                summon->GetMotionMaster()->MovePoint(POINT_INITIAL, VolunteerSpotPositions[i][1]);
                                summon->SetReactState(REACT_PASSIVE);
                                summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC );
                                summons.Summon(summon);
                            }
                        }
                        combatSummonsSummoned = true;
                    }

                    break;
                }
                case NPC_TWILIGHT_VOLUNTEER:
                {
                    if (sacraficeTarget_GUID && summon->GetGUID() != sacraficeTarget_GUID)
                    {
                        break;
                    }

                    if (killer != me && killer->GetGUID() != sacraficeTarget_GUID)
                    {
                        volunteerWork = false;
                    }
                    else
                    {
                        DoCastSelf(SPELL_GIFT_OF_THE_HERALD, true);
                    }
                    events.ScheduleEvent(EVENT_JEDOGA_MOVE_DOWN, 1000, 0, PHASE_RITUAL);
                    break;
                }
            }

            summons.Despawn(summon);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
        {
            if (!ritualTriggered && me->HealthBelowPctDamaged(55, damage) && events.IsInPhase(PHASE_NORMAL))
            {
                SetCombatMovement(false);
                me->InterruptNonMeleeSpells(false);
                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                events.SetPhase(PHASE_RITUAL);
                events.ScheduleEvent(EVENT_JEDOGA_PREPARE_RITUAL, 1000, 0, PHASE_RITUAL);
                ritualTriggered = true;
                return;
            }

            if (events.IsInPhase(PHASE_RITUAL))
            {
                damage = 0;
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_SACRAFICE)
            {
                if (Creature* target = ObjectAccessor::GetCreature(*me, sacraficeTarget_GUID))
                {
                    Unit::Kill(me, target);
                }
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(TEXT_AGGRO);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
            {
                return;
            }

            Talk(TEXT_SLAY);
        }

        void JustDied(Unit* /*Killer*/) override
        {
            _JustDied();
            Talk(TEXT_DEATH);
        }
        
        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (!(type == POINT_MOTION_TYPE || type == EFFECT_MOTION_TYPE)) 
            {
                return;
            }

            switch (pointId)
            {
                case POINT_DOWN:
                {
                    me->ClearUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                    ReschedulleCombatEvents();
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);

                    me->RemoveAurasDueToSpell(SPELL_SPHERE_VISUAL);
                    me->RemoveAurasDueToSpell(SPELL_LIGHTNING_BOLTS);
                    me->RemoveAurasDueToSpell(SPELL_HOVER_FALL);
                    SetCombatMovement(true);

                    me->SetDisableGravity(false);
                    me->SetHover(false);

                    me->SetInCombatWithZone();
                    if (Unit* victim = me->GetVictim())
                    {
                        me->StopMoving();
                        AttackStart(victim);
                    }
                }break;
                case POINT_UP:
                {
                    me->SetFacingTo(5.66f);
                    if (!summons.empty())
                    {
                        sacraficeTarget_GUID = acore::Containers::SelectRandomContainerElement(summons);
                        if (Creature* volunteer = ObjectAccessor::GetCreature(*me, sacraficeTarget_GUID))
                        {
                            Talk(TEXT_SACRIFICE_1);
                            sacraficeTarget_GUID = volunteer->GetGUID();
                            volunteer->AI()->DoAction(ACTION_RITUAL_BEGIN);
                        }
                        // Something failed, let players continue but do not grant achievement
                        else
                        {
                            volunteerWork = false;
                            me->GetMotionMaster()->Clear();
                            DoCastSelf(SPELL_HOVER_FALL);
                            me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);
                        }
                    }
                    break;
                }
                case POINT_RITUAL:
                {
                    me->SetFacingTo(5.66f);
                    DoCastSelf(SPELL_HOVER_FALL);
                    events.ScheduleEvent(EVENT_JEDOGA_MOVE_UP, 1000, 0, PHASE_RITUAL);
                    break;
                }
                case POINT_INITIAL:
                {
                    me->SetFacingTo(5.66f);
                    DoCastSelf(SPELL_SPHERE_VISUAL, true);
                    DoCastSelf(SPELL_LIGHTNING_BOLTS, true);
                    if (!oocTriggers.empty())
                    {
                        for (uint64 const guid : oocTriggers)
                        {
                            if (Creature* trigger = ObjectAccessor::GetCreature(*me, guid))
                            {
                                trigger->CastSpell(nullptr, SPELL_BEAM_VISUAL_JEDOGA);
                            }
                        }
                    }
                    break;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    // Normal phase
                    case EVENT_JEDOGA_CYCLONE:
                    {
                        DoCastSelf(DUNGEON_MODE(SPELL_CYCLONE_STRIKE, SPELL_CYCLONE_STRIKE_H), false);
                        events.RepeatEvent(urand(10000, 14000));
                        break;
                    }
                    case EVENT_JEDOGA_LIGHTNING_BOLT:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        {
                            DoCast(pTarget, DUNGEON_MODE(SPELL_LIGHTNING_BOLT, SPELL_LIGHTNING_BOLT_H), false);
                        }
                        events.RepeatEvent(urand(11000, 15000));
                        break;
                    }
                    case EVENT_JEDOGA_THUNDERSHOCK:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        {
                            DoCast(pTarget, DUNGEON_MODE(SPELL_THUNDERSHOCK, SPELL_THUNDERSHOCK_H), false);
                        }

                        events.RepeatEvent(urand(16000, 22000));
                        break;
                    }
                    // Ritual phase
                    case EVENT_JEDOGA_PREPARE_RITUAL:
                    {
                        me->GetMotionMaster()->Clear(true);
                        me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[1]);
                        break;
                    }
                    case EVENT_JEDOGA_MOVE_UP:
                    {
                        me->GetMotionMaster()->Clear(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->GetMotionMaster()->MoveTakeoff(POINT_UP, JedogaPosition[0], 7.0f);
                        break;
                    }
                    case EVENT_JEDOGA_MOVE_DOWN:
                    {
                        summons.DespawnEntry(NPC_JEDOGA_CONTROLLER);
                        DoCastSelf(SPELL_HOVER_FALL);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_VOLUNTEER_WORK)
            {
                return volunteerWork ? 1 : 0;
            }

            return 0;
        }

    private:
        std::list<uint64> oocSummons;
        std::list<uint64> oocTriggers;

        uint64 sacraficeTarget_GUID;

        bool combatSummonsSummoned;
        bool ritualTriggered;
        bool volunteerWork; // true = success, false = failed

        void ReschedulleCombatEvents()
        {
            events.SetPhase(PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_CYCLONE, 3000, 0, PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_LIGHTNING_BOLT, 7000, 0, PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_THUNDERSHOCK, 12000, 0, PHASE_NORMAL);
        }

        void DespawnOOCSummons()
        {
            if (!oocTriggers.empty())
            {
                for (uint64 const guid : oocTriggers)
                {
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                    {
                        summon->DespawnOrUnsummon();
                    }
                }
                oocTriggers.clear();
            }

            if (!oocSummons.empty())
            {
                for (uint64 const guid : oocSummons)
                {
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                    {
                        summon->DespawnOrUnsummon();
                    }
                }
                oocSummons.clear();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_jedoga_shadowseekerAI(creature);
    }
};

class npc_twilight_volunteer : public CreatureScript
{
public:
    npc_twilight_volunteer() : CreatureScript("npc_twilight_volunteer") { }

    struct npc_twilight_volunteerAI : public ScriptedAI
    {
        npc_twilight_volunteerAI(Creature* pCreature) : ScriptedAI(pCreature),
            pInstance(pCreature->GetInstanceScript()),
            isSacraficeTarget(false)
        {
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_RITUAL_BEGIN)
            {
                isSacraficeTarget = true;
                me->SetRegeneratingHealth(false);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                DoCastSelf(SPELL_ACTIVATE_INITIATE, true);
                me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);

                Talk(SAY_CHOSEN);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                
                events.ScheduleEvent(EVENT_RITUAL_BEGIN_MOVE, 1500);
            }
        }

        void EnterEvadeMode() override
        {
            if (!isSacraficeTarget)
            {
                ScriptedAI::EnterEvadeMode();
            }
        }

        void AttackStart(Unit* who) override
        {
            if (!isSacraficeTarget)
            {
                ScriptedAI::AttackStart(who);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
            {
                return;
            }
            
            if (id == POINT_INITIAL)
            {
                me->SetFacingTo(me->GetAngle(&JedogaPosition[0]));
                me->SendMovementFlagUpdate();
                DoCastSelf(SPELL_WHITE_SPHERE, false);
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
            }
            else if (id == POINT_RITUAL)
            {
                if (Creature* jedoga = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_JEDOGA_SHADOWSEEKER)))
                {
                    jedoga->AI()->Talk(TEXT_SACRIFICE_2);
                    jedoga->CastSpell(nullptr, SPELL_SACRIFICE_BEAM);
                    if (Creature* ritualTrigger = jedoga->SummonCreature(NPC_JEDOGA_CONTROLLER, JedogaPosition[2], TEMPSUMMON_TIMED_DESPAWN, 5000))
                    {
                        ritualTrigger->CastSpell(ritualTrigger, SPELL_SACRIFICE_VISUAL);
                    }
                }

                Talk(SAY_SACRIFICED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            if (events.ExecuteEvent() == EVENT_RITUAL_BEGIN_MOVE)
            {
                me->GetMotionMaster()->Clear();
                me->SetHomePosition(JedogaPosition[2]);
                me->SetWalk(true);
                me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[2], false);
            }

            if (isSacraficeTarget)
            {
                return;
            }

            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();
            }           
        }

    private:
        InstanceScript* pInstance;
        EventMap events;
        bool isSacraficeTarget;
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_twilight_volunteerAI(creature);
    }
};

// 56328 - Random Lightning Visual Effect
class spell_random_lightning_visual_effect : public SpellScriptLoader
{
    public:
        spell_random_lightning_visual_effect() : SpellScriptLoader("spell_random_lightning_visual_effect") { }

    class spell_random_lightning_visual_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_random_lightning_visual_effect_SpellScript);

        void ModDestHeight(SpellDestination& dest)
        {
            Position const offset = { frand(-15.0f, 15.0f), frand(-15.0f, 15.0f), -19.0f, 0.0f };
            dest.RelocateOffset(offset);
        }

        void Register() override
        {
            OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_random_lightning_visual_effect_SpellScript::ModDestHeight, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_random_lightning_visual_effect_SpellScript();
    }
};

// 56150 - Sacrifice Beam
class spell_jedoga_sacrafice_beam : public SpellScriptLoader
{
    public:
        spell_jedoga_sacrafice_beam() : SpellScriptLoader("spell_jedoga_sacrafice_beam") { }

    class spell_jedoga_sacrafice_beam_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_jedoga_sacrafice_beam_AuraScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleRemoval(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            AuraRemoveMode const removeMode = GetTargetApplication()->GetRemoveMode();
            if (removeMode == AURA_REMOVE_BY_DEFAULT || removeMode == AURA_REMOVE_BY_EXPIRE)
            {
                GetCaster()->ToCreature()->AI()->DoAction(ACTION_SACRAFICE);
            }
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_jedoga_sacrafice_beam_AuraScript::HandleRemoval, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_jedoga_sacrafice_beam_AuraScript();
    }
};

// CriteriaID 7359, Volunteer Work (2056)
class achievement_volunteer_work : public AchievementCriteriaScript
{
    public:
        achievement_volunteer_work() : AchievementCriteriaScript("achievement_volunteer_work")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target) override
        {
            if (Creature const* jedoga = target ? target->ToCreature() : nullptr)
            {
                return jedoga->AI()->GetData(DATA_VOLUNTEER_WORK) == 1;
            }

            return false;
        }
};

void AddSC_boss_jedoga_shadowseeker()
{
    // Creatures
    new boss_jedoga_shadowseeker();
    new npc_twilight_volunteer();

    // Spells
    new spell_random_lightning_visual_effect();
    new spell_jedoga_sacrafice_beam();

    // Achievements
    new achievement_volunteer_work();
}
