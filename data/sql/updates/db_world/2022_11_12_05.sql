-- DB update 2022_11_12_04 -> 2022_11_12_05
--
DELETE FROM `gameobject_queststarter` WHERE (`quest` = 2933) AND (`id` IN (142703, 142704, 142705, 142706, 142707, 142712, 142713, 142714));
INSERT INTO `gameobject_queststarter` (`id`, `quest`) VALUES (142703, 2933), (142704, 2933), (142705, 2933), (142706, 2933), (142707, 2933), (142712, 2933), (142713, 2933), (142714, 2933);
