INSERT INTO version_db_world (`sql_rev`) VALUES ('1528460337456239208');

-- Pathing for Wooly Kodo group
UPDATE `creature` SET `position_x`=-2891.01, `position_y`=-2150.02, `position_z`=94.2478, `spawndist`=0, `MovementType`=2 WHERE `guid`=15144;
UPDATE `creature` SET `position_x`=-2895.78, `position_y`=-2158.99, `position_z`=91.6667, `spawndist`=0, `MovementType`=0 WHERE `guid`=15142;
UPDATE `creature` SET `position_x`=-2876.98, `position_y`=-2149.49, `position_z`=92.9047, `spawndist`=0, `MovementType`=0 WHERE `guid`=15141;
UPDATE `creature` SET `position_x`=-2878.42, `position_y`=-2160.61, `position_z`=92.0229, `spawndist`=0, `MovementType`=0 WHERE `guid`=15135;

DELETE FROM `creature_addon` WHERE `guid`=15144;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(15144,151440,0,0,0,0,"");

DELETE FROM `creature_formations` WHERE `leaderGUID`=15144;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(15144,15144,0,0,515,0,0),
(15144,15135,15,0,515,0,0),
(15144,15142,12,270,515,0,0),
(15144,15141,9,60,515,0,0);

DELETE FROM `waypoint_data` WHERE `id`=151440;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(151440,1,-2891.01,-2150.02,94.2478,0,0,0,0,100,0),
(151440,2,-2903.93,-2136.42,95.657,0,0,0,0,100,0),
(151440,3,-2921.7,-2112.77,95.5313,0,0,0,0,100,0),
(151440,4,-2928.01,-2071.33,96.0166,0,0,0,0,100,0),
(151440,5,-2928.91,-2050.84,95.785,0,0,0,0,100,0),
(151440,6,-2926.84,-2041.01,96.3781,0,0,0,0,100,0),
(151440,7,-2923.56,-2034.24,96.0931,0,0,0,0,100,0),
(151440,8,-2915.72,-2026.93,95.6855,0,0,0,0,100,0),
(151440,9,-2905.62,-2021.31,93.4736,0,0,0,0,100,0),
(151440,10,-2896.02,-2017.06,91.7219,0,0,0,0,100,0),
(151440,11,-2881.85,-2010.83,91.8045,0,0,0,0,100,0),
(151440,12,-2872.75,-2008.67,92.7372,0,0,0,0,100,0),
(151440,13,-2860.24,-2009.61,94.2234,0,0,0,0,100,0),
(151440,14,-2850.68,-2007.45,95.3112,0,0,0,0,100,0),
(151440,15,-2837.95,-2001.67,96.0295,0,0,0,0,100,0),
(151440,16,-2798.05,-1973.73,93.4632,0,0,0,0,100,0),
(151440,17,-2775.55,-1955.8,94.3558,0,0,0,0,100,0),
(151440,18,-2770.03,-1954.5,94.3486,0,0,0,0,100,0),
(151440,19,-2737.42,-1955.19,94.2536,0,0,0,0,100,0),
(151440,20,-2710.84,-1959.71,96.7887,0,0,0,0,100,0),
(151440,21,-2667.95,-1973.89,97.7269,0,0,0,0,100,0),
(151440,22,-2649.13,-1983.14,98.7822,0,0,0,0,100,0),
(151440,23,-2640.2,-1988.65,97.8667,0,0,0,0,100,0),
(151440,24,-2613.39,-2005.2,91.7337,0,0,0,0,100,0),
(151440,25,-2554.57,-2041.31,92.0596,0,0,0,0,100,0),
(151440,26,-2525.49,-2064.46,93.7675,0,0,0,0,100,0),
(151440,27,-2520.19,-2075.43,93.7559,0,0,0,0,100,0),
(151440,28,-2518.56,-2091.79,93.4852,0,0,0,0,100,0),
(151440,29,-2521.19,-2119.21,92.1279,0,0,0,0,100,0),
(151440,30,-2523.41,-2133.03,95.6538,0,0,0,0,100,0),
(151440,31,-2523.99,-2157.74,96.1462,0,0,0,0,100,0),
(151440,32,-2513.76,-2189.22,96.6454,0,0,0,0,100,0),
(151440,33,-2511.82,-2202.38,95.8735,0,0,0,0,100,0),
(151440,34,-2511.2,-2208.1,94.7895,0,0,0,0,100,0),
(151440,35,-2512.97,-2220.95,92.1185,0,0,0,0,100,0),
(151440,36,-2517,-2236.07,92.0664,0,0,0,0,100,0),
(151440,37,-2526.55,-2255.15,94.2318,0,0,0,0,100,0),
(151440,38,-2532.38,-2268.06,95.292,0,0,0,0,100,0),
(151440,39,-2541.75,-2277.29,95.0165,0,0,0,0,100,0),
(151440,40,-2564.64,-2288.88,92.3051,0,0,0,0,100,0),
(151440,41,-2598.33,-2299.11,91.6696,0,0,0,0,100,0),
(151440,42,-2623.49,-2294.38,93.5493,0,0,0,0,100,0),
(151440,43,-2652.46,-2282.06,91.8607,0,0,0,0,100,0),
(151440,44,-2707.78,-2258.55,91.6669,0,0,0,0,100,0),
(151440,45,-2712.81,-2253.49,93.2486,0,0,0,0,100,0),
(151440,46,-2719.92,-2249.24,94.5715,0,0,0,0,100,0),
(151440,47,-2722.89,-2247.63,93.545,0,0,0,0,100,0),
(151440,48,-2727.47,-2243.92,91.6671,0,0,0,0,100,0),
(151440,49,-2742.73,-2228.33,92.8483,0,0,0,0,100,0),
(151440,50,-2753.01,-2206.2,96.3717,0,0,0,0,100,0),
(151440,51,-2786.31,-2184.29,95.7868,0,0,0,0,100,0),
(151440,52,-2826.44,-2175.95,96.4113,0,0,0,0,100,0),
(151440,53,-2833.23,-2174.24,95.3236,0,0,0,0,100,0),
(151440,54,-2840.01,-2172.53,92.9766,0,0,0,0,100,0),
(151440,55,-2850.23,-2170.11,91.6667,0,0,0,0,100,0),
(151440,56,-2874.56,-2162.59,92.2099,0,0,0,0,100,0);


-- Random movement for Gazelles
UPDATE `creature` SET `spawndist` = 20, `MovementType` = 1 WHERE `id` = 4166 AND `spawndist` = 0;


-- Pathing for Barrens Kodo group
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 15139;
UPDATE `creature` SET `orientation` = 2.98926 WHERE `guid` in (15137,15138,15139,15140);

DELETE FROM `creature_addon` WHERE `guid` = 15139;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(15139,151390,0,0,0,0,"");

DELETE FROM `creature_formations` WHERE `leaderGUID` = 15139;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(15139,15139,0,0,515,0,0),
(15139,15137,15,180,515,0,0),
(15139,15138,12,270,515,0,0),
(15139,15140,9,60,515,0,0);

DELETE FROM `waypoint_data` WHERE `id`=151390;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(151390,1,-2998.13,-2012.47,91.7341,0,0,0,0,100,0),
(151390,2,-3048.21,-1999.61,91.8675,0,0,0,0,100,0),
(151390,3,-3106.65,-2003.4,98.1789,0,0,0,0,100,0),
(151390,4,-3143.73,-2004.96,91.6704,0,0,0,0,100,0),
(151390,5,-3267.98,-2026.34,92.5754,0,0,0,0,100,0),
(151390,6,-3583.22,-1921.61,94.3068,0,13000,0,0,100,0),
(151390,7,-3645.08,-1956.1,91.9535,0,0,0,0,100,0),
(151390,8,-3702.84,-2056.81,93.3177,0,0,0,0,100,0),
(151390,9,-3724.26,-2202.7,91.7286,0,0,0,0,100,0),
(151390,10,-3696.85,-2312.4,92.1689,0,0,0,0,100,0),
(151390,11,-3667.83,-2352.59,91.6668,0,0,0,0,100,0),
(151390,12,-3657.77,-2356.66,91.6667,0,0,0,0,100,0),
(151390,13,-3648.58,-2356.08,91.757,0,0,0,0,100,0),
(151390,14,-3639.44,-2353.15,92.3895,0,0,0,0,100,0),
(151390,15,-3630.63,-2346.35,92.1355,0,0,0,0,100,0),
(151390,16,-3597.42,-2300.35,92.6799,0,0,0,0,100,0),
(151390,17,-3563.12,-2268.77,91.7997,0,0,0,0,100,0),
(151390,18,-3520.45,-2253.33,92.7574,0,0,0,0,100,0),
(151390,19,-3488.97,-2234.86,93.676,0,0,0,0,100,0),
(151390,20,-3387.12,-2196.93,95.1846,0,0,0,0,100,0),
(151390,21,-3292.87,-2185.51,92.5575,0,14000,0,0,100,0),
(151390,22,-3206.89,-2075.94,94.7149,0,0,0,0,100,0),
(151390,23,-3154.15,-2065.12,92.807,0,11000,0,0,100,0),
(151390,24,-3144.05,-2075.1,91.9836,0,0,0,0,100,0),
(151390,25,-3125.87,-2101.69,91.6774,0,0,0,0,100,0),
(151390,26,-3105.69,-2123.68,91.8374,0,0,0,0,100,0),
(151390,27,-3082.92,-2132.46,91.7132,0,0,0,0,100,0),
(151390,28,-2983.82,-2114.47,93.6036,0,0,0,0,100,0),
(151390,29,-2974.75,-2087.39,91.6668,0,0,0,0,100,0),
(151390,30,-2958.35,-2057.43,96.6284,0,0,0,0,100,0),
(151390,31,-2973.28,-2017.21,94.3499,0,0,0,0,100,0);
