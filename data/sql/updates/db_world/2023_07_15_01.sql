-- DB update 2023_07_15_00 -> 2023_07_15_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23168;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23168);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23168, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 10000, 12000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Or\'kaos the Insane - In Combat - Cast \'Uppercut\''),
(23168, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 6000, 10000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Or\'kaos the Insane - In Combat - Cast \'Cleave\' '),
(23168, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 6000, 10000, 0, 11, 17547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Or\'kaos the Insane - In Combat - Cast \'Mortal Strike\'');
