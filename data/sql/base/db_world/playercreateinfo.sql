-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.playercreateinfo
DROP TABLE IF EXISTS `playercreateinfo`;
CREATE TABLE IF NOT EXISTS `playercreateinfo` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `map` smallint unsigned NOT NULL DEFAULT '0',
  `zone` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.playercreateinfo: ~62 rows (approximately)
DELETE FROM `playercreateinfo`;
INSERT INTO `playercreateinfo` (`race`, `class`, `map`, `zone`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
	(1, 1, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(1, 2, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(1, 4, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(1, 5, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(1, 6, 609, 4298, 2355.84, -5664.77, 426.028, 3.65997),
	(1, 8, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(1, 9, 0, 12, -8949.95, -132.493, 83.5312, 0),
	(2, 1, 1, 14, -618.518, -4251.67, 38.718, 0),
	(2, 3, 1, 14, -618.518, -4251.67, 38.718, 0),
	(2, 4, 1, 14, -618.518, -4251.67, 38.718, 0),
	(2, 6, 609, 4298, 2358.44, -5666.9, 426.023, 3.65997),
	(2, 7, 1, 14, -618.518, -4251.67, 38.718, 0),
	(2, 9, 1, 14, -618.518, -4251.67, 38.718, 0),
	(3, 1, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
	(3, 2, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
	(3, 3, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
	(3, 4, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
	(3, 5, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
	(3, 6, 609, 4298, 2358.44, -5666.9, 426.023, 3.65997),
	(4, 1, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
	(4, 3, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
	(4, 4, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
	(4, 5, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
	(4, 6, 609, 4298, 2356.21, -5662.21, 426.026, 3.65997),
	(4, 11, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
	(5, 1, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
	(5, 4, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
	(5, 5, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
	(5, 6, 609, 4298, 2356.21, -5662.21, 426.026, 3.65997),
	(5, 8, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
	(5, 9, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
	(6, 1, 1, 215, -2917.58, -257.98, 52.9968, 0),
	(6, 3, 1, 215, -2917.58, -257.98, 52.9968, 0),
	(6, 6, 609, 4298, 2358.17, -5663.21, 426.027, 3.65997),
	(6, 7, 1, 215, -2917.58, -257.98, 52.9968, 0),
	(6, 11, 1, 215, -2917.58, -257.98, 52.9968, 0),
	(7, 1, 0, 1, -6240.32, 331.033, 382.758, 0),
	(7, 4, 0, 1, -6240, 331, 383, 0),
	(7, 6, 609, 4298, 2355.05, -5661.7, 426.026, 3.65997),
	(7, 8, 0, 1, -6240, 331, 383, 0),
	(7, 9, 0, 1, -6240, 331, 383, 0),
	(8, 1, 1, 14, -618.518, -4251.67, 38.718, 0),
	(8, 3, 1, 14, -618.518, -4251.67, 38.718, 0),
	(8, 4, 1, 14, -618.518, -4251.67, 38.718, 0),
	(8, 5, 1, 14, -618.518, -4251.67, 38.718, 0),
	(8, 6, 609, 4298, 2355.05, -5661.7, 426.026, 3.65997),
	(8, 7, 1, 14, -618.518, -4251.67, 38.718, 0),
	(8, 8, 1, 14, -618.518, -4251.67, 38.718, 0),
	(10, 2, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(10, 3, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(10, 4, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(10, 5, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(10, 6, 609, 4298, 2355.84, -5664.77, 426.028, 3.65997),
	(10, 8, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(10, 9, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
	(11, 1, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
	(11, 2, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
	(11, 3, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
	(11, 5, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
	(11, 6, 609, 4298, 2358.17, -5663.21, 426.027, 3.65997),
	(11, 7, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
	(11, 8, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
