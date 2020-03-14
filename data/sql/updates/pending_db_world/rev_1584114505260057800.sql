INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584114505260057800');

-- Based off https://wowwiki.fandom.com/wiki/Clam?oldid=2076011
DELETE FROM `spell_loot_template` WHERE `entry` IN (58172, 58168, 61898, 58160);
INSERT INTO `spell_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(58172, 5503, 0, 100, 0, 1, 1, 1, 1, NULL),
(58172, 5498, 0, 5, 0, 1, 1, 1, 1, NULL),
(58168, 5504, 0, 100, 0, 1, 1, 1, 1, NULL),
(58168, 5498, 0, 5, 0, 1, 1, 1, 1, NULL),
(58168, 5500, 0, 2.5, 0, 1, 1, 1, 1, NULL),
(61898, 7974, 0, 100, 0, 1, 1, 1, 1, NULL),
(61898, 5498, 0, 3, 0, 1, 1, 1, 1, NULL),
(61898, 5500, 0, 1, 0, 1, 1, 1, 1, NULL),
(61898, 7971, 0, 4, 0, 1, 1, 1, 1, NULL),
(61898, 13926, 0, 0.5, 0, 1, 1, 1, 1, NULL),
(58160, 24477, 0, 100, 0, 1, 1, 1, 1, NULL),
(58160, 24478, 0, 15, 0, 1, 1, 1, 1, NULL),
(58160, 13926, 0, 5, 0, 1, 1, 1, 1, NULL),
(58160, 24479, 0, 1, 0, 1, 1, 1, 1, NULL);
