INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557952462090372016');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 25765 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(25765,0,0,1,38,0,100,0,0,1,0,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - On Data Set 0 1 - Set Data 0 0'),
(25765,0,1,2,61,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - Linked - Set Active On'),
(25765,0,2,0,61,0,100,0,0,0,0,0,0,53,0,25765,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - Linked - Start Waypoint'),
(25765,0,3,4,40,0,100,0,22,25765,0,0,0,54,45000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - On Waypoint 22 Reached - Pause Waypoint'),
(25765,0,4,0,61,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - Linked - Set Run On'),
(25765,0,5,6,40,0,100,0,74,25765,0,0,0,11,47460,3,0,0,0,0,11,26817,5,0,0,0,0,0,0,'Fizzcrank Bomber - On Waypoint 74 Reached - Cast \'Fizzcrank Pilot - Gett Off Plane\''),
(25765,0,6,0,61,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fizzcrank Bomber - Linked - Despawn Instant');
