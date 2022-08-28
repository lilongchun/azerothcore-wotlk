-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.creature_template_resistance
DROP TABLE IF EXISTS `creature_template_resistance`;
CREATE TABLE IF NOT EXISTS `creature_template_resistance` (
  `CreatureID` mediumint unsigned NOT NULL,
  `School` tinyint unsigned NOT NULL,
  `Resistance` smallint DEFAULT NULL,
  `VerifiedBuild` smallint DEFAULT '0',
  PRIMARY KEY (`CreatureID`,`School`),
  CONSTRAINT `creature_template_resistance_chk_1` CHECK (((`School` >= 1) and (`School` <= 6)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.creature_template_resistance: ~1 600 rows (ungefär)
DELETE FROM `creature_template_resistance`;
/*!40000 ALTER TABLE `creature_template_resistance` DISABLE KEYS */;
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
	(40, 2, 21, 12340),
	(89, 2, 300, 12340),
	(157, 5, 40, 12340),
	(157, 6, 10, 12340),
	(193, 4, 175, 12340),
	(264, 2, 100, 12340),
	(264, 6, 100, 12340),
	(327, 2, 24, 12340),
	(329, 2, 260, 12340),
	(329, 3, 260, 12340),
	(329, 4, 260, 12340),
	(329, 5, 260, 12340),
	(329, 6, 260, 12340),
	(334, 6, 100, 12340),
	(423, 5, 50, 12340),
	(429, 5, 50, 12340),
	(431, 5, 50, 12340),
	(432, 5, 50, 12340),
	(433, 5, 50, 12340),
	(474, 3, 10, 12340),
	(475, 2, 21, 12340),
	(476, 2, 24, 12340),
	(487, 6, 10, 12340),
	(488, 6, 10, 12340),
	(489, 6, 10, 12340),
	(490, 6, 10, 12340),
	(494, 2, 100, 12340),
	(494, 6, 100, 12340),
	(495, 2, 100, 12340),
	(495, 6, 100, 12340),
	(499, 2, 100, 12340),
	(499, 6, 100, 12340),
	(521, 2, 80, 12340),
	(521, 3, 80, 12340),
	(521, 4, 80, 12340),
	(521, 5, 80, 12340),
	(521, 6, 80, 12340),
	(533, 5, 56, 12340),
	(579, 5, 50, 12340),
	(594, 2, 10, 12340),
	(594, 3, 10, 12340),
	(594, 4, 10, 12340),
	(594, 5, 10, 12340),
	(594, 6, 10, 12340),
	(619, 2, 10, 12340),
	(619, 3, 10, 12340),
	(619, 4, 10, 12340),
	(619, 5, 10, 12340),
	(619, 6, 10, 12340),
	(628, 2, 4, 12340),
	(628, 3, 7, 12340),
	(628, 6, 1, 12340),
	(634, 2, 10, 12340),
	(634, 3, 10, 12340),
	(634, 4, 10, 12340),
	(634, 5, 10, 12340),
	(634, 6, 10, 12340),
	(636, 2, 10, 12340),
	(636, 3, 10, 12340),
	(636, 4, 10, 12340),
	(636, 5, 10, 12340),
	(636, 6, 10, 12340),
	(657, 2, 10, 12340),
	(657, 3, 10, 12340),
	(657, 4, 10, 12340),
	(657, 5, 10, 12340),
	(657, 6, 10, 12340),
	(740, 5, 105, 12340),
	(741, 3, 80, 12340),
	(741, 5, 107, 12340),
	(742, 3, 100, 12340),
	(742, 5, 168, 12340),
	(743, 3, 100, 12340),
	(744, 3, 100, 12340),
	(744, 5, 172, 12340),
	(745, 3, 100, 12340),
	(764, 2, 39, 12340),
	(764, 3, 39, 12340),
	(764, 4, 39, 12340),
	(764, 5, 78, 12340),
	(764, 6, 39, 12340),
	(765, 2, 40, 12340),
	(765, 3, 40, 12340),
	(765, 4, 40, 12340),
	(765, 5, 80, 12340),
	(765, 6, 40, 12340),
	(766, 2, 41, 12340),
	(766, 3, 41, 12340),
	(766, 4, 41, 12340),
	(766, 5, 82, 12340),
	(766, 6, 41, 12340),
	(820, 6, 10, 12340),
	(821, 6, 10, 12340),
	(826, 2, 100, 12340),
	(826, 6, 100, 12340),
	(827, 2, 100, 12340),
	(827, 6, 100, 12340),
	(828, 2, 100, 12340),
	(828, 6, 100, 12340),
	(840, 2, 100, 12340),
	(840, 6, 100, 12340),
	(869, 6, 10, 12340),
	(870, 6, 10, 12340),
	(874, 6, 10, 12340),
	(876, 6, 10, 12340),
	(878, 6, 10, 12340),
	(885, 2, 100, 12340),
	(885, 6, 100, 12340),
	(886, 2, 100, 12340),
	(886, 6, 100, 12340),
	(887, 2, 100, 12340),
	(887, 6, 100, 12340),
	(888, 2, 100, 12340),
	(888, 6, 100, 12340),
	(910, 6, 40, 12340),
	(920, 5, 60, 12340),
	(999, 2, 100, 12340),
	(999, 6, 100, 12340),
	(1000, 2, 100, 12340),
	(1000, 6, 100, 12340),
	(1001, 2, 100, 12340),
	(1001, 6, 100, 12340),
	(1024, 4, 30, 12340),
	(1025, 4, 30, 12340),
	(1026, 4, 30, 12340),
	(1027, 4, 30, 12340),
	(1028, 4, 30, 12340),
	(1029, 4, 30, 12340),
	(1031, 6, 100, 12340),
	(1032, 6, 100, 12340),
	(1033, 6, 100, 12340),
	(1034, 2, 25, 12340),
	(1035, 2, 25, 12340),
	(1035, 4, 25, 12340),
	(1035, 5, 25, 12340),
	(1035, 6, 25, 12340),
	(1036, 2, 25, 12340),
	(1037, 2, 25, 12340),
	(1038, 2, 25, 12340),
	(1039, 3, 50, 12340),
	(1040, 3, 50, 12340),
	(1041, 3, 50, 12340),
	(1042, 2, 62, 12340),
	(1043, 2, 62, 12340),
	(1043, 6, 75, 12340),
	(1044, 2, 62, 12340),
	(1045, 2, 174, 12340),
	(1047, 2, 180, 12340),
	(1048, 2, 183, 12340),
	(1049, 2, 186, 12340),
	(1050, 2, 186, 12340),
	(1051, 6, 100, 12340),
	(1052, 6, 100, 12340),
	(1053, 6, 100, 12340),
	(1054, 6, 100, 12340),
	(1057, 2, 25, 12340),
	(1069, 2, 75, 12340),
	(1098, 2, 100, 12340),
	(1098, 6, 100, 12340),
	(1099, 2, 100, 12340),
	(1099, 6, 100, 12340),
	(1100, 2, 100, 12340),
	(1100, 6, 100, 12340),
	(1101, 2, 100, 12340),
	(1101, 6, 100, 12340),
	(1134, 4, 40, 12340),
	(1135, 4, 40, 12340),
	(1169, 6, 100, 12340),
	(1199, 3, 10, 12340),
	(1201, 3, 10, 12340),
	(1203, 2, 100, 12340),
	(1203, 6, 100, 12340),
	(1204, 2, 100, 12340),
	(1204, 6, 100, 12340),
	(1222, 6, 100, 12340),
	(1225, 2, 40, 12340),
	(1225, 4, 40, 12340),
	(1225, 6, 40, 12340),
	(1236, 2, 39, 12340),
	(1244, 5, 30, 12340),
	(1253, 2, 30, 12340),
	(1253, 6, 70, 12340),
	(1258, 2, 5, 12340),
	(1258, 3, 8, 12340),
	(1258, 6, 2, 12340),
	(1418, 4, 30, 12340),
	(1436, 2, 100, 12340),
	(1436, 6, 100, 12340),
	(1495, 6, 10, 12340),
	(1496, 6, 10, 12340),
	(1501, 2, 1, 12340),
	(1501, 3, 1, 12340),
	(1501, 4, 1, 12340),
	(1501, 5, 1, 12340),
	(1501, 6, 1, 12340),
	(1502, 2, 1, 12340),
	(1502, 3, 1, 12340),
	(1502, 4, 1, 12340),
	(1502, 5, 1, 12340),
	(1502, 6, 1, 12340),
	(1509, 3, 1, 12340),
	(1515, 6, 10, 12340),
	(1519, 6, 10, 12340),
	(1570, 6, 10, 12340),
	(1652, 6, 10, 12340),
	(1706, 2, 10, 12340),
	(1706, 3, 10, 12340),
	(1706, 4, 10, 12340),
	(1706, 5, 10, 12340),
	(1706, 6, 10, 12340),
	(1707, 2, 10, 12340),
	(1707, 3, 10, 12340),
	(1707, 4, 10, 12340),
	(1707, 5, 10, 12340),
	(1707, 6, 10, 12340),
	(1708, 2, 10, 12340),
	(1708, 3, 10, 12340),
	(1708, 4, 10, 12340),
	(1708, 5, 10, 12340),
	(1708, 6, 10, 12340),
	(1711, 2, 10, 12340),
	(1711, 3, 10, 12340),
	(1711, 4, 10, 12340),
	(1711, 5, 10, 12340),
	(1711, 6, 10, 12340),
	(1715, 2, 10, 12340),
	(1715, 3, 10, 12340),
	(1715, 4, 10, 12340),
	(1715, 5, 10, 12340),
	(1715, 6, 10, 12340),
	(1725, 2, 10, 12340),
	(1725, 3, 10, 12340),
	(1725, 4, 10, 12340),
	(1725, 5, 10, 12340),
	(1725, 6, 10, 12340),
	(1726, 2, 10, 12340),
	(1726, 3, 10, 12340),
	(1726, 4, 10, 12340),
	(1726, 5, 10, 12340),
	(1726, 6, 10, 12340),
	(1729, 2, 10, 12340),
	(1729, 3, 10, 12340),
	(1729, 4, 10, 12340),
	(1729, 5, 10, 12340),
	(1729, 6, 10, 12340),
	(1732, 2, 10, 12340),
	(1732, 3, 10, 12340),
	(1732, 4, 10, 12340),
	(1732, 5, 10, 12340),
	(1732, 6, 10, 12340),
	(1735, 6, 10, 12340),
	(1736, 6, 10, 12340),
	(1737, 6, 10, 12340),
	(1738, 6, 10, 12340),
	(1739, 6, 10, 12340),
	(1741, 6, 10, 12340),
	(1742, 6, 10, 12340),
	(1743, 6, 10, 12340),
	(1744, 6, 10, 12340),
	(1745, 6, 10, 12340),
	(1746, 6, 10, 12340),
	(1756, 2, 50, 12340),
	(1756, 3, 50, 12340),
	(1756, 4, 50, 12340),
	(1756, 5, 50, 12340),
	(1756, 6, 50, 12340),
	(1769, 4, 40, 12340),
	(1782, 5, 40, 12340),
	(1796, 4, 150, 12340),
	(1800, 4, 165, 12340),
	(1808, 6, 100, 12340),
	(1812, 2, 55, 12340),
	(1812, 3, 55, 12340),
	(1812, 4, 55, 12340),
	(1812, 5, 110, 12340),
	(1812, 6, 110, 12340),
	(1813, 2, 57, 12340),
	(1813, 3, 57, 12340),
	(1813, 4, 114, 12340),
	(1813, 5, 57, 12340),
	(1813, 6, 114, 12340),
	(1867, 4, 50, 12340),
	(1867, 6, 30, 12340),
	(1885, 2, 177, 12340),
	(1888, 4, 50, 12340),
	(1888, 6, 30, 12340),
	(1889, 4, 50, 12340),
	(1889, 6, 30, 12340),
	(1912, 4, 50, 12340),
	(1913, 4, 50, 12340),
	(1914, 4, 50, 12340),
	(1914, 6, 30, 12340),
	(1915, 4, 50, 12340),
	(1915, 6, 30, 12340),
	(1920, 4, 50, 12340),
	(1981, 6, 100, 12340),
	(2038, 6, 32, 12340),
	(2091, 2, 400, 12340),
	(2102, 2, 25, 12340),
	(2103, 2, 25, 12340),
	(2142, 2, 100, 12340),
	(2142, 6, 100, 12340),
	(2149, 6, 100, 12340),
	(2166, 2, 18, 12340),
	(2166, 3, 18, 12340),
	(2166, 4, 18, 12340),
	(2166, 5, 27, 12340),
	(2166, 6, 18, 12340),
	(2175, 6, 10, 12340),
	(2209, 6, 10, 12340),
	(2210, 6, 10, 12340),
	(2241, 3, 100, 12340),
	(2244, 5, 15, 12340),
	(2250, 4, 66, 12340),
	(2251, 4, 68, 12340),
	(2252, 3, 35, 12340),
	(2253, 3, 36, 12340),
	(2254, 3, 37, 12340),
	(2255, 3, 38, 12340),
	(2256, 3, 39, 12340),
	(2258, 3, 74, 12340),
	(2271, 4, 50, 12340),
	(2272, 4, 50, 12340),
	(2287, 3, 40, 12340),
	(2336, 5, 40, 12340),
	(2337, 5, 39, 12340),
	(2337, 6, 39, 12340),
	(2358, 4, 50, 12340),
	(2359, 2, 34, 12340),
	(2359, 3, 34, 12340),
	(2359, 4, 34, 12340),
	(2359, 5, 68, 12340),
	(2359, 6, 34, 12340),
	(2405, 6, 10, 12340),
	(2408, 4, 75, 12340),
	(2416, 3, 37, 12340),
	(2418, 6, 10, 12340),
	(2419, 6, 10, 12340),
	(2425, 6, 252, 12340),
	(2470, 2, 100, 12340),
	(2470, 6, 100, 12340),
	(2540, 4, 50, 12340),
	(2575, 6, 100, 12340),
	(2577, 5, 75, 12340),
	(2577, 6, 100, 12340),
	(2590, 6, 54, 12340),
	(2591, 6, 57, 12340),
	(2597, 3, 100, 12340),
	(2611, 2, 25, 12340),
	(2611, 3, 25, 12340),
	(2611, 4, 25, 12340),
	(2611, 5, 25, 12340),
	(2628, 4, 50, 12340),
	(2642, 5, 118, 12340),
	(2655, 3, 115, 12340),
	(2656, 3, 240, 12340),
	(2656, 6, 100, 12340),
	(2716, 2, 100, 12340),
	(2725, 2, 132, 12340),
	(2745, 2, 210, 12340),
	(2745, 3, 42, 12340),
	(2745, 4, 42, 12340),
	(2745, 5, 42, 12340),
	(2745, 6, 42, 12340),
	(2752, 3, 70, 12340),
	(2761, 2, 39, 12340),
	(2761, 3, 78, 12340),
	(2761, 4, 39, 12340),
	(2761, 5, 39, 12340),
	(2761, 6, 39, 12340),
	(2762, 5, 30, 12340),
	(2776, 2, 40, 12340),
	(2776, 3, 40, 12340),
	(2776, 4, 40, 12340),
	(2776, 5, 80, 12340),
	(2776, 6, 40, 12340),
	(2794, 2, 190, 12340),
	(2794, 3, 190, 12340),
	(2794, 4, 190, 12340),
	(2794, 5, 190, 12340),
	(2794, 6, 190, 12340),
	(2887, 2, 41, 12340),
	(2887, 3, 41, 12340),
	(2887, 4, 41, 12340),
	(2887, 5, 82, 12340),
	(2887, 6, 41, 12340),
	(2919, 2, 45, 12340),
	(2919, 3, 45, 12340),
	(2919, 4, 45, 12340),
	(2919, 5, 45, 12340),
	(2919, 6, 45, 12340),
	(3247, 3, 20, 12340),
	(3249, 3, 24, 12340),
	(3272, 2, 70, 12340),
	(3272, 5, 30, 12340),
	(3424, 3, 22, 12340),
	(3516, 2, 630, 12340),
	(3516, 3, 504, 12340),
	(3516, 4, 504, 12340),
	(3516, 5, 504, 12340),
	(3516, 6, 504, 12340),
	(3568, 2, 150, 12340),
	(3568, 3, 150, 12340),
	(3568, 4, 150, 12340),
	(3568, 5, 150, 12340),
	(3568, 6, 150, 12340),
	(3569, 2, 5, 12340),
	(3569, 3, 5, 12340),
	(3569, 4, 5, 12340),
	(3569, 5, 10, 12340),
	(3569, 6, 5, 12340),
	(3570, 5, 30, 12340),
	(3577, 4, 50, 12340),
	(3578, 4, 50, 12340),
	(3630, 2, 2, 12340),
	(3630, 3, 2, 12340),
	(3630, 4, 2, 12340),
	(3630, 5, 2, 12340),
	(3630, 6, 2, 12340),
	(3631, 2, 2, 12340),
	(3631, 3, 2, 12340),
	(3631, 4, 2, 12340),
	(3631, 5, 2, 12340),
	(3631, 6, 2, 12340),
	(3641, 4, 100, 12340),
	(3653, 2, 60, 12340),
	(3662, 6, 68, 12340),
	(3725, 5, 40, 12340),
	(3728, 5, 40, 12340),
	(3773, 6, 104, 12340),
	(3840, 3, 40, 12340),
	(3898, 6, 96, 12340),
	(3900, 6, 96, 12340),
	(3917, 4, 75, 12340),
	(3950, 2, 1, 12340),
	(3950, 3, 1, 12340),
	(3950, 4, 1, 12340),
	(3950, 5, 1, 12340),
	(3950, 6, 1, 12340),
	(3990, 5, 30, 12340),
	(4016, 3, 20, 12340),
	(4017, 3, 20, 12340),
	(4028, 2, 26, 12340),
	(4028, 3, 26, 12340),
	(4028, 4, 52, 12340),
	(4028, 5, 26, 12340),
	(4028, 6, 52, 12340),
	(4029, 2, 28, 12340),
	(4029, 3, 28, 12340),
	(4029, 4, 28, 12340),
	(4029, 5, 28, 12340),
	(4029, 6, 56, 12340),
	(4030, 2, 240, 12340),
	(4030, 3, 240, 12340),
	(4030, 4, 240, 12340),
	(4030, 5, 300, 12340),
	(4030, 6, 240, 12340),
	(4034, 2, 25, 12340),
	(4034, 3, 25, 12340),
	(4034, 4, 50, 12340),
	(4034, 5, 25, 12340),
	(4034, 6, 50, 12340),
	(4053, 2, 25, 12340),
	(4053, 3, 25, 12340),
	(4053, 4, 25, 12340),
	(4053, 5, 25, 12340),
	(4053, 6, 25, 12340),
	(4057, 3, 75, 12340),
	(4061, 2, 25, 12340),
	(4061, 3, 25, 12340),
	(4061, 4, 25, 12340),
	(4061, 5, 25, 12340),
	(4062, 6, 100, 12340),
	(4064, 6, 100, 12340),
	(4111, 2, 81, 12340),
	(4112, 2, 80, 12340),
	(4113, 2, 83, 12340),
	(4114, 2, 82, 12340),
	(4116, 2, 90, 12340),
	(4117, 3, 54, 12340),
	(4118, 3, 56, 12340),
	(4119, 3, 58, 12340),
	(4276, 5, 30, 12340),
	(4323, 2, 128, 12340),
	(4324, 3, 129, 12340),
	(4328, 2, 100, 12340),
	(4329, 2, 100, 12340),
	(4331, 2, 100, 12340),
	(4333, 2, 110, 12340),
	(4334, 2, 100, 12340),
	(4391, 6, 100, 12340),
	(4392, 6, 100, 12340),
	(4393, 6, 100, 12340),
	(4417, 2, 10, 12340),
	(4417, 3, 10, 12340),
	(4417, 4, 10, 12340),
	(4417, 5, 10, 12340),
	(4417, 6, 10, 12340),
	(4418, 2, 10, 12340),
	(4418, 3, 10, 12340),
	(4418, 4, 10, 12340),
	(4418, 5, 10, 12340),
	(4418, 6, 10, 12340),
	(4423, 2, 60, 12340),
	(4423, 3, 60, 12340),
	(4423, 4, 60, 12340),
	(4423, 5, 120, 12340),
	(4423, 6, 60, 12340),
	(4468, 3, 240, 12340),
	(4469, 3, 115, 12340),
	(4469, 6, 100, 12340),
	(4517, 6, 45, 12340),
	(4518, 6, 45, 12340),
	(4519, 6, 45, 12340),
	(4525, 2, 70, 12340),
	(4525, 5, 100, 12340),
	(4531, 2, 70, 12340),
	(4531, 5, 100, 12340),
	(4535, 2, 30, 12340),
	(4535, 3, 10, 12340),
	(4535, 4, 10, 12340),
	(4535, 5, 150, 12340),
	(4535, 6, 20, 12340),
	(4619, 6, 128, 12340),
	(4632, 2, 70, 12340),
	(4632, 5, 30, 12340),
	(4633, 2, 70, 12340),
	(4633, 5, 30, 12340),
	(4634, 2, 70, 12340),
	(4634, 5, 30, 12340),
	(4635, 2, 70, 12340),
	(4635, 5, 30, 12340),
	(4636, 2, 70, 12340),
	(4636, 5, 30, 12340),
	(4637, 2, 70, 12340),
	(4637, 5, 30, 12340),
	(4661, 2, 30, 12340),
	(4661, 3, 30, 12340),
	(4661, 4, 30, 12340),
	(4661, 5, 30, 12340),
	(4661, 6, 60, 12340),
	(4676, 2, 300, 12340),
	(4677, 2, 90, 12340),
	(4680, 2, 95, 12340),
	(4682, 5, 95, 12340),
	(4683, 2, 95, 12340),
	(4684, 5, 100, 12340),
	(4783, 2, 30, 12340),
	(4783, 6, 70, 12340),
	(4784, 2, 30, 12340),
	(4784, 6, 70, 12340),
	(4786, 2, 30, 12340),
	(4786, 6, 70, 12340),
	(4787, 2, 30, 12340),
	(4787, 6, 70, 12340),
	(4816, 2, 75, 12340),
	(4816, 3, 75, 12340),
	(4816, 4, 75, 12340),
	(4816, 5, 75, 12340),
	(4848, 5, 80, 12340),
	(4887, 2, 75, 12340),
	(5056, 2, 2, 12340),
	(5056, 3, 2, 12340),
	(5056, 4, 2, 12340),
	(5056, 5, 2, 12340),
	(5056, 6, 2, 12340),
	(5228, 6, 100, 12340),
	(5235, 6, 100, 12340),
	(5243, 3, 30, 12340),
	(5243, 6, 70, 12340),
	(5249, 3, 20, 12340),
	(5251, 3, 21, 12340),
	(5253, 3, 21, 12340),
	(5254, 3, 21, 12340),
	(5255, 3, 21, 12340),
	(5256, 3, 30, 12340),
	(5256, 6, 70, 12340),
	(5258, 3, 22, 12340),
	(5259, 3, 30, 12340),
	(5259, 6, 70, 12340),
	(5261, 3, 30, 12340),
	(5261, 6, 70, 12340),
	(5263, 3, 30, 12340),
	(5263, 6, 70, 12340),
	(5267, 3, 30, 12340),
	(5267, 6, 70, 12340),
	(5269, 3, 30, 12340),
	(5269, 6, 70, 12340),
	(5270, 3, 30, 12340),
	(5270, 6, 70, 12340),
	(5271, 3, 30, 12340),
	(5271, 6, 70, 12340),
	(5273, 3, 30, 12340),
	(5273, 6, 70, 12340),
	(5276, 2, 77, 12340),
	(5276, 3, 77, 12340),
	(5276, 4, 77, 12340),
	(5276, 5, 77, 12340),
	(5277, 3, 200, 12340),
	(5277, 5, 204, 12340),
	(5278, 2, 70, 12340),
	(5278, 3, 70, 12340),
	(5278, 4, 70, 12340),
	(5278, 5, 70, 12340),
	(5280, 3, 200, 12340),
	(5280, 5, 200, 12340),
	(5283, 3, 200, 12340),
	(5283, 5, 196, 12340),
	(5288, 3, 1, 12340),
	(5291, 2, 2, 12340),
	(5291, 3, 2, 12340),
	(5291, 4, 2, 12340),
	(5291, 5, 2, 12340),
	(5291, 6, 2, 12340),
	(5295, 4, 125, 12340),
	(5319, 5, 240, 12340),
	(5349, 2, 85, 12340),
	(5349, 3, 85, 12340),
	(5349, 4, 85, 12340),
	(5349, 5, 85, 12340),
	(5349, 6, 85, 12340),
	(5356, 2, 100, 12340),
	(5356, 3, 100, 12340),
	(5356, 4, 100, 12340),
	(5356, 5, 100, 12340),
	(5356, 6, 100, 12340),
	(5400, 5, 120, 12340),
	(5429, 2, 110, 12340),
	(5430, 2, 240, 12340),
	(5461, 4, 120, 12340),
	(5462, 4, 125, 12340),
	(5465, 3, 125, 12340),
	(5481, 2, 96, 12340),
	(5481, 3, 96, 12340),
	(5481, 4, 96, 12340),
	(5481, 5, 96, 12340),
	(5481, 6, 96, 12340),
	(5485, 2, 50, 12340),
	(5485, 3, 100, 12340),
	(5485, 4, 50, 12340),
	(5485, 5, 100, 12340),
	(5485, 6, 50, 12340),
	(5598, 3, 30, 12340),
	(5598, 6, 70, 12340),
	(5624, 6, 10, 12340),
	(5725, 6, 10, 12340),
	(5756, 2, 2, 12340),
	(5756, 3, 2, 12340),
	(5756, 4, 2, 12340),
	(5756, 5, 2, 12340),
	(5756, 6, 2, 12340),
	(5760, 6, 160, 12340),
	(5761, 2, 100, 12340),
	(5761, 3, 100, 12340),
	(5761, 4, 100, 12340),
	(5761, 5, 100, 12340),
	(5761, 6, 100, 12340),
	(5806, 2, 23, 12340),
	(5806, 3, 23, 12340),
	(5806, 4, 23, 12340),
	(5806, 5, 46, 12340),
	(5806, 6, 23, 12340),
	(5834, 2, 55, 12340),
	(5834, 3, 55, 12340),
	(5834, 4, 55, 12340),
	(5834, 5, 55, 12340),
	(5834, 6, 55, 12340),
	(5839, 6, 100, 12340),
	(5840, 6, 100, 12340),
	(5844, 6, 100, 12340),
	(5846, 6, 100, 12340),
	(5849, 2, 100, 12340),
	(5853, 2, 46, 12340),
	(5853, 3, 46, 12340),
	(5853, 4, 46, 12340),
	(5853, 5, 92, 12340),
	(5853, 6, 46, 12340),
	(5855, 2, 170, 12340),
	(5855, 3, 170, 12340),
	(5857, 2, 125, 12340),
	(5858, 2, 125, 12340),
	(5861, 2, 150, 12340),
	(5881, 2, 45, 12340),
	(5881, 3, 45, 12340),
	(5881, 4, 45, 12340),
	(5881, 5, 90, 12340),
	(5881, 6, 45, 12340),
	(5890, 2, 1, 12340),
	(5890, 3, 1, 12340),
	(5890, 4, 1, 12340),
	(5890, 5, 1, 12340),
	(5890, 6, 1, 12340),
	(5891, 3, 15, 12340),
	(5891, 5, 30, 12340),
	(5895, 5, 30, 12340),
	(5898, 5, 30, 12340),
	(5902, 5, 30, 12340),
	(5930, 2, 70, 12340),
	(5990, 2, 100, 12340),
	(5991, 2, 100, 12340),
	(5992, 2, 98, 12340),
	(5993, 2, 106, 12340),
	(6004, 5, 102, 12340),
	(6005, 5, 104, 12340),
	(6006, 5, 106, 12340),
	(6007, 5, 108, 12340),
	(6008, 5, 108, 12340),
	(6009, 5, 110, 12340),
	(6072, 5, 102, 12340),
	(6072, 6, 136, 12340),
	(6073, 2, 300, 12340),
	(6074, 2, 23, 12340),
	(6074, 3, 23, 12340),
	(6074, 4, 23, 12340),
	(6074, 5, 23, 12340),
	(6074, 6, 23, 12340),
	(6115, 2, 75, 12340),
	(6115, 5, 75, 12340),
	(6123, 6, 100, 12340),
	(6124, 6, 100, 12340),
	(6129, 4, 175, 12340),
	(6130, 4, 175, 12340),
	(6131, 3, 208, 12340),
	(6131, 4, 175, 12340),
	(6200, 6, 204, 12340),
	(6201, 6, 209, 12340),
	(6202, 6, 214, 12340),
	(6212, 6, 100, 12340),
	(6220, 2, 29, 12340),
	(6220, 3, 145, 12340),
	(6220, 4, 29, 12340),
	(6220, 5, 29, 12340),
	(6220, 6, 29, 12340),
	(6228, 6, 100, 12340),
	(6239, 2, 40, 12340),
	(6239, 3, 40, 12340),
	(6239, 4, 40, 12340),
	(6239, 5, 200, 12340),
	(6239, 6, 40, 12340),
	(6352, 2, 108, 12340),
	(6389, 6, 10, 12340),
	(6492, 2, 17, 12340),
	(6492, 3, 34, 12340),
	(6492, 4, 17, 12340),
	(6492, 5, 34, 12340),
	(6492, 6, 17, 12340),
	(6498, 2, 200, 12340),
	(6498, 3, 200, 12340),
	(6498, 4, 200, 12340),
	(6498, 5, 200, 12340),
	(6498, 6, 200, 12340),
	(6499, 2, 200, 12340),
	(6499, 3, 200, 12340),
	(6499, 4, 200, 12340),
	(6499, 5, 200, 12340),
	(6499, 6, 200, 12340),
	(6500, 2, 200, 12340),
	(6500, 3, 200, 12340),
	(6500, 4, 200, 12340),
	(6500, 5, 200, 12340),
	(6500, 6, 200, 12340),
	(6517, 3, 51, 12340),
	(6518, 3, 51, 12340),
	(6519, 3, 51, 12340),
	(6523, 6, 100, 12340),
	(6527, 3, 51, 12340),
	(6550, 2, 40, 12340),
	(6550, 3, 40, 12340),
	(6550, 4, 40, 12340),
	(6550, 5, 40, 12340),
	(6550, 6, 40, 12340),
	(6556, 6, 100, 12340),
	(6559, 6, 100, 12340),
	(6748, 2, 60, 12340),
	(6748, 3, 50, 12340),
	(6748, 4, 60, 12340),
	(6748, 5, 10, 12340),
	(6748, 6, 10, 12340),
	(7031, 2, 190, 12340),
	(7031, 3, 190, 12340),
	(7031, 4, 52, 12340),
	(7031, 5, 52, 12340),
	(7031, 6, 52, 12340),
	(7032, 2, 168, 12340),
	(7032, 3, 112, 12340),
	(7032, 4, 112, 12340),
	(7032, 5, 112, 12340),
	(7032, 6, 112, 12340),
	(7034, 6, 78, 12340),
	(7040, 2, 125, 12340),
	(7041, 2, 125, 12340),
	(7042, 2, 125, 12340),
	(7043, 2, 125, 12340),
	(7047, 2, 150, 12340),
	(7048, 2, 150, 12340),
	(7086, 6, 100, 12340),
	(7092, 6, 100, 12340),
	(7093, 6, 100, 12340),
	(7099, 5, 20, 12340),
	(7104, 2, 560, 12340),
	(7104, 3, 560, 12340),
	(7104, 4, 560, 12340),
	(7104, 5, 560, 12340),
	(7104, 6, 560, 12340),
	(7105, 6, 200, 12340),
	(7106, 6, 200, 12340),
	(7107, 6, 204, 12340),
	(7108, 6, 208, 12340),
	(7109, 6, 200, 12340),
	(7110, 6, 205, 12340),
	(7111, 6, 212, 12340),
	(7132, 2, 54, 12340),
	(7132, 3, 54, 12340),
	(7132, 4, 54, 12340),
	(7132, 5, 54, 12340),
	(7132, 6, 108, 12340),
	(7135, 2, 300, 12340),
	(7135, 5, 76, 12340),
	(7136, 2, 300, 12340),
	(7136, 5, 77, 12340),
	(7137, 2, 300, 12340),
	(7226, 2, 46, 12340),
	(7226, 3, 46, 12340),
	(7226, 4, 46, 12340),
	(7226, 5, 92, 12340),
	(7226, 6, 46, 12340),
	(7266, 2, 32, 12340),
	(7266, 3, 32, 12340),
	(7266, 4, 32, 12340),
	(7266, 5, 64, 12340),
	(7266, 6, 32, 12340),
	(7291, 5, 50, 12340),
	(7310, 5, 30, 12340),
	(7341, 4, 190, 12340),
	(7432, 3, 50, 12340),
	(7433, 3, 50, 12340),
	(7434, 3, 50, 12340),
	(7435, 4, 82, 12340),
	(7435, 6, 165, 12340),
	(7436, 4, 84, 12340),
	(7436, 6, 168, 12340),
	(7437, 4, 85, 12340),
	(7437, 6, 170, 12340),
	(7455, 3, 55, 12340),
	(7455, 5, 25, 12340),
	(7456, 3, 55, 12340),
	(7456, 5, 25, 12340),
	(7457, 4, 110, 12340),
	(7458, 4, 112, 12340),
	(7459, 4, 114, 12340),
	(7460, 4, 116, 12340),
	(7489, 6, 10, 12340),
	(7584, 3, 200, 12340),
	(7664, 2, 50, 12340),
	(7664, 5, 50, 12340),
	(7666, 2, 116, 12340),
	(7666, 4, 116, 12340),
	(7666, 6, 116, 12340),
	(7726, 3, 65, 12340),
	(7734, 6, 240, 12340),
	(7735, 3, 120, 12340),
	(7735, 4, 120, 12340),
	(7735, 5, 120, 12340),
	(7768, 3, 40, 12340),
	(7780, 3, 40, 12340),
	(7980, 6, 10, 12340),
	(8096, 6, 10, 12340),
	(8207, 6, 110, 12340),
	(8211, 2, 90, 12340),
	(8211, 3, 90, 12340),
	(8211, 4, 90, 12340),
	(8211, 5, 90, 12340),
	(8211, 6, 90, 12340),
	(8212, 3, 240, 12340),
	(8213, 2, 153, 12340),
	(8213, 3, 51, 12340),
	(8213, 4, 51, 12340),
	(8213, 5, 51, 12340),
	(8213, 6, 51, 12340),
	(8257, 6, 100, 12340),
	(8277, 2, 125, 12340),
	(8278, 2, 170, 12340),
	(8278, 3, 170, 12340),
	(8280, 2, 95, 12340),
	(8280, 5, 95, 12340),
	(8281, 2, 294, 12340),
	(8281, 3, 294, 12340),
	(8281, 4, 294, 12340),
	(8281, 5, 294, 12340),
	(8281, 6, 294, 12340),
	(8303, 2, 40, 12340),
	(8303, 3, 10, 12340),
	(8303, 5, 230, 12340),
	(8303, 6, 60, 12340),
	(8310, 2, 100, 12340),
	(8310, 6, 100, 12340),
	(8317, 3, 30, 12340),
	(8317, 6, 70, 12340),
	(8319, 3, 200, 12340),
	(8319, 5, 147, 12340),
	(8324, 3, 30, 12340),
	(8324, 6, 70, 12340),
	(8337, 6, 100, 12340),
	(8338, 6, 100, 12340),
	(8400, 2, 208, 12340),
	(8400, 3, 104, 12340),
	(8400, 4, 104, 12340),
	(8400, 5, 156, 12340),
	(8400, 6, 104, 12340),
	(8438, 4, 125, 12340),
	(8440, 4, 125, 12340),
	(8441, 2, 48, 12340),
	(8441, 3, 48, 12340),
	(8441, 4, 48, 12340),
	(8441, 5, 96, 12340),
	(8441, 6, 48, 12340),
	(8497, 3, 200, 12340),
	(8497, 5, 196, 12340),
	(8504, 6, 100, 12340),
	(8566, 6, 100, 12340),
	(8608, 2, 300, 12340),
	(8616, 2, 300, 12340),
	(8637, 6, 100, 12340),
	(8667, 2, 44, 12340),
	(8667, 3, 44, 12340),
	(8667, 4, 44, 12340),
	(8667, 5, 44, 12340),
	(8667, 6, 44, 12340),
	(8668, 2, 75, 12340),
	(8668, 3, 75, 12340),
	(8668, 4, 75, 12340),
	(8668, 5, 75, 12340),
	(8675, 2, 75, 12340),
	(8675, 3, 75, 12340),
	(8675, 4, 75, 12340),
	(8675, 5, 75, 12340),
	(8716, 6, 248, 12340),
	(8718, 5, 93, 12340),
	(8766, 3, 100, 12340),
	(8766, 6, 100, 12340),
	(8889, 2, 100, 12340),
	(8889, 5, 20, 12340),
	(8890, 2, 100, 12340),
	(8890, 5, 20, 12340),
	(8891, 2, 100, 12340),
	(8891, 5, 20, 12340),
	(8892, 2, 100, 12340),
	(8892, 5, 20, 12340),
	(8893, 2, 100, 12340),
	(8893, 5, 20, 12340),
	(8894, 2, 100, 12340),
	(8894, 5, 20, 12340),
	(8901, 2, 100, 12340),
	(8901, 5, 20, 12340),
	(8903, 2, 100, 12340),
	(8903, 5, 20, 12340),
	(8905, 2, 270, 12340),
	(8905, 3, 108, 12340),
	(8905, 4, 108, 12340),
	(8905, 5, 108, 12340),
	(8905, 6, 108, 12340),
	(8906, 2, 110, 12340),
	(8906, 3, 110, 12340),
	(8906, 4, 110, 12340),
	(8906, 5, 110, 12340),
	(8906, 6, 110, 12340),
	(8908, 2, 280, 12340),
	(8908, 4, 140, 12340),
	(8909, 4, -52, 12340),
	(8911, 2, 275, 12340),
	(8911, 3, 55, 12340),
	(8911, 4, 55, 12340),
	(8911, 5, 55, 12340),
	(8911, 6, 55, 12340),
	(8923, 2, 153, 12340),
	(8923, 3, 153, 12340),
	(8923, 4, 153, 12340),
	(8923, 5, 153, 12340),
	(8923, 6, 153, 12340),
	(8981, 2, 110, 12340),
	(8981, 3, 330, 12340),
	(8981, 4, 110, 12340),
	(8981, 5, 110, 12340),
	(8981, 6, 440, 12340),
	(8982, 2, 58, 12340),
	(8982, 3, 290, 12340),
	(8982, 4, 58, 12340),
	(8982, 5, 58, 12340),
	(8982, 6, 58, 12340),
	(8983, 3, 174, 12340),
	(9017, 2, 275, 12340),
	(9017, 3, 55, 12340),
	(9017, 4, 55, 12340),
	(9017, 5, 55, 12340),
	(9017, 6, 55, 12340),
	(9024, 2, 52, 12340),
	(9025, 2, 510, 12340),
	(9025, 3, 510, 12340),
	(9025, 4, 510, 12340),
	(9025, 5, 510, 12340),
	(9025, 6, 510, 12340),
	(9026, 2, 208, 12340),
	(9026, 3, 104, 12340),
	(9026, 4, 104, 12340),
	(9026, 5, 156, 12340),
	(9026, 6, 104, 12340),
	(9031, 5, 162, 12340),
	(9096, 2, 150, 12340),
	(9318, 2, 125, 12340),
	(9377, 2, 34, 12340),
	(9377, 3, 34, 12340),
	(9377, 4, 34, 12340),
	(9377, 5, 68, 12340),
	(9377, 6, 34, 12340),
	(9396, 3, 125, 12340),
	(9397, 2, 48, 12340),
	(9397, 3, 48, 12340),
	(9397, 4, 48, 12340),
	(9397, 5, 48, 12340),
	(9397, 6, 48, 12340),
	(9453, 2, 54, 12340),
	(9453, 3, 54, 12340),
	(9453, 4, 54, 12340),
	(9453, 5, 54, 12340),
	(9453, 6, 54, 12340),
	(9477, 6, 100, 12340),
	(9516, 6, 236, 12340),
	(9556, 2, 75, 12340),
	(9556, 3, 75, 12340),
	(9556, 4, 75, 12340),
	(9556, 5, 75, 12340),
	(9598, 2, 112, 12340),
	(9598, 3, 112, 12340),
	(9598, 4, 112, 12340),
	(9598, 5, 112, 12340),
	(9598, 6, 112, 12340),
	(9621, 6, 100, 12340),
	(9816, 2, 1000, 12340),
	(9879, 2, 300, 12340),
	(9879, 5, 30, 12340),
	(10038, 6, 10, 12340),
	(10077, 2, 100, 12340),
	(10077, 3, 100, 12340),
	(10077, 4, 100, 12340),
	(10077, 5, 100, 12340),
	(10077, 6, 100, 12340),
	(10083, 2, 150, 12340),
	(10084, 2, 75, 12340),
	(10161, 2, 171, 12340),
	(10184, 3, 100, 11723),
	(10196, 3, 228, 12340),
	(10202, 4, 295, 12340),
	(10258, 2, 177, 12340),
	(10290, 6, 100, 12340),
	(10339, 2, 210, 12340),
	(10339, 3, 210, 12340),
	(10339, 4, 210, 12340),
	(10339, 5, 210, 12340),
	(10339, 6, 210, 12340),
	(10366, 2, 150, 12340),
	(10371, 2, 150, 12340),
	(10372, 2, 150, 12340),
	(10384, 2, 168, 12340),
	(10384, 3, 168, 12340),
	(10384, 4, 168, 12340),
	(10384, 5, 168, 12340),
	(10384, 6, 168, 12340),
	(10431, 2, 30, 12340),
	(10431, 6, 70, 12340),
	(10432, 4, 180, 12340),
	(10433, 5, 174, 12340),
	(10442, 2, 150, 12340),
	(10442, 3, 150, 12340),
	(10442, 4, 150, 12340),
	(10442, 5, 150, 12340),
	(10442, 6, 150, 12340),
	(10447, 2, 200, 12340),
	(10447, 3, 200, 12340),
	(10447, 4, 200, 12340),
	(10447, 5, 200, 12340),
	(10447, 6, 200, 12340),
	(10508, 4, 186, 12340),
	(10516, 2, 171, 12340),
	(10516, 3, 171, 12340),
	(10516, 4, 171, 12340),
	(10516, 5, 171, 12340),
	(10516, 6, 171, 12340),
	(10558, 2, 171, 12340),
	(10558, 3, 171, 12340),
	(10558, 4, 171, 12340),
	(10558, 5, 171, 12340),
	(10558, 6, 171, 12340),
	(10640, 3, 79, 12340),
	(10641, 2, 250, 12340),
	(10641, 3, 250, 12340),
	(10641, 4, 250, 12340),
	(10641, 5, 375, 12340),
	(10641, 6, 200, 12340),
	(10642, 4, 75, 12340),
	(10659, 4, 82, 12340),
	(10659, 6, 165, 12340),
	(10660, 4, 84, 12340),
	(10660, 6, 168, 12340),
	(10661, 4, 56, 12340),
	(10661, 6, 168, 12340),
	(10662, 4, 168, 12340),
	(10663, 4, 174, 12340),
	(10665, 6, 10, 12340),
	(10678, 6, 165, 12340),
	(10683, 2, 177, 12340),
	(10699, 5, 84, 12340),
	(10756, 2, 87, 12340),
	(10756, 4, 29, 12340),
	(10757, 2, 84, 12340),
	(10757, 4, 28, 12340),
	(10758, 3, 65, 12340),
	(10759, 3, 65, 12340),
	(10760, 3, 65, 12340),
	(10761, 3, 65, 12340),
	(10814, 2, 220, 12340),
	(10814, 3, 220, 12340),
	(10814, 4, 220, 12340),
	(10814, 5, 220, 12340),
	(10814, 6, 220, 12340),
	(10827, 5, 56, 12340),
	(10876, 5, 84, 12340),
	(10882, 2, 2, 12340),
	(10882, 3, 2, 12340),
	(10882, 4, 2, 12340),
	(10882, 5, 2, 12340),
	(10882, 6, 2, 12340),
	(10955, 2, 60, 12340),
	(10955, 3, 60, 12340),
	(10955, 4, 60, 12340),
	(10955, 5, 120, 12340),
	(10955, 6, 60, 12340),
	(11024, 2, 5, 12340),
	(11024, 3, 3, 12340),
	(11034, 2, 30, 12340),
	(11034, 6, 70, 12340),
	(11035, 2, 30, 12340),
	(11035, 6, 70, 12340),
	(11036, 2, 30, 12340),
	(11036, 6, 70, 12340),
	(11039, 2, 30, 12340),
	(11039, 6, 70, 12340),
	(11040, 2, 100, 12340),
	(11040, 6, 100, 12340),
	(11063, 2, 30, 12340),
	(11063, 6, 70, 12340),
	(11099, 2, 30, 12340),
	(11099, 6, 70, 12340),
	(11102, 2, 30, 12340),
	(11102, 6, 70, 12340),
	(11143, 2, 180, 12340),
	(11143, 3, 180, 12340),
	(11143, 4, 180, 12340),
	(11143, 5, 180, 12340),
	(11143, 6, 180, 12340),
	(11256, 5, 30, 12340),
	(11262, 2, 171, 11723),
	(11262, 3, 95, 11723),
	(11321, 2, 22, 12340),
	(11321, 3, 15, 12340),
	(11357, 2, 2, 12340),
	(11357, 3, 2, 12340),
	(11357, 4, 2, 12340),
	(11357, 5, 2, 12340),
	(11357, 6, 2, 12340),
	(11440, 2, 54, 12340),
	(11440, 3, 54, 12340),
	(11440, 4, 54, 12340),
	(11440, 5, 54, 12340),
	(11440, 6, 54, 12340),
	(11441, 2, 58, 12340),
	(11441, 3, 58, 12340),
	(11441, 4, 58, 12340),
	(11441, 5, 58, 12340),
	(11441, 6, 58, 12340),
	(11442, 2, 54, 12340),
	(11442, 3, 54, 12340),
	(11442, 4, 54, 12340),
	(11442, 5, 54, 12340),
	(11442, 6, 54, 12340),
	(11443, 2, 53, 12340),
	(11443, 3, 53, 12340),
	(11443, 4, 53, 12340),
	(11443, 5, 53, 12340),
	(11443, 6, 53, 12340),
	(11444, 2, 58, 12340),
	(11444, 3, 58, 12340),
	(11444, 4, 58, 12340),
	(11444, 5, 58, 12340),
	(11444, 6, 58, 12340),
	(11453, 6, 171, 12340),
	(11455, 5, 168, 12340),
	(11457, 2, 171, 12340),
	(11480, 2, 60, 12340),
	(11480, 3, 120, 12340),
	(11480, 4, 120, 12340),
	(11480, 5, 60, 12340),
	(11480, 6, 300, 12340),
	(11483, 2, 290, 12340),
	(11483, 3, 290, 12340),
	(11483, 4, 290, 12340),
	(11483, 5, 290, 12340),
	(11483, 6, 290, 12340),
	(11484, 2, 120, 12340),
	(11484, 3, 120, 12340),
	(11484, 4, 120, 12340),
	(11484, 5, 120, 12340),
	(11484, 6, 120, 12340),
	(11489, 2, 60, 12340),
	(11489, 3, 300, 12340),
	(11489, 4, 60, 12340),
	(11489, 5, 60, 12340),
	(11489, 6, 60, 12340),
	(11491, 2, 290, 12340),
	(11491, 3, 290, 12340),
	(11491, 4, 290, 12340),
	(11491, 5, 290, 12340),
	(11491, 6, 290, 12340),
	(11492, 3, 180, 12340),
	(11576, 2, 34, 12340),
	(11576, 3, 34, 12340),
	(11576, 4, 34, 12340),
	(11576, 5, 34, 12340),
	(11576, 6, 68, 12340),
	(11577, 2, 37, 12340),
	(11577, 3, 37, 12340),
	(11577, 4, 37, 12340),
	(11577, 5, 37, 12340),
	(11577, 6, 75, 12340),
	(11578, 2, 34, 12340),
	(11578, 3, 34, 12340),
	(11578, 4, 34, 12340),
	(11578, 5, 34, 12340),
	(11578, 6, 68, 12340),
	(11658, 2, 93, 12340),
	(11659, 2, 93, 12340),
	(11661, 2, 93, 12340),
	(11662, 2, 93, 12340),
	(11664, 2, 93, 12340),
	(11664, 3, -93, 12340),
	(11664, 4, -93, 12340),
	(11664, 5, -93, 12340),
	(11664, 6, -93, 12340),
	(11665, 2, 93, 12340),
	(11665, 3, 93, 12340),
	(11666, 4, -93, 12340),
	(11667, 4, -93, 12340),
	(11668, 4, -93, 12340),
	(11669, 2, 186, 12340),
	(11669, 3, 122, 12340),
	(11669, 4, 122, 12340),
	(11669, 5, 122, 12340),
	(11669, 6, 122, 12340),
	(11671, 2, 93, 12340),
	(11672, 2, 95, 12340),
	(11673, 2, 93, 12340),
	(11744, 2, 56, 12340),
	(11744, 3, 56, 12340),
	(11744, 4, 56, 12340),
	(11744, 5, 112, 12340),
	(11744, 6, 56, 12340),
	(11745, 2, 116, 12340),
	(11745, 3, 116, 12340),
	(11745, 4, 116, 12340),
	(11745, 5, 116, 12340),
	(11745, 6, 116, 12340),
	(11777, 5, 132, 12340),
	(11778, 5, 135, 12340),
	(11779, 5, 161, 12340),
	(11780, 6, 135, 12340),
	(11781, 6, 129, 12340),
	(11782, 6, 132, 12340),
	(11783, 2, 92, 12340),
	(11783, 3, 92, 12340),
	(11783, 4, 92, 12340),
	(11783, 5, 92, 12340),
	(11783, 6, 92, 12340),
	(11784, 2, 48, 12340),
	(11784, 3, 240, 12340),
	(11784, 4, 48, 12340),
	(11784, 5, 48, 12340),
	(11784, 6, 48, 12340),
	(11793, 3, 69, 12340),
	(11794, 3, 69, 12340),
	(11859, 6, 240, 12340),
	(11862, 2, 25, 12340),
	(11862, 3, 25, 12340),
	(11862, 4, 25, 12340),
	(11862, 5, 50, 12340),
	(11862, 6, 25, 12340),
	(11863, 2, 30, 12340),
	(11863, 6, 70, 12340),
	(11864, 2, 30, 12340),
	(11864, 6, 70, 12340),
	(11871, 2, 2, 12340),
	(11871, 3, 2, 12340),
	(11871, 4, 2, 12340),
	(11871, 5, 2, 12340),
	(11871, 6, 2, 12340),
	(11876, 6, 148, 12340),
	(11988, 2, 186, 12340),
	(12018, 2, 95, 12340),
	(12076, 2, 95, 12340),
	(12076, 3, 95, 12340),
	(12098, 2, 93, 12340),
	(12099, 2, 95, 12340),
	(12099, 3, 95, 12340),
	(12100, 2, 95, 12340),
	(12100, 3, 95, 12340),
	(12101, 2, 93, 12340),
	(12101, 3, 93, 12340),
	(12119, 2, 93, 12340),
	(12129, 2, 250, 12340),
	(12129, 3, 90, 12340),
	(12142, 2, 93, 12340),
	(12236, 6, 188, 12340),
	(12259, 2, 186, 12340),
	(12259, 5, 93, 12340),
	(12264, 2, 93, 12340),
	(12264, 6, 186, 12340),
	(12265, 4, -186, 12340),
	(12396, 5, 93, 12340),
	(12396, 6, 244, 12340),
	(12428, 6, 10, 12340),
	(12431, 2, 70, 12340),
	(12431, 3, 70, 12340),
	(12431, 4, 70, 12340),
	(12431, 5, 70, 12340),
	(12431, 6, 70, 12340),
	(12432, 2, 28, 12340),
	(12432, 4, 28, 12340),
	(12432, 6, 28, 12340),
	(12739, 2, 150, 12340),
	(12759, 4, 75, 12340),
	(12806, 2, 95, 12340),
	(12806, 3, 95, 12340),
	(12876, 4, 75, 12340),
	(12976, 2, 70, 12340),
	(12976, 5, 30, 12340),
	(12977, 2, 70, 12340),
	(12977, 5, 30, 12340),
	(13149, 3, 100, 12340),
	(13150, 3, 100, 12340),
	(13151, 3, 100, 12340),
	(13196, 5, 275, 12340),
	(13276, 2, 168, 12340),
	(13278, 2, 300, 12340),
	(13278, 3, 300, 12340),
	(13278, 4, 300, 12340),
	(13278, 5, 300, 12340),
	(13278, 6, 300, 12340),
	(13279, 2, 56, 12340),
	(13279, 3, 56, 12340),
	(13279, 4, 56, 12340),
	(13279, 5, 56, 12340),
	(13279, 6, 112, 12340),
	(13282, 2, 96, 12340),
	(13282, 3, 144, 12340),
	(13282, 4, 144, 12340),
	(13282, 5, 96, 12340),
	(13282, 6, 96, 12340),
	(13285, 2, 58, 12340),
	(13285, 3, 58, 12340),
	(13285, 4, 58, 12340),
	(13285, 5, 290, 12340),
	(13285, 6, 58, 12340),
	(13322, 2, 58, 12340),
	(13322, 3, 290, 12340),
	(13322, 4, 58, 12340),
	(13322, 5, 58, 12340),
	(13322, 6, 58, 12340),
	(13456, 2, 90, 12340),
	(13456, 3, 144, 12340),
	(13456, 4, 144, 12340),
	(13456, 5, 45, 12340),
	(13456, 6, 45, 12340),
	(13696, 2, 92, 12340),
	(13696, 3, 144, 12340),
	(13696, 4, 144, 12340),
	(13696, 5, 92, 12340),
	(13696, 6, 92, 12340),
	(13736, 2, 92, 12340),
	(13736, 3, 144, 12340),
	(13736, 4, 144, 12340),
	(13736, 5, 46, 12340),
	(13736, 6, 46, 12340),
	(13839, 6, 10, 12340),
	(14020, 6, 80, 12340),
	(14022, 2, 180, 12340),
	(14023, 3, 300, 12340),
	(14023, 5, 180, 12340),
	(14024, 4, 300, 12340),
	(14024, 6, 150, 12340),
	(14223, 4, 75, 12340),
	(14226, 2, 95, 12340),
	(14231, 5, 30, 12340),
	(14232, 2, 60, 12340),
	(14232, 3, 60, 12340),
	(14232, 4, 60, 12340),
	(14232, 5, 60, 12340),
	(14232, 6, 60, 12340),
	(14234, 2, 2, 12340),
	(14234, 3, 2, 12340),
	(14234, 4, 2, 12340),
	(14234, 5, 2, 12340),
	(14234, 6, 2, 12340),
	(14261, 4, 200, 12340),
	(14261, 6, 200, 12340),
	(14262, 3, 500, 12340),
	(14264, 2, 500, 12340),
	(14265, 2, 200, 12340),
	(14265, 5, 200, 12340),
	(14302, 2, 200, 12340),
	(14302, 3, 200, 12340),
	(14302, 4, 200, 12340),
	(14302, 5, 200, 12340),
	(14302, 6, 200, 12340),
	(14340, 6, 216, 12340),
	(14343, 2, 20, 12340),
	(14343, 3, 20, 12340),
	(14343, 5, 87, 12340),
	(14343, 6, 30, 12340),
	(14362, 2, 50, 12340),
	(14362, 3, 50, 12340),
	(14362, 4, 50, 12340),
	(14362, 5, 50, 12340),
	(14362, 6, 50, 12340),
	(14385, 6, 240, 12340),
	(14399, 2, 60, 12340),
	(14399, 3, 120, 12340),
	(14399, 4, 120, 12340),
	(14399, 5, 60, 12340),
	(14399, 6, 300, 12340),
	(14400, 2, 60, 12340),
	(14400, 3, 60, 12340),
	(14400, 4, 60, 12340),
	(14400, 5, 60, 12340),
	(14400, 6, 60, 12340),
	(14424, 3, 50, 12340),
	(14426, 3, 65, 12340),
	(14452, 6, 244, 12340),
	(14454, 2, 600, 12340),
	(14454, 3, 600, 12340),
	(14454, 4, 600, 12340),
	(14454, 5, 600, 12340),
	(14454, 6, 480, 12340),
	(14455, 5, 30, 12340),
	(14457, 5, 30, 12340),
	(14458, 2, 57, 12340),
	(14458, 3, 114, 12340),
	(14458, 4, 57, 12340),
	(14458, 5, 57, 12340),
	(14458, 6, 57, 12340),
	(14460, 2, 110, 12340),
	(14460, 3, 55, 12340),
	(14460, 4, 55, 12340),
	(14460, 5, 110, 12340),
	(14460, 6, 55, 12340),
	(14461, 2, 58, 12340),
	(14461, 3, 116, 12340),
	(14461, 4, 116, 12340),
	(14461, 5, 58, 12340),
	(14461, 6, 290, 12340),
	(14462, 5, 30, 12340),
	(14464, 2, 290, 12340),
	(14464, 3, 58, 12340),
	(14464, 4, 58, 12340),
	(14464, 5, 58, 12340),
	(14464, 6, 58, 12340),
	(14467, 2, 300, 12340),
	(14502, 2, 75, 12340),
	(14502, 3, 75, 12340),
	(14502, 4, 75, 12340),
	(14502, 5, 75, 12340),
	(14506, 6, 248, 12340),
	(14535, 6, 240, 12340),
	(14690, 2, 171, 12340),
	(14690, 3, 171, 12340),
	(14690, 4, 171, 12340),
	(14690, 5, 171, 12340),
	(14690, 6, 171, 12340),
	(14694, 5, 162, 12340),
	(15111, 6, 244, 12340),
	(15339, 2, 1000, 12340),
	(15339, 3, 1000, 12340),
	(15339, 4, 1000, 12340),
	(15339, 5, 1000, 12340),
	(15692, 6, 100, 12340),
	(15990, 4, 200, 12340),
	(15990, 5, 100, 12340),
	(16170, 4, 105, 12340),
	(16171, 4, 105, 12340),
	(16174, 5, 105, 12340),
	(16176, 5, 105, 12340),
	(16178, 6, 105, 12340),
	(16292, 3, 144, 12340),
	(16292, 4, 144, 12340),
	(16485, 6, 100, 12340),
	(16488, 6, 75, 12340),
	(16489, 6, 75, 12340),
	(16492, 6, 70, 12340),
	(16504, 6, 100, 12340),
	(16525, 2, 105, 12340),
	(16525, 4, 105, 12340),
	(16525, 5, 105, 12340),
	(16540, 5, 50, 12340),
	(16807, 5, 5, 12340),
	(17034, 6, 8311, 12340),
	(17035, 6, 8311, 12340),
	(17039, 6, 8311, 12340),
	(17053, 6, 8311, 12340),
	(17283, 6, 100, 12340),
	(17300, 5, 102, 12340),
	(17308, 5, 93, 12340),
	(17358, 4, 75, 12340),
	(17359, 2, 90, 12340),
	(17359, 3, 90, 12340),
	(17359, 4, 90, 12340),
	(17359, 5, 90, 12340),
	(17359, 6, 90, 12340),
	(17399, 5, 90, 12340),
	(17556, 2, 50, 12340),
	(17556, 3, 50, 12340),
	(17556, 4, 50, 12340),
	(17556, 5, 50, 12340),
	(17556, 6, 50, 12340),
	(17592, 2, 125, 12340),
	(17767, 4, 186, 12340),
	(17870, 5, 75, 12340),
	(17870, 6, 100, 12340),
	(17916, 2, 175, 12340),
	(17916, 3, 175, 12340),
	(17916, 4, 175, 12340),
	(17916, 5, 175, 12340),
	(17916, 6, 175, 12340),
	(18105, 3, 150, 12340),
	(18401, 5, 115, 12340),
	(18432, 2, 210, 12340),
	(18432, 3, 210, 12340),
	(18432, 4, 210, 12340),
	(18432, 5, 210, 12340),
	(18432, 6, 210, 12340),
	(18433, 5, 93, 12340),
	(18438, 6, 150, 12340),
	(18614, 5, 90, 12340),
	(18978, 2, 186, 12340),
	(19027, 6, 1754, 12340),
	(19030, 6, 1754, 12340),
	(20168, 3, 150, 12340),
	(20568, 5, 5, 12340),
	(20713, 2, 77, 12340),
	(20713, 3, 77, 12340),
	(20713, 4, 77, 12340),
	(20713, 5, 77, 12340),
	(20908, 6, 140, 12340),
	(20910, 2, 140, 12340),
	(20910, 3, 140, 12340),
	(20910, 4, 140, 12340),
	(20910, 5, 140, 12340),
	(20910, 6, 140, 12340),
	(20911, 2, 1000, 12340),
	(21389, 2, 245, 12340),
	(21588, 2, 1000, 12340),
	(21616, 2, 140, 12340),
	(21617, 6, 140, 12340),
	(21618, 2, 140, 12340),
	(21618, 3, 140, 12340),
	(21618, 4, 140, 12340),
	(21618, 5, 140, 12340),
	(21618, 6, 140, 12340),
	(22408, 5, 75, 12340),
	(22408, 6, 100, 12340),
	(22898, 2, 210, 12340),
	(22952, 2, 75, 12340),
	(22952, 3, 75, 12340),
	(22952, 4, 75, 12340),
	(22952, 5, 75, 12340),
	(22952, 6, 75, 12340),
	(22993, 2, 375, 12340),
	(22993, 3, 375, 12340),
	(22993, 4, 375, 12340),
	(22993, 5, 375, 12340),
	(22993, 6, 375, 12340),
	(24818, 2, 100, 12340),
	(24818, 5, 20, 12340),
	(24819, 2, 100, 12340),
	(24819, 5, 20, 12340),
	(28858, 3, 545, 12340),
	(28862, 4, 545, 12340),
	(30236, 2, 4394, 12340),
	(30236, 4, 1, 12340),
	(36538, 3, 100, 1),
	(36566, 2, 171, 12340),
	(36566, 3, 95, 12340),
	(36572, 2, 250, 12340),
	(36572, 3, 90, 12340);
/*!40000 ALTER TABLE `creature_template_resistance` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
