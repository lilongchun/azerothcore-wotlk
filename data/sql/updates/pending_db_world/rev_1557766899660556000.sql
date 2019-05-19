INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557766899660556000');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27122;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 27122);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27122, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Deathgaze - On Aggro - Cast \'12739\''),
(27122, 0, 1, 0, 0, 0, 100, 0, 3300, 3300, 4600, 4600, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Deathgaze - In Combat - Cast \'12739\''),
(27122, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 45000, 45000, 11, 50659, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Deathgaze - In Combat - Cast \'50659\'');
