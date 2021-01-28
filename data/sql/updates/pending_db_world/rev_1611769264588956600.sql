INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611769264588956600');

ALTER TABLE `creature_template` ADD COLUMN `spell_school_immune_mask` INT(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `mechanic_immune_mask`;

-- Imported from TrinityCore
-- SPELL_SCHOOL_NORMAL
UPDATE `creature_template` SET `spell_school_immune_mask` = 1 WHERE `entry` = 11284;

-- SPELL_SCHOOL_FIRE
UPDATE `creature_template` SET `spell_school_immune_mask` = 4 WHERE `entry` IN (89,575,2091,2108,2447,2726,2745,2760,3417,4036,4037,4038,4676,5850,5852,5893,5896,6073,6520,6073,6520,6521,7135,7136,7137,7266,7738,7846,8281,8608,8616,8680,8909,8910,8911,9016,9017,9026,9178,9376,9816,9878,9879,11502,11583,11666,11667,11668,11981,11983,12056,12143,12265,13020,14460,14461,14601,14668,15203,15209,15438,17003,19203,19973,21706,22323,20703,25001,25417,30847);

-- SPELL_SCHOOL_NATURE
UPDATE `creature_template` SET `spell_school_immune_mask` = 8 WHERE `entry` IN (92,832,2258,2592,2735,2736,2752,2762,2791,4034,4035,4499,4526,5855,5898,5902,6239,8667,9377,9397,11321,11576,11577,11578,11744,11745,11777,11778,11783,11784,12201,12237,14399,14400,14435,14454,14455,14478,14887,14888,14889,14890,15352,16043,17085,17154,17156,17157,17158,17159,17160,18062,18181,21707,23029,11779,22036,26407,28411,28585,28825);

-- SPELL_SCHOOL_FROST
UPDATE `creature_template` SET `spell_school_immune_mask` = 16 WHERE `entry` IN (510,691,2761,2776,2794,3851,3861,3917,3950,4978,5461,5462,5894,5895,5897,6047,6220,6748,7079,7132,7428,7429,8519,8520,8521,8522,8837,9453,10198,10642,10756,10757,10955,11256,11862,12759,12876,13278,13279,13280,13282,13322,13456,13696,13736,14269,14350,14457,14458,15211,15305,17153,17155,17167,17358,19204,21428,21728,22009,22309,17207,26342,26341,26340,26339,26338,20704,22035,16570,25740,25755,25756,25757,25865,26116,26178,26204,26214,26215,26216,24228,24601,25226,25514,25715,26316,30846);

-- SPELL_SCHOOL_SHADOW
UPDATE `creature_template` SET `spell_school_immune_mask` = 32 WHERE `entry` IN (703,1043,1364,19206,20705);

-- SPELL_SCHOOL_ARCANE
UPDATE `creature_template` SET `spell_school_immune_mask` = 64 WHERE `entry` IN (6109,6492,6550,10202,10662,10663,10664,11480,11483,11484,14397,15527,16488,16530,16854,18864,18865,18866,18867,19205,20516,22310,20702,26370,30848);

-- SPELL_SCHOOL_ARCANE & SPELL_SCHOOL_SHADOW
UPDATE `creature_template` SET `spell_school_immune_mask` = 96 WHERE `entry` = 21032;

-- SPELL_SCHOOL_ARCANE & SPELL_SCHOOL_SHADOW & SPELL_SCHOOL_FROST & SPELL_SCHOOL_FIRE
UPDATE `creature_template` SET `spell_school_immune_mask` = 116 WHERE `entry` IN (7734,7735);

-- SPELL_SCHOOL_ARCANE & SPELL_SCHOOL_SHADOW & SPELL_SCHOOL_FROST & SPELL_SCHOOL_FIRE & SPELL_SCHOOL_NATURE
UPDATE `creature_template` SET `spell_school_immune_mask` = 124 WHERE `entry` = 10485;

-- SPELL_SCHOOL_ARCANE & SPELL_SCHOOL_SHADOW & SPELL_SCHOOL_FROST & SPELL_SCHOOL_FIRE & SPELL_SCHOOL_NATURE & SPELL_SCHOOL_HOLY
UPDATE `creature_template` SET `spell_school_immune_mask` = 126 WHERE `entry` IN (12457,16491);

-- SPELL_SCHOOL_ARCANE & SPELL_SCHOOL_SHADOW & SPELL_SCHOOL_FROST & SPELL_SCHOOL_FIRE & SPELL_SCHOOL_NATURE & SPELL_SCHOOL_HOLY & SPELL_SCHOOL_NORMAL
UPDATE `creature_template` SET `spell_school_immune_mask` = 127 WHERE `entry` = 8317;
