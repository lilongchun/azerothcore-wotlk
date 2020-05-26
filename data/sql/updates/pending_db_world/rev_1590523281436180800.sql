INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590523281436180800');

UPDATE `creature` SET `id` = 40607, `modelid` = 0 WHERE `guid` = 133917;
DELETE FROM `npc_vendor` WHERE `entry` = 40607;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(40607, 0, 40787, 0, 0, 2959, 0),
(40607, 0, 40788, 0, 0, 2959, 0),
(40607, 0, 40789, 0, 0, 2959, 0),
(40607, 0, 40807, 0, 0, 2960, 0),
(40607, 0, 40808, 0, 0, 2960, 0),
(40607, 0, 40809, 0, 0, 2960, 0),
(40607, 0, 40826, 0, 0, 2959, 0),
(40607, 0, 40827, 0, 0, 2959, 0),
(40607, 0, 40828, 0, 0, 2959, 0),
(40607, 0, 40847, 0, 0, 2958, 0),
(40607, 0, 40848, 0, 0, 2958, 0),
(40607, 0, 40849, 0, 0, 2958, 0),
(40607, 0, 40866, 0, 0, 2958, 0),
(40607, 0, 40868, 0, 0, 2958, 0),
(40607, 0, 40869, 0, 0, 2958, 0),
(40607, 0, 40907, 0, 0, 2959, 0),
(40607, 0, 40927, 0, 0, 2960, 0),
(40607, 0, 40933, 0, 0, 2959, 0),
(40607, 0, 40939, 0, 0, 2958, 0),
(40607, 0, 40963, 0, 0, 2958, 0),
(40607, 0, 40992, 0, 0, 2959, 0),
(40607, 0, 40993, 0, 0, 2959, 0),
(40607, 0, 41001, 0, 0, 2960, 0),
(40607, 0, 41007, 0, 0, 2960, 0),
(40607, 0, 41013, 0, 0, 2959, 0),
(40607, 0, 41019, 0, 0, 2959, 0),
(40607, 0, 41027, 0, 0, 2958, 0),
(40607, 0, 41033, 0, 0, 2958, 0),
(40607, 0, 41038, 0, 0, 2958, 0),
(40607, 0, 41044, 0, 0, 2958, 0),
(40607, 0, 41081, 0, 0, 2959, 0),
(40607, 0, 41087, 0, 0, 2959, 0),
(40607, 0, 41137, 0, 0, 2960, 0),
(40607, 0, 41143, 0, 0, 2960, 0),
(40607, 0, 41151, 0, 0, 2959, 0),
(40607, 0, 41157, 0, 0, 2959, 0),
(40607, 0, 41199, 0, 0, 2958, 0),
(40607, 0, 41205, 0, 0, 2958, 0),
(40607, 0, 41211, 0, 0, 2958, 0),
(40607, 0, 41217, 0, 0, 2958, 0),
(40607, 0, 41275, 0, 0, 2958, 0),
(40607, 0, 41281, 0, 0, 2958, 0),
(40607, 0, 41287, 0, 0, 2960, 0),
(40607, 0, 41293, 0, 0, 2960, 0),
(40607, 0, 41298, 0, 0, 2958, 0),
(40607, 0, 41304, 0, 0, 2958, 0),
(40607, 0, 41310, 0, 0, 2959, 0),
(40607, 0, 41316, 0, 0, 2959, 0),
(40607, 0, 41321, 0, 0, 2959, 0),
(40607, 0, 41327, 0, 0, 2959, 0),
(40607, 0, 41650, 0, 0, 2959, 0),
(40607, 0, 41655, 0, 0, 2958, 0),
(40607, 0, 41661, 0, 0, 2959, 0),
(40607, 0, 41667, 0, 0, 2958, 0),
(40607, 0, 41672, 0, 0, 2959, 0),
(40607, 0, 41678, 0, 0, 2959, 0),
(40607, 0, 41683, 0, 0, 2958, 0),
(40607, 0, 41715, 0, 0, 2958, 0),
(40607, 0, 41767, 0, 0, 2960, 0),
(40607, 0, 41773, 0, 0, 2960, 0),
(40607, 0, 41854, 0, 0, 2959, 0),
(40607, 0, 41859, 0, 0, 2959, 0),
(40607, 0, 41864, 0, 0, 2958, 0),
(40607, 0, 41869, 0, 0, 2958, 0),
(40607, 0, 41874, 0, 0, 2960, 0),
(40607, 0, 41915, 0, 0, 2959, 0),
(40607, 0, 41921, 0, 0, 2959, 0),
(40607, 0, 41927, 0, 0, 2958, 0),
(40607, 0, 41934, 0, 0, 2958, 0),
(40607, 0, 41940, 0, 0, 2960, 0),
(40607, 0, 41946, 0, 0, 2959, 0),
(40607, 0, 41953, 0, 0, 2959, 0),
(40607, 0, 41959, 0, 0, 2958, 0),
(40607, 0, 41965, 0, 0, 2958, 0),
(40607, 0, 41971, 0, 0, 2960, 0),
(40607, 0, 41993, 0, 0, 2959, 0),
(40607, 0, 41998, 0, 0, 2959, 0),
(40607, 0, 42005, 0, 0, 2958, 0),
(40607, 0, 42011, 0, 0, 2958, 0),
(40607, 0, 42017, 0, 0, 2960, 0),
(40607, 0, 42579, 0, 0, 2969, 0),
(40607, 0, 42584, 0, 0, 2969, 0),
(40607, 0, 42589, 0, 0, 2969, 0),
(40607, 0, 42598, 0, 0, 2969, 0),
(40607, 0, 42603, 0, 0, 2969, 0),
(40607, 0, 42608, 0, 0, 2969, 0),
(40607, 0, 42615, 0, 0, 2969, 0),
(40607, 0, 42621, 0, 0, 2969, 0),
(40607, 0, 42853, 0, 0, 2969, 0),
(40607, 0, 45706, 0, 0, 2596, 0);
