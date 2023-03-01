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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_black_morass.h"

enum Enums
{
    SAY_ENTER                   = 0,
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_ARCANE_BLAST          = 31457,
    SPELL_ARCANE_DISCHARGE      = 31472,
    SPELL_TIME_LAPSE            = 31467,
    SPELL_ATTRACTION            = 38540,

    SPELL_BANISH_DRAGON_HELPER  = 31550,
};

struct boss_chrono_lord_deja : public BossAI
{
    boss_chrono_lord_deja(Creature* creature) : BossAI(creature, DATA_CHRONO_LORD_DEJA)
    {
        instance = creature->GetInstanceScript();
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void InitializeAI() override
    {
        Talk(SAY_ENTER);
        ScriptedAI::InitializeAI();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        if (IsHeroic())
        {
            scheduler.Schedule(25s, 50s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_ATTRACTION);
                context.Repeat(25s, 50s);
            });
        }

        /* Timers need to be clarified with Gultask */
        scheduler.Schedule(15s, 50s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCANE_BLAST);
            context.Repeat(15s, 50s);
        })
        .Schedule(14s, 42s, [this](TaskContext context)
        {
            DoCast(SPELL_TIME_LAPSE);
            context.Repeat(14s, 42s);
        })
        .Schedule(12s, 35s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_DISCHARGE);
            context.Repeat(14s, 42s);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_TIME_KEEPER)
        {
            if (me->IsWithinDistInMap(who, 20.0f))
            {
                Talk(SAY_BANISH);
                DoCast(me, SPELL_BANISH_DRAGON_HELPER, true);
                return;
            }
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff, [this] {
            DoMeleeAttackIfReady();
        });
    }
};

void AddSC_boss_chrono_lord_deja()
{
    RegisterTheBlackMorassCreatureAI(boss_chrono_lord_deja);
}
