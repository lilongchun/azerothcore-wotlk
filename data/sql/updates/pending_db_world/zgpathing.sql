UPDATE `creature_template` SET `speed_walk`=1,`speed_run`=1.14286 WHERE `entry` IN(11371, 11350, 11372, 11830, 13321, 11374, 15043, 11831, 11351, 11359, 11387, 11373, 15042, 14758);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry` IN(2914, 1420);
UPDATE `creature_template` SET `speed_walk`=0.66667, `speed_run`=2.14286 WHERE `entry` IN(11352);
UPDATE `creature_template` SET `speed_walk`=2, `speed_run`=2.14286 WHERE `entry` IN(11368, 14750);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry` IN(1420);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=2.14286 WHERE `entry` IN(14834, 14517, 14510);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.71429 WHERE `entry` IN(11357);
UPDATE `creature_template` SET `speed_walk`=2, `speed_run`=2.42857 WHERE `entry` IN(14880);

SET @NPC := 49132;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12317.01,`position_y`=-1447.9121,`position_z`=130.70255 WHERE `guid`=@NPC;
UPDATE `creature`SET `wander_distance`=0,`MovementType`=0,`position_x`=-12317.01,`position_y`=-1447.9121,`position_z`=130.70255 WHERE `guid`=49131;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-12317.01,`position_y`=-1447.9121,`position_z`=130.70255 WHERE `guid`=49133;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12317.01,`position_y`=-1447.9121,`position_z`=130.70255 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-12317.01,-1447.9121,130.70255,0,0,0,0,100,0),
(@path,2,-12294.435,-1452.9664,130.7252,0,0,0,0,100,0),
(@path,3,-12274.962,-1432.1677,130.7252,0,0,0,0,100,0),
(@path,4,-12251.229,-1419.3248,130.7252,0,0,0,0,100,0),
(@path,5,-12218.372,-1407.2831,131.82335,0,0,0,0,100,0),
(@path,6,-12251.229,-1419.3248,130.7252,0,0,0,0,100,0),
(@path,7,-12274.962,-1432.1677,130.7252,0,0,0,0,100,0),
(@path,8,-12294.435,-1452.9664,130.7252,0,0,0,0,100,0);

DELETE FROM `creature` WHERE (`id1` = 11372 AND guid = 49090) OR (`id1` = 11371 AND `guid` = 49090) OR (`id1` = 14750 AND  `guid`IN (52135, 49139)) OR (`id1`= 11368 AND `guid` = 49139) OR (`id1`= 11368 AND `guid` IN (52138, 52137, 52136));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49090, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11862.2, -1317.21, 79.0372, 4.15388, 7200, 0, 0, 15260, 0, 0, 0, 0, 0, '', 0),
(49139, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12237.4, -1413.4, 130.725, 3.49715, 7200, 5, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(52135, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12229.842, -1411.0471, 130.725, 3.49715, 7200, 5, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(52136, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12229.842, -1410.0471, 130.725, 5.11337, 7200, 5, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(52137, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12229.842, -1412.0471, 130.725, 5.11337, 7200, 5, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(52138, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12229.842, -1411.5471, 130.725, 5.11337, 7200, 5, 0, 5341, 0, 1, 0, 0, 0, '', 0);

SET @NPC := 49090;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11874.843,`position_y`=-1325.8516,`position_z`=78.68711 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-11874.843,-1325.8516,78.68711,0,0,0,0,100,0),
(@path,2,-11888.364,-1338.8317,74.93052,0,0,0,0,100,0),
(@path,3,-11904.724,-1344.1305,75.75995,0,0,0,0,100,0),
(@path,4,-11905.38,-1360.0092,70.85077,0,0,0,0,100,0),
(@path,5,-11901.88,-1377.7013,68.11927,0,0,0,0,100,0),
(@path,6,-11884.866,-1380.3492,66.02857,0,0,0,0,100,0),
(@path,7,-11880.479,-1399.4225,62.97413,0,0,0,0,100,0),
(@path,8,-11878.038,-1407.888,62.201817,0,0,0,0,100,0),
(@path,9,-11894.919,-1416.4415,57.01041,0,0,0,0,100,0),
(@path,10,-11921.158,-1428.7435,46.9667,0,2000,0,0,100,0),
(@path,11,-11894.919,-1416.4415,57.01041,0,0,0,0,100,0),
(@path,12,-11878.038,-1407.888,62.201817,0,0,0,0,100,0),
(@path,13,-11880.479,-1399.4225,62.97413,0,0,0,0,100,0),
(@path,14,-11884.866,-1380.3492,66.02857,0,0,0,0,100,0),
(@path,15,-11901.88,-1377.7013,68.11927,0,0,0,0,100,0),
(@path,16,-11905.361,-1360.0527,70.93378,0,0,0,0,100,0),
(@path,17,-11904.724,-1344.1305,75.75995,0,0,0,0,100,0),
(@path,18,-11888.364,-1338.8317,74.93052,0,0,0,0,100,0),
(@path,19,-11874.843,-1325.8516,78.68711,0,0,0,0,100,0),
(@path,20,-11863.753,-1313.4701,78.72681,0,2000,0,0,100,0);

SET @NPC := 49761;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11966.846,`position_y`=-1528.8047,`position_z`=41.97195 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-11966.846,-1528.8047,41.97195,0,0,0,0,100,0),
(@path,2,-11999.917,-1520.9025,58.9844,0,0,0,0,100,0),
(@path,3,-12023.279,-1518.9547,72.43448,0,0,0,0,100,0),
(@path,4,-12028.042,-1500.1376,77.62198,0,0,0,0,100,0),
(@path,5,-12029.563,-1488.6721,79.530396,0,0,0,0,100,0),
(@path,6,-12033.312,-1478.7206,80.10852,0,0,0,0,100,0),
(@path,7,-12066.744,-1478.9442,101.670784,0,0,0,0,100,0),
(@path,8,-12100.744,-1478.7441,128.72264,0,0,0,0,100,0),
(@path,9,-12066.744,-1478.9442,101.670784,0,0,0,0,100,0),
(@path,10,-12033.312,-1478.7206,80.10852,0,0,0,0,100,0),
(@path,11,-12029.563,-1488.6721,79.530396,0,0,0,0,100,0),
(@path,12,-12028.042,-1500.1376,77.62198,0,0,0,0,100,0),
(@path,13,-12023.279,-1518.9547,72.43448,0,0,0,0,100,0),
(@path,14,-11999.917,-1520.9025,58.9844,0,0,0,0,100,0);

SET @NPC := 49751;
SET @path := @NPC * 10;
SET @NPC2 := 49752;
SET @path2 := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11915.182,`position_y`=-1309.0254,`position_z`=77.85016 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-11917.182,`position_y`=-1309.0254,`position_z`=77.85016 WHERE `guid`=@NPC2;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@path,@path2);
INSERT INTO `waypoint_data`(`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-11915.182,-1309.0254,77.85016,0,0,0,0,100,0),
(@path,2,-11900.22,-1322.3068,77.35016,0,0,0,0,100,0),
(@path,3,-11891.567,-1333.3414,75.761086,0,0,0,0,100,0),
(@path,4,-11883.896,-1344.9625,74.07407,0,0,0,0,100,0),
(@path,5,-11884.932,-1366.6774,69.18043,0,0,0,0,100,0),
(@path,6,-11881.251,-1392.7772,64.10792,0,0,0,0,100,0),
(@path,7,-11884.669,-1407.5942,61.118076,0,0,0,0,100,0),
(@path,8,-11898.967,-1416.9801,55.54923,0,0,0,0,100,0),
(@path,9,-11914.943,-1429.737,46.979885,0,0,0,0,100,0),
(@path,10,-11920.759,-1446.3221,42.852036,0,0,0,0,100,0),
(@path,11,-11927.813,-1477.2751,32.164944,0,0,0,0,100,0),
(@path,12,-11938.073,-1520.2743,42.869736,0,0,0,0,100,0),
(@path,13,-11940.487,-1533.6138,39.66779,0,0,0,0,100,0),
(@path,14,-11947.255,-1542.4147,39.66779,0,0,0,0,100,0),
(@path,15,-11943.104,-1557.1871,39.79279,0,0,0,0,100,0),
(@path,16,-11943.644,-1566.9681,41.143223,0,0,0,0,100,0),
(@path,17,-11945.308,-1590.3102,36.837807,0,0,0,0,100,0),
(@path,18,-11947.825,-1619.8463,41.207428,0,0,0,0,100,0),
(@path,19,-11951.434,-1633.3173,38.97269,0,0,0,0,100,0),
(@path,20,-11968.02,-1647.7539,35.483604,0,0,0,0,100,0),
(@path,21,-12000.128,-1644.0223,34.706413,0,0,0,0,100,0),
(@path,22,-12025.215,-1640.9318,38.757927,0,0,0,0,100,0),
(@path,23,-12041.77,-1650.1912,40.77353,0,0,0,0,100,0),
(@path,24,-12059.076,-1670.9088,42.50792,0,0,0,0,100,0),
(@path,25,-12060.682,-1706.4213,45.026535,0,0,0,0,100,0),
(@path,26,-12047.378,-1730.9137,50.612717,0,0,0,0,100,0),
(@path,27,-12060.682,-1706.4213,45.026535,0,0,0,0,100,0),
(@path,28,-12059.076,-1670.9088,42.50792,0,0,0,0,100,0),
(@path,29,-12041.77,-1650.1912,40.77353,0,0,0,0,100,0),
(@path,30,-12025.215,-1640.9318,38.757927,0,0,0,0,100,0),
(@path,31,-12000.128,-1644.0223,34.706413,0,0,0,0,100,0),
(@path,32,-11968.145,-1647.8522,35.503624,0,0,0,0,100,0),
(@path,33,-11951.559,-1633.4141,38.973248,0,0,0,0,100,0),
(@path,34,-11947.825,-1619.8463,41.207428,0,0,0,0,100,0),
(@path,35,-11945.308,-1590.3102,36.837807,0,0,0,0,100,0),
(@path,36,-11943.644,-1566.9681,41.143223,0,0,0,0,100,0),
(@path,37,-11943.104,-1557.1871,39.79279,0,0,0,0,100,0),
(@path,38,-11947.255,-1542.4147,39.66779,0,0,0,0,100,0),
(@path,39,-11940.487,-1533.6138,39.66779,0,0,0,0,100,0),
(@path,40,-11938.073,-1520.2743,42.869736,0,0,0,0,100,0),
(@path,41,-11927.813,-1477.2751,32.164944,0,0,0,0,100,0),
(@path,42,-11920.759,-1446.3221,42.852036,0,0,0,0,100,0),
(@path,43,-11914.943,-1429.737,46.979885,0,0,0,0,100,0),
(@path,44,-11898.967,-1416.9801,55.54923,0,0,0,0,100,0),
(@path,45,-11884.669,-1407.5942,61.118076,0,0,0,0,100,0),
(@path,46,-11881.251,-1392.7772,64.10792,0,0,0,0,100,0),
(@path,47,-11884.932,-1366.6774,69.18043,0,0,0,0,100,0),
(@path,48,-11883.896,-1344.9625,74.07407,0,0,0,0,100,0),
(@path,49,-11891.567,-1333.3414,75.761086,0,0,0,0,100,0),
(@path,50,-11900.22,-1322.3068,77.35016,0,0,0,0,100,0);

SET @NPC := 49146;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12051.524,`position_y`=-1427.2681,`position_z`=130.14175 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12051.524,-1427.2681,130.14175,0,0,0,0,100,0),
(@PATH,2,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0),
(@PATH,3,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@PATH,4,-12076.898,-1450.6375,130.39133,0,0,0,0,100,0),
(@PATH,5,-12088.711,-1450.2057,130.85104,0,0,0,0,100,0),
(@PATH,6,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@PATH,7,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0);

SET @NPC := 49135;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12207.685,`position_y`=-1462.47,`position_z`=131.32281 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12207.685,-1462.47,131.32281,0,0,0,0,100,0),
(@PATH,2,-12245.68,-1474.5807,130.62447,0,0,0,0,100,0),
(@PATH,3,-12272.678,-1484.2139,130.7252,0,0,0,0,100,0),
(@PATH,4,-12291.434,-1475.9297,130.7252,0,0,0,0,100,0),
(@PATH,5,-12312.472,-1457.0942,130.70255,0,0,0,0,100,0),
(@PATH,6,-12291.434,-1475.9297,130.7252,0,0,0,0,100,0),
(@PATH,7,-12272.678,-1484.2139,130.7252,0,0,0,0,100,0),
(@PATH,8,-12245.68,-1474.5807,130.62447,0,0,0,0,100,0);
 
SET @NPC := 49186;
SET @path := @NPC * 10;
SET @NPC2 := 49189;
SET @NPC3 := 49188;
SET @NPC4 := 49187;
SET @NPC5 := 49140;
SET @NPC6 := 49139;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-12138.658,`position_y`=-1462.6881,`position_z`=132.72519 WHERE `guid`=@NPC2;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-12140.658,`position_y`=-1462.6881,`position_z`=132.72519 WHERE `guid`=@NPC3;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-12139.658,`position_y`=-1461.6881,`position_z`=132.72519 WHERE `guid`=@NPC4;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-12139.658,`position_y`=-1463.6881,`position_z`=132.72519 WHERE `guid`=@NPC5;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=1,`position_x`=-12139.658,`position_y`=-1461.3881,`position_z`=132.72519 WHERE `guid`=@NPC6;
UPDATE `creature` SET `wander_distance`=2,`MovementType`=2,`position_x`=-12139.658,`position_y`=-1462.6881,`position_z`=130.72519 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-12139.658,-1462.6881,131.72519,0,0,2,0,100,0),
(@path,2,-12145.165,-1472.5826,131.72519,0,0,2,0,100,0),
(@path,3,-12150.585,-1480.6031,131.72519,0,0,2,0,100,0),
(@path,4,-12155.898,-1487.2714,131.88535,0,0,2,0,100,0),
(@path,5,-12162.413,-1488.4478,131.95273,0,0,2,0,100,0),
(@path,6,-12166.849,-1484.3025,131.72519,0,0,2,0,100,0),
(@path,7,-12169.933,-1475.3961,131.72519,0,0,2,0,100,0),
(@path,8,-12168.736,-1461.0402,131.72519,0,0,2,0,100,0),
(@path,9,-12165.8,-1451.5284,132.1915,0,0,0,2,100,0),
(@path,10,-12159.837,-1446.8896,132.52573,0,0,2,0,100,0),
(@path,11,-12154.368,-1448.3627,132.15585,0,0,2,0,100,0),
(@path,12,-12148.044,-1460.6128,131.72519,0,0,2,0,100,0),
(@path,13,-12142.502,-1469.3756,131.72519,0,0,2,0,100,0),
(@path,14,-12139.423,-1477.193,131.72519,0,0,2,0,100,0),
(@path,15,-12142.655,-1487.7107,131.81308,0,0,2,0,100,0),
(@path,16,-12150.853,-1489.0536,132.22275,0,0,2,0,100,0),
(@path,17,-12157.748,-1478.774,131.72519,0,0,2,0,100,0),
(@path,18,-12158.351,-1465.1509,132.22519,0,0,2,0,100,0),
(@path,19,-12156.007,-1450.0975,131.72519,0,0,2,0,100,0),
(@path,20,-12153.582,-1446.1135,132.67294,0,0,2,0,100,0),
(@path,21,-12146.194,-1444.6774,133.9537,0,0,2,0,100,0),
(@path,22,-12139.783,-1452.6754,131.72519,0,0,2,0,100,0);

SET @NPC := 52136;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12229.842,`position_y`=-1411.0471,`position_z`=131.83165 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-12229.842,-1411.0471,131.83165-0.5,0,0,0,0,100,0),
(@path,2,-12206.786,-1421.8655,131.78893-0.5,0,0,0,0,100,0),
(@path,3,-12195.927,-1433.3926,134.31308-0.5,0,0,0,0,100,0),
(@path,4,-12205.035,-1448.4469,131.69781-0.5,0,0,0,0,100,0),
(@path,5,-12206.235,-1461.8943,132.32281-0.5,0,0,0,0,100,0),
(@path,6,-12177.454,-1466.4033,131.72519-0.5,0,0,0,0,100,0),
(@path,7,-12138.972,-1456.231,131.72519-0.5,0,0,0,0,100,0),
(@path,8,-12126.492,-1456.4739,131.72519-0.5,0,0,0,0,100,0),
(@path,9,-12157.802,-1469.8934,131.90048-0.5,0,0,0,0,100,0),
(@path,10,-12179.677,-1470.5027,131.72519-0.5,0,0,0,0,100,0),
(@path,11,-12207.076,-1464.7598,132.07281-0.5,0,0,0,0,100,0),
(@path,12,-12221.514,-1453.3093,131.69781-0.5,0,0,0,0,100,0),
(@path,13,-12224.45,-1427.07,131.7252-0.5,0,0,0,0,100,0),
(@path,14,-12246.912,-1421.354,131.7252-0.5,0,0,0,0,100,0),
(@path,15,-12269.187,-1427.5114,131.7252-0.5,0,0,0,0,100,0),
(@path,16,-12285.375,-1448.8418,131.7252-0.5,0,0,0,0,100,0),
(@path,17,-12287.772,-1473.3102,131.7252-0.5,0,0,0,0,100,0),
(@path,18,-12273.458,-1487.5211,131.7252-0.5,0,0,0,0,100,0),
(@path,19,-12249.114,-1489.0677,131.6252-0.5,0,0,0,0,100,0),
(@path,20,-12235.835,-1473.7202,131.7834-0.5,0,0,0,0,100,0),
(@path,21,-12250.835,-1461.4537,131.66344-0.5,0,0,0,0,100,0),
(@path,22,-12265.916,-1449.0624,131.7252-0.5,0,0,0,0,100,0),
(@path,23,-12277.745,-1431.3622,131.7252-0.5,0,0,0,0,100,0),
(@path,24,-12303.044,-1414.7955,131.7252-0.5,0,0,0,0,100,0),
(@path,25,-12277.745,-1431.3622,131.7252-0.5,0,0,0,0,100,0),
(@path,26,-12265.916,-1449.0624,131.7252-0.5,0,0,0,0,100,0),
(@path,27,-12250.835,-1461.4537,131.66344-0.5,0,0,0,0,100,0),
(@path,28,-12235.835,-1473.7202,131.7834-0.5,0,0,0,0,100,0),
(@path,29,-12249.114,-1489.0677,131.6252-0.5,0,0,0,0,100,0),
(@path,30,-12273.458,-1487.5211,131.7252-0.5,0,0,0,0,100,0),
(@path,31,-12287.772,-1473.3102,131.7252-0.5,0,0,0,0,100,0),
(@path,32,-12285.375,-1448.8418,131.7252-0.5,0,0,0,0,100,0),
(@path,33,-12269.187,-1427.5114,131.7252-0.5,0,0,0,0,100,0),
(@path,34,-12246.912,-1421.354,131.7252-0.5,0,0,0,0,100,0),
(@path,35,-12224.45,-1427.07,131.7252-0.5,0,0,0,0,100,0),
(@path,36,-12221.514,-1453.3093,131.69781-0.5,0,0,0,0,100,0),
(@path,37,-12207.227,-1464.7308,132.11774-0.5,0,0,0,0,100,0),
(@path,38,-12179.677,-1470.5027,131.72519-0.5,0,0,0,0,100,0),
(@path,39,-12157.802,-1469.8934,131.90048-0.5,0,0,0,0,100,0),
(@path,40,-12126.492,-1456.4739,131.72519-0.5,0,0,0,0,100,0),
(@path,41,-12177.454,-1466.4033,131.72519-0.5,0,0,0,0,100,0),
(@path,42,-12206.235,-1461.8943,132.32281-0.5,0,0,0,0,100,0),
(@path,43,-12205.035,-1448.4469,131.69781-0.5,0,0,0,0,100,0),
(@path,44,-12195.927,-1433.3926,134.31308-0.5,0,0,0,0,100,0),
(@path,45,-12206.786,-1421.8655,131.78893-0.5,0,0,0,0,100,0),
(@path,46,-12229.842,-1411.0471,132.83165-0.5,0,0,0,0,100,0),
(@path,47,-12254.974,-1407.7135,132.03355-0.5,0,0,0,0,100,0),
(@path,48,-12275.289,-1404.068,131.7252-0.5,0,0,0,0,100,0),
(@path,49,-12290.608,-1416.1903,132.7252-0.5,0,0,0,0,100,0),
(@path,50,-12292.546,-1432.5616,132.89317-0.5,0,0,0,0,100,0),
(@path,51,-12275.803,-1456.5319,132.7252-0.5,0,0,0,0,100,0),
(@path,52,-12257.487,-1460.9338,132.7252-0.5,0,0,0,0,100,0),
(@path,53,-12248.77,-1487.915,132.72212-0.5,0,0,0,0,100,0),
(@path,54,-12227.283,-1488.0863,133.32726-0.5,0,0,0,0,100,0),
(@path,55,-12211.806,-1476.1088,131.79576-0.5,0,0,0,0,100,0),
(@path,56,-12176.583,-1471.7878,131.72519-0.5,0,0,0,0,100,0),
(@path,57,-12147.339,-1466.9387,131.72519-0.5,0,0,0,0,100,0),
(@path,58,-12121.021,-1459.1855,131.72519-0.5,0,0,0,0,100,0),
(@path,59,-12088.544,-1450.2576,131.85104-0.5,0,0,0,0,100,0),
(@path,60,-12147.339,-1466.9387,131.72519-0.5,0,0,0,0,100,0),
(@path,61,-12176.583,-1471.7878,131.72519-0.5,0,0,0,0,100,0),
(@path,62,-12211.806,-1476.1088,131.79576-0.5,0,0,0,0,100,0),
(@path,63,-12227.283,-1488.0863,133.32726-0.5,0,0,0,0,100,0),
(@path,64,-12248.77,-1487.915,131.72212-0.5,0,0,0,0,100,0),
(@path,65,-12257.487,-1460.9338,131.7252-0.5,0,0,0,0,100,0),
(@path,66,-12275.803,-1456.5319,131.7252-0.5,0,0,0,0,100,0),
(@path,67,-12292.546,-1432.5616,131.89317-0.5,0,0,0,0,100,0),
(@path,68,-12290.608,-1416.1903,131.7252-0.5,0,0,0,0,100,0),
(@path,69,-12275.289,-1404.068,131.7252-0.5,0,0,0,0,100,0),
(@path,70,-12254.974,-1407.7135,132.03355-0.5,0,0,0,0,100,0);

DELETE FROM `creature` WHERE (`id1` = 14750 AND `GUID` = 49185) OR (`id1` = 14750 AND `GUID` = 49167) OR (`id1` = 11368 AND `GUID` = 49156) OR (`id1` = 11368 AND `GUID` = 49157) ;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49185, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12213.109, -1477.2382, 130.725, 130.93126, 7200, 5, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(49167, 14750, 0, 0, 309, 0, 0, 1, 1, 0, -12215.109, -1477.2382, 130.725, 130.93126, 7200, 5, 0, 31440, 0, 1, 0, 0, 0, '', 0),
(49156, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12215.109, -1476.2382, 130.725, 3.1765, 7200, 0, 0, 5341, 0, 1, 0, 0, 0, '', 0),
(49157, 11368, 0, 0, 309, 0, 0, 1, 1, 0, -12215.109, -1478.2382, 130.725, 0.314159, 7200, 0, 0, 5341, 0, 1, 0, 0, 0, '', 0);

SET @NPC := 49158;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12214.109,`position_y`=-1477.2382,`position_z`=130.93126 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12214.109,-1477.2382,130.93126,0,0,0,0,100,0),
(@PATH,2,-12211.264,-1469.974,130.7252,0,0,0,0,100,0),
(@PATH,3,-12214.149,-1461.742,130.81232,0,0,0,0,100,0),
(@PATH,4,-12235.612,-1459.0533,130.7252,0,0,0,0,100,0),
(@PATH,5,-12255.216,-1470.7734,130.62447,0,0,0,0,100,0),
(@PATH,6,-12255.078,-1483.8112,130.62447,0,0,0,0,100,0),
(@PATH,7,-12246.08,-1488.4501,131.03218,0,0,0,0,100,0),
(@PATH,8,-12233.38,-1491.1652,133.18355,0,0,0,0,100,0),
(@PATH,9,-12222.606,-1482.8005,130.99913,0,0,0,0,100,0);

SET @NPC := 51452;
SET @NPC2 := 51451;
SET @path := @NPC * 10;
SET @posX := -12057.339;
SET @posY := -1734.9985;
SET @posZ := 51.701015;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12057.339,`position_y`=-1734.9985,`position_z`=51.701015 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12057.339,-1734.9985,51.701015,0,0,0,0,100,0),
(@PATH,2,-12064.325,-1723.6598,48.64299,0,0,0,0,100,0),
(@PATH,3,-12081.199,-1711.9126,50.009007,0,0,0,0,100,0),
(@PATH,4,-12083.754,-1694.3141,47.727253,0,0,0,0,100,0),
(@PATH,5,-12075.137,-1685.36,44.9919,0,0,0,0,100,0),
(@PATH,6,-12060.942,-1668.3538,42.789413,0,0,0,0,100,0),
(@PATH,7,-12053.68,-1652.7511,43.139984,0,0,0,0,100,0),
(@PATH,8,-12040.667,-1640.4402,40.75351,0,0,0,0,100,0),
(@PATH,9,-12023.091,-1633.9069,38.15856,0,0,0,0,100,0),
(@PATH,10,-12013.497,-1648.2031,37.284782,0,0,0,0,100,0),
(@PATH,11,-11993.206,-1638.6372,34.66549,0,0,0,0,100,0),
(@PATH,12,-11970.971,-1640.5399,35.773155,0,0,0,0,100,0),
(@PATH,13,-11952.981,-1647.8049,39.700054,0,0,0,0,100,0),
(@PATH,14,-11970.971,-1640.5399,35.773155,0,0,0,0,100,0),
(@PATH,15,-11993.206,-1638.6372,34.66549,0,0,0,0,100,0),
(@PATH,16,-12013.497,-1648.2031,37.284782,0,0,0,0,100,0),
(@PATH,17,-12023.091,-1633.9069,38.15856,0,0,0,0,100,0),
(@PATH,18,-12040.667,-1640.4402,40.75351,0,0,0,0,100,0),
(@PATH,19,-12053.68,-1652.7511,43.139984,0,0,0,0,100,0),
(@PATH,20,-12060.942,-1668.3538,42.789413,0,0,0,0,100,0),
(@PATH,21,-12075.137,-1685.36,44.9919,0,0,0,0,100,0),
(@PATH,22,-12083.754,-1694.3141,47.727253,0,0,0,0,100,0),
(@PATH,23,-12081.199,-1711.9126,50.009007,0,0,0,0,100,0),
(@PATH,24,-12064.325,-1723.6598,48.64299,0,0,0,0,100,0);

SET @NPC := 49698;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-12066.406,`position_y`=-1786.6548,`position_z`=69.81737 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12066.406,-1786.6548,69.81737,0,0,0,0,100,0),
(@PATH,2,-12050.457,-1766.337,60.718105,0,0,0,0,100,0),
(@PATH,3,-12033.071,-1750.8512,55.646065,0,0,0,0,100,0),
(@PATH,4,-11999.78,-1753.2365,54.84094,0,0,0,0,100,0),
(@PATH,5,-11968.856,-1756.7726,53.229122,0,0,0,0,100,0),
(@PATH,6,-11956.396,-1766.9595,53.534046,0,0,0,0,100,0),
(@PATH,7,-11953.831,-1798.9094,53.284046,0,0,0,0,100,0),
(@PATH,8,-11955.532,-1833.0516,55.080914,0,0,0,0,100,0),
(@PATH,9,-11943.489,-1843.0251,56.276337,0,0,0,0,100,0),
(@PATH,10,-11922.226,-1844.5981,58.643448,0,0,0,0,100,0),
(@PATH,11,-11892.495,-1857.25,63.02691,0,0,0,0,100,0),
(@PATH,12,-11922.226,-1844.5981,58.643448,0,0,0,0,100,0),
(@PATH,13,-11943.489,-1843.0251,56.276337,0,0,0,0,100,0),
(@PATH,14,-11955.532,-1833.0516,55.080914,0,0,0,0,100,0),
(@PATH,15,-11953.831,-1798.9094,53.284046,0,0,0,0,100,0),
(@PATH,16,-11956.396,-1766.9595,53.534046,0,0,0,0,100,0),
(@PATH,17,-11968.856,-1756.7726,53.229122,0,0,0,0,100,0),
(@PATH,18,-11999.78,-1753.2365,54.84094,0,0,0,0,100,0),
(@PATH,19,-12033.071,-1750.8512,55.646065,0,0,0,0,100,0),
(@PATH,20,-12050.457,-1766.337,60.718105,0,0,0,0,100,0);

SET @NPC := 49760;
SET @NPC2 := 49756;
SET @path := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11938.328,`position_y`=-1819.2622,`position_z`=52.21226 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-11931.328,`position_y`=-1819.2622,`position_z`=52.21226 WHERE `guid`=@NPC2;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11938.328,-1819.2622,52.21226,0,0,0,0,100,0),
(@PATH,2,-11961.947,-1803.928,54.609234,0,0,0,0,100,0),
(@PATH,3,-11966.618,-1790.2196,54.229603,0,0,0,0,100,0),
(@PATH,4,-11968.503,-1770.5248,54.450214,0,0,0,0,100,0),
(@PATH,5,-11970.222,-1748.2112,53.054806,0,0,0,0,100,0),
(@PATH,6,-11982.738,-1744.707,54.054806,0,0,0,0,100,0),
(@PATH,7,-11992.345,-1765.0465,56.527462,0,0,0,0,100,0),
(@PATH,8,-11992.616,-1776.3724,57.829365,0,0,0,0,100,0),
(@PATH,9,-11990.501,-1798.2838,58.157246,0,0,0,0,100,0),
(@PATH,10,-11988.533,-1816.025,58.800465,0,0,0,0,100,0),
(@PATH,11,-11990.606,-1843.1467,58.96818,0,0,0,0,100,0),
(@PATH,12,-11988.533,-1816.025,58.800465,0,0,0,0,100,0),
(@PATH,13,-11990.501,-1798.2838,58.157246,0,0,0,0,100,0),
(@PATH,14,-11992.616,-1776.3724,57.829365,0,0,0,0,100,0),
(@PATH,15,-11992.345,-1765.0465,56.527462,0,0,0,0,100,0),
(@PATH,16,-11982.855,-1744.6752,54.016476,0,0,0,0,100,0),
(@PATH,17,-11970.222,-1748.2112,53.054806,0,0,0,0,100,0),
(@PATH,18,-11968.503,-1770.5248,54.450214,0,0,0,0,100,0),
(@PATH,19,-11966.618,-1790.2196,54.229603,0,0,0,0,100,0),
(@PATH,20,-11961.947,-1803.928,54.609234,0,0,0,0,100,0);

SET @NPC := 51947;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11977.521,`position_y`=-1753.175,`position_z`=52.679806 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11977.521,-1753.175,52.679806,0,0,0,0,100,0),
(@PATH,2,-11954.122,-1805.8005,52.859722,0,0,0,0,100,0),
(@PATH,3,-11931.607,-1808.4896,51.387363,0,0,0,0,100,0),
(@PATH,4,-11901.063,-1811.8312,51.262363,0,0,0,0,100,0),
(@PATH,5,-11865.95,-1811.2943,51.134724,0,0,0,0,100,0),
(@PATH,6,-11831.555,-1812.5005,51.024055,0,0,0,0,100,0),
(@PATH,7,-11818.492,-1834.661,50.14477,0,0,0,0,100,0),
(@PATH,8,-11804.356,-1849.8798,47.525387,0,0,0,0,100,0),
(@PATH,9,-11818.492,-1834.661,50.14477,0,0,0,0,100,0),
(@PATH,10,-11831.555,-1812.5005,51.024055,0,0,0,0,100,0),
(@PATH,11,-11865.95,-1811.2943,51.134724,0,0,0,0,100,0),
(@PATH,12,-11901.063,-1811.8312,51.262363,0,0,0,0,100,0),
(@PATH,13,-11931.607,-1808.4896,51.387363,0,0,0,0,100,0),
(@PATH,14,-11954.122,-1805.8005,52.859722,0,0,0,0,100,0),
(@PATH,15,-11957.259,-1768.3782,53.47521,0,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderguid` IN (49090, 49751, 49752, 49146, 49147, 49132, 49135, 49186, 49189, 52136, 49157, 49158, 49167, 49185, 51452, 49760);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
('49751', '49751', '0', '0', '515', '0', '0'),
('49751', '49752', '2', '270', '515', '0', '0'),
('49090', '49090', '0', '0', '515', '0', '0'),
('49090', '49091', '2', '90', '515', '0', '0'),
('49146', '49146', '0', '0', '515', '0', '0'),
('49146', '49145', '10', '165', '515', '0', '0'),
('49146', '49144', '10', '195', '515', '0', '0'),
('49146', '49143', '10', '185', '515', '0', '0'),
('49146', '49147', '10', '170', '515', '0', '0'),
('49132', '49132', '0', '0', '515', '0', '0'),
('49132', '49131', '2', '155', '515', '0', '0'),
('49132', '49133', '2', '205', '515', '0', '0'),
('49135', '49135', '0', '0', '515', '0', '0'),
('49135', '49136', '2', '205', '515', '0', '0'),
('49135', '49134', '2', '155', '515', '0', '0'),
('49186', '49186', '0', '0', '515', '0', '0'),
('49186', '49189', '5', '180', '515', '0', '0'),
('49186', '49188', '5', '205', '515', '0', '0'),
('49186', '49140', '5', '180', '515', '0', '0'),
('49186', '49139', '10', '205', '515', '0', '0'),
('49186', '49187', '10', '155', '515', '0', '0'),
('52136', '52136', '0', '0', '515', '0', '0'),
('52136', '52135', '10', '180', '515', '0', '0'),
('52136', '52137', '5', '205', '515', '0', '0'),
('52136', '52138', '5', '180', '515', '0', '0'),
('49158', '49157', '10', '205', '515', '0', '0'),
('49158', '49158', '0', '0', '515', '0', '0'),
('49158', '49156', '10', '180', '515', '0', '0'),
('49158', '49167', '5', '205', '515', '0', '0'),
('49158', '49185', '5', '180', '515', '0', '0'),
('51452', '51452', '0', '0', '515', '0', '0'),
('51452', '51451', '2', '90', '515', '0', '0'),
('49760', '49760', '0', '0', '515', '0', '0'),
('49760', '49756', '2', '90', '515', '0', '0');
