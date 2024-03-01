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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "hyjal.h"

enum Spells
{
    SPELL_FROST_ARMOR           = 31256,
    SPELL_DEATH_AND_DECAY       = 31258,
    SPELL_FROST_NOVA            = 31250,
    SPELL_ICEBOLT               = 31249,
    SPELL_ENRAGE                = 26662
};

enum Texts
{
    SAY_ONDEATH                 = 0,
    SAY_ONSLAY                  = 1,
    SAY_DECAY                   = 2,
    SAY_NOVA                    = 3,
    SAY_ONSPAWN                 = 4
};

enum Misc
{
    PATH_RAGE_WINTERCHILL       = 177670,
    POINT_COMBAT_START          = 7
};

struct boss_rage_winterchill : public BossAI
{
public:
    boss_rage_winterchill(Creature* creature) : BossAI(creature, DATA_WINTERCHILL)
    {
        _recentlySpoken = false;
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        scheduler.Schedule(18s, 24s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_FROST_ARMOR);
            context.Repeat(30s, 45s);
        }).Schedule(5s, 9s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                DoCast(target, SPELL_ICEBOLT);
            context.Repeat(9s, 15s);
        }).Schedule(12s, 17s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 20.f))
            {
                DoCastAOE(SPELL_FROST_NOVA);
                Talk(SAY_NOVA);
                context.Repeat(25s, 30s);
            }
            else
                context.Repeat(1200ms);
        }).Schedule(21s, 28s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.f))
            {
                DoCast(target, SPELL_DEATH_AND_DECAY);
                Talk(SAY_DECAY);
            }
            context.Repeat(45s);
        }).Schedule(600s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_ENRAGE);
                context.Repeat(300s);
            });
    }

    void DoAction(int32 action) override
    {
        Talk(SAY_ONSPAWN, 1200ms);
        
        if (action == DATA_WINTERCHILL)
            me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_CHARGE_1, ALLIANCE_BASE_CHARGE_3), false);
    }

    void PathEndReached(uint32 pathId) override
    {
        switch (pathId)
        {
        case ALLIANCE_BASE_CHARGE_1:
        case ALLIANCE_BASE_CHARGE_2:
        case ALLIANCE_BASE_CHARGE_3:
            me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_PATROL_1, ALLIANCE_BASE_PATROL_3), true);
            break;
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer())
        {
            Talk(SAY_ONSLAY);
            _recentlySpoken = true;

            scheduler.Schedule(6s, [this](TaskContext)
                {
                    _recentlySpoken = false;
                });
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_ONDEATH);
        BossAI::JustDied(killer);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

private:
    bool _recentlySpoken;
};

void AddSC_boss_rage_winterchill()
{
    RegisterHyjalAI(boss_rage_winterchill);
}
