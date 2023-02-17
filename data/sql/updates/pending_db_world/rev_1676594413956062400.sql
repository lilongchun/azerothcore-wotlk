--
DELETE FROM `creature` WHERE `id1`=18679;
INSERT INTO `creature` (`guid`, `id1`, `map`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`) VALUES
(24922, 18679, 530, 1, -368.807, 1845.98, 86.4098, 2.91794, 28800, 2),
(24923, 18679, 530, 1, -114.012, 1835.66, 73.8411, 0.612791, 28800, 2),
(24924, 18679, 530, 1, 494.112, 2187.12, 131.719, 1.88514, 28800, 2),
(24925, 18679, 530, 1, 442.586, 3516.65, 60.8444, 1.20665, 28800, 2);

DELETE FROM `creature_addon` WHERE (`guid` IN (24922, 24923, 24924, 24925, 151930));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24922, 249220, 0, 0, 1, 0, 0, ''),
(24923, 249230, 0, 0, 1, 0, 0, ''),
(24924, 249240, 0, 0, 1, 0, 0, ''),
(24925, 249250, 0, 0, 1, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` IN (249220, 249230, 249240, 249250, 1519300);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(249220, 1, -368.807, 1845.98, 86.4098),
(249220, 2, -394.117, 1765.65, 60.0718),
(249220, 3, -430.21, 1735.79, 50.2494),
(249220, 4, -467.137, 1759.59, 46.767),
(249220, 5, -481.167, 1743.93, 41.2044),
(249220, 6, -491.55, 1741.66, 46.4614),
(249220, 7, -501.393, 1756.58, 49.219),
(249220, 8, -534.742, 1790.65, 56.8644),
(249220, 9, -563.301, 1812.43, 66.1833),
(249220, 10, -582.342, 1829.4, 70.716),
(249220, 11, -541.357, 1879.13, 77.7951),
(249220, 12, -484.344, 1898.96, 87.2478),
(249220, 13, -392.494, 1897.04, 104.712),
(249230, 1, -114.012, 1835.66, 73.8411),
(249230, 2, -91.4783, 1847.82, 69.2832),
(249230, 3, -48.3747, 1834.22, 56.2454),
(249230, 4, -27.769, 1751.28, 45.8751),
(249230, 5, 7.84103, 1727.88, 42.7232),
(249230, 6, 61.2473, 1718.28, 40.0149),
(249230, 7, 83.7766, 1696.73, 39.1369),
(249230, 8, 100.682, 1697.19, 40.2013),
(249230, 9, 173.49, 1699.2, 29.6471),
(249230, 10, 187.283, 1739.6, 31.9241),
(249230, 11, 204.008, 1746.78, 24.8385),
(249230, 12, 211.648, 1786.65, 19.2764),
(249230, 13, 199.708, 1790.54, 22.2977),
(249230, 14, 173.246, 1781.3, 26.3822),
(249230, 15, 155.866, 1781.44, 33.661),
(249230, 16, 134.747, 1779.92, 34.6875),
(249230, 17, 128.552, 1783.87, 37.7445),
(249230, 18, 79.8076, 1800.09, 45.2287),
(249230, 19, 63.0398, 1800.49, 48.2331),
(249230, 20, 32.4485, 1861.2, 49.7156),
(249230, 21, 29.9901, 1871.98, 47.1418),
(249230, 22, 9.29734, 1874.98, 51.9819),
(249230, 23, -22.6535, 1868.99, 57.1755),
(249230, 24, -43.6076, 1863.96, 64.0862),
(249230, 25, -78.5294, 1861.73, 71.2376),
(249240, 1, 494.112, 2187.12, 131.719),
(249240, 2, 490.009, 2150.51, 126.99),
(249240, 3, 476.108, 2147.86, 118.362),
(249240, 4, 447.068, 2146.79, 117.958),
(249240, 5, 391.824, 2120.25, 115.876),
(249240, 6, 364.498, 2141.12, 120.353),
(249240, 7, 366.106, 2174.26, 120.116),
(249240, 8, 369.158, 2196.83, 119.376),
(249240, 9, 343.484, 2215.23, 117.934),
(249240, 10, 340.956, 2232.1, 118.971),
(249240, 11, 391.441, 2247.7, 117.091),
(249240, 12, 432.466, 2259.06, 117.991),
(249240, 13, 437.614, 2269.6, 114.766),
(249240, 14, 438.826, 2278.85, 118.556),
(249240, 15, 438.178, 2332.83, 119.533),
(249240, 16, 430.33, 2389.52, 125.334),
(249240, 17, 424.122, 2410.58, 132.903),
(249240, 18, 409.936, 2426.29, 140.293),
(249240, 19, 391.569, 2441.42, 147.378),
(249240, 20, 372.028, 2450.85, 153.994),
(249240, 21, 351.563, 2501.71, 158.671),
(249240, 22, 358.341, 2519.12, 157.017),
(249240, 23, 362.253, 2540.77, 155.273),
(249240, 24, 393.193, 2549.76, 151.156),
(249240, 25, 422.271, 2538.3, 151.843),
(249240, 26, 443.763, 2554.36, 162.211),
(249240, 27, 446.835, 2632.73, 179.099),
(249240, 28, 487.397, 2745.97, 201.314),
(249240, 29, 524.691, 2778.75, 213.732),
(249240, 30, 529.078, 2770.99, 213.393),
(249240, 31, 516.915, 2750.16, 211.931),
(249240, 32, 474.551, 2663.26, 192.277),
(249240, 33, 463.675, 2628.29, 184.522),
(249240, 34, 463.409, 2570.53, 174.952),
(249240, 35, 459.304, 2541.33, 164.87),
(249240, 36, 465.254, 2485.88, 156.33),
(249240, 37, 428.184, 2445.82, 139.387),
(249240, 38, 428.213, 2414.12, 133.002),
(249240, 39, 447.828, 2392.86, 133.544),
(249240, 40, 454.476, 2300.08, 124.765),
(249240, 41, 478.859, 2261.73, 129.556),
(249240, 42, 490.589, 2224.36, 131.317),
(249250, 1, 442.586, 3516.65, 60.8444),
(249250, 2, 430.167, 3506.58, 62.984),
(249250, 3, 380.869, 3507.06, 62.9783),
(249250, 4, 364.828, 3502.97, 62.3136),
(249250, 5, 359.136, 3482.24, 62.8538),
(249250, 6, 350.932, 3469.66, 61.7651),
(249250, 7, 333.588, 3465.64, 62.0532),
(249250, 8, 332.589, 3436.69, 61.9835),
(249250, 9, 344.644, 3424.99, 63.3763),
(249250, 10, 346.874, 3386.66, 64.2423),
(249250, 11, 341.957, 3361.83, 68.1707),
(249250, 12, 354.937, 3358.04, 62.9527),
(249250, 13, 373.619, 3362.38, 62.5949),
(249250, 14, 395.768, 3352.65, 62.7729),
(249250, 15, 417.721, 3338.98, 61.9029),
(249250, 16, 438.161, 3340.84, 62.9257),
(249250, 17, 463.486, 3377.86, 73.8103),
(249250, 18, 466.918, 3398.15, 69.5736),
(249250, 19, 505.131, 3430.84, 73.9158),
(249250, 20, 508.783, 3437.74, 73.853),
(249250, 21, 516.238, 3459.83, 74.7222),
(249250, 22, 527.515, 3486.28, 77.0556),
(249250, 23, 489.114, 3523.57, 65.8445),
(249250, 24, 468.23, 3526.64, 63.9368);

DELETE FROM `pool_template` WHERE `entry`=1115 AND `description` LIKE 'Vorakem Doomspeaker (18679)';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1115, 1, 'Vorakem Doomspeaker (18679)');

DELETE FROM `pool_creature` WHERE `pool_entry`=1115 AND `description` LIKE 'Vorakem Doomspeaker (18679)';
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(24922, 1115, 0, 'Vorakem Doomspeaker (18679)'),
(24923, 1115, 0, 'Vorakem Doomspeaker (18679)'),
(24924, 1115, 0, 'Vorakem Doomspeaker (18679)'),
(24925, 1115, 0, 'Vorakem Doomspeaker (18679)');
