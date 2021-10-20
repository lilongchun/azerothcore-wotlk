/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Baron_Geddon
SD%Complete: 100
SDComment:
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Emotes
{
    EMOTE_SERVICE                   = 0
};

enum Spells
{
    SPELL_INFERNO                   = 19695,
    SPELL_INFERNO_DUMMY_EFFECT      = 19698, // Server side spell which inflicts damage
    SPELL_IGNITE_MANA               = 19659,
    SPELL_LIVING_BOMB               = 20475,
    SPELL_ARMAGEDDON                = 20479,
};

enum Events
{
    EVENT_INFERNO                   = 1,
    EVENT_IGNITE_MANA,
    EVENT_LIVING_BOMB,
};

class boss_baron_geddon : public CreatureScript
{
public:
    boss_baron_geddon() : CreatureScript("boss_baron_geddon") { }

    struct boss_baron_geddonAI : public BossAI
    {
        boss_baron_geddonAI(Creature* creature) : BossAI(creature, DATA_GEDDON),
            armageddonCasted(false)
        {
        }

        void Reset() override
        {
            _Reset();
            armageddonCasted = false;
        }

        void EnterCombat(Unit* /*attacker*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_INFERNO, urand(13000, 15000));
            events.ScheduleEvent(EVENT_IGNITE_MANA, urand(7000, 19000));
            events.ScheduleEvent(EVENT_LIVING_BOMB, urand(11000, 16000));
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            // If boss is below 2% hp - cast Armageddon
            if (!armageddonCasted && damage < me->GetHealth() && me->HealthBelowPctDamaged(2, damage))
            {
                me->InterruptNonMeleeSpells(true);
                if (me->CastSpell(me, SPELL_ARMAGEDDON) == SPELL_CAST_OK)
                {
                    Talk(EMOTE_SERVICE);
                }

                armageddonCasted = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_INFERNO:
                    {
                        DoCastSelf(SPELL_INFERNO);
                        events.RepeatEvent(urand(21000, 26000));
                        break;
                    }
                    case EVENT_IGNITE_MANA:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true, -SPELL_IGNITE_MANA))
                        {
                            DoCast(target, SPELL_IGNITE_MANA);
                        }

                        events.RepeatEvent(urand(27000, 32000));
                        break;
                    }
                    case EVENT_LIVING_BOMB:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        {
                            DoCast(target, SPELL_LIVING_BOMB);
                        }

                        events.RepeatEvent(urand(11000, 16000));
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        bool armageddonCasted;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_baron_geddonAI>(creature);
    }
};

// 19695 Inferno
class spell_geddon_inferno : public SpellScriptLoader
{
public:
    spell_geddon_inferno() : SpellScriptLoader("spell_geddon_inferno") { }

    class spell_geddon_inferno_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_geddon_inferno_AuraScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_INFERNO_DUMMY_EFFECT });
        }

        void PeriodicTick(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (Unit* caster = GetUnitOwner())
            {
                //The pulses come about 1 second apart and last for 10 seconds. Damage starts at 500 damage per pulse and increases by 500 every other pulse (500, 500, 1000, 1000, 1500, etc.). (Source: Wowwiki)
                int32 multiplier = 1;
                switch (aurEff->GetTickNumber())
                {
                    case 2:
                    case 3:
                        multiplier = 2;
                        break;
                    case 4:
                    case 5:
                        multiplier = 3;
                        break;
                    case 6:
                    case 7:
                        multiplier = 4;
                        break;
                    case 8:
                        multiplier = 5;
                        break;
                }

                caster->CastCustomSpell(SPELL_INFERNO_DUMMY_EFFECT, SPELLVALUE_BASE_POINT0, 500 * multiplier, caster, TRIGGERED_NONE, nullptr, aurEff);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_geddon_inferno_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_geddon_inferno_AuraScript();
    }
};

void AddSC_boss_baron_geddon()
{
    new boss_baron_geddon();

    // Spells
    new spell_geddon_inferno();
}
