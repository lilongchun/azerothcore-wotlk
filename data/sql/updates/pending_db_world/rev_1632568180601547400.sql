INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632568180601547400');

UPDATE ``smart_scripts` SET `action_param3`='990000' WHERE  `entryorguid`=179666 AND `source_type`=1 AND `id`=0 AND `link`=0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=14460;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14460, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 89, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - Is Summoned - Random Move'),
(14460, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 10000, 16000, 0, 11, 23113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - In Combat - Cast Blast Wave');
