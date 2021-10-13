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

/* ScriptData
SDName: Boss_Golemagg
SD%Complete: 90
SDComment: Timers need to be confirmed, Golemagg's Trust need to be checked
SDCategory: Molten Core
EndScriptData */

#include "molten_core.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Texts
{
    EMOTE_LOWHP             = 0,
};

enum Spells
{
    // Golemagg
    SPELL_MAGMASPLASH       = 13879,
    SPELL_PYROBLAST         = 20228,
    SPELL_EARTHQUAKE        = 19798,
    SPELL_ENRAGE            = 19953,
    SPELL_GOLEMAGG_TRUST    = 20553,

    // Core Rager
    SPELL_MANGLE            = 19820
};

enum Events
{
    EVENT_PYROBLAST     = 1,
    EVENT_EARTHQUAKE    = 2,
};

class boss_golemagg : public CreatureScript
{
public:
    boss_golemagg() : CreatureScript("boss_golemagg") { }

    struct boss_golemaggAI : public BossAI
    {
        boss_golemaggAI(Creature* creature) : BossAI(creature, BOSS_GOLEMAGG_THE_INCINERATOR)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            DoCast(me, SPELL_MAGMASPLASH, true);
        }

        void EnterCombat(Unit* victim) override
        {
            BossAI::EnterCombat(victim);
            events.ScheduleEvent(EVENT_PYROBLAST, 7000);

            // The two ragers should join the fight alongside me against my foes.
            std::list<Creature*> ragers;
            me->GetCreaturesWithEntryInRange(ragers, 100, NPC_CORE_RAGER);
            for (Creature* i : ragers)
            {
                if (i && i->IsAlive() && !i->IsInCombat())
                {
                    i->AI()->AttackStart(victim);
                }
            }
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!HealthBelowPct(10) || me->HasAura(SPELL_ENRAGE))
                return;

            DoCast(me, SPELL_ENRAGE, true);
            events.ScheduleEvent(EVENT_EARTHQUAKE, 3000);
        }

        void UpdateAI(uint32 diff) override
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
                    case EVENT_PYROBLAST:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, SPELL_PYROBLAST);
                        events.ScheduleEvent(EVENT_PYROBLAST, 7000);
                        break;
                    case EVENT_EARTHQUAKE:
                        DoCastVictim(SPELL_EARTHQUAKE);
                        events.ScheduleEvent(EVENT_EARTHQUAKE, 3000);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_golemaggAI>(creature);
    }
};

class npc_core_rager : public CreatureScript
{
public:
    npc_core_rager() : CreatureScript("npc_core_rager") { }

    struct npc_core_ragerAI : public ScriptedAI
    {
        npc_core_ragerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            mangleTimer = 7 * IN_MILLISECONDS;               // These times are probably wrong
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (HealthAbovePct(50) || !instance)
                return;

            if (Creature* pGolemagg = instance->instance->GetCreature(instance->GetGuidData(BOSS_GOLEMAGG_THE_INCINERATOR)))
            {
                if (pGolemagg->IsAlive())
                {
                    me->AddAura(SPELL_GOLEMAGG_TRUST, me);
                    Talk(EMOTE_LOWHP);
                    me->SetFullHealth();
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            // Mangle
            if (mangleTimer <= diff)
            {
                DoCastVictim(SPELL_MANGLE);
                mangleTimer = 10 * IN_MILLISECONDS;
            }
            else
                mangleTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        uint32 mangleTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_core_ragerAI>(creature);
    }
};

void AddSC_boss_golemagg()
{
    new boss_golemagg();
    new npc_core_rager();
}
