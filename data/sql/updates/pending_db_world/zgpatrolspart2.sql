DELETE FROM `creature` WHERE `guid` IN (49149, 91457);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(91457, 11353, 0, 0, 309, 0, 0, 1, 1, 1, -11625.6, -1488.06, 45.3629, 4.20245, 7200, 0, 0, 21364, 0, 2, 0, 0, 0, '', 0),
(49149, 15111, 0, 0, 309, 0, 0, 1, 1, 1, -11856.7, -1871.74, 64.2785, 4.6087, 7200, 5, 0, 12575, 9944, 1, 0, 0, 0, '', 0);
DELETE FROM `creature` WHERE (`id1` = 14750 AND `guid` IN (52265, 52266)) OR (`id1` = 11368 AND `guid` IN (52267, 52268, 52269, 52270, 52271));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(52265, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12139.7, -1461.39, 132.725, 3.49715, 7200, 4, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(52266, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 3.49715, 7200, 4, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(52267, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 5.11337, 7200, 0, 0, 5341, 0, 2, 0, 0, 0, '', 0),
(52268, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 5.01408, 7200, 4, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(52269, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 3.19756, 7200, 4, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(52270, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 5.19928, 7200, 4, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(52271, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12199.8, -1432.72, 133.302, 5.09036, 7200, 4, 0, 5341, 0, 1, 0, 0, 0, '', 0);

SET @NPC := 52267;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12279.661,`position_y`=-1437.7651,`position_z`=130.7252 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1, `wander_distance`= 4, `position_x`=-12279.661,`position_y`=-1437.7651,`position_z`=130.7252 WHERE `guid` IN (52265, 52266, 52268, 52269, 52270, 52271);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12279.661,-1437.7651,130.7252,0,0,0,0,100,0),
(@PATH,2,-12273.889,-1442.9456,130.7252,0,0,0,0,100,0),
(@PATH,3,-12272.747,-1455.5314,130.7252,0,0,0,0,100,0),
(@PATH,4,-12277.202,-1464.8107,130.7252,0,0,0,0,100,0),
(@PATH,5,-12284.19,-1473.1727,130.7252,0,0,0,0,100,0),
(@PATH,6,-12294.534,-1480.2686,130.8817,0,0,0,0,100,0),
(@PATH,7,-12304.744,-1479.3315,132.01277,0,0,0,0,100,0),
(@PATH,8,-12316.196,-1462.9426,130.70255,0,0,0,0,100,0),
(@PATH,9,-12305.534,-1452.7662,130.70255,0,0,0,0,100,0),
(@PATH,10,-12293.26,-1443.0798,130.7252,0,0,0,0,100,0),
(@PATH,11,-12282.498,-1445.1747,130.7252,0,0,0,0,100,0),
(@PATH,12,-12280.598,-1456.5935,130.7252,0,0,0,0,100,0),
(@PATH,13,-12285.771,-1470.3275,130.7252,0,0,0,0,100,0),
(@PATH,14,-12298.271,-1481.0421,131.14806,0,0,0,0,100,0),
(@PATH,15,-12309.94,-1483.0845,132.7618,0,0,0,0,100,0),
(@PATH,16,-12314.164,-1468.745,130.71321,0,0,0,0,100,0),
(@PATH,17,-12311.926,-1459.6638,130.70255,0,0,0,0,100,0),
(@PATH,18,-12307.524,-1451.2375,130.70255,0,0,0,0,100,0),
(@PATH,19,-12298.418,-1444.7874,130.7252,0,0,0,0,100,0),
(@PATH,20,-12290.997,-1444.8539,130.7252,0,0,0,0,100,0),
(@PATH,21,-12286.294,-1450.8981,130.7252,0,0,0,0,100,0),
(@PATH,22,-12286.32,-1459.2678,130.7252,0,0,0,0,100,0),
(@PATH,23,-12291.313,-1470.921,130.7252,0,0,0,0,100,0),
(@PATH,24,-12301.496,-1479.0215,131.83821,0,0,0,0,100,0),
(@PATH,25,-12310.952,-1473.5144,131.47957,0,0,0,0,100,0),
(@PATH,26,-12310.798,-1461.9359,130.70255,0,0,0,0,100,0),
(@PATH,27,-12295.607,-1443.4049,130.7252,0,0,0,0,100,0);

SET @NPC := 49123;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12199.814,`position_y`=-1432.7246,`position_z`=133.30249 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1, `wander_distance`= 4, `position_x`=-12199.814,`position_y`=-1432.7246,`position_z`=133.30249 WHERE `guid` IN (49128, 49127, 49124, 49125, 49130, 49129);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12199.814,-1432.7246,133.30249,0,0,0,0,100,0),
(@PATH,2,-12201.092,-1418.7756,134.06944,0,0,0,0,100,0),
(@PATH,3,-12216.145,-1407.9874,132.45421,0,0,0,0,100,0),
(@PATH,4,-12231.352,-1405.2097,132.38829,0,0,0,0,100,0),
(@PATH,5,-12243.286,-1411.2496,132.7252,0,0,0,0,100,0),
(@PATH,6,-12238.431,-1422.679,132.7252,0,0,0,0,100,0),
(@PATH,7,-12229.905,-1442.7914,132.69781,0,0,0,0,100,0),
(@PATH,8,-12225.549,-1451.114,132.69781,0,0,0,0,100,0),
(@PATH,9,-12214.378,-1447.3993,132.69781,0,0,0,0,100,0),
(@PATH,10,-12206.028,-1432.4019,132.88976,0,0,0,0,100,0),
(@PATH,11,-12216.252,-1414.8685,132.7252,0,0,0,0,100,0),
(@PATH,12,-12228.853,-1409.4326,132.9503,0,0,0,0,100,0),
(@PATH,13,-12238.942,-1405.217,132.7252,0,0,0,0,100,0),
(@PATH,14,-12251.546,-1405.7375,132.09508,0,0,0,0,100,0),
(@PATH,15,-12255.312,-1419.062,132.7252,0,0,0,0,100,0),
(@PATH,16,-12255.312,-1419.062,132.7252,0,0,0,0,100,0),
(@PATH,17,-12248.536,-1428.0126,132.7252,0,0,0,0,100,0),
(@PATH,18,-12235.721,-1434.8424,132.7252,0,0,0,0,100,0),
(@PATH,19,-12224.75,-1444.1573,132.69781,0,0,0,0,100,0),
(@PATH,20,-12218.656,-1453.3082,132.69781,0,0,0,0,100,0),
(@PATH,21,-12211.176,-1456.2633,132.69781,0,0,0,0,100,0),
(@PATH,22,-12201.237,-1448.5684,132.69781,0,0,0,0,100,0),
(@PATH,23,-12202.742,-1439.2172,132.93121,0,0,0,0,100,0),
(@PATH,24,-12205.002,-1422.5133,132.81236,0,0,0,0,100,0),
(@PATH,25,-12218.03,-1411.0071,132.19273,0,0,0,0,100,0),
(@PATH,26,-12232.668,-1409.5203,132.2147,0,0,0,0,100,0),
(@PATH,27,-12242.129,-1411.943,132.7252,0,0,0,0,100,0),
(@PATH,28,-12244.375,-1420.1545,132.7252,0,0,0,0,100,0),
(@PATH,29,-12239.236,-1429.6349,132.7252,0,0,0,0,100,0),
(@PATH,30,-12226.557,-1440.8917,132.69781,0,0,0,0,100,0),
(@PATH,31,-12210.098,-1440.5779,132.69781,0,0,0,0,100,0);

SET @NPC := 49651;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11550.093,`position_y`=-1223.9448,`position_z`=80.220146 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11550.093,`position_y`=-1223.9448,`position_z`=80.220146 WHERE `guid` IN (49652, 49653, 49654);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');

DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11550.093,-1223.9448,80.220146,0,0,0,0,100,0),
(@PATH,2,-11557.223,-1222.4227,79.65862,0,0,0,0,100,0),
(@PATH,3,-11553.573,-1223.2018,79.88592,0,0,0,0,100,0),
(@PATH,4,-11571.926,-1223.9309,78.613945,0,0,0,0,100,0),
(@PATH,5,-11587.294,-1224.643,78.26922,0,0,0,0,100,0),
(@PATH,6,-11573.703,-1224.0151,78.593925,0,0,0,0,100,0),
(@PATH,7,-11587.294,-1224.643,78.26922,0,0,0,0,100,0),
(@PATH,8,-11596.543,-1229.5101,78.13177,0,0,0,0,100,0),
(@PATH,9,-11593.092,-1227.6938,78.18306,0,0,0,0,100,0),
(@PATH,10,-11602.165,-1234.0627,78.7508,0,0,0,0,100,0),
(@PATH,11,-11617.252,-1245.9791,81.09846,0,0,0,0,100,0),
(@PATH,12,-11615.512,-1244.5958,81.12922,0,0,0,0,100,0),
(@PATH,13,-11618.764,-1255.8805,80.15998,0,0,0,0,100,0),
(@PATH,14,-11610.591,-1265.3711,79.51179,0,0,0,0,100,0),
(@PATH,15,-11615.949,-1259.15,80.24421,0,0,0,0,100,0),
(@PATH,16,-11610.591,-1265.3711,79.51179,0,0,0,0,100,0),
(@PATH,17,-11605.663,-1273.7218,78.79365,0,0,0,0,100,0),
(@PATH,18,-11605.728,-1286.811,79.642525,0,0,0,0,100,0),
(@PATH,19,-11605.718,-1284.0552,79.57482,0,0,0,0,100,0),
(@PATH,20,-11610.82,-1291.4453,79.481636,0,0,0,0,100,0),
(@PATH,21,-11624.228,-1295.4607,79.237495,0,0,0,0,100,0),
(@PATH,22,-11626.538,-1301.7444,79.03057,0,0,0,0,100,0),
(@PATH,23,-11624.65,-1296.6116,79.1996,0,0,0,0,100,0),
(@PATH,24,-11619.523,-1305.1301,78.82818,0,0,0,0,100,0),
(@PATH,25,-11606.912,-1305.0999,78.94073,0,0,0,0,100,0),
(@PATH,26,-11613.363,-1305.1178,79.253716,0,0,0,0,100,0),
(@PATH,27,-11606.912,-1305.0999,78.94073,0,0,0,0,100,0),
(@PATH,28,-11596.496,-1293.9733,78.49969,0,0,0,0,100,0),
(@PATH,29,-11595.904,-1278.656,78.05364,0,0,0,0,100,0),
(@PATH,30,-11596.081,-1283.3551,78.64007,0,0,0,0,100,0),
(@PATH,31,-11603.361,-1272.9172,78.54609,0,0,0,0,100,0),
(@PATH,32,-11609.264,-1264.9315,79.297676,0,0,0,0,100,0),
(@PATH,33,-11616.075,-1255.8618,80.27912,0,0,0,0,100,0),
(@PATH,34,-11614.406,-1247.4045,80.718575,0,0,0,0,100,0),
(@PATH,35,-11615.159,-1257.0778,80.14802,0,0,0,0,100,0),
(@PATH,36,-11614.406,-1247.4045,80.718575,0,0,0,0,100,0),
(@PATH,37,-11601.293,-1235.7604,78.521065,0,0,0,0,100,0),
(@PATH,38,-11614.517,-1248.9042,80.55207,0,0,0,0,100,0),
(@PATH,39,-11601.293,-1235.7604,78.521065,0,0,0,0,100,0),
(@PATH,40,-11595.637,-1230.9723,77.77166,0,0,0,0,100,0),
(@PATH,41,-11597.134,-1232.2388,78.25164,0,0,0,0,100,0),
(@PATH,42,-11586.536,-1226.437,77.81951,0,0,0,0,100,0),
(@PATH,43,-11572.477,-1226.1782,78.07488,0,0,0,0,100,0),
(@PATH,44,-11578.927,-1226.3036,78.00222,0,0,0,0,100,0),
(@PATH,45,-11572.477,-1226.1782,78.07488,0,0,0,0,100,0),
(@PATH,46,-11564.836,-1228.5527,78.7326,0,0,0,0,100,0),
(@PATH,47,-11558.235,-1235.8303,79.168465,0,0,0,0,100,0),
(@PATH,48,-11559.544,-1245.3492,78.530525,0,0,0,0,100,0),
(@PATH,49,-11558.78,-1252.0249,78.530525,0,0,0,0,100,0),
(@PATH,50,-11559.316,-1243.6807,78.57619,0,0,0,0,100,0),
(@PATH,51,-11558.78,-1252.0249,78.530525,0,0,0,0,100,0),
(@PATH,52,-11553.219,-1257.0553,78.854256,0,0,0,0,100,0),
(@PATH,53,-11558.801,-1251.7013,78.530525,0,0,0,0,100,0),
(@PATH,54,-11553.219,-1257.0553,78.854256,0,0,0,0,100,0),
(@PATH,55,-11545.639,-1258.4368,78.655525,0,0,0,0,100,0),
(@PATH,56,-11538.496,-1250.3383,78.8484,0,0,0,0,100,0),
(@PATH,57,-11542.667,-1255.0679,78.735756,0,0,0,0,100,0),
(@PATH,58,-11538.496,-1250.3383,78.8484,0,0,0,0,100,0),
(@PATH,59,-11536.562,-1241.876,79.543465,0,0,0,0,100,0),
(@PATH,60,-11537.724,-1233.9279,80.84254,0,0,0,0,100,0),
(@PATH,61,-11537.29,-1236.8806,80.50465,0,0,0,0,100,0),
(@PATH,62,-11543.108,-1228.7406,80.861015,0,0,0,0,100,0);

SET @NPC := 49359;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11573.295,`position_y`=-1292.3151,`position_z`=77.6076 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11573.295,`position_y`=-1292.3151,`position_z`=77.6076 WHERE `guid` IN (49389, 49361, 49362);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11573.295,-1292.3151,77.6076,0,0,0,0,100,0),
(@PATH,2,-11578.533,-1292.2468,77.6076,0,0,0,0,100,0),
(@PATH,3,-11568.895,-1290.8673,77.6076,0,0,0,0,100,0),
(@PATH,4,-11564.248,-1288.008,77.61754,0,0,0,0,100,0),
(@PATH,5,-11558.108,-1284.228,77.61754,0,0,0,0,100,0),
(@PATH,6,-11551.872,-1280.8896,77.61754,0,0,0,0,100,0),
(@PATH,7,-11547.022,-1278.6217,77.61754,0,0,0,0,100,0),
(@PATH,8,-11541.502,-1275.4727,77.699814,0,0,0,0,100,0),
(@PATH,9,-11535.807,-1272.9,78.52379,0,0,0,0,100,0),
(@PATH,10,-11538.608,-1274.1652,78.08458,0,0,0,0,100,0),
(@PATH,11,-11530.607,-1273.916,79.139114,0,0,0,0,100,0),
(@PATH,12,-11523.014,-1274.1941,79.639114,0,0,0,0,100,0),
(@PATH,13,-11526.356,-1277.2069,79.514114,0,0,0,0,100,0),
(@PATH,14,-11533.672,-1277.9888,78.76427,0,0,0,0,100,0),
(@PATH,15,-11539.865,-1279.0991,77.8961,0,0,0,0,100,0),
(@PATH,16,-11531.995,-1277.8068,78.98726,0,0,0,0,100,0),
(@PATH,17,-11539.865,-1279.0991,77.8961,0,0,0,0,100,0),
(@PATH,18,-11545.074,-1280.2617,77.46495,0,0,0,0,100,0),
(@PATH,19,-11550.38,-1283.0656,77.61754,0,0,0,0,100,0),
(@PATH,20,-11558.382,-1288.1755,77.61754,0,0,0,0,100,0),
(@PATH,21,-11565.479,-1292.4176,77.61754,0,0,0,0,100,0),
(@PATH,22,-11571.892,-1295.2625,77.6076,0,0,0,0,100,0),
(@PATH,23,-11577.398,-1298.0808,77.6076,0,0,0,0,100,0),
(@PATH,24,-11572.176,-1295.4081,77.6076,0,0,0,0,100,0),
(@PATH,25,-11585.52,-1301.9451,77.67639,0,0,0,0,100,0),
(@PATH,26,-11589.563,-1305.7449,77.67639,0,0,0,0,100,0),
(@PATH,27,-11593.048,-1310.1058,77.64465,0,0,0,0,100,0),
(@PATH,28,-11599.742,-1319.1442,77.55139,0,0,0,0,100,0),
(@PATH,29,-11591.976,-1308.7777,77.65402,0,0,0,0,100,0),
(@PATH,30,-11599.742,-1319.1442,77.55139,0,0,0,0,100,0),
(@PATH,31,-11596.848,-1315.2811,77.59797,0,0,0,0,100,0),
(@PATH,32,-11601.772,-1324.7399,77.55523,0,0,0,0,100,0),
(@PATH,33,-11605.479,-1334.0862,77.55613,0,0,0,0,100,0),
(@PATH,34,-11609.26,-1342.6189,77.6323,0,0,0,0,100,0),
(@PATH,35,-11610.773,-1352.7749,77.55613,0,0,0,0,100,0),
(@PATH,36,-11610.197,-1348.9067,77.645,0,0,0,0,100,0),
(@PATH,37,-11611.939,-1368.4354,75.22457,0,0,0,0,100,0),
(@PATH,38,-11611.607,-1364.8892,76.27732,0,0,0,0,100,0),
(@PATH,39,-11611.77,-1382.5566,71.45577,0,0,0,0,100,0),
(@PATH,40,-11611.919,-1396.4943,67.74264,0,0,0,0,100,0),
(@PATH,41,-11611.881,-1392.0277,69.02648,0,0,0,0,100,0),
(@PATH,42,-11611.207,-1406.998,65.316864,0,0,0,0,100,0),
(@PATH,43,-11611.176,-1420.5205,61.98801,0,0,0,0,100,0),
(@PATH,44,-11611.206,-1407.707,65.139626,0,0,0,0,100,0),
(@PATH,45,-11611.176,-1420.5205,61.98801,0,0,0,0,100,0),
(@PATH,46,-11614.535,-1423.8512,60.785374,0,0,0,0,100,0),
(@PATH,47,-11618.927,-1420.7843,60.744602,0,0,0,0,100,0),
(@PATH,48,-11618.428,-1412.8008,62.566868,0,0,0,0,100,0),
(@PATH,49,-11618.237,-1398.9095,66.78097,0,0,0,0,100,0),
(@PATH,50,-11618.313,-1404.4672,65.30759,0,0,0,0,100,0),
(@PATH,51,-11618.125,-1388.1809,69.71139,0,0,0,0,100,0),
(@PATH,52,-11617.474,-1372.5542,74.23116,0,0,0,0,100,0),
(@PATH,53,-11617.998,-1385.0753,70.68411,0,0,0,0,100,0),
(@PATH,54,-11617.474,-1372.5542,74.23116,0,0,0,0,100,0),
(@PATH,55,-11614.303,-1362.1172,76.78953,0,0,0,0,100,0),
(@PATH,56,-11614.15,-1351.4323,77.55613,0,0,0,0,100,0),
(@PATH,57,-11614.189,-1354.0997,77.55613,0,0,0,0,100,0),
(@PATH,58,-11610.35,-1337.7463,77.55613,0,0,0,0,100,0),
(@PATH,59,-11603.985,-1322.4636,77.55523,0,0,0,0,100,0),
(@PATH,60,-11607.471,-1330.8333,77.555725,0,0,0,0,100,0),
(@PATH,61,-11603.985,-1322.4636,77.55523,0,0,0,0,100,0),
(@PATH,62,-11598.557,-1313.0482,77.55139,0,0,0,0,100,0),
(@PATH,63,-11589.14,-1301.8583,77.452515,0,0,0,0,100,0),
(@PATH,64,-11593.17,-1306.6475,77.54358,0,0,0,0,100,0),
(@PATH,65,-11589.14,-1301.8583,77.452515,0,0,0,0,100,0),
(@PATH,66,-11584.965,-1296.8317,77.6076,0,0,0,0,100,0),
(@PATH,67,-11584.541,-1288.1438,77.6076,0,0,0,0,100,0),
(@PATH,68,-11585.833,-1272.9137,77.6076,0,0,0,0,100,0),
(@PATH,69,-11585.112,-1281.4099,77.6076,0,0,0,0,100,0),
(@PATH,70,-11585.833,-1272.9137,77.6076,0,0,0,0,100,0),
(@PATH,71,-11583.156,-1271.3705,77.6076,0,0,0,0,100,0),
(@PATH,72,-11580.249,-1281.9635,77.6076,0,0,0,0,100,0),
(@PATH,73,-11580.544,-1278.5647,77.6076,0,0,0,0,100,0),
(@PATH,74,-11580.214,-1288.6029,77.6076,0,0,0,0,100,0),
(@PATH,75,-11578.505,-1292.3073,77.6076,0,0,0,0,100,0);

SET @NPC := 91441;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11537.733,`position_y`=-1487.2949,`position_z`=74.980804 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11536.733,`position_y`=-1487.2949,`position_z`=74.980804 WHERE `guid`=91440;

DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11537.733,-1487.2949,74.980804,0,0,0,0,100,0),
(@PATH,2,-11558.047,-1477.5065,66.72031,0,0,0,0,100,0),
(@PATH,3,-11569.054,-1475.5392,63.00964,0,0,0,0,100,0),
(@PATH,4,-11579.731,-1490.234,54.890743,0,0,0,0,100,0),
(@PATH,5,-11583.994,-1504.7122,53.77436,0,0,0,0,100,0),
(@PATH,6,-11596.935,-1513.0582,48.127876,0,0,0,0,100,0),
(@PATH,7,-11615.329,-1514.1256,43.016304,0,0,0,0,100,0),
(@PATH,8,-11623.127,-1497.8248,44.31972,0,0,0,0,100,0),
(@PATH,9,-11639.55,-1482.4012,45.770515,0,0,0,0,100,0),
(@PATH,10,-11623.127,-1497.8248,44.31972,0,0,0,0,100,0),
(@PATH,11,-11615.329,-1514.1256,43.016304,0,0,0,0,100,0),
(@PATH,12,-11596.935,-1513.0582,48.127876,0,0,0,0,100,0),
(@PATH,13,-11583.994,-1504.7122,53.77436,0,0,0,0,100,0),
(@PATH,14,-11579.731,-1490.234,54.890743,0,0,0,0,100,0),
(@PATH,15,-11569.054,-1475.5392,63.00964,0,0,0,0,100,0),
(@PATH,16,-11558.047,-1477.5065,66.72031,0,0,0,0,100,0);

SET @NPC := 51951;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11528.148,`position_y`=-1513.8928,`position_z`=63.905006 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11527.148,`position_y`=-1513.8928,`position_z`=63.905006 WHERE `guid`=51951;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11528.148,-1513.8928,63.905006,0,0,0,0,100,0),
(@PATH,2,-11540.652,-1510.0276,62.370094,0,0,0,0,100,0),
(@PATH,3,-11562.911,-1508.6621,55.512184,0,0,0,0,100,0),
(@PATH,4,-11579.961,-1504.0708,54.545113,0,0,0,0,100,0),
(@PATH,5,-11609.733,-1498.5669,46.873188,0,0,0,0,100,0),
(@PATH,6,-11629.067,-1474.237,48.77846,0,0,0,0,100,0),
(@PATH,7,-11604.551,-1463.5339,52.698364,0,0,0,0,100,0),
(@PATH,8,-11603.742,-1445.5684,58.399292,0,0,0,0,100,0),
(@PATH,9,-11617.274,-1426.2169,59.972874,0,0,0,0,100,0),
(@PATH,10,-11629.517,-1415.1227,61.600803,0,0,0,0,100,0),
(@PATH,11,-11652.543,-1417.3339,58.611256,0,0,0,0,100,0),
(@PATH,12,-11667.903,-1442.6356,58.95604,0,0,0,0,100,0),
(@PATH,13,-11652.543,-1417.3339,58.611256,0,0,0,0,100,0),
(@PATH,14,-11629.633,-1415.1328,61.566868,0,0,0,0,100,0),
(@PATH,15,-11617.274,-1426.2169,59.972874,0,0,0,0,100,0),
(@PATH,16,-11603.747,-1445.4777,58.45984,0,0,0,0,100,0),
(@PATH,17,-11604.557,-1463.4434,52.774292,0,0,0,0,100,0),
(@PATH,18,-11629.067,-1474.237,48.77846,0,0,0,0,100,0),
(@PATH,19,-11609.733,-1498.5669,46.873188,0,0,0,0,100,0),
(@PATH,20,-11579.961,-1504.0708,54.545113,0,0,0,0,100,0),
(@PATH,21,-11562.911,-1508.6621,55.512184,0,0,0,0,100,0),
(@PATH,22,-11540.652,-1510.0276,62.370094,0,0,0,0,100,0);

SET @NPC := 91458;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11655.185,`position_y`=-1556.1298,`position_z`=41.085743 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11654.185,`position_y`=-1556.1298,`position_z`=41.085743 WHERE `guid`=91457;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11655.185,-1556.1298,41.085743,0,0,0,0,100,0),
(@PATH,2,-11646.647,-1520.3574,39.52875,0,0,0,0,100,0),
(@PATH,3,-11635.523,-1505.7322,41.577824,0,0,0,0,100,0),
(@PATH,4,-11617.473,-1473.5356,48.90151,0,0,0,0,100,0),
(@PATH,5,-11620.747,-1453.2869,54.162476,0,0,0,0,100,0),
(@PATH,6,-11638.18,-1449.1713,59.971928,0,0,0,0,100,0),
(@PATH,7,-11620.747,-1453.2869,54.162476,0,0,0,0,100,0),
(@PATH,8,-11617.473,-1473.5356,48.90151,0,0,0,0,100,0),
(@PATH,9,-11635.523,-1505.7322,41.577824,0,0,0,0,100,0),
(@PATH,10,-11646.647,-1520.3574,39.52875,0,0,0,0,100,0);

SET @NPC := 49057;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11861.868,`position_y`=-1902.6844,`position_z`=64.00689 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11861.868,-1902.6844,64.00689,0,0,1,0,100,0),
(@PATH,2,-11864.919,-1875.0856,64.287445,0,0,1,0,100,0),
(@PATH,3,-11873.851,-1872.3376,64.72649,0,0,1,0,100,0),
(@PATH,4,-11877.952,-1858.161,64.13116,0,0,1,0,100,0),
(@PATH,5,-11878.428,-1844.322,63.788383,0,0,1,0,100,0),
(@PATH,6,-11901.125,-1843.6138,60.67543,0,0,1,0,100,0),
(@PATH,7,-11918.121,-1837.8859,58.49794,0,0,1,0,100,0),
(@PATH,8,-11933.903,-1849.0443,57.74362,0,0,1,0,100,0),
(@PATH,9,-11918.121,-1837.8859,58.49794,0,0,1,0,100,0),
(@PATH,10,-11901.125,-1843.6138,60.67543,0,0,1,0,100,0),
(@PATH,11,-11878.428,-1844.322,63.788383,0,0,1,0,100,0),
(@PATH,12,-11877.952,-1858.161,64.13116,0,0,1,0,100,0),
(@PATH,13,-11873.851,-1872.3376,64.72649,0,0,1,0,100,0),
(@PATH,14,-11864.919,-1875.0856,64.287445,0,0,1,0,100,0);

SET @NPC := 49065;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11885.854,`position_y`=-1884.8516,`position_z`=63.60832 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11885.854,-1884.8516,63.60832,0,0,0,0,100,0),
(@PATH,2,-11883.883,-1881.4486,63.60832,0,0,0,0,100,0),
(@PATH,3,-11885.817,-1877.1693,63.60832,0,0,0,0,100,0),
(@PATH,4,-11891.109,-1875.8904,63.60832,0,0,0,0,100,0),
(@PATH,5,-11893.704,-1880.7555,63.60832,0,0,0,0,100,0),
(@PATH,6,-11891.03,-1885.1721,63.60832,0,0,0,0,100,0);

SET @NPC := 49062;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11870.778,`position_y`=-1890.4827,`position_z`=64.42717 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11870.778,-1890.4827,64.42717,0,0,0,0,100,0),
(@PATH,2,-11874.493,-1886.7123,64.23137,0,0,0,0,100,0),
(@PATH,3,-11879.215,-1887.6454,63.60832,0,0,0,0,100,0),
(@PATH,4,-11880.993,-1892.7509,63.60832,0,0,0,0,100,0),
(@PATH,5,-11877.776,-1896.8364,63.60832,0,0,0,0,100,0),
(@PATH,6,-11872.059,-1895.8776,63.898846,0,0,0,0,100,0);

SET @NPC := 49053;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11854.911,`position_y`=-1900.671,`position_z`=64.122856 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11854.911,-1900.671,64.122856,0,0,0,0,100,0),
(@PATH,2,-11857.439,-1878.6938,64.00717,0,0,0,0,100,0),
(@PATH,3,-11855.941,-1864.2994,64.43505,0,0,0,0,100,0),
(@PATH,4,-11861.117,-1853.1434,64.12035,0,0,0,0,100,0),
(@PATH,5,-11858.396,-1842.1367,63.803947,0,0,0,0,100,0),
(@PATH,6,-11861.117,-1853.1434,64.12035,0,0,0,0,100,0),
(@PATH,7,-11855.941,-1864.2994,64.43505,0,0,0,0,100,0),
(@PATH,8,-11857.439,-1878.6938,64.00717,0,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (49123, 49130, 52267, 49651, 49359, 91458, 91457, 91441, 51951, 49057, 49065, 49062, 49053);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(49123, 49123, 0, 0, 514, 0, 0),
(49123, 49128, 5, 195, 514, 0, 0),
(49123, 49127, 10, 195, 514, 0, 0),
(49123, 49124, 5, 155, 514, 0, 0),
(49123, 49125, 10, 155, 514, 0, 0),
(49123, 49130, 10, 180, 514, 0, 0),
(49123, 49129, 5, 180, 514, 0, 0),
(52267, 52267, 0, 0, 514, 0, 0),
(52267, 52271, 5, 195, 514, 0, 0),
(52267, 52270, 10, 195, 514, 0, 0),
(52267, 52269, 5, 155, 514, 0, 0),
(52267, 52268, 10, 155, 514, 0, 0),
(52267, 52265, 10, 180, 514, 0, 0),
(52267, 52266, 5, 180, 514, 0, 0),
(49651, 49651, 0, 0, 514, 0, 0),
(49651, 49652, 2, 180, 514, 0, 0),
(49651, 49653, 4, 180, 514, 0, 0),
(49651, 49654, 6, 180, 514, 0, 0),
(49359, 49359, 0, 0, 514, 0, 0),
(49359, 49362, 2, 180, 514, 0, 0),
(49359, 49361, 4, 180, 514, 0, 0),
(49359, 49389, 6, 180, 514, 0, 0),
(91441, 91441, 0, 0, 514, 0, 0),
(91441, 91440, 4, 90, 514, 0, 0),
(51951, 51951, 0, 0, 514, 0, 0),
(51951, 51952, 2, 90, 514, 0, 0),
(91458, 91458, 0, 0, 514, 0, 0),
(91458, 91457, 2, 90, 514, 0, 0),
(49057, 49057, 0, 0, 514, 0, 0),
(49057, 49149, 10, 180, 514, 0, 0),
(49065, 49065, 0, 0, 514, 0, 0),
(49065, 49066, 2, 180, 514, 0, 0),
(49065, 49067, 4, 180, 514, 0, 0),
(49062, 49062, 0, 0, 514, 0, 0),
(49062, 49063, 2, 180, 514, 0, 0),
(49062, 49064, 4, 180, 514, 0, 0),
(49053, 49053, 0, 0, 514, 0, 0),
(49053, 49054, 2, 180, 514, 0, 0),
(49053, 49055, 4, 180, 514, 0, 0);
