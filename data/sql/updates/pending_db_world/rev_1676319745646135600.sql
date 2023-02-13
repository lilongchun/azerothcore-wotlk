--
DELETE FROM `creature` WHERE `id1`=18648 AND `guid`=86357;
INSERT INTO `creature`(`guid`, `id1`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`) VALUES
(86357, 18648, 530, 1, -1996.77, 3691.44, -55.336, 4.15348, 300, 2);

DELETE FROM `creature_addon` WHERE (`guid` = 86357);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(86357, 863570, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id`=863570;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(863570, 1, -1996.77, 3691.44, -55.336),
(863570, 2, -2003.93, 3680, -62.9563),
(863570, 3, -2012.14, 3673.5, -70.4843),
(863570, 4, -2017.82, 3668.26, -70.9137),
(863570, 5, -2025.06, 3661.79, -69.4269),
(863570, 6, -2038.99, 3660.38, -66.7324),
(863570, 7, -2053.45, 3649.44, -65.0682),
(863570, 8, -2060.97, 3637.63, -65.2084),
(863570, 9, -2065.82, 3627.13, -66.8755),
(863570, 10, -2069.63, 3618.56, -63.7202),
(863570, 11, -2075.9, 3605.38, -62.2908),
(863570, 12, -2080.72, 3593.47, -63.6726),
(863570, 13, -2086.85, 3577.68, -63.0435),
(863570, 14, -2091.53, 3561.27, -63.9136),
(863570, 15, -2091.9, 3558.99, -64.593),
(863570, 16, -2093.33, 3551.36, -71.5948),
(863570, 17, -2093.09, 3545.55, -60.957),
(863570, 18, -2095.03, 3534.02, -57.587),
(863570, 19, -2096.72, 3521.29, -56.1821),
(863570, 20, -2097.01, 3513.11, -57.028),
(863570, 21, -2099.07, 3493.34, -64.6929),
(863570, 22, -2103.58, 3483.31, -63.2184),
(863570, 23, -2105.74, 3475.41, -65.6768),
(863570, 24, -2106.44, 3467.97, -64.468),
(863570, 25, -2107.1, 3461.39, -65.8403),
(863570, 26, -2108.14, 3449.75, -63.965),
(863570, 27, -2108.91, 3436.89, -59.7906),
(863570, 28, -2109.66, 3423.51, -52.8207),
(863570, 29, -2112.76, 3413.32, -48.142),
(863570, 30, -2121.64, 3404.88, -46.3506),
(863570, 31, -2131.1, 3396.23, -44.9126),
(863570, 32, -2134.37, 3389.37, -46.1489),
(863570, 33, -2131.79, 3383.86, -49.3395),
(863570, 34, -2128.36, 3376.67, -55.9128),
(863570, 35, -2126.56, 3368.71, -56.1998),
(863570, 36, -2127.56, 3362.95, -53.5525),
(863570, 37, -2131.19, 3357.47, -46.1145),
(863570, 38, -2125.85, 3347.14, -45.6573),
(863570, 39, -2119.3, 3334.73, -47.1481),
(863570, 40, -2110.68, 3321.54, -47.8091),
(863570, 41, -2100.88, 3310.8, -48.6787),
(863570, 42, -2090.47, 3299.05, -50.4756),
(863570, 43, -2083.33, 3293.68, -55.9256),
(863570, 44, -2078.28, 3287.97, -51.4244),
(863570, 45, -2073.34, 3281.43, -52.9969),
(863570, 46, -2063.93, 3268.75, -56.6561),
(863570, 47, -2055.24, 3257.03, -59.2205),
(863570, 48, -2053.2, 3252.83, -62.8816),
(863570, 49, -2047.24, 3246.85, -73.0043),
(863570, 50, -2043.23, 3243.11, -72.4173),
(863570, 51, -2037.29, 3237.16, -69.086),
(863570, 52, -2031.93, 3231.8, -70.0572),
(863570, 53, -2037.81, 3237.48, -69.2409),
(863570, 54, -2043.55, 3243.31, -72.4278),
(863570, 55, -2047.31, 3246.89, -72.9844),
(863570, 56, -2053.51, 3253.16, -62.3759),
(863570, 57, -2055.88, 3257.93, -58.9112),
(863570, 58, -2063.94, 3268.6, -56.6398),
(863570, 59, -2073.83, 3281.86, -52.7742),
(863570, 60, -2078.86, 3288.44, -51.4462),
(863570, 61, -2083.72, 3293.82, -55.8937),
(863570, 62, -2090.97, 3299.89, -50.4188),
(863570, 63, -2101.03, 3310.92, -48.6276),
(863570, 64, -2110.38, 3321.34, -47.8336),
(863570, 65, -2118.06, 3332.77, -47.2585),
(863570, 66, -2125.31, 3345.69, -45.7645),
(863570, 67, -2131.76, 3358.36, -46.2777),
(863570, 68, -2127.94, 3363.14, -53.5166),
(863570, 69, -2126.84, 3369.1, -56.2019),
(863570, 70, -2128.84, 3377.25, -55.5198),
(863570, 71, -2132.2, 3383.99, -49.3382),
(863570, 72, -2134.55, 3389.79, -45.954),
(863570, 73, -2131.32, 3396.31, -44.8486),
(863570, 74, -2121.76, 3405.02, -46.3264),
(863570, 75, -2113.32, 3413.32, -47.9902),
(863570, 76, -2110.22, 3423.3, -52.2944),
(863570, 77, -2109.28, 3437.47, -60.2717),
(863570, 78, -2108.45, 3449.68, -63.8449),
(863570, 79, -2107.3, 3461.64, -65.6918),
(863570, 80, -2106.68, 3468.04, -64.4831),
(863570, 81, -2105.94, 3475.72, -65.4231),
(863570, 82, -2103.89, 3483.71, -63.0018),
(863570, 83, -2099.3, 3493.67, -64.4541),
(863570, 84, -2097.45, 3513.67, -56.8631),
(863570, 85, -2097.2, 3521.95, -56.0993),
(863570, 86, -2095.39, 3534.9, -57.5393),
(863570, 87, -2093.37, 3546, -61.2589),
(863570, 88, -2093.66, 3551.82, -71.882),
(863570, 89, -2092.36, 3558.82, -64.4532),
(863570, 90, -2091.93, 3561.65, -63.5573),
(863570, 91, -2086.94, 3578.34, -63.0179),
(863570, 92, -2081, 3593.7, -63.4996),
(863570, 93, -2076.34, 3605.29, -62.0478),
(863570, 94, -2070.21, 3619.16, -63.7059),
(863570, 95, -2066.15, 3627.76, -66.6732),
(863570, 96, -2061.21, 3637.91, -65.0062),
(863570, 97, -2053.49, 3650.07, -64.9078),
(863570, 98, -2039.41, 3660.59, -66.5091),
(863570, 99, -2025.45, 3662.06, -69.2666),
(863570, 100, -2018.42, 3668.33, -70.7122),
(863570, 101, -2012.08, 3674.36, -69.8961),
(863570, 102, -2003.99, 3680.59, -62.4553),
(863570, 103, -1996.95, 3691.94, -54.9681),
(863570, 104, -1987.92, 3710.84, -41.6305),
(863570, 105, -1980.74, 3729.54, -30.1387),
(863570, 106, -1970.21, 3735.92, -23.6044),
(863570, 107, -1956.11, 3741.73, -15.3974),
(863570, 108, -1944.91, 3748.26, -11.1596),
(863570, 109, -1935.12, 3754.11, -9.51987),
(863570, 110, -1918.06, 3762.94, -6.23739),
(863570, 111, -1907.43, 3768.79, -2.98779),
(863570, 112, -1894.27, 3775.38, 5.33932),
(863570, 113, -1885.92, 3779.56, 7.72026),
(863570, 114, -1865.18, 3795.66, 7.24442),
(863570, 115, -1848.48, 3803.51, 12.059),
(863570, 116, -1830.9, 3805.41, 17.8008),
(863570, 117, -1849.35, 3803.04, 11.8302),
(863570, 118, -1866.25, 3795.23, 7.0094),
(863570, 119, -1885.98, 3779.49, 7.72068),
(863570, 120, -1892.23, 3776.35, 6.22982),
(863570, 121, -1904.74, 3769.73, -1.31481),
(863570, 122, -1917.84, 3762.46, -6.18441),
(863570, 123, -1935.54, 3754.11, -9.53416),
(863570, 124, -1944.97, 3748.29, -11.1474),
(863570, 125, -1956.71, 3741.05, -16.0124),
(863570, 126, -1970.67, 3735.79, -23.8129),
(863570, 127, -1981.2, 3729.16, -30.45),
(863570, 128, -1988.06, 3710.37, -41.9423);
