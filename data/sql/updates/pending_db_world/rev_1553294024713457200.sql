INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553294024713457200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7572;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7572);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7572, 0, 0, 1, 62, 0, 100, 0, 881, 0, 0, 0, 26, 2784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, ''),
(7572, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 26, 2801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, ''),
(7572, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, ''),
(7572, 0, 3, 4, 62, 0, 100, 0, 840, 2, 0, 0, 11, 11024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(7572, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, '');