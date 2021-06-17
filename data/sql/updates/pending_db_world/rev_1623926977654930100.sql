INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623926977654930100');

SET @WRETCHED_CAPTIVE = 16916;
SET @SERGEANT_KANREN = 16924;

-- Set the Wretched Captive's orientation facing Sergeant Kan'ren
UPDATE `creature` SET `orientation` = 4.07927 WHERE `id` = @WRETCHED_CAPTIVE;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @WRETCHED_CAPTIVE;

-- Better scripting on the event
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @WRETCHED_CAPTIVE);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@WRETCHED_CAPTIVE, 0, 0, 1, 38, 0, 100, 0, 1, 1, 1000, 40000, 0, 5, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wretched Captive - On Data Set 1 1 - Play Emote 20'),
(@WRETCHED_CAPTIVE, 0, 1, 0, 61, 0, 100, 0, 1, 1, 1000, 40000, 0, 1, 0, 12000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wretched Captive - On Data Set 1 1 - Say Line 0'),
(@WRETCHED_CAPTIVE, 0, 3, 0, 52, 0, 100, 0, 0, @WRETCHED_CAPTIVE, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @SERGEANT_KANREN, 15, 0, 0, 0, 0, 0, 0, 'Wretched Captive - On Text 0 Over - Set Data 1 1'),
(@WRETCHED_CAPTIVE, 0, 4, 5, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wretched Captive - On Data Set 2 2 - Play Emote 18'),
(@WRETCHED_CAPTIVE, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 19, @SERGEANT_KANREN, 15, 0, 0, 0, 0, 0, 0, 'Wretched Captive - On Data Set 2 2 - Set Data 0 0');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @SERGEANT_KANREN;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @SERGEANT_KANREN);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SERGEANT_KANREN, 0, 0, 0, 101, 0, 100, 0, 1, 40, 2000, 180000, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Kan\'ren - On Min Players in Range - Say Line 0'),
(@SERGEANT_KANREN, 0, 1, 0, 52, 0, 100, 0, 0, @SERGEANT_KANREN, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16916, 15, 0, 0, 0, 0, 0, 0, 'Sergeant Kan\'ren - On Text 0 Over - Set Data 1 1'),
(@SERGEANT_KANREN, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 1, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Kan\'ren - On Data Set 1 1 - Say Line 1'),
(@SERGEANT_KANREN, 0, 3, 0, 52, 0, 100, 0, 1, @SERGEANT_KANREN, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 16916, 15, 0, 0, 0, 0, 0, 0, 'Sergeant Kan\'ren - On Text 1 Over - Set Data 2 2');
