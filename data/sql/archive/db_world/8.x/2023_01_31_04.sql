-- DB update 2023_01_31_03 -> 2023_01_31_04
-- Coilskar Sire (19768)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19768;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19768);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19768, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2500, 4700, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Siren - In Combat - Cast \'Water Bolt\''),
(19768, 0, 1, 0, 2, 0, 100, 0, 0, 99, 30000, 35000, 0, 11, 38026, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Siren - Between 0-99% Health - Cast \'Viscous Shield\'');
