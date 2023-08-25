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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "WorldSession.h"
#include "serpent_shrine.h"

enum Says
{
    SAY_INTRO                       = 0,
    SAY_AGGRO                       = 1,
    SAY_PHASE1                      = 2,
    SAY_PHASE2                      = 3,
    SAY_PHASE3                      = 4,
    SAY_BOWSHOT                     = 5,
    SAY_SLAY                        = 6,
    SAY_DEATH                       = 7
};

enum Spells
{
    SPELL_SHOOT                     = 37770,
    SPELL_MULTI_SHOT                = 38310,
    SPELL_SHOCK_BLAST               = 38509,
    SPELL_STATIC_CHARGE             = 38280,
    SPELL_ENTANGLE                  = 38316,
    SPELL_MAGIC_BARRIER             = 38112,
    SPELL_FORKED_LIGHTNING          = 38145,

    SPELL_SUMMON_ENCHANTED_ELEMENTAL = 38017,
    SPELL_SUMMON_COILFANG_ELITE     = 38248,
    SPELL_SUMMON_COILFANG_STRIDER   = 38241,
    SPELL_SUMMON_TAINTED_ELEMENTAL  = 38140,
    SPELL_SURGE                     = 38044,

    SPELL_REMOVE_TAINTED_CORES      = 39495,
    SPELL_SUMMON_TOXIC_SPOREBAT     = 38494,
    SPELL_SUMMON_SPOREBAT1          = 38489,
    SPELL_SUMMON_SPOREBAT2          = 38490,
    SPELL_SUMMON_SPOREBAT3          = 38492,
    SPELL_SUMMON_SPOREBAT4          = 38493,
    SPELL_TOXIC_SPORES              = 38574
};

enum Misc
{
    ITEM_TAINTED_CORE               = 31088,

    POINT_HOME                      = 1,
};

class startFollow : public BasicEvent
{
public:
    startFollow(Unit* owner) : _owner(owner)  { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        if (InstanceScript* instance = _owner->GetInstanceScript())
        {
            if (Creature* vashj = ObjectAccessor::GetCreature(*_owner, instance->GetGuidData(NPC_LADY_VASHJ)))
            {
                _owner->GetMotionMaster()->MoveFollow(vashj, 3.0f, vashj->GetAngle(_owner), MOTION_SLOT_CONTROLLED);
            }
        }
        return true;
    }
private:
    Unit* _owner;
};

struct boss_lady_vashj : public BossAI
{
    boss_lady_vashj(Creature* creature) : BossAI(creature, DATA_LADY_VASHJ)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        _intro = false;
    }

    void Reset() override
    {
        _count = 0;
        _recentlySpoken = false;
        _batTimer = 20s;
        BossAI::Reset();

        ScheduleHealthCheckEvent(70, [&]{
            Talk(SAY_PHASE2);
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->MovePoint(POINT_HOME, me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY(), me->GetHomePosition().GetPositionZ(), true, true);
        });
    }

    
    void KilledUnit(Unit* /*victim*/) override
    {
        if(!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
        }
        scheduler.Schedule(6s, [this](TaskContext)
        {
            _recentlySpoken = false;
        });
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        me->CastSpell(me, SPELL_REMOVE_TAINTED_CORES, true);

        ScheduleSpells();
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == WORLD_TRIGGER)
        {
            summon->CastSpell(summon, SPELL_MAGIC_BARRIER, false);
        }
        else if (summon->GetEntry() == NPC_ENCHANTED_ELEMENTAL)
        {
            summon->SetWalk(true);
            summon->m_Events.AddEvent(new startFollow(summon), summon->m_Events.CalculateTime(0));
        }
        else if (summon->GetEntry() == NPC_TOXIC_SPOREBAT)
        {
            summon->GetMotionMaster()->MoveRandom(30.0f);
        }
        else if (summon->GetEntry() != NPC_TAINTED_ELEMENTAL)
        {
            summon->GetMotionMaster()->MovePoint(POINT_HOME, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, true);
        }
    }

    void ScheduleSpells()
    {
        scheduler.Schedule(10s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHOCK_BLAST);
            context.Repeat(10s, 20s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_STATIC_CHARGE);
            context.Repeat(20s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_ENTANGLE);
            context.Repeat(30s);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_intro && who->GetTypeId() == TYPEID_PLAYER)
        {
            _intro = true;
            Talk(SAY_INTRO);
        }

        BossAI::MoveInLineOfSight(who);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != POINT_HOME)
        {
            return;
        }

        me->SetFacingTo(me->GetHomePosition().GetOrientation());
        instance->SetData(DATA_ACTIVATE_SHIELD, 0);
        scheduler.CancelAll();

        scheduler.Schedule(3s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_FORKED_LIGHTNING);
            context.Repeat(2500s, 5000s);
        }).Schedule(0s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_ENCHANTED_ELEMENTAL, true);
            context.Repeat(2500ms);
        }).Schedule(45s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_COILFANG_ELITE, true);
            context.Repeat(45s);
        }).Schedule(60s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_COILFANG_STRIDER, true);
            context.Repeat(60s);
        }).Schedule(50s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_TAINTED_ELEMENTAL, true);
            context.Repeat(50s);
        }).Schedule(1s, [this](TaskContext context)
        {
            if (!me->HasAura(SPELL_MAGIC_BARRIER))
            {
                Talk(SAY_PHASE3);
                me->SetReactState(REACT_AGGRESSIVE);
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                scheduler.CancelAll();

                ScheduleSpells();
                scheduler.Schedule(5s, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_SUMMON_TOXIC_SPOREBAT, true);
                    _batTimer = 20s - static_cast<std::chrono::seconds>(std::min(_count++, 16));
                    context.Repeat(_batTimer);
                });
            }
            else
            {
                context.Repeat(1s);
            }
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->GetReactState() != REACT_AGGRESSIVE || !me->isAttackReady())
        {
            return;
        }

        if (!me->IsWithinMeleeRange(me->GetVictim()))
        {
            me->resetAttackTimer();
            me->SetSheath(SHEATH_STATE_RANGED);
            me->CastSpell(me->GetVictim(), roll_chance_i(33) ? SPELL_MULTI_SHOT : SPELL_SHOOT, false);
            if (roll_chance_i(15))
            {
                Talk(SAY_BOWSHOT);
            }
        }
        else
        {
            me->SetSheath(SHEATH_STATE_MELEE);
            DoMeleeAttackIfReady();
        }
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetHomePosition().GetExactDist2d(me) > 80.0f || !SelectTargetFromPlayerList(100.0f);
    }

private:
    bool _recentlySpoken;
    bool _intro;
    int32 _count;
    std::chrono::seconds _batTimer;
};

/*

//Toxic Sporebat
//Toxic Spores: Used in Phase 3 by the Spore Bats, it creates a contaminated green patch of ground, dealing about 2775-3225 nature damage every second to anyone who stands in it.
//deprecated -- adds do work
class npc_toxic_sporebat : public CreatureScript
{
public:
    npc_toxic_sporebat() : CreatureScript("npc_toxic_sporebat") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<npc_toxic_sporebatAI>(creature);
    }

    struct npc_toxic_sporebatAI : public ScriptedAI
    {
        npc_toxic_sporebatAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            EnterEvadeMode();
        }

        InstanceScript* instance;

        uint32 MovementTimer;
        uint32 ToxicSporeTimer;
        uint32 BoltTimer;
        uint32 CheckTimer;

        void Reset()
        {
            me->SetDisableGravity(true);
            me->SetFaction(FACTION_MONSTER);
            MovementTimer = 0;
            ToxicSporeTimer = 5000;
            BoltTimer = 5500;
            CheckTimer = 1000;
        }

        void MoveInLineOfSight(Unit* who)

        {
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1)
                MovementTimer = 0;
        }

        void UpdateAI(uint32 diff)
        {
            // Random movement
            if (MovementTimer <= diff)
            {
                uint32 rndpos = rand()%8;
                me->GetMotionMaster()->MovePoint(1, SporebatWPPos[rndpos][0], SporebatWPPos[rndpos][1], SporebatWPPos[rndpos][2]);
                MovementTimer = 6000;
            } else MovementTimer -= diff;

            // toxic spores
            if (BoltTimer <= diff)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    if (Creature* trig = me->SummonCreature(TOXIC_SPORES_TRIGGER, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 30000))
                    {
                        trig->SetFaction(FACTION_MONSTER);
                        trig->CastSpell(trig, SPELL_TOXIC_SPORES, true);
                    }
                }
                BoltTimer = 10000+rand()%5000;
            }
            else BoltTimer -= diff;

            // CheckTimer
            if (CheckTimer <= diff)
            {
                // check if vashj is death
                Unit* Vashj = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_LADYVASHJ));
                if (!Vashj || !Vashj->IsAlive() || CAST_AI(boss_lady_vashj::boss_lady_vashjAI, Vashj->ToCreature()->AI())->Phase != 3)
                {
                    // remove
                    me->setDeathState(DEAD);
                    me->RemoveCorpse();
                    me->SetFaction(FACTION_FRIENDLY);
                }

                CheckTimer = 1000;
            }
            else
                CheckTimer -= diff;
        }
    };

};
*/

class spell_lady_vashj_magic_barrier : public SpellScriptLoader
{
public:
    spell_lady_vashj_magic_barrier() : SpellScriptLoader("spell_lady_vashj_magic_barrier") { }

    class spell_lady_vashj_magic_barrier_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_lady_vashj_magic_barrier_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit::DealDamage(GetTarget(), GetTarget(), GetTarget()->CountPctFromMaxHealth(5));
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_lady_vashj_magic_barrier_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_SCHOOL_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_lady_vashj_magic_barrier_AuraScript();
    }
};

class spell_lady_vashj_remove_tainted_cores : public SpellScriptLoader
{
public:
    spell_lady_vashj_remove_tainted_cores() : SpellScriptLoader("spell_lady_vashj_remove_tainted_cores") { }

    class spell_lady_vashj_remove_tainted_cores_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_lady_vashj_remove_tainted_cores_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Player* target = GetHitPlayer())
            {
                target->DestroyItemCount(ITEM_TAINTED_CORE, -1, true);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_remove_tainted_cores_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_lady_vashj_remove_tainted_cores_SpellScript();
    }
};

class spell_lady_vashj_summon_sporebat : public SpellScriptLoader
{
public:
    spell_lady_vashj_summon_sporebat() : SpellScriptLoader("spell_lady_vashj_summon_sporebat") { }

    class spell_lady_vashj_summon_sporebat_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_lady_vashj_summon_sporebat_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->CastSpell(GetCaster(), RAND(SPELL_SUMMON_SPOREBAT1, SPELL_SUMMON_SPOREBAT2, SPELL_SUMMON_SPOREBAT3, SPELL_SUMMON_SPOREBAT4), true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_summon_sporebat_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_lady_vashj_summon_sporebat_SpellScript();
    }
};

class spell_lady_vashj_spore_drop_effect : public SpellScriptLoader
{
public:
    spell_lady_vashj_spore_drop_effect() : SpellScriptLoader("spell_lady_vashj_spore_drop_effect") { }

    class spell_lady_vashj_spore_drop_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_lady_vashj_spore_drop_effect_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
            {
                target->CastSpell(target, SPELL_TOXIC_SPORES, true, nullptr, nullptr, GetCaster()->GetGUID());
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_spore_drop_effect_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_lady_vashj_spore_drop_effect_SpellScript();
    }
};

void AddSC_boss_lady_vashj()
{
    RegisterSerpentShrineAI(boss_lady_vashj);
    new spell_lady_vashj_magic_barrier();
    new spell_lady_vashj_remove_tainted_cores();
    new spell_lady_vashj_summon_sporebat();
    new spell_lady_vashj_spore_drop_effect();
}
