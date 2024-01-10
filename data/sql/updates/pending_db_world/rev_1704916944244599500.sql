-- Update 'Magical Menagerie' Cosmetic creature spawns with sniffed values
DELETE FROM `creature` WHERE (`id1` IN (31795, 31796, 31709, 31710, 31711, 31714, 31719, 31728, 31729, 31730, 31732, 31733, 31735, 31740, 31741, 31742)) AND (`guid` IN (100693, 100774, 117101, 117166, 117221, 117622, 117880, 118577, 118687, 118745, 118867, 118880, 119351, 120256, 120411, 120515));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(100693, 31795, 571, 1, 1, 0, 5843.26123046875, 563.841796875, 653.23895263671875, 0.226892799139022827, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(100774, 31796, 571, 1, 1, 0, 5853.2626953125, 576.4080810546875, 653.99591064453125, 5.654866695404052734, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(117101, 31709, 571, 1, 1, 0, 5841.44091796875, 561.623291015625, 653.25286865234375, 4.747295379638671875, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(117166, 31710, 571, 1, 1, 0, 5853.4375, 563.98089599609375, 653.25286865234375, 1.256637096405029296, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(117221, 31711, 571, 1, 1, 0, 5849.7724609375, 571.70831298828125, 653.4473876953125, 3.96189737319946289, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(117622, 31714, 571, 1, 1, 0, 5851.6484375, 561.7413330078125, 653.24591064453125, 4.084070205688476562, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(117880, 31719, 571, 1, 1, 0, 5838.8857421875, 554.9130859375, 654.69732666015625, 5.567600250244140625, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(118577, 31728, 571, 1, 1, 0, 5858.50830078125, 570.294921875, 654.00286865234375, 2.600540637969970703, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(118687, 31729, 571, 1, 1, 0, 5853.3984375, 564.296630859375, 653.8431396484375, 3.490658521652221679, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(118745, 31730, 571, 1, 1, 0, 5847.25, 554.0838623046875, 654.0306396484375, 0.855211317539215087, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(118867, 31732, 571, 1, 1, 0, 5859.31005859375, 573.16375732421875, 653.7667236328125, 3.839724302291870117, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(118880, 31733, 571, 1, 1, 0, 5851.462890625, 574.11517333984375, 653.42645263671875, 0.506145477294921875, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(119351, 31735, 571, 1, 1, 0, 5859.35791015625, 573.21661376953125, 652.75982666015625, 2.58308720588684082, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(120256, 31740, 571, 1, 1, 0, 5858.958984375, 570.02239990234375, 654.961181640625, 2.932153224945068359, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(120411, 31741, 571, 1, 1, 0, 5859.6298828125, 569.32440185546875, 654.00286865234375, 4.764749050140380859, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(120515, 31742, 571, 1, 1, 0, 5838.4833984375, 558.2471923828125, 654.00286865234375, 0, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL);
