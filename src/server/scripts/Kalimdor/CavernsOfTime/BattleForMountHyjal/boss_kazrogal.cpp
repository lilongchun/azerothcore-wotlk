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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"
#include "hyjal_trash.h"

enum Spells
{
    SPELL_CLEAVE        = 31436,
    SPELL_WARSTOMP      = 31480,
    SPELL_MARK          = 31447,
    SPELL_MARK_DAMAGE   = 31463
};

enum Texts
{
    SAY_ONSLAY          = 0,
    SAY_MARK            = 1,
    SAY_ONAGGRO         = 2,
};

enum Sounds
{
    SOUND_ONDEATH       = 11018,
};

enum Misc
{
    PATH_KAZROGAL       = 178880,
    POINT_COMBAT_START  = 7
};

class boss_kazrogal : public CreatureScript
{
public:
    boss_kazrogal() : CreatureScript("boss_kazrogal") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<boss_kazrogalAI>(creature);
    }

    struct boss_kazrogalAI : public hyjal_trashAI
    {
        boss_kazrogalAI(Creature* creature) : hyjal_trashAI(creature)
        {
            instance = creature->GetInstanceScript();
            go = false;
        }

        uint32 CleaveTimer;
        uint32 WarStompTimer;
        uint32 MarkTimer;
        uint32 MarkTimerBase;
        bool go;

        void Reset() override
        {
            damageTaken = 0;
            CleaveTimer = 5000;
            WarStompTimer = 15000;
            MarkTimer = 45000;
            MarkTimerBase = 45000;

            if (IsEvent)
                instance->SetData(DATA_KAZROGALEVENT, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (IsEvent)
                instance->SetData(DATA_KAZROGALEVENT, IN_PROGRESS);
            Talk(SAY_ONAGGRO);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_ONSLAY);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId == POINT_COMBAT_START && instance)
            {
                Unit* target = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_THRALL));
                if (target && target->IsAlive())
                    me->AddThreat(target, 0.0f);
            }
        }

        void JustDied(Unit* killer) override
        {
            hyjal_trashAI::JustDied(killer);
            if (IsEvent)
                instance->SetData(DATA_KAZROGALEVENT, DONE);
            DoPlaySoundToSet(me, SOUND_ONDEATH);
        }

        void UpdateAI(uint32 diff) override
        {
            if (IsEvent)
            {
                //Must update npc_escortAI
                npc_escortAI::UpdateAI(diff);
                if (!go)
                {
                    go = true;
                    me->GetMotionMaster()->MovePath(PATH_KAZROGAL, false);
                }
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (CleaveTimer <= diff)
            {
                DoCast(me, SPELL_CLEAVE);
                CleaveTimer = 6000 + rand() % 15000;
            }
            else CleaveTimer -= diff;

            if (WarStompTimer <= diff)
            {
                DoCast(me, SPELL_WARSTOMP);
                WarStompTimer = 60000;
            }
            else WarStompTimer -= diff;

            if (MarkTimer <= diff)
            {
                DoCastAOE(SPELL_MARK);

                MarkTimerBase -= 5000;
                if (MarkTimerBase < 5500)
                    MarkTimerBase = 5500;
                MarkTimer = MarkTimerBase;
                Talk(SAY_MARK);
            }
            else MarkTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class spell_mark_of_kazrogal : public SpellScriptLoader
{
public:
    spell_mark_of_kazrogal() : SpellScriptLoader("spell_mark_of_kazrogal") { }

    class spell_mark_of_kazrogal_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mark_of_kazrogal_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_kazrogal_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    class spell_mark_of_kazrogal_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mark_of_kazrogal_AuraScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_MARK_DAMAGE });
        }

        void OnPeriodic(AuraEffect const* aurEff)
        {
            Unit* target = GetTarget();

            if (target->GetPower(POWER_MANA) == 0)
            {
                target->CastSpell(target, SPELL_MARK_DAMAGE, true, nullptr, aurEff);
                // Remove aura
                SetDuration(0);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_kazrogal_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_MANA_LEECH);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_mark_of_kazrogal_SpellScript();
    }

    AuraScript* GetAuraScript() const override
    {
        return new spell_mark_of_kazrogal_AuraScript();
    }
};

void AddSC_boss_kazrogal()
{
    new boss_kazrogal();
    new spell_mark_of_kazrogal();
}

