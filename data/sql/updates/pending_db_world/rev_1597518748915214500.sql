INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597518748915214500');'

-- Update Brewfest Music Doodad script
UPDATE `gameobject_template` SET `ScriptName`='go_brewfest_music' WHERE `entry`=186221;

-- Add missing Brewfest Music Doodad spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+1;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0 , 186221, 530, 1, 1, -1897.498, 5560.614, -12.34483, 4.363323, 0, 0, 0, 0, 120, 255, 1),
(@OGUID+1 , 186221, 530, 1, 1, 9325.442, -7276.318, 13.34217, 4.363323, 0, 0, 0, 0, 120, 255, 1);

-- Update Midsummer Music Doodad script
UPDATE `gameobject_template` SET `ScriptName`='go_midsummer_music' WHERE `entry`=188174;

-- Update Pirate Day Music Doodad script
UPDATE `gameobject_template` SET `ScriptName`='go_pirate_day_music' WHERE `entry`=190363;

-- Update Darkmoon Faire Music Doodad script
UPDATE `gameobject_template` SET `ScriptName`='go_darkmoon_faire_music' WHERE `entry`=180335;
