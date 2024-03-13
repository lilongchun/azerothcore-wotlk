-- DB update 2024_03_08_01 -> 2024_03_08_02
-- Update gameobject 'Chair' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (194360, 194361, 194362, 194363, 194364))
AND (`guid` IN (17806, 17807, 17808, 17809, 17810));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(17806, 194360, 603, 0, 0, 3, 1, 1954.6956787109375, 91.87249755859375, 239.6241607666015625, 5.989951133728027343, 0, 0, -0.14609241485595703, 0.989270925521850585, 7200, 255, 1, "", 47966, NULL),
(17807, 194361, 603, 0, 0, 3, 1, 1961.8349609375, 65.23160552978515625, 239.6471405029296875, 3.686115264892578125, 0, 0, -0.963165283203125, 0.268910109996795654, 7200, 255, 1, "", 47720, NULL),
(17808, 194362, 603, 0, 0, 3, 1, 1886.633544921875, 72.21144866943359375, 239.6241607666015625, 1.713893532752990722, 0, 0, 0.755846977233886718, 0.654748260974884033, 7200, 255, 1, "", 47966, NULL),
(17809, 194363, 603, 0, 0, 3, 1, 1944.32568359375, 106.1580963134765625, 239.6471405029296875, 3.686115264892578125, 0, 0, -0.963165283203125, 0.268910109996795654, 7200, 255, 1, "", 47966, NULL),
(17810, 194364, 603, 0, 0, 3, 1, 1899.227783203125, 45.58289337158203125, 239.6471405029296875, 1.417184114456176757, 0, 0, 0.650765419006347656, 0.759278833866119384, 7200, 255, 1, "", 47966, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (160415, 183751, 183752, 183753, 183754, 183755))
AND (`guid` IN (10857, 10858, 10859, 10860, 10861, 10862));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- this spawn is out of bounds, makes no sense adding it, even if it shows in sniffs
-- (, 158579, 230, 0, 0, 3, 1, 1071.4451904296875, -542.276123046875, -81.8671722412109375, 1.570795774459838867, 0, 0, 0.707106590270996093, 0.707106947898864746, 7200, 255, 1, "", 46779, NULL),
(10857, 160415, 628, 0, 0, 3, 1, 1117.19189453125, -365.67437744140625, 18.84563636779785156, 0.968655109405517578, 0, 0, 0.465613365173339843, 0.884988248348236083, 7200, 255, 1, "", 50375, NULL),
(10858, 183751, 532, 0, 0, 1, 1, -11165.12890625, -1574.0458984375, 278.268157958984375, 1.659516334533691406, 0, 0, 0.737768173217773437, 0.675054192543029785, 7200, 255, 1, "", 50375, NULL),
(10859, 183752, 532, 0, 0, 1, 1, -11170.0029296875, -1576.1551513671875, 278.233856201171875, 3.196491718292236328, 0, 0, -0.99962329864501953, 0.027446011081337928, 7200, 255, 1, "", 50375, NULL),
(10860, 183753, 532, 0, 0, 1, 1, -11182.484375, -1585.8856201171875, 278.252532958984375, 5.610287666320800781, 0, 0, -0.33013725280761718, 0.943932950496673583, 7200, 255, 1, "", 50375, NULL),
(10861, 183754, 532, 0, 0, 1, 1, -11200.525390625, -1600.3330078125, 278.233856201171875, 4.619372367858886718, 0, 0, -0.73921680450439453, 0.673467516899108886, 7200, 255, 1, "", 50375, NULL),
(10862, 183755, 532, 0, 0, 1, 1, -11179.3544921875, -1583.925537109375, 278.233856201171875, 4.619372367858886718, 0, 0, -0.73921680450439453, 0.673467516899108886, 7200, 255, 1, "", 50375, NULL);
