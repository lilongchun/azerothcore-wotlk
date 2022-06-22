SET @NPC := 49132;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-12317.01,position_y=-1447.9121,position_z=130.70255 WHERE guid=@NPC;
UPDATE creature SET wander_distance=0,MovementType=0,position_x=-12317.01,position_y=-1447.9121,position_z=130.70255 WHERE guid=49131;
UPDATE creature SET wander_distance=0,MovementType=0,position_x=-12317.01,position_y=-1447.9121,position_z=130.70255 WHERE guid=49133;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-12317.01,-1447.9121,130.70255,0,0,0,0,100,0),
(@path,2,-12294.435,-1452.9664,130.7252,0,0,0,0,100,0),
(@path,3,-12274.962,-1432.1677,130.7252,0,0,0,0,100,0),
(@path,4,-12251.229,-1419.3248,130.7252,0,0,0,0,100,0),
(@path,5,-12218.372,-1407.2831,131.82335,0,0,0,0,100,0),
(@path,6,-12251.229,-1419.3248,130.7252,0,0,0,0,100,0),
(@path,7,-12274.962,-1432.1677,130.7252,0,0,0,0,100,0),
(@path,8,-12294.435,-1452.9664,130.7252,0,0,0,0,100,0);

DELETE FROM `creature` WHERE (`id1` = 11372 AND guid = 49090) OR (`id1` = 11371 AND guid = 49090);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49090, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11862.2, -1317.21, 79.0372, 4.15388, 7200, 0, 0, 15260, 0, 0, 0, 0, 0, '', 0);

SET @NPC := 49090;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11874.843,position_y=-1325.8516,position_z=78.68711 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
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
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11966.846,position_y=-1528.8047,position_z=41.97195 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
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
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11915.182,position_y=-1309.0254,position_z=77.85016 WHERE guid=@NPC;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11917.182,position_y=-1309.0254,position_z=77.85016 WHERE guid=@NPC2;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id IN (@path,@path2);
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
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
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-12051.524,position_y=-1427.2681,position_z=130.14175 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-12051.524,-1427.2681,130.14175,0,0,0,0,100,0),
(@path,2,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0),
(@path,3,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@path,4,-12076.898,-1450.6375,130.39133,0,0,0,0,100,0),
(@path,5,-12088.711,-1450.2057,130.85104,0,0,0,0,400,0),
(@path,6,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@path,7,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0);

SET @NPC := 49135;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-12207.685,position_y=-1462.47,position_z=131.32281 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-12207.685,-1462.47,131.32281,0,0,0,0,100,0),
(@path,2,-12245.68,-1474.5807,130.62447,0,0,0,0,100,0),
(@path,3,-12272.678,-1484.2139,130.7252,0,0,0,0,100,0),
(@path,4,-12291.434,-1475.9297,130.7252,0,0,0,0,100,0),
(@path,5,-12312.472,-1457.0942,130.70255,0,0,0,0,100,0),
(@path,6,-12291.434,-1475.9297,130.7252,0,0,0,0,100,0),
(@path,7,-12272.678,-1484.2139,130.7252,0,0,0,0,100,0),
(@path,8,-12245.68,-1474.5807,130.62447,0,0,0,0,100,0);
 
SET @NPC := 49186;
SET @path := @NPC * 10;
SET @NPC2 := 49189;
SET @NPC3 := 49188;
SET @NPC4 := 49187;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-12139.658,position_y=-1462.6881,position_z=130.72519 WHERE guid=@NPC;
UPDATE creature SET wander_distance=0,MovementType=0,position_x=-12139.658,position_y=-1462.6881,position_z=130.72519 WHERE guid=@NPC2;
UPDATE creature SET wander_distance=0,MovementType=0,position_x=-12139.658,position_y=-1462.6881,position_z=130.72519 WHERE guid=@NPC3;
UPDATE creature SET wander_distance=0,MovementType=0,position_x=-12139.658,position_y=-1462.6881,position_z=130.72519 WHERE guid=@NPC4;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-12139.658,-1462.6881,130.72519,0,0,0,0,100,0),
(@path,2,-12145.165,-1472.5826,130.72519,0,0,0,0,100,0),
(@path,3,-12150.585,-1480.6031,130.72519,0,0,0,0,100,0),
(@path,4,-12155.898,-1487.2714,130.88535,0,0,0,0,100,0),
(@path,5,-12162.413,-1488.4478,130.95273,0,0,0,0,100,0),
(@path,6,-12166.849,-1484.3025,130.72519,0,0,0,0,100,0),
(@path,7,-12169.933,-1475.3961,130.72519,0,0,0,0,100,0),
(@path,8,-12168.736,-1461.0402,130.72519,0,0,0,0,100,0),
(@path,9,-12165.8,-1451.5284,131.1915,0,0,0,0,100,0),
(@path,10,-12159.837,-1446.8896,131.52573,0,0,0,0,100,0),
(@path,11,-12154.368,-1448.3627,131.15585,0,0,0,0,100,0),
(@path,12,-12148.044,-1460.6128,130.72519,0,0,0,0,100,0),
(@path,13,-12142.502,-1469.3756,130.72519,0,0,0,0,100,0),
(@path,14,-12139.423,-1477.193,130.72519,0,0,0,0,100,0),
(@path,15,-12142.655,-1487.7107,130.81308,0,0,0,0,100,0),
(@path,16,-12150.853,-1489.0536,131.22275,0,0,0,0,100,0),
(@path,17,-12157.748,-1478.774,130.72519,0,0,0,0,100,0),
(@path,18,-12158.351,-1465.1509,131.22519,0,0,0,0,100,0),
(@path,19,-12156.007,-1450.0975,130.72519,0,0,0,0,100,0),
(@path,20,-12153.582,-1446.1135,131.67294,0,0,0,0,100,0),
(@path,21,-12146.194,-1444.6774,132.9537,0,0,0,0,100,0),
(@path,22,-12139.783,-1452.6754,130.72519,0,0,0,0,100,0);
 
DELETE FROM `creature_formations` WHERE `leaderguid` IN (49090, 49751, 49752, 49146, 49147, 49132, 49135, 49186, 49189);
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
('49186', '49187', '5', '155', '515', '0', '0');
