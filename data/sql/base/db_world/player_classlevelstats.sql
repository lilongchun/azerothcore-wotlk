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

-- Dumpar struktur för tabell acore_world.player_classlevelstats
DROP TABLE IF EXISTS `player_classlevelstats`;
CREATE TABLE IF NOT EXISTS `player_classlevelstats` (
  `class` tinyint unsigned NOT NULL,
  `level` tinyint unsigned NOT NULL,
  `basehp` int unsigned NOT NULL DEFAULT '1',
  `basemana` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`class`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci PACK_KEYS=0 COMMENT='Stores levels stats.';

-- Dumpar data för tabell acore_world.player_classlevelstats: 800 rows
DELETE FROM `player_classlevelstats`;
/*!40000 ALTER TABLE `player_classlevelstats` DISABLE KEYS */;
INSERT INTO `player_classlevelstats` (`class`, `level`, `basehp`, `basemana`) VALUES
	(1, 1, 20, 0),
	(1, 2, 29, 0),
	(1, 3, 38, 0),
	(1, 4, 47, 0),
	(1, 5, 56, 0),
	(1, 6, 65, 0),
	(1, 7, 74, 0),
	(1, 8, 83, 0),
	(1, 9, 92, 0),
	(1, 10, 97, 0),
	(1, 11, 103, 0),
	(1, 12, 109, 0),
	(1, 13, 118, 0),
	(1, 14, 128, 0),
	(1, 15, 139, 0),
	(1, 16, 151, 0),
	(1, 17, 154, 0),
	(1, 18, 168, 0),
	(1, 19, 183, 0),
	(1, 20, 199, 0),
	(1, 21, 206, 0),
	(1, 22, 224, 0),
	(1, 23, 243, 0),
	(1, 24, 253, 0),
	(1, 25, 274, 0),
	(1, 26, 296, 0),
	(1, 27, 309, 0),
	(1, 28, 333, 0),
	(1, 29, 348, 0),
	(1, 30, 374, 0),
	(1, 31, 401, 0),
	(1, 32, 419, 0),
	(1, 33, 448, 0),
	(1, 34, 468, 0),
	(1, 35, 499, 0),
	(1, 36, 521, 0),
	(1, 37, 545, 0),
	(1, 38, 581, 0),
	(1, 39, 609, 0),
	(1, 40, 649, 0),
	(1, 41, 681, 0),
	(1, 42, 715, 0),
	(1, 43, 761, 0),
	(1, 44, 799, 0),
	(1, 45, 839, 0),
	(1, 46, 881, 0),
	(1, 47, 935, 0),
	(1, 48, 981, 0),
	(1, 49, 1029, 0),
	(1, 50, 1079, 0),
	(1, 51, 1131, 0),
	(1, 52, 1185, 0),
	(1, 53, 1241, 0),
	(1, 54, 1299, 0),
	(1, 55, 1359, 0),
	(1, 56, 1421, 0),
	(1, 57, 1485, 0),
	(1, 58, 1551, 0),
	(1, 59, 1619, 0),
	(1, 60, 1689, 0),
	(1, 61, 1902, 0),
	(1, 62, 2129, 0),
	(1, 63, 2357, 0),
	(1, 64, 2612, 0),
	(1, 65, 2883, 0),
	(1, 66, 3169, 0),
	(1, 67, 3455, 0),
	(1, 68, 3774, 0),
	(1, 69, 4109, 0),
	(1, 70, 4444, 0),
	(1, 71, 4720, 0),
	(1, 72, 5013, 0),
	(1, 73, 5325, 0),
	(1, 74, 5656, 0),
	(1, 75, 6008, 0),
	(1, 76, 6381, 0),
	(1, 77, 6778, 0),
	(1, 78, 7198, 0),
	(1, 79, 7646, 0),
	(1, 80, 8121, 0),
	(2, 1, 28, 60),
	(2, 2, 36, 78),
	(2, 3, 44, 98),
	(2, 4, 52, 104),
	(2, 5, 60, 111),
	(2, 6, 68, 134),
	(2, 7, 76, 143),
	(2, 8, 84, 153),
	(2, 9, 92, 179),
	(2, 10, 100, 192),
	(2, 11, 108, 205),
	(2, 12, 116, 219),
	(2, 13, 124, 249),
	(2, 14, 129, 265),
	(2, 15, 135, 282),
	(2, 16, 141, 315),
	(2, 17, 152, 334),
	(2, 18, 164, 354),
	(2, 19, 177, 390),
	(2, 20, 191, 412),
	(2, 21, 206, 435),
	(2, 22, 222, 459),
	(2, 23, 239, 499),
	(2, 24, 247, 525),
	(2, 25, 266, 552),
	(2, 26, 286, 579),
	(2, 27, 307, 621),
	(2, 28, 329, 648),
	(2, 29, 342, 675),
	(2, 30, 366, 702),
	(2, 31, 391, 729),
	(2, 32, 407, 756),
	(2, 33, 434, 798),
	(2, 34, 462, 825),
	(2, 35, 481, 852),
	(2, 36, 511, 879),
	(2, 37, 542, 906),
	(2, 38, 564, 933),
	(2, 39, 597, 960),
	(2, 40, 621, 987),
	(2, 41, 656, 1014),
	(2, 42, 682, 1041),
	(2, 43, 719, 1068),
	(2, 44, 747, 1110),
	(2, 45, 786, 1137),
	(2, 46, 816, 1164),
	(2, 47, 857, 1176),
	(2, 48, 889, 1203),
	(2, 49, 922, 1230),
	(2, 50, 966, 1257),
	(2, 51, 1001, 1284),
	(2, 52, 1037, 1311),
	(2, 53, 1084, 1338),
	(2, 54, 1122, 1365),
	(2, 55, 1161, 1392),
	(2, 56, 1201, 1419),
	(2, 57, 1252, 1446),
	(2, 58, 1294, 1458),
	(2, 59, 1337, 1485),
	(2, 60, 1381, 1512),
	(2, 61, 1540, 1656),
	(2, 62, 1708, 1800),
	(2, 63, 1884, 1944),
	(2, 64, 2068, 2088),
	(2, 65, 2262, 2232),
	(2, 66, 2466, 2377),
	(2, 67, 2679, 2521),
	(2, 68, 2901, 2665),
	(2, 69, 3134, 2809),
	(2, 70, 3377, 2953),
	(2, 71, 3629, 3097),
	(2, 72, 3900, 3241),
	(2, 73, 4191, 3385),
	(2, 74, 4503, 3529),
	(2, 75, 4839, 3673),
	(2, 76, 5200, 3817),
	(2, 77, 5588, 3962),
	(2, 78, 6005, 4106),
	(2, 79, 6453, 4250),
	(2, 80, 6934, 4394),
	(3, 1, 46, 65),
	(3, 2, 53, 70),
	(3, 3, 60, 76),
	(3, 4, 67, 98),
	(3, 5, 74, 106),
	(3, 6, 81, 130),
	(3, 7, 88, 140),
	(3, 8, 95, 166),
	(3, 9, 102, 193),
	(3, 10, 109, 206),
	(3, 11, 116, 235),
	(3, 12, 123, 250),
	(3, 13, 130, 266),
	(3, 14, 138, 298),
	(3, 15, 147, 316),
	(3, 16, 157, 350),
	(3, 17, 168, 370),
	(3, 18, 180, 391),
	(3, 19, 193, 428),
	(3, 20, 207, 451),
	(3, 21, 222, 475),
	(3, 22, 238, 515),
	(3, 23, 255, 541),
	(3, 24, 273, 568),
	(3, 25, 292, 611),
	(3, 26, 312, 640),
	(3, 27, 333, 670),
	(3, 28, 355, 715),
	(3, 29, 378, 745),
	(3, 30, 402, 775),
	(3, 31, 417, 805),
	(3, 32, 443, 850),
	(3, 33, 470, 880),
	(3, 34, 498, 910),
	(3, 35, 527, 940),
	(3, 36, 547, 970),
	(3, 37, 578, 1015),
	(3, 38, 610, 1045),
	(3, 39, 643, 1075),
	(3, 40, 667, 1105),
	(3, 41, 702, 1135),
	(3, 42, 738, 1180),
	(3, 43, 775, 1210),
	(3, 44, 803, 1240),
	(3, 45, 842, 1270),
	(3, 46, 872, 1300),
	(3, 47, 913, 1330),
	(3, 48, 955, 1360),
	(3, 49, 994, 1390),
	(3, 50, 1047, 1420),
	(3, 51, 1067, 1450),
	(3, 52, 1113, 1480),
	(3, 53, 1150, 1510),
	(3, 54, 1198, 1540),
	(3, 55, 1237, 1570),
	(3, 56, 1287, 1600),
	(3, 57, 1328, 1630),
	(3, 58, 1370, 1660),
	(3, 59, 1423, 1690),
	(3, 60, 1467, 1720),
	(3, 61, 1633, 1886),
	(3, 62, 1819, 2053),
	(3, 63, 2003, 2219),
	(3, 64, 2195, 2385),
	(3, 65, 2397, 2552),
	(3, 66, 2623, 2718),
	(3, 67, 2844, 2884),
	(3, 68, 3075, 3050),
	(3, 69, 3316, 3217),
	(3, 70, 3568, 3383),
	(3, 71, 3834, 3549),
	(3, 72, 4120, 3716),
	(3, 73, 4427, 3882),
	(3, 74, 4757, 4048),
	(3, 75, 5112, 4215),
	(3, 76, 5493, 4381),
	(3, 77, 5903, 4547),
	(3, 78, 6343, 4713),
	(3, 79, 6816, 4880),
	(3, 80, 7324, 5046),
	(4, 1, 25, 0),
	(4, 2, 32, 0),
	(4, 3, 49, 0),
	(4, 4, 56, 0),
	(4, 5, 63, 0),
	(4, 6, 70, 0),
	(4, 7, 87, 0),
	(4, 8, 94, 0),
	(4, 9, 101, 0),
	(4, 10, 118, 0),
	(4, 11, 125, 0),
	(4, 12, 142, 0),
	(4, 13, 149, 0),
	(4, 14, 156, 0),
	(4, 15, 173, 0),
	(4, 16, 181, 0),
	(4, 17, 190, 0),
	(4, 18, 200, 0),
	(4, 19, 221, 0),
	(4, 20, 233, 0),
	(4, 21, 246, 0),
	(4, 22, 260, 0),
	(4, 23, 275, 0),
	(4, 24, 301, 0),
	(4, 25, 318, 0),
	(4, 26, 336, 0),
	(4, 27, 355, 0),
	(4, 28, 375, 0),
	(4, 29, 396, 0),
	(4, 30, 428, 0),
	(4, 31, 451, 0),
	(4, 32, 475, 0),
	(4, 33, 500, 0),
	(4, 34, 526, 0),
	(4, 35, 553, 0),
	(4, 36, 581, 0),
	(4, 37, 610, 0),
	(4, 38, 640, 0),
	(4, 39, 671, 0),
	(4, 40, 703, 0),
	(4, 41, 736, 0),
	(4, 42, 770, 0),
	(4, 43, 805, 0),
	(4, 44, 841, 0),
	(4, 45, 878, 0),
	(4, 46, 916, 0),
	(4, 47, 955, 0),
	(4, 48, 995, 0),
	(4, 49, 1026, 0),
	(4, 50, 1068, 0),
	(4, 51, 1111, 0),
	(4, 52, 1155, 0),
	(4, 53, 1200, 0),
	(4, 54, 1246, 0),
	(4, 55, 1283, 0),
	(4, 56, 1331, 0),
	(4, 57, 1380, 0),
	(4, 58, 1430, 0),
	(4, 59, 1471, 0),
	(4, 60, 1523, 0),
	(4, 61, 1702, 0),
	(4, 62, 1879, 0),
	(4, 63, 2077, 0),
	(4, 64, 2285, 0),
	(4, 65, 2489, 0),
	(4, 66, 2717, 0),
	(4, 67, 2941, 0),
	(4, 68, 3190, 0),
	(4, 69, 3450, 0),
	(4, 70, 3704, 0),
	(4, 71, 3980, 0),
	(4, 72, 4277, 0),
	(4, 73, 4596, 0),
	(4, 74, 4939, 0),
	(4, 75, 5307, 0),
	(4, 76, 5703, 0),
	(4, 77, 6128, 0),
	(4, 78, 6585, 0),
	(4, 79, 7076, 0),
	(4, 80, 7604, 0),
	(5, 1, 52, 73),
	(5, 2, 57, 76),
	(5, 3, 72, 95),
	(5, 4, 77, 114),
	(5, 5, 92, 133),
	(5, 6, 101, 152),
	(5, 7, 112, 171),
	(5, 8, 117, 190),
	(5, 9, 132, 209),
	(5, 10, 137, 212),
	(5, 11, 142, 215),
	(5, 12, 157, 234),
	(5, 13, 172, 254),
	(5, 14, 177, 260),
	(5, 15, 192, 282),
	(5, 16, 197, 305),
	(5, 17, 212, 329),
	(5, 18, 227, 339),
	(5, 19, 232, 365),
	(5, 20, 247, 377),
	(5, 21, 252, 405),
	(5, 22, 268, 434),
	(5, 23, 275, 449),
	(5, 24, 293, 480),
	(5, 25, 302, 497),
	(5, 26, 322, 530),
	(5, 27, 343, 549),
	(5, 28, 355, 584),
	(5, 29, 378, 605),
	(5, 30, 392, 627),
	(5, 31, 417, 665),
	(5, 32, 433, 689),
	(5, 33, 460, 728),
	(5, 34, 478, 752),
	(5, 35, 507, 776),
	(5, 36, 527, 800),
	(5, 37, 548, 839),
	(5, 38, 580, 863),
	(5, 39, 603, 887),
	(5, 40, 637, 911),
	(5, 41, 662, 950),
	(5, 42, 698, 974),
	(5, 43, 725, 998),
	(5, 44, 763, 1022),
	(5, 45, 792, 1046),
	(5, 46, 822, 1070),
	(5, 47, 863, 1094),
	(5, 48, 895, 1118),
	(5, 49, 928, 1142),
	(5, 50, 972, 1166),
	(5, 51, 1007, 1190),
	(5, 52, 1053, 1214),
	(5, 53, 1090, 1238),
	(5, 54, 1128, 1262),
	(5, 55, 1177, 1271),
	(5, 56, 1217, 1295),
	(5, 57, 1258, 1319),
	(5, 58, 1300, 1343),
	(5, 59, 1353, 1352),
	(5, 60, 1397, 1376),
	(5, 61, 1557, 1500),
	(5, 62, 1738, 1625),
	(5, 63, 1916, 1749),
	(5, 64, 2101, 1873),
	(5, 65, 2295, 1998),
	(5, 66, 2495, 2122),
	(5, 67, 2719, 2247),
	(5, 68, 2936, 2371),
	(5, 69, 3160, 2495),
	(5, 70, 3391, 2620),
	(5, 71, 3644, 2744),
	(5, 72, 3916, 2868),
	(5, 73, 4208, 2993),
	(5, 74, 4522, 3117),
	(5, 75, 4859, 3242),
	(5, 76, 5221, 3366),
	(5, 77, 5610, 3490),
	(5, 78, 6028, 3615),
	(5, 79, 6477, 3739),
	(5, 80, 6960, 3863),
	(6, 1, 22, 0),
	(6, 2, 27, 0),
	(6, 3, 32, 0),
	(6, 4, 37, 0),
	(6, 5, 42, 0),
	(6, 6, 47, 0),
	(6, 7, 52, 0),
	(6, 8, 58, 0),
	(6, 9, 64, 0),
	(6, 10, 70, 0),
	(6, 11, 77, 0),
	(6, 12, 84, 0),
	(6, 13, 92, 0),
	(6, 14, 100, 0),
	(6, 15, 117, 0),
	(6, 16, 127, 0),
	(6, 17, 138, 0),
	(6, 18, 150, 0),
	(6, 19, 163, 0),
	(6, 20, 177, 0),
	(6, 21, 192, 0),
	(6, 22, 208, 0),
	(6, 23, 225, 0),
	(6, 24, 239, 0),
	(6, 25, 258, 0),
	(6, 26, 278, 0),
	(6, 27, 299, 0),
	(6, 28, 321, 0),
	(6, 29, 344, 0),
	(6, 30, 368, 0),
	(6, 31, 393, 0),
	(6, 32, 419, 0),
	(6, 33, 446, 0),
	(6, 34, 474, 0),
	(6, 35, 503, 0),
	(6, 36, 533, 0),
	(6, 37, 564, 0),
	(6, 38, 596, 0),
	(6, 39, 629, 0),
	(6, 40, 698, 0),
	(6, 41, 698, 0),
	(6, 42, 734, 0),
	(6, 43, 771, 0),
	(6, 44, 809, 0),
	(6, 45, 849, 0),
	(6, 46, 891, 0),
	(6, 47, 935, 0),
	(6, 48, 981, 0),
	(6, 49, 1029, 0),
	(6, 50, 1079, 0),
	(6, 51, 1131, 0),
	(6, 52, 1185, 0),
	(6, 53, 1241, 0),
	(6, 54, 1299, 0),
	(6, 55, 1359, 0),
	(6, 56, 1421, 0),
	(6, 57, 1485, 0),
	(6, 58, 1551, 0),
	(6, 59, 1619, 0),
	(6, 60, 1689, 0),
	(6, 61, 1902, 0),
	(6, 62, 2129, 0),
	(6, 63, 2357, 0),
	(6, 64, 2612, 0),
	(6, 65, 2883, 0),
	(6, 66, 3169, 0),
	(6, 67, 3455, 0),
	(6, 68, 3774, 0),
	(6, 69, 4109, 0),
	(6, 70, 4444, 0),
	(6, 71, 4720, 0),
	(6, 72, 5013, 0),
	(6, 73, 5325, 0),
	(6, 74, 5656, 0),
	(6, 75, 6008, 0),
	(6, 76, 6381, 0),
	(6, 77, 6778, 0),
	(6, 78, 7199, 0),
	(6, 79, 7646, 0),
	(6, 80, 8121, 0),
	(7, 1, 40, 85),
	(7, 2, 47, 91),
	(7, 3, 55, 98),
	(7, 4, 62, 106),
	(7, 5, 70, 115),
	(7, 6, 77, 125),
	(7, 7, 85, 136),
	(7, 8, 92, 148),
	(7, 9, 100, 161),
	(7, 10, 107, 175),
	(7, 11, 114, 190),
	(7, 12, 122, 206),
	(7, 13, 129, 223),
	(7, 14, 137, 241),
	(7, 15, 144, 260),
	(7, 16, 152, 280),
	(7, 17, 161, 301),
	(7, 18, 170, 323),
	(7, 19, 181, 346),
	(7, 20, 193, 370),
	(7, 21, 205, 395),
	(7, 22, 219, 421),
	(7, 23, 234, 448),
	(7, 24, 250, 476),
	(7, 25, 257, 505),
	(7, 26, 275, 535),
	(7, 27, 294, 566),
	(7, 28, 315, 598),
	(7, 29, 336, 631),
	(7, 30, 358, 665),
	(7, 31, 371, 699),
	(7, 32, 396, 733),
	(7, 33, 422, 767),
	(7, 34, 448, 786),
	(7, 35, 465, 820),
	(7, 36, 494, 854),
	(7, 37, 524, 888),
	(7, 38, 545, 922),
	(7, 39, 577, 941),
	(7, 40, 610, 975),
	(7, 41, 633, 1009),
	(7, 42, 669, 1028),
	(7, 43, 694, 1062),
	(7, 44, 732, 1096),
	(7, 45, 760, 1115),
	(7, 46, 799, 1149),
	(7, 47, 829, 1183),
	(7, 48, 871, 1202),
	(7, 49, 903, 1236),
	(7, 50, 947, 1255),
	(7, 51, 981, 1289),
	(7, 52, 1027, 1323),
	(7, 53, 1064, 1342),
	(7, 54, 1101, 1376),
	(7, 55, 1150, 1395),
	(7, 56, 1190, 1414),
	(7, 57, 1231, 1448),
	(7, 58, 1283, 1467),
	(7, 59, 1326, 1501),
	(7, 60, 1423, 1520),
	(7, 61, 1528, 1664),
	(7, 62, 1694, 1808),
	(7, 63, 1883, 1951),
	(7, 64, 2067, 2095),
	(7, 65, 2262, 2239),
	(7, 66, 2465, 2383),
	(7, 67, 2679, 2527),
	(7, 68, 2903, 2670),
	(7, 69, 3136, 2814),
	(7, 70, 3380, 2958),
	(7, 71, 3633, 3102),
	(7, 72, 3903, 3246),
	(7, 73, 4194, 3389),
	(7, 74, 4507, 3533),
	(7, 75, 4843, 3677),
	(7, 76, 5203, 3821),
	(7, 77, 5592, 3965),
	(7, 78, 6009, 4108),
	(7, 79, 6457, 4252),
	(7, 80, 6939, 4396),
	(8, 1, 32, 100),
	(8, 2, 47, 110),
	(8, 3, 52, 106),
	(8, 4, 67, 118),
	(8, 5, 82, 131),
	(8, 6, 97, 130),
	(8, 7, 102, 145),
	(8, 8, 117, 146),
	(8, 9, 132, 163),
	(8, 10, 137, 196),
	(8, 11, 152, 215),
	(8, 12, 167, 220),
	(8, 13, 172, 241),
	(8, 14, 187, 263),
	(8, 15, 202, 271),
	(8, 16, 207, 295),
	(8, 17, 222, 305),
	(8, 18, 237, 331),
	(8, 19, 242, 343),
	(8, 20, 257, 371),
	(8, 21, 272, 385),
	(8, 22, 277, 415),
	(8, 23, 292, 431),
	(8, 24, 298, 463),
	(8, 25, 315, 481),
	(8, 26, 333, 515),
	(8, 27, 342, 535),
	(8, 28, 362, 556),
	(8, 29, 373, 592),
	(8, 30, 395, 613),
	(8, 31, 418, 634),
	(8, 32, 432, 670),
	(8, 33, 457, 691),
	(8, 34, 473, 712),
	(8, 35, 500, 733),
	(8, 36, 518, 754),
	(8, 37, 547, 790),
	(8, 38, 577, 811),
	(8, 39, 598, 832),
	(8, 40, 630, 853),
	(8, 41, 653, 874),
	(8, 42, 687, 895),
	(8, 43, 712, 916),
	(8, 44, 748, 937),
	(8, 45, 775, 958),
	(8, 46, 813, 979),
	(8, 47, 842, 1000),
	(8, 48, 882, 1021),
	(8, 49, 913, 1042),
	(8, 50, 955, 1048),
	(8, 51, 988, 1069),
	(8, 52, 1032, 1090),
	(8, 53, 1067, 1111),
	(8, 54, 1103, 1117),
	(8, 55, 1150, 1138),
	(8, 56, 1188, 1159),
	(8, 57, 1237, 1165),
	(8, 58, 1277, 1186),
	(8, 59, 1328, 1192),
	(8, 60, 1370, 1213),
	(8, 61, 1526, 1316),
	(8, 62, 1702, 1419),
	(8, 63, 1875, 1521),
	(8, 64, 2070, 1624),
	(8, 65, 2261, 1727),
	(8, 66, 2461, 1830),
	(8, 67, 2686, 1932),
	(8, 68, 2906, 2035),
	(8, 69, 3136, 2138),
	(8, 70, 3393, 2241),
	(8, 71, 3646, 2343),
	(8, 72, 3918, 2446),
	(8, 73, 4210, 2549),
	(8, 74, 4524, 2652),
	(8, 75, 4861, 2754),
	(8, 76, 5223, 2857),
	(8, 77, 5612, 2960),
	(8, 78, 6030, 3063),
	(8, 79, 6480, 3165),
	(8, 80, 6963, 3268),
	(9, 1, 23, 90),
	(9, 2, 28, 98),
	(9, 3, 43, 107),
	(9, 4, 48, 102),
	(9, 5, 63, 113),
	(9, 6, 68, 126),
	(9, 7, 83, 144),
	(9, 8, 88, 162),
	(9, 9, 93, 180),
	(9, 10, 108, 198),
	(9, 11, 123, 200),
	(9, 12, 128, 218),
	(9, 13, 143, 237),
	(9, 14, 148, 257),
	(9, 15, 153, 278),
	(9, 16, 168, 300),
	(9, 17, 173, 308),
	(9, 18, 189, 332),
	(9, 19, 196, 357),
	(9, 20, 204, 383),
	(9, 21, 223, 395),
	(9, 22, 233, 423),
	(9, 23, 244, 452),
	(9, 24, 266, 467),
	(9, 25, 279, 498),
	(9, 26, 293, 530),
	(9, 27, 318, 548),
	(9, 28, 334, 582),
	(9, 29, 351, 602),
	(9, 30, 379, 638),
	(9, 31, 398, 674),
	(9, 32, 418, 695),
	(9, 33, 439, 731),
	(9, 34, 471, 752),
	(9, 35, 494, 788),
	(9, 36, 518, 809),
	(9, 37, 543, 830),
	(9, 38, 569, 866),
	(9, 39, 606, 887),
	(9, 40, 634, 923),
	(9, 41, 663, 944),
	(9, 42, 693, 965),
	(9, 43, 724, 1001),
	(9, 44, 756, 1022),
	(9, 45, 799, 1043),
	(9, 46, 832, 1064),
	(9, 47, 868, 1100),
	(9, 48, 904, 1121),
	(9, 49, 941, 1142),
	(9, 50, 979, 1163),
	(9, 51, 1018, 1184),
	(9, 52, 1058, 1205),
	(9, 53, 1099, 1226),
	(9, 54, 1141, 1247),
	(9, 55, 1184, 1268),
	(9, 56, 1228, 1289),
	(9, 57, 1273, 1310),
	(9, 58, 1319, 1331),
	(9, 59, 1366, 1352),
	(9, 60, 1414, 1373),
	(9, 61, 1580, 1497),
	(9, 62, 1755, 1621),
	(9, 63, 1939, 1745),
	(9, 64, 2133, 1870),
	(9, 65, 2323, 1994),
	(9, 66, 2535, 2118),
	(9, 67, 2758, 2242),
	(9, 68, 2991, 2366),
	(9, 69, 3235, 2490),
	(9, 70, 3490, 2615),
	(9, 71, 3750, 2739),
	(9, 72, 4025, 2863),
	(9, 73, 4330, 2987),
	(9, 74, 4646, 3111),
	(9, 75, 4997, 3235),
	(9, 76, 5373, 3360),
	(9, 77, 5774, 3483),
	(9, 78, 6207, 3608),
	(9, 79, 6667, 3732),
	(9, 80, 7136, 3856),
	(11, 1, 44, 60),
	(11, 2, 51, 66),
	(11, 3, 58, 73),
	(11, 4, 75, 81),
	(11, 5, 82, 90),
	(11, 6, 89, 100),
	(11, 7, 106, 111),
	(11, 8, 113, 123),
	(11, 9, 120, 136),
	(11, 10, 137, 150),
	(11, 11, 144, 165),
	(11, 12, 151, 182),
	(11, 13, 168, 200),
	(11, 14, 175, 219),
	(11, 15, 182, 239),
	(11, 16, 199, 260),
	(11, 17, 206, 282),
	(11, 18, 214, 305),
	(11, 19, 233, 329),
	(11, 20, 243, 354),
	(11, 21, 254, 380),
	(11, 22, 266, 392),
	(11, 23, 289, 420),
	(11, 24, 303, 449),
	(11, 25, 318, 479),
	(11, 26, 334, 509),
	(11, 27, 361, 524),
	(11, 28, 379, 554),
	(11, 29, 398, 584),
	(11, 30, 418, 614),
	(11, 31, 439, 629),
	(11, 32, 461, 659),
	(11, 33, 494, 689),
	(11, 34, 518, 704),
	(11, 35, 543, 734),
	(11, 36, 569, 749),
	(11, 37, 596, 779),
	(11, 38, 624, 809),
	(11, 39, 653, 824),
	(11, 40, 683, 854),
	(11, 41, 714, 869),
	(11, 42, 746, 899),
	(11, 43, 779, 914),
	(11, 44, 823, 944),
	(11, 45, 858, 959),
	(11, 46, 894, 989),
	(11, 47, 921, 1004),
	(11, 48, 959, 1019),
	(11, 49, 998, 1049),
	(11, 50, 1038, 1064),
	(11, 51, 1079, 1079),
	(11, 52, 1121, 1109),
	(11, 53, 1164, 1124),
	(11, 54, 1208, 1139),
	(11, 55, 1253, 1154),
	(11, 56, 1299, 1169),
	(11, 57, 1346, 1199),
	(11, 58, 1384, 1214),
	(11, 59, 1433, 1229),
	(11, 60, 1483, 1244),
	(11, 61, 1657, 1357),
	(11, 62, 1840, 1469),
	(11, 63, 2020, 1582),
	(11, 64, 2222, 1694),
	(11, 65, 2433, 1807),
	(11, 66, 2640, 1919),
	(11, 67, 2872, 2032),
	(11, 68, 3114, 2145),
	(11, 69, 3351, 2257),
	(11, 70, 3614, 2370),
	(11, 71, 3883, 2482),
	(11, 72, 4172, 2595),
	(11, 73, 4483, 2708),
	(11, 74, 4817, 2820),
	(11, 75, 5176, 2933),
	(11, 76, 5562, 3045),
	(11, 77, 5977, 3158),
	(11, 78, 6423, 3270),
	(11, 79, 6902, 3383),
	(11, 80, 7417, 3496);
/*!40000 ALTER TABLE `player_classlevelstats` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
