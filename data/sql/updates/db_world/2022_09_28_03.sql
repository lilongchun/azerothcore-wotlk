-- DB update 2022_09_28_02 -> 2022_09_28_03
-- Affected rows: 106
UPDATE `creature_template` SET `dmgschool`=6 WHERE `entry` IN (15527, 16488, 16489, 16529, 16530, 17096, 17283, 18405, 18429, 18805, 18864, 18865, 19205, 20252, 20478, 20702, 21521, 21578, 22244, 24744, 25573);
UPDATE `creature_template` SET `dmgschool`=5 WHERE `entry` IN (521, 3470, 8538, 10389, 11284, 14389, 14686, 14986, 15146, 18341, 18401, 18472, 18659, 18701, 18703, 19206, 19307, 19480, 19668, 20265, 20267, 20689, 20700, 20705, 20778, 20779, 20870, 20875, 21101, 21346, 21604, 21612, 21620, 21626, 21941, 22929, 23498, 25772, 34035, 34171);
UPDATE `creature_template` SET `dmgschool`=4 WHERE `entry` IN (691, 2761, 5461, 5462, 10388, 11256, 14457, 14458, 17153, 17155, 17207, 17917, 18101, 19204, 19653, 20079, 20090, 20627, 20704, 20792, 21059, 21428, 21695, 21696, 21728, 21730, 21916, 21917, 22035, 22309, 22875, 25040, 32630);
UPDATE `creature_template` SET `dmgschool`=3 WHERE `entry` IN (832, 2762, 6239, 13282, 13456, 13696, 14454, 14455, 16901, 16903, 17085, 17154, 17158, 17159, 17160, 17356, 17357, 18102, 18145, 20565, 20566, 20774, 20908, 21060, 21617, 21707, 22036, 22310, 22878, 22881, 22883, 34004, 34005);
UPDATE `creature_template` SET `dmgschool`=2 WHERE `entry` IN (575, 2745, 2760, 4036, 4037, 4038, 5850, 5893, 5896, 8281, 8908, 8909, 8910, 8911, 9017, 9878, 9879, 10756, 10757, 11666, 11667, 11668, 11673, 12056, 12143, 12265, 14460, 14461, 15438, 17454, 17908, 18100, 19203, 20481, 20514, 20703, 21061, 21538, 21706, 22286, 22298, 22311, 22323, 22997, 23192, 30643, 31317);
