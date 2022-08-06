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
#include "SpellInfo.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_POISON_SHOCK          = 25993,
    SPELL_POISONBOLT_VOLLEY     = 25991,
    SPELL_TOXIN                 = 26575,
    SPELL_VISCIDUS_SLOWED       = 26034,
    SPELL_VISCIDUS_SLOWED_MORE  = 26036,
    SPELL_VISCIDUS_FREEZE       = 25937,
    SPELL_REJOIN_VISCIDUS       = 25896,
    SPELL_VISCIDUS_EXPLODE      = 25938,
    SPELL_VISCIDUS_SUICIDE      = 26003,
    SPELL_VISCIDUS_SHRINKS      = 25893,                   // Removed from client, in world.spell_dbc

    SPELL_MEMBRANE_VISCIDUS     = 25994,                   // damage reduction spell - removed from DBC
    SPELL_VISCIDUS_WEAKNESS     = 25926,                   // aura which procs at damage - should trigger the slow spells - removed from DBC
    SPELL_VISCIDUS_GROWS        = 25897,                   // removed from DBC
    SPELL_SUMMON_GLOBS          = 25885,                   // summons npc 15667 using spells from 25865 to 25884; All spells have target coords - removed from DBC
    SPELL_VISCIDUS_TELEPORT     = 25904,                   // removed from DBC
};

enum Events
{
    EVENT_POISONBOLT_VOLLEY     = 1,
    EVENT_POISON_SHOCK          = 2,
    EVENT_RESET_PHASE           = 3
};

enum Phases
{
    PHASE_FROST                 = 1,
    PHASE_MELEE                 = 2,
    PHASE_GLOB                  = 3
};

enum Emotes
{
    EMOTE_SLOW                  = 0,
    EMOTE_FREEZE                = 1,
    EMOTE_FROZEN                = 2,

    EMOTE_CRACK                 = 3,
    EMOTE_SHATTER               = 4,
    EMOTE_EXPLODE               = 5
};

enum HitCounter
{
    HITCOUNTER_SLOW             = 100,
    HITCOUNTER_SLOW_MORE        = 150,
    HITCOUNTER_FREEZE           = 200,

    HITCOUNTER_CRACK            = 50,
    HITCOUNTER_SHATTER          = 100,
    HITCOUNTER_EXPLODE          = 150,
};

enum MovePoints
{
    ROOM_CENTER                 = 1
};

Position const ViscidusCoord = { -7992.36f, 908.19f, -52.62f, 1.68f }; /// @todo Visci isn't in room middle
float const RoomRadius = 40.0f; /// @todo Not sure if its correct

struct boss_viscidus : public BossAI
{
    boss_viscidus(Creature* creature) : BossAI(creature, DATA_VISCIDUS) { }

    void Reset() override
    {
        _Reset();
        _hitcounter = 0;
        _phase = PHASE_FROST;
    }

    void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (!attacker || _phase != PHASE_MELEE)
            return;

        ++_hitcounter;

        if (attacker->HasUnitState(UNIT_STATE_MELEE_ATTACKING) && _hitcounter >= HITCOUNTER_EXPLODE)
        {
            Talk(EMOTE_EXPLODE);
            events.Reset();
            _phase = PHASE_GLOB;
            DoCast(me, SPELL_VISCIDUS_EXPLODE);
            me->SetVisible(false);
            me->RemoveAura(SPELL_TOXIN);
            me->RemoveAura(SPELL_VISCIDUS_FREEZE);

            uint8 NumGlobes = me->GetHealthPct() / 5.0f;
            for (uint8 i = 0; i < NumGlobes; ++i)
            {
                float Angle = i * 2 * M_PI / NumGlobes;
                float X = ViscidusCoord.GetPositionX() + std::cos(Angle) * RoomRadius;
                float Y = ViscidusCoord.GetPositionY() + std::sin(Angle) * RoomRadius;
                float Z = -35.0f;

                if (TempSummon* Glob = me->SummonCreature(NPC_GLOB_OF_VISCIDUS, X, Y, Z))
                {
                    Glob->UpdateAllowedPositionZ(X, Y, Z);
                    Glob->NearTeleportTo(X, Y, Z, 0.0f);
                    Glob->GetMotionMaster()->MovePoint(ROOM_CENTER, ViscidusCoord);
                }
            }
        }
        else if (_hitcounter == HITCOUNTER_SHATTER)
            Talk(EMOTE_SHATTER);
        else if (_hitcounter == HITCOUNTER_CRACK)
            Talk(EMOTE_CRACK);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if ((spell->GetSchoolMask() & SPELL_SCHOOL_MASK_FROST) && _phase == PHASE_FROST && me->GetHealthPct() > 5.0f)
        {
            ++_hitcounter;

            if (_hitcounter >= HITCOUNTER_FREEZE)
            {
                _hitcounter = 0;
                Talk(EMOTE_FROZEN);
                _phase = PHASE_MELEE;
                DoCast(me, SPELL_VISCIDUS_FREEZE);
                me->RemoveAura(SPELL_VISCIDUS_SLOWED_MORE);
                events.ScheduleEvent(EVENT_RESET_PHASE, 15000);
            }
            else if (_hitcounter >= HITCOUNTER_SLOW_MORE)
            {
                Talk(EMOTE_FREEZE);
                me->RemoveAura(SPELL_VISCIDUS_SLOWED);
                DoCast(me, SPELL_VISCIDUS_SLOWED_MORE);
            }
            else if (_hitcounter >= HITCOUNTER_SLOW)
            {
                Talk(EMOTE_SLOW);
                DoCast(me, SPELL_VISCIDUS_SLOWED);
            }
        }
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.Reset();
        InitSpells();
    }

    void InitSpells()
    {
        DoCast(me, SPELL_TOXIN);
        events.ScheduleEvent(EVENT_POISONBOLT_VOLLEY, 10s, 15s);
        events.ScheduleEvent(EVENT_POISON_SHOCK, 7s, 12s);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        summons.DespawnAll();
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCast(me, SPELL_VISCIDUS_SUICIDE);
        summons.DespawnAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (_phase == PHASE_GLOB && summons.empty())
        {
            DoResetThreat();
            me->NearTeleportTo(ViscidusCoord.GetPositionX(),
                ViscidusCoord.GetPositionY(),
                ViscidusCoord.GetPositionZ(),
                ViscidusCoord.GetOrientation());

            _hitcounter = 0;
            _phase = PHASE_FROST;
            InitSpells();
            me->SetVisible(true);
        }

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POISONBOLT_VOLLEY:
                    DoCast(me, SPELL_POISONBOLT_VOLLEY);
                    events.ScheduleEvent(EVENT_POISONBOLT_VOLLEY, 10s, 15s);
                    break;
                case EVENT_POISON_SHOCK:
                    DoCast(me, SPELL_POISON_SHOCK);
                    events.ScheduleEvent(EVENT_POISON_SHOCK, 7s, 12s);
                    break;
                case EVENT_RESET_PHASE:
                    _hitcounter = 0;
                    _phase = PHASE_FROST;
                    break;
                default:
                    break;
            }
        }

        if (_phase != PHASE_GLOB)
            DoMeleeAttackIfReady();
    }

private:
    uint8 _hitcounter;
    Phases _phase;
};

struct boss_glob_of_viscidus : public ScriptedAI
{
    boss_glob_of_viscidus(Creature* creature) : ScriptedAI(creature) { }

    void JustDied(Unit* /*killer*/) override
    {
        InstanceScript* instance = me->GetInstanceScript();

        if (Creature* viscidus = me->GetMap()->GetCreature(instance->GetGuidData(DATA_VISCIDUS)))
        {
            if (BossAI* viscidusAI = dynamic_cast<BossAI*>(viscidus->GetAI()))
                viscidusAI->SummonedCreatureDespawn(me);

            if (viscidus->IsAlive() && viscidus->GetHealthPct() < 5.0f)
            {
                viscidus->SetVisible(true);
                Unit::Kill(viscidus->GetVictim(), viscidus);
            }
            else
            {
                viscidus->SetHealth(viscidus->GetHealth() - viscidus->GetMaxHealth() / 20);
                viscidus->CastSpell(viscidus, SPELL_VISCIDUS_SHRINKS);
            }
        }
    }

    void MovementInform(uint32 /*type*/, uint32 id) override
    {
        if (id == ROOM_CENTER)
        {
            DoCast(me, SPELL_REJOIN_VISCIDUS);
            if (TempSummon* summon = me->ToTempSummon())
                summon->UnSummon();
        }
    }
};

void AddSC_boss_viscidus()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_viscidus);
    RegisterTempleOfAhnQirajCreatureAI(boss_glob_of_viscidus);
}
