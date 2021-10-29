INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620244782542375889');

-- Added missing aura for Magmadar
UPDATE `creature_template_addon` SET `auras`='19449' WHERE `entry`=11982;

-- 19411 Lava Bomb (used by Magmadar)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (19411, 20474) AND `ScriptName`='spell_magmadar_lava_bomb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19411, 'spell_magmadar_lava_bomb'),
(20474, 'spell_magmadar_lava_bomb');

-- Renamed Core Hound script
update `creature_template` SET `ScriptName`='npc_mc_core_hound' WHERE `entry`=11671;

-- Timers update for NPC "Flamewaker Protector"
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=5000, `event_param3`=6500, `event_param4`=6500 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=10000, `event_param3`=7000, `event_param4`=7000 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Timers update for NPC "Flamewaker"
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param2`=6000, `event_param3`=10000, `event_param4`=13000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param3`=4000, `event_param4`=6000 WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=4000, `event_param2`=9000, `event_param3`=5000, `event_param4`=8000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=2 AND `link`=0;

-- Garr texts
DELETE FROM `creature_text` WHERE `CreatureID`=12057 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12057, 0, 0, '%s forces one of his Firesworn minions to erupt!', 41, 0, 100, 0, 0, 0, 8254, 0, 'Garr EMOTE_MASS_ERRUPTION');

-- Garr
-- Firesworn
-- add them immolate and thrash auras 
UPDATE `creature_template_addon` SET `auras`='8876 15733' WHERE `entry`=12099;

-- Conditions for spell "21086 Encouragement"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21086 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21086, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Encouragement Effects 1 and Effect 2  - can target Flamewaker Healer');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21086 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11664 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21086, 0, 1, 31, 0, 3, 11664, 0, 0, 0, 0, '', 'Encouragement Effects 1 and Effect 2 - can target Flamewaker Elite');

-- Conditions for spell "21090 Champion"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=21090 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 21090, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Healer');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=21090 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11664 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 21090, 0, 1, 31, 0, 3, 11664, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Elite');

-- Conditions for spell "21087 Immunity"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21087 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21087, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Healer');

-- Texts
DELETE FROM `creature_text` WHERE `CreatureID`=12018 AND `GroupID`=7 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12018, 7, 0, 'You think you\'ve won already? Perhaps you\'ll need another lesson in pain!', 14, 0, 100, 0, 0, 0, 8545, 0, 'majordomo SAY_LAST_ADD');

-- Majordomu summon
DELETE FROM `creature_summon_groups` WHERE `summonerId`=12018;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(12018, 0, 1, 11663, 761.652, -1164.3, -119.533, 3.3919, 1, 10000),
(12018, 0, 1, 11663, 747.323, -1149.24, -120.06, 3.6629, 1, 10000),
(12018, 0, 1, 11663, 766.734, -1183.16, -119.292, 2.9889, 1, 10000),
(12018, 0, 1, 11663, 757.364, -1198.31, -118.652, 2.3095, 1, 10000),
(12018, 0, 1, 11664, 752.349, -1159.19, -119.261, 3.6032, 1, 10000),
(12018, 0, 1, 11664, 738.015, -1152.22, -119.512, 4.0792, 1, 10000),
(12018, 0, 1, 11664, 757.246, -1189.79, -118.633, 2.5333, 1, 10000),
(12018, 0, 1, 11664, 745.916, -1199.35, -118.119, 1.8932, 1, 10000);

-- Molten Giant
UPDATE `creature_template_addon` SET `auras`='18943' WHERE  `entry`=11658;
update `creature_addon` set `auras`='18943' where `guid` in (select `guid` from `creature` where `id`=11658);
UPDATE `smart_scripts` SET `event_param1`='6000', `event_param2`='10000', `event_param3`='7000', `event_param4`='10000' WHERE  `entryorguid`=11658 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`='6000', `event_param2`='11000', `event_param3`='12000', `event_param4`='16000' WHERE  `entryorguid`=11658 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Firelord
UPDATE `creature_template_addon` SET `auras`='19396' WHERE  `entry`=11668;
update creature_addon set `auras`='19396' where `guid` in (select `guid` from `creature` where `id`=11668);
UPDATE `smart_scripts` SET `event_param1`='4000', `event_param3`='2000', `event_param4`='4000' WHERE  `entryorguid`=11668 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param2`='15000', `event_param3`='15000', `event_param4`='15000' WHERE  `entryorguid`=11668 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Ancient Core Hound
UPDATE `creature_template_addon` SET `auras`='18950' WHERE  `entry`=11658;
update creature_addon set `auras`='18950' where `guid` in (select `guid` from `creature` where `id`=11658);

-- Fire Imp
update `creature_template` set `AIName`='SmartAI' where `entry`=11669;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11669 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11669, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 4000, 7000, 0, 11, 20602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flame Imp - IC - Cast Fire Nova');

-- spell "Play Dead" aura script (used by core hounds)
DELETE FROM `spell_script_names` WHERE `spell_id`=19822 AND `ScriptName`='spell_mc_play_dead';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19822, 'spell_mc_play_dead');

-- Magmadar linked respawn data
-- set @magmadarGUID := (SELECT `guid` from `creature` WHERE `id` = 11982 AND `map`=409);
SET @magmadarGUID := 56683;
DELETE FROM `linked_respawn` WHERE `guid` IN (SELECT `guid` from `creature` WHERE `id` IN (11671, 11673) AND `map`=409);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`)
SELECT `guid`, CONCAT(@magmadarGUID), CONCAT(0) from `creature` WHERE `id` IN (11671, 11673) AND `map`=409;

-- Added "18950 Invisibility and Stealth Detection" to Ancient Core Hounds
UPDATE `creature_template_addon` SET `auras`='18950' WHERE  `entry`=11673;

-- 19695 Inferno (used by Geddon)
DELETE FROM `spell_script_names` WHERE `spell_id`=19695 AND `ScriptName`='spell_geddon_inferno';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19695, 'spell_geddon_inferno');

-- Added "Thrash" aura for Core Rager
UPDATE `creature_template_addon` SET `auras`='12787 20553' WHERE  `entry`=11672;

-- Added missing auras for Golemagg
UPDATE `creature_template_addon` SET `auras`='13879 18943 20556' WHERE  `entry`=11988;

-- spell "Attract Rager"(20544) condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=20544 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11672 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 20544, 0, 0, 31, 0, 3, 11672, 0, 0, 0, 0, '', 'Spell Attract Rager should target only Core Rager');

-- Core Hound formations
-- GROUP 1
-- 56638, 56635, 56637, 56634, 56636
set @leader := 56638;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@leader, 56635, 56637, 56634, 56636);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@leader, 56635, 56637, 56634, 56636);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@leader, @leader, 0, 0, 2, 0, 0),
(@leader, 56635, 0, 0, 3, 0, 0),
(@leader, 56637, 0, 0, 3, 0, 0),
(@leader, 56634, 0, 0, 3, 0, 0),
(@leader, 56636, 0, 0, 3, 0, 0);
-- GROUP 2
-- 56629, 56630, 56632, 56633, 56631
set @leader := 56629;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@leader, 56630, 56632, 56633, 56631);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@leader, 56630, 56632, 56633, 56631);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@leader, @leader, 0, 0, 2, 0, 0),
(@leader, 56630, 0, 0, 3, 0, 0),
(@leader, 56632, 0, 0, 3, 0, 0),
(@leader, 56633, 0, 0, 3, 0, 0),
(@leader, 56631, 0, 0, 3, 0, 0);
-- GROUP 3
-- 56639, 56641, 56642, 56643, 56640
set @leader := 56639;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@leader, 56641, 56642, 56643, 56640);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@leader, 56641, 56642, 56643, 56640);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@leader, @leader, 0, 0, 2, 0, 0),
(@leader, 56641, 0, 0, 3, 0, 0),
(@leader, 56642, 0, 0, 3, 0, 0),
(@leader, 56643, 0, 0, 3, 0, 0),
(@leader, 56640, 0, 0, 3, 0, 0);
-- GROUP 4
-- 56651, 56650, 56652, 56653, 56654
set @leader := 56651;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@leader, 56650, 56652, 56653, 56654);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@leader, 56650, 56652, 56653, 56654);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@leader, @leader, 0, 0, 2, 0, 0),
(@leader, 56650, 0, 0, 3, 0, 0),
(@leader, 56652, 0, 0, 3, 0, 0),
(@leader, 56653, 0, 0, 3, 0, 0),
(@leader, 56654, 0, 0, 3, 0, 0);
-- GROUP 5
-- 56648, 56644, 56646, 56649, 56647
set @leader := 56648;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@leader, 56644, 56646, 56649, 56647);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@leader, 56644, 56646, 56649, 56647);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@leader, @leader, 0, 0, 2, 0, 0),
(@leader, 56644, 0, 0, 3, 0, 0),
(@leader, 56646, 0, 0, 3, 0, 0),
(@leader, 56649, 0, 0, 3, 0, 0),
(@leader, 56647, 0, 0, 3, 0, 0);

-- Lucifron Flamewalkers
-- These minions has formation data and they always follows Lucifron
/* ERROR MSG:
WaypointMovementGenerator::LoadPath: creature Flamewaker Protector (GUID Full: 0xf130002f5700006c Type: Creature Entry: 12119  Low: 108) doesn't have waypoint path id: 566060
WaypointMovementGenerator::LoadPath: creature Flamewaker Protector (GUID Full: 0xf130002f5700006d Type: Creature Entry: 12119  Low: 109) doesn't have waypoint path id: 566070
*/
UPDATE `creature_addon` SET `path_id`='0' WHERE `guid` IN (56606, 56607);
update `creature` set `MovementType`=0 where `guid` IN (56606, 56607);

-- Garr's Firesworn
UPDATE `creature_template` SET `ScriptName`='npc_garr_firesworn' WHERE `entry`=12099;

-- Garr's "Separation Anexiety"(23487, server side)
UPDATE `spell_dbc` SET `EffectAura_1`=226, `EffectAuraPeriod_1`=1000 WHERE  `Id`=23487;
DELETE FROM `spell_script_names` WHERE `spell_id`=23487 AND `ScriptName`='spell_garr_separation_nexiety';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23487, 'spell_garr_separation_nexiety');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=23487 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=12099 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 23487, 0, 0, 31, 0, 3, 12099, 0, 0, 0, 0, '', 'Separation Anexiety (effect 0) - should target only Firesworn');

-- Removed script for "Son of Flame"
update `creature_template` set `ScriptName`='' where `entry`=12143;

-- Garr's linked respawn data
-- set @garrGUID := (SELECT `guid` from `creature` WHERE `id` = 12101 AND `map`=409);
SET @garrGUID := 56683;
DELETE FROM `linked_respawn` WHERE `guid` IN (SELECT `guid` from `creature` WHERE `id` = 12101 AND `map`=409);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`)
SELECT `guid`, CONCAT(@magmadarGUID), CONCAT(0) from `creature` WHERE `id` = 12101 AND `map`=409;

-- "19515 Frenzy (SERVERSIDE)" used by Garr's Firesworn
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=19515 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=1 AND `ConditionValue1`=3 AND `ConditionValue2`=12057 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 19515, 0, 0, 31, 1, 3, 12057, 0, 0, 0, 0, '', 'Frenzy (SERVERSIDE) - should target only Garr');

-- Allow casting while dead
update `spell_dbc` set `attributesEx`=`attributesEx` | 0x00800000 where `id` = 19515;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=19515 AND `spell_effect`=19516 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(19515, 19516, 1, 'Frenzy - On Hit - Trigger Enrage');

-- 20482 Firesworn Eruption Trigger (SERVERSIDE)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=20482 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=1 AND `ConditionValue1`=3 AND `ConditionValue2`=12099 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 20482, 0, 0, 31, 1, 3, 12099, 0, 0, 0, 0, '', 'spell "Firesworn Eruption Trigger" should target only Firesworn');

-- 20482 Firesworn Eruption Trigger (SERVERSIDE)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=20482 AND `spell_effect`=20483 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(20482, 20483, 1, 'Firesworn Eruption Trigger - On Hit - Trigger Massive Eruption');
