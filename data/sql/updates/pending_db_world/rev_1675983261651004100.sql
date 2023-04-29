--

DELETE FROM `creature_template_addon` WHERE `entry` IN (32838,34679,29945,29855,28857,27351,25196,37993, 37998, 1312, 4984, 5510, 5516, 12791, 13358, 13359, 14489, 25195,28049);
INSERT INTO `creature_template_addon` (`entry`, `bytes2`, `emote`) VALUES
(14489,2,0),
(13359,2,0),
(13358,2,0),
(12791,258,0),
(5516,2,0),
(5510,2,0),
(4984,2,0),
(1312,2,0),
(37993,2,0),
(37998,2,0),
(25195,2,0),
(25196,2,0),
(27351,2,214),
(28049,2,0),
(28857,2,0),
(29855,2,0),
(29945,2,0),
(32838,2,0),
(34679,2,0);

UPDATE `creature_template_addon` SET `bytes2`=2 WHERE `entry` IN (18965,18970,31294,37144,37146,32710,32711);
UPDATE `creature` SET `equipment_id`=-1 WHERE `id1` IN (27553,27560,27557,31563,25242,25243,25275,19068,16582,16842,16580,18240,17138,25962,19048,19792,18489,20203,19610,19737,19995,19362,21742,21717,22016,22018);
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (27588,16842, 28596, 28569, 18301, 19147, 21114, 21254);
UPDATE `creature_equip_template` SET `ItemID1`=34681 WHERE `CreatureID` IN (27573) AND `ID`=1;
DELETE FROM `creature_equip_template` WHERE `CreatureID`IN (27588,27553,27560,27557,31563,25242,25243,25275,28596, 28569, 18301, 19147, 21114, 21254, 19068,16582,16842,16580,18240,17138,25962,19048,19792,18489,20203,19610,19737,19995,19362,21742,21717,25994,22016,22018);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`) VALUES
(19068, 4, 14877, 14877, 5260), -- 19068
(19068, 3, 18062, 0, 5260), -- 19068
(19068, 2, 17383, 0, 5260), -- 19068
(19068, 1, 10898, 12456, 5260), -- 19068
(18489, 4, 14877, 14877, 5260), -- 18489
(18489, 3, 18062, 0, 5260), -- 18489
(18489, 2, 17383, 0, 5260), -- 18489
(18489, 1, 10898, 12456, 5260), -- 18489
(20203, 3, 1911, 0, 0), -- 20203
(20203, 2, 2704, 0, 0), -- 20203
(20203, 1, 1903, 0, 0), -- 20203
(19610, 3, 1903, 0, 0), -- 19610
(19610, 2, 4994, 0, 0), -- 19610
(19610, 1, 1910, 0, 0), -- 19610
(19737, 2, 4994, 0, 0), -- 19737
(19737, 1, 1903, 0, 0), -- 19737
(25994, 1, 1906, 2081, 0), -- 25994
(25994, 2, 2200, 0, 0), -- 25994
(19995, 3, 2703, 13407, 5870), -- 19995
(19995, 2, 2703, 13406, 5870), -- 19995
(19995, 1, 14874, 0, 5870), -- 19995
(19362, 4, 30181, 21549, 2507), -- 19362
(19362, 3, 30180, 30180, 2507), -- 19362
(19362, 2, 30178, 0, 2507), -- 19362
(19362, 1, 30179, 0, 2507), -- 1936
(21742, 2, 5956, 24322, 0), -- 21742
(21742, 1, 27405, 24322, 0), -- 21742
(21717, 5, 5956, 0, 0), -- 21717
(21717, 4, 31600, 31600, 0), -- 21717
(21717, 3, 31601, 0, 0), -- 21717
(21717, 2, 31603, 31603, 0), -- 21717
(21717, 1, 31600, 31466, 0), -- 21717
(22016, 4, 31206, 31466, 0), -- 22016
(22016, 3, 31208, 0, 0), -- 22016
(22016, 2, 31207, 0, 0), -- 22016
(22016, 1, 31205, 31205, 0), -- 22016
(22018, 4, 12403, 0, 0), -- 22018
(22018, 3, 30636, 0, 0), -- 22018
(22018, 2, 25758, 0, 0), -- 22018
(22018, 1, 27405, 24328, 0), -- 22018
(19792, 7, 30179, 21549, 0), -- 19792
(19792, 6, 29417, 0, 0), -- 19792
(19792, 5, 2028, 0, 0), -- 19792
(19792, 4, 27405, 24328, 0), -- 19792
(19792, 3, 25758, 0, 0), -- 19792
(19792, 2, 30636, 0, 0), -- 19792
(19792, 1, 23225, 0, 0), -- 19792
(19048, 2, 1903, 0, 0), -- 19048
(19048, 1, 1910, 0, 0), -- 19048
(25962, 1, 2200, 0, 0), -- 25962
(25962, 2, 1906, 2081, 0), -- 25962
(17138, 5, 5289, 0, 0), -- 17138
(17138, 4, 14475, 0, 0), -- 17138
(17138, 3, 5287, 0, 0), -- 17138
(17138, 2, 5288, 0, 0), -- 17138
(17138, 1, 14643, 0, 0), -- 17138
(18240, 6, 6233, 0, 0), -- 18240
(18240, 5, 12868, 0, 0), -- 18240
(18240, 4, 3362, 0, 0), -- 18240
(18240, 3, 3351, 0, 0), -- 18240
(18240, 2, 3346, 0, 0), -- 18240
(18240, 1, 3367, 0, 0), -- 18240
(16580, 1, 10898, 12456, 5260), -- 16580
(16580, 2, 21465, 12452, 5260), -- 16580
(16582, 2, 10898, 12456, 13924), -- 16582
(16582, 1, 18062, 0, 13924), -- 16582
(16842, 2, 1905, 2558, 0), -- 16842
(16842, 1, 1901, 1901, 0), -- 16842
(28596, 1, 5292, 0, 0), -- 28596
(28569, 1, 5292, 0, 0), -- 28569
(18301, 1, 3351, 0, 0), -- 18301
(19147, 1, 2704, 0, 0), -- 19147
(21114, 1, 1911, 0, 0), -- 21114
(21254, 1, 3350, 0, 0), -- 21254
(27588, 1, 21573, 21572, 21564), -- 27588
(27553, 3, 34682, 12452, 0), -- 27553
(27553, 2, 34681, 12452, 0), -- 27553
(27553, 1, 30181, 12452, 0), -- 27553
(27560, 4, 36790, 0, 0), -- 27560
(27560, 3, 36791, 0, 0), -- 27560
(27560, 2, 36792, 0, 0), -- 27560
(27560, 1, 28914, 0, 0), -- 27560
(27557, 2, 34682, 0, 0), -- 27557
(27557, 1, 34681, 0, 0), -- 27557
(31563, 3, 34637, 34637, 5260), -- 31563
(31563, 2, 34639, 0, 5260), -- 31563
(31563, 1, 34640, 21549, 5260), -- 31563
(25242, 4, 34637, 34637, 42921), -- 25242
(25242, 3, 34639, 0, 42921), -- 25242
(25242, 2, 34640, 21549, 42921), -- 25242
(25242, 1, 8178, 0, 42921), -- 25242
(25243, 2, 34681, 0, 5260), -- 25243
(25243, 1, 34682, 34682, 5260), -- 25243
(25275, 2, 1903, 13611, 0), -- 25275
(25275, 1, 35312, 9701, 0); -- 25275

DELETE FROM `creature_equip_template` WHERE `CreatureID`=38493;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`) VALUES
(38493, 1, 40595, 49933, 0), -- 38493
(38493, 2, 46107, 49933, 0); -- 38493
UPDATE `creature` SET `equipment_id`=2 WHERE `guid` IN (246904,246905,246915);

UPDATE `creature` SET `equipment_id`=-1 WHERE `id1` IN (1976, 14901, 23745, 24015, 24062, 24212, 28579, 32710, 32711, 34838); 
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (1976, 14901, 23745, 24015, 24062, 24212, 28579, 32710, 32711, 34838);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`) VALUES
(1976, 1, 1899, 143, 0),
(1976, 2, 2715, 143, 0),
(14901, 1, 12629, 0, 0),
(14901, 2, 1910, 13605, 0),
(23745, 1, 6228, 0, 0),
(23745, 2, 2023, 0, 0),
(24015, 1, 34818, 0, 0),
(24015, 2, 34817, 0, 0),
(24015, 3, 34819, 0, 0),
(24015, 4, 34819, 33212, 0),
(24015, 5, 34820, 0, 0),
(24015, 6, 34816, 0, 0),
(24015, 7, 34821, 0, 0),
(24062, 1, 1910, 0, 0),
(24062, 2, 2704, 0, 0),
(24212, 1, 1983, 0, 0),
(24212, 2, 1910, 0, 0),
(28579, 1, 39359, 0, 0),
(28579, 2, 33594, 33594, 0),
(32710, 1, 0, 0, 44635),
(32710, 2, 0, 0, 44643),
(32711, 1, 0, 0, 44643),
(32711, 2, 0, 0, 44635),
(34838, 1, 34817, 0, 0),
(34838, 2, 40894, 13407, 0),
(34838, 3, 34816, 34819, 0), 
(34838, 4, 34821, 34816, 0), 
(34838, 5, 34819, 33212, 0),
(34838, 6, 34818, 0, 0);

UPDATE `creature` SET `equipment_id` = 0 WHERE `id1` IN (6500,5405,6513,9600,4075,3819);
