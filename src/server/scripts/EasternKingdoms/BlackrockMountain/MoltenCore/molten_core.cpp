/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#include "ScriptMgr.h"
#include "molten_core.h"
#include "SpellScript.h"

// 19822 Play Dead
class spell_mc_play_dead : public SpellScriptLoader
{
public:
    spell_mc_play_dead() : SpellScriptLoader("spell_mc_play_dead") { }

    class spell_mc_play_dead_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mc_play_dead_AuraScript);

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* target = GetTarget()->ToCreature())
            {
                target->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                target->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                //target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                target->SetReactState(REACT_PASSIVE);
                target->SetControlled(true, UNIT_STATE_ROOT);
                target->AttackStop();
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* target = GetTarget()->ToCreature())
            {
                target->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                target->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                //target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                target->SetControlled(false, UNIT_STATE_ROOT);
                target->SetReactState(REACT_AGGRESSIVE);

                if (target->IsInCombat())
                {
                    bool shouldDie = true;
                    std::list<Creature*> hounds;
                    target->GetCreaturesWithEntryInRange(hounds, 80, NPC_CORE_HOUND);
                    if (!hounds.empty())
                    {
                        // Alive hound been found within 80 yards -> cancel suicide
                        if (std::find_if(hounds.begin(), hounds.end(), [this](Creature const* hound)
                        {
                            return hound->IsAlive() && !hound->HasAura(m_scriptSpellId);
                        }) != hounds.end())
                        {
                            shouldDie = false;
                        }
                    }

                    if (!shouldDie)
                    {
                        target->SetFullHealth();
                        target->AI()->SetData(1, 1);
                    }
                    else
                    {
                        Unit::Kill(target, target);
                    }
                }
            }
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectApplyFn(spell_mc_play_dead_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_FEIGN_DEATH, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_mc_play_dead_AuraScript();
    }
};

void AddSC_molten_core()
{
    new spell_mc_play_dead();
}
