INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587689314000956500');


UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=25623;

DELETE FROM `smart_scripts` WHERE `entryorguid`=25623 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25623, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 4000, 6000, 11, 54185, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harvest Collector - IC - Cast Claw Slash'),
(25623, 0, 1, 0, 8, 0, 100, 0, 47166, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harvest Collector - On spell hit - Despawn');
