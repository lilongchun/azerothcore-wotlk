/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO   = 0,
    SAY_SLAY    = 1,
    SAY_TAUNTED = 2,
    SAY_DEATH   = 3
};

enum Spells
{
    SPELL_UNBALANCING_STRIKE        = 26613,
    SPELL_DISRUPTING_SHOUT_10       = 55543,
    SPELL_DISRUPTING_SHOUT_25       = 29107,
    SPELL_JAGGED_KNIFE              = 55550,
    SPELL_HOPELESS                  = 29125,

    SPELL_TAUNT                     = 29060
};

enum Events
{
    EVENT_SPELL_UNBALANCING_STRIKE  = 1,
    EVENT_SPELL_DISRUPTING_SHOUT    = 2,
    EVENT_SPELL_JAGGED_KNIFE        = 3
};

enum Misc
{
    NPC_DEATH_KNIGHT_UNDERSTUDY     = 16803,
    NPC_RAZUVIOUS                   = 16061
};

class boss_razuvious : public CreatureScript
{
public:
    boss_razuvious() : CreatureScript("boss_razuvious") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_razuviousAI (pCreature);
    }

    struct boss_razuviousAI : public BossAI
    {
        explicit boss_razuviousAI(Creature* c) : BossAI(c, BOSS_RAZUVIOUS), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;

        void SpawnHelpers()
        {
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2762.23f, -3085.07f, 267.685f, 1.95f);
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2758.24f, -3110.97f, 267.685f, 3.94f);
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2782.45f, -3088.03f, 267.685f, 0.75f);
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2778.56f, -3113.74f, 267.685f, 5.28f);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void Reset() override
        {
            BossAI::Reset();
            summons.DespawnAll();
            events.Reset();
            SpawnHelpers();
        }

        void KilledUnit(Unit* who) override
        {
            if (roll_chance_i(30))
            {
                Talk(SAY_SLAY);
            }
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (pInstance)
                {
                    pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
                }
            }
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            // Damage done by the controlled Death Knight understudies should also count toward damage done by players
            if(who && who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_DEATH_KNIGHT_UNDERSTUDY)
            {
                me->LowerPlayerDamageReq(damage);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            me->CastSpell(me, SPELL_HOPELESS, true);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_TAUNT)
            {
                Talk(SAY_TAUNTED, caster);
            }
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_UNBALANCING_STRIKE, 20000);
            events.ScheduleEvent(EVENT_SPELL_DISRUPTING_SHOUT, 15000);
            events.ScheduleEvent(EVENT_SPELL_JAGGED_KNIFE, 10000);
            summons.DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_UNBALANCING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_UNBALANCING_STRIKE, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_DISRUPTING_SHOUT:
                    me->CastSpell(me, RAID_MODE(SPELL_DISRUPTING_SHOUT_10, SPELL_DISRUPTING_SHOUT_25), false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_JAGGED_KNIFE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f))
                    {
                        me->CastSpell(target, SPELL_JAGGED_KNIFE, false);
                    }
                    events.RepeatEvent(10000);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_razuvious_minion : public CreatureScript
{
public:
    boss_razuvious_minion() : CreatureScript("boss_razuvious_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_razuvious_minionAI (pCreature);
    }

    struct boss_razuvious_minionAI : public ScriptedAI
    {
        explicit boss_razuvious_minionAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (me->GetInstanceScript())
                {
                    me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
                }
            }
        }

        void EnterCombat(Unit* who) override
        {
            if (Creature* cr = me->FindNearestCreature(NPC_RAZUVIOUS, 100.0f))
            {
                cr->SetInCombatWithZone();
                cr->AI()->AttackStart(who);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                events.Update(diff);
                if (!me->HasUnitState(UNIT_STATE_CASTING) || !me->IsCharmed())
                {
                    DoMeleeAttackIfReady();
                }
            }
        }
    };
};

void AddSC_boss_razuvious()
{
    new boss_razuvious();
    new boss_razuvious_minion();
}
