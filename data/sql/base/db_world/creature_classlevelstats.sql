-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.creature_classlevelstats
DROP TABLE IF EXISTS `creature_classlevelstats`;
CREATE TABLE IF NOT EXISTS `creature_classlevelstats` (
  `level` tinyint unsigned NOT NULL,
  `class` tinyint unsigned NOT NULL,
  `basehp0` int unsigned NOT NULL DEFAULT '1',
  `basehp1` int unsigned NOT NULL DEFAULT '1',
  `basehp2` int unsigned NOT NULL DEFAULT '1',
  `basemana` int unsigned NOT NULL DEFAULT '0',
  `basearmor` int unsigned NOT NULL DEFAULT '1',
  `attackpower` int unsigned NOT NULL DEFAULT '0',
  `rangedattackpower` int unsigned NOT NULL DEFAULT '0',
  `damage_base` float NOT NULL DEFAULT '0',
  `damage_exp1` float NOT NULL DEFAULT '0',
  `damage_exp2` float NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`level`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumping data for table acore_world.creature_classlevelstats: 400 rows
DELETE FROM `creature_classlevelstats`;
/*!40000 ALTER TABLE `creature_classlevelstats` DISABLE KEYS */;
INSERT INTO `creature_classlevelstats` (`level`, `class`, `basehp0`, `basehp1`, `basehp2`, `basemana`, `basearmor`, `attackpower`, `rangedattackpower`, `damage_base`, `damage_exp1`, `damage_exp2`, `comment`) VALUES
	(1, 1, 42, 1, 1, 0, 8, 9, 1, 0.1321, 0.1321, 0.1321, NULL),
	(1, 2, 41, 1, 1, 60, 7, 9, 1, 0.2381, 0.2381, 0.2381, NULL),
	(1, 4, 42, 1, 1, 0, 6, 9, 1, 0.1321, 0.1321, 0.1321, NULL),
	(1, 8, 40, 1, 1, 120, 5, 8, 10, 0.1781, 0.1781, 0.1781, NULL),
	(2, 1, 55, 1, 1, 0, 20, 11, 1, 0.2888, 0.2888, 0.2888, NULL),
	(2, 2, 54, 1, 1, 69, 19, 11, 1, 0.3119, 0.3119, 0.3119, NULL),
	(2, 4, 55, 1, 1, 0, 18, 11, 1, 0.2888, 0.2888, 0.2888, NULL),
	(2, 8, 52, 1, 1, 147, 16, 10, 10, 0.3233, 0.3233, 0.3233, NULL),
	(3, 1, 71, 1, 1, 0, 33, 13, 1, 0.5547, 0.5547, 0.5547, NULL),
	(3, 2, 69, 1, 1, 79, 33, 11, 1, 0.5952, 0.5952, 0.5952, NULL),
	(3, 4, 71, 1, 1, 0, 31, 13, 1, 0.5547, 0.5547, 0.5547, NULL),
	(3, 8, 67, 1, 1, 174, 28, 12, 10, 0.4793, 0.4793, 0.4793, NULL),
	(4, 1, 86, 1, 1, 0, 68, 15, 1, 0.9435, 0.9435, 0.9435, NULL),
	(4, 2, 83, 1, 1, 104, 66, 13, 1, 0.946, 0.946, 0.946, NULL),
	(4, 4, 86, 1, 1, 0, 63, 15, 1, 0.9435, 0.9435, 0.9435, NULL),
	(4, 8, 81, 1, 1, 202, 57, 13, 11, 0.5714, 0.5714, 0.5714, NULL),
	(5, 1, 102, 1, 1, 0, 111, 18, 1, 1.3708, 1.3708, 1.3708, NULL),
	(5, 2, 98, 1, 1, 115, 109, 14, 1, 1.4567, 1.4567, 1.4567, NULL),
	(5, 4, 102, 1, 1, 0, 102, 18, 1, 1.3708, 1.3708, 1.3708, NULL),
	(5, 8, 95, 1, 1, 230, 93, 14, 11, 0.768, 0.768, 0.768, NULL),
	(6, 1, 120, 1, 1, 0, 165, 20, 1, 2.0661, 2.0661, 2.0661, NULL),
	(6, 2, 115, 1, 1, 126, 163, 16, 1, 2.0933, 2.0933, 2.0933, NULL),
	(6, 4, 120, 1, 1, 0, 152, 20, 1, 2.0661, 2.0661, 2.0661, NULL),
	(6, 8, 111, 1, 1, 259, 139, 15, 11, 1.1985, 1.1985, 1.1985, NULL),
	(7, 1, 137, 1, 1, 0, 230, 24, 1, 2.7669, 2.7669, 2.7669, NULL),
	(7, 2, 131, 1, 1, 138, 208, 20, 1, 2.7273, 2.7273, 2.7273, NULL),
	(7, 4, 137, 1, 1, 0, 212, 24, 1, 2.7669, 2.7669, 2.7669, NULL),
	(7, 8, 126, 1, 1, 289, 194, 15, 11, 2.159, 2.159, 2.159, NULL),
	(8, 1, 156, 1, 1, 0, 306, 28, 1, 3.1993, 3.1993, 3.1993, NULL),
	(8, 2, 148, 1, 1, 165, 303, 24, 1, 3.1076, 3.1076, 3.1076, NULL),
	(8, 4, 156, 1, 1, 0, 286, 28, 1, 3.1993, 3.1993, 3.1993, NULL),
	(8, 8, 143, 1, 1, 319, 265, 16, 11, 2.5217, 2.5217, 2.5217, NULL),
	(9, 1, 176, 1, 1, 0, 387, 31, 1, 3.7038, 3.7038, 3.7038, NULL),
	(9, 2, 166, 1, 1, 178, 369, 27, 1, 3.595, 3.595, 3.595, NULL),
	(9, 4, 176, 1, 1, 0, 363, 31, 1, 3.7038, 3.7038, 3.7038, NULL),
	(9, 8, 160, 1, 1, 350, 339, 17, 11, 3.03, 2.99, 2.99, NULL),
	(10, 1, 198, 1, 1, 0, 463, 34, 1, 4.1084, 4.1084, 4.1084, NULL),
	(10, 2, 186, 1, 1, 191, 460, 30, 1, 3.9604, 3.9604, 3.9604, NULL),
	(10, 4, 198, 1, 1, 0, 443, 34, 1, 4.1084, 4.1084, 4.1084, NULL),
	(10, 8, 178, 1, 1, 382, 423, 17, 12, 3.4451, 3.4451, 3.4451, NULL),
	(11, 1, 222, 1, 1, 0, 528, 38, 1, 4.6996, 4.6996, 4.6996, NULL),
	(11, 2, 208, 1, 1, 205, 526, 34, 1, 4.4552, 4.4552, 4.4552, NULL),
	(11, 4, 222, 1, 1, 0, 488, 38, 1, 4.6996, 4.6996, 4.6996, NULL),
	(11, 8, 199, 1, 1, 459, 447, 18, 12, 3.975, 3.975, 3.975, NULL),
	(12, 1, 247, 1, 1, 0, 562, 42, 1, 5.4601, 5.4601, 5.4601, NULL),
	(12, 2, 230, 1, 1, 249, 560, 38, 1, 5.1436, 5.1436, 5.1436, NULL),
	(12, 4, 247, 1, 1, 0, 519, 42, 1, 5.4601, 5.4601, 5.4601, NULL),
	(12, 8, 219, 1, 1, 537, 475, 19, 12, 4.6771, 4.6771, 4.6771, NULL),
	(13, 1, 273, 1, 1, 0, 596, 46, 1, 5.9359, 5.9359, 5.9359, NULL),
	(13, 2, 253, 1, 1, 264, 596, 42, 1, 5.5674, 5.5674, 5.5674, NULL),
	(13, 4, 273, 1, 1, 0, 553, 46, 1, 5.9359, 5.9359, 5.9359, NULL),
	(13, 8, 241, 1, 1, 601, 509, 20, 12, 5.1513, 5.1513, 5.1513, NULL),
	(14, 1, 300, 1, 1, 0, 630, 50, 1, 6.5895, 6.5895, 6.5895, NULL),
	(14, 2, 276, 1, 1, 295, 630, 46, 1, 6.1568, 6.1568, 6.1568, NULL),
	(14, 4, 300, 1, 1, 0, 577, 50, 1, 6.5895, 6.5895, 6.5895, NULL),
	(14, 8, 263, 1, 1, 710, 523, 21, 12, 5.7241, 5.7241, 5.7241, NULL),
	(15, 1, 328, 1, 1, 0, 665, 54, 2, 7.1981, 7.1981, 7.1981, NULL),
	(15, 2, 301, 1, 1, 326, 665, 48, 2, 6.8211, 6.8211, 6.8211, NULL),
	(15, 4, 328, 1, 1, 0, 612, 54, 2, 7.1981, 7.1981, 7.1981, NULL),
	(15, 8, 285, 1, 1, 790, 559, 22, 13, 6.3298, 6.3298, 6.3298, NULL),
	(16, 1, 356, 1, 1, 0, 700, 56, 2, 7.6697, 7.6697, 7.6697, NULL),
	(16, 2, 325, 1, 1, 357, 700, 52, 2, 7.1374, 7.1374, 7.1374, NULL),
	(16, 4, 356, 1, 1, 0, 645, 56, 2, 7.6697, 7.6697, 7.6697, NULL),
	(16, 8, 307, 1, 1, 856, 589, 24, 13, 6.6051, 6.6051, 6.6051, NULL),
	(17, 1, 386, 1, 1, 0, 734, 60, 2, 8.2225, 8.2225, 8.2225, NULL),
	(17, 2, 350, 1, 1, 390, 734, 56, 2, 7.6355, 7.6355, 7.6355, NULL),
	(17, 4, 386, 1, 1, 0, 676, 60, 2, 8.2225, 8.2225, 8.2225, NULL),
	(17, 8, 330, 1, 1, 938, 617, 26, 13, 7.0485, 7.0485, 7.0485, NULL),
	(18, 1, 417, 1, 1, 0, 768, 64, 3, 8.5452, 8.5452, 8.5452, NULL),
	(18, 2, 377, 1, 1, 408, 768, 58, 3, 8.0339, 8.0339, 8.0339, NULL),
	(18, 4, 417, 1, 1, 0, 706, 64, 3, 8.5452, 8.5452, 8.5452, NULL),
	(18, 8, 354, 1, 1, 1020, 643, 27, 13, 7.4083, 7.4083, 7.4083, NULL),
	(19, 1, 449, 1, 1, 0, 802, 68, 3, 8.9384, 8.9384, 8.9384, NULL),
	(19, 2, 404, 1, 1, 456, 802, 60, 3, 8.611, 8.611, 8.611, NULL),
	(19, 4, 449, 1, 1, 0, 738, 68, 3, 8.9384, 8.9384, 8.9384, NULL),
	(19, 8, 379, 1, 1, 1118, 674, 28, 13, 7.9333, 7.9333, 7.9333, NULL),
	(20, 1, 484, 1, 1, 0, 836, 70, 4, 9.6823, 9.6823, 9.6823, NULL),
	(20, 2, 433, 1, 1, 490, 836, 64, 4, 9.0674, 9.0674, 9.0674, NULL),
	(20, 4, 484, 1, 1, 0, 769, 70, 4, 9.6823, 9.6823, 9.6823, NULL),
	(20, 8, 405, 1, 1, 1202, 701, 30, 14, 8.3382, 8.3382, 8.3382, NULL),
	(21, 1, 521, 1, 1, 0, 872, 74, 4, 9.9677, 9.9677, 9.9677, NULL),
	(21, 2, 464, 1, 1, 510, 872, 68, 4, 9.3169, 9.3169, 9.3169, NULL),
	(21, 4, 521, 1, 1, 0, 801, 74, 4, 9.9677, 9.9677, 9.9677, NULL),
	(21, 8, 432, 1, 1, 1272, 729, 32, 14, 8.5517, 8.5517, 8.5517, NULL),
	(22, 1, 562, 1, 1, 0, 906, 78, 4, 10.4218, 10.4218, 10.4218, NULL),
	(22, 2, 498, 1, 1, 545, 906, 71, 5, 9.7945, 9.7945, 9.7945, NULL),
	(22, 4, 562, 1, 1, 0, 833, 78, 4, 10.4218, 10.4218, 10.4218, NULL),
	(22, 8, 463, 1, 1, 1357, 759, 34, 14, 8.9102, 8.9102, 8.9102, NULL),
	(23, 1, 605, 1, 1, 0, 940, 80, 5, 10.8099, 10.8099, 10.8099, NULL),
	(23, 2, 533, 1, 1, 581, 940, 74, 5, 10.076, 10.076, 10.076, NULL),
	(23, 4, 605, 1, 1, 0, 863, 80, 5, 10.8099, 10.8099, 10.8099, NULL),
	(23, 8, 494, 1, 1, 1443, 786, 35, 14, 9.228, 9.228, 9.228, NULL),
	(24, 1, 651, 1, 1, 0, 975, 84, 6, 11.2419, 11.2419, 11.2419, NULL),
	(24, 2, 571, 1, 1, 618, 975, 78, 6, 10.4619, 10.4619, 10.4619, NULL),
	(24, 4, 651, 1, 1, 0, 895, 84, 6, 11.2419, 11.2419, 11.2419, NULL),
	(24, 8, 528, 1, 1, 1545, 815, 36, 15, 9.6818, 9.6818, 9.6818, NULL),
	(25, 1, 699, 1, 1, 0, 1008, 86, 6, 11.7485, 11.7485, 11.7485, NULL),
	(25, 2, 610, 1, 1, 655, 1008, 80, 6, 10.7857, 10.7857, 10.7857, NULL),
	(25, 4, 699, 1, 1, 0, 926, 86, 6, 11.7485, 11.7485, 11.7485, NULL),
	(25, 8, 562, 1, 1, 1633, 843, 37, 15, 10.1014, 10.1014, 10.1014, NULL),
	(26, 1, 750, 1, 1, 0, 1043, 90, 7, 12.0453, 12.0453, 12.0453, NULL),
	(26, 2, 651, 1, 1, 693, 1042, 84, 6, 11.1849, 11.1849, 11.1849, NULL),
	(26, 4, 750, 1, 1, 0, 957, 90, 7, 12.0453, 12.0453, 12.0453, NULL),
	(26, 8, 598, 1, 1, 1707, 871, 39, 15, 10.3246, 10.3246, 10.3246, NULL),
	(27, 1, 800, 1, 1, 0, 1078, 92, 7, 12.6213, 12.6213, 12.6213, NULL),
	(27, 2, 690, 1, 1, 732, 1078, 86, 7, 11.7126, 11.7126, 11.7126, NULL),
	(27, 4, 800, 1, 1, 0, 989, 92, 7, 12.6213, 12.6213, 12.6213, NULL),
	(27, 8, 633, 1, 1, 1812, 900, 40, 15, 10.804, 10.804, 10.804, NULL),
	(28, 1, 853, 1, 1, 0, 1111, 96, 8, 12.795, 12.795, 12.795, NULL),
	(28, 2, 732, 1, 1, 756, 1110, 90, 7, 11.9663, 11.9663, 11.9663, NULL),
	(28, 4, 853, 1, 1, 0, 1020, 96, 8, 12.795, 12.795, 12.795, NULL),
	(28, 8, 669, 1, 1, 1977, 928, 42, 15, 11.0213, 11.0213, 11.0213, NULL),
	(29, 1, 905, 1, 1, 0, 1145, 100, 8, 13.3432, 13.3432, 13.3432, NULL),
	(29, 2, 773, 1, 1, 811, 1145, 94, 8, 12.352, 12.352, 12.352, NULL),
	(29, 4, 905, 1, 1, 0, 1051, 100, 8, 13.3432, 13.3432, 13.3432, NULL),
	(29, 8, 704, 1, 1, 2068, 957, 44, 16, 11.3608, 11.3608, 11.3608, NULL),
	(30, 1, 955, 1, 1, 0, 1179, 102, 9, 13.9264, 13.9264, 13.9264, NULL),
	(30, 2, 811, 1, 1, 852, 1178, 94, 8, 13.0007, 13.0007, 13.0007, NULL),
	(30, 4, 955, 1, 1, 0, 1082, 102, 9, 13.9264, 13.9264, 13.9264, NULL),
	(30, 8, 737, 1, 1, 2175, 984, 44, 16, 11.9607, 11.9607, 11.9607, NULL),
	(31, 1, 1006, 1, 1, 0, 1213, 106, 9, 14.1954, 14.1954, 14.1954, NULL),
	(31, 2, 850, 1006, 1, 878, 1213, 98, 9, 13.2348, 13.2348, 13.2348, NULL),
	(31, 4, 1006, 1, 1, 0, 1113, 106, 9, 14.1954, 14.1954, 14.1954, NULL),
	(31, 8, 770, 1, 1, 2253, 1012, 46, 16, 12.16, 12.16, 12.16, NULL),
	(32, 1, 1057, 1, 1, 0, 1249, 108, 10, 14.696, 14.696, 14.696, NULL),
	(32, 2, 888, 1, 1, 935, 1248, 100, 9, 13.6924, 13.6924, 13.6924, NULL),
	(32, 4, 1057, 1, 1, 0, 1146, 108, 10, 14.696, 14.696, 14.696, NULL),
	(32, 8, 802, 1, 1, 2362, 1042, 47, 16, 12.5746, 12.5746, 12.5746, NULL),
	(33, 1, 1110, 1, 1, 0, 1281, 112, 10, 14.9914, 14.9914, 14.9914, NULL),
	(33, 2, 928, 1, 1, 963, 1281, 104, 10, 13.9511, 13.9511, 13.9511, NULL),
	(33, 4, 1110, 1, 1, 0, 1173, 112, 10, 14.9914, 14.9914, 14.9914, NULL),
	(33, 8, 835, 1, 1, 2457, 1065, 49, 17, 12.7966, 12.7966, 12.7966, NULL),
	(34, 1, 1163, 1, 1, 0, 1317, 114, 11, 15.4944, 15.4944, 15.4944, NULL),
	(34, 2, 967, 1, 1, 1007, 1316, 106, 10, 14.4142, 14.4142, 14.4142, NULL),
	(34, 4, 1163, 1, 1, 0, 1208, 114, 11, 15.4944, 15.4944, 15.4944, NULL),
	(34, 8, 867, 1, 1, 2553, 1098, 50, 17, 13.2162, 13.2162, 13.2162, NULL),
	(35, 1, 1220, 1, 1, 0, 1349, 118, 11, 15.8617, 15.8617, 15.8617, NULL),
	(35, 2, 1009, 1, 1, 1067, 1349, 110, 11, 14.7365, 14.7365, 14.7365, NULL),
	(35, 4, 1220, 1, 1, 0, 1237, 118, 11, 15.8617, 15.8617, 15.8617, NULL),
	(35, 8, 902, 1, 1, 2680, 1124, 52, 17, 13.497, 13.497, 13.497, NULL),
	(36, 1, 1277, 1, 1, 0, 1456, 120, 12, 16.2984, 16.2984, 16.2984, NULL),
	(36, 2, 1050, 1, 1, 1097, 1455, 112, 11, 15.1346, 15.1346, 15.1346, NULL),
	(36, 4, 1277, 1, 1, 0, 1349, 120, 12, 16.2984, 16.2984, 16.2984, NULL),
	(36, 8, 935, 1, 1, 2763, 1241, 53, 18, 13.8566, 13.8566, 13.8566, NULL),
	(37, 1, 1336, 1, 1, 0, 1568, 124, 12, 16.7962, 16.7962, 16.7962, NULL),
	(37, 2, 1093, 1, 1, 1142, 1567, 116, 11, 15.5816, 15.5816, 15.5816, NULL),
	(37, 4, 1336, 1, 1, 0, 1434, 124, 12, 16.7962, 16.7962, 16.7962, NULL),
	(37, 8, 970, 1, 1, 2861, 1300, 54, 18, 14.367, 14.367, 14.367, NULL),
	(38, 1, 1395, 1, 1, 0, 1684, 128, 13, 17.1865, 17.1865, 17.1865, NULL),
	(38, 2, 1135, 1, 1, 1189, 1683, 120, 12, 15.9286, 15.9286, 15.9286, NULL),
	(38, 4, 1395, 1, 1, 0, 1538, 128, 13, 17.1865, 17.1865, 17.1865, NULL),
	(38, 8, 1004, 1, 1, 2975, 1391, 56, 18, 14.6707, 14.6707, 14.6707, NULL),
	(39, 1, 1459, 1, 1, 0, 1808, 132, 13, 17.7286, 17.7286, 17.7286, NULL),
	(39, 2, 1180, 1, 1, 1236, 1807, 124, 12, 16.4168, 16.4168, 16.4168, NULL),
	(39, 4, 1459, 1, 1, 0, 1649, 132, 13, 17.7286, 17.7286, 17.7286, NULL),
	(39, 8, 1040, 1, 1, 3075, 1489, 58, 18, 15.1049, 15.1049, 15.1049, NULL),
	(40, 1, 1524, 1, 1, 0, 1938, 136, 14, 18.2971, 18.2971, 18.2971, NULL),
	(40, 2, 1226, 1, 1, 1283, 1937, 128, 13, 16.9294, 16.9294, 16.9294, NULL),
	(40, 4, 1524, 1, 1, 0, 1764, 136, 14, 18.2971, 18.2971, 18.2971, NULL),
	(40, 8, 1077, 1, 1, 3191, 1590, 60, 19, 15.5617, 15.5617, 15.5617, NULL),
	(41, 1, 1585, 1, 1, 0, 2074, 142, 15, 19.1997, 19.1997, 19.1997, NULL),
	(41, 2, 1268, 1, 1, 1332, 2072, 132, 13, 17.8592, 17.8592, 17.8592, NULL),
	(41, 4, 1585, 1, 1, 0, 1886, 142, 15, 19.1997, 19.1997, 19.1997, NULL),
	(41, 8, 1110, 1, 1, 3293, 1697, 62, 19, 16.4044, 16.4044, 16.4044, NULL),
	(42, 1, 1651, 1, 1, 0, 2218, 152, 15, 20.3431, 20.3431, 20.3431, NULL),
	(42, 2, 1321, 1, 1, 1381, 2216, 142, 15, 18.8824, 18.8824, 18.8824, NULL),
	(42, 4, 1651, 1, 1, 0, 2015, 152, 15, 20.3431, 20.3431, 20.3431, NULL),
	(42, 8, 1156, 1, 1, 3471, 1811, 67, 19, 17.3076, 17.3076, 17.3076, NULL),
	(43, 1, 1716, 1, 1, 0, 2369, 162, 16, 21.7088, 21.7088, 21.7088, NULL),
	(43, 2, 1373, 1, 1, 1432, 2367, 152, 14, 20.1127, 20.1127, 20.1127, NULL),
	(43, 4, 1716, 1, 1, 0, 2148, 162, 16, 21.7088, 21.7088, 21.7088, NULL),
	(43, 8, 1201, 1, 1, 3575, 1926, 71, 19, 18.5165, 18.5165, 18.5165, NULL),
	(44, 1, 1782, 1, 1, 0, 2528, 174, 16, 23.5881, 23.5881, 23.5881, NULL),
	(44, 2, 1426, 1, 1, 1483, 2527, 166, 15, 21.6981, 21.6981, 21.6981, NULL),
	(44, 4, 1782, 1, 1, 0, 2303, 174, 16, 23.5881, 23.5881, 23.5881, NULL),
	(44, 8, 1247, 1, 1, 3680, 2078, 78, 20, 19.9224, 19.9224, 19.9224, NULL),
	(45, 1, 1848, 1, 1, 0, 2695, 184, 17, 24.6797, 24.6797, 24.6797, NULL),
	(45, 2, 1478, 1, 1, 1534, 2692, 172, 15, 22.9018, 22.9018, 22.9018, NULL),
	(45, 4, 1848, 1, 1, 0, 2436, 184, 17, 24.6797, 24.6797, 24.6797, NULL),
	(45, 8, 1294, 1, 1, 3801, 2177, 81, 20, 21.0097, 21.0097, 21.0097, NULL),
	(46, 1, 1919, 1, 1, 0, 2750, 188, 17, 25.1735, 25.1735, 25.1735, NULL),
	(46, 2, 1535, 1, 1, 1587, 2749, 176, 16, 23.3451, 23.3451, 23.3451, NULL),
	(46, 4, 1919, 1, 1, 0, 2485, 188, 17, 25.1735, 25.1735, 25.1735, NULL),
	(46, 8, 1343, 1, 1, 3923, 2220, 83, 20, 21.4023, 21.4023, 21.4023, NULL),
	(47, 1, 1990, 1, 1, 0, 2804, 192, 18, 25.7137, 25.7137, 25.7137, NULL),
	(47, 2, 1592, 1, 1, 1640, 2802, 180, 16, 23.9542, 23.9542, 23.9542, NULL),
	(47, 4, 1990, 1, 1, 0, 2535, 192, 18, 25.7137, 25.7137, 25.7137, NULL),
	(47, 8, 1393, 1, 1, 4031, 2265, 85, 21, 21.9484, 21.9484, 21.9484, NULL),
	(48, 1, 2062, 1, 1, 0, 2857, 196, 19, 26.209, 26.209, 26.209, NULL),
	(48, 2, 1650, 1, 1, 1695, 2855, 184, 17, 24.401, 24.401, 24.401, NULL),
	(48, 4, 2062, 1, 1, 0, 2582, 196, 19, 26.209, 26.209, 26.209, NULL),
	(48, 8, 1443, 1, 1, 4140, 2307, 87, 21, 22.3444, 22.3444, 22.3444, NULL),
	(49, 1, 2138, 1, 1, 0, 2912, 200, 19, 26.9952, 26.9952, 26.9952, NULL),
	(49, 2, 1710, 1, 1, 1750, 2910, 188, 17, 24.9975, 24.9975, 24.9975, NULL),
	(49, 4, 2138, 1, 1, 0, 2631, 200, 19, 26.9952, 26.9952, 26.9952, NULL),
	(49, 8, 1497, 1, 1, 4281, 2349, 89, 21, 22.8788, 22.8788, 22.8788, NULL),
	(50, 1, 2215, 1, 1, 0, 2966, 206, 20, 27.5899, 27.5899, 27.5899, NULL),
	(50, 2, 1772, 1, 1, 1807, 2964, 194, 18, 25.5204, 25.5204, 25.5204, NULL),
	(50, 4, 2215, 1, 1, 0, 2680, 206, 20, 27.5899, 27.5899, 27.5899, NULL),
	(50, 8, 1551, 1, 1, 4393, 2393, 91, 22, 23.4508, 23.4508, 23.4508, NULL),
	(51, 1, 2292, 1, 1, 0, 3018, 210, 20, 28.128, 28.128, 28.128, NULL),
	(51, 2, 1834, 1, 1, 1864, 3017, 198, 19, 26.0047, 26.0047, 26.0047, NULL),
	(51, 4, 2292, 1, 1, 0, 2728, 210, 20, 28.128, 28.128, 28.128, NULL),
	(51, 8, 1604, 1, 1, 4506, 2437, 93, 22, 23.8815, 23.8815, 23.8815, NULL),
	(52, 1, 2371, 1, 1, 0, 3060, 214, 21, 28.8795, 28.8795, 28.8795, NULL),
	(52, 2, 1897, 1, 1, 1923, 3072, 202, 19, 26.6877, 26.6877, 26.6877, NULL),
	(52, 4, 2371, 1, 1, 0, 2778, 214, 21, 28.8795, 28.8795, 28.8795, NULL),
	(52, 8, 1660, 1, 1, 4650, 2481, 95, 22, 24.4958, 24.4958, 24.4958, NULL),
	(53, 1, 2453, 1, 1, 0, 3128, 218, 22, 29.4381, 29.4381, 29.4381, NULL),
	(53, 2, 1962, 1, 1, 1982, 3126, 206, 20, 27.1912, 27.1912, 27.1912, NULL),
	(53, 4, 2453, 1, 1, 0, 2826, 218, 22, 29.4381, 29.4381, 29.4381, NULL),
	(53, 8, 1717, 1, 1, 4765, 2524, 97, 23, 24.9442, 24.9442, 24.9442, NULL),
	(54, 1, 2533, 1, 1, 0, 3180, 224, 22, 30.0501, 30.0501, 30.0501, NULL),
	(54, 2, 2026, 1, 1, 2041, 3178, 210, 20, 27.8506, 27.8506, 27.8506, NULL),
	(54, 4, 2533, 1, 1, 0, 2874, 224, 22, 30.0501, 30.0501, 30.0501, NULL),
	(54, 8, 1773, 1, 1, 4896, 2567, 99, 23, 25.5368, 25.5368, 25.5368, NULL),
	(55, 1, 2614, 1, 5228, 0, 3234, 228, 23, 30.7177, 30.7177, 30.7177, NULL),
	(55, 2, 2091, 1, 4182, 2117, 3232, 214, 21, 28.4555, 28.4555, 28.4555, NULL),
	(55, 4, 2614, 1, 5228, 0, 2922, 228, 23, 30.7177, 30.7177, 30.7177, NULL),
	(55, 8, 1830, 1, 3660, 5013, 2609, 101, 23, 26.079, 26.079, 26.079, NULL),
	(56, 1, 2699, 1, 5398, 0, 3289, 234, 23, 31.2387, 31.2387, 31.2387, NULL),
	(56, 2, 2159, 1, 4318, 2163, 3287, 220, 21, 28.9161, 28.9161, 28.9161, NULL),
	(56, 4, 2699, 1, 5398, 0, 2972, 234, 23, 31.2387, 31.2387, 31.2387, NULL),
	(56, 8, 1889, 1, 3778, 5206, 2654, 104, 24, 26.4791, 26.4791, 26.4791, NULL),
	(57, 1, 2784, 1, 5568, 0, 3342, 238, 24, 31.945, 31.945, 31.945, NULL),
	(57, 2, 2227, 1, 4454, 2241, 3340, 224, 22, 29.5701, 29.5701, 29.5701, NULL),
	(57, 4, 2784, 1, 5568, 0, 3020, 238, 24, 31.945, 31.945, 31.945, NULL),
	(57, 8, 1949, 1, 3898, 5340, 2698, 106, 24, 27.0667, 27.0667, 27.0667, NULL),
	(58, 1, 2871, 3989, 5742, 0, 3396, 242, 25, 32.5967, 40.2143, 40.2143, NULL),
	(58, 2, 2297, 3191, 4594, 2289, 3394, 228, 23, 30.1469, 34.7143, 34.7143, NULL),
	(58, 4, 2871, 3989, 5742, 0, 3068, 242, 25, 32.5967, 40.2143, 40.2143, NULL),
	(58, 8, 2010, 2793, 4020, 5461, 2740, 107, 24, 27.6972, 37.4048, 37.4048, NULL),
	(59, 1, 2961, 4142, 1, 0, 3449, 248, 25, 33.2007, 43.2857, 43.2857, NULL),
	(59, 2, 2369, 3314, 1, 2369, 3447, 234, 23, 30.6847, 49.6442, 49.6442, NULL),
	(59, 4, 2961, 4142, 1, 0, 3117, 248, 25, 33.2007, 43.2857, 43.2857, NULL),
	(59, 8, 2073, 2899, 1, 5598, 2784, 110, 25, 28.1686, 46.5537, 46.5537, NULL),
	(60, 1, 3052, 4979, 1, 0, 3750, 252, 26, 33.9625, 53.4755, 53.4755, NULL),
	(60, 2, 2442, 3984, 1, 2434, 3748, 238, 24, 31.3842, 55, 55, NULL),
	(60, 4, 3052, 4979, 1, 0, 3388, 252, 26, 33.9625, 53.4755, 53.4755, NULL),
	(60, 8, 2136, 3484, 1, 5751, 3025, 112, 25, 28.7983, 50.396, 50.396, NULL),
	(61, 1, 3144, 5158, 1, 0, 4047, 258, 28, 34.5714, 61.2729, 61.2729, NULL),
	(61, 2, 2515, 4126, 1, 2486, 4044, 244, 25, 31.837, 58.3279, 58.3279, NULL),
	(61, 4, 3144, 5158, 1, 0, 3655, 258, 28, 34.5714, 61.2729, 61.2729, NULL),
	(61, 8, 2201, 3611, 1, 5875, 3263, 115, 25, 29.3225, 53.4807, 53.4807, NULL),
	(62, 1, 3237, 5341, 1, 0, 4344, 262, 30, 35.2381, 67.4442, 67.4442, NULL),
	(62, 2, 2590, 4274, 1, 2568, 4340, 246, 26, 32.6201, 62.4676, 62.4676, NULL),
	(62, 4, 3237, 5341, 1, 0, 3922, 262, 30, 35.2381, 67.4442, 67.4442, NULL),
	(62, 8, 2266, 3739, 1, 6015, 3500, 116, 25, 29.917, 57.2713, 57.2713, NULL),
	(63, 1, 3331, 5527, 1, 0, 4641, 268, 32, 35.775, 71.4361, 71.4361, NULL),
	(63, 2, 2665, 4422, 1, 2620, 4637, 252, 26, 33.1092, 66.121, 66.121, NULL),
	(63, 4, 3331, 5527, 1, 0, 4189, 268, 32, 35.9047, 71.4361, 71.4361, NULL),
	(63, 8, 2332, 3870, 1, 6156, 3736, 119, 26, 30.4646, 60.577, 60.577, NULL),
	(64, 1, 3427, 5715, 1, 0, 4937, 272, 33, 36.5714, 75.9334, 75.9334, NULL),
	(64, 2, 2740, 4572, 1, 2705, 4933, 256, 27, 33.7143, 70.2568, 70.2568, NULL),
	(64, 4, 3427, 5715, 1, 0, 4457, 272, 33, 36.5714, 75.9334, 75.9334, NULL),
	(64, 8, 2399, 4000, 1, 6229, 3977, 121, 26, 31.0435, 64.089, 64.089, NULL),
	(65, 1, 3524, 5914, 1, 0, 5234, 278, 35, 37.2381, 80.3794, 80.3794, NULL),
	(65, 2, 2819, 4731, 1, 2790, 5228, 262, 29, 34.3333, 74.3252, 74.3252, NULL),
	(65, 4, 3524, 5914, 1, 0, 4724, 278, 35, 37.2381, 80.3794, 80.3794, NULL),
	(65, 8, 2467, 4731, 4731, 6443, 4214, 124, 26, 31.6015, 68.0244, 69.9742, NULL),
	(66, 1, 3624, 6116, 1, 0, 5531, 282, 37, 37.9047, 84.8941, 84.8941, NULL),
	(66, 2, 2899, 6906, 6116, 2846, 5523, 266, 29, 35.0158, 78.472, 84.8941, NULL),
	(66, 4, 3624, 6116, 1, 0, 5104, 282, 37, 37.9047, 84.8941, 84.8941, NULL),
	(66, 8, 2552, 4892, 4892, 6588, 4460, 125, 27, 32.1734, 72.0499, 78.8784, NULL),
	(67, 1, 3728, 6326, 1, 0, 5829, 288, 39, 38.5714, 89.6211, 94.901, NULL),
	(67, 2, 2982, 5060, 1, 2933, 5821, 272, 31, 35.656, 82.7944, 94.901, NULL),
	(67, 4, 3728, 6326, 1, 0, 5326, 288, 39, 38.5714, 89.6211, 94.901, NULL),
	(67, 8, 2610, 5060, 1, 6749, 4710, 128, 27, 32.736, 75.9676, 87.7826, NULL),
	(68, 1, 3834, 6542, 6986, 0, 6126, 292, 41, 39.2381, 94.4934, 104.527, NULL),
	(68, 2, 3067, 5233, 6986, 2991, 6116, 276, 31, 36.3244, 87.2677, 104.527, NULL),
	(68, 4, 3834, 6542, 6986, 0, 5527, 292, 41, 39.2381, 94.4934, 104.527, NULL),
	(68, 8, 2684, 4580, 5588, 6882, 4928, 130, 27, 33.3048, 80.1061, 96.6868, NULL),
	(69, 1, 3942, 6761, 7984, 0, 6423, 298, 43, 39.9047, 99.5328, 114.153, NULL),
	(69, 2, 3153, 5409, 7984, 3080, 6412, 282, 32, 36.974, 91.8916, 114.153, NULL),
	(69, 4, 3942, 6761, 7984, 0, 5795, 298, 43, 39.9047, 99.5328, 114.153, NULL),
	(69, 8, 2759, 4733, 6387, 7031, 5167, 133, 28, 33.8695, 84.2722, 105.591, NULL),
	(70, 1, 4050, 6986, 8982, 0, 6719, 304, 44, 40.5714, 104.527, 123.779, NULL),
	(70, 2, 3240, 5589, 8982, 3155, 6708, 286, 33, 37.6361, 96.7364, 123.779, NULL),
	(70, 4, 4050, 6986, 8982, 0, 6062, 304, 44, 40.5714, 104.527, 123.779, NULL),
	(70, 8, 2835, 4890, 7185, 7196, 5404, 135, 28, 34.4369, 88.3402, 114.496, NULL),
	(71, 1, 4163, 7181, 9291, 0, 7018, 308, 48, 41.2381, 106.357, 127.382, NULL),
	(71, 2, 3330, 5744, 9291, 3231, 7007, 290, 37, 38.2899, 98.3977, 127.383, NULL),
	(71, 4, 4163, 7181, 9291, 0, 6332, 308, 48, 41.2381, 106.357, 127.382, NULL),
	(71, 8, 2914, 5027, 7432, 7332, 5645, 137, 31, 35.0025, 92.4034, 117.829, NULL),
	(72, 1, 4278, 7380, 9610, 0, 7318, 314, 53, 41.9047, 108.071, 131.091, NULL),
	(72, 2, 3422, 5903, 9610, 3309, 7305, 296, 40, 38.9492, 99.8571, 131.092, NULL),
	(72, 4, 4278, 7380, 9610, 0, 6602, 314, 53, 41.9047, 108.071, 131.091, NULL),
	(72, 8, 2995, 5166, 7688, 7500, 5886, 140, 34, 35.5693, 96.5068, 121.259, NULL),
	(73, 1, 4399, 7588, 9940, 0, 7618, 320, 58, 42.5714, 118.643, 134.908, NULL),
	(73, 2, 3519, 6070, 9940, 3387, 7604, 302, 44, 39.6048, 101.451, 134.908, NULL),
	(73, 4, 4399, 7580, 9940, 0, 6872, 320, 58, 42.5714, 118.643, 134.908, NULL),
	(73, 8, 3098, 5311, 7952, 7654, 6126, 143, 37, 36.1353, 100.617, 124.79, NULL),
	(74, 1, 4524, 7804, 10282, 0, 7918, 354, 63, 43.2381, 120.434, 138.836, NULL),
	(74, 2, 3619, 6243, 10282, 3466, 7903, 334, 48, 40.2629, 102.955, 138.836, NULL),
	(74, 4, 4524, 1, 10282, 0, 7143, 354, 63, 43.2381, 120.434, 138.836, NULL),
	(74, 8, 3186, 1, 8225, 7809, 6368, 158, 41, 36.7018, 104.723, 128.423, NULL),
	(75, 1, 4652, 8025, 10635, 0, 8219, 392, 68, 43.9047, 122.226, 142.878, NULL),
	(75, 2, 3722, 6420, 10635, 3561, 8204, 370, 53, 40.9193, 104.52, 142.878, NULL),
	(75, 4, 4652, 1, 10635, 0, 7415, 392, 68, 43.9047, 122.226, 142.878, NULL),
	(75, 8, 3256, 5617, 8508, 7981, 6610, 175, 45, 37.268, 108.832, 132.162, NULL),
	(76, 1, 4781, 8247, 11001, 0, 8520, 432, 74, 44.5713, 124.018, 147.038, NULL),
	(76, 2, 3825, 6602, 11001, 3643, 8503, 408, 57, 41.5757, 106.085, 147.038, NULL),
	(76, 4, 4781, 1, 11001, 0, 7686, 432, 74, 44.5713, 124.018, 147.038, NULL),
	(76, 8, 3367, 1, 8800, 8139, 6851, 193, 49, 37.8342, 112.941, 136.01, NULL),
	(77, 1, 4916, 8480, 11379, 0, 8822, 478, 81, 45.2379, 125.81, 151.319, NULL),
	(77, 2, 3933, 6784, 11379, 3725, 8803, 452, 62, 42.2321, 107.65, 151.319, NULL),
	(77, 4, 4916, 1, 11379, 0, 7958, 478, 81, 45.2379, 125.81, 151.319, NULL),
	(77, 8, 3462, 1, 9103, 8313, 7094, 214, 54, 38.4004, 117.05, 139.97, NULL),
	(78, 1, 5052, 8715, 11770, 0, 9124, 528, 88, 45.9045, 127.602, 155.724, NULL),
	(78, 2, 4042, 6972, 11770, 3809, 9104, 500, 68, 42.8885, 109.215, 155.724, NULL),
	(78, 4, 5052, 1, 11770, 0, 8230, 528, 88, 45.9045, 127.602, 155.724, NULL),
	(78, 8, 3558, 1, 9416, 8459, 7335, 236, 58, 38.9666, 121.159, 144.045, NULL),
	(79, 1, 5194, 8960, 12175, 0, 9426, 582, 95, 46.5711, 129.394, 160.258, NULL),
	(79, 2, 4155, 7167, 12175, 3893, 9405, 550, 74, 43.5449, 110.78, 160.258, NULL),
	(79, 4, 5194, 1, 12175, 0, 8503, 582, 95, 46.5711, 129.394, 160.258, NULL),
	(79, 8, 3658, 1, 9740, 8636, 7579, 260, 64, 39.5328, 125.268, 148.239, NULL),
	(80, 1, 5342, 9215, 12600, 0, 9729, 642, 103, 47.2377, 131.186, 164.924, NULL),
	(80, 2, 4274, 7373, 12600, 3994, 9706, 608, 80, 44.2013, 112.345, 164.924, NULL),
	(80, 4, 5342, 1, 12600, 0, 8776, 642, 103, 47.2377, 131.186, 164.924, NULL),
	(80, 8, 3739, 1, 10080, 8814, 7822, 287, 69, 40.099, 129.377, 152.555, NULL),
	(81, 1, 5492, 9474, 13033, 0, 10033, 708, 112, 47.9043, 132.978, 168.974, NULL),
	(81, 2, 4394, 7581, 13033, 4081, 10007, 670, 86, 44.8577, 113.91, 169.095, NULL),
	(81, 4, 5496, 1, 13033, 0, 9068, 708, 112, 47.9043, 132.978, 168.974, NULL),
	(81, 8, 3870, 1, 10486, 8979, 8102, 317, 74, 40.6652, 133.486, 156.871, NULL),
	(82, 1, 5647, 9741, 13481, 0, 10356, 782, 121, 48.5709, 134.77, 173.024, NULL),
	(82, 2, 4518, 7794, 13481, 4169, 10253, 726, 91, 45.5141, 115.475, 173.266, NULL),
	(82, 4, 5647, 1, 13481, 0, 9348, 782, 121, 48.5709, 134.77, 173.024, NULL),
	(82, 8, 3977, 1, 10784, 9160, 8340, 350, 79, 41.2314, 137.595, 161.187, NULL),
	(83, 1, 5808, 11570, 13945, 0, 10673, 805, 135, 49.2375, 136.562, 177.074, NULL),
	(83, 2, 4646, 1, 13945, 4258, 10573, 783, 98, 46.1705, 117.04, 177.438, NULL),
	(83, 4, 5808, 1, 13945, 0, 9589, 805, 135, 49.2375, 136.562, 177.074, NULL),
	(83, 8, 4090, 1, 11156, 9328, 8505, 386, 84, 41.7976, 141.704, 165.503, NULL),
	(84, 1, 5971, 10300, 1, 0, 1, 828, 0, 49.9041, 138.354, 181.124, NULL),
	(84, 2, 1, 1, 1, 4363, 1, 840, 0, 46.8269, 118.605, 181.61, NULL),
	(84, 4, 1, 1, 1, 0, 1, 828, 0, 49.9041, 138.354, 181.124, NULL),
	(84, 8, 1, 1, 1, 9512, 1, 425, 0, 42.3638, 145.813, 169.819, NULL),
	(85, 1, 6141, 1, 1, 0, 1, 851, 0, 50.5707, 140.146, 185.174, NULL),
	(85, 2, 1, 1, 15498, 4454, 1, 897, 0, 47.4833, 120.17, 185.782, NULL),
	(85, 4, 1, 1, 1, 0, 1, 851, 0, 50.5707, 140.146, 185.174, NULL),
	(85, 8, 4299, 1, 1, 9697, 1, 467, 0, 42.93, 149.922, 174.135, NULL),
	(86, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(86, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(86, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(86, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(87, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(87, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(87, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(87, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(88, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(88, 2, 1, 1, 16515, 4735, 1, 0, 0, 0, 0, 0, NULL),
	(88, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(88, 8, 1, 1, 1, 10232, 1, 0, 0, 0, 0, 0, NULL),
	(89, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(89, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(89, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(89, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(90, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(90, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(90, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(90, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(91, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(91, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(91, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(91, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(92, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(92, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(92, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(92, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(93, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(93, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(93, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(93, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(94, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(94, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(94, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(94, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(95, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(95, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(95, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(95, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(96, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(96, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(96, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(96, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(97, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(97, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(97, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(97, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(98, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(98, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(98, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(98, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(99, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(99, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(99, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(99, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(100, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(100, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL),
	(100, 4, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, NULL),
	(100, 8, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, NULL);
/*!40000 ALTER TABLE `creature_classlevelstats` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
