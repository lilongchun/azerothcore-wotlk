INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553343090705922800');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` =25291;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid =25291);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25291, 0, 0, 0, 62, 0, 100, 0, 9761, 0, 0, 0, 11, 52909, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On click - Cast water breathing');
