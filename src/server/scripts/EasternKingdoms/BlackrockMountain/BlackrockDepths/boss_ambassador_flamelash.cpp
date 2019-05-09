/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_depths.h"

enum Spells
{
    SPELL_FIREBLAST         = 15573,
    SPELL_BURNING_SPIRIT    = 14744,
};

enum AmbassadorEvents
{
    AGGRO_TEXT              = 0,
    EVENT_SPELL_FIREBLAST   = 1,
    EVENT_SUMMON_SPIRITS    = 2,
};

const uint32 NPC_FIRE_SPIRIT = 9178;
const uint32 NPC_AMBASSADOR_FLAMELASHER = 9156;

const Position SummonPositions[7] =
{
    {1028.786987f, -224.787186f, -61.840500f, 3.617599f},
    {1045.144775f, -241.108292f, -61.967422f, 3.617599f},
    {1028.852905f, -257.484222f, -61.981380f, 3.617599f},
    {1012.461060f, -273.803406f, -61.994171f, 3.617599f},
    { 995.503052f, -257.563751f, -62.013153f, 3.617599f},
    { 979.358704f, -240.535309f, -61.983044f, 3.617599f},
    {1012.252747f, -206.696487f, -61.980618f, 3.617599f},
};

vector<int> gobjectDwarfRunesEntry { 170578, 170579, 170580, 170581, 170582, 170583, 170584 }; 

class boss_ambassador_flamelash : public CreatureScript
{
public:
    boss_ambassador_flamelash() : CreatureScript("boss_ambassador_flamelash") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_ambassador_flamelashAI>(creature);
    }

    struct boss_ambassador_flamelashAI : public BossAI
    {
        boss_ambassador_flamelashAI(Creature* creature) : BossAI(creature, BOSS_AMBASSADOR_FLAMELASH), summons(me) { }

        EventMap _events;
        SummonList summons;
        vector<int> validPosition;
        bool foundValidPosition = false;

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void Reset() override
        {
            _events.Reset();
            summons.DespawnAll();
            TurnRunes(false);
            foundValidPosition = false;
            validPosition.clear();
        }

        void TurnRunes(bool mode)
        {
            // Active makes the runes burn, ready turns them off
            GOState state = mode ? GO_STATE_ACTIVE : GO_STATE_READY;
            
            for (int RuneEntry : gobjectDwarfRunesEntry)
                if (GameObject* dwarfRune = me->FindNearestGameObject(RuneEntry, 200.0f))
                    dwarfRune->SetGoState(state);
        }

        void EnterCombat(Unit* /*who*/) override
        { 
            _events.ScheduleEvent(EVENT_SPELL_FIREBLAST, 2000);
            
            // Spawn 7 Embers initially
            for (int i = 0; i < 4; ++i)
                _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 4000);

            // Activate the runes (Start burning)
            TurnRunes(true);

            Talk(AGGRO_TEXT);
        }

        void JustDied(Unit* /*killer*/) override
        {
            TurnRunes(false);
            _events.Reset();
            summons.DespawnAll();
        }
        
        int getValidRandomPosition()
        {
            /* Generate a random position which 
             * have not been used in 4 summonings.
             * Since we are calling the event whenever the Spirit
             * dies and not all at the time, we need to save at
             * least 4 positions until reseting the vector
            */

            // Searching a new position so reset this bool check
            foundValidPosition = false;
            int randomPosition;

            while (!foundValidPosition)
            {
                /* When we have summoned 4 creatures, reset the vector
                 * so we can summon new spirits in other positions.*/
                if (validPosition.size() == 4)
                    validPosition.clear();

                // The random ranges from the position 0 to the position 6
                randomPosition = urand(0, 6);

                // When we have an empty vector we can use any random position generated.
                if (validPosition.empty())
                    foundValidPosition = true;

                /* This check is done to avoid running the vector
                 * when it is empty. Because if it is empty, then any
                 * position can be used to summon Spirits.
                 */
                if (!foundValidPosition)
                {
                    // Check every position inside the vector
                    for (int pos : validPosition)
                    {
                        // If the random is different, we found a temporary true,
                        // until we find one that is equal, which means it has been used.
                        if (pos != randomPosition)
                            foundValidPosition = true;
                        else
                        {
                            foundValidPosition = false;
                            break;
                        }
                    }
                }
            }

            // We found a valid position. Save it and return it to summon.
            validPosition.emplace_back(randomPosition);
            return randomPosition;
        }

        void SummonSpirits()
        {
            // Make the Spirits get close to Ambassador
            if (Creature* Spirit = me->SummonCreature(NPC_FIRE_SPIRIT, SummonPositions[getValidRandomPosition()], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000))
                Spirit->GetMotionMaster()->MoveChase(me);
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;
                
            _events.Update(diff);

            // Whenever a fire spirit gets in meele range of the boss,
            // kill the NPC and make Ambassador cast Burning Spirit on himself
            Creature* spawn = me->FindNearestCreature(NPC_FIRE_SPIRIT, 1.0f, true);
            if (spawn)
            {
                me->CastSpell(me, SPELL_BURNING_SPIRIT);
                me->Kill(me, spawn);
                _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, urand(12, 14)*IN_MILLISECONDS);
            }
                
            switch(_events.ExecuteEvent())
            {
                case EVENT_SPELL_FIREBLAST:
                    DoCastVictim(SPELL_FIREBLAST);
                    _events.ScheduleEvent(EVENT_SPELL_FIREBLAST, 7000);
                    break;
                case EVENT_SUMMON_SPIRITS:
                    SummonSpirits();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_burning_spirit : public CreatureScript
{
public:
    npc_burning_spirit() : CreatureScript("npc_burning_spirit") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<npc_burning_spiritAI>(creature);
    }

    struct npc_burning_spiritAI : public CreatureAI
    {
        npc_burning_spiritAI(Creature* creature) : CreatureAI(creature) { }

        void UpdateAI(uint32 /*diff*/) override
        {
            Creature* boss = me->FindNearestCreature(NPC_AMBASSADOR_FLAMELASHER, 5000.0f, true);
            if (boss)
            {
                me->GetMotionMaster()->MoveChase(boss);
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;
        }
    };
};
void AddSC_boss_ambassador_flamelash()
{
    new boss_ambassador_flamelash();
    new npc_burning_spirit();
}
