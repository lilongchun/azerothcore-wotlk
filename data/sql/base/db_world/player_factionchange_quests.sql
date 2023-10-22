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

-- Dumping structure for table acore_world.player_factionchange_quests
DROP TABLE IF EXISTS `player_factionchange_quests`;
CREATE TABLE IF NOT EXISTS `player_factionchange_quests` (
  `alliance_id` int unsigned NOT NULL,
  `horde_id` int unsigned NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`),
  UNIQUE KEY `alliance_uniq` (`alliance_id`),
  UNIQUE KEY `horde_uniq` (`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.player_factionchange_quests: ~293 rows (approximately)
DELETE FROM `player_factionchange_quests`;
INSERT INTO `player_factionchange_quests` (`alliance_id`, `horde_id`) VALUES
	(7065, 7064),
	(7168, 7163),
	(7169, 7164),
	(7170, 7165),
	(7171, 7166),
	(7172, 7167),
	(8114, 8121),
	(8115, 8122),
	(8311, 8312),
	(8860, 8861),
	(8905, 8913),
	(8906, 8914),
	(8907, 8915),
	(8908, 10493),
	(8909, 8916),
	(8910, 8917),
	(8911, 8919),
	(8912, 8920),
	(8922, 8923),
	(8926, 8927),
	(8929, 8930),
	(8931, 8938),
	(8932, 8939),
	(8933, 10495),
	(8934, 8940),
	(8935, 8941),
	(8936, 8943),
	(8937, 8944),
	(8951, 9016),
	(8952, 9017),
	(8953, 9018),
	(8954, 10497),
	(8955, 9019),
	(8956, 9020),
	(8958, 9021),
	(8959, 9022),
	(8960, 9032),
	(8977, 8978),
	(8997, 8998),
	(8999, 9007),
	(9000, 9008),
	(9001, 9014),
	(9002, 10499),
	(9003, 9009),
	(9004, 9010),
	(9005, 9012),
	(9006, 9013),
	(9520, 9535),
	(9522, 9536),
	(9524, 9525),
	(9587, 9588),
	(9869, 9870),
	(9933, 9934),
	(9938, 9937),
	(9940, 9939),
	(9982, 9983),
	(9994, 9995),
	(9996, 9997),
	(10005, 10006),
	(10014, 10015),
	(10033, 10034),
	(10035, 10036),
	(10038, 10039),
	(10040, 10041),
	(10042, 10043),
	(10048, 10049),
	(10051, 10052),
	(10053, 10059),
	(10054, 10060),
	(10055, 10086),
	(10056, 10158),
	(10057, 10062),
	(10076, 10074),
	(10078, 10087),
	(10080, 10089),
	(10083, 10090),
	(10084, 10092),
	(10115, 10118),
	(10116, 10117),
	(10122, 10150),
	(10126, 10151),
	(10128, 10153),
	(10130, 10152),
	(10131, 10154),
	(10137, 10155),
	(10138, 10156),
	(10139, 10157),
	(10140, 10120),
	(10141, 10121),
	(10142, 10123),
	(10145, 10127),
	(10146, 10129),
	(10147, 10133),
	(10148, 10135),
	(10163, 10162),
	(10382, 10388),
	(10394, 10390),
	(10395, 10393),
	(10397, 10392),
	(10443, 10442),
	(10444, 10448),
	(10476, 10479),
	(10492, 8918),
	(10494, 8942),
	(10496, 8957),
	(10498, 9011),
	(10562, 10595),
	(10563, 10596),
	(10564, 10598),
	(10572, 10597),
	(10582, 10600),
	(10583, 10601),
	(10585, 10602),
	(10586, 10603),
	(10589, 10604),
	(10606, 10611),
	(10612, 10613),
	(10621, 10623),
	(10626, 10627),
	(10662, 10663),
	(10680, 10681),
	(10744, 10745),
	(10754, 10755),
	(10759, 10761),
	(10762, 10756),
	(10763, 10757),
	(10764, 10758),
	(10766, 10767),
	(10772, 10750),
	(10773, 10751),
	(10774, 10765),
	(10775, 10768),
	(10776, 10769),
	(10863, 10862),
	(10869, 10868),
	(10962, 10963),
	(11002, 11003),
	(11117, 11431),
	(11122, 11412),
	(11123, 11124),
	(11131, 11219),
	(11150, 11205),
	(11185, 11186),
	(11242, 11403),
	(11302, 11312),
	(11321, 11413),
	(11346, 11350),
	(11348, 11352),
	(11349, 11351),
	(11355, 11365),
	(11358, 11366),
	(11359, 11367),
	(11400, 11419),
	(11486, 11487),
	(11502, 11503),
	(11657, 11923),
	(11704, 11702),
	(11713, 11684),
	(11731, 11922),
	(11882, 11915),
	(11921, 11926),
	(11924, 11925),
	(11986, 12026),
	(11993, 12058),
	(12022, 12191),
	(12105, 12423),
	(12129, 12165),
	(12130, 12196),
	(12131, 12197),
	(12133, 12155),
	(12135, 12139),
	(12138, 12198),
	(12142, 12144),
	(12143, 12145),
	(12146, 12147),
	(12153, 12199),
	(12161, 12425),
	(12183, 12201),
	(12184, 12202),
	(12185, 12203),
	(12219, 12207),
	(12220, 12213),
	(12222, 12256),
	(12223, 12257),
	(12246, 12229),
	(12247, 12231),
	(12248, 12241),
	(12249, 12236),
	(12250, 12242),
	(12255, 12259),
	(12278, 12306),
	(12323, 12324),
	(12416, 12448),
	(12417, 12449),
	(12418, 12450),
	(12460, 12461),
	(12464, 12285),
	(12479, 12480),
	(12491, 12492),
	(12854, 12895),
	(12858, 12926),
	(12860, 12927),
	(12862, 13060),
	(12870, 12882),
	(12872, 12928),
	(12885, 12929),
	(12887, 12892),
	(12896, 12897),
	(12898, 12899),
	(13186, 13185),
	(13188, 13189),
	(13222, 13223),
	(13226, 13227),
	(13284, 13301),
	(13309, 13310),
	(13332, 13306),
	(13334, 13307),
	(13335, 13329),
	(13336, 13330),
	(13337, 13312),
	(13338, 13316),
	(13339, 13328),
	(13341, 13340),
	(13380, 13373),
	(13381, 13374),
	(13382, 13376),
	(13383, 13379),
	(13387, 13259),
	(13388, 13262),
	(13389, 13263),
	(13390, 13271),
	(13391, 13275),
	(13392, 13282),
	(13393, 13304),
	(13394, 13305),
	(13395, 13236),
	(13396, 13348),
	(13397, 13349),
	(13398, 13359),
	(13399, 13360),
	(13400, 13361),
	(13401, 13362),
	(13402, 13363),
	(13403, 13364),
	(13408, 13409),
	(13410, 13411),
	(13415, 13416),
	(13418, 13419),
	(13480, 13479),
	(13484, 13483),
	(13625, 13677),
	(13633, 13634),
	(13671, 13676),
	(13672, 13678),
	(13679, 13680),
	(13686, 13687),
	(13828, 13829),
	(13835, 13838),
	(13837, 13839),
	(14022, 14036),
	(14023, 14037),
	(14024, 14040),
	(14028, 14041),
	(14030, 14044),
	(14033, 14043),
	(14035, 14047),
	(14048, 14061),
	(14051, 14062),
	(14053, 14059),
	(14054, 14060),
	(14055, 14058),
	(14096, 14142),
	(20438, 24556),
	(20439, 24451),
	(24498, 24507),
	(24499, 24511),
	(24500, 24802),
	(24510, 24506),
	(24535, 24563),
	(24655, 24536),
	(24656, 24541),
	(24657, 24576),
	(24683, 24682),
	(24710, 24712),
	(24711, 24713),
	(24804, 24805),
	(24848, 24850),
	(25055, 25092),
	(25180, 25181),
	(25253, 25228),
	(25282, 25254),
	(25290, 25288),
	(25414, 25293);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
