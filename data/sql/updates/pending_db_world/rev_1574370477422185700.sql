INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1574370477422185700');

DELETE FROM `gameobject` WHERE `guid` = 164445 AND `id`= 180403; 
INSERT INTO `gameobject` VALUES 
(164445, 180403, 0, 0, 0, 1, 1, -14438.509766, 474.10745, 15.301989, 3.695229, 0, 0, 0, 0, 180, 100, 1, NULL, 0);

DELETE FROM `game_event_gameobject` WHERE `eventEntry` = 15 AND `guid` = 164445;
INSERT INTO `game_event_gameobject` VALUES (15, 164445);

UPDATE `creature` SET `position_x` = -14438.509766, `position_y` = 474.107452, `position_z` = 15.937873, `orientation` = 3.983454 WHERE `guid` = 203521;
UPDATE `creature` SET `position_x` = -14436.471680, `position_y` = 472.914825, `position_z` = 15.335059, `orientation` = 3.385898 WHERE `guid` = 54687;
UPDATE `creature` SET `position_x` = -14438.791992, `position_y` = 476.681549, `position_z` = 15.270824, `orientation` = 3.696133 WHERE `guid` = 54688;

DELETE FROM `game_event_creature` WHERE `guid` IN (203521, 54687, 54688); 
INSERT INTO `game_event_creature` VALUES  
(15, 203521),
(15, 54687),
(15, 54688);

