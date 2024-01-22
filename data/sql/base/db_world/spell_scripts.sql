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

-- Dumping structure for table acore_world.spell_scripts
DROP TABLE IF EXISTS `spell_scripts`;
CREATE TABLE IF NOT EXISTS `spell_scripts` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `effIndex` tinyint unsigned NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `command` int unsigned NOT NULL DEFAULT '0',
  `datalong` int unsigned NOT NULL DEFAULT '0',
  `datalong2` int unsigned NOT NULL DEFAULT '0',
  `dataint` int NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.spell_scripts: ~130 rows (approximately)
DELETE FROM `spell_scripts`;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
	(35727, 0, 0, 15, 35730, 2, 0, 0, 0, 0, 0),
	(35376, 0, 0, 15, 25649, 2, 0, 0, 0, 0, 0),
	(29129, 0, 0, 15, 32569, 2, 0, 0, 0, 0, 0),
	(29128, 0, 0, 15, 32568, 2, 0, 0, 0, 0, 0),
	(54620, 0, 0, 6, 571, 0, 0, 5807.75, 588.063, 660.939, 1.64659),
	(37834, 0, 0, 8, 21892, 0, 0, 0, 0, 0, 0),
	(34448, 0, 0, 15, 26566, 0, 0, 0, 0, 0, 0),
	(34452, 0, 0, 15, 26572, 0, 0, 0, 0, 0, 0),
	(21014, 0, 0, 17, 34127, 3, 0, 0, 0, 0, 0),
	(45980, 0, 1, 8, 25773, 0, 0, 0, 0, 0, 0),
	(44997, 0, 0, 15, 45009, 1, 1, 0, 0, 0, 0),
	(45030, 1, 0, 15, 45088, 1, 1, 0, 0, 0, 0),
	(49625, 0, 0, 15, 43106, 1, 1, 0, 0, 0, 0),
	(49634, 0, 0, 15, 43068, 1, 1, 0, 0, 0, 0),
	(53343, 1, 0, 15, 54586, 1, 1, 0, 0, 0, 0),
	(53341, 1, 0, 15, 54586, 1, 1, 0, 0, 0, 0),
	(54640, 0, 0, 15, 54643, 2, 0, 0, 0, 0, 0),
	(23645, 0, 0, 14, 23170, 1, 0, 0, 0, 0, 0),
	(23725, 0, 0, 15, 23783, 1, 1, 0, 0, 0, 0),
	(23725, 0, 0, 15, 23782, 1, 1, 0, 0, 0, 0),
	(40109, 0, 0, 15, 40075, 2, 1, 0, 0, 0, 0),
	(51336, 0, 0, 15, 50770, 0, 1, 0, 0, 0, 0),
	(21977, 0, 0, 15, 21887, 0, 1, 0, 0, 0, 0),
	(37028, 0, 0, 14, 36904, 0, 0, 0, 0, 0, 0),
	(25652, 0, 0, 15, 30141, 2, 0, 0, 0, 0, 0),
	(25650, 0, 0, 15, 30140, 2, 0, 0, 0, 0, 0),
	(25143, 0, 0, 15, 32572, 2, 0, 0, 0, 0, 0),
	(25140, 0, 0, 15, 32571, 2, 0, 0, 0, 0, 0),
	(38358, 1, 0, 15, 38353, 0, 1, 0, 0, 0, 0),
	(40904, 1, 0, 15, 40903, 3, 1, 0, 0, 0, 0),
	(44876, 0, 0, 15, 44870, 2, 1, 0, 0, 0, 0),
	(45185, 2, 0, 14, 46394, 0, 0, 0, 0, 0, 0),
	(46289, 0, 0, 15, 46285, 0, 1, 0, 0, 0, 0),
	(52124, 0, 0, 15, 52125, 0, 0, 0, 0, 0, 0),
	(58466, 0, 0, 15, 58467, 2, 1, 0, 0, 0, 0),
	(58466, 0, 0, 15, 58648, 2, 1, 0, 0, 0, 0),
	(58475, 0, 0, 15, 58477, 2, 1, 0, 0, 0, 0),
	(58475, 0, 0, 15, 58648, 2, 1, 0, 0, 0, 0),
	(57337, 0, 0, 15, 58067, 2, 1, 0, 0, 0, 0),
	(57397, 0, 0, 15, 57398, 2, 1, 0, 0, 0, 0),
	(57397, 0, 0, 15, 58648, 2, 1, 0, 0, 0, 0),
	(28698, 0, 0, 15, 28694, 2, 1, 0, 0, 0, 0),
	(49203, 0, 0, 15, 51209, 3, 1, 0, 0, 0, 0),
	(43375, 0, 0, 15, 43377, 1, 0, 0, 0, 0, 0),
	(51662, 0, 0, 15, 63848, 1, 1, 0, 0, 0, 0),
	(42287, 0, 0, 17, 33041, 1, 0, 0, 0, 0, 0),
	(47097, 0, 0, 15, 47324, 0, 0, 0, 0, 0, 0),
	(47097, 0, 0, 15, 47325, 0, 0, 0, 0, 0, 0),
	(50252, 0, 0, 15, 50250, 1, 0, 0, 0, 0, 0),
	(47724, 0, 0, 15, 50239, 1, 0, 0, 0, 0, 0),
	(47703, 0, 0, 15, 50254, 1, 0, 0, 0, 0, 0),
	(48730, 0, 0, 15, 48729, 1, 0, 0, 0, 0, 0),
	(48728, 0, 0, 15, 48727, 1, 0, 0, 0, 0, 0),
	(48726, 0, 0, 15, 48725, 1, 0, 0, 0, 0, 0),
	(48724, 0, 0, 15, 48723, 1, 0, 0, 0, 0, 0),
	(24194, 0, 0, 15, 24105, 0, 0, 0, 0, 0, 0),
	(24194, 0, 0, 15, 24107, 0, 0, 0, 0, 0, 0),
	(24194, 0, 0, 15, 24106, 0, 0, 0, 0, 0, 0),
	(24194, 0, 0, 15, 24108, 0, 0, 0, 0, 0, 0),
	(24194, 0, 0, 15, 69533, 0, 0, 0, 0, 0, 0),
	(24195, 0, 0, 15, 24104, 0, 0, 0, 0, 0, 0),
	(24195, 0, 0, 15, 24101, 0, 0, 0, 0, 0, 0),
	(24195, 0, 0, 15, 24102, 0, 0, 0, 0, 0, 0),
	(24195, 0, 0, 15, 24103, 0, 0, 0, 0, 0, 0),
	(24195, 0, 0, 15, 69530, 0, 0, 0, 0, 0, 0),
	(56515, 0, 0, 15, 56516, 0, 0, 0, 0, 0, 0),
	(53062, 0, 0, 15, 53067, 2, 0, 0, 0, 0, 0),
	(45980, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0),
	(51864, 0, 0, 15, 51865, 2, 0, 0, 0, 0, 0),
	(51889, 0, 0, 15, 51865, 2, 0, 0, 0, 0, 0),
	(45071, 2, 0, 16, 12318, 1, 0, 0, 0, 0, 0),
	(49899, 0, 0, 1, 416, 0, 0, 0, 0, 0, 0),
	(55048, 0, 0, 14, 54894, 0, 0, 0, 0, 0, 0),
	(47117, 0, 0, 15, 47118, 2, 0, 0, 0, 0, 0),
	(47149, 0, 0, 15, 47150, 2, 0, 0, 0, 0, 0),
	(47316, 0, 0, 15, 47317, 2, 0, 0, 0, 0, 0),
	(47405, 0, 0, 15, 47406, 2, 0, 0, 0, 0, 0),
	(50439, 0, 0, 15, 50440, 2, 0, 0, 0, 0, 0),
	(37894, 0, 0, 15, 37893, 2, 0, 0, 0, 0, 0),
	(37892, 0, 0, 15, 37893, 2, 0, 0, 0, 0, 0),
	(37867, 0, 0, 15, 37868, 2, 0, 0, 0, 0, 0),
	(47958, 0, 0, 15, 47954, 1, 0, 0, 0, 0, 0),
	(47958, 0, 0, 15, 47955, 1, 0, 0, 0, 0, 0),
	(47958, 0, 0, 15, 47956, 1, 0, 0, 0, 0, 0),
	(47958, 0, 0, 15, 47957, 1, 0, 0, 0, 0, 0),
	(57082, 0, 0, 15, 57077, 1, 0, 0, 0, 0, 0),
	(57082, 0, 0, 15, 57078, 1, 0, 0, 0, 0, 0),
	(57082, 0, 0, 15, 57080, 1, 0, 0, 0, 0, 0),
	(57082, 0, 0, 15, 57081, 1, 0, 0, 0, 0, 0),
	(57884, 1, 0, 14, 57889, 0, 0, 0, 0, 0, 0),
	(52933, 0, 0, 15, 52934, 0, 0, 0, 0, 0, 0),
	(52933, 0, 0, 15, 52935, 0, 0, 0, 0, 0, 0),
	(52933, 0, 0, 15, 52936, 0, 0, 0, 0, 0, 0),
	(52933, 0, 0, 15, 52937, 0, 0, 0, 0, 0, 0),
	(47393, 0, 0, 14, 47391, 0, 0, 0, 0, 0, 0),
	(47615, 0, 0, 14, 47473, 0, 0, 0, 0, 0, 0),
	(47638, 0, 0, 14, 47636, 0, 0, 0, 0, 0, 0),
	(58916, 0, 0, 15, 58915, 0, 0, 0, 0, 0, 0),
	(58917, 0, 0, 15, 58919, 0, 0, 0, 0, 0, 0),
	(53010, 0, 0, 14, 52989, 0, 0, 0, 0, 0, 0),
	(50630, 0, 0, 14, 46598, 0, 0, 0, 0, 0, 0),
	(37834, 0, 0, 14, 32567, 0, 0, 0, 0, 0, 0),
	(68861, 0, 0, 15, 68858, 2, 1, 0, 0, 0, 0),
	(69051, 0, 0, 15, 69023, 3, 1, 0, 0, 0, 0),
	(68871, 0, 0, 15, 68875, 0, 1, 0, 0, 0, 0),
	(51862, 0, 0, 15, 51861, 0, 0, 0, 0, 0, 0),
	(51862, 0, 0, 15, 52452, 0, 0, 0, 0, 0, 0),
	(51862, 0, 0, 15, 52453, 0, 0, 0, 0, 0, 0),
	(51862, 0, 0, 15, 52454, 0, 0, 0, 0, 0, 0),
	(32580, 0, 0, 10, 21351, 30000, 0, 0, 0, 0, 0),
	(44688, 0, 0, 14, 46598, 0, 0, 0, 0, 0, 0),
	(44688, 0, 0, 15, 44741, 1, 0, 0, 0, 0, 0),
	(29137, 2, 0, 15, 29101, 2, 0, 0, 0, 0, 0),
	(29135, 2, 0, 15, 29102, 2, 0, 0, 0, 0, 0),
	(29126, 2, 0, 15, 29099, 2, 0, 0, 0, 0, 0),
	(46671, 2, 0, 15, 46690, 2, 0, 0, 0, 0, 0),
	(29139, 2, 0, 15, 29133, 2, 0, 0, 0, 0, 0),
	(29136, 2, 0, 15, 29130, 2, 0, 0, 0, 0, 0),
	(29138, 2, 0, 15, 29132, 2, 0, 0, 0, 0, 0),
	(46672, 2, 0, 15, 46689, 2, 0, 0, 0, 0, 0),
	(38173, 0, 0, 10, 22023, 12000, 0, 0, 0, 0, 0),
	(53099, 0, 0, 15, 53098, 0, 0, 0, 0, 0, 0),
	(55288, 0, 0, 15, 55289, 0, 0, 0, 0, 0, 0),
	(46550, 0, 0, 14, 46424, 0, 0, 0, 0, 0, 0),
	(59064, 0, 0, 6, 1, 0, 0, 1333.49, -4375.51, 26.204, 0.104),
	(59439, 0, 0, 6, 0, 0, 0, 1969.03, 237.55, 38.39, 3.21),
	(60940, 0, 0, 6, 0, 0, 0, 1769.13, 772.25, 56.22, 3.97),
	(24320, 0, 0, 15, 24321, 2, 0, 0, 0, 0, 0),
	(25952, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0),
	(50499, 0, 0, 15, 50493, 0, 0, 0, 0, 0, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
