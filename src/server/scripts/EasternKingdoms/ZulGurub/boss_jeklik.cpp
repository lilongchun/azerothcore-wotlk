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

#include "GameObjectAI.h"
#include "MoveSplineInit.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "SpellScript.h"
#include "TaskScheduler.h"
#include "WaypointMgr.h"
#include "zulgurub.h"

enum Says
{
    // Jeklik
    SAY_AGGRO                           = 0,
    SAY_CALL_RIDERS                     = 1,
    SAY_DEATH                           = 2,
    EMOTE_SUMMON_BATS                   = 3,
    EMOTE_GREAT_HEAL                    = 4,

    // Bat Rider
    EMOTE_BATRIDER_LOW_HEALTH            = 0
};

enum Spells
{
    // Intro
    SPELL_GREEN_CHANNELING              = 13540,
    SPELL_BAT_FORM                      = 23966,

    // Phase one
    SPELL_PIERCE_ARMOR                  = 12097,
    SPELL_BLOOD_LEECH                   = 22644,
    SPELL_CHARGE                        = 22911,
    SPELL_SONIC_BURST                   = 23918,
    SPELL_SWOOP                         = 23919,

    // Phase two
    SPELL_CURSE_OF_BLOOD                = 16098,
    SPELL_PSYCHIC_SCREAM                = 22884,
    SPELL_SHADOW_WORD_PAIN              = 23952,
    SPELL_MIND_FLAY                     = 23953,
    SPELL_GREATER_HEAL                  = 23954,

    // Bat Rider (Boss)
    SPELL_BATRIDER_THROW_LIQUID_FIRE    = 23970,
    SPELL_BATRIDER_SUMMON_LIQUID_FIRE   = 23971,

    // Bat Rider (Trash)
    SPELL_BATRIDER_DEMO_SHOUT           = 23511,
    SPELL_BATRIDER_BATTLE_COMMAND       = 5115,
    SPELL_BATRIDER_INFECTED_BITE        = 16128,
    SPELL_BATRIDER_PASSIVE_THRASH       = 8876,
    SPELL_BATRIDER_UNSTABLE_CONCOCTION  = 24024
};

enum BatIds
{
    NPC_BLOODSEEKER_BAT                 = 11368,
    NPC_BATRIDER                        = 14750
};

enum Events
{
    // Phase one
    EVENT_CHARGE_JEKLIK                 = 1,
    EVENT_PIERCE_ARMOR,
    EVENT_BLOOD_LEECH,
    EVENT_SONIC_BURST,
    EVENT_SWOOP,
    EVENT_SPAWN_BATS,

    // Phase two
    EVENT_CURSE_OF_BLOOD,
    EVENT_PSYCHIC_SCREAM,
    EVENT_SHADOW_WORD_PAIN,
    EVENT_MIND_FLAY,
    EVENT_GREATER_HEAL,
    EVENT_SPAWN_FLYING_BATS,

    // Bat Riders (Boss)
    EVENT_BATRIDER_THROW_BOMB,

    // Bat Riders (Trash)
    EVENT_BATRIDER_DEMO_SHOUT,
    EVENT_BATRIDER_BATTLE_COMMAND,
    EVENT_BATRIDER_INFECTED_BITE,
    EVENT_BATRIDER_UNSTABLE_CONCOCTION
};

enum Phase
{
    PHASE_ONE                           = 1,
    PHASE_TWO                           = 2
};

Position const SpawnBat[6] =
{
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f }
};

Position const SpawnBatRider = { -12301.689, -1371.2921, 145.09244 };
Position const JeklikCaveHomePosition = { -12291.9f, -1380.08f, 144.902f, 2.28638f };

enum PathID
{
    PATH_JEKLIK_INTRO                   = 145170,
    PATH_BATRIDER_LOOP                  = 147500
};

enum BatRiderMode
{
    BATRIDER_MODE_TRASH                 = 1,
    BATRIDER_MODE_BOSS
};

// High Priestess Jeklik (14517)
struct boss_jeklik : public BossAI
{
    // Bat Riders (14750) counter
    uint8 batRidersCount = 0;

    boss_jeklik(Creature* creature) : BossAI(creature, DATA_JEKLIK) { }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
    }

    void Reset() override
    {
        BossAI::Reset();

        // allow the scheduler to interrupt casting
        scheduler.ClearValidator();

        // start invisible so we can setup the green channeling effect
        me->SetVisible(false);

        me->SetHomePosition(JeklikCaveHomePosition);

        me->SetDisableGravity(false);
        me->SetReactState(REACT_PASSIVE);
        BossAI::SetCombatMovement(false);
        batRidersCount = 0;

        // once the path for her to come down to the ground starts, it appears to be near-impossible to stop it
        // instead, simply wait the 3 seconds it takes the path to complete, then teleport her home
        scheduler.Schedule(3s, [this](TaskContext)
        {
            // teleport back to cave
            float x, y, z, o;
            JeklikCaveHomePosition.GetPosition(x, y, z, o);

            me->NearTeleportTo(x, y, z, o);
        });

        // casting effect
        scheduler.Schedule(4s, [this](TaskContext)
        {
            DoCastSelf(SPELL_GREEN_CHANNELING, true);

        });

        // restore visibility and unlock root
        scheduler.Schedule(5s, [this](TaskContext)
        {
            me->SetVisible(true);
            me->ClearUnitState(UNIT_STATE_ROOT);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        // don't interrupt casting
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        // cancel the casting effect if it hasn't happened already
        scheduler.CancelAll();

        Talk(SAY_AGGRO);
        DoZoneInCombat();

        me->RemoveAurasDueToSpell(SPELL_GREEN_CHANNELING);
        me->SetDisableGravity(true);
        DoCastSelf(SPELL_BAT_FORM, true);

        me->GetMotionMaster()->MovePath(PATH_JEKLIK_INTRO, false);
    }

    void PathEndReached(uint32 pathId) override
    {
        BossAI::PathEndReached(pathId);

        me->SetDisableGravity(false);
        SetCombatMovement(true);
        me->SetReactState(REACT_AGGRESSIVE);

        scheduler.CancelAll();

        //
        // PHASE 1
        //
        // Charge
        scheduler.Schedule(10s, 20s, PHASE_ONE, [this](TaskContext context) {
            // charge the nearest player that is at least 8 yards away (charge min distance)
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, -8.0f, false, false))
            {
                LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: Charge successful (target: {})", target->GetName());
                DoCast(target, SPELL_CHARGE);
                AttackStart(target);
            }
            else
            {
                LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: Charge failed (no target available)");
            }
            context.Repeat(15s, 30s);
        // Pierce Armor
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context) {
            DoCastVictim(SPELL_PIERCE_ARMOR);
            context.Repeat(20s, 30s);
        // Blood Leech
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context) {
            DoCastVictim(SPELL_BLOOD_LEECH);
            context.Repeat(10s, 20s);
        // Sonic Burst
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context) {
            DoCastVictim(SPELL_SONIC_BURST);
            context.Repeat(20s, 30s);
        // Swoop
        }).Schedule(20s, PHASE_ONE, [this](TaskContext context) {
            DoCastVictim(SPELL_SWOOP);
            context.Repeat(20s, 30s);
        // Spawn Cave Bats
        }).Schedule(30s, PHASE_ONE, [this](TaskContext context) {
            Talk(EMOTE_SUMMON_BATS);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                for (uint8 i = 0; i < 6; ++i)
                {
                    if (Creature* bat = me->SummonCreature(NPC_BLOODSEEKER_BAT, SpawnBat[i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                    {
                        bat->AI()->AttackStart(target);
                    }
                }
            }
            context.Repeat(30s);
        });

        //
        // Phase 2 (@ 50% health)
        //
        ScheduleHealthCheckEvent(50, [&] {
            LOG_DEBUG("scripts.ai", "boss_jeklik:: PHASE TWO");
            me->RemoveAurasDueToSpell(SPELL_BAT_FORM);
            DoResetThreatList();

            scheduler.CancelGroup(PHASE_ONE);

            // Curse of Blood
            scheduler.Schedule(5s, 15s, PHASE_TWO, [this](TaskContext context) {
                DoCastSelf(SPELL_CURSE_OF_BLOOD);
                context.Repeat(25s, 30s);
            // Psychic Scream
            }).Schedule(25s, 35s, PHASE_TWO, [this](TaskContext context) {
                DoCastVictim(SPELL_PSYCHIC_SCREAM);
                context.Repeat(35s, 45s);
            // Shadow Word: Pain
            }).Schedule(10s, 15s, PHASE_TWO, [this](TaskContext context) {
                DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN, 0, true);
                context.Repeat(12s, 18s);
            // Mind Flay
            }).Schedule(10s, 30s, PHASE_TWO, [this](TaskContext context) {
                DoCastVictim(SPELL_MIND_FLAY);
                context.Repeat(20s, 40s);
            // Greater Heal
            }).Schedule(25s, PHASE_TWO, [this](TaskContext context) {
                Talk(EMOTE_GREAT_HEAL);
                me->InterruptNonMeleeSpells(false);
                DoCastSelf(SPELL_GREATER_HEAL);
                context.Repeat(25s);
            // Spawn Flying Bats
            }).Schedule(10s, PHASE_TWO, [this](TaskContext context) {
                if (me->GetThreatMgr().GetThreatListSize())
                {
                    // summon up to 2 bat riders
                    if (batRidersCount < 2)
                    {
                        LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: Spawn Flying Bats (Summoning {} of 2)", batRidersCount + 1);
                        Talk(SAY_CALL_RIDERS);
                        // only if the bat rider was successfully created
                        if (me->SummonCreature(NPC_BATRIDER, SpawnBatRider, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                        {
                            // increase the counter
                            batRidersCount++;
                        }
                        if (batRidersCount == 1)
                        {
                            context.Repeat(10s, 15s);
                        }
                    }
                }
            });
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        // enter evade mode
        BossAI::EnterEvadeMode(why);

        if (why != EvadeReason::EVADE_REASON_NO_PATH)
        {
            // make invisible to hide wonky-looking movement
            me->SetVisible(false);

            // cancel any pending moves and stop moving
            me->GetMotionMaster()->Clear();
            me->AddUnitState(UNIT_STATE_ROOT);

            Reset();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        // ensures that the scheduler gets updated even out of combat
        scheduler.Update(diff);

        BossAI::UpdateAI(diff);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
};

// Gurubashi Bat Rider (14750) - trash and boss summon are same creature ID
struct npc_batrider : public CreatureAI
{
    BatRiderMode _mode; // the version of this creature (trash or boss)

    npc_batrider(Creature* creature) : CreatureAI(creature)
    {
        // if this is a summon of Jeklik, it is in boss mode
        if
        (
            me->GetEntry() == NPC_BATRIDER &&
            me->IsSummon() &&
            me->ToTempSummon() &&
            me->ToTempSummon()->GetSummoner() &&
            me->ToTempSummon()->GetSummoner()->GetEntry() == NPC_PRIESTESS_JEKLIK
        )
        {
            LOG_DEBUG("scripts.ai", "npc_batrider::constructor: BATRIDER_MODE_BOSS");
            _mode = BATRIDER_MODE_BOSS;

            // make the bat rider unattackable
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

            // keep the bat from attacking players directly
            me->SetReactState(REACT_PASSIVE);

            // make the bat rider move the correct speed
            me->SetSpeed(MOVE_WALK, 5.0f, true);

        }
        // otherwise, trash mode
        else
        {
            LOG_DEBUG("scripts.ai", "npc_batrider::constructor: BATRIDER_MODE_TRASH");
            me->SetReactState(REACT_DEFENSIVE);
            _mode = BATRIDER_MODE_TRASH;
        }
    }

    void Reset() override
    {
        CreatureAI::Reset();

        switch (_mode)
        {
            case BATRIDER_MODE_BOSS:
                events.Reset();
                me->GetMotionMaster()->Clear();
                break;
            case BATRIDER_MODE_TRASH:
                events.Reset();

                // apply the Thrash (8876) spell to the bat rider (passive ability)
                me->CastSpell(me, SPELL_BATRIDER_PASSIVE_THRASH);

                break;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        CreatureAI::JustEngagedWith(who);

        switch (_mode)
        {
            case BATRIDER_MODE_BOSS:
                events.ScheduleEvent(EVENT_BATRIDER_THROW_BOMB, 2s);
                break;
            case BATRIDER_MODE_TRASH:
                events.ScheduleEvent(EVENT_BATRIDER_DEMO_SHOUT, 1s);
                events.ScheduleEvent(EVENT_BATRIDER_BATTLE_COMMAND, 8s);
                events.ScheduleEvent(EVENT_BATRIDER_INFECTED_BITE, 6500ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (_mode == BATRIDER_MODE_BOSS)
        {
            // if the creature isn't moving, run the loop
            if (!me->isMoving())
            {
                LOG_DEBUG("scripts.ai", "npc_batrider::UpdateAI: not moving, running loop");
                // enable flying
                me->SetDisableGravity(true);
                // send the rider on its loop
                me->GetMotionMaster()->MoveSplinePath(PATH_BATRIDER_LOOP);
            }

            // event handling
            switch (events.ExecuteEvent())
            {
                case EVENT_BATRIDER_THROW_BOMB:
                    LOG_DEBUG("scripts.ai", "npc_batrider::UpdateAI: EVENT_BATRIDER_THROW_BOMB");
                    DoCastRandomTarget(SPELL_BATRIDER_THROW_LIQUID_FIRE);
                    events.ScheduleEvent(EVENT_BATRIDER_THROW_BOMB, 8s);
                    break;
                default:
                    break;
            }
        }
        else if (_mode == BATRIDER_MODE_TRASH)
        {
            if (!UpdateVictim())
            {
                return;
            }

            // don't interrupt casting
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // if health goes below 30%, cast Unstable Concoction
            if (me->HealthBelowPct(30))
            {
                events.ScheduleEvent(EVENT_BATRIDER_UNSTABLE_CONCOCTION, 0);
            }

            // event handling
            switch (events.ExecuteEvent())
            {
                case EVENT_BATRIDER_DEMO_SHOUT:
                    DoCastSelf(SPELL_BATRIDER_DEMO_SHOUT);
                    break;
                case EVENT_BATRIDER_BATTLE_COMMAND:
                    DoCastSelf(SPELL_BATRIDER_BATTLE_COMMAND);
                    events.ScheduleEvent(EVENT_BATRIDER_BATTLE_COMMAND, 25s);
                    break;
                case EVENT_BATRIDER_INFECTED_BITE:
                    DoCastVictim(SPELL_BATRIDER_INFECTED_BITE);
                    events.ScheduleEvent(EVENT_BATRIDER_INFECTED_BITE, 8s);
                    break;
                case EVENT_BATRIDER_UNSTABLE_CONCOCTION:
                    Talk(EMOTE_BATRIDER_LOW_HEALTH);
                    DoCastSelf(SPELL_BATRIDER_UNSTABLE_CONCOCTION);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    }
};

class spell_batrider_bomb : public SpellScript
{
    PrepareSpellScript(spell_batrider_bomb);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BATRIDER_SUMMON_LIQUID_FIRE });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_BATRIDER_SUMMON_LIQUID_FIRE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_batrider_bomb::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_jeklik()
{
    RegisterCreatureAI(boss_jeklik);
    RegisterCreatureAI(npc_batrider);
    RegisterSpellScript(spell_batrider_bomb);
}
