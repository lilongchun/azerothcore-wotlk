--
-- Remove all entries, they will be replaced
DELETE FROM `creature` WHERE `id1`=2955;
DELETE FROM `creature` WHERE `id2`=2955;
DELETE FROM `creature` WHERE `id3`=2955;

-- Corrects spawn points to sniffed values, mostly this was fine, but the XYZ values were done manually rather than from sniffed variables
-- Wander distance was already set to 20, which is a good minimum value, about half of them have a wander value of around 30 or more, the sniff will be uploaded later to the collective if anyone wants to deep dive that for some reason
-- Similarly, 155 was the spawntime set before this fix, 180 is probbably correct, but this is fine imo without dynamic spawning
SET @GUID :=88354;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+96;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2915.9321, -117.10601, 77.61542, 1.884955525398254394, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2915.9321 -117.10601 77.61542
(@GUID+1, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2881.4697, -150.06369, 67.3019, 3.03687286376953125, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2881.4697 -150.06369 67.3019
(@GUID+2, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2983.2869, -181.743, 63.0384, 2.146754980087280273, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2983.2869 -181.743 63.0384
(@GUID+3, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3049.5332, -116.48638, 52.78892, 3.612831592559814453, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3049.5332 -116.48638 52.78892
(@GUID+4, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3084.8281, -151.3636, 47.7102, 1.972222089767456054, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3084.8281 -151.3636 47.7102
(@GUID+5, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3048.971, -183.28185, 59.85856, 1.553343057632446289, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3048.971 -183.28185 59.85856
(@GUID+6, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3016.0718, -217.09685, 56.218082, 4.398229598999023437, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3016.0718 -217.09685 56.218082
(@GUID+7, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2849.0051, -182.61052, 59.357796, 1.692969322204589843, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2849.0051 -182.61052 59.357796
(@GUID+8, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2817.4912, -216.73177, 56.172832, 3.96189737319946289, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2817.4912 -216.73177 56.172832
(@GUID+9, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2848.5728, -316.2174, 55.82892, 1.919862151145935058, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2848.5728 -316.2174 55.82892
(@GUID+10, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2817.3057, -284.28928, 58.999767, 0.261799395084381103, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2817.3057 -284.28928 58.999767
(@GUID+11, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2791.1252, -316.0387, 55.81441, 5.096361160278320312, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2791.1252 -316.0387 55.81441
(@GUID+12, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2816.52, -348.31967, 57.394314, 4.747295379638671875, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2816.52 -348.31967 57.394314
(@GUID+13, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2849.3384, -383.77203, 55.30781, 0.331612557172775268, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2849.3384 -383.77203 55.30781
(@GUID+14, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2883.8289, -350.39417, 55.231503, 4.171336650848388671, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2883.8289 -350.39417 55.231503
(@GUID+15, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2915.2188, -383.69476, 55.308075, 3.124139308929443359, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2915.2188 -383.69476 55.308075
(@GUID+16, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2882.5889, -417.75314, 49.94027, 0, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2882.5889 -417.75314 49.94027
(@GUID+17, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2864.4363, -449.93967, 53.77305, 1.605702877044677734, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2864.4363 -449.93967 53.77305
(@GUID+18, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2883.513, -483.6671, 47.450447, 2.687807083129882812, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2883.513 -483.6671 47.450447
(@GUID+19, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2951.8186, -350.5021, 55.86079, 5.846852779388427734, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2951.8186 -350.5021 55.86079
(@GUID+20, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2983.916, -316.7991, 48.84321, 1.029744267463684082, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2983.916 -316.7991 48.84321
(@GUID+21, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3018.8704, -284.1935, 43.844025, 2.111848354339599609, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3018.8704 -284.1935 43.844025
(@GUID+22, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3050.7756, -317.3549, 42.753426, 0.383972436189651489, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3050.7756 -317.3549 42.753426
(@GUID+23, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3117.3638, -317.11685, 40.205025, 1.815142393112182617, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3117.3638 -317.11685 40.205025
(@GUID+24, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3082.7852, -283.14948, 36.52417, 4.450589656829833984, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3082.7852 -283.14948 36.52417
(@GUID+25, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3082.5708, -350.88812, 36.985973, 0.139626339077949523, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3082.5708 -350.88812 36.985973
(@GUID+26, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3049.2266, -384.4684, 39.612816, 3.682644605636596679, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3049.2266 -384.4684 39.612816
(@GUID+27, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3084.3826, -417.4145, 37.911163, 5.951572895050048828, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3084.3826 -417.4145 37.911163
(@GUID+28, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3116.5625, -383.2819, 41.819256, 2.321287870407104492, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3116.5625 -383.2819 41.819256
(@GUID+29, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3016.7205, -417.2922, 48.25192, 0.575958669185638427, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3016.7205 -417.2922 48.25192
(@GUID+30, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2983.6528, -382.88184, 53.537003, 2.827433347702026367, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2983.6528 -382.88184 53.537003
(@GUID+31, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2984.1338, -450.97092, 46.477955, 4.537856101989746093, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2984.1338 -450.97092 46.477955
(@GUID+32, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2950.2192, -417.1669, 53.86521, 0.104719758033752441, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2950.2192 -417.1669 53.86521
(@GUID+33, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2917.082, -450.50412, 46.918938, 4.78220224380493164, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2917.082 -450.50412 46.918938
(@GUID+34, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2883.351, -549.6797, 51.405052, 5.078907966613769531, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2883.351 -549.6797 51.405052
(@GUID+35, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2850.924, -517.7154, 50.91358, 5.06145477294921875, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2850.924 -517.7154 50.91358
(@GUID+36, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2817.7004, -549.1674, 55.274178, 2.617993831634521484, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2817.7004 -549.1674 55.274178
(@GUID+37, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2851.802, -583.9538, 57.15891, 3.630284786224365234, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2851.802 -583.9538 57.15891
(@GUID+38, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2915.418, -517.8362, 47.194675, 4.380776405334472656, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2915.418 -517.8362 47.194675
(@GUID+39, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2817.2737, -617.9309, 56.016186, 5.619960308074951171, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2817.2737 -617.9309 56.016186
(@GUID+40, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2884.533, -616.6502, 55.083035, 5.969026088714599609, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2884.533 -616.6502 55.083035
(@GUID+41, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2949.897, -615.9156, 39.461315, 2.897246599197387695, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2949.897 -615.9156 39.461315
(@GUID+42, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2915.745, -583.6176, 50.565845, 5.462880611419677734, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2915.745 -583.6176 50.565845
(@GUID+43, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2949.016, -549.3831, 45.385597, 4.049163818359375, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2949.016 -549.3831 45.385597
(@GUID+44, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2983.931, -583.4975, 38.284866, 6.0737457275390625, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2983.931 -583.4975 38.284866
(@GUID+45, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3018.492, -617.0446, 29.809212, 1.256637096405029296, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3018.492 -617.0446 29.809212
(@GUID+46, 2966, 0, 0, 1, 0, 0, 1, 1, 0, -3017.079, -685.03986, 41.89431, 5.432766437530517578, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3017.079 -685.03986 41.89431
(@GUID+47, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3084.279, -682.7648, 31.90988, 0.802851438522338867, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3084.279 -682.7648 31.90988
(@GUID+48, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3050.0088, -650.9782, 29.19056, 0.680678427219390869, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3050.0088 -650.9782 29.19056
(@GUID+49, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3085.173, -617.01215, 34.477776, 5.689773082733154296, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3085.173 -617.01215 34.477776
(@GUID+50, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3116.6624, -649.3928, 32.413265, 1.169370532035827636, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3116.6624 -649.3928 32.413265
(@GUID+51, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3116.1125, -714.4594, 33.46272, 0.942477762699127197, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3116.1125 -714.4594 33.46272
(@GUID+52, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3148.6108, -683.60284, 23.079771, 3.141592741012573242, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3148.6108 -683.60284 23.079771
(@GUID+53, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3182.7786, -716.07, 26.982426, 4.537856101989746093, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3182.7786 -716.07 26.982426
(@GUID+54, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3148.8203, -615.4817, 35.513004, 2.356194496154785156, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3148.8203 -615.4817 35.513004
(@GUID+55, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3117.3677, -251.52632, 41.896477, 2.722713708877563476, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3117.3677 -251.52632 41.896477
(@GUID+56, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3150.7246, -216.66353, 43.11533, 1.029744267463684082, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3150.7246 -216.66353 43.11533
(@GUID+57, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3182.763, -249.51974, 40.0922, 0.628318548202514648, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3182.763 -249.51974 40.0922
(@GUID+58, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3184.1643, -317.5604, 37.124756, 5.707226753234863281, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3184.1643 -317.5604 37.124756
(@GUID+59, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3150.1514, -285.3053, 39.282925, 3.089232683181762695, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3150.1514 -285.3053 39.282925
(@GUID+60, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3149.0168, -349.84933, 34.957115, 4.660028934478759765, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3149.0168 -349.84933 34.957115
(@GUID+61, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3215.4568, -217.2468, 31.292675, 4.328416347503662109, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3215.4568 -217.2468 31.292675
(@GUID+62, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3182.377, -184.5408, 41.331944, 1.692969322204589843, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3182.377 -184.5408 41.331944
(@GUID+63, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3215.015, -284.60513, 30.6046, 4.590215682983398437, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3215.015 -284.60513 30.6046
(@GUID+64, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3284.4084, -217.13043, 39.615646, 3.787364482879638671, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3284.4084 -217.13043 39.615646
(@GUID+65, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3284.5642, -282.64816, 37.027092, 2.199114799499511718, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3284.5642 -282.64816 37.027092
(@GUID+66, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3214.8604, -347.4374, 28.102503, 5.969026088714599609, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3214.8604 -347.4374 28.102503
(@GUID+67, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3248.986, -316.8644, 32.329453, 4.886921882629394531, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3248.986 -316.8644 32.329453
(@GUID+68, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3282.3496, -350.19608, 43.65876, 2.39110112190246582, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3282.3496 -350.19608 43.65876
(@GUID+69, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3249.6396, -384.67285, 31.974255, 2.0245819091796875, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3249.6396 -384.67285 31.974255
(@GUID+70, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3281.6199, -417.9758, 36.595318, 0.122173048555850982, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3281.6199 -417.9758 36.595318
(@GUID+71, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3215.3584, -416.1518, 25.393665, 2.356194496154785156, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3215.3584 -416.1518 25.393665
(@GUID+72, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3248.7173, -450.7054, 28.379059, 1.48352980613708496, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3248.7173 -450.7054 28.379059
(@GUID+73, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3216.2603, -483.22516, 24.11747, 4.310963153839111328, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3216.2603 -483.22516 24.11747
(@GUID+74, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3249.8452, -516.86914, 27.956903, 5.393067359924316406, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3249.8452 -516.86914 27.956903
(@GUID+75, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3150.8284, -482.7306, 30.151358, 1.884955525398254394, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3150.8284 -482.7306 30.151358
(@GUID+76, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3149.8757, -417.15897, 31.773283, 4.590215682983398437, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3149.8757 -417.15897 31.773283
(@GUID+77, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3115.8054, -449.89996, 29.697945, 3.735004663467407226, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3115.8054 -449.89996 29.697945
(@GUID+78, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3083.3086, -483.736, 31.280085, 3.560471534729003906, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3083.3086 -483.736 31.280085
(@GUID+79, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3118.7922, -516.90375, 34.351627, 0.03490658476948738, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3118.7922 -516.90375 34.351627
(@GUID+80, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3148.536, -550.18274, 30.679869, 2.443460941314697265, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3148.536 -550.18274 30.679869
(@GUID+81, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3116.379, -583.2126, 34.0221, 4.886921882629394531, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3116.379 -583.2126 34.0221
(@GUID+82, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3217.4094, -616.01, 28.73066, 3.665191411972045898, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3217.4094 -616.01 28.73066
(@GUID+83, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3216.0747, -548.41754, 25.538637, 4.834561824798583984, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3216.0747 -548.41754 25.538637
(@GUID+84, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3282.0308, -550.7741, 46.280766, 1.151917338371276855, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3282.0308 -550.7741 46.280766
(@GUID+85, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3280.8374, -617.0858, 35.034283, 4.345870018005371093, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3280.8374 -617.0858 35.034283
(@GUID+86, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3248.9495, -581.88226, 30.587183, 4.677482128143310546, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3248.9495 -581.88226 30.587183
(@GUID+87, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3281.4895, -683.2465, 39.041134, 1.675516128540039062, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3281.4895 -683.2465 39.041134
(@GUID+88, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3247.2446, -649.0194, 30.383823, 4.328416347503662109, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3247.2446 -649.0194 30.383823
(@GUID+89, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3215.3052, -682.5738, 29.801714, 2.042035102844238281, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3215.3052 -682.5738 29.801714
(@GUID+90, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3247.6877, -714.72, 36.439972, 2.652900457382202148, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3247.6877 -714.72 36.439972
(@GUID+91, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3182.1843, -648.84247, 29.093792, 1.169370532035827636, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3182.1843 -648.84247 29.093792
(@GUID+92, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3051.3738, -582.958, 25.07603, 1.535889744758605957, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3051.3738 -582.958 25.07603
(@GUID+93, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3015.6433, -549.345, 31.536392, 0.401425719261169433, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -3015.6433 -549.345 31.536392
(@GUID+94, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2949.265, -482.95715, 43.765648, 3.089232683181762695, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2949.265 -482.95715 43.765648
(@GUID+95, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -2984.5002, -517.8174, 39.379818, 3.141592741012573242, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0), -- .go xyz -2984.5002 -517.8174 39.379818
(@GUID+96, 2955, 0, 0, 1, 0, 0, 1, 1, 0, -3016.3232, -483.44913, 36.235992, 0.663225114345550537, 155, 20, 0, 1, 0, 1, 0, 0, 0, '', 0); -- .go xyz -3016.3232 -483.44913 36.235992
