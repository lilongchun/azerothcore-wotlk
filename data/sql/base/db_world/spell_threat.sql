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

-- Dumpar struktur för tabell acore_world.spell_threat
DROP TABLE IF EXISTS `spell_threat`;
CREATE TABLE IF NOT EXISTS `spell_threat` (
  `entry` MEDIUMINT unsigned NOT NULL,
  `flatMod` INT DEFAULT NULL,
  `pctMod` float NOT NULL DEFAULT '1' COMMENT 'threat multiplier for damage/healing',
  `apPctMod` float NOT NULL DEFAULT 0 COMMENT 'additional threat bonus from attack power',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Dumpar data för tabell acore_world.spell_threat: 107 rows
DELETE FROM `spell_threat`;
/*!40000 ALTER TABLE `spell_threat` DISABLE KEYS */;
INSERT INTO `spell_threat` (`entry`, `flatMod`, `pctMod`, `apPctMod`) VALUES
	(78, 5, 1, 0),
	(284, 10, 1, 0),
	(285, 16, 1, 0),
	(498, 0, 0, 0),
	(779, 0, 1.5, 0),
	(845, 8, 1, 0),
	(1464, 18, 1, 0),
	(1608, 22, 1, 0),
	(2139, 180, 1, 0),
	(5209, 98, 1, 0),
	(5211, 53, 1, 0),
	(5676, 0, 2, 0),
	(6343, 0, 1.85, 0),
	(6572, 7, 1, 0),
	(6574, 11, 1, 0),
	(6798, 105, 1, 0),
	(6807, 13, 1, 0),
	(6808, 20, 1, 0),
	(6809, 27, 1, 0),
	(7294, 0, 2, 0),
	(7369, 15, 1, 0),
	(7379, 15, 1, 0),
	(7386, 345, 1, 0.05),
	(8056, 0, 2, 0),
	(8187, 0, 0, 0),
	(8820, 24, 1, 0),
	(8972, 47, 1, 0),
	(8983, 158, 1, 0),
	(9745, 75, 1, 0),
	(9880, 106, 1, 0),
	(9881, 140, 1, 0),
	(11564, 31, 1, 0),
	(11565, 48, 1, 0),
	(11566, 70, 1, 0),
	(11567, 92, 1, 0),
	(11600, 27, 1, 0),
	(11601, 41, 1, 0),
	(11604, 38, 1, 0),
	(11605, 49, 1, 0),
	(11608, 25, 1, 0),
	(11609, 35, 1, 0),
	(15237, 0, 0, 0),
	(17057, 0, 0, 0),
	(19675, 80, 1, 0),
	(19742, 0, 0, 0),
	(20185, 0, 0, 0),
	(20243, 0, 1, 0.05),
	(20470, 0, 0, 0),
	(20569, 48, 1, 0),
	(23455, 0, 0, 0),
	(23922, 228, 1, 0),
	(23923, 268, 1, 0),
	(23924, 307, 1, 0),
	(23925, 347, 1, 0),
	(25231, 68, 1, 0),
	(25241, 59, 1, 0),
	(25242, 78, 1, 0),
	(25258, 387, 1, 0),
	(25269, 58, 1, 0),
	(25286, 104, 1, 0),
	(25288, 53, 1, 0),
	(25894, 0, 0, 0),
	(26688, 0, 0, 0),
	(26996, 212, 1, 0),
	(28176, 0, 0, 0),
	(29166, 0, 10, 0),
	(29707, 121, 1, 0),
	(30324, 164, 1, 0),
	(30356, 426, 1, 0),
	(30357, 71, 1, 0),
	(32546, 0, 0.5, 0),
	(33619, 0, 0, 0),
	(33745, 182, 0.5, 0),
	(34299, 0, 0, 0),
	(45334, 40, 1, 0),
	(45524, 240, 1, 0),
	(47449, 224, 1, 0),
	(47450, 259, 1, 0),
	(47474, 123, 1, 0),
	(47475, 140, 1, 0),
	(47487, 650, 1, 0),
	(47488, 770, 1, 0),
	(47519, 95, 1, 0),
	(47520, 112, 1, 0),
	(47568, 0, 0, 0),
	(48479, 345, 1, 0),
	(48480, 422, 1, 0),
	(48567, 409, 0.5, 0),
	(48568, 515, 0.5, 0),
	(48743, 0, 0, 0),
	(49039, 110, 1, 0),
	(49576, 110, 1, 0),
	(49916, 138, 1, 0),
	(50181, 0, 0, 0),
	(50422, 0, 0, 0),
	(51209, 112, 1, 0),
	(52212, 0, 1.9, 0),
	(55090, 51, 1, 0),
	(55265, 63, 1, 0),
	(55270, 98, 1, 0),
	(55271, 120, 1, 0),
	(56815, 0, 1.75, 0),
	(57755, 0, 1.5, 0),
	(57823, 121, 1, 0),
	(60089, 638, 1, 0),
	(63611, 0, 0, 0),
	(65142, 0, 0, 0);
/*!40000 ALTER TABLE `spell_threat` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
