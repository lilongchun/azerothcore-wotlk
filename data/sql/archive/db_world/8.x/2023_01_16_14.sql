-- DB update 2023_01_16_13 -> 2023_01_16_14
--
SET @OGUID := 55735;

DELETE FROM `gameobject` WHERE `map`=560 AND `id` IN (187235, 187567) AND `guid` BETWEEN @OGUID+0 AND @OGUID+39;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@OGUID+0 , 187235, 560, 2367, 2367, 3, 1, 2327.7, 923.297, 55.0792, 1.50098, 0, 0, 0.681998, 0.731354, 7200, 255, 1, '', 47187),
(@OGUID+1 , 187235, 560, 2367, 2367, 3, 1, 2350.5, 913.715, 55.2528, 0.820303, 0, 0, 0.398748, 0.91706, 7200, 255, 1, '', 47187),
(@OGUID+2 , 187235, 560, 2367, 2367, 3, 1, 1957.94, 1090.89, 26.6288, 4.17134, 0, 0, -0.870356, 0.492424, 7200, 255, 1, '', 47187),
(@OGUID+3 , 187235, 560, 2367, 2367, 3, 1, 2634.74, 705.168, 56.1564, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+4 , 187235, 560, 2367, 2367, 3, 1, 2628.34, 698.823, 56.2869, 6.05629, 0, 0, -0.113203, 0.993572, 7200, 255, 1, '', 47187),
(@OGUID+5 , 187235, 560, 2367, 2367, 3, 1, 2644.95, 704.002, 56.1751, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+6 , 187235, 560, 2367, 2367, 3, 1, 2649.52, 700.67, 56.3216, 3.7001, 0, 0, -0.961261, 0.27564, 7200, 255, 1, '', 47187),
(@OGUID+7 , 187567, 560, 2367, 2367, 3, 1, 2628.55, 655.727, 61.1613, 1.25664, 0, 0, 0.587785, 0.809017, 7200, 255, 1, '', 47187),
(@OGUID+8 , 187235, 560, 2367, 2367, 3, 1, 2614.34, 627.073, 56.7241, 0.820303, 0, 0, 0.398748, 0.91706, 7200, 255, 1, '', 47187),
(@OGUID+9 , 187235, 560, 2367, 2367, 3, 1, 2632.78, 654.738, 54.2741, 1.09956, 0, 0, 0.522498, 0.85264, 7200, 255, 1, '', 47187),
(@OGUID+10, 187235, 560, 2367, 2367, 3, 1, 2624.57, 657.569, 54.2737, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+11, 187235, 560, 2367, 2367, 3, 1, 2647.02, 670.236, 55.7051, 2.93214, 0, 0, 0.994521, 0.104536, 7200, 255, 1, '', 47187),
(@OGUID+12, 187235, 560, 2367, 2367, 3, 1, 2622.35, 624.398, 56.7241, 1.81514, 0, 0, 0.788011, 0.615662, 7200, 255, 1, '', 47187),
(@OGUID+13, 187235, 560, 2367, 2367, 3, 1, 2654.3, 656.427, 61.9301, 1.83259, 0, 0, 0.793353, 0.608762, 7200, 255, 1, '', 47187),
(@OGUID+14, 187235, 560, 2367, 2367, 3, 1, 2188.3, 147.514, 90.1394, 3.87463, 0, 0, -0.93358, 0.358368, 7200, 255, 1, '', 47187),
(@OGUID+15, 187235, 560, 2367, 2367, 3, 1, 2182.14, 136.87, 90.1394, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+16, 187235, 560, 2367, 2367, 3, 1, 2228.18, 128.799, 104.672, 4.20625, 0, 0, -0.861629, 0.507539, 7200, 255, 1, '', 47187),
(@OGUID+17, 187235, 560, 2367, 2367, 3, 1, 2218.77, 112.094, 104.672, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+18, 187235, 560, 2367, 2367, 3, 1, 2251.85, 137.491, 89.4548, 3.22886, 0, 0, -0.999048, 0.0436193, 7200, 255, 1, '', 47187),
(@OGUID+19, 187235, 560, 2367, 2367, 3, 1, 2246.24, 127.997, 89.4548, 1.90241, 0, 0, 0.814116, 0.580703, 7200, 255, 1, '', 47187),
(@OGUID+20, 187235, 560, 2367, 2367, 3, 1, 1899.79, 1048.55, 18.0428, 0.157079, 0, 0, 0.0784588, 0.996917, 7200, 255, 1, '', 47187),
(@OGUID+21, 187235, 560, 2367, 2367, 3, 1, 1901.2, 1058.45, 18.1829, 5.75959, 0, 0, -0.258819, 0.965926, 7200, 255, 1, '', 47187),
(@OGUID+22, 187235, 560, 2367, 2367, 3, 1, 1884.31, 1083.16, 17.6409, 3.17653, 0, 0, -0.999847, 0.0174693, 7200, 255, 1, '', 47187),
(@OGUID+23, 187235, 560, 2367, 2367, 3, 1, 1871.39, 1070.32, 17.1592, 4.43314, 0, 0, -0.798635, 0.601815, 7200, 255, 1, '', 47187),
(@OGUID+24, 187235, 560, 2367, 2367, 3, 1, 1863.76, 1061.21, 15.7083, 0.750491, 0, 0, 0.366501, 0.930418, 7200, 255, 1, '', 47187),
(@OGUID+25, 187235, 560, 2367, 2367, 3, 1, 1840.65, 1097.35, 15.2979, 5.02655, 0, 0, -0.587785, 0.809017, 7200, 255, 1, '', 47187),
(@OGUID+26, 187235, 560, 2367, 2367, 3, 1, 1823.27, 1050.91, 11.0783, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+27, 187235, 560, 2367, 2367, 3, 1, 1821.2, 1040.31, 11.6916, 3.76991, 0, 0, -0.951056, 0.309017, 7200, 255, 1, '', 47187),
(@OGUID+28, 187567, 560, 2367, 2367, 3, 1, 1817.56, 1052.36, 16.8424, 1.58825, 0, 0, 0.71325, 0.70091, 7200, 255, 1, '', 47187),
(@OGUID+29, 187235, 560, 2367, 2367, 3, 1, 1810.83, 1124.28, 13.3553, 3.63029, 0, 0, -0.970295, 0.241925, 7200, 255, 1, '', 47187),
(@OGUID+30, 187235, 560, 2367, 2367, 3, 1, 1800.69, 1084.27, 11.0713, 4.38078, 0, 0, -0.814116, 0.580703, 7200, 255, 1, '', 47187),
(@OGUID+31, 187235, 560, 2367, 2367, 3, 1, 1809.76, 1083.95, 11.3059, 4.92183, 0, 0, -0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+32, 187235, 560, 2367, 2367, 3, 1, 1808.54, 1024.53, 11.6881, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+33, 187567, 560, 2367, 2367, 3, 1, 1805.48, 1097.36, 19.5861, 4.69494, 0, 0, -0.71325, 0.70091, 7200, 255, 1, '', 47187),
(@OGUID+34, 187235, 560, 2367, 2367, 3, 1, 1810.94, 1130.16, 13.3551, 2.68781, 0, 0, 0.97437, 0.224951, 7200, 255, 1, '', 47187),
(@OGUID+35, 187235, 560, 2367, 2367, 3, 1, 1776.37, 1054.55, 6.90413, 1.36136, 0, 0, 0.62932, 0.777146, 7200, 255, 1, '', 47187),
(@OGUID+36, 187235, 560, 2367, 2367, 3, 1, 1776.81, 1067.18, 7.54524, 5.07891, 0, 0, -0.566406, 0.824126, 7200, 255, 1, '', 47187),
(@OGUID+37, 187235, 560, 2367, 2367, 3, 1, 1755.99, 1020.43, 6.87962, 0.820303, 0, 0, 0.398748, 0.91706, 7200, 255, 1, '', 47187),
(@OGUID+38, 187235, 560, 2367, 2367, 3, 1, 1745.99, 1058.14, 6.87962, 0.628317, 0, 0, 0.309016, 0.951057, 7200, 255, 1, '', 47187),
(@OGUID+39, 187235, 560, 2367, 2367, 3, 1, 1736.87, 1084.24, 6.87962, 5.65487, 0, 0, -0.309016, 0.951057, 7200, 255, 1, '', 47187);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=2 AND `guid` BETWEEN @OGUID+0 AND @OGUID+39;
INSERT INTO `game_event_gameobject` (`guid`, `eventEntry`) VALUES
(@OGUID+0 , 2),
(@OGUID+1 , 2),
(@OGUID+2 , 2),
(@OGUID+3 , 2),
(@OGUID+4 , 2),
(@OGUID+5 , 2),
(@OGUID+6 , 2),
(@OGUID+7 , 2),
(@OGUID+8 , 2),
(@OGUID+9 , 2),
(@OGUID+10, 2),
(@OGUID+11, 2),
(@OGUID+12, 2),
(@OGUID+13, 2),
(@OGUID+14, 2),
(@OGUID+15, 2),
(@OGUID+16, 2),
(@OGUID+17, 2),
(@OGUID+18, 2),
(@OGUID+19, 2),
(@OGUID+20, 2),
(@OGUID+21, 2),
(@OGUID+22, 2),
(@OGUID+23, 2),
(@OGUID+24, 2),
(@OGUID+25, 2),
(@OGUID+26, 2),
(@OGUID+27, 2),
(@OGUID+28, 2),
(@OGUID+29, 2),
(@OGUID+30, 2),
(@OGUID+31, 2),
(@OGUID+32, 2),
(@OGUID+33, 2),
(@OGUID+34, 2),
(@OGUID+35, 2),
(@OGUID+36, 2),
(@OGUID+37, 2),
(@OGUID+38, 2),
(@OGUID+39, 2);
