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

#ifndef ACORE_PASSIVEAI_H
#define ACORE_PASSIVEAI_H

#include "CreatureAI.h"
//#include "CreatureAIImpl.h"

class PassiveAI : public CreatureAI
{
public:
    explicit PassiveAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void UpdateAI(uint32) override;

    static int Permissible(Creature const*) { return PERMIT_BASE_IDLE;  }
};

class PossessedAI : public CreatureAI
{
public:
    explicit PossessedAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit* target) override;
    void JustEnteredCombat(Unit* who) override { EngagementStart(who); }
    void JustExitedCombat() override { EngagementOver(); }
    void JustStartedThreateningMe(Unit*) override { }
    void UpdateAI(uint32) override;
    void EnterEvadeMode(EvadeReason /*why*/) override {}

    void JustDied(Unit*) override;
    void KilledUnit(Unit* victim) override;

    static int Permissible(Creature const*) { return PERMIT_BASE_IDLE;  }
};

class NullCreatureAI : public CreatureAI
{
public:
    explicit NullCreatureAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void JustStartedThreateningMe(Unit*) override { }
    void JustEnteredCombat(Unit*) override { }
    void UpdateAI(uint32) override {}
    void EnterEvadeMode(EvadeReason /*why*/) override {}
    void OnCharmed(bool /*apply*/) override {}

    static int Permissible(Creature const*) { return PERMIT_BASE_IDLE;  }
};

class CritterAI : public PassiveAI
{
public:
    explicit CritterAI(Creature* c) : PassiveAI(c) { _combatTimer = 0; }

    void DamageTaken(Unit* /*done_by*/, uint32& /*damage*/, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override;
    void EnterEvadeMode(EvadeReason why) override;
    void UpdateAI(uint32) override;

    // Xinef: Added
private:
    uint32 _combatTimer;
};

class TriggerAI : public NullCreatureAI
{
public:
    explicit TriggerAI(Creature* c) : NullCreatureAI(c) {}
    void IsSummonedBy(Unit* summoner) override;
};

#endif
