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

    static int32 Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }
};

class PossessedAI : public CreatureAI
{
public:
    explicit PossessedAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit* target) override;
    void UpdateAI(uint32) override;
    void EnterEvadeMode(EvadeReason /*why*/) override {}

    void JustDied(Unit*) override;
    void KilledUnit(Unit* victim) override;

    static int32 Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }
};

class NullCreatureAI : public CreatureAI
{
public:
    explicit NullCreatureAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void UpdateAI(uint32) override {}
    void EnterEvadeMode(EvadeReason /*why*/) override {}
    void OnCharmed(bool /*apply*/) override {}

    static int32 Permissible(Creature const* creature);
};

class CritterAI : public PassiveAI
{
public:
    explicit CritterAI(Creature* c) : PassiveAI(c) { }

    void EnterCombat(Unit* /*who*/) override;
    void EnterEvadeMode(EvadeReason why) override;
    void MovementInform(uint32 type, uint32 id) override;
    void UpdateAI(uint32 /*diff*/) override { }

    static int32 Permissible(Creature const* creature);
};

class TriggerAI : public NullCreatureAI
{
public:
    explicit TriggerAI(Creature* c) : NullCreatureAI(c) {}
    void IsSummonedBy(Unit* summoner) override;

    static int32 Permissible(Creature const* creature);
};

#endif
