/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    EMOTE_BERSERK                               = 3,
    EMOTE_ENRAGE                                = 4
};

enum Spells
{
    SPELL_HATEFUL_STRIKE_10         = 41926,
    SPELL_HATEFUL_STRIKE_25         = 59192,
    SPELL_FRENZY                    = 28131,
    SPELL_BERSERK                   = 26662,
    SPELL_SLIME_BOLT                = 32309,
};

enum Events
{
    EVENT_HEALTH_CHECK              = 1,
    EVENT_SPELL_HATEFUL_STRIKE      = 2,
    EVENT_SPELL_SLIME_BOLT          = 3,
    EVENT_SPELL_BERSERK             = 4,
};

enum Misc
{
    ACHIEV_TIMED_START_EVENT        = 10286,
};

// These are the Creature entries
int const CreatureEntriesToPullOnAggro [] = { 16017, 16018, 16020, 16021, 16022 };

// Due to current Pathfinding system being in unstable, I have to filter
// which GUID I will pull to avoid creatures clipping through textures
uint64 const CreatureGUIDS[] = { 97736, 97718, 97747, 128068, 128069, 128078, 128079,
                                128080, 128082, 128083, 128085, 128086, 128089, 128090,
                                128091, 128093, 128094, 128095, 128096, 128100, 128101, 128102 };

class boss_patchwerk : public CreatureScript
{
public:
    boss_patchwerk() : CreatureScript("boss_patchwerk") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_patchwerkAI (pCreature);
    }

    struct boss_patchwerkAI : public BossAI
    {
        boss_patchwerkAI(Creature *c) : BossAI(c, BOSS_PATCHWERK) 
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* pInstance;

        void Reset()
        {
            BossAI::Reset();
            events.Reset();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (!urand(0,3))
                Talk(SAY_SLAY);

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        // If any of the adds on his chamber are alive, pull them
        void PullChamberAdds()
        {
            for (uint64 GUID : CreatureGUIDS)
            {
                for (int entry : CreatureEntriesToPullOnAggro)
                {
                    std::list<Creature*> a;
                    me->GetCreaturesWithEntryInRange(a, 500.0f, entry);
                    for (std::list<Creature*>::const_iterator itr = a.begin(); itr != a.end(); ++itr)
                    {
                        if ((*itr)->GetGUID() & GUID)
                            (*itr)->ToCreature()->AI()->AttackStart(me->GetVictim());
                    }
                }
            }
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            Talk(SAY_AGGRO);
            PullChamberAdds();
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_SPELL_HATEFUL_STRIKE, 1200);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 360000);
            events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);

            if (pInstance)
            {
                pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_HATEFUL_STRIKE:
                {
                    //Cast Hateful strike on the player with the highest
                    //amount of HP within melee distance, and second threat amount
                    std::list<Unit*> meleeRangeTargets;
                    Unit* finalTarget = NULL;
                    uint8 counter = 0;
                    
                    ThreatContainer::StorageType::const_iterator i = me->getThreatManager().getThreatList().begin();
                    for (; i != me->getThreatManager().getThreatList().end(); ++i, ++counter)
                    {
                        // Gather all units with melee range
                        Unit *target = (*i)->getTarget();
                        if (me->IsWithinMeleeRange(target))
                            meleeRangeTargets.push_back(target);

                        // and add threat to most hated
                        if (counter < RAID_MODE(2,3))
                            me->AddThreat(target, 500.0f);
                    }

                    counter = 0;
                    for (std::list<Unit*>::const_iterator i = meleeRangeTargets.begin(); i != meleeRangeTargets.end(); ++i, ++counter)
                    {
                        // if there is only one target available
                        if (meleeRangeTargets.size() == 1)
                            finalTarget = (*i);
                        else if (counter > 0) // skip first target
                        {
                            if (!finalTarget || (*i)->GetHealth() > finalTarget->GetHealth())
                                finalTarget = (*i);

                            // third loop
                            if (counter >= 2)
                                break;
                        }
                    }

                    if (finalTarget)
                        me->CastSpell(finalTarget, RAID_MODE(SPELL_HATEFUL_STRIKE_10, SPELL_HATEFUL_STRIKE_25), false);

                    events.RepeatEvent(1000);
                    break;
                }
                case EVENT_SPELL_BERSERK:
                    Talk(EMOTE_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.ScheduleEvent(EVENT_SPELL_SLIME_BOLT, 2000);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SLIME_BOLT:
                    me->CastSpell(me, SPELL_SLIME_BOLT, false);
                    events.RepeatEvent(3000);
                    break;
                case EVENT_HEALTH_CHECK:
                    if (me->GetHealthPct() <= 5)
                    {
                        Talk(EMOTE_ENRAGE);
                        me->CastSpell(me, SPELL_FRENZY, true);
                        events.PopEvent();
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;

            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_patchwerk()
{
    new boss_patchwerk();
}
