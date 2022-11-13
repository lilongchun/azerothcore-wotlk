-- Terrowulf Packlord 
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51870 AND `id1`=3792;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3792);
-- Akkrilus
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51883 AND `id1`=3773;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3773);

INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(52022, 3773, 1, 0, 0, 1, 1, 1, 2286.01953125, 44.71516799926757812, 102.4616622924804687, 1.413716673851013183, 75600, 0, 0, 684, 693, 0, 0, 0, 0, 46368);

DELETE FROM `pool_template` WHERE `entry`=1077 AND `description`='Akkrilus Rare Spawn';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1077, 1, 'Akkrilus Rare Spawn');

DELETE FROM `pool_creature` WHERE `pool_entry`=1077 AND `guid` IN (51883, 52022);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
(51883,1077,'Akkrilus spawn 1'),
(52022,1077,'Akkrilus spawn 2');

-- Eck'alom
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=32879 AND `id1`=10642;
-- Mugglefin
UPDATE `creature` SET `spawntimesecs`=30600 WHERE `guid`=51884 AND `id1`=10643;
DELETE FROM `creature` WHERE `guid` IN (51887);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(51887, 10643, 1, 0, 0, 1, 1, 1, 3066.543212890625, 500.173492431640625, 1.209225177764892578, 6.088938713073730468, 30600, 4, 0, 908, 0, 1, 0, 0, 0, 46368);

DELETE FROM `pool_template` WHERE `entry`=1047 AND `description`='Mugglefin Rare Spawn';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1047, 1, 'Mugglefin Rare Spawn');

DELETE FROM `pool_creature` WHERE `pool_entry`=1047 AND `guid` IN (51884, 51887);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
(51884,1047,'Mugglefin spawn 1'),
(51887,1047,'Mugglefin spawn 2');
-- Ursol lok
UPDATE `creature` SET `spawntimesecs`=37800 WHERE `guid`=51884 AND `id1`=12037;
