-- DB update 2022_11_05_00 -> 2022_11_05_01

-- Set CALLKILLEDMONSTER non repeteable
UPDATE `smart_scripts` SET `event_flags` = `event_flags`|1 WHERE `entryorguid` IN (21859, 21846) AND `source_type`=0 AND `id`=0 AND `link`=1;

-- Add spawns imported from TC
DELETE FROM `creature` WHERE `id1` IN (21846, 21859) AND `id2` IN (21846, 21859) AND `guid` BETWEEN @GUID+0 AND @GUID+35;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`) VALUES
(@GUID+0 , 21846, 21859, 530, 3519, 0, 1, 1, -3780.56, 5215.07, -23.1934, 0.0349066, 7, 0),
(@GUID+1 , 21846, 21859, 530, 3519, 0, 1, 1, -3777.38, 5184.86, -24.4552, 3.9968, 7, 0),
(@GUID+2 , 21846, 21859, 530, 3519, 0, 1, 1, -3772.17, 5211.63, -22.8059, 5.49779, 7, 0),
(@GUID+3 , 21846, 21859, 530, 3519, 0, 1, 1, -3770.83, 5121.01, -21.4213, 0.959931, 7, 0),
(@GUID+4 , 21846, 21859, 530, 3519, 0, 1, 1, -3766.29, 5062.47, -18.9817, 3.57792, 7, 0),
(@GUID+5 , 21846, 21859, 530, 3519, 0, 1, 1, -3764.99, 5095.88, -19.0595, 0.122173, 7, 0),
(@GUID+6 , 21846, 21859, 530, 3519, 0, 1, 1, -3762.46, 5171.85, -22.9264, 1.0821, 7, 0),
(@GUID+7 , 21846, 21859, 530, 3519, 0, 1, 1, -3759.02, 5140.41, -22.8351, 4.81711, 7, 0),
(@GUID+8 , 21846, 21859, 530, 3519, 0, 1, 1, -3758.07, 5261.12, -15.3995, 2.77507, 7, 0),
(@GUID+9 , 21846, 21859, 530, 3519, 0, 1, 1, -3753.9, 5294.92, -16.9184, 1.43117, 7, 0),
(@GUID+10, 21846, 21859, 530, 3519, 0, 1, 1, -3753.17, 5078.65, -18.2274, 0.872665, 7, 0),
(@GUID+11, 21846, 21859, 530, 3519, 0, 1, 1, -3750.03, 5125.17, -21.9827, 5.35816, 7, 0),
(@GUID+12, 21846, 21859, 530, 3519, 0, 1, 1, -3749.58, 5195.27, -22.6601, 3.68264, 7, 0),
(@GUID+13, 21846, 21859, 530, 3519, 0, 1, 1, -3741.7, 5160.73, -22.2081, 4.50295, 7, 0),
(@GUID+14, 21846, 21859, 530, 3519, 0, 1, 1, -3741.05, 5171.27, -21.8304, 2.14675, 7, 0),
(@GUID+15, 21846, 21859, 530, 3519, 0, 1, 1, -3739.48, 5271.71, -16.0977, 0.523599, 7, 0),
(@GUID+16, 21846, 21859, 530, 3519, 0, 1, 1, -3734.78, 5327.33, -13.0874, 3.9619, 7, 0),
(@GUID+17, 21846, 21859, 530, 3519, 0, 1, 1, -3733.21, 5061.52, -17.6918, 0.628319, 7, 0),
(@GUID+18, 21846, 21859, 530, 3519, 0, 1, 1, -3731.54, 5160.66, -22.2169, 3.4383, 7, 0),
(@GUID+19, 21846, 21859, 530, 3519, 0, 1, 1, -3726.95, 5263.67, -17.9404, 3.66519, 7, 0),
(@GUID+20, 21846, 21859, 530, 3519, 0, 1, 1, -3721.04, 5275.86, -18.5205, 1.25664, 7, 0),
(@GUID+21, 21846, 21859, 530, 3519, 0, 1, 1, -3720.57, 5205.87, -20.2053, 2.53073, 7, 0),
(@GUID+22, 21846, 21859, 530, 3519, 0, 1, 1, -3718.09, 5217.56, -21.3539, 2.75762, 7, 0),
(@GUID+23, 21846, 21859, 530, 3519, 0, 1, 1, -3713.32, 5257.14, -20.3728, 3.82227, 7, 0),
(@GUID+24, 21846, 21859, 530, 3519, 0, 1, 1, -3711.44, 5290.39, -18.9303, 0.0698132, 7, 0),
(@GUID+25, 21846, 21859, 530, 3519, 0, 1, 1, -3691.57, 5220.81, -21.1431, 2.54818, 7, 0),
(@GUID+26, 21846, 21859, 530, 3519, 0, 1, 1, -3689.51, 5295.31, -20.0296, 3.33358, 7, 0),
(@GUID+27, 21846, 21859, 530, 3519, 0, 1, 1, -3688.32, 5336.11, -15.1771, 3.735, 7, 0),
(@GUID+28, 21846, 21859, 530, 3519, 0, 1, 1, -3687.49, 5351.75, -13.172, 3.1765, 7, 0),
(@GUID+29, 21846, 21859, 530, 3519, 0, 1, 1, -3679.08, 5287.66, -20.6681, 0.0698132, 7, 0),
(@GUID+30, 21846, 21859, 530, 3519, 0, 1, 1, -3678.04, 5293.5, -20.3924, 1.78024, 7, 0),
(@GUID+31, 21846, 21859, 530, 3519, 0, 1, 1, -3676.77, 5334.48, -16.1081, 0.575959, 7, 0),
(@GUID+32, 21846, 21859, 530, 3519, 0, 1, 1, -3643.76, 5323.48, -18.2017, 4.08407, 7, 0),
(@GUID+33, 21846, 21859, 530, 3519, 0, 1, 1, -3640.03, 5318.27, -19.0845, 3.38594, 7, 0),
(@GUID+34, 21846, 21859, 530, 3519, 0, 1, 1, -3634.82, 5283.14, -21.9279, 4.5204, 7, 0),
(@GUID+35, 21846, 21859, 530, 3519, 0, 1, 1, -3783.05, 5215.14, -23.515, 1.76278, 7, 0);
