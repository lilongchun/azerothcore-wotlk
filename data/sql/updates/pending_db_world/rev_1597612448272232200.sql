INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597612448272232200');

UPDATE `gameobject_template` SET `ScriptName`='go_brewfest_music' WHERE `entry`=186221;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+1;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0 , 186221, 530, 1, 1, -1897.498, 5560.614, -12.34483, 4.363323, 0, 0, 0, 0, 120, 255, 1),
(@OGUID+1 , 186221, 530, 1, 1, 9325.442, -7276.318, 13.34217, 4.363323, 0, 0, 0, 0, 120, 255, 1);