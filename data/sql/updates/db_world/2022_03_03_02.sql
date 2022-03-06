-- DB update 2022_03_03_01 -> 2022_03_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_03_01 2022_03_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645975153757743173'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645975153757743173');

-- Pathing for Banthar Entry: 18259
SET @NPC := 65529;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2304.6633,`position_y`=8590.539,`position_z`=-17.682453 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2304.6633,8590.539,-17.682453,0,0,0,0,100,0),
(@PATH,2,-2238.1865,8531.614,-16.504036,0,0,0,0,100,0),
(@PATH,3,-2214.0325,8503.077,-15.869347,0,0,0,0,100,0),
(@PATH,4,-2196.0647,8477.849,-17.184437,0,0,0,0,100,0),
(@PATH,5,-2183.5088,8437.967,-17.765284,0,0,0,0,100,0),
(@PATH,6,-2175.3252,8405.691,-17.435509,0,0,0,0,100,0),
(@PATH,7,-2168.435,8379.355,-17.653986,0,0,0,0,100,0),
(@PATH,8,-2158.4136,8351.16,-17.667555,0,0,0,0,100,0),
(@PATH,9,-2142.2913,8323.524,-20.222967,0,0,0,0,100,0),
(@PATH,10,-2124.5696,8293.215,-18.991814,0,0,0,0,100,0),
(@PATH,11,-2114.0486,8260.96,-18.402712,0,0,0,0,100,0),
(@PATH,12,-2117.1665,8229.137,-16.48296,0,0,0,0,100,0),
(@PATH,13,-2122.2034,8200.11,-17.955372,0,0,0,0,100,0),
(@PATH,14,-2139.851,8171.5044,-18.096193,0,0,0,0,100,0),
(@PATH,15,-2165.899,8138.905,-20.080093,0,0,0,0,100,0),
(@PATH,16,-2180.5254,8105.0444,-18.229433,0,0,0,0,100,0),
(@PATH,17,-2192.1646,8062.9897,-21.686302,0,0,0,0,100,0),
(@PATH,18,-2197.2551,8025.007,-19.048195,0,0,0,0,100,0),
(@PATH,19,-2211.6404,7978.1406,-21.625237,0,0,0,0,100,0),
(@PATH,20,-2207.2878,7935.608,-16.857744,0,0,0,0,100,0),
(@PATH,21,-2205.4485,7902.9297,-17.18866,0,0,0,0,100,0),
(@PATH,22,-2204.7727,7869.874,-19.780546,0,0,0,0,100,0),
(@PATH,23,-2210.2837,7842.8926,-18.695017,0,0,0,0,100,0),
(@PATH,24,-2228.4238,7811.7793,-24.324644,0,0,0,0,100,0),
(@PATH,25,-2246.3193,7784.558,-25.223425,0,0,0,0,100,0),
(@PATH,26,-2269.0632,7756.876,-23.582458,0,0,0,0,100,0),
(@PATH,27,-2290.9326,7737.725,-22.059143,0,0,0,0,100,0),
(@PATH,28,-2323.7734,7715.1763,-21.235,0,0,0,0,100,0),
(@PATH,29,-2360.7202,7704.8145,-18.896097,0,0,0,0,100,0),
(@PATH,30,-2395.369,7709.0635,-18.26944,0,0,0,0,100,0),
(@PATH,31,-2422.89,7720.6553,-18.262747,0,0,0,0,100,0),
(@PATH,32,-2446.803,7734.5044,-22.00119,0,0,0,0,100,0),
(@PATH,33,-2462.2644,7757.724,-28.858368,0,0,0,0,100,0),
(@PATH,34,-2470.068,7782.7173,-34.57561,0,0,0,0,100,0),
(@PATH,35,-2472.2207,7811.632,-40.764824,0,0,0,0,100,0),
(@PATH,36,-2473.1785,7843.1665,-45.795307,0,0,0,0,100,0),
(@PATH,37,-2473.3164,7880.185,-50.441868,0,0,0,0,100,0),
(@PATH,38,-2459.3994,7909.6665,-50.785633,0,0,0,0,100,0),
(@PATH,39,-2439.5835,7925.5625,-49.43688,0,0,0,0,100,0),
(@PATH,40,-2411.8616,7932.502,-47.427326,0,0,0,0,100,0),
(@PATH,41,-2375.9656,7930.991,-44.746113,0,0,0,0,100,0),
(@PATH,42,-2335.54,7940.52,-38.712055,0,0,0,0,100,0),
(@PATH,43,-2306.3477,7952.8193,-38.067398,0,0,0,0,100,0),
(@PATH,44,-2273.6055,7967.1235,-33.78349,0,0,0,0,100,0),
(@PATH,45,-2246.6472,7989.6016,-31.006058,0,0,0,0,100,0),
(@PATH,46,-2224.3364,8010.3003,-26.689152,0,0,0,0,100,0),
(@PATH,47,-2211.7158,8046.532,-23.972027,0,0,0,0,100,0),
(@PATH,48,-2199.9243,8081.3057,-24.48143,0,0,0,0,100,0),
(@PATH,49,-2190.9155,8115.8057,-19.85126,0,0,0,0,100,0),
(@PATH,50,-2187.9092,8143.1406,-21.898373,0,0,0,0,100,0),
(@PATH,51,-2180.554,8177.6006,-25.258144,0,0,0,0,100,0),
(@PATH,52,-2165.1025,8220.076,-22.41474,0,0,0,0,100,0),
(@PATH,53,-2161.4648,8247.288,-23.298136,0,0,0,0,100,0),
(@PATH,54,-2158.7192,8275.873,-20.404589,0,0,0,0,100,0),
(@PATH,55,-2160.1926,8310.674,-22.381659,0,0,0,0,100,0),
(@PATH,56,-2165.0535,8340.644,-19.399366,0,0,0,0,100,0),
(@PATH,57,-2172.1519,8375.965,-18.47503,0,0,0,0,100,0),
(@PATH,58,-2180.7483,8404.469,-18.611778,0,0,0,0,100,0),
(@PATH,59,-2199.4956,8446.634,-21.2344,0,0,0,0,100,0),
(@PATH,60,-2219.4893,8488.889,-17.746397,0,0,0,0,100,0),
(@PATH,61,-2235.893,8514.941,-19.960823,0,0,0,0,100,0),
(@PATH,62,-2253.9993,8544.553,-17.73443,0,0,0,0,100,0),
(@PATH,63,-2274.7415,8570.36,-19.668837,0,0,0,0,100,0),
(@PATH,64,-2300.7483,8592.389,-16.841389,0,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` IN (67981,67982,67983,67984,67985,67986);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(67981,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0),
(67982,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0),
(67983,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0),
(67984,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0),
(67985,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0),
(67986,18205,18205,19183,530,0,0,1,1,0,-2304.6633,8590.539,-17.682453,5.19985,300,20,0,0,0,1,0,0,0,'',0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=65529;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(65529,67981,40,180,512,0,0),
(65529,67982,45,170,512,0,0),
(65529,67983,55,180,512,0,0),
(65529,67984,60,190,512,0,0),
(65529,67985,60,170,512,0,0),
(65529,67986,70,180,512,0,0),
(65529,65529,0,0,0,0,0);

-- Pathing for Clefthoof Bull Entry: 17132
SET @NPC := 59983;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2533.302,`position_y`=7693.282,`position_z`=-22.522913 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2533.302,7693.282,-22.522913,0,0,0,0,100,0),
(@PATH,2,-2553.6506,7730.749,-31.743504,0,0,0,0,100,0),
(@PATH,3,-2585.2832,7754.329,-35.52054,0,0,0,0,100,0),
(@PATH,4,-2605.1836,7761.6216,-34.6365,0,0,0,0,100,0),
(@PATH,5,-2633.1926,7764.731,-35.44424,0,0,0,0,100,0),
(@PATH,6,-2658.154,7768.289,-37.24464,0,0,0,0,100,0),
(@PATH,7,-2676.8152,7764.5903,-33.81983,0,0,0,0,100,0),
(@PATH,8,-2702.7395,7765.48,-30.887325,0,0,0,0,100,0),
(@PATH,9,-2729.8606,7773.424,-31.201477,0,0,0,0,100,0),
(@PATH,10,-2757.8398,7778.987,-26.721565,0,0,0,0,100,0),
(@PATH,11,-2779.176,7780.721,-22.723583,0,0,0,0,100,0),
(@PATH,12,-2791.4631,7768.732,-17.764843,0,0,0,0,100,0),
(@PATH,13,-2799.9917,7749.6763,-14.350023,0,0,0,0,100,0),
(@PATH,14,-2790.899,7722.566,-13.857807,0,0,0,0,100,0),
(@PATH,15,-2780.0776,7692.03,-11.092861,0,0,0,0,100,0),
(@PATH,16,-2762.3145,7686.335,-13.705421,0,0,0,0,100,0),
(@PATH,17,-2724.3247,7682.152,-15.733696,0,0,0,0,100,0),
(@PATH,18,-2707.9124,7682.8506,-16.310234,0,0,0,0,100,0),
(@PATH,19,-2683.4045,7675.2407,-18.337666,0,0,0,0,100,0),
(@PATH,20,-2652.548,7668.7363,-15.603823,0,0,0,0,100,0),
(@PATH,21,-2634.3672,7663.3345,-15.451502,0,0,0,0,100,0),
(@PATH,22,-2608.3313,7653.4062,-14.048151,0,0,0,0,100,0),
(@PATH,23,-2588.2878,7644.2363,-11.940189,0,0,0,0,100,0),
(@PATH,24,-2559.9126,7643.0503,-13.315542,0,0,0,0,100,0),
(@PATH,25,-2528.9927,7671.0454,-18.712122,0,0,0,0,100,0);

UPDATE `creature` SET `id1`=18205,`id2`=18205,`id3`=19183,`wander_distance`=20,`MovementType`=1,`position_x`=-2533.302,`position_y`=7693.282,`position_z`=-22.522913 WHERE `guid` IN 
(65059,65060,68632,64966,64968,64964);

DELETE FROM `creature_formations` WHERE `leaderGUID`=59983;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(59983,65059,30,175,512,0,0),
(59983,65060,30,185,512,0,0),
(59983,68632,40,170,512,0,0),
(59983,64966,40,190,512,0,0),
(59983,64968,50,175,512,0,0),
(59983,64964,50,185,512,0,0),
(59983,59983,0,0,0,0,0);

-- Pathing for Clefthoof Bull Entry: 17132
SET @NPC := 59986;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2596.8586,`position_y`=7879.941,`position_z`=-53.312645 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2596.8586,7879.941,-53.312645,0,0,0,0,100,0),
(@PATH,2,-2577.3406,7878.849,-53.74563,0,0,0,0,100,0),
(@PATH,3,-2545.047,7880.1743,-53.221092,0,0,0,0,100,0),
(@PATH,4,-2519.8132,7878.178,-51.89135,0,0,0,0,100,0),
(@PATH,5,-2499.0688,7876.4565,-51.459812,0,0,0,0,100,0),
(@PATH,6,-2474.3381,7874.6226,-49.697727,0,0,0,0,100,0),
(@PATH,7,-2452.5474,7843.2397,-44.15914,0,0,0,0,100,0),
(@PATH,8,-2449.4407,7829.118,-41.01607,0,0,0,0,100,0),
(@PATH,9,-2465.209,7810.7915,-40.4941,0,0,0,0,100,0),
(@PATH,10,-2490.2166,7800.7734,-40.683647,0,0,0,0,100,0),
(@PATH,11,-2536.2388,7800.9297,-41.58805,0,0,0,0,100,0),
(@PATH,12,-2568.6865,7801.3003,-42.378574,0,0,0,0,100,0),
(@PATH,13,-2606.4966,7798.6797,-42.601906,0,0,0,0,100,0),
(@PATH,14,-2638.1658,7794.1816,-39.601818,0,0,0,0,100,0),
(@PATH,15,-2664.5,7793.514,-40.521618,0,0,0,0,100,0),
(@PATH,16,-2682.4878,7788.2334,-37.590588,0,0,0,0,100,0),
(@PATH,17,-2710.2444,7776.4634,-31.962097,0,0,0,0,100,0),
(@PATH,18,-2737.8286,7773.0728,-29.726936,0,0,0,0,100,0),
(@PATH,19,-2757.3389,7772.8423,-25.682259,0,0,0,0,100,0),
(@PATH,20,-2774.4548,7777.9062,-24.084301,0,0,0,0,100,0),
(@PATH,21,-2790.5278,7793.532,-19.102001,0,0,0,0,100,0),
(@PATH,22,-2795.0886,7807.404,-20.976631,0,0,0,0,100,0),
(@PATH,23,-2781.283,7843.6406,-29.445621,0,0,0,0,100,0),
(@PATH,24,-2747.1318,7856.2344,-34.94151,0,0,0,0,100,0),
(@PATH,25,-2727.8381,7860.8223,-39.785362,0,0,0,0,100,0),
(@PATH,26,-2709.9082,7862.58,-42.68844,0,0,0,0,100,0),
(@PATH,27,-2688.0955,7864.349,-43.76228,0,0,0,0,100,0),
(@PATH,28,-2668.5676,7869.8257,-46.57703,0,0,0,0,100,0),
(@PATH,29,-2641.4526,7874.388,-49.144367,0,0,0,0,100,0),
(@PATH,30,-2620.445,7876.6562,-50.049942,0,0,0,0,100,0);

UPDATE `creature` SET `id1`=18205,`id2`=18205,`id3`=19183,`wander_distance`=20,`MovementType`=1,`position_x`=-2596.8586,`position_y`=7879.941,`position_z`=-53.312645 WHERE `guid` IN 
(65053,65054,65055,65056,65057,65058);

DELETE FROM `creature_formations` WHERE `leaderGUID`=59986;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(59986,65053,30,180,512,0,0),
(59986,65054,42,170,512,0,0),
(59986,65055,42,180,512,0,0),
(59986,65056,42,190,512,0,0),
(59986,65057,54,175,512,0,0),
(59986,65058,54,185,512,0,0),
(59986,59986,0,0,0,0,0);

-- Pathing for Clefthoof Bull Entry: 17132
SET @NPC := 59987;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2578.9414,`position_y`=7762.349,`position_z`=-37.534943 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2578.9414,7762.349,-37.534943,0,0,0,0,100,0),
(@PATH,2,-2586.7644,7744.5166,-33.661896,0,0,0,0,100,0),
(@PATH,3,-2590.748,7730.0586,-30.613132,0,0,0,0,100,0),
(@PATH,4,-2598.2727,7715.291,-28.155369,0,0,0,0,100,0),
(@PATH,5,-2611.522,7703.527,-25.57359,0,0,0,0,100,0),
(@PATH,6,-2638.5435,7688.7993,-24.074404,0,0,0,0,100,0),
(@PATH,7,-2651.1284,7684.6353,-20.565248,0,0,0,0,100,0),
(@PATH,8,-2670.0498,7680.2085,-18.371601,0,0,0,0,100,0),
(@PATH,9,-2690.3179,7678.5767,-18.95412,0,0,0,0,100,0),
(@PATH,10,-2712.068,7675.7256,-14.362236,0,0,0,0,100,0),
(@PATH,11,-2734.9197,7671.612,-12.972755,0,0,0,0,100,0),
(@PATH,12,-2760.629,7666.6025,-12.264674,0,0,0,0,100,0),
(@PATH,13,-2773.4932,7672.673,-11.998867,0,0,0,0,100,0),
(@PATH,14,-2778.2664,7687.174,-10.676357,0,0,0,0,100,0),
(@PATH,15,-2780.5625,7711.0566,-13.682514,0,0,0,0,100,0),
(@PATH,16,-2763.271,7737.6997,-22.003496,0,0,0,0,100,0),
(@PATH,17,-2751.8052,7747.712,-22.909502,0,0,0,0,100,0),
(@PATH,18,-2722.5227,7767.6016,-31.008362,0,0,0,0,100,0),
(@PATH,19,-2693.1719,7784.7344,-34.61244,0,0,0,0,100,0),
(@PATH,20,-2677.3276,7797.483,-40.18922,0,0,0,0,100,0),
(@PATH,21,-2640.8176,7826.4106,-43.023987,0,0,0,0,100,0),
(@PATH,22,-2624.8872,7846.229,-45.856953,0,0,0,0,100,0),
(@PATH,23,-2603.595,7868.4575,-50.951797,0,0,0,0,100,0),
(@PATH,24,-2581.8499,7886.3066,-55.11355,0,0,0,0,100,0),
(@PATH,25,-2556.0244,7885.5547,-53.76455,0,0,0,0,100,0),
(@PATH,26,-2519.5852,7878.224,-51.89135,0,0,0,0,100,0),
(@PATH,27,-2513.2415,7835.933,-47.76302,0,0,0,0,100,0),
(@PATH,28,-2533.7297,7823.7163,-44.947548,0,0,0,0,100,0),
(@PATH,29,-2545.543,7812.9355,-44.16398,0,0,0,0,100,0),
(@PATH,30,-2559.6394,7793.0254,-41.994583,0,0,0,0,100,0),
(@PATH,31,-2569.683,7776.2397,-40.117737,0,0,0,0,100,0);

UPDATE `creature` SET `id1`=18205,`id2`=18205,`id3`=19183,`wander_distance`=20,`MovementType`=1,`position_x`=-2578.9414,`position_y`=7762.349,`position_z`=-37.534943 WHERE `guid` IN 
(68628,68629,68630,68631);

DELETE FROM `creature_formations` WHERE `leaderGUID`=59987;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(59987,68628,30,180,512,0,0),
(59987,68629,40,175,512,0,0),
(59987,68630,50,185,512,0,0),
(59987,68631,50,170,512,0,0),
(59987,59987,0,0,0,0,0);

-- Pathing for Clefthoof Bull Entry: 17132
SET @NPC := 59989;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2797.0994,`position_y`=7697.2676,`position_z`=-10.436611 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2797.0994,7697.2676,-10.436611,0,0,0,0,100,0),
(@PATH,2,-2727.4001,7695.3896,-17.447197,0,0,0,0,100,0),
(@PATH,3,-2708.3806,7693.6304,-18.84124,0,0,0,0,100,0),
(@PATH,4,-2680.809,7693.625,-22.966328,0,0,0,0,100,0),
(@PATH,5,-2660.809,7693.0537,-22.794008,0,0,0,0,100,0),
(@PATH,6,-2636.177,7661.4907,-14.666834,0,0,0,0,100,0),
(@PATH,7,-2625.7317,7649.991,-12.516657,0,0,0,0,100,0),
(@PATH,8,-2607.5283,7635.868,-11.063288,0,0,0,0,100,0),
(@PATH,9,-2588.1174,7624.233,-9.395568,0,0,0,0,100,0),
(@PATH,10,-2570.1436,7612.51,-7.2615347,0,0,0,0,100,0),
(@PATH,11,-2551.9316,7602.01,-6.1578865,0,0,0,0,100,0),
(@PATH,12,-2525.8398,7601.147,-3.2541418,0,0,0,0,100,0),
(@PATH,13,-2500.5813,7609.182,-4.518302,0,0,0,0,100,0),
(@PATH,14,-2482.001,7621.283,-3.962923,0,0,0,0,100,0),
(@PATH,15,-2462.0718,7645.233,-4.715763,0,0,0,0,100,0),
(@PATH,16,-2451.9604,7662.1475,-7.802433,0,0,0,0,100,0),
(@PATH,17,-2417.6992,7679.0728,-10.379824,0,0,0,0,100,0),
(@PATH,18,-2394.3352,7690.6226,-13.987774,0,0,0,0,100,0),
(@PATH,19,-2372.5056,7708.1206,-19.362457,0,0,0,0,100,0),
(@PATH,20,-2352.4834,7708.9385,-20.620584,0,0,0,0,100,0),
(@PATH,21,-2333.0408,7707.866,-19.005753,0,0,0,0,100,0),
(@PATH,22,-2311.089,7705.2144,-18.337418,0,0,0,0,100,0),
(@PATH,23,-2292.3855,7709.9316,-20.372202,0,0,0,0,100,0),
(@PATH,24,-2271.373,7723.4497,-21.240854,0,0,0,0,100,0),
(@PATH,25,-2247.1174,7722.5957,-18.88291,0,0,0,0,100,0),
(@PATH,26,-2232.8396,7715.0806,-15.940077,0,0,0,0,100,0),
(@PATH,27,-2221.7708,7694.014,-13.3185005,0,0,0,0,100,0),
(@PATH,28,-2214.6936,7668.578,-17.467182,0,0,0,0,100,0),
(@PATH,29,-2212.2493,7633.317,-19.078701,0,0,0,0,100,0),
(@PATH,30,-2234.8591,7619.432,-14.946472,0,0,0,0,100,0),
(@PATH,31,-2280.673,7612.316,-9.390898,0,0,0,0,100,0),
(@PATH,32,-2326.2031,7617.639,-4.569274,0,0,0,0,100,0),
(@PATH,33,-2348.732,7633.4443,-4.7594757,0,0,0,0,100,0),
(@PATH,34,-2374.6064,7665.9478,-7.890709,0,0,0,0,100,0),
(@PATH,35,-2398.8264,7686.5034,-12.567242,0,0,0,0,100,0),
(@PATH,36,-2423.7004,7711.1484,-16.356253,0,0,0,0,100,0),
(@PATH,37,-2448.448,7731.1963,-21.352123,0,0,0,0,100,0),
(@PATH,38,-2494.795,7730.725,-28.727377,0,0,0,0,100,0),
(@PATH,39,-2526.5425,7714.962,-25.670614,0,0,0,0,100,0),
(@PATH,40,-2547.6858,7723.041,-29.42783,0,0,0,0,100,0),
(@PATH,41,-2578.534,7726.413,-31.470188,0,0,0,0,100,0),
(@PATH,42,-2611.55,7725.3247,-29.26292,0,0,0,0,100,0),
(@PATH,43,-2641.7327,7721.828,-30.876842,0,0,0,0,100,0),
(@PATH,44,-2675.8582,7716.2847,-26.796625,0,0,0,0,100,0),
(@PATH,45,-2705.3887,7721.617,-25.325079,0,0,0,0,100,0),
(@PATH,46,-2734.3098,7731.452,-22.90813,0,0,0,0,100,0),
(@PATH,47,-2765.9993,7741.5415,-21.706133,0,0,0,0,100,0),
(@PATH,48,-2784.6272,7738.768,-17.414965,0,0,0,0,100,0),
(@PATH,49,-2797.3848,7719.631,-12.432514,0,0,0,0,100,0);

UPDATE `creature` SET `id1`=18205,`id2`=18205,`id3`=19183,`wander_distance`=20,`MovementType`=1,`position_x`=-2797.0994,`position_y`=7697.2676,`position_z`=-10.436611 WHERE `guid` IN 
(65048,65049,65050,65051,65052);

DELETE FROM `creature_formations` WHERE `leaderGUID`=59989;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(59989,65048,30,170,512,0,0),
(59989,65049,30,190,512,0,0),
(59989,65050,42,170,512,0,0),
(59989,65051,42,190,512,0,0),
(59989,65052,46,180,512,0,0),
(59989,59989,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_03_02' WHERE sql_rev = '1645975153757743173';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
