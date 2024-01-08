-- DB update 2023_12_12_07 -> 2023_12_12_08
-- Update creature 26401 'Summer Scorchling' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 26401) AND (`guid` IN (86242, 86243, 86244, 86245, 86246, 86247, 86248, 86250, 86251, 86252, 86253, 86254, 86255, 86256, 86259, 86260, 86261, 86262, 86266, 86267, 86268));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(86242, 26401, 1, 1, 1, 0, 9781.1103515625, 1014.0506591796875, 1299.7325439453125, 6.195918560028076171, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86243, 26401, 1, 1, 1, 0, -60.6233291625976562, 1257.71923828125, 90.39239501953125, 2.984513044357299804, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86244, 26401, 1, 1, 1, 0, -3450.724609375, -4223.07763671875, 11.30528640747070312, 2.617993831634521484, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86245, 26401, 0, 1, 1, 0, -1208.2412109375, -2664.67626953125, 45.48974990844726562, 5.934119224548339843, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86246, 26401, 0, 1, 1, 0, -14298.2265625, 55.34860610961914062, 1.575636267662048339, 2.548180580139160156, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86247, 26401, 0, 1, 1, 0, -612.23529052734375, -547.71807861328125, 36.52710342407226562, 4.520402908325195312, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86248, 26401, 0, 1, 1, 0, -3442.657958984375, -947.76812744140625, 9.999930381774902343, 4.101523876190185546, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86250, 26401, 0, 1, 1, 0, -9386.228515625, 26.15180397033691406, 60.80147933959960937, 4.520402908325195312, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86251, 26401, 0, 1, 1, 0, -9425.8212890625, -2119.199951171875, 66.50519561767578125, 4.17939, 120, 0, 0, 0, 0, 0, "", 50063, 1, "orientation corrected manually (not sniffed)"),
(86252, 26401, 0, 1, 1, 0, 183.0362396240234375, -2129.666748046875, 103.0820159912109375, 3.665191411972045898, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86253, 26401, 0, 1, 1, 0, -10645.77734375, 1061.61572265625, 33.19464874267578125, 5.497786998748779296, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86254, 26401, 0, 1, 1, 0, -5415.36181640625, -497.513824462890625, 396.788787841796875, 4.764749050140380859, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86255, 26401, 0, 1, 1, 0, -5243.61181640625, -2892.8017578125, 338.306884765625, 1.93731546401977539, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86256, 26401, 0, 1, 1, 0, -10697.6162109375, -1158.414306640625, 25.09402847290039062, 3.90954, 120, 0, 0, 0, 0, 0, "", 50063, 1, "orientation corrected manually (not sniffed)"),
(86259, 26401, 0, 1, 1, 0, -10943.697265625, -3228.098388671875, 41.52805328369140625, 4.520402908325195312, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86260, 26401, 1, 1, 1, 0, -6776.6474609375, 532.37774658203125, -1.19517350196838378, 3.211405754089355468, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86261, 26401, 1, 1, 1, 0, 6854.21728515625, -4755.90380859375, 696.802490234375, 0.890117883682250976, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86262, 26401, 1, 1, 1, 0, -7223.92333984375, -3861.275390625, 11.623138427734375, 3.892084121704101562, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86266, 26401, 1, 1, 1, 0, 2565.9814453125, -479.263214111328125, 108.92437744140625, 1.675516128540039062, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86267, 26401, 1, 1, 1, 0, 6314.423828125, 521.31195068359375, 18.34495735168457031, 1.343903541564941406, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(86268, 26401, 530, 1, 1, 0, -524.69891357421875, 2326.219482421875, 39.19670486450195312, 3.59537816047668457, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 26401) AND (`guid` BETWEEN 12687 AND 12706);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12687, 26401, 0, 1, 1, 0, -8261.720703125, -2618.029541015625, 133.7710723876953125, 1.343903541564941406, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12688, 26401, 0, 1, 1, 0, 1009.16253662109375, -1451.0050048828125, 62.07862472534179687, 5.16617441177368164, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12689, 26401, 1, 1, 1, 0, -4398.87939453125, 3476.787109375, 11.54022502899169921, 5.864306449890136718, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12690, 26401, 530, 1, 1, 0, -2231.830322265625, -11895.99609375, 26.59745025634765625, 4.694935798645019531, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12691, 26401, 530, 1, 1, 0, -2514.7001953125, 7556.93212890625, -1.79236471652984619, 5.375614166259765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12692, 26401, 530, 1, 1, 0, -3000.531982421875, 4166.52880859375, 4.958461284637451171, 0.593411922454833984, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12693, 26401, 530, 1, 1, 0, -3948.35986328125, 2045.0777587890625, 95.1881103515625, 4.520402908325195312, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12694, 26401, 530, 1, 1, 0, -4218.193359375, -12307.73046875, 2.429591178894042968, 5.934119224548339843, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12695, 26401, 530, 1, 1, 0, -517.99908447265625, 2337.170654296875, 37.98640823364257812, 1.020272254943847656, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12696, 26401, 530, 1, 1, 0, 194.09649658203125, 6019.69091796875, 22.19038772583007812, 6.161012172698974609, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12697, 26401, 530, 1, 1, 0, 2025.9322509765625, 6593.35107421875, 135.63983154296875, 5.934119224548339843, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12698, 26401, 530, 1, 1, 0, 3127.916748046875, 3746.1259765625, 141.725860595703125, 6.161012172698974609, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12699, 26401, 571, 1, 1, 0, 2464.73583984375, -4894.6826171875, 262.607513427734375, 2.30383467674255371, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12700, 26401, 571, 1, 1, 0, 3398.714599609375, -2892.38232421875, 201.8875274658203125, 2.30383467674255371, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12701, 26401, 571, 1, 1, 0, 3937.900390625, -592.607177734375, 241.169891357421875, 5.951572895050048828, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12702, 26401, 571, 1, 1, 0, 4132.59375, 5391.90771484375, 26.4304656982421875, 3.59537816047668457, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12703, 26401, 571, 1, 1, 0, 5142.75244140625, -682.16619873046875, 170.015838623046875, 5.951572895050048828, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12704, 26401, 571, 1, 1, 0, 5372.826171875, 4833.00732421875, -198.048736572265625, 6.230008602142333984, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12705, 26401, 571, 1, 1, 0, 5624.93603515625, -2616.33642578125, 292.582763671875, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12706, 26401, 571, 1, 1, 0, 6084.76904296875, -1104.1611328125, 418.51953125, 1.099557399749755859, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 26401));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` = 26401);
