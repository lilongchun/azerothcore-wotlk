/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_SPELLAURAS_H
#define ACORE_SPELLAURAS_H

#include "SpellAuraDefines.h"
#include "Unit.h"

class Unit;
class SpellInfo;
struct SpellModifier;
struct ProcTriggerSpell;
struct SpellProcEntry;

// forward decl
class AuraEffect;
class Aura;
class DynamicObject;
class AuraScript;

class AuraApplication
{
    friend void Unit::_ApplyAura(AuraApplication* aurApp, uint8 effMask);
    friend void Unit::_UnapplyAura(AuraApplicationMap::iterator& i, AuraRemoveMode removeMode);
    friend void Unit::_ApplyAuraEffect(Aura* aura, uint8 effIndex);
    friend void Unit::RemoveAura(AuraApplication* aurApp, AuraRemoveMode mode);
    friend AuraApplication* Unit::_CreateAuraApplication(Aura* aura, uint8 effMask);
private:
    Unit* const _target;
    Aura* const _base;
    AuraRemoveMode _removeMode: 8;                 // Store info for know remove aura reason
    uint8 _slot;                                   // Aura slot on unit
    uint8 _flags;                                  // Aura info flag
    uint8 _effectsToApply;                         // Used only at spell hit to determine which effect should be applied
    bool _needClientUpdate: 1;

    // xinef: stacking
    uint8 _disableMask;

    explicit AuraApplication(Unit* target, Unit* caster, Aura* base, uint8 effMask);
    void _Remove();
private:
    void _InitFlags(Unit* caster, uint8 effMask);
    void _HandleEffect(uint8 effIndex, bool apply);
public:
    Unit* GetTarget() const { return _target; }
    Aura* GetBase() const { return _base; }

    uint8 GetSlot() const { return _slot; }
    uint8 GetFlags() const { return _flags; }
    uint8 GetEffectMask() const { return _flags & (AFLAG_EFF_INDEX_0 | AFLAG_EFF_INDEX_1 | AFLAG_EFF_INDEX_2); }
    bool HasEffect(uint8 effect) const { ASSERT(effect < MAX_SPELL_EFFECTS);  return _flags & (1 << effect); }
    bool IsPositive() const { return _flags & AFLAG_POSITIVE; }
    bool IsSelfcasted() const { return _flags & AFLAG_CASTER; }
    uint8 GetEffectsToApply() const { return _effectsToApply; }

    void SetRemoveMode(AuraRemoveMode mode) { _removeMode = mode; }
    AuraRemoveMode GetRemoveMode() const {return _removeMode;}

    void SetNeedClientUpdate() { _needClientUpdate = true;}
    bool IsNeedClientUpdate() const { return _needClientUpdate;}
    void BuildUpdatePacket(ByteBuffer& data, bool remove) const;
    void ClientUpdate(bool remove = false);

    // xinef: stacking
    bool IsActive(uint8 effIdx) { return ((1 << effIdx) & _disableMask) == 0; }
    void SetDisableMask(uint8 effIdx) { _disableMask |= 1 << effIdx; }
    void RemoveDisableMask(uint8 effIdx) { _disableMask &= ~(1 << effIdx); }
};

class Aura
{
    friend Aura* Unit::_TryStackingOrRefreshingExistingAura(SpellInfo const* newAura, uint8 effMask, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, bool noPeriodicReset);
public:
    typedef std::map<ObjectGuid, AuraApplication*> ApplicationMap;

    static uint8 BuildEffectMaskForOwner(SpellInfo const* spellProto, uint8 avalibleEffectMask, WorldObject* owner);
    static Aura* TryRefreshStackOrCreate(SpellInfo const* spellproto, uint8 tryEffMask, WorldObject* owner, Unit* caster, int32* baseAmount = nullptr, Item* castItem = nullptr, ObjectGuid casterGUID = ObjectGuid::Empty, bool* refresh = nullptr, bool periodicReset = false);
    static Aura* TryCreate(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount = nullptr, Item* castItem = nullptr, ObjectGuid casterGUID = ObjectGuid::Empty, ObjectGuid itemGUID = ObjectGuid::Empty);
    static Aura* Create(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID = ObjectGuid::Empty);
    explicit Aura(SpellInfo const* spellproto, WorldObject* owner, Unit* caster, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID = ObjectGuid::Empty);
    void _InitEffects(uint8 effMask, Unit* caster, int32* baseAmount);
    virtual ~Aura();

    SpellInfo const* GetSpellInfo() const { return m_spellInfo; }
    uint32 GetId() const;

    ObjectGuid GetCastItemGUID() const { return m_castItemGuid; }
    uint32 GetCastItemEntry() const { return m_castItemEntry; }
    ObjectGuid GetCasterGUID() const { return m_casterGuid; }
    Unit* GetCaster() const;
    WorldObject* GetOwner() const { return m_owner; }
    Unit* GetUnitOwner() const { ASSERT(GetType() == UNIT_AURA_TYPE); return (Unit*)m_owner; }
    DynamicObject* GetDynobjOwner() const { ASSERT(GetType() == DYNOBJ_AURA_TYPE); return (DynamicObject*)m_owner; }

    AuraObjectType GetType() const;

    virtual void _ApplyForTarget(Unit* target, Unit* caster, AuraApplication* auraApp);
    virtual void _UnapplyForTarget(Unit* target, Unit* caster, AuraApplication* auraApp);
    void _Remove(AuraRemoveMode removeMode);
    virtual void Remove(AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT) = 0;

    virtual void FillTargetMap(std::map<Unit*, uint8>& targets, Unit* caster) = 0;
    void UpdateTargetMap(Unit* caster, bool apply = true);

    void _RegisterForTargets() {Unit* caster = GetCaster(); UpdateTargetMap(caster, false);}
    void ApplyForTargets() {Unit* caster = GetCaster(); UpdateTargetMap(caster, true);}
    void _ApplyEffectForTargets(uint8 effIndex);

    void UpdateOwner(uint32 diff, WorldObject* owner);
    void Update(uint32 diff, Unit* caster);

    time_t GetApplyTime() const { return m_applyTime; }
    int32 GetMaxDuration() const { return m_maxDuration; }
    void SetMaxDuration(int32 duration) { m_maxDuration = duration; }
    int32 CalcMaxDuration() const { return CalcMaxDuration(GetCaster()); }
    int32 CalcMaxDuration(Unit* caster) const;
    int32 GetDuration() const { return m_duration; }
    void SetDuration(int32 duration, bool withMods = false);
    void RefreshDuration();
    void RefreshTimers(bool periodicReset = false);
    void RefreshTimersWithMods();
    bool IsExpired() const { return !GetDuration();}
    bool IsPermanent() const { return GetMaxDuration() == -1; }

    uint8 GetCharges() const { return m_procCharges; }
    void SetCharges(uint8 charges);
    uint8 CalcMaxCharges(Unit* caster) const;
    uint8 CalcMaxCharges() const { return CalcMaxCharges(GetCaster()); }
    bool ModCharges(int32 num, AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT);
    bool DropCharge(AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT) { return ModCharges(-1, removeMode); }

    uint8 GetStackAmount() const { return m_stackAmount; }
    void SetStackAmount(uint8 num);
    bool ModStackAmount(int32 num, AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT, bool periodicReset = false);

    void RefreshSpellMods();

    uint8 GetCasterLevel() const { return m_casterLevel; }

    bool IsArea() const;
    bool IsPassive() const;
    bool IsDeathPersistent() const;
    bool IsRemovedOnShapeLost(Unit* target) const;
    bool CanBeSaved() const;
    bool IsRemoved() const { return m_isRemoved; }
    bool CanBeSentToClient() const;
    // Single cast aura helpers
    bool IsSingleTarget() const {return m_isSingleTarget; }
    bool IsSingleTargetWith(Aura const* aura) const;
    void SetIsSingleTarget(bool val) { m_isSingleTarget = val; }
    void UnregisterSingleTarget();
    int32 CalcDispelChance(Unit* auraTarget, bool offensive) const;

    void SetLoadedState(int32 maxduration, int32 duration, int32 charges, uint8 stackamount, uint8 recalculateMask, int32* amount);

    // helpers for aura effects
    bool HasEffect(uint8 effIndex) const { return bool(GetEffect(effIndex)); }
    bool HasEffectType(AuraType type) const;
    AuraEffect* GetEffect(uint8 effIndex) const { ASSERT (effIndex < MAX_SPELL_EFFECTS); return m_effects[effIndex]; }
    uint8 GetEffectMask() const { uint8 effMask = 0; for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i) if (m_effects[i]) effMask |= 1 << i; return effMask; }
    void RecalculateAmountOfEffects();
    void HandleAllEffects(AuraApplication* aurApp, uint8 mode, bool apply);

    // Helpers for targets
    ApplicationMap const& GetApplicationMap() {return m_applications;}
    void GetApplicationList(std::list<AuraApplication*>& applicationList) const;
    const AuraApplication* GetApplicationOfTarget (ObjectGuid guid) const { ApplicationMap::const_iterator itr = m_applications.find(guid); if (itr != m_applications.end()) return itr->second; return nullptr; }
    AuraApplication* GetApplicationOfTarget (ObjectGuid guid) { ApplicationMap::iterator itr = m_applications.find(guid); if (itr != m_applications.end()) return itr->second; return nullptr; }
    bool IsAppliedOnTarget(ObjectGuid guid) const { return m_applications.find(guid) != m_applications.end(); }

    void SetNeedClientUpdateForTargets() const;
    void HandleAuraSpecificMods(AuraApplication const* aurApp, Unit* caster, bool apply, bool onReapply);
    bool CanBeAppliedOn(Unit* target);
    bool CheckAreaTarget(Unit* target);
    bool CanStackWith(Aura const* checkAura, bool remove) const;
    bool IsAuraStronger(Aura const* newAura) const;

    // Proc system
    // this subsystem is not yet in use - the core of it is functional, but still some research has to be done
    // and some dependant problems fixed before it can replace old proc system (for example cooldown handling)
    // currently proc system functionality is implemented in Unit::ProcDamageAndSpell
    bool IsProcOnCooldown() const;
    void AddProcCooldown(uint32 msec);
    bool IsUsingCharges() const { return m_isUsingCharges; }
    void SetUsingCharges(bool val) { m_isUsingCharges = val; }
    void PrepareProcToTrigger(AuraApplication* aurApp, ProcEventInfo& eventInfo);
    bool IsProcTriggeredOnEvent(AuraApplication* aurApp, ProcEventInfo& eventInfo) const;
    float CalcProcChance(SpellProcEntry const& procEntry, ProcEventInfo& eventInfo) const;
    void TriggerProcOnEvent(AuraApplication* aurApp, ProcEventInfo& eventInfo);

    // AuraScript
    void LoadScripts();
    bool CallScriptCheckAreaTargetHandlers(Unit* target);
    void CallScriptDispel(DispelInfo* dispelInfo);
    void CallScriptAfterDispel(DispelInfo* dispelInfo);
    bool CallScriptEffectApplyHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode);
    bool CallScriptEffectRemoveHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode);
    void CallScriptAfterEffectApplyHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode);
    void CallScriptAfterEffectRemoveHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode);
    bool CallScriptEffectPeriodicHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp);
    void CallScriptEffectUpdatePeriodicHandlers(AuraEffect* aurEff);
    void CallScriptEffectCalcAmountHandlers(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated);
    void CallScriptEffectCalcPeriodicHandlers(AuraEffect const* aurEff, bool& isPeriodic, int32& amplitude);
    void CallScriptEffectCalcSpellModHandlers(AuraEffect const* aurEff, SpellModifier*& spellMod);
    void CallScriptEffectAbsorbHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount, bool& defaultPrevented);
    void CallScriptEffectAfterAbsorbHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount);
    void CallScriptEffectManaShieldHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount, bool& defaultPrevented);
    void CallScriptEffectAfterManaShieldHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount);
    void CallScriptEffectSplitHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& splitAmount);

    // Spell Proc Hooks
    bool CallScriptCheckProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo);
    bool CallScriptPrepareProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo);
    bool CallScriptProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo);
    void CallScriptAfterProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo);
    bool CallScriptEffectProcHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, ProcEventInfo& eventInfo);
    void CallScriptAfterEffectProcHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, ProcEventInfo& eventInfo);

    AuraScript* GetScriptByName(std::string const& scriptName) const;

    std::list<AuraScript*> m_loadedScripts;
private:
    void _DeleteRemovedApplications();
protected:
    SpellInfo const* const m_spellInfo;
    ObjectGuid const m_casterGuid;
    ObjectGuid const m_castItemGuid;                    // it is NOT safe to keep a pointer to the item because it may get deleted
    uint32 const m_castItemEntry;                       // when deleted, we could retrieve some information from template instead
    time_t const m_applyTime;
    WorldObject* const m_owner;

    int32 m_maxDuration;                                // Max aura duration
    int32 m_duration;                                   // Current time
    int32 m_timeCla;                                    // Timer for power per sec calcultion
    int32 m_updateTargetMapInterval;                    // Timer for UpdateTargetMapOfEffect

    uint8 const m_casterLevel;                          // Aura level (store caster level for correct show level dep amount)
    uint8 m_procCharges;                                // Aura charges (0 for infinite)
    uint8 m_stackAmount;                                // Aura stack amount

    AuraEffect* m_effects[3];
    ApplicationMap m_applications;

    bool m_isRemoved: 1;
    bool m_isSingleTarget: 1;                       // true if it's a single target spell and registered at caster - can change at spell steal for example
    bool m_isUsingCharges: 1;

private:
    Unit::AuraApplicationList m_removedApplications;
};

class UnitAura : public Aura
{
    friend Aura* Aura::Create(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID);

protected:
    explicit UnitAura(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID = ObjectGuid::Empty);

public:
    void _ApplyForTarget(Unit* target, Unit* caster, AuraApplication* aurApp) override;
    void _UnapplyForTarget(Unit* target, Unit* caster, AuraApplication* aurApp) override;

    void Remove(AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT) override;

    void FillTargetMap(std::map<Unit*, uint8>& targets, Unit* caster) override;

    // Allow Apply Aura Handler to modify and access m_AuraDRGroup
    void SetDiminishGroup(DiminishingGroup group) { m_AuraDRGroup = group; }
    DiminishingGroup GetDiminishGroup() const { return m_AuraDRGroup; }

private:
    DiminishingGroup m_AuraDRGroup: 8;              // Diminishing
};

class DynObjAura : public Aura
{
    friend Aura* Aura::Create(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID);

protected:
    explicit DynObjAura(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID = ObjectGuid::Empty);

public:
    void Remove(AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT) override;

    void FillTargetMap(std::map<Unit*, uint8>& targets, Unit* caster) override;
};
#endif
