-- DB update 2022_12_28_00 -> 2022_12_28_01
-- Sniffed
UPDATE `creature_template` SET `type_flags`=`type_flags`|134217856 WHERE (`entry` = 18240);
UPDATE `creature_template_addon` SET `bytes1` = 0, `bytes2` = 1, `auras` = '31261' WHERE (`entry` = 18240);
DELETE FROM `creature_addon` WHERE `guid` IN (84446,84447,84448,84449,84450,84451,84452,84453,84454,84455,84456,84457,84458,84460,84461,84462,84463,84464,84465,84466,84467,84468,84469,84470,84471,84472,84473,84474,84475,84476,84477,84478,84479,84480,84481);
