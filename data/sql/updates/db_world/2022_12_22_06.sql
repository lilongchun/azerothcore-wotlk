-- DB update 2022_12_22_05 -> 2022_12_22_06
--
SET @GUID := 9704;

DELETE FROM `gameobject` WHERE `id`=184684;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0 , 184684, 530, 3520, 0, 1, 1, -2502.91, 1168.12, 55.5328, -2.05949, 0, 0, 0.857167, -0.515038, 120, 255, 1, '', 0),
(@GUID+1 , 184684, 530, 3520, 0, 1, 1, -2562.92, 1063.91, 45.3053, -0.383972, 0, 0, 0.190809, -0.981627, 120, 255, 1, '', 0),
(@GUID+2 , 184684, 530, 3520, 0, 1, 1, -2539.85, 1174.34, 79.2236, -1.88496, 0, 0, 0.809017, -0.587785, 120, 255, 1, '', 0),
(@GUID+3 , 184684, 530, 3520, 0, 1, 1, -2564.83, 1101.64, 65.0654, -2.79253, 0, 0, 0.984808, -0.173648, 120, 255, 1, '', 0),
(@GUID+4 , 184684, 530, 3520, 0, 1, 1, -2576.15, 1177.07, 74.8158, 1.81514, 0, 0, 0.788011, 0.615662, 120, 255, 1, '', 0),
(@GUID+5 , 184684, 530, 3520, 0, 1, 1, -2606.99, 1077.82, 54.3653, 2.26893, 0, 0, 0.906308, 0.422618, 120, 255, 1, '', 0),
(@GUID+6 , 184684, 530, 3520, 0, 1, 1, -2497.18, 1069.18, 51.8808, -1.22173, 0, 0, 0.573576, -0.819152, 120, 255, 1, '', 0),
(@GUID+7 , 184684, 530, 3520, 0, 1, 1, -2482.5, 1118.31, 49.096, 0.20944, 0, 0, 0.104528, 0.994522, 120, 255, 1, '', 0),
(@GUID+8 , 184684, 530, 3520, 0, 1, 1, -2532.08, 1102.09, 66.699, 1.20428, 0, 0, 0.566406, 0.824126, 120, 255, 1, '', 0),
(@GUID+9 , 184684, 530, 3520, 0, 1, 1, -2708.96, 1128.65, 58.9191, 2.62378, 0, 0, 0.96667, 0.256025, 120, 255, 1, '', 46924),
(@GUID+10, 184684, 530, 3520, 0, 1, 1, -2694.1, 1092.73, 50.6055, 0.890563, 0, 0, 0.430712, 0.90249, 120, 255, 1, '', 46924),
(@GUID+11, 184684, 530, 3520, 0, 1, 1, -2723.83, 1077.73, 46.9453, 1.98967, 0, 0, 0.83867, 0.54464, 120, 255, 1, '', 46924),
(@GUID+12, 184684, 530, 3520, 0, 1, 1, -2664.99, 1081.4, 48.9334, 5.79771, 0, 0, -0.240362, 0.970683, 120, 255, 1, '', 46924),
(@GUID+13, 184684, 530, 3520, 0, 1, 1, -2638.52, 1122.91, 65.8191, 4.20625, 0, 0, -0.861629, 0.507539, 120, 255, 1, '', 46924),
(@GUID+14, 184684, 530, 3520, 0, 1, 1, -2596.45, 1037.23, 38.2863, 4.7473, 0, 0, -0.694658, 0.71934, 120, 255, 1, '', 46924),
(@GUID+15, 184684, 530, 3520, 0, 1, 1, -2580.55, 1121.57, 69.7769, 4.40485, 0, 0, -0.807068, 0.590459, 120, 255, 1, '', 46924),
(@GUID+16, 184684, 530, 3520, 0, 1, 1, -2534.9, 1131.53, 75.7671, 4.83456, 0, 0, -0.66262, 0.748956, 120, 255, 1, '', 46924),
(@GUID+17, 184684, 530, 3520, 0, 1, 1, -2531.89, 1035.4, 45.5817, 1.09956, 0, 0, 0.522498, 0.85264, 120, 255, 1, '', 46924),
(@GUID+18, 184684, 530, 3520, 0, 1, 1, -2516.96, 1029.69, 39.0831, 1.01748, 0, 0, 0.487076, 0.87336, 120, 255, 1, '', 46924),
(@GUID+19, 184684, 530, 3520, 0, 1, 1, -2494.83, 1036.67, 45.8349, 5.61996, 0, 0, -0.325567, 0.945519, 120, 255, 1, '', 46924),
(@GUID+20, 184684, 530, 3520, 0, 1, 1, -2490.16, 1008.91, 26.3388, 4.2237, 0, 0, -0.857167, 0.515038, 120, 255, 1, '', 46924),
(@GUID+21, 184684, 530, 3520, 0, 1, 1, -2548.29, 1026.32, 38.904, 6.14115, 0, 0, -0.0709572, 0.997479, 120, 255, 1, '', 46924),
(@GUID+22, 184684, 530, 3520, 0, 1, 1, -2602.67, 1101.67, 62.4206, 0.087266, 0, 0, 0.0436192, 0.999048, 120, 255, 1, '', 46924),
(@GUID+23, 184684, 530, 3520, 0, 1, 1, -2665.52, 1103.14, 57.2047, 1.43117, 0, 0, 0.656058, 0.75471, 120, 255, 1, '', 46924),
(@GUID+24, 184684, 530, 3520, 0, 1, 1, -2702.5, 1130.36, 59.5393, 4.62512, 0, 0, -0.737277, 0.675591, 120, 255, 1, '', 46924),
(@GUID+25, 184684, 530, 3520, 0, 1, 1, -2697.93, 1102.31, 54.1485, 5.46288, 0, 0, -0.398748, 0.91706, 120, 255, 1, '', 46924),
(@GUID+26, 184684, 530, 3520, 0, 1, 1, -2744.74, 1118.77, 47.8999, 3.194, 0, 0, -0.999657, 0.0262016, 120, 255, 1, '', 46924),
(@GUID+27, 184684, 530, 3520, 0, 1, 1, -2636.59, 1068.31, 52.026, 3.4034, 0, 0, -0.991445, 0.130528, 120, 255, 1, '', 46924),
(@GUID+28, 184684, 530, 3520, 0, 1, 1, -2598.06, 1130.64, 68.7114, 3.4383, 0, 0, -0.989016, 0.147811, 120, 255, 1, '', 46924),
(@GUID+29, 184684, 530, 3520, 0, 1, 1, -2511.26, 1072.8, 59.3213, 2.09866, 0, 0, 0.867089, 0.498153, 120, 255, 1, '', 46924),
(@GUID+30, 184684, 530, 3520, 0, 1, 1, -2628.11, 1119.41, 64.9071, 3.00824, 0, 0, 0.997778, 0.0666271, 120, 255, 1, '', 46924),
(@GUID+31, 184684, 530, 3520, 0, 1, 1, -2638.2, 1063.25, 51.6139, 5.5967, 0, 0, -0.336542, 0.941668, 120, 255, 1, '', 46924);

DELETE FROM `pool_template` WHERE `entry`=1077 AND `description`='Ravenous Flayer Egg (184684)';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1077, 20, 'Ravenous Flayer Egg (184684)');

DELETE FROM `pool_gameobject` WHERE `pool_entry`=1077 AND `description`='Ravenous Flayer Egg (184684)';
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+0 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+1 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+2 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+3 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+4 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+5 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+6 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+7 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+8 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+9 , 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+10, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+11, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+12, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+13, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+14, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+15, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+16, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+17, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+18, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+19, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+20, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+21, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+22, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+23, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+24, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+25, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+26, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+27, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+28, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+29, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+30, 1077, 0, 'Ravenous Flayer Egg (184684)'),
(@GUID+31, 1077, 0, 'Ravenous Flayer Egg (184684)');
