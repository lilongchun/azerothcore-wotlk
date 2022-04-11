-- DB update 2022_04_07_06 -> 2022_04_07_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_07_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_07_06 2022_04_07_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648965068000701761'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648965068000701761');
DELETE FROM `creature_loot_template` WHERE `Entry` = 11583;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(11583, 19002, 0,     100.0, 0,  1, 0, 1, 1),
(11583, 19003, 0,     100.0, 0,  1, 0, 1, 1),
(11583, 21138, 0,     100.0, 1,  1, 0, 1, 1),
(11583, 21142, 0,     100.0, 1,  1, 0, 1, 1),
(11583, 30044, 30044, 0.05,  0, 1, 0, 1, 1),
(11583, 30089, 30089, 1.0,   0, 1, 5, 1, 1),
(11583, 30105, 30105, 0.05,  0, 1, 0, 1, 1),
(11583, 30171, 30171, 0.05,  0, 1, 0, 1, 1),
(11583, 30172, 30172, 100.0, 0, 1, 0, 1, 1),
(11583, 30173, 30173, 100.0, 0, 1, 0, 1, 1),
(11583, 30330, 30330, 0.05,  0, 1, 0, 1, 1),
(11583, 30486, 30486, 100.0, 0, 1, 0, 1, 2),
(11583, 30487, 30487, 100.0, 0, 1, 0, 1, 1),
(11583, 30551, 30551, 100.0, 0, 1, 0, 1, 1),
(11583, 34009, 34009, 100.0, 0, 1, 0, 1, 2);

DELETE FROM `reference_loot_template` WHERE `Entry` IN (34009, 30105, 30044, 30089, 30172, 30173, 30330, 30486, 30487, 30551, 30171);
INSERT INTO `reference_loot_template`(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(34009, 16900, 0, 0, 0, 1, 1, 1, 1),
(34009, 16908, 0, 0, 0, 1, 1, 1, 1),
(34009, 16914, 0, 0, 0, 1, 1, 1, 1),
(34009, 16921, 0, 0, 0, 1, 1, 1, 1),
(34009, 16929, 0, 0, 0, 1, 1, 1, 1),
(34009, 16939, 0, 0, 0, 1, 1, 1, 1),
(34009, 16947, 0, 0, 0, 1, 1, 1, 1),
(34009, 16955, 0, 0, 0, 1, 1, 1, 1),
(34009, 16963, 0, 0, 0, 1, 1, 1, 1),
(30044, 2564,  0,  0.0, 0, 1, 1, 1,1),
(30044, 7734,  0,  0.0, 0, 1, 1, 1,1),
(30044, 13009, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13030, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13046, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13065, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13066, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13085, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13125, 0,  0.0, 0, 1, 1, 1,1),
(30044, 13139, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10135, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10143, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10151, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10157, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10158, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10246, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10252, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10254, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10262, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10264, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10266, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10271, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10273, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10367, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10384, 0,  0.0, 0, 1, 1, 1,1),
(30089, 10389, 0,  0.0, 0, 1, 1, 1,1),
(30089, 11980, 0,  0.0, 0, 1, 1, 1,1),
(30089, 12017, 0,  0.0, 0, 1, 1, 1,1),
(30089, 12048, 0,  0.0, 0, 1, 1, 1,1),
(30089, 12058, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14328, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14332, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14336, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14456, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14464, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14680, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14811, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14812, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14975, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14979, 0,  0.0, 0, 1, 1, 1,1),
(30089, 14982, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15221, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15240, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15247, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15258, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15283, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15289, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15439, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15442, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15680, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15684, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15687, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15941, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15942, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15968, 0,  0.0, 0, 1, 1, 1,1),
(30089, 15989, 0,  0.0, 0, 1, 1, 1,1),
(30171, 1203,  0,  0.0, 0, 1, 1, 1,1),
(30171, 1973,  0,  0.0, 0, 1, 1, 1,1),
(30171, 2564,  0,  0.0, 0, 1, 1, 1,1),
(30171, 4696,  0,  0.0, 0, 1, 1, 1,1),
(30171, 5266,  0,  0.0, 0, 1, 1, 1,1),
(30171, 5267,  0,  0.0, 0, 1, 1, 1,1),
(30171, 6622,  0,  0.0, 0, 1, 1, 1,1),
(30171, 7734,  0,  0.0, 0, 1, 1, 1,1),
(30171, 7976,  0,  0.0, 0, 1, 1, 1,1),
(30171, 7991,  0,  0.0, 0, 1, 1, 1,1),
(30171, 8028,  0,  0.0, 0, 1, 1, 1,1),
(30171, 9402,  0,  0.0, 0, 1, 1, 1,1),
(30171, 10605, 0,  0.0, 0, 1, 1, 1,1),
(30171, 10608, 0,  0.0, 0, 1, 1, 1,1),
(30171, 11302, 0,  0.0, 0, 1, 1, 1,1),
(30171, 12698, 0,  0.0, 0, 1, 1, 1,1),
(30171, 12711, 0,  0.0, 0, 1, 1, 1,1),
(30171, 12717, 0,  0.0, 0, 1, 1, 1,1),
(30171, 12720, 0,  0.0, 0, 1, 1, 1,1),
(30171, 12728, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13000, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13001, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13002, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13003, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13004, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13006, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13007, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13008, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13009, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13013, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13015, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13030, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13036, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13040, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13047, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13053, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13060, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13066, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13067, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13070, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13072, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13073, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13075, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13077, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13083, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13085, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13091, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13096, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13107, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13111, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13113, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13116, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13118, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13120, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13123, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13125, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13126, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13130, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13133, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13135, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13144, 0,  0.0, 0, 1, 1, 1,1),
(30171, 13146, 0,  0.0, 0, 1, 1, 1,1),
(30171, 14501, 0,  0.0, 0, 1, 1, 1,1),
(30171, 14509, 0,  0.0, 0, 1, 1, 1,1),
(30171, 14511, 0,  0.0, 0, 1, 1, 1,1),
(30171, 17413, 0,  0.0, 0, 1, 1, 1,1),
(30171, 17414, 0,  0.0, 0, 1, 1, 1,1),
(30171, 17682, 0,  0.0, 0, 1, 1, 1,1),
(30171, 17683, 0,  0.0, 0, 1, 1, 1,1),
(30171, 18600, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22388, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22389, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22390, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22393, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22890, 0,  0.0, 0, 1, 1, 1,1),
(30171, 22891, 0,  0.0, 0, 1, 1, 1,1),
(30172, 9297,  0,  0.0, 0, 1, 1, 1,1),
(30172, 10246, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10247, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10248, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10249, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10250, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10251, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10252, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10253, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10254, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10255, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10256, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10257, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10258, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10259, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10260, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10261, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10262, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10263, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10264, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10265, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10266, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10267, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10268, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10269, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10270, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10272, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10273, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10274, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10367, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10384, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10385, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10386, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10387, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10388, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10389, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10390, 0,  0.0, 0, 1, 1, 1,1),
(30172, 10391, 0,  0.0, 0, 1, 1, 1,1),
(30172, 11224, 0,  0.0, 0, 1, 1, 1,1),
(30172, 11226, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12017, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12048, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12682, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12683, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12684, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12685, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12689, 0,  0.0, 0, 1, 1, 1,1),
(30172, 12702, 0,  0.0, 0, 1, 1, 1,1),
(30172, 13486, 0,  0.0, 0, 1, 1, 1,1),
(30172, 13487, 0,  0.0, 0, 1, 1, 1,1),
(30172, 13488, 0,  0.0, 0, 1, 1, 1,1),
(30172, 13489, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14328, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14329, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14330, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14331, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14332, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14333, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14334, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14335, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14336, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14337, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14975, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14976, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14977, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14978, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14979, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14980, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14981, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14982, 0,  0.0, 0, 1, 1, 1,1),
(30172, 14983, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15221, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15229, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15240, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15247, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15258, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15267, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15273, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15278, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15283, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15289, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15325, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15434, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15435, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15436, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15437, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15438, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15439, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15440, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15441, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15442, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15678, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15679, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15680, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15681, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15682, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15683, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15684, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15685, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15686, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15687, 0,  0.0, 0, 1, 1, 1,1),
(30172, 15942, 0,  0.0, 0, 1, 1, 1,1),
(30172, 16044, 0,  0.0, 0, 1, 1, 1,1),
(30172, 16055, 0,  0.0, 0, 1, 1, 1,1),
(30172, 16253, 0,  0.0, 0, 1, 1, 1,1),
(30173, 17962, 0,  0.0, 0, 1, 1, 1,1),
(30173, 17963, 0,  0.0, 0, 1, 1, 1,1),
(30173, 17964, 0,  0.0, 0, 1, 1, 1,1),
(30173, 17965, 0,  0.0, 0, 1, 1, 1,1),
(30173, 17969, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16897, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16905, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16916, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16923, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16931, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16942, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16950, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16958, 0,  0.0, 0, 1, 1, 1,1),
(30486, 16966, 0,  0.0, 0, 1, 1, 1,1),
(30487, 19360, 0,  10.0,0, 1, 1, 1,1),
(30487, 19363, 0,  10.0,0, 1, 1, 1,1),
(30487, 19375, 0,  0.0, 0, 1, 1, 1,1),
(30487, 19376, 0,  0.0, 0, 1, 1, 1,1),
(30487, 19377, 0,  0.0, 0, 1, 1, 1,1),
(30487, 19378, 0,  0.0, 0, 1, 1, 1,1),
(30551, 19356, 0,  10.0,0, 1, 1, 1,1),
(30551, 19364, 0,  10.0,0, 1, 1, 1,1),
(30551, 19379, 0,  0.0, 0, 1, 1, 1,1),
(30551, 19380, 0,  0.0, 0, 1, 1, 1,1),
(30551, 19381, 0,  0.0, 0, 1, 1, 1,1),
(30551, 19382, 0,  0.0, 0, 1, 1, 1,1),
(30330, 30171, 30171, 100.0, 0, 1, 0, 1, 1),
(30105, 30044, 30044, 100.0, 0, 1, 0, 1 ,1);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_07_07' WHERE sql_rev = '1648965068000701761';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
