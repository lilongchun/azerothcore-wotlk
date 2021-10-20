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

-- Added "Magma Splash" aura for Golemagg
UPDATE `creature_template_addon` SET `auras`='13879' WHERE  `entry`=11988;
