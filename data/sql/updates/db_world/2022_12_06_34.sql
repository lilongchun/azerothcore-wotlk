-- DB update 2022_12_06_33 -> 2022_12_06_34
-- Delete all old gameobjects andd add new ones
DELETE FROM `gameobject` WHERE `id`=185541;

SET @GUID := 21800;

DELETE FROM `gameobject` WHERE `id`=185541 AND `guid` BETWEEN @GUID+0 AND @GUID+44;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `ZoneId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID+0 , 185541, 530, 3519, 1, 1, -3522.93, 3591.24, 279.984, 3.13623, 0, 0, 0.999996, 0.00268371, 320, 255, 1),
(@GUID+1 , 185541, 530, 3519, 1, 1, -3614.71, 3668.21, 277.876, 3.06554, 0, 0, 0.999277, 0.0380174, 320, 255, 1),
(@GUID+2 , 185541, 530, 3519, 1, 1, -3687.49, 3676.91, 275.849, 3.17157, 0, 0, 0.999888, -0.014987, 320, 255, 1),
(@GUID+3 , 185541, 530, 3519, 1, 1, -3591.01, 3724.4, 286.046, 2.90092, 0, 0, 0.992768, 0.120047, 320, 255, 1),
(@GUID+4 , 185541, 530, 3519, 1, 1, -3660.47, 3804.44, 256.671, 0.921711, 0, 0, 0.444715, 0.895672, 320, 255, 1),
(@GUID+5 , 185541, 530, 3519, 1, 1, -3709.67, 3744.53, 277.062, 2.56712, 0, 0, 0.959031, 0.283302, 320, 255, 1),
(@GUID+6 , 185541, 530, 3519, 1, 1, -3758.52, 3732.27, 276.852, 6.07391, 0, 0, 0.104445, -0.994531, 320, 255, 1),
(@GUID+7 , 185541, 530, 3519, 1, 1, -3945.16, 3664.53, 287.184, 3.24256, 0, 0, 0.998726, -0.0504627, 320, 255, 1),
(@GUID+8 , 185541, 530, 3519, 1, 1, -3869.19, 3813.33, 293.27, 2.40611, 0, 0, 0.933142, 0.359508, 320, 255, 1),
(@GUID+9 , 185541, 530, 3519, 1, 1, -3928.52, 3803.6, 296.713, 0.84317, 0, 0, 0.409207, 0.912442, 320, 255, 1),
(@GUID+10, 185541, 530, 3519, 1, 1, -4015.58, 3704.01, 296.699, 2.70849, 0, 0, 0.976644, 0.214862, 320, 255, 1),
(@GUID+11, 185541, 530, 3519, 1, 1, -4048.37, 3670.2, 306.466, 5.85008, 0, 0, 0.214865, -0.976644, 320, 255, 1),
(@GUID+12, 185541, 530, 3519, 1, 1, -4035.57, 3604.6, 289.111, 4.36568, 0, 0, 0.818477, -0.57454, 320, 255, 1),
(@GUID+13, 185541, 530, 3519, 1, 1, -4114.9, 3445.98, 291.461, 4.78586, 0, 0, 0.680659, -0.732601, 320, 255, 1),
(@GUID+14, 185541, 530, 3519, 1, 1, -4164.12, 3408.89, 293.794, 5.79116, 0, 0, 0.243536, -0.969892, 320, 255, 1),
(@GUID+15, 185541, 530, 3519, 1, 1, -4145.64, 3367.12, 286.617, 2.18226, 0, 0, 0.88715, 0.461482, 320, 255, 1),
(@GUID+16, 185541, 530, 3519, 1, 1, -4057.38, 3349.27, 285.711, 3.79233, 0, 0, 0.947534, -0.319656, 320, 255, 1),
(@GUID+17, 185541, 530, 3519, 1, 1, -4085.77, 3318.1, 288.168, 4.21251, 0, 0, 0.860035, -0.510236, 320, 255, 1),
(@GUID+18, 185541, 530, 3519, 1, 1, -4134.75, 3296.82, 291.336, 3.47031, 0, 0, 0.986524, -0.163619, 320, 255, 1),
(@GUID+19, 185541, 530, 3519, 1, 1, -4196.13, 3308.13, 284.064, 0.587893, 0, 0, 0.289732, 0.957108, 320, 255, 1),
(@GUID+20, 185541, 530, 3519, 1, 1, -4189.54, 3257.55, 292.043, 2.70455, 0, 0, 0.976219, 0.216787, 320, 255, 1),
(@GUID+21, 185541, 530, 3519, 1, 1, -4087.81, 3247.68, 298.522, 4.46776, 0, 0, 0.788098, -0.61555, 320, 255, 1),
(@GUID+22, 185541, 530, 3519, 1, 1, -4180.37, 3124.99, 321.346, 3.64701, 0, 0, 0.968238, -0.250029, 320, 255, 1),
(@GUID+23, 185541, 530, 3519, 1, 1, -4180.98, 2998.87, 314.479, 6.08959, 0, 0, 0.0966446, -0.995319, 320, 255, 1),
(@GUID+24, 185541, 530, 3519, 1, 1, -4066.43, 3066.54, 318.051, 0.458292, 0, 0, 0.227146, 0.973861, 320, 255, 1),
(@GUID+25, 185541, 530, 3519, 1, 1, -3976.59, 3165.93, 315.712, 0.415095, 0, 0, 0.206061, 0.978539, 320, 255, 1),
(@GUID+26, 185541, 530, 3519, 1, 1, -3913.84, 3258.51, 299.482, 5.97571, 0, 0, 0.153131, -0.988206, 320, 255, 1),
(@GUID+27, 185541, 530, 3519, 1, 1, -3825.82, 3296.92, 276.039, 0.332628, 0, 0, 0.165548, 0.986202, 320, 255, 1),
(@GUID+28, 185541, 530, 3519, 1, 1, -3896.6, 3304.55, 285.785, 3.59988, 0, 0, 0.973861, -0.227146, 320, 255, 1),
(@GUID+29, 185541, 530, 3519, 1, 1, -3888.72, 3199.02, 313.575, 5.30419, 0, 0, 0.470182, -0.88257, 320, 255, 1),
(@GUID+30, 185541, 530, 3519, 1, 1, -3862.88, 3234.32, 308.008, 0.199102, 0, 0, 0.0993868, 0.995049, 320, 255, 1),
(@GUID+31, 185541, 530, 3519, 1, 1, -3777.72, 3341.68, 276.476, 0.937377, 0, 0, 0.451716, 0.892162, 320, 255, 1),
(@GUID+32, 185541, 530, 3519, 1, 1, -3897.6, 3146.29, 326.375, 4.31067, 0, 0, 0.833968, -0.551813, 320, 255, 1),
(@GUID+33, 185541, 530, 3519, 1, 1, -3868.82, 3107.8, 333.388, 4.93506, 0, 0, 0.624167, -0.781291, 320, 255, 1),
(@GUID+34, 185541, 530, 3519, 1, 1, -3919.64, 3054.12, 358.956, 1.711, 0, 0, 0.754898, 0.655842, 320, 255, 1),
(@GUID+35, 185541, 530, 3519, 1, 1, -3994.67, 3021.64, 358.166, 1.28295, 0, 0, 0.598378, 0.801214, 320, 255, 1),
(@GUID+36, 185541, 530, 3519, 1, 1, -4002.35, 3003.2, 361.913, 4.85259, 0, 0, 0.655844, -0.754897, 320, 255, 1),
(@GUID+37, 185541, 530, 3519, 1, 1, -3716.99, 3343.28, 287.33, 0.0734353, 0, 0, 0.0367094, 0.999326, 320, 255, 1),
(@GUID+38, 185541, 530, 3519, 1, 1, -3652.02, 3308.09, 285.399, 0.689972, 0, 0, 0.338184, 0.94108, 320, 255, 1),
(@GUID+39, 185541, 530, 3519, 1, 1, -3689.99, 3391.04, 282.229, 1.88378, 0, 0, 0.808671, 0.588262, 320, 255, 1),
(@GUID+40, 185541, 530, 3519, 1, 1, -3623.51, 3372.87, 294.724, 5.37488, 0, 0, 0.438702, -0.898633, 320, 255, 1),
(@GUID+41, 185541, 530, 3519, 1, 1, -3467.18, 3487.59, 286.371, 4.38136, 0, 0, 0.813945, -0.580942, 320, 255, 1),
(@GUID+42, 185541, 530, 3519, 1, 1, -3642.29, 3189.84, 314.527, 4.04758, 0, 0, 0.899141, -0.437659, 320, 255, 1),
(@GUID+43, 185541, 530, 3519, 1, 1, -4116.15, 3212.55, 299.799, 5.08038, 0, 0, 0.565801, -0.824542, 320, 255, 1),
(@GUID+44, 185541, 530, 3519, 1, 1, -4108.74, 3544.24, 296.961, 1.6953, 0, 0, 0.749729, 0.661745, 320, 255, 1);
