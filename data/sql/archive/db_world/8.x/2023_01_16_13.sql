-- DB update 2023_01_16_12 -> 2023_01_16_13
-- Road Patrols
DELETE FROM `creature_addon` WHERE `guid` IN (31799, 48021, 48022, 31931, 47895, 47896, 38497, 48008, 48009, 38051, 48006, 48007, 40161, 48010, 48011);
DELETE FROM `waypoint_data` WHERE `id` IN (317990, 319310, 384970, 380510, 401610);
-- Delete extra patrol
DELETE FROM `creature` WHERE `guid` IN (40161, 48010, 48011) AND `id1` IN (17814, 17815) AND `map`=560;

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (31799, 31931, 38497, 38051, 40161) AND `memberGUID` IN (31799, 48021, 48022, 31931, 47895, 47896, 38497, 48008, 48009, 38051, 48006, 48007, 40161, 48010, 48011);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(31799, 31799, 0, 0, 3, 0, 0),
(31799, 48021, 1.75, 90, 515, 0, 0),
(31799, 48022, 1.75, 180, 515, 0, 0),
(31931, 31931, 0, 0, 3, 0, 0),
(31931, 47895, 1.75, 90, 515, 0, 0),
(31931, 47896, 1.75, 180, 515, 0, 0),
(38497, 38497, 0, 0, 3, 0, 0),
(38497, 48008, 1.75, 90, 515, 0, 0),
(38497, 48009, 1.75, 180, 515, 0, 0),
(38051, 38051, 0, 0, 3, 0, 0),
(38051, 48006, 1.75, 90, 515, 0, 0),
(38051, 48007, 1.75, 180, 515, 0, 0);

-- Pathing for Lordaeron Sentry Entry: 17815
SET @NPC := 31799;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2639.2786,`position_y`=706.2916,`position_z`=56.133114 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=2639.2786,`position_y`=706.2916,`position_z`=56.133114 WHERE `guid` IN (48021, 48022);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2639.2786,706.2916,56.133114,NULL,0,0,0,100,0),
(@PATH,2,2616.6555,732.495,55.542076,NULL,0,0,0,100,0),
(@PATH,3,2616.41,765.8051,56.669064,NULL,0,0,0,100,0),
(@PATH,4,2650.6904,800.4463,59.137634,NULL,0,0,0,100,0),
(@PATH,5,2645.4395,837.0351,62.076283,NULL,0,0,0,100,0),
(@PATH,6,2648.8286,886.3763,70.00796,NULL,0,0,0,100,0),
(@PATH,7,2600.0872,881.9358,67.97554,NULL,0,0,0,100,0),
(@PATH,8,2566.5989,885.267,66.26084,NULL,0,0,0,100,0),
(@PATH,9,2533.3198,884.6279,64.76201,NULL,0,0,0,100,0),
(@PATH,10,2499.9165,883.73254,63.793438,NULL,0,0,0,100,0),
(@PATH,11,2466.53,879.13196,62.80923,NULL,0,0,0,100,0),
(@PATH,12,2433.3486,873.20294,60.26077,NULL,0,0,0,100,0),
(@PATH,13,2399.923,862.7437,56.950455,NULL,0,0,0,100,0),
(@PATH,14,2366.6465,852.4082,55.597023,NULL,0,0,0,100,0),
(@PATH,15,2333.3254,841.0766,53.795734,NULL,0,0,0,100,0),
(@PATH,16,2300.101,827.1956,54.24242,NULL,0,0,0,100,0),
(@PATH,17,2283.6602,818.24945,54.681904,NULL,0,0,0,100,0),
(@PATH,18,2284.8774,833.2363,54.8091,NULL,0,0,0,100,0),
(@PATH,19,2280.072,866.58215,54.552338,NULL,0,0,0,100,0),
(@PATH,20,2268.029,899.95184,54.603855,NULL,0,0,0,100,0),
(@PATH,21,2255.4045,933.2042,54.619514,NULL,0,0,0,100,0),
(@PATH,22,2243.007,966.4714,54.54609,NULL,0,0,0,100,0),
(@PATH,23,2235.5574,999.86285,54.35434,NULL,0,0,0,100,0),
(@PATH,24,2230.9585,1017.2498,53.66352,NULL,0,0,0,100,0),
(@PATH,25,2199.8667,1023.1483,49.129005,NULL,0,0,0,100,0),
(@PATH,26,2166.743,1033.4891,43.4606,NULL,0,0,0,100,0),
(@PATH,27,2133.375,1041.0846,38.1891,NULL,0,0,0,100,0),
(@PATH,28,2099.997,1032.463,33.053593,NULL,0,0,0,100,0),
(@PATH,29,2066.678,1023.6782,31.649784,NULL,0,0,0,100,0),
(@PATH,30,2033.1595,1036.842,27.260267,NULL,0,0,0,100,0),
(@PATH,31,2000.1263,1039.048,25.368788,NULL,0,0,0,100,0),
(@PATH,32,1976.1582,1029.0402,24.877884,NULL,0,0,0,100,0),
(@PATH,33,1933.9054,1053.6482,20.207039,NULL,0,0,0,100,0),
(@PATH,34,1900.0455,1053.6002,17.663145,NULL,0,0,0,100,0),
(@PATH,35,1866.7896,1066.5774,16.247551,NULL,0,0,0,100,0),
(@PATH,36,1833.5148,1078.4152,11.905301,NULL,0,0,0,100,0),
(@PATH,37,1800.0416,1062.003,8.49329,NULL,0,0,0,100,0),
(@PATH,38,1833.5148,1078.4152,11.905301,NULL,0,0,0,100,0),
(@PATH,39,1866.7896,1066.5774,16.247551,NULL,0,0,0,100,0),
(@PATH,40,1900.0455,1053.6002,17.663145,NULL,0,0,0,100,0),
(@PATH,41,1933.9054,1053.6482,20.207039,NULL,0,0,0,100,0),
(@PATH,42,1976.1582,1029.0402,24.877884,NULL,0,0,0,100,0),
(@PATH,43,2000.1263,1039.048,25.368788,NULL,0,0,0,100,0),
(@PATH,44,2033.1595,1036.842,27.260267,NULL,0,0,0,100,0),
(@PATH,45,2066.663,1023.69336,31.66946,NULL,0,0,0,100,0),
(@PATH,46,2099.997,1032.463,33.053593,NULL,0,0,0,100,0),
(@PATH,47,2133.375,1041.0846,38.1891,NULL,0,0,0,100,0),
(@PATH,48,2166.743,1033.4891,43.4606,NULL,0,0,0,100,0),
(@PATH,49,2199.8667,1023.1483,49.129005,NULL,0,0,0,100,0),
(@PATH,50,2230.9585,1017.2498,53.66352,NULL,0,0,0,100,0),
(@PATH,51,2235.5574,999.86285,54.35434,NULL,0,0,0,100,0),
(@PATH,52,2243.007,966.4714,54.54609,NULL,0,0,0,100,0),
(@PATH,53,2255.4045,933.2042,54.619514,NULL,0,0,0,100,0),
(@PATH,54,2268.029,899.95184,54.603855,NULL,0,0,0,100,0),
(@PATH,55,2280.072,866.58215,54.552338,NULL,0,0,0,100,0),
(@PATH,56,2284.8774,833.2363,54.8091,NULL,0,0,0,100,0),
(@PATH,57,2283.6602,818.24945,54.681904,NULL,0,0,0,100,0),
(@PATH,58,2300.101,827.1956,54.24242,NULL,0,0,0,100,0),
(@PATH,59,2333.3254,841.0766,53.795734,NULL,0,0,0,100,0),
(@PATH,60,2366.6465,852.4082,55.597023,NULL,0,0,0,100,0),
(@PATH,61,2399.923,862.7437,56.950455,NULL,0,0,0,100,0),
(@PATH,62,2433.3486,873.20294,60.26077,NULL,0,0,0,100,0),
(@PATH,63,2466.53,879.13196,62.80923,NULL,0,0,0,100,0),
(@PATH,64,2499.9165,883.73254,63.793438,NULL,0,0,0,100,0),
(@PATH,65,2533.3198,884.6279,64.76201,NULL,0,0,0,100,0),
(@PATH,66,2566.5989,885.267,66.26084,NULL,0,0,0,100,0),
(@PATH,67,2600.0872,881.9358,67.97554,NULL,0,0,0,100,0),
(@PATH,68,2648.8286,886.3763,70.00796,NULL,0,0,0,100,0),
(@PATH,69,2645.4395,837.0351,62.076283,NULL,0,0,0,100,0),
(@PATH,70,2650.6904,800.4463,59.137634,NULL,0,0,0,100,0),
(@PATH,71,2616.41,765.8051,56.669064,NULL,0,0,0,100,0),
(@PATH,72,2616.6555,732.495,55.542076,NULL,0,0,0,100,0);
-- 0x20422046001165C000581A0003A0F8E1 .go xyz 2639.2786 706.2916 56.133114

-- Pathing for Lordaeron Sentry Entry: 17815
SET @NPC := 38497;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1785.1494,`position_y`=1059.7461,`position_z`=7.4997754 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1785.1494,`position_y`=1059.7461,`position_z`=7.4997754 WHERE `guid` IN (48008, 48009);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1785.1494,1059.7461,7.4997754,NULL,0,0,0,100,0),
(@PATH,2,1807.9244,1066.7906,9.400806,NULL,0,0,0,100,0),
(@PATH,3,1833.5851,1077.7472,11.993924,NULL,0,0,0,100,0),
(@PATH,4,1866.4275,1066.9388,16.172268,NULL,0,0,0,100,0),
(@PATH,5,1899.988,1052.5074,17.993156,NULL,0,0,0,100,0),
(@PATH,6,1933.4088,1052.1146,20.207039,NULL,0,0,0,100,0),
(@PATH,7,1970.9503,1029.3729,24.414505,NULL,0,0,0,100,0),
(@PATH,8,1999.967,1037.368,25.487244,NULL,0,0,0,100,0),
(@PATH,9,2033.0857,1036.158,27.342299,NULL,0,0,0,100,0),
(@PATH,10,2066.437,1023.7202,31.66946,NULL,0,0,0,100,0),
(@PATH,11,2099.8337,1031.154,33.053593,NULL,0,0,0,100,0),
(@PATH,12,2133.2314,1040.4186,38.0768,NULL,0,0,0,100,0),
(@PATH,13,2166.5674,1033.6455,43.496593,NULL,0,0,0,100,0),
(@PATH,14,2199.9133,1022.7056,49.13462,NULL,0,0,0,100,0),
(@PATH,15,2231.8333,1014.5566,53.61164,NULL,0,0,0,100,0),
(@PATH,16,2243.3503,966.83356,54.525482,NULL,0,0,0,100,0),
(@PATH,17,2255.3577,933.4627,54.54609,NULL,0,0,0,100,0),
(@PATH,18,2267.9368,900.0089,54.510963,NULL,0,0,0,100,0),
(@PATH,19,2280.2844,866.7419,54.603855,NULL,0,0,0,100,0),
(@PATH,20,2285.292,833.3753,54.75473,NULL,0,0,0,100,0),
(@PATH,21,2282.0686,815.46246,54.681904,NULL,0,0,0,100,0),
(@PATH,22,2300.1846,827.1603,54.24242,NULL,0,0,0,100,0),
(@PATH,23,2333.4233,840.40344,53.847023,NULL,0,0,0,100,0),
(@PATH,24,2366.681,853.4108,55.733658,NULL,0,0,0,100,0),
(@PATH,25,2399.9805,862.44415,56.983658,NULL,0,0,0,100,0),
(@PATH,26,2433.5442,872.9633,60.284206,NULL,0,0,0,100,0),
(@PATH,27,2466.7537,879.08453,62.865704,NULL,0,0,0,100,0),
(@PATH,28,2500.209,883.5788,63.762005,NULL,0,0,0,100,0),
(@PATH,29,2533.5017,884.79144,64.7772,NULL,0,0,0,100,0),
(@PATH,30,2566.761,886.15063,66.18087,NULL,0,0,0,100,0),
(@PATH,31,2600.0027,881.77625,67.96541,NULL,0,0,0,100,0),
(@PATH,32,2633.4114,884.50476,69.28347,NULL,0,0,0,100,0),
(@PATH,33,2648.6272,887.2003,70.106834,NULL,0,0,0,100,0),
(@PATH,34,2648.1772,866.70953,67.11697,NULL,0,0,0,100,0),
(@PATH,35,2643.4717,833.34406,61.376575,NULL,0,0,0,100,0),
(@PATH,36,2649.929,800.1507,59.19159,NULL,0,0,0,100,0),
(@PATH,37,2633.398,781.11884,57.6461,NULL,0,0,0,100,0),
(@PATH,38,2614.7578,766.58716,56.59582,NULL,0,0,0,100,0),
(@PATH,39,2614.6687,733.4032,55.637325,NULL,0,0,0,100,0),
(@PATH,40,2638.3074,707.1444,56.133114,NULL,0,0,0,100,0),
(@PATH,41,2614.6687,733.4032,55.637325,NULL,0,0,0,100,0),
(@PATH,42,2614.7578,766.58716,56.59582,NULL,0,0,0,100,0),
(@PATH,43,2633.398,781.11884,57.6461,NULL,0,0,0,100,0),
(@PATH,44,2649.929,800.1507,59.19159,NULL,0,0,0,100,0),
(@PATH,45,2643.4717,833.34406,61.376575,NULL,0,0,0,100,0),
(@PATH,46,2648.1772,866.70953,67.11697,NULL,0,0,0,100,0),
(@PATH,47,2648.6272,887.2003,70.106834,NULL,0,0,0,100,0),
(@PATH,48,2633.4114,884.50476,69.28347,NULL,0,0,0,100,0),
(@PATH,49,2600.0027,881.77625,67.96541,NULL,0,0,0,100,0),
(@PATH,50,2566.761,886.15063,66.18087,NULL,0,0,0,100,0),
(@PATH,51,2533.5017,884.79144,64.7772,NULL,0,0,0,100,0),
(@PATH,52,2500.209,883.5788,63.762005,NULL,0,0,0,100,0),
(@PATH,53,2466.7537,879.08453,62.865704,NULL,0,0,0,100,0),
(@PATH,54,2433.5442,872.9633,60.284206,NULL,0,0,0,100,0),
(@PATH,55,2399.9805,862.44415,56.983658,NULL,0,0,0,100,0),
(@PATH,56,2366.681,853.4108,55.733658,NULL,0,0,0,100,0),
(@PATH,57,2333.4233,840.40344,53.847023,NULL,0,0,0,100,0),
(@PATH,58,2300.1846,827.1603,54.24242,NULL,0,0,0,100,0),
(@PATH,59,2282.0686,815.46246,54.681904,NULL,0,0,0,100,0),
(@PATH,60,2285.292,833.3753,54.75473,NULL,0,0,0,100,0),
(@PATH,61,2280.2844,866.7419,54.603855,NULL,0,0,0,100,0),
(@PATH,62,2267.9368,900.0089,54.510963,NULL,0,0,0,100,0),
(@PATH,63,2255.3577,933.4627,54.54609,NULL,0,0,0,100,0),
(@PATH,64,2243.3503,966.83356,54.525482,NULL,0,0,0,100,0),
(@PATH,65,2231.8333,1014.5566,53.61164,NULL,0,0,0,100,0),
(@PATH,66,2199.9133,1022.7056,49.13462,NULL,0,0,0,100,0),
(@PATH,67,2166.5674,1033.6455,43.496593,NULL,0,0,0,100,0),
(@PATH,68,2133.2314,1040.4186,38.0768,NULL,0,0,0,100,0),
(@PATH,69,2099.8337,1031.154,33.053593,NULL,0,0,0,100,0),
(@PATH,70,2066.437,1023.7202,31.66946,NULL,0,0,0,100,0),
(@PATH,71,2033.0857,1036.158,27.342299,NULL,0,0,0,100,0),
(@PATH,72,1999.967,1037.368,25.487244,NULL,0,0,0,100,0),
(@PATH,73,1970.9503,1029.3729,24.414505,NULL,0,0,0,100,0),
(@PATH,74,1933.4088,1052.1146,20.207039,NULL,0,0,0,100,0),
(@PATH,75,1899.988,1052.5074,17.993156,NULL,0,0,0,100,0),
(@PATH,76,1866.4275,1066.9388,16.172268,NULL,0,0,0,100,0),
(@PATH,77,1833.5851,1077.7472,11.993924,NULL,0,0,0,100,0),
(@PATH,78,1807.9244,1066.7906,9.400806,NULL,0,0,0,100,0);
-- 0x20422046001165C000581A0002A0F8E1 .go xyz 1785.1494 1059.7461 7.4997754

-- Pathing for Lordaeron Sentry Entry: 17815
SET @NPC := 38051;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1915.2782,`position_y`=166.88997,`position_z`=66.420334 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1915.2782,`position_y`=166.88997,`position_z`=66.420334 WHERE `guid` IN (48006, 48007);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,1915.2782,166.88997,66.420334,NULL,0,0,0,100,0),
(@PATH,2 ,1933.3627,199.43684,68.55553,NULL,0,0,0,100,0),
(@PATH,3 ,1958.7087,233.44987,68.25363,NULL,0,0,0,100,0),
(@PATH,4 ,1985.3677,266.538,67.274605,NULL,0,0,0,100,0),
(@PATH,5 ,2008.4141,299.949,66.5921,NULL,0,0,0,100,0),
(@PATH,6 ,2029.3097,333.36285,66.2039,NULL,0,0,0,100,0),
(@PATH,7 ,2046.5256,366.8134,66.07941,NULL,0,0,0,100,0),
(@PATH,8 ,2061.7188,399.7105,66.07941,NULL,0,0,0,100,0),
(@PATH,9 ,2075.2612,433.4388,66.35451,NULL,0,0,0,100,0),
(@PATH,10,2085.227,466.7322,65.99344,NULL,0,0,0,100,0),
(@PATH,11,2100.293,499.89203,61.793736,NULL,0,0,0,100,0),
(@PATH,12,2134.9597,533.3772,55.160877,NULL,0,0,0,100,0),
(@PATH,13,2160.3733,566.7977,46.943867,NULL,0,0,0,100,0),
(@PATH,14,2169.0386,599.9322,40.813835,NULL,0,0,0,100,0),
(@PATH,15,2173.1648,633.4348,34.61213,NULL,0,0,0,100,0),
(@PATH,16,2182.9766,670.1759,33.942467,NULL,0,0,0,100,0),
(@PATH,17,2195.8901,700.02814,37.097427,NULL,0,0,0,100,0),
(@PATH,18,2220.6614,733.39703,45.14522,NULL,0,0,0,100,0),
(@PATH,19,2248.9954,766.6798,52.944767,NULL,0,0,0,100,0),
(@PATH,20,2272.683,800.09247,54.556904,NULL,0,0,0,100,0),
(@PATH,21,2285.5388,833.2577,54.729755,NULL,0,0,0,100,0),
(@PATH,22,2279.4978,866.8086,54.603855,NULL,0,0,0,100,0),
(@PATH,23,2267.4993,899.9578,54.603855,NULL,0,0,0,100,0),
(@PATH,24,2255.1328,933.5135,54.54609,NULL,0,0,0,100,0),
(@PATH,25,2242.963,966.8592,54.525482,NULL,0,0,0,100,0),
(@PATH,26,2234.5244,1000.2554,54.37835,NULL,0,0,0,100,0),
(@PATH,27,2228.6057,1033.3921,53.29277,NULL,0,0,0,100,0),
(@PATH,28,2226.4805,1066.674,50.751965,NULL,0,0,0,100,0),
(@PATH,29,2225.1138,1100.0208,47.501396,NULL,0,0,0,100,0),
(@PATH,30,2219.279,1133.2515,47.441338,NULL,0,0,0,100,0),
(@PATH,31,2203.438,1166.5723,47.441338,NULL,0,0,0,100,0),
(@PATH,32,2177.0708,1201.5569,47.477154,NULL,0,0,0,100,0),
(@PATH,33,2158.344,1227.1785,47.322506,NULL,0,0,0,100,0),
(@PATH,34,2177.0708,1201.5569,47.477154,NULL,0,0,0,100,0),
(@PATH,35,2203.438,1166.5723,47.441338,NULL,0,0,0,100,0),
(@PATH,36,2219.279,1133.2515,47.441338,NULL,0,0,0,100,0),
(@PATH,37,2225.1138,1100.0208,47.501396,NULL,0,0,0,100,0),
(@PATH,38,2226.4805,1066.674,50.751965,NULL,0,0,0,100,0),
(@PATH,39,2228.6057,1033.3921,53.29277,NULL,0,0,0,100,0),
(@PATH,40,2234.5244,1000.2554,54.37835,NULL,0,0,0,100,0),
(@PATH,41,2242.963,966.8592,54.525482,NULL,0,0,0,100,0),
(@PATH,42,2255.1328,933.5135,54.54609,NULL,0,0,0,100,0),
(@PATH,43,2267.4993,899.9578,54.603855,NULL,0,0,0,100,0),
(@PATH,44,2279.4978,866.8086,54.603855,NULL,0,0,0,100,0),
(@PATH,45,2285.5388,833.2577,54.729755,NULL,0,0,0,100,0),
(@PATH,46,2272.683,800.09247,54.556904,NULL,0,0,0,100,0),
(@PATH,47,2248.9954,766.6798,52.944767,NULL,0,0,0,100,0),
(@PATH,48,2220.6614,733.39703,45.14522,NULL,0,0,0,100,0),
(@PATH,49,2195.8901,700.02814,37.097427,NULL,0,0,0,100,0),
(@PATH,50,2182.9766,670.1759,33.942467,NULL,0,0,0,100,0),
(@PATH,51,2173.1648,633.4348,34.61213,NULL,0,0,0,100,0),
(@PATH,52,2169.0386,599.9322,40.813835,NULL,0,0,0,100,0),
(@PATH,53,2160.3733,566.7977,46.943867,NULL,0,0,0,100,0),
(@PATH,54,2134.9597,533.3772,55.160877,NULL,0,0,0,100,0),
(@PATH,55,2100.293,499.89203,61.793736,NULL,0,0,0,100,0),
(@PATH,56,2085.227,466.7322,65.99344,NULL,0,0,0,100,0),
(@PATH,57,2075.2612,433.4388,66.35451,NULL,0,0,0,100,0),
(@PATH,58,2061.7188,399.7105,66.07941,NULL,0,0,0,100,0),
(@PATH,59,2046.5256,366.8134,66.07941,NULL,0,0,0,100,0),
(@PATH,60,2029.3097,333.36285,66.2039,NULL,0,0,0,100,0),
(@PATH,61,2008.4141,299.949,66.5921,NULL,0,0,0,100,0),
(@PATH,62,1985.3677,266.538,67.274605,NULL,0,0,0,100,0),
(@PATH,63,1958.7087,233.44987,68.25363,NULL,0,0,0,100,0),
(@PATH,64,1933.3627,199.43684,68.55553,NULL,0,0,0,100,0);
-- 0x20422046001165C000581A000120F8E2 .go xyz 2158.344 1227.1785 47.322506

-- Pathing for Lordaeron Sentry Entry: 17815
SET @NPC := 31931;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2103.3918,`position_y`=1333.9415,`position_z`=47.345947 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=2103.3918,`position_y`=1333.9415,`position_z`=47.345947 WHERE `guid` IN (47895, 47896);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,2103.3918,1333.9415,47.345947,NULL,0,0,0,100,0),
(@PATH,2 ,2117.1653,1300.0837,47.25368,NULL,0,0,0,100,0),
(@PATH,3 ,2135.3755,1266.5591,47.416084,NULL,0,0,0,100,0),
(@PATH,4 ,2154.008,1233.5289,47.247627,NULL,0,0,0,100,0),
(@PATH,5 ,2177.5837,1199.9348,47.366386,NULL,0,0,0,100,0),
(@PATH,6 ,2204.2024,1165.6702,47.441338,NULL,0,0,0,100,0),
(@PATH,7 ,2219.0212,1133.3259,47.441338,NULL,0,0,0,100,0),
(@PATH,8 ,2226.034,1100.0942,47.492607,NULL,0,0,0,100,0),
(@PATH,9 ,2226.6536,1066.845,50.731457,NULL,0,0,0,100,0),
(@PATH,10,2229.4927,1033.4387,53.074142,NULL,0,0,0,100,0),
(@PATH,11,2235.451,1000.4372,54.37835,NULL,0,0,0,100,0),
(@PATH,12,2242.72,966.7881,54.525482,NULL,0,0,0,100,0),
(@PATH,13,2254.9116,933.2465,54.619514,NULL,0,0,0,100,0),
(@PATH,14,2267.9587,899.9565,54.603855,NULL,0,0,0,100,0),
(@PATH,15,2279.7522,866.7176,54.603855,NULL,0,0,0,100,0),
(@PATH,16,2285.8884,833.4665,54.683197,NULL,0,0,0,100,0),
(@PATH,17,2271.3103,800.17786,54.556904,NULL,0,0,0,100,0),
(@PATH,18,2248.9385,766.28796,52.92477,NULL,0,0,0,100,0),
(@PATH,19,2222.6885,733.4756,45.53316,NULL,0,0,0,100,0),
(@PATH,20,2199.9814,705.9134,38.45436,NULL,0,0,0,100,0),
(@PATH,21,2183.4436,671.9523,34.047813,NULL,0,0,0,100,0),
(@PATH,22,2173.2122,633.11383,34.746147,NULL,0,0,0,100,0),
(@PATH,23,2169.0981,599.8944,40.806755,NULL,0,0,0,100,0),
(@PATH,24,2160.8425,566.8087,46.886005,NULL,0,0,0,100,0),
(@PATH,25,2133.9849,533.43677,55.27074,NULL,0,0,0,100,0),
(@PATH,26,2102.682,500.0803,61.526283,NULL,0,0,0,100,0),
(@PATH,27,2085.1711,466.63803,66.07155,NULL,0,0,0,100,0),
(@PATH,28,2079.1477,443.0053,66.22951,NULL,0,0,0,100,0),
(@PATH,29,2062.3293,400.23102,66.18985,NULL,0,0,0,100,0),
(@PATH,30,2046.4001,366.72775,66.07941,NULL,0,0,0,100,0),
(@PATH,31,2030.5328,333.3761,66.2039,NULL,0,0,0,100,0),
(@PATH,32,2011.089,300.02844,66.1958,NULL,0,0,0,100,0),
(@PATH,33,1986.6836,266.5842,67.274605,NULL,0,0,0,100,0),
(@PATH,34,1962.4227,233.44661,67.80795,NULL,0,0,0,100,0),
(@PATH,35,1933.4548,199.38693,68.54942,NULL,0,0,0,100,0),
(@PATH,36,1915.0591,166.63585,66.27286,NULL,0,0,0,100,0),
(@PATH,37,1909.7109,154.14236,65.70743,NULL,0,0,0,100,0),
(@PATH,38,1915.0591,166.63585,66.27286,NULL,0,0,0,100,0),
(@PATH,39,1933.4548,199.38693,68.54942,NULL,0,0,0,100,0),
(@PATH,40,1962.4227,233.44661,67.80795,NULL,0,0,0,100,0),
(@PATH,41,1986.6836,266.5842,67.274605,NULL,0,0,0,100,0),
(@PATH,42,2011.089,300.02844,66.1958,NULL,0,0,0,100,0),
(@PATH,43,2030.5328,333.3761,66.2039,NULL,0,0,0,100,0),
(@PATH,44,2046.4001,366.72775,66.07941,NULL,0,0,0,100,0),
(@PATH,45,2062.3293,400.23102,66.18985,NULL,0,0,0,100,0),
(@PATH,46,2079.1477,443.0053,66.22951,NULL,0,0,0,100,0),
(@PATH,47,2085.1711,466.63803,66.07155,NULL,0,0,0,100,0),
(@PATH,48,2102.682,500.0803,61.526283,NULL,0,0,0,100,0),
(@PATH,49,2133.9849,533.43677,55.27074,NULL,0,0,0,100,0),
(@PATH,50,2160.8425,566.8087,46.886005,NULL,0,0,0,100,0),
(@PATH,51,2169.0981,599.8944,40.806755,NULL,0,0,0,100,0),
(@PATH,52,2173.2122,633.11383,34.746147,NULL,0,0,0,100,0),
(@PATH,53,2183.4436,671.9523,34.047813,NULL,0,0,0,100,0),
(@PATH,54,2199.9814,705.9134,38.45436,NULL,0,0,0,100,0),
(@PATH,55,2222.6885,733.4756,45.53316,NULL,0,0,0,100,0),
(@PATH,56,2248.9385,766.28796,52.92477,NULL,0,0,0,100,0),
(@PATH,57,2271.3103,800.17786,54.556904,NULL,0,0,0,100,0),
(@PATH,58,2285.8884,833.4665,54.683197,NULL,0,0,0,100,0),
(@PATH,59,2279.7522,866.7176,54.603855,NULL,0,0,0,100,0),
(@PATH,60,2267.9587,899.9565,54.603855,NULL,0,0,0,100,0),
(@PATH,61,2254.9116,933.2465,54.619514,NULL,0,0,0,100,0),
(@PATH,62,2242.72,966.7881,54.525482,NULL,0,0,0,100,0),
(@PATH,63,2235.451,1000.4372,54.37835,NULL,0,0,0,100,0),
(@PATH,64,2229.4927,1033.4387,53.074142,NULL,0,0,0,100,0),
(@PATH,65,2226.6536,1066.845,50.731457,NULL,0,0,0,100,0),
(@PATH,66,2226.034,1100.0942,47.492607,NULL,0,0,0,100,0),
(@PATH,67,2219.0212,1133.3259,47.441338,NULL,0,0,0,100,0),
(@PATH,68,2204.2024,1165.6702,47.441338,NULL,0,0,0,100,0),
(@PATH,69,2177.5837,1199.9348,47.366386,NULL,0,0,0,100,0),
(@PATH,70,2154.008,1233.5289,47.247627,NULL,0,0,0,100,0),
(@PATH,71,2135.3755,1266.5591,47.416084,NULL,0,0,0,100,0),
(@PATH,72,2117.1653,1300.0837,47.25368,NULL,0,0,0,100,0);
-- 0x20422046001165C000581A0000A0F8E2 .go xyz 2103.3918 1333.9415 47.345947

-- Pathing for Lordaeron Sentry Entry: 17815 - Tower 1
SET @NPC := 83972;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2337.6953,`position_y`=915.4379,`position_z`=55.15482 WHERE `guid`=@NPC; -- Dual ID
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2337.6953,915.4379,55.15482,NULL,0,0,0,100,0),
(@PATH,2,2333.4814,903.4899,57.65865,NULL,0,0,0,100,0),
(@PATH,3,2340.1555,900.48224,57.65981,NULL,0,0,0,100,0),
(@PATH,4,2346.2947,887.8544,57.564976,NULL,0,0,0,100,0),
(@PATH,5,2338.7297,869.56415,57.568974,NULL,0,0,0,100,0),
(@PATH,6,2317.9297,866.5276,57.598198,NULL,0,0,0,100,0),
(@PATH,7,2306.1555,880.7254,57.54948,NULL,0,0,0,100,0),
(@PATH,8,2313.9922,901.3326,57.554733,NULL,0,0,0,100,0),
(@PATH,9,2333.4875,903.71106,57.65865,NULL,0,0,0,100,0),
(@PATH,10,2326.9998,886.5512,57.662193,NULL,0,0,0,100,0),
(@PATH,11,2330.3596,875.4593,57.665497,NULL,0,0,0,100,0),
(@PATH,12,2320.9487,875.9523,60.78332,NULL,0,0,0,100,0),
(@PATH,13,2315.7356,885.64825,63.546394,NULL,0,0,0,100,0),
(@PATH,14,2320.3723,893.43945,65.54927,NULL,0,0,0,100,0),
(@PATH,15,2329.7632,894.6896,68.690025,NULL,0,0,0,100,0),
(@PATH,16,2336.055,887.16,71.3774,NULL,0,0,0,100,0),
(@PATH,17,2331.607,877.8364,75.11574,NULL,0,0,0,100,0),
(@PATH,18,2323.1711,877.8186,76.97392,NULL,0,0,0,100,0),
(@PATH,19,2318.2617,884.3274,80.53621,NULL,0,0,0,100,0),
(@PATH,20,2321.3237,890.0113,81.65865,NULL,0,0,0,100,0),
(@PATH,21,2327.0613,892.2306,83.6398,NULL,0,0,0,100,0),
(@PATH,22,2332.3845,888.5621,86.47227,NULL,0,0,0,100,0),
(@PATH,23,2332.476,883.74207,87.17428,NULL,0,0,0,100,0),
(@PATH,24,2321.1294,886.053,92.7524,NULL,0,0,0,100,0),
(@PATH,25,2332.476,883.74207,87.17428,NULL,0,0,0,100,0),
(@PATH,26,2332.3845,888.5621,86.47227,NULL,0,0,0,100,0),
(@PATH,27,2327.0613,892.2306,83.6398,NULL,0,0,0,100,0),
(@PATH,28,2321.3237,890.0113,81.65865,NULL,0,0,0,100,0),
(@PATH,29,2318.2617,884.3274,80.53621,NULL,0,0,0,100,0),
(@PATH,30,2323.1711,877.8186,76.97392,NULL,0,0,0,100,0),
(@PATH,31,2331.5618,877.742,75.2132,NULL,0,0,0,100,0),
(@PATH,32,2336.055,887.16,71.3774,NULL,0,0,0,100,0),
(@PATH,33,2329.7632,894.6896,68.690025,NULL,0,0,0,100,0),
(@PATH,34,2320.3723,893.43945,65.54927,NULL,0,0,0,100,0),
(@PATH,35,2315.7356,885.64825,63.546394,NULL,0,0,0,100,0),
(@PATH,36,2320.9487,875.9523,60.78332,NULL,0,0,0,100,0),
(@PATH,37,2330.3596,875.4593,57.665497,NULL,0,0,0,100,0),
(@PATH,38,2326.9998,886.5512,57.662193,NULL,0,0,0,100,0),
(@PATH,39,2333.4875,903.71106,57.65865,NULL,0,0,0,100,0),
(@PATH,40,2313.9922,901.3326,57.554733,NULL,0,0,0,100,0),
(@PATH,41,2306.1555,880.7254,57.54948,NULL,0,0,0,100,0),
(@PATH,42,2317.9297,866.5276,57.598198,NULL,0,0,0,100,0),
(@PATH,43,2338.7297,869.56415,57.568974,NULL,0,0,0,100,0),
(@PATH,44,2346.2947,887.8544,57.564976,NULL,0,0,0,100,0),
(@PATH,45,2340.1555,900.48224,57.65981,NULL,0,0,0,100,0),
(@PATH,46,2333.4814,903.4899,57.65865,NULL,0,0,0,100,0);
-- 0x20422046001165C000581A000320F8E1 .go xyz 2337.6953 915.4379 55.15482

-- Pathing for Lordaeron Watchman Entry: 17814
SET @NPC := 48018;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2030.5573,`position_y`=549.52216,`position_z`=62.65978 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2030.5573,549.52216,62.65978,NULL,0,0,0,100,0),
(@PATH,2,2043.0187,543.96594,65.43548,NULL,0,0,0,100,0),
(@PATH,3,2040.9486,528.9046,65.35817,NULL,0,0,0,100,0),
(@PATH,4,2053.6233,516.6144,65.3921,NULL,0,0,0,100,0),
(@PATH,5,2066.4966,516.7051,65.36601,NULL,0,0,0,100,0),
(@PATH,6,2076.9932,524.8176,65.3846,NULL,0,0,0,100,0),
(@PATH,7,2080.0664,537.6619,65.424576,NULL,0,0,0,100,0),
(@PATH,8,2073.2578,552.86383,65.413246,NULL,0,0,0,100,0),
(@PATH,9,2058.9766,555.5665,65.34127,NULL,0,0,0,100,0),
(@PATH,10,2047.5226,550.6699,65.42719,NULL,0,0,0,100,0),
(@PATH,11,2043.2604,544.3217,65.43548,NULL,0,0,0,100,0),
(@PATH,12,2058.8784,536.21625,65.438126,NULL,0,0,0,100,0),
(@PATH,13,2066.8667,540.08575,65.43678,NULL,0,0,0,100,0),
(@PATH,14,2070.924,532.96564,67.08647,NULL,0,0,0,100,0),
(@PATH,15,2063.4397,526.1872,70.21204,NULL,0,0,0,100,0),
(@PATH,16,2056.6567,525.29297,72.259315,NULL,0,0,0,100,0),
(@PATH,17,2052.3293,530.6643,73.32143,NULL,0,0,0,100,0),
(@PATH,18,2051.132,539.46906,76.37743,NULL,0,0,0,100,0),
(@PATH,19,2058.9639,545.4133,79.13861,NULL,0,0,0,100,0),
(@PATH,20,2067.3652,542.5206,81.916046,NULL,0,0,0,100,0),
(@PATH,21,2068.8682,531.42017,84.74329,NULL,0,0,0,100,0),
(@PATH,22,2061.934,526.92706,87.70602,NULL,0,0,0,100,0),
(@PATH,23,2053.2678,531.0762,89.4308,NULL,0,0,0,100,0),
(@PATH,24,2054.9526,540.5202,93.20269,NULL,0,0,0,100,0),
(@PATH,25,2062.1814,541.9551,94.935486,NULL,0,0,0,100,0),
(@PATH,26,2059.0625,530.921,100.52455,NULL,0,0,0,100,0),
(@PATH,27,2062.1814,541.9551,94.935486,NULL,0,0,0,100,0),
(@PATH,28,2054.9526,540.5202,93.20269,NULL,0,0,0,100,0),
(@PATH,29,2053.2678,531.0762,89.4308,NULL,0,0,0,100,0),
(@PATH,30,2061.934,526.92706,87.70602,NULL,0,0,0,100,0),
(@PATH,31,2068.8682,531.42017,84.74329,NULL,0,0,0,100,0),
(@PATH,32,2067.4739,542.4832,81.969536,NULL,0,0,0,100,0),
(@PATH,33,2058.9639,545.4133,79.13861,NULL,0,0,0,100,0),
(@PATH,34,2051.132,539.46906,76.37743,NULL,0,0,0,100,0),
(@PATH,35,2052.3293,530.6643,73.32143,NULL,0,0,0,100,0),
(@PATH,36,2056.6567,525.29297,72.259315,NULL,0,0,0,100,0),
(@PATH,37,2063.4397,526.1872,70.21204,NULL,0,0,0,100,0),
(@PATH,38,2070.924,532.96564,67.08647,NULL,0,0,0,100,0),
(@PATH,39,2066.8667,540.08575,65.43678,NULL,0,0,0,100,0),
(@PATH,40,2058.8784,536.21625,65.438126,NULL,0,0,0,100,0),
(@PATH,41,2043.2604,544.3217,65.43548,NULL,0,0,0,100,0),
(@PATH,42,2047.5226,550.6699,65.42719,NULL,0,0,0,100,0),
(@PATH,43,2058.9766,555.5665,65.34127,NULL,0,0,0,100,0),
(@PATH,44,2073.2578,552.86383,65.413246,NULL,0,0,0,100,0),
(@PATH,45,2080.0664,537.6619,65.424576,NULL,0,0,0,100,0),
(@PATH,46,2076.9932,524.8176,65.3846,NULL,0,0,0,100,0),
(@PATH,47,2066.4966,516.7051,65.36601,NULL,0,0,0,100,0),
(@PATH,48,2053.6233,516.6144,65.3921,NULL,0,0,0,100,0),
(@PATH,49,2040.9486,528.9046,65.35817,NULL,0,0,0,100,0),
(@PATH,50,2043.0187,543.96594,65.43548,NULL,0,0,0,100,0);
-- 0x204220460011658000581A000220F8E1 .go xyz 2030.5573 549.52216 62.65978

-- Pathing for Don Carlos Entry: 28132
SET @NPC := 1885;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2227.62,`position_y`=1009.7258,`position_z`=53.78852 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,2410,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2227.62,1009.7258,53.78852,NULL,0,0,0,100,0),
(@PATH,2,2227.62,1009.7258,53.78852,2.478367567062377929,11000,0,0,100,0),
(@PATH,3,2239.5022,966.686,54.710663,NULL,0,0,0,100,0),
(@PATH,4,2250.3352,933.3757,54.54609,NULL,0,0,0,100,0),
(@PATH,5,2262.7214,900.36816,54.351204,NULL,0,0,0,100,0),
(@PATH,6,2275.6965,866.6112,54.198456,NULL,0,0,0,100,0),
(@PATH,7,2281.3337,833.35144,54.979706,NULL,9000,0,0,100,0),
(@PATH,8,2266.3677,800.44366,54.67512,NULL,0,0,0,100,0),
(@PATH,9,2243.6724,766.81726,52.80878,NULL,0,0,0,100,0),
(@PATH,10,2216.9329,733.1887,44.46825,NULL,0,0,0,100,0),
(@PATH,11,2200.039,713.3644,39.00902,NULL,0,0,0,100,0),
(@PATH,12,2190.7734,700.3174,36.458755,NULL,0,0,0,100,0),
(@PATH,13,2182.4844,682.9269,34.258385,NULL,10000,0,0,100,0),
(@PATH,14,2216.152,733.4819,44.693806,NULL,0,0,0,100,0),
(@PATH,15,2233.0774,755.7023,50.529865,NULL,0,0,0,100,0),
(@PATH,16,2243.432,766.66656,52.744473,NULL,0,0,0,100,0),
(@PATH,17,2265.9766,800.0752,54.67512,NULL,0,0,0,100,0),
(@PATH,18,2276.7432,817.5262,54.806904,NULL,10000,0,0,100,0),
(@PATH,19,2274.8376,866.8675,53.983494,NULL,0,0,0,100,0),
(@PATH,20,2262.3582,900.01575,54.354378,NULL,0,0,0,100,0),
(@PATH,21,2250.1418,933.542,54.54609,NULL,0,0,0,100,0),
(@PATH,22,2238.6863,966.67145,54.71237,NULL,0,0,0,100,0),
(@PATH,23,2230.2744,1000.1133,54.23957,NULL,0,0,0,100,0);
-- 0x20422046001B790000581A000020F8E1 .go xyz 2227.62 1009.7258 53.78852

-- Hillsbrad Peasants working at Tower
DELETE FROM `creature_template_addon` WHERE (`entry` = 20424);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20424, 0, 0, 0, 1, 233, 0, '');

DELETE FROM `creature` WHERE `map`=560 AND `id1`=20424 AND `guid` IN (11390,11404,11414,11415,11416,11417,11420,11424,11488,11499,11501,11502); -- Deletes extra one
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(11390, 20424, 560, 2367, 2367, 3, 1, 1, 2306.75732421875, 906.4609375, 54.78238677978515625, 5.585053443908691406, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11404, 20424, 560, 2367, 2367, 3, 1, 1, 2351.021240234375, 902.345703125, 55.26427841186523437, 3.560471534729003906, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11414, 20424, 560, 2367, 2367, 3, 1, 1, 2316.123779296875, 912.6961669921875, 54.8037261962890625, 5.026548385620117187, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11415, 20424, 560, 2367, 2367, 3, 1, 1, 2315.3564453125, 856.1329345703125, 56.57412338256835937, 1.082104086875915527, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11416, 20424, 560, 2367, 2367, 3, 1, 1, 2342.88720703125, 887.82073974609375, 57.70813751220703125, 3.525565147399902343, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11417, 20424, 560, 2367, 2367, 3, 1, 1, 2301.0205078125, 898.58056640625, 54.41033935546875, 5.759586334228515625, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11420, 20424, 560, 2367, 2367, 3, 1, 1, 2302.145751953125, 868.93359375, 55.70030593872070312, 0.680678427219390869, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11424, 20424, 560, 2367, 2367, 3, 1, 1, 2340.767578125, 859.9713134765625, 55.25447845458984375, 2.530727386474609375, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11488, 20424, 560, 2367, 2367, 3, 1, 1, 2329.278564453125, 895.7554931640625, 57.7480926513671875, 1.919862151145935058, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11499, 20424, 560, 2367, 2367, 3, 1, 1, 2297.286865234375, 885.65594482421875, 54.39743423461914062, 0.174532920122146606, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20424 (Area: 2367 - Difficulty: 1)
(11501, 20424, 560, 2367, 2367, 3, 1, 1, 2355.77001953125, 891.4378662109375, 57.94371795654296875, 3.979350566864013671, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187); -- 20424 (Area: 2367 - Difficulty: 1)

-- Static formations in towers
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (31908,40162,41813,42939,44653,46842,48013,48015) AND `memberGUID` IN (31908,40162,41813,42939,44653,44656,46842,46850,47583,47894,48012,48013,48014,48015,48016,48017,48019,48020);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(40162, 40162, 0, 0, 3, 0, 0),
(40162, 48012, 0, 0, 3, 0, 0),
(48013, 48013, 0, 0, 3, 0, 0),
(48013, 48014, 0, 0, 3, 0, 0),
(44653, 44653, 0, 0, 3, 0, 0),
(44653, 44656, 0, 0, 3, 0, 0),
(46842, 46842, 0, 0, 3, 0, 0),
(46842, 46850, 0, 0, 3, 0, 0),
(48015, 48015, 0, 0, 3, 0, 0),
(48015, 48016, 0, 0, 3, 0, 0),
(41813, 41813, 0, 0, 3, 0, 0),
(41813, 48017, 0, 0, 3, 0, 0),
(31908, 31908, 0, 0, 3, 0, 0),
(31908, 47583, 0, 0, 3, 0, 0),
(31908, 47894, 0, 0, 3, 0, 0),
(42939, 42939, 0, 0, 3, 0, 0),
(42939, 48020, 0, 0, 3, 0, 0),
(42939, 48019, 0, 0, 3, 0, 0);
