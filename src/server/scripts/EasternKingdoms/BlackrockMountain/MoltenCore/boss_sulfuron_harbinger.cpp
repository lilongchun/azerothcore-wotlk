/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Sulfuron_Harbringer
SD%Complete: 80
SDComment: Adds NYI
SDCategory: Molten Core
EndScriptData */

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    // Sulfuron Harbringer
    SPELL_DARK_STRIKE           = 19777,
    SPELL_DEMORALIZING_SHOUT    = 19778,
    SPELL_INSPIRE               = 19779,
    SPELL_KNOCKDOWN             = 19780,
    SPELL_FLAMESPEAR            = 19781,

    // Adds
    SPELL_HEAL                  = 19775,
    SPELL_SHADOWWORDPAIN        = 19776,
    SPELL_IMMOLATE              = 20294,
};

enum Events
{
    EVENT_DARK_STRIKE           = 1,
    EVENT_DEMORALIZING_SHOUT    = 2,
    EVENT_INSPIRE               = 3,
    EVENT_KNOCKDOWN             = 4,
    EVENT_FLAMESPEAR            = 5,

    EVENT_HEAL                  = 6,
    EVENT_SHADOW_WORD_PAIN      = 7,
    EVENT_IMMOLATE              = 8,
};

class boss_sulfuron : public CreatureScript
{
public:
    boss_sulfuron() : CreatureScript("boss_sulfuron") { }

    struct boss_sulfuronAI : public BossAI
    {
        boss_sulfuronAI(Creature* creature) : BossAI(creature, BOSS_SULFURON_HARBINGER)
        {
        }

        void EnterCombat(Unit* victim)
        {
            BossAI::EnterCombat(victim);
            events.ScheduleEvent(EVENT_DARK_STRIKE, 10000);
            events.ScheduleEvent(EVENT_DEMORALIZING_SHOUT, 15000);
            events.ScheduleEvent(EVENT_INSPIRE, 13000);
            events.ScheduleEvent(EVENT_KNOCKDOWN, 6000);
            events.ScheduleEvent(EVENT_FLAMESPEAR, 2000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DARK_STRIKE:
                        DoCast(me, SPELL_DARK_STRIKE);
                        events.ScheduleEvent(EVENT_DARK_STRIKE, urand(15000, 18000));
                        break;
                    case EVENT_DEMORALIZING_SHOUT:
                        DoCastVictim(SPELL_DEMORALIZING_SHOUT);
                        events.ScheduleEvent(EVENT_DEMORALIZING_SHOUT, urand(15000, 20000));
                        break;
                    case EVENT_INSPIRE:
                        {
                            std::list<Creature*> healers = DoFindFriendlyMissingBuff(45.0f, SPELL_INSPIRE);
                            if (!healers.empty())
                                DoCast(acore::Containers::SelectRandomContainerElement(healers), SPELL_INSPIRE);

                            DoCast(me, SPELL_INSPIRE);
                            events.ScheduleEvent(EVENT_INSPIRE, urand(20000, 26000));
                            break;
                        }
                    case EVENT_KNOCKDOWN:
                        DoCastVictim(SPELL_KNOCKDOWN);
                        events.ScheduleEvent(EVENT_KNOCKDOWN, urand(12000, 15000));
                        break;
                    case EVENT_FLAMESPEAR:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            DoCast(target, SPELL_FLAMESPEAR);
                        events.ScheduleEvent(EVENT_FLAMESPEAR, urand(12000, 16000));
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_sulfuronAI(creature);
    }
};

class npc_flamewaker_priest : public CreatureScript
{
public:
    npc_flamewaker_priest() : CreatureScript("npc_flamewaker_priest") { }

    struct npc_flamewaker_priestAI : public ScriptedAI
    {
        npc_flamewaker_priestAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void Reset()
        {
            events.Reset();
        }

        void JustDied(Unit* /*killer*/)
        {
            events.Reset();
        }

        void EnterCombat(Unit* victim)
        {
            ScriptedAI::EnterCombat(victim);
            events.ScheduleEvent(EVENT_HEAL, urand(15000, 30000));
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 2000);
            events.ScheduleEvent(EVENT_IMMOLATE, 8000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HEAL:
                        if (Unit* target = DoSelectLowestHpFriendly(60.0f, 1))
                            DoCast(target, SPELL_HEAL);
                        events.ScheduleEvent(EVENT_HEAL, urand(15000, 20000));
                        break;
                    case EVENT_SHADOW_WORD_PAIN:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_SHADOWWORDPAIN))
                            DoCast(target, SPELL_SHADOWWORDPAIN);
                        events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, urand(18000, 26000));
                        break;
                    case EVENT_IMMOLATE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_IMMOLATE))
                            DoCast(target, SPELL_IMMOLATE);
                        events.ScheduleEvent(EVENT_IMMOLATE, urand(15000, 25000));
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_flamewaker_priestAI(creature);
    }
};

void AddSC_boss_sulfuron()
{
    new boss_sulfuron();
    new npc_flamewaker_priest();
}
