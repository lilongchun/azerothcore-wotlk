INSERT INTO version_db_world (`sql_rev`) VALUES ('1545760746348146400');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2667;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2667);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2667, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 18, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ward of Laze - On Just Summoned - Set Unit Flags - Disable Movement'),
(2667, 0, 1, 0, 0, 0, 100, 0, 3, 3, 3, 3, 11, 3826, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ward of Laze - In Combat - Cast "Ward of Laze Passive"');

