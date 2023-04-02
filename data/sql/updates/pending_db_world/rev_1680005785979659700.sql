SET @NPC := 3110421;
DELETE FROM `creature` WHERE `guid` IN (@NPC+1, @NPC+2, @NPC+3, @NPC+4, @NPC+5, @NPC+6, @NPC+7, @NPC+8, @NPC+9, @NPC+10, @NPC+11, @NPC+12, @NPC+13, @NPC+14, @NPC+15, @NPC+16, @NPC+17, @NPC+18, @NPC+19, @NPC+20, @NPC+21, @NPC+22, @NPC+23, @NPC+24, @NPC+25, @NPC+26, @NPC+27, @NPC+28, @NPC+29, @NPC+30, @NPC+31, @NPC+32, @NPC+33, @NPC+34, @NPC+35, @NPC+36, @NPC+37, @NPC+38, @NPC+39, @NPC+40);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
-- HORDE
(@NPC+1, 18816, 0, 0, 530, 0, 0, 1, 1, 0, -1523.92, 7951.76, -17.6942, 3.51172, 300, 0, 0, 59130, 0, 0, 3, 4096, 0, "", 0),
(@NPC+2, 18821, 0, 0, 530, 0, 0, 1, 1, 0, -1527.75, 7952.46, -17.6948, 3.99317, 300, 0, 0, 70965, 2790, 0, 128, 4096, 0, "", 0),
(@NPC+3, 21474, 0, 0, 530, 0, 0, 1, 1, 0, -1520.14, 7927.11, -20.2527, 3.39389, 300, 0, 0, 104790, 0, 0, 4224, 4096, 0, "", 0),
(@NPC+4, 21484, 0, 0, 530, 0, 0, 1, 1, 0, -1524.84, 7930.34, -20.182, 3.6405, 300, 0, 0, 104790, 0, 0, 128, 4096, 0, "", 0),
(@NPC+5, 21483, 0, 0, 530, 0, 0, 1, 1, 0, -1570.01, 7993.8, -22.4505, 5.02655, 300, 0, 0, 104790, 0, 0, 128, 4096, 0, "", 0),
(@NPC+6, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1654.06, 8000.46, -26.59, 3.37, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+7, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1487.18, 7899.1, -19.53, 0.954, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+8, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1480.88, 7908.79, -19.19, 4.485, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+9, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1540.56, 7995.44, -20.45, 0.947, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+10, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1546.95, 8000.85, -20.72, 6.035, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+11, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1595.31, 7860.53, -21.51, 3.747, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+12, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1651.54, 7988.56, -26.5289, 2.98451, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+13, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1602.46, 7866.43, -22.1177, 4.74729, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+14, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1586.58, 7932.62, -24.76, 1.00684, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+15, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1545.57, 7935.83, -21.13, 3.448, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+16, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1585.73, 7994.68, -23.29, 4.439, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+17, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1578.2544, 7942.152, -22.726915, 3.317, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 1
(@NPC+18, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1601.5521, 7950.475, -25.48774, 1.094, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 2
(@NPC+19, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1611.6683, 7957.6304, -27.328438, 5.567, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 3
(@NPC+20, 18192, 0, 0, 530, 0, 0, 1, 1, 0, -1593.7784, 7988.3916, -23.511473, 4.34587, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "OutdoorPvP_nagrandCreature", 0), -- PATROL 4
-- ALLIANCE
(@NPC+21, 18817, 0, 0, 530, 0, 0, 1, 1, 0, -1591.18, 8020.39, -22.2042, 4.59022, 300, 0, 0, 59130, 0, 0, 3, 4096, 0, "", 0),
(@NPC+22, 18822, 0, 0, 530, 0, 0, 1, 1, 0, -1588.00, 8019.00, -22.2042, 4.06662, 300, 0, 0, 70965, 2790, 0, 128, 4096, 0, "", 0),
(@NPC+23, 21485, 0, 0, 530, 0, 0, 1, 1, 0, -1521.93, 7927.37, -20.2299, 3.24631, 300, 0, 0, 104790, 0, 0, 4224, 4096, 0, "", 0),
(@NPC+24, 21487, 0, 0, 530, 0, 0, 1, 1, 0, -1540.33, 7971.95, -20.7186, 3.07178, 300, 0, 0, 104790, 0, 0, 128, 4096, 0, "", 0),
(@NPC+25, 21488, 0, 0, 530, 0, 0, 1, 1, 0, -1570.01, 7993.8, -22.4505, 5.02655, 300, 0, 0, 104790, 0, 0, 128, 4096, 0, "", 0),
(@NPC+26, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1654.06, 8000.46, -26.59, 3.37, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+27, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1487.18, 7899.1, -19.53, 0.954, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+28, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1480.88, 7908.79, -19.19, 4.485, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+29, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1540.56, 7995.44, -20.45, 0.947, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+30, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1546.95, 8000.85, -20.72, 6.035, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+31, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1595.31, 7860.53, -21.51, 3.747, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+32, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1651.54, 7988.56, -26.5289, 2.98451, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+33, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1602.46, 7866.43, -22.1177, 4.74729, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+34, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1586.58, 7932.62, -24.76, 1.00684, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+35, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1545.57, 7935.83, -21.13, 3.448, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+36, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1585.73, 7994.68, -23.29, 4.439, 3600, 0, 0, 1182800, 0, 0, 0, 4096, 0, "", 0),
(@NPC+37, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1578.2544, 7942.152, -22.726915, 3.317, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 1
(@NPC+38, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1601.5521, 7950.475, -25.48774, 1.094, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 2
(@NPC+39, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1611.6683, 7957.6304, -27.328438, 5.567, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0), -- PATROL 3
(@NPC+40, 18256, 0, 0, 530, 0, 0, 1, 1, 0, -1593.7784, 7988.3916, -23.511473, 4.34587, 3600, 0, 0, 1182800, 0, 2, 0, 4096, 0, "", 0); -- PATROL 4

-- HORDE
SET @NPCPAT1 := @NPC+17;
SET @PATH := @NPCPAT1 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT1;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT1,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1578.2544,7942.152,-22.726915,NULL,0,0,0,100,0),
(@PATH,2,-1604.801,7950.809,-26.352486,NULL,0,0,0,100,0),
(@PATH,3,-1618.2837,7972.56,-24.741226,NULL,0,0,0,100,0),
(@PATH,4,-1620.6606,7986.165,-24.407974,NULL,0,0,0,100,0),
(@PATH,5,-1627.0247,7987.222,-24.741226,NULL,7500,0,0,100,0),
(@PATH,6,-1616.4249,7964.83,-26.525581,NULL,0,0,0,100,0),
(@PATH,7,-1593.1031,7986.29,-23.556028,NULL,0,0,0,100,0),
(@PATH,8,-1560.4299,7990.434,-21.372875,NULL,7500,0,0,100,0),
(@PATH,9,-1563.902,7951.0166,-22.608301,NULL,0,0,0,100,0),
(@PATH,10,-1544.69,7929.014,-21.267084,NULL,7500,0,0,100,0),
(@PATH,11,-1525.14,7920.1685,-20.322586,NULL,0,0,0,100,0),
(@PATH,12,-1548.2592,7915.58,-21.267084,NULL,0,0,0,100,0),
(@PATH,13,-1561.5724,7908.538,-21.979242,NULL,0,0,0,100,0),
(@PATH,14,-1567.437,7901.1885,-21.979645,NULL,7500,0,0,100,0),
(@PATH,15,-1570.1881,7924.743,-22.589752,NULL,0,0,0,100,0);

SET @NPCPAT2 := @NPC+18;
SET @PATH := @NPCPAT2 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT2;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT2,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1601.5521,7950.475,-25.48774,NULL,0,0,0,100,0),
(@PATH,2,-1605.7198,7958.928,-25.589912,NULL,0,0,0,100,0),
(@PATH,3,-1603.0267,7970.598,-24.292007,NULL,0,0,0,100,0),
(@PATH,4,-1597.1958,7988.6084,-23.727415,NULL,0,0,0,100,0),
(@PATH,5,-1563.0417,7984.9004,-21.805859,NULL,0,0,0,100,0),
(@PATH,6,-1552.0924,7971.6025,-21.340649,NULL,0,0,0,100,0),
(@PATH,7,-1552.6584,7939.8413,-21.864893,NULL,0,0,0,100,0),
(@PATH,8,-1559.9021,7927.2256,-21.687494,NULL,0,0,0,100,0),
(@PATH,9,-1580.1727,7940.029,-23.01732,NULL,0,0,0,100,0);

SET @NPCPAT3 := @NPC+19;
SET @PATH := @NPCPAT3 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT3;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT3,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1611.6683,7957.6304,-27.328438,NULL,0,0,0,100,0),
(@PATH,2,-1618.0887,7983.4497,-24.41481,NULL,0,0,0,100,0),
(@PATH,3,-1643.7819,7986.462,-25.064526,NULL,0,0,0,100,0),
(@PATH,4,-1643.5465,7995.867,-25.810375,NULL,0,0,0,100,0),
(@PATH,5,-1611.7173,7997.099,-24.491226,NULL,0,0,0,100,0),
(@PATH,6,-1583.7445,7990.3584,-23.042845,NULL,0,0,0,100,0),
(@PATH,7,-1560.121,7988.5166,-21.37434,NULL,0,0,0,100,0),
(@PATH,8,-1556.1189,7971.6978,-21.897045,NULL,0,0,0,100,0),
(@PATH,9,-1549.7915,7950.7188,-21.270655,NULL,0,0,0,100,0),
(@PATH,10,-1552.4308,7934.078,-21.739405,NULL,0,0,0,100,0),
(@PATH,11,-1519.6771,7925.7915,-20.246414,NULL,0,0,0,100,0),
(@PATH,12,-1500.88,7916.9707,-19.072586,NULL,0,0,0,100,0),
(@PATH,13,-1509.5591,7915.889,-19.447586,NULL,0,0,0,100,0),
(@PATH,14,-1538.3795,7922.952,-21.060053,NULL,0,0,0,100,0),
(@PATH,15,-1562.6403,7908.5366,-21.892084,NULL,0,0,0,100,0),
(@PATH,16,-1582.8197,7893.7847,-22.548172,NULL,0,0,0,100,0),
(@PATH,17,-1598.5696,7887.1675,-24.116043,NULL,0,0,0,100,0),
(@PATH,18,-1582.957,7910.1274,-24.712067,NULL,0,0,0,100,0),
(@PATH,19,-1582.636,7940.633,-23.45592,NULL,0,0,0,100,0),
(@PATH,20,-1604.9592,7940.441,-26.098213,NULL,0,0,0,100,0),
(@PATH,21,-1631.5454,7947.5947,-35.980537,NULL,0,0,0,100,0);

SET @NPCPAT4 := @NPC+20;
SET @PATH := @NPCPAT4 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT4;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT4,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1593.7784,7988.3916,-23.511473,NULL,0,0,0,100,0),
(@PATH,2,-1559.4581,7970.869,-22.18391,NULL,0,0,0,100,0),
(@PATH,3,-1554.2388,7945.5103,-22.054346,NULL,0,0,0,100,0),
(@PATH,4,-1564.365,7929.291,-21.630976,NULL,0,0,0,100,0),
(@PATH,5,-1586.477,7942.994,-24.06981,NULL,0,0,0,100,0),
(@PATH,6,-1614.7969,7949.1113,-29.484688,NULL,0,0,0,100,0),
(@PATH,7,-1619.6309,7963.3203,-27.734688,NULL,0,0,0,100,0),
(@PATH,8,-1607.4355,7971.2866,-24.57106,NULL,0,0,0,100,0);

-- ALLIANCE
SET @NPCPAT5 := @NPC+37;
SET @PATH := @NPCPAT5 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT5;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT5,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1578.2544,7942.152,-22.726915,NULL,0,0,0,100,0),
(@PATH,2,-1604.801,7950.809,-26.352486,NULL,0,0,0,100,0),
(@PATH,3,-1618.2837,7972.56,-24.741226,NULL,0,0,0,100,0),
(@PATH,4,-1620.6606,7986.165,-24.407974,NULL,0,0,0,100,0),
(@PATH,5,-1627.0247,7987.222,-24.741226,NULL,7500,0,0,100,0),
(@PATH,6,-1616.4249,7964.83,-26.525581,NULL,0,0,0,100,0),
(@PATH,7,-1593.1031,7986.29,-23.556028,NULL,0,0,0,100,0),
(@PATH,8,-1560.4299,7990.434,-21.372875,NULL,7500,0,0,100,0),
(@PATH,9,-1563.902,7951.0166,-22.608301,NULL,0,0,0,100,0),
(@PATH,10,-1544.69,7929.014,-21.267084,NULL,7500,0,0,100,0),
(@PATH,11,-1525.14,7920.1685,-20.322586,NULL,0,0,0,100,0),
(@PATH,12,-1548.2592,7915.58,-21.267084,NULL,0,0,0,100,0),
(@PATH,13,-1561.5724,7908.538,-21.979242,NULL,0,0,0,100,0),
(@PATH,14,-1567.437,7901.1885,-21.979645,NULL,7500,0,0,100,0),
(@PATH,15,-1570.1881,7924.743,-22.589752,NULL,0,0,0,100,0);

SET @NPCPAT6 := @NPC+38;
SET @PATH := @NPCPAT6 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT6;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT6,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1601.5521,7950.475,-25.48774,NULL,0,0,0,100,0),
(@PATH,2,-1605.7198,7958.928,-25.589912,NULL,0,0,0,100,0),
(@PATH,3,-1603.0267,7970.598,-24.292007,NULL,0,0,0,100,0),
(@PATH,4,-1597.1958,7988.6084,-23.727415,NULL,0,0,0,100,0),
(@PATH,5,-1563.0417,7984.9004,-21.805859,NULL,0,0,0,100,0),
(@PATH,6,-1552.0924,7971.6025,-21.340649,NULL,0,0,0,100,0),
(@PATH,7,-1552.6584,7939.8413,-21.864893,NULL,0,0,0,100,0),
(@PATH,8,-1559.9021,7927.2256,-21.687494,NULL,0,0,0,100,0),
(@PATH,9,-1580.1727,7940.029,-23.01732,NULL,0,0,0,100,0);

SET @NPCPAT7 := @NPC+39;
SET @PATH := @NPCPAT7 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT7;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT7,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1611.6683,7957.6304,-27.328438,NULL,0,0,0,100,0),
(@PATH,2,-1618.0887,7983.4497,-24.41481,NULL,0,0,0,100,0),
(@PATH,3,-1643.7819,7986.462,-25.064526,NULL,0,0,0,100,0),
(@PATH,4,-1643.5465,7995.867,-25.810375,NULL,0,0,0,100,0),
(@PATH,5,-1611.7173,7997.099,-24.491226,NULL,0,0,0,100,0),
(@PATH,6,-1583.7445,7990.3584,-23.042845,NULL,0,0,0,100,0),
(@PATH,7,-1560.121,7988.5166,-21.37434,NULL,0,0,0,100,0),
(@PATH,8,-1556.1189,7971.6978,-21.897045,NULL,0,0,0,100,0),
(@PATH,9,-1549.7915,7950.7188,-21.270655,NULL,0,0,0,100,0),
(@PATH,10,-1552.4308,7934.078,-21.739405,NULL,0,0,0,100,0),
(@PATH,11,-1519.6771,7925.7915,-20.246414,NULL,0,0,0,100,0),
(@PATH,12,-1500.88,7916.9707,-19.072586,NULL,0,0,0,100,0),
(@PATH,13,-1509.5591,7915.889,-19.447586,NULL,0,0,0,100,0),
(@PATH,14,-1538.3795,7922.952,-21.060053,NULL,0,0,0,100,0),
(@PATH,15,-1562.6403,7908.5366,-21.892084,NULL,0,0,0,100,0),
(@PATH,16,-1582.8197,7893.7847,-22.548172,NULL,0,0,0,100,0),
(@PATH,17,-1598.5696,7887.1675,-24.116043,NULL,0,0,0,100,0),
(@PATH,18,-1582.957,7910.1274,-24.712067,NULL,0,0,0,100,0),
(@PATH,19,-1582.636,7940.633,-23.45592,NULL,0,0,0,100,0),
(@PATH,20,-1604.9592,7940.441,-26.098213,NULL,0,0,0,100,0),
(@PATH,21,-1631.5454,7947.5947,-35.980537,NULL,0,0,0,100,0);

SET @NPCPAT8 := @NPC+40;
SET @PATH := @NPCPAT8 * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPCPAT8;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPCPAT8,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1593.7784,7988.3916,-23.511473,NULL,0,0,0,100,0),
(@PATH,2,-1559.4581,7970.869,-22.18391,NULL,0,0,0,100,0),
(@PATH,3,-1554.2388,7945.5103,-22.054346,NULL,0,0,0,100,0),
(@PATH,4,-1564.365,7929.291,-21.630976,NULL,0,0,0,100,0),
(@PATH,5,-1586.477,7942.994,-24.06981,NULL,0,0,0,100,0),
(@PATH,6,-1614.7969,7949.1113,-29.484688,NULL,0,0,0,100,0),
(@PATH,7,-1619.6309,7963.3203,-27.734688,NULL,0,0,0,100,0),
(@PATH,8,-1607.4355,7971.2866,-24.57106,NULL,0,0,0,100,0);