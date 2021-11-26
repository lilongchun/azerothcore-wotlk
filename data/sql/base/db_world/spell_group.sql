-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица _acore_world.spell_group
DROP TABLE IF EXISTS `spell_group`;
CREATE TABLE IF NOT EXISTS `spell_group` (
  `id` INT unsigned NOT NULL DEFAULT 0,
  `spell_id` INT unsigned NOT NULL DEFAULT 0,
  `special_flag` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`spell_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Spell System';

-- Дамп данных таблицы _acore_world.spell_group: 342 rows
DELETE FROM `spell_group`;
/*!40000 ALTER TABLE `spell_group` DISABLE KEYS */;
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES
	(1, 673, 2),
	(1, 2367, 1),
	(1, 2374, 1),
	(1, 2378, 2),
	(1, 2380, 2),
	(1, 3160, 1),
	(1, 3164, 1),
	(1, 3166, 2),
	(1, 3219, 2),
	(1, 3220, 2),
	(1, 3222, 2),
	(1, 3223, 2),
	(1, 3593, 2),
	(1, 7844, 1),
	(1, 8212, 1),
	(1, 10667, 1),
	(1, 10668, 2),
	(1, 10669, 1),
	(1, 10692, 2),
	(1, 10693, 2),
	(1, 11319, 2),
	(1, 11328, 1),
	(1, 11334, 1),
	(1, 11348, 2),
	(1, 11349, 2),
	(1, 11371, 2),
	(1, 11390, 1),
	(1, 11396, 2),
	(1, 11405, 1),
	(1, 11406, 1),
	(1, 11474, 1),
	(1, 15231, 2),
	(1, 15233, 2),
	(1, 16321, 2),
	(1, 16322, 1),
	(1, 16323, 1),
	(1, 16325, 2),
	(1, 16326, 2),
	(1, 16327, 2),
	(1, 16329, 1),
	(1, 17038, 1),
	(1, 17535, 2),
	(1, 17537, 1),
	(1, 17538, 1),
	(1, 17539, 1),
	(1, 17626, 3),
	(1, 17627, 3),
	(1, 17628, 3),
	(1, 17629, 3),
	(1, 21920, 1),
	(1, 24361, 2),
	(1, 24363, 2),
	(1, 24382, 2),
	(1, 24383, 2),
	(1, 24417, 2),
	(1, 26276, 1),
	(1, 27652, 2),
	(1, 27653, 2),
	(1, 28486, 1),
	(1, 28488, 1),
	(1, 28490, 1),
	(1, 28491, 1),
	(1, 28493, 1),
	(1, 28497, 1),
	(1, 28501, 1),
	(1, 28502, 2),
	(1, 28503, 1),
	(1, 28509, 2),
	(1, 28514, 2),
	(1, 28518, 3),
	(1, 28519, 3),
	(1, 28520, 3),
	(1, 28521, 3),
	(1, 28540, 3),
	(1, 29348, 2),
	(1, 33720, 1),
	(1, 33721, 1),
	(1, 33726, 1),
	(1, 38954, 1),
	(1, 39625, 2),
	(1, 39626, 2),
	(1, 39627, 2),
	(1, 39628, 2),
	(1, 40567, 7),
	(1, 40568, 7),
	(1, 40572, 7),
	(1, 40573, 7),
	(1, 40575, 7),
	(1, 40576, 7),
	(1, 41608, 11),
	(1, 41609, 11),
	(1, 41610, 11),
	(1, 41611, 11),
	(1, 42735, 3),
	(1, 45373, 1),
	(1, 46837, 11),
	(1, 46839, 11),
	(1, 53746, 1),
	(1, 53747, 2),
	(1, 53748, 1),
	(1, 53749, 1),
	(1, 53751, 2),
	(1, 53752, 3),
	(1, 53755, 3),
	(1, 53758, 3),
	(1, 53760, 3),
	(1, 53763, 2),
	(1, 53764, 2),
	(1, 54212, 3),
	(1, 54452, 1),
	(1, 54494, 1),
	(1, 60340, 1),
	(1, 60341, 1),
	(1, 60343, 2),
	(1, 60344, 1),
	(1, 60345, 1),
	(1, 60346, 1),
	(1, 60347, 2),
	(1, 62380, 3),
	(1, 63729, 1),
	(1, 67016, 3),
	(1, 67017, 3),
	(1, 67018, 3),
	(1001, 5020, 0),
	(1001, 5021, 0),
	(1001, 5257, 0),
	(1001, 6114, 0),
	(1001, 18125, 0),
	(1001, 18141, 0),
	(1001, 19705, 0),
	(1001, 19706, 0),
	(1001, 19708, 0),
	(1001, 19709, 0),
	(1001, 19710, 0),
	(1001, 19711, 0),
	(1001, 20875, 0),
	(1001, 22789, 0),
	(1001, 23697, 0),
	(1001, 24799, 0),
	(1001, 24870, 0),
	(1001, 25037, 0),
	(1001, 25694, 0),
	(1001, 25722, 0),
	(1001, 25804, 0),
	(1001, 25941, 0),
	(1001, 33254, 0),
	(1001, 33256, 0),
	(1001, 33257, 0),
	(1001, 33259, 0),
	(1001, 33261, 0),
	(1001, 33263, 0),
	(1001, 33265, 0),
	(1001, 33268, 0),
	(1001, 33272, 0),
	(1001, 35272, 0),
	(1001, 37058, 0),
	(1001, 40323, 0),
	(1001, 42293, 0),
	(1001, 43722, 0),
	(1001, 43730, 0),
	(1001, 43764, 0),
	(1001, 43771, 0),
	(1001, 44097, 0),
	(1001, 44098, 0),
	(1001, 44099, 0),
	(1001, 44100, 0),
	(1001, 44101, 0),
	(1001, 44102, 0),
	(1001, 44104, 0),
	(1001, 44105, 0),
	(1001, 44106, 0),
	(1001, 45245, 0),
	(1001, 45619, 0),
	(1001, 46682, 0),
	(1001, 46687, 0),
	(1001, 46899, 0),
	(1001, 53284, 0),
	(1001, 57079, 0),
	(1001, 57097, 0),
	(1001, 57100, 0),
	(1001, 57102, 0),
	(1001, 57107, 0),
	(1001, 57111, 0),
	(1001, 57139, 0),
	(1001, 57286, 0),
	(1001, 57288, 0),
	(1001, 57291, 0),
	(1001, 57294, 0),
	(1001, 57325, 0),
	(1001, 57327, 0),
	(1001, 57329, 0),
	(1001, 57332, 0),
	(1001, 57334, 0),
	(1001, 57356, 0),
	(1001, 57358, 0),
	(1001, 57360, 0),
	(1001, 57363, 0),
	(1001, 57365, 0),
	(1001, 57367, 0),
	(1001, 57371, 0),
	(1001, 57373, 0),
	(1001, 57399, 0),
	(1001, 58468, 0),
	(1001, 58479, 0),
	(1001, 59230, 0),
	(1001, 62349, 0),
	(1001, 64057, 0),
	(1001, 65247, 0),
	(1001, 65365, 0),
	(1001, 65410, 0),
	(1001, 65412, 0),
	(1001, 65414, 0),
	(1001, 65415, 0),
	(1001, 65416, 0),
	(1001, 66623, 0),
	(1001, 69559, 0),
	(1002, 469, 0),
	(1002, 5677, 0),
	(1002, 6307, 0),
	(1002, 6673, 0),
	(1002, 19740, 0),
	(1002, 19742, 0),
	(1002, 20217, 0),
	(1002, 20911, 0),
	(1002, 25782, 0),
	(1002, 25894, 0),
	(1002, 25898, 0),
	(1002, 25899, 0),
	(1002, 26393, 0),
	(1002, 32770, 0),
	(1002, 56525, 0),
	(1002, 58054, 0),
	(1002, 67480, 32),
	(1002, 72586, 32),
	(1003, 8647, 0),
	(1003, 55749, 0),
	(1003, 58567, 0),
	(1004, 770, 0),
	(1004, 16231, 2),
	(1004, 16857, 0),
	(1004, 33196, 1),
	(1004, 56626, 2),
	(1005, 8515, 0),
	(1005, 55610, 0),
	(1006, 24932, 0),
	(1006, 29801, 0),
	(1007, 19506, 0),
	(1007, 30802, 0),
	(1007, 53137, 0),
	(1008, 33876, 0),
	(1008, 33878, 0),
	(1008, 46856, 0),
	(1009, 24907, 0),
	(1009, 51466, 0),
	(1010, 12579, 0),
	(1010, 22959, 0),
	(1011, 48090, 33),
	(1011, 52109, 0),
	(1011, 57658, 0),
	(1012, 31579, 0),
	(1012, 50170, 0),
	(1012, 63531, 0),
	(1012, 75593, 0),
	(1013, 21183, 0),
	(1013, 30708, 0),
	(1014, 89, 2),
	(1014, 6343, 4096),
	(1014, 55095, 0),
	(1014, 58179, 2),
	(1014, 68055, 1),
	(1015, 3043, 1),
	(1015, 5570, 0),
	(1016, 12294, 32),
	(1016, 13218, 32),
	(1016, 19434, 32),
	(1016, 56112, 0),
	(1017, 99, 1),
	(1017, 702, 2),
	(1017, 1160, 1),
	(1018, 8076, 0),
	(1018, 8115, 0),
	(1018, 8118, 0),
	(1018, 57330, 0),
	(1019, 1459, 0),
	(1019, 8096, 0),
	(1019, 8112, 0),
	(1019, 14752, 0),
	(1019, 23028, 0),
	(1019, 27681, 0),
	(1019, 54424, 0),
	(1019, 61024, 0),
	(1019, 61316, 0),
	(1020, 34123, 0),
	(1020, 63514, 0),
	(1021, 14893, 0),
	(1021, 16177, 0),
	(1022, 1714, 0),
	(1022, 5760, 0),
	(1022, 31589, 0),
	(1023, 1126, 0),
	(1023, 21849, 0),
	(1023, 72588, 0),
	(1024, 1243, 0),
	(1024, 8099, 0),
	(1024, 21562, 0),
	(1024, 72590, 0),
	(1025, 976, 0),
	(1025, 27683, 0),
	(1026, 348, 0),
	(1026, 30108, 0),
	(1027, 604, 0),
	(1027, 1008, 0),
	(1028, 1490, 0),
	(1028, 51726, 32),
	(1028, 60431, 0),
	(1029, 40623, 0),
	(1029, 40625, 0),
	(1029, 40626, 0),
	(1030, 6562, 0),
	(1030, 28878, 0),
	(1031, 12292, 0),
	(1031, 12880, 0),
	(1031, 31884, 0),
	(1031, 34471, 0),
	(1031, 48391, 0),
	(1031, 49016, 0),
	(1031, 57518, 0),
	(1031, 57933, 0),
	(1032, 2825, 0),
	(1032, 10060, 512),
	(1032, 12042, 256),
	(1032, 32182, 0),
	(1033, 7481, 0),
	(1033, 7483, 0),
	(1033, 7484, 0),
	(1034, 467, 64),
	(1112, 8219, 0),
	(1112, 8220, 0),
	(1112, 8221, 0),
	(1112, 8222, 0),
	(1113, 57055, 0),
	(1113, 56648, 0);
/*!40000 ALTER TABLE `spell_group` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
