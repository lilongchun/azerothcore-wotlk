INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618600341183458700');

DELETE FROM `spell_dbc` WHERE ID IN (20253,58620,58621,64382,20252,20616,20617,25272,25275);

INSERT INTO `spell_dbc` (`ID`, `Category`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `TargetCreatureType`, `RequiresSpellFocus`, `FacingCasterFlags`, `CasterAuraState`, `TargetAuraState`, `ExcludeCasterAuraState`, `ExcludeTargetAuraState`, `CasterAuraSpell`, `TargetAuraSpell`, `ExcludeCasterAuraSpell`, `ExcludeTargetAuraSpell`, `CastingTimeIndex`, `RecoveryTime`, `CategoryRecoveryTime`, `InterruptFlags`, `AuraInterruptFlags`, `ChannelInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `PowerType`, `ManaCost`, `ManaCostPerLevel`, `ManaPerSecond`, `ManaPerSecondPerLevel`, `RangeIndex`, `Speed`, `ModalNextSpell`, `CumulativeAura`, `Totem_1`, `Totem_2`, `Reagent_1`, `Reagent_2`, `Reagent_3`, `Reagent_4`, `Reagent_5`, `Reagent_6`, `Reagent_7`, `Reagent_8`, `ReagentCount_1`, `ReagentCount_2`, `ReagentCount_3`, `ReagentCount_4`, `ReagentCount_5`, `ReagentCount_6`, `ReagentCount_7`, `ReagentCount_8`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectChainTargets_1`, `EffectChainTargets_2`, `EffectChainTargets_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectPointsPerCombo_1`, `EffectPointsPerCombo_2`, `EffectPointsPerCombo_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `SpellVisualID_1`, `SpellVisualID_2`, `SpellIconID`, `ActiveIconID`, `SpellPriority`, `Name_Lang_enUS`, `Name_Lang_enGB`, `Name_Lang_koKR`, `Name_Lang_frFR`, `Name_Lang_deDE`, `Name_Lang_enCN`, `Name_Lang_zhCN`, `Name_Lang_enTW`, `Name_Lang_zhTW`, `Name_Lang_esES`, `Name_Lang_esMX`, `Name_Lang_ruRU`, `Name_Lang_ptPT`, `Name_Lang_ptBR`, `Name_Lang_itIT`, `Name_Lang_Unk`, `Name_Lang_Mask`, `NameSubtext_Lang_enUS`, `NameSubtext_Lang_enGB`, `NameSubtext_Lang_koKR`, `NameSubtext_Lang_frFR`, `NameSubtext_Lang_deDE`, `NameSubtext_Lang_enCN`, `NameSubtext_Lang_zhCN`, `NameSubtext_Lang_enTW`, `NameSubtext_Lang_zhTW`, `NameSubtext_Lang_esES`, `NameSubtext_Lang_esMX`, `NameSubtext_Lang_ruRU`, `NameSubtext_Lang_ptPT`, `NameSubtext_Lang_ptBR`, `NameSubtext_Lang_itIT`, `NameSubtext_Lang_Unk`, `NameSubtext_Lang_Mask`, `Description_Lang_enUS`, `Description_Lang_enGB`, `Description_Lang_koKR`, `Description_Lang_frFR`, `Description_Lang_deDE`, `Description_Lang_enCN`, `Description_Lang_zhCN`, `Description_Lang_enTW`, `Description_Lang_zhTW`, `Description_Lang_esES`, `Description_Lang_esMX`, `Description_Lang_ruRU`, `Description_Lang_ptPT`, `Description_Lang_ptBR`, `Description_Lang_itIT`, `Description_Lang_Unk`, `Description_Lang_Mask`, `AuraDescription_Lang_enUS`, `AuraDescription_Lang_enGB`, `AuraDescription_Lang_koKR`, `AuraDescription_Lang_frFR`, `AuraDescription_Lang_deDE`, `AuraDescription_Lang_enCN`, `AuraDescription_Lang_zhCN`, `AuraDescription_Lang_enTW`, `AuraDescription_Lang_zhTW`, `AuraDescription_Lang_esES`, `AuraDescription_Lang_esMX`, `AuraDescription_Lang_ruRU`, `AuraDescription_Lang_ptPT`, `AuraDescription_Lang_ptBR`, `AuraDescription_Lang_itIT`, `AuraDescription_Lang_Unk`, `AuraDescription_Lang_Mask`, `ManaCostPct`, `StartRecoveryCategory`, `StartRecoveryTime`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `StanceBarOrder`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `MinFactionID`, `MinReputation`, `RequiredAuraVision`, `RequiredTotemCategoryID_1`, `RequiredTotemCategoryID_2`, `RequiredAreasID`, `SchoolMask`, `RuneCostID`, `SpellMissileID`, `PowerDisplayID`, `Field227`, `Field228`, `Field229`, `SpellDescriptionVariableID`, `SpellDifficultyID`, `unk_320_2`, `unk_320_3`) VALUES
(20253,0,0,0,2424848,648,1077936128,0,0,0,0,0,262144,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,101,0,0,1,0,27,1,0,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,6,2,0,1,1,0,0,0,0,-1,0,0,12,0,0,6,6,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2816,0,15,0,50,"Intercept","","","","","","","","","","","","","","","",16712190,"Rank 1","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing ${1+$AP*0.12} damage (based on attack power) and stunning it for $20253d.","","","","","","","","","","","","","","","",16712190,"Stunned.","","","","","","","","","","","","","","","",16712190,0,0,0,0,0,0,0,0,0,2,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0), 
(58620,0,0,0,448,0,0,524288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,87376,100,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,6,0,0,1,0,0,0,0,0,-1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,58621,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,0,50,"Glyph of Chains of Ice","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,"Your Chains of Ice also causes $58621s1 Frost damage, increased by your attack power.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,15,0,0,0,0,1,0,0,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0), 
(58621,0,0,0,0,0,0,262144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,101,0,0,0,0,0,0,0,0,0,0,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,2,0,0,13,0,0,0,0,0,143,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11152,0,23,0,0,"Glyph of Chains of Ice","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,"Your Chains of Ice also causes $58621s1 Frost damage, increased by your attack power.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,0,0,0,0,16,0,0,0,0,1,1,0,0,0,0), 
(64382,0,0,0,2424848,512,0,1024,0,0,0,25165824,65536,0,0,0,0,1,0,0,0,0,0,0,0,0,16,300000,0,9,0,0,0,101,0,0,71,71,1,1,250,0,0,0,4,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,173555,0,2,6,0,1,1,0,0,0,0,11,-21,0,0,0,0,6,6,0,0,0,0,0,0,0,0,101,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13222,0,3998,0,0,"Shattering Throw","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,"Throws your weapon at the enemy causing ${$64382m1+$AP*.50} damage (based on attack power), reducing the armor on the target by $64382s2% for $64382d or removing any invulnerabilities.","","","","","","","","","","","","","","","",16712190,"Armor reduced by $s2%.","","","","","","","","","","","","","","","",16712190,0,133,1500,0,4,0,4194304,0,0,2,0,0,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0), 
(20252,1158,0,0,539295760,1024,0,0,0,0,8388608,262144,262144,0,0,0,0,1,0,0,0,0,0,0,0,65219,1,0,30000,0,0,0,0,0,0,0,30,30,0,1,100,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,96,64,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20253,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,516,0,0,"Intercept","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing ${$AP*0.12} damage (based on attack power) and stunning it for $20253d.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,4,1073741824,0,0,0,0,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0), 
(20616,1158,0,0,539295760,1024,0,0,0,0,8388608,262144,262144,0,0,0,0,1,0,0,0,0,0,0,0,65219,1,0,30000,0,0,0,0,0,0,0,42,42,0,1,100,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,96,64,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20614,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,516,0,0,"Intercept","","","","","","","","","","","","","","","",16712190,"Rank 2","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing $20614s2 damage and stunning it for $20614d.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,4,1073741824,0,0,0,0,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0), 
(20617,1158,0,0,539295760,1024,0,0,0,0,8388608,262144,262144,0,0,0,0,1,0,0,0,0,0,0,0,65219,1,0,30000,0,0,0,0,0,0,0,52,52,0,1,100,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,96,64,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20615,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,516,0,0,"Intercept","","","","","","","","","","","","","","","",16712190,"Rank 3","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing $20615s2 damage and stunning it for $20615d.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,4,1073741824,0,0,0,0,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0), 
(25272,1158,0,0,539295760,1024,0,0,0,0,8388608,262144,262144,0,0,0,0,1,0,0,0,0,0,0,0,65219,1,0,30000,0,0,0,0,0,0,0,61,61,0,1,100,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,96,64,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25273,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,516,0,0,"Intercept","","","","","","","","","","","","","","","",16712190,"Rank 4","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing $25273s2 damage and stunning it for $25273d.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,4,1073741824,0,0,0,0,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0), 
(25275,1158,0,0,539295760,1024,0,0,0,0,8388608,262144,262144,0,0,0,0,1,0,0,0,0,0,0,0,65219,1,0,30000,0,0,0,0,0,0,0,69,69,0,1,100,0,0,0,95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,96,64,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25274,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,516,0,0,"Intercept","","","","","","","","","","","","","","","",16712190,"Rank 5","","","","","","","","","","","","","","","",16712190,"Charge an enemy, causing $25274s2 damage and stunning it for $25274d.","","","","","","","","","","","","","","","",16712190,"","","","","","","","","","","","","","","","",16712190,0,0,0,0,4,1073741824,0,0,0,0,2,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0); 
