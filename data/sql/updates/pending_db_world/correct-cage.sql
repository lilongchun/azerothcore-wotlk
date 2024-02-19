-- remove faulty cages with unsniffed posis
DELETE FROM `gameobject` WHERE `id` = 185952 AND `guid` IN (265632, 265651, 265656, 265661, 265685, 265896, 266592, 266807, 267674, 267748, 268069, 268937); 
-- add new correct cage from sniff
DELETE FROM `gameobject` WHERE `id` = 185474 AND `guid` = 265632;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(265632, 185474, 548, 0, 0, 1, 1, 451.26233, -544.8354, -7.546607, 4.8345633, 0, 0, 0.7, -0.7, 300, 0, 1, '', 50791, NULL);
-- removing default npc flag gossip and questgiver from Olum
UPDATE `creature_template` SET `npcflag` = `npcflag` & ~2 & ~1 WHERE `entry` = 22820;
