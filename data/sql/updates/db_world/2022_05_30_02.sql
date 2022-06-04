-- DB update 2022_05_30_01 -> 2022_05_30_02
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (14507, 14509, 14510, 14515, 14517) AND `Item` IN (22711, 22712, 22713, 22714, 22715, 22716, 22718, 22720, 22721, 22722, 30546)) OR (`Entry` = 14834) AND (`Item` IN (34090, 30398)) OR (`Entry` IN (15084, 15082, 15085, 15083));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES

(14507, 30546, 30546, 100, 0, 1, 0, 1, 1, ''),
(14509, 30546, 30546, 100, 0, 1, 0, 1, 1, ''),
(14510, 30546, 30546, 100, 0, 1, 0, 1, 1, ''),
(14515, 30546, 30546, 100, 0, 1, 0, 1, 1, ''),
(14517, 30546, 30546, 100, 0, 1, 0, 1, 1, ''),
(14834, 34090, 34090, 100, 0, 1, 1, 1, 1, 'Hakkar - (ReferenceTable)'),
(14834, 30398, 30398, 100, 0, 1, 0, 1, 1, ''),
(15082, 19939, 0, 100, 0, 1, 2, 1, 1, 'Gri\'lek - Gri\'lek\'s Blood'),
(15082, 19939, 0, 20, 0, 1, 3, 1, 1, 'Gri\'lek - Gri\'lek\'s Blood'),
(15082, 19939, 0, 20, 0, 1, 4, 1, 1, 'Gri\'lek - Gri\'lek\'s Blood'),
(15082, 19961, 0, 0, 0, 1, 1, 1, 1, 'Gri\'lek - Gri\'lek\'s Grinder'),
(15082, 19962, 0, 0, 0, 1, 1, 1, 1, 'Gri\'lek - Gri\'lek\'s Carver'),
(15084, 19940, 0, 100, 0, 1, 2, 1, 1, 'Renataki - Renataki\'s Tooth'),
(15084, 19940, 0, 20, 0, 1, 3, 1, 1, 'Renataki - Renataki\'s Tooth'),
(15084, 19940, 0, 20, 0, 1, 4, 1, 1, 'Renataki - Renataki\'s Tooth'),
(15084, 19963, 0, 0, 0, 1, 1, 1, 1, 'Renataki - Pitchfork of Madness'),
(15084, 19964, 0, 0, 0, 1, 1, 1, 1, 'Renataki - Renataki\'s Soul Conduit'),
(15083, 19942, 0, 100, 0, 1, 2, 1, 1, 'Hazza\'rah - Hazza\'rah\'s Dream Thread'),
(15083, 19942, 0, 20, 0, 1, 3, 1, 1, 'Hazza\'rah - Hazza\'rah\'s Dream Thread'),
(15083, 19942, 0, 20, 0, 1, 4, 1, 1, 'Hazza\'rah - Hazza\'rah\'s Dream Thread'),
(15083, 19967, 0, 0, 0, 1, 1, 1, 1, 'Hazza\'rah - Thoughtblighter'),
(15083, 19968, 0, 0, 0, 1, 1, 1, 1, 'Hazza\'rah - Fiery Retributer'),
(15085, 19941, 0, 100, 0, 1, 2, 1, 1, 'Wushoolay - Wushoolay\'s Mane'),
(15085, 19941, 0, 20, 0, 1, 3, 1, 1, 'Wushoolay - Wushoolay\'s Mane'),
(15085, 19941, 0, 20, 0, 1, 4, 1, 1, 'Wushoolay - Wushoolay\'s Mane'),
(15085, 19965, 0, 0, 0, 1, 1, 1, 1, 'Wushoolay - Wushoolay\'s Poker'),
(15085, 19993, 0, 0, 0, 1, 1, 1, 1, 'Wushoolay - Hoodoo Hunting Bow');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 30546) AND (`Item` IN (22711, 22712, 22713, 22714, 22715, 22716, 22718, 22720, 22721, 22722)) OR (`Entry` = 30398) AND (`Item` IN (19852, 19853, 19856, 19857, 19864, 20257, 20264)) OR (`Entry` = 34090) AND (`Item` IN (19852, 19853, 19856, 19857, 19864, 20257, 20264));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30546, 22711, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22712, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22713, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22714, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22715, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22716, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22718, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22720, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22721, 0, 0, 0, 1, 1, 1, 1, ''),
(30546, 22722, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 19852, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 19853, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 19856, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 19857, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 19864, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 20257, 0, 0, 0, 1, 1, 1, 1, ''),
(30398, 20264, 0, 0, 0, 1, 1, 1, 1, '');
