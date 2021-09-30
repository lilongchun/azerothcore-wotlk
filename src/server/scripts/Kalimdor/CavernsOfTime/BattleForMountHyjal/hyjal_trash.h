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

#ifndef SC_HYJAL_TRASH_AI_H
#define SC_HYJAL_TRASH_AI_H

#include "hyjal.h"
#include "ScriptedEscortAI.h"

#define MINRAIDDAMAGE  700000//minimal damage before trash can drop loot and reputation, resets if faction leader dies

struct hyjal_trashAI : public npc_escortAI
{
    hyjal_trashAI(Creature* creature);

    void UpdateAI(uint32 diff) override;

    void JustDied(Unit* /*killer*/) override;

    void DamageTaken(Unit* done_by, uint32& damage, DamageEffectType, SpellSchoolMask) override;

public:
    InstanceScript* instance;
    bool IsEvent;
    uint32 Delay;
    uint32 LastOverronPos;
    bool IsOverrun;
    bool SetupOverrun;
    uint32 OverrunType;
    uint8 faction;
    bool useFlyPath;
    uint32 damageTaken;
    float DummyTarget[3];

    //private:
};
#endif
