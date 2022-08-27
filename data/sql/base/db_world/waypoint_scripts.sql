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

-- Dumpar struktur för tabell acore_world.waypoint_scripts
DROP TABLE IF EXISTS `waypoint_scripts`;
CREATE TABLE IF NOT EXISTS `waypoint_scripts` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `command` int unsigned NOT NULL DEFAULT '0',
  `datalong` int unsigned NOT NULL DEFAULT '0',
  `datalong2` int unsigned NOT NULL DEFAULT '0',
  `dataint` int unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `guid` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.waypoint_scripts: 584 rows
DELETE FROM `waypoint_scripts`;
/*!40000 ALTER TABLE `waypoint_scripts` DISABLE KEYS */;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
	(115879, 0, 16, 7274, 0, 0, 0, 0, 0, 0, 0),
	(1, 0, 2, 83, 11, 0, 0, 0, 0, 0, 1),
	(3, 0, 2, 83, 28, 0, 0, 0, 0, 0, 3),
	(4, 0, 2, 83, 28, 0, 0, 0, 0, 0, 4),
	(1360540, 0, 1, 468, 1, 0, 0, 0, 0, 0, 5),
	(1360541, 0, 1, 401, 0, 0, 0, 0, 0, 0, 6),
	(10, 0, 1, 5, 0, 0, 0, 0, 0, 0, 10),
	(11, 0, 1, 18, 0, 0, 0, 0, 0, 0, 11),
	(12, 0, 1, 21, 0, 0, 0, 0, 0, 0, 12),
	(13, 0, 1, 273, 0, 0, 0, 0, 0, 0, 13),
	(14, 0, 1, 22, 0, 0, 0, 0, 0, 0, 14),
	(14, 0, 16, 9739, 2, 0, 0, 0, 0, 0, 15),
	(21, 0, 1, 0, 1, 0, 0, 0, 0, 0, 21),
	(22, 0, 0, 0, 0, 5960, 0, 0, 0, 0, 25),
	(23, 0, 0, 0, 0, 22392, 0, 0, 0, 0, 26),
	(23, 0, 2, 83, 15, 0, 0, 0, 0, 0, 27),
	(24, 0, 0, 0, 0, 22050, 0, 0, 0, 0, 28),
	(24, 0, 2, 83, 1, 0, 0, 0, 0, 0, 29),
	(25, 0, 0, 0, 0, 22051, 0, 0, 0, 0, 30),
	(25, 0, 2, 83, 1, 0, 0, 0, 0, 0, 31),
	(26, 0, 0, 0, 0, 22052, 0, 0, 0, 0, 32),
	(26, 0, 2, 83, 1, 0, 0, 0, 0, 0, 33),
	(27, 0, 0, 0, 0, 10141, 0, 0, 0, 0, 34),
	(28, 0, 0, 0, 0, 10146, 0, 0, 0, 0, 35),
	(29, 0, 0, 0, 0, 10152, 0, 0, 0, 0, 36),
	(30, 0, 0, 0, 0, 10126, 0, 0, 0, 0, 37),
	(31, 0, 2, 83, 13, 0, 0, 0, 0, 0, 38),
	(32, 0, 2, 83, 13, 0, 0, 0, 0, 0, 39),
	(33, 0, 2, 83, 13, 0, 0, 0, 0, 0, 40),
	(34, 0, 2, 83, 16, 0, 0, 0, 0, 0, 41),
	(35, 0, 2, 83, 16, 0, 0, 0, 0, 0, 42),
	(36, 0, 2, 83, 16, 0, 0, 0, 0, 0, 43),
	(37, 0, 2, 83, 16, 0, 0, 0, 0, 0, 44),
	(38, 0, 2, 83, 16, 0, 0, 0, 0, 0, 45),
	(39, 0, 0, 0, 0, 7194, 0, 0, 0, 0, 46),
	(40, 0, 0, 0, 0, 7193, 0, 0, 0, 0, 47),
	(41, 0, 0, 0, 0, 7191, 0, 0, 0, 0, 48),
	(42, 0, 0, 0, 0, 10139, 0, 0, 0, 0, 49),
	(43, 0, 0, 0, 0, 6406, 0, 0, 0, 0, 50),
	(44, 0, 0, 0, 0, 6405, 0, 0, 0, 0, 51),
	(45, 0, 0, 0, 0, 10158, 0, 0, 0, 0, 52),
	(46, 0, 0, 0, 0, 22544, 0, 0, 0, 0, 53),
	(47, 0, 0, 0, 0, 10146, 0, 0, 0, 0, 54),
	(929090, 1, 30, 0, 0, 0, 0, 0, 0, 3.22886, 55),
	(929090, 2, 2, 74, 8, 0, 0, 0, 0, 0, 56),
	(929090, 5, 2, 74, 0, 0, 0, 0, 0, 0, 57),
	(929091, 1, 30, 0, 0, 0, 0, 0, 0, 0.610865, 58),
	(929091, 2, 15, 23488, 1, 0, 0, 0, 0, 0, 59),
	(929091, 5, 2, 83, 233, 0, 0, 0, 0, 0, 60),
	(929091, 24, 2, 83, 69, 0, 0, 0, 0, 0, 61),
	(929110, 2, 2, 74, 1, 0, 0, 0, 0, 0, 62),
	(929110, 39, 2, 74, 0, 0, 0, 0, 0, 0, 63),
	(929110, 41, 2, 83, 133, 0, 0, 0, 0, 0, 64),
	(928980, 8, 6, 0, 1, 0, -621.969, -4670.08, 5.06115, 1.09835, 65),
	(928990, 9, 6, 0, 1, 0, -619.393, -4664.69, 5.05786, 1.12032, 66),
	(48, 0, 1, 38, 0, 0, 0, 0, 0, 0, 67),
	(49, 1, 1, 378, 1, 0, 0, 0, 0, 0, 68),
	(50, 0, 1, 25, 0, 0, 0, 0, 0, 0, 69),
	(51, 1, 1, 402, 0, 0, 0, 0, 0, 0, 70),
	(52, 2, 1, 418, 1, 0, 0, 0, 0, 0, 71),
	(52, 10, 1, 0, 1, 0, 0, 0, 0, 0, 72),
	(66, 0, 2, 83, 20, 0, 0, 0, 0, 0, 73),
	(67, 0, 0, 0, 0, 12835, 0, 0, 0, 0, 74),
	(67, 0, 2, 83, 20, 0, 0, 0, 0, 0, 75),
	(68, 0, 2, 83, 20, 0, 0, 0, 0, 0, 76),
	(69, 0, 2, 83, 20, 0, 0, 0, 0, 0, 77),
	(70, 0, 0, 0, 0, 12832, 0, 0, 0, 0, 78),
	(71, 0, 0, 0, 0, 12833, 0, 0, 0, 0, 79),
	(72, 0, 0, 0, 0, 14565, 0, 0, 0, 0, 80),
	(73, 0, 0, 0, 0, 14567, 0, 0, 0, 0, 81),
	(74, 0, 0, 0, 0, 15144, 0, 0, 0, 0, 82),
	(74, 0, 2, 83, 68, 0, 0, 0, 0, 0, 83),
	(75, 0, 2, 83, 68, 0, 0, 0, 0, 0, 84),
	(76, 0, 2, 83, 68, 0, 0, 0, 0, 0, 85),
	(77, 0, 2, 83, 68, 0, 0, 0, 0, 0, 86),
	(78, 0, 2, 83, 68, 0, 0, 0, 0, 0, 87),
	(79, 0, 2, 83, 68, 0, 0, 0, 0, 0, 88),
	(1378561, 0, 30, 0, 0, 0, 0, 0, 0, 5.75959, 89),
	(1378561, 3, 1, 69, 1, 0, 0, 0, 0, 0, 90),
	(1378562, 0, 30, 0, 0, 0, 0, 0, 0, 0.715585, 91),
	(1378562, 4, 1, 133, 1, 0, 0, 0, 0, 0, 92),
	(1378562, 39, 1, 0, 1, 0, 0, 0, 0, 0, 93),
	(1378563, 0, 30, 0, 0, 0, 0, 0, 0, 1.80131, 94),
	(1378563, 1, 1, 28, 1, 0, 0, 0, 0, 0, 95),
	(1378563, 22, 1, 0, 1, 0, 0, 0, 0, 0, 96),
	(1380451, 2, 2, 74, 1, 0, 0, 0, 0, 0, 97),
	(1380451, 2, 1, 7, 0, 0, 0, 0, 0, 0, 98),
	(1380451, 24, 2, 74, 0, 0, 0, 0, 0, 0, 99),
	(1380452, 0, 30, 0, 0, 0, 0, 0, 0, 3.89208, 100),
	(1380452, 7, 1, 69, 1, 0, 0, 0, 0, 0, 101),
	(1380452, 16, 1, 0, 1, 0, 0, 0, 0, 0, 102),
	(113, 0, 2, 83, 69, 0, 0, 0, 0, 0, 123),
	(114, 0, 2, 83, 69, 0, 0, 0, 0, 0, 124),
	(115, 0, 2, 83, 69, 0, 0, 0, 0, 0, 125),
	(116, 0, 2, 83, 69, 0, 0, 0, 0, 0, 126),
	(117, 0, 2, 83, 69, 0, 0, 0, 0, 0, 127),
	(118, 0, 2, 83, 69, 0, 0, 0, 0, 0, 128),
	(119, 0, 2, 83, 69, 0, 0, 0, 0, 0, 129),
	(120, 0, 2, 83, 69, 0, 0, 0, 0, 0, 130),
	(121, 0, 2, 83, 69, 0, 0, 0, 0, 0, 131),
	(122, 0, 2, 83, 69, 0, 0, 0, 0, 0, 132),
	(123, 0, 2, 83, 69, 0, 0, 0, 0, 0, 133),
	(124, 0, 2, 83, 69, 0, 0, 0, 0, 0, 134),
	(125, 0, 2, 83, 69, 0, 0, 0, 0, 0, 135),
	(126, 0, 2, 83, 69, 0, 0, 0, 0, 0, 136),
	(127, 0, 2, 83, 69, 0, 0, 0, 0, 0, 137),
	(128, 0, 2, 83, 69, 0, 0, 0, 0, 0, 138),
	(129, 0, 2, 83, 69, 0, 0, 0, 0, 0, 139),
	(130, 0, 2, 83, 69, 0, 0, 0, 0, 0, 140),
	(131, 0, 2, 83, 69, 0, 0, 0, 0, 0, 141),
	(132, 0, 2, 83, 69, 0, 0, 0, 0, 0, 142),
	(133, 0, 2, 83, 69, 0, 0, 0, 0, 0, 143),
	(134, 0, 2, 83, 69, 0, 0, 0, 0, 0, 144),
	(135, 0, 2, 83, 69, 0, 0, 0, 0, 0, 145),
	(136, 0, 2, 83, 69, 0, 0, 0, 0, 0, 146),
	(137, 0, 2, 83, 69, 0, 0, 0, 0, 0, 147),
	(138, 0, 2, 83, 69, 0, 0, 0, 0, 0, 148),
	(139, 0, 2, 83, 69, 0, 0, 0, 0, 0, 149),
	(140, 0, 2, 83, 69, 0, 0, 0, 0, 0, 150),
	(141, 0, 2, 83, 69, 0, 0, 0, 0, 0, 151),
	(142, 0, 0, 0, 0, 17569, 0, 0, 0, 0, 152),
	(143, 0, 0, 0, 0, 17563, 0, 0, 0, 0, 153),
	(157, 0, 2, 83, 1, 0, 0, 0, 0, 0, 167),
	(158, 0, 2, 83, 6, 0, 0, 0, 0, 0, 168),
	(159, 0, 2, 83, 1, 0, 0, 0, 0, 0, 169),
	(161, 0, 2, 83, 36, 0, 0, 0, 0, 0, 171),
	(162, 0, 2, 83, 36, 0, 0, 0, 0, 0, 172),
	(163, 0, 2, 83, 36, 0, 0, 0, 0, 0, 173),
	(164, 0, 2, 83, 36, 0, 0, 0, 0, 0, 174),
	(165, 0, 2, 83, 36, 0, 0, 0, 0, 0, 175),
	(166, 0, 2, 83, 36, 0, 0, 0, 0, 0, 176),
	(167, 0, 2, 83, 1, 0, 0, 0, 0, 0, 177),
	(168, 0, 2, 83, 1, 0, 0, 0, 0, 0, 178),
	(169, 0, 2, 83, 6, 0, 0, 0, 0, 0, 179),
	(172, 0, 2, 83, 5, 0, 0, 0, 0, 0, 182),
	(173, 0, 2, 83, 5, 0, 0, 0, 0, 0, 183),
	(174, 0, 2, 83, 5, 0, 0, 0, 0, 0, 184),
	(175, 0, 2, 83, 5, 0, 0, 0, 0, 0, 185),
	(176, 0, 2, 83, 5, 0, 0, 0, 0, 0, 186),
	(177, 0, 2, 83, 5, 0, 0, 0, 0, 0, 187),
	(178, 0, 2, 83, 5, 0, 0, 0, 0, 0, 188),
	(179, 0, 2, 83, 5, 0, 0, 0, 0, 0, 189),
	(180, 0, 2, 83, 5, 0, 0, 0, 0, 0, 190),
	(181, 0, 2, 83, 5, 0, 0, 0, 0, 0, 191),
	(182, 0, 2, 83, 5, 0, 0, 0, 0, 0, 192),
	(183, 0, 2, 83, 5, 0, 0, 0, 0, 0, 193),
	(215, 0, 0, 0, 0, 10119, 0, 0, 0, 0, 225),
	(216, 0, 0, 0, 0, 17035, 0, 0, 0, 0, 226),
	(216, 0, 2, 83, 25, 0, 0, 0, 0, 0, 227),
	(217, 0, 2, 83, 233, 0, 0, 0, 0, 0, 228),
	(218, 0, 0, 0, 0, 17045, 0, 0, 0, 0, 229),
	(218, 0, 2, 83, 25, 0, 0, 0, 0, 0, 230),
	(219, 0, 0, 0, 0, 17056, 0, 0, 0, 0, 231),
	(220, 0, 0, 0, 0, 17486, 0, 0, 0, 0, 232),
	(221, 0, 0, 0, 0, 17485, 0, 0, 0, 0, 233),
	(222, 0, 0, 0, 0, 17485, 0, 0, 0, 0, 234),
	(223, 0, 0, 0, 0, 17485, 0, 0, 0, 0, 235),
	(226, 0, 0, 0, 0, 18816, 0, 0, 0, 0, 238),
	(227, 0, 2, 83, 69, 0, 0, 0, 0, 0, 239),
	(228, 0, 2, 83, 69, 0, 0, 0, 0, 0, 240),
	(271, 0, 0, 0, 0, 1101, 0, 0, 0, 0, 283),
	(272, 0, 0, 0, 0, 1103, 0, 0, 0, 0, 284),
	(273, 0, 0, 0, 0, 1102, 0, 0, 0, 0, 285),
	(274, 0, 0, 0, 0, 1104, 0, 0, 0, 0, 286),
	(275, 0, 2, 83, 7, 0, 0, 0, 0, 0, 287),
	(276, 0, 2, 83, 7, 0, 0, 0, 0, 0, 288),
	(277, 0, 2, 83, 7, 0, 0, 0, 0, 0, 289),
	(278, 0, 2, 83, 39, 0, 0, 0, 0, 0, 290),
	(279, 0, 0, 0, 0, 1110, 0, 0, 0, 0, 291),
	(280, 0, 0, 0, 0, 1105, 0, 0, 0, 0, 292),
	(281, 0, 0, 0, 0, 1108, 0, 0, 0, 0, 293),
	(282, 0, 0, 0, 0, 1106, 0, 0, 0, 0, 294),
	(283, 0, 0, 0, 0, 1107, 0, 0, 0, 0, 295),
	(284, 0, 0, 0, 0, 1112, 0, 0, 0, 0, 296),
	(308, 0, 2, 83, 234, 0, 0, 0, 0, 0, 320),
	(309, 0, 2, 83, 234, 0, 0, 0, 0, 0, 321),
	(310, 0, 2, 83, 234, 0, 0, 0, 0, 0, 322),
	(311, 0, 2, 83, 234, 0, 0, 0, 0, 0, 323),
	(312, 0, 2, 83, 234, 0, 0, 0, 0, 0, 324),
	(313, 0, 0, 0, 0, 2874, 0, 0, 0, 0, 325),
	(314, 0, 0, 0, 0, 10119, 0, 0, 0, 0, 326),
	(329, 0, 0, 0, 0, 13572, 0, 0, 0, 0, 346),
	(330, 0, 0, 0, 0, 13580, 0, 0, 0, 0, 347),
	(331, 0, 0, 0, 0, 13576, 0, 0, 0, 0, 348),
	(333, 0, 0, 0, 0, 15119, 0, 0, 0, 0, 350),
	(336, 0, 2, 83, 10, 0, 0, 0, 0, 0, 353),
	(337, 0, 2, 83, 10, 0, 0, 0, 0, 0, 354),
	(338, 0, 2, 83, 10, 0, 0, 0, 0, 0, 355),
	(339, 0, 2, 83, 10, 0, 0, 0, 0, 0, 356),
	(340, 0, 2, 83, 10, 0, 0, 0, 0, 0, 357),
	(341, 0, 2, 83, 10, 0, 0, 0, 0, 0, 358),
	(342, 0, 2, 83, 10, 0, 0, 0, 0, 0, 359),
	(343, 0, 2, 83, 10, 0, 0, 0, 0, 0, 360),
	(344, 0, 2, 83, 10, 0, 0, 0, 0, 0, 361),
	(345, 0, 2, 83, 10, 0, 0, 0, 0, 0, 362),
	(346, 0, 2, 83, 10, 0, 0, 0, 0, 0, 363),
	(347, 0, 2, 83, 10, 0, 0, 0, 0, 0, 364),
	(348, 0, 2, 83, 10, 0, 0, 0, 0, 0, 365),
	(349, 0, 2, 83, 10, 0, 0, 0, 0, 0, 366),
	(350, 0, 2, 83, 10, 0, 0, 0, 0, 0, 367),
	(351, 0, 2, 83, 10, 0, 0, 0, 0, 0, 368),
	(352, 0, 2, 83, 10, 0, 0, 0, 0, 0, 369),
	(353, 0, 2, 83, 10, 0, 0, 0, 0, 0, 370),
	(354, 0, 2, 83, 10, 0, 0, 0, 0, 0, 371),
	(355, 0, 2, 83, 10, 0, 0, 0, 0, 0, 372),
	(356, 0, 2, 83, 10, 0, 0, 0, 0, 0, 373),
	(357, 0, 2, 83, 10, 0, 0, 0, 0, 0, 374),
	(358, 0, 2, 83, 10, 0, 0, 0, 0, 0, 375),
	(359, 0, 2, 83, 10, 0, 0, 0, 0, 0, 376),
	(360, 0, 2, 83, 10, 0, 0, 0, 0, 0, 377),
	(361, 0, 2, 83, 10, 0, 0, 0, 0, 0, 378),
	(362, 0, 2, 83, 10, 0, 0, 0, 0, 0, 379),
	(363, 0, 2, 83, 10, 0, 0, 0, 0, 0, 380),
	(364, 0, 2, 83, 10, 0, 0, 0, 0, 0, 381),
	(365, 0, 2, 83, 10, 0, 0, 0, 0, 0, 382),
	(366, 0, 2, 83, 10, 0, 0, 0, 0, 0, 383),
	(367, 0, 2, 83, 10, 0, 0, 0, 0, 0, 384),
	(368, 0, 2, 83, 10, 0, 0, 0, 0, 0, 385),
	(369, 0, 2, 83, 10, 0, 0, 0, 0, 0, 386),
	(370, 0, 2, 83, 36, 0, 0, 0, 0, 0, 387),
	(371, 0, 2, 83, 36, 0, 0, 0, 0, 0, 388),
	(372, 0, 2, 83, 36, 0, 0, 0, 0, 0, 389),
	(373, 0, 2, 83, 36, 0, 0, 0, 0, 0, 390),
	(374, 0, 2, 83, 36, 0, 0, 0, 0, 0, 391),
	(375, 0, 2, 83, 36, 0, 0, 0, 0, 0, 392),
	(376, 0, 2, 83, 10, 0, 0, 0, 0, 0, 393),
	(377, 0, 2, 83, 10, 0, 0, 0, 0, 0, 394),
	(378, 0, 2, 83, 10, 0, 0, 0, 0, 0, 395),
	(379, 0, 2, 83, 10, 0, 0, 0, 0, 0, 396),
	(447, 0, 0, 0, 0, 24425, 0, 0, 0, 0, 491),
	(449, 0, 0, 0, 0, 24425, 0, 0, 0, 0, 493),
	(451, 0, 0, 0, 0, 22216, 0, 0, 0, 0, 495),
	(451, 0, 2, 83, 1, 0, 0, 0, 0, 0, 496),
	(452, 0, 0, 0, 0, 22211, 0, 0, 0, 0, 497),
	(452, 0, 2, 83, 1, 0, 0, 0, 0, 0, 498),
	(453, 0, 0, 0, 0, 22206, 0, 0, 0, 0, 499),
	(453, 0, 2, 83, 68, 0, 0, 0, 0, 0, 500),
	(454, 0, 2, 83, 61, 0, 0, 0, 0, 0, 501),
	(455, 0, 0, 0, 0, 25086, 0, 0, 0, 0, 502),
	(456, 0, 0, 0, 0, 25073, 0, 0, 0, 0, 503),
	(457, 0, 0, 0, 0, 25074, 0, 0, 0, 0, 504),
	(458, 0, 0, 0, 0, 25075, 0, 0, 0, 0, 505),
	(459, 0, 0, 0, 0, 25076, 0, 0, 0, 0, 506),
	(462, 0, 2, 83, 398, 0, 0, 0, 0, 0, 509),
	(463, 0, 0, 0, 0, 23842, 0, 0, 0, 0, 510),
	(463, 0, 2, 83, 398, 0, 0, 0, 0, 0, 511),
	(464, 0, 2, 83, 398, 0, 0, 0, 0, 0, 512),
	(465, 0, 2, 83, 398, 0, 0, 0, 0, 0, 513),
	(466, 0, 1, 29, 0, 0, 0, 0, 0, 0, 515),
	(1000, 0, 0, 0, 0, 328, 0, 0, 0, 0, 516),
	(1001, 0, 0, 0, 0, 327, 0, 0, 0, 0, 517),
	(1002, 0, 0, 0, 0, 5956, 0, 0, 0, 0, 518),
	(1003, 0, 0, 0, 0, 5957, 0, 0, 0, 0, 519),
	(1004, 0, 0, 0, 0, 5960, 0, 0, 0, 0, 520),
	(1005, 0, 0, 0, 0, 5959, 0, 0, 0, 0, 521),
	(470, 1, 30, 0, 0, 0, 0, 0, 0, 3.3185, 527),
	(471, 1, 30, 0, 0, 0, 0, 0, 0, 1.804, 528),
	(472, 1, 30, 0, 0, 0, 0, 0, 0, 4.9747, 529),
	(473, 1, 30, 0, 0, 0, 0, 0, 0, 4.9635, 530),
	(474, 1, 30, 0, 0, 0, 0, 0, 0, 3.3859, 531),
	(475, 1, 1, 1, 0, 0, 0, 0, 0, 0, 532),
	(475, 3, 1, 25, 0, 0, 0, 0, 0, 0, 533),
	(476, 1, 1, 69, 1, 0, 0, 0, 0, 0, 534),
	(477, 0, 30, 0, 0, 0, 0, 0, 0, 5.37, 535),
	(477, 1, 1, 69, 1, 0, 0, 0, 0, 0, 536),
	(478, 1, 30, 0, 0, 0, 0, 0, 0, 5.3516, 537),
	(479, 1, 30, 0, 0, 0, 0, 0, 0, 1.42, 538),
	(480, 1, 30, 0, 0, 0, 0, 0, 0, 4.2214, 539),
	(480, 1, 1, 69, 1, 0, 0, 0, 0, 0, 540),
	(481, 1, 30, 0, 0, 0, 0, 0, 0, 5.3582, 541),
	(481, 1, 1, 173, 1, 0, 0, 0, 0, 0, 542),
	(1010, 0, 1, 6, 0, 0, 0, 0, 0, 0, 543),
	(1011, 0, 1, 1, 0, 0, 0, 0, 0, 0, 544),
	(1012, 0, 1, 274, 0, 0, 0, 0, 0, 0, 545),
	(1013, 0, 1, 69, 0, 0, 0, 0, 0, 0, 546),
	(1014, 0, 1, 69, 0, 0, 0, 0, 0, 0, 547),
	(1015, 0, 1, 69, 0, 0, 0, 0, 0, 0, 548),
	(1016, 0, 1, 69, 0, 0, 0, 0, 0, 0, 549),
	(1017, 0, 1, 69, 0, 0, 0, 0, 0, 0, 550),
	(1018, 0, 1, 69, 0, 0, 0, 0, 0, 0, 551),
	(1019, 0, 1, 69, 0, 0, 0, 0, 0, 0, 552),
	(1020, 0, 1, 69, 0, 0, 0, 0, 0, 0, 553),
	(1021, 0, 1, 379, 0, 0, 0, 0, 0, 0, 554),
	(1022, 0, 1, 379, 0, 0, 0, 0, 0, 0, 555),
	(1023, 0, 1, 1, 0, 0, 0, 0, 0, 0, 556),
	(1024, 0, 1, 1, 0, 0, 0, 0, 0, 0, 557),
	(1025, 0, 1, 1, 0, 0, 0, 0, 0, 0, 558),
	(1026, 0, 1, 1, 0, 0, 0, 0, 0, 0, 559),
	(1027, 0, 1, 69, 0, 0, 0, 0, 0, 0, 560),
	(1028, 0, 1, 69, 0, 0, 0, 0, 0, 0, 561),
	(1029, 0, 1, 69, 0, 0, 0, 0, 0, 0, 562),
	(1030, 0, 1, 69, 0, 0, 0, 0, 0, 0, 563),
	(1031, 0, 1, 69, 0, 0, 0, 0, 0, 0, 564),
	(1032, 0, 1, 69, 0, 0, 0, 0, 0, 0, 565),
	(1033, 0, 1, 69, 0, 0, 0, 0, 0, 0, 566),
	(1034, 0, 1, 69, 0, 0, 0, 0, 0, 0, 567),
	(1035, 0, 1, 69, 0, 0, 0, 0, 0, 0, 568),
	(1036, 0, 1, 69, 0, 0, 0, 0, 0, 0, 569),
	(1037, 0, 1, 69, 0, 0, 0, 0, 0, 0, 570),
	(1038, 0, 15, 746, 4, 32652, 1, 0, 0, 0, 571),
	(1039, 0, 1, 1, 0, 0, 0, 0, 0, 0, 572),
	(1040, 0, 1, 233, 0, 0, 0, 0, 0, 0, 573),
	(1041, 0, 1, 233, 0, 0, 0, 0, 0, 0, 574),
	(1042, 0, 1, 233, 0, 0, 0, 0, 0, 0, 575),
	(1043, 0, 1, 69, 0, 0, 0, 0, 0, 0, 576),
	(1044, 0, 1, 69, 0, 0, 0, 0, 0, 0, 577),
	(1045, 0, 1, 69, 0, 0, 0, 0, 0, 0, 578),
	(1065, 0, 1, 69, 0, 0, 0, 0, 0, 0, 598),
	(1070, 0, 1, 69, 0, 0, 0, 0, 0, 0, 603),
	(1071, 0, 1, 381, 0, 0, 0, 0, 0, 0, 604),
	(1072, 0, 1, 69, 0, 0, 0, 0, 0, 0, 605),
	(1073, 0, 1, 69, 0, 0, 0, 0, 0, 0, 606),
	(1074, 0, 1, 69, 0, 0, 0, 0, 0, 0, 607),
	(1075, 0, 1, 69, 0, 0, 0, 0, 0, 0, 608),
	(1076, 0, 1, 69, 0, 0, 0, 0, 0, 0, 609),
	(1077, 0, 15, 746, 4, 32651, 1, 0, 0, 0, 610),
	(1078, 0, 1, 16, 0, 0, 0, 0, 0, 0, 611),
	(1079, 0, 15, 746, 4, 32650, 1, 0, 0, 0, 612),
	(1082, 0, 1, 233, 0, 0, 0, 0, 0, 0, 615),
	(1083, 0, 1, 69, 0, 0, 0, 0, 0, 0, 616),
	(1084, 0, 1, 233, 0, 0, 0, 0, 0, 0, 617),
	(1085, 0, 1, 69, 0, 0, 0, 0, 0, 0, 618),
	(1086, 0, 1, 3, 0, 0, 0, 0, 0, 0, 619),
	(1087, 0, 1, 233, 0, 0, 0, 0, 0, 0, 620),
	(1088, 0, 1, 69, 0, 0, 0, 0, 0, 0, 621),
	(1089, 0, 1, 233, 0, 0, 0, 0, 0, 0, 622),
	(1090, 0, 1, 69, 0, 0, 0, 0, 0, 0, 623),
	(1091, 0, 1, 233, 0, 0, 0, 0, 0, 0, 624),
	(1092, 0, 1, 69, 0, 0, 0, 0, 0, 0, 625),
	(1093, 0, 1, 233, 0, 0, 0, 0, 0, 0, 626),
	(1094, 0, 1, 69, 0, 0, 0, 0, 0, 0, 627),
	(1095, 0, 1, 233, 0, 0, 0, 0, 0, 0, 628),
	(1096, 0, 1, 69, 0, 0, 0, 0, 0, 0, 629),
	(1097, 0, 1, 69, 0, 0, 0, 0, 0, 0, 630),
	(1098, 0, 1, 233, 0, 0, 0, 0, 0, 0, 631),
	(1099, 0, 1, 233, 0, 0, 0, 0, 0, 0, 632),
	(1100, 0, 1, 69, 0, 0, 0, 0, 0, 0, 633),
	(1101, 0, 1, 233, 0, 0, 0, 0, 0, 0, 634),
	(1102, 0, 1, 233, 0, 0, 0, 0, 0, 0, 635),
	(1103, 0, 1, 233, 0, 0, 0, 0, 0, 0, 636),
	(1104, 0, 1, 233, 0, 0, 0, 0, 0, 0, 637),
	(1105, 0, 1, 69, 0, 0, 0, 0, 0, 0, 638),
	(1106, 0, 1, 233, 0, 0, 0, 0, 0, 0, 639),
	(1108, 0, 1, 69, 0, 0, 0, 0, 0, 0, 641),
	(1109, 0, 1, 69, 0, 0, 0, 0, 0, 0, 642),
	(1110, 0, 1, 69, 0, 0, 0, 0, 0, 0, 643),
	(1111, 0, 1, 69, 0, 0, 0, 0, 0, 0, 644),
	(1112, 0, 1, 69, 0, 0, 0, 0, 0, 0, 645),
	(1113, 0, 1, 69, 0, 0, 0, 0, 0, 0, 646),
	(1006, 0, 1, 6, 0, 0, 0, 0, 0, 0, 647),
	(1007, 0, 1, 1, 0, 0, 0, 0, 0, 0, 648),
	(1008, 0, 1, 16, 0, 0, 0, 0, 0, 0, 649),
	(1009, 0, 1, 1, 0, 0, 0, 0, 0, 0, 650),
	(1114, 0, 31, 226, 0, 0, 0, 0, 0, 0, 651),
	(1114, 1, 1, 69, 1, 0, 0, 0, 0, 0, 652),
	(1115, 0, 31, 2066, 0, 0, 0, 0, 0, 0, 653),
	(1115, 1, 1, 173, 1, 0, 0, 0, 0, 0, 654),
	(1116, 1, 1, 69, 1, 0, 0, 0, 0, 0, 655),
	(1120, 0, 1, 16, 1, 0, 0, 0, 0, 0, 661),
	(1120, 5, 1, 26, 1, 0, 0, 0, 0, 0, 662),
	(1120, 6, 30, 0, 0, 0, 0, 0, 0, 4.67122, 663),
	(1120, 10, 1, 22, 0, 0, 0, 0, 0, 0, 664),
	(1120, 10, 0, 0, 0, 24439, 0, 0, 0, 0, 665),
	(1121, 1, 0, 0, 0, 24443, 0, 0, 0, 0, 666),
	(1122, 1, 1, 233, 1, 0, 0, 0, 0, 0, 667),
	(1123, 1, 1, 379, 1, 0, 0, 0, 0, 0, 668),
	(1124, 0, 1, 26, 1, 0, 0, 0, 0, 0, 669),
	(1124, 1, 15, 56745, 1, 0, 0, 0, 0, 0, 670),
	(1124, 4, 15, 56745, 1, 0, 0, 0, 0, 0, 671),
	(1125, 1, 32, 21612, 0, 0, 0, 0, 0, 0, 672),
	(1126, 1, 32, 21614, 0, 0, 0, 0, 0, 0, 673),
	(1127, 1, 30, 0, 0, 0, 0, 0, 0, 4.97788, 674),
	(1127, 1, 1, 69, 1, 0, 0, 0, 0, 0, 675),
	(1128, 1, 30, 0, 0, 0, 0, 0, 0, 5.70399, 676),
	(1128, 1, 1, 173, 1, 0, 0, 0, 0, 0, 677),
	(1129, 1, 30, 0, 0, 0, 0, 0, 0, 0.436332, 678),
	(1129, 1, 1, 69, 1, 0, 0, 0, 0, 0, 679),
	(2026160, 0, 30, 0, 0, 0, 0, 0, 0, 0.907571, 684),
	(2026160, 1, 1, 234, 1, 0, 0, 0, 0, 0, 685),
	(2026161, 0, 30, 0, 0, 0, 0, 0, 0, 3.29867, 686),
	(2026161, 1, 1, 234, 1, 0, 0, 0, 0, 0, 687),
	(2026250, 0, 30, 0, 0, 0, 0, 0, 0, 2.33874, 688),
	(2026250, 1, 1, 234, 1, 0, 0, 0, 0, 0, 689),
	(2026251, 0, 30, 0, 0, 0, 0, 0, 0, 0.191986, 690),
	(2026251, 1, 1, 234, 1, 0, 0, 0, 0, 0, 691),
	(2026270, 0, 30, 0, 0, 0, 0, 0, 0, 5.11381, 692),
	(2026270, 1, 1, 234, 1, 0, 0, 0, 0, 0, 693),
	(2026271, 0, 30, 0, 0, 0, 0, 0, 0, 4.79965, 694),
	(2026271, 1, 1, 234, 1, 0, 0, 0, 0, 0, 695),
	(1133, 0, 30, 0, 0, 0, 0, 0, 0, 4.08361, 696),
	(1134, 0, 30, 0, 0, 0, 0, 0, 0, 0.104771, 697),
	(1135, 0, 1, 1, 0, 0, 0, 0, 0, 0, 698),
	(1136, 0, 15, 36804, 4, 21404, 30, 0, 0, 0, 699),
	(1137, 1, 1, 1, 0, 0, 0, 0, 0, 0, 700),
	(1138, 1, 30, 0, 0, 0, 0, 0, 0, 2.79253, 701),
	(1138, 2, 1, 1, 0, 0, 0, 0, 0, 0, 702),
	(1138, 7, 1, 15, 0, 0, 0, 0, 0, 0, 703),
	(1139, 1, 6, 571, 1, 0, 4370.97, -4934.86, 29.1214, 0.982114, 704),
	(1140, 1, 6, 571, 1, 0, 4374.84, -4770.08, 52.848, 1.1487, 705),
	(1141, 1, 6, 571, 1, 0, 4306.51, -4766.24, 56.8766, 0.465818, 706),
	(1142, 1, 6, 571, 1, 0, 4463.83, -4644.89, 84.6203, 2.40181, 707),
	(1143, 1, 6, 571, 1, 0, 4353.19, -4571.79, 118.402, 1.35635, 708),
	(1144, 1, 6, 571, 1, 0, 4131.99, -4889.01, 60.1083, 0.369627, 709),
	(1145, 1, 6, 571, 1, 0, 4051.38, -5111.15, 12.6903, 0.341522, 710),
	(1146, 1, 6, 571, 1, 0, 4182, -4758.6, 71.2506, 6.20304, 711),
	(1147, 1, 6, 571, 1, 0, 3940.79, -4923.88, 81.667, 0.583063, 712),
	(1148, 1, 6, 571, 1, 0, 4137.97, -4969.12, 36.8373, 1.16219, 713),
	(1149, 1, 6, 571, 1, 0, 4116.99, -5024.95, 30.5289, 0.607674, 714),
	(1150, 1, 6, 571, 1, 0, 4388.64, -4820.43, 41.3801, 0.994674, 715),
	(1151, 1, 6, 571, 1, 0, 3859.19, -5204.08, 71.2207, 5.69976, 716),
	(1152, 1, 6, 571, 1, 0, 3879.8, -4989.44, 85.9219, 0.275225, 717),
	(1153, 1, 6, 571, 1, 0, 3922.52, -5267.12, 7.26294, 0.90739, 718),
	(1154, 1, 6, 571, 1, 0, 3863.01, -5340.63, 4.19676, 0.484555, 719),
	(1155, 1, 6, 571, 1, 0, 3707.78, -5226.12, 125.551, 6.2721, 720),
	(1156, 1, 6, 571, 1, 0, 3658.67, -5436.73, 26.487, 0.949674, 721),
	(1157, 1, 6, 571, 1, 0, 3521.14, -5462.94, 168.445, 0.93554, 722),
	(1158, 1, 6, 571, 1, 0, 3632.08, -5536.6, 12.9124, 1.18737, 723),
	(1159, 0, 1, 66, 0, 0, 0, 0, 0, 0, 724),
	(1164, 0, 30, 0, 0, 0, 0, 0, 0, 5.18363, 741),
	(1165, 0, 30, 0, 0, 0, 0, 0, 0, 4.10152, 742),
	(1166, 0, 1, 69, 1, 0, 0, 0, 0, 0, 743),
	(1167, 0, 1, 0, 0, 0, 0, 0, 0, 0, 744),
	(1168, 1, 30, 0, 0, 0, 0, 0, 0, 1.32645, 745),
	(1169, 1, 30, 0, 0, 0, 0, 0, 0, 0.541052, 746),
	(1170, 1, 30, 0, 0, 0, 0, 0, 0, 4.15388, 747),
	(1171, 1, 30, 0, 0, 0, 0, 0, 0, 3.68265, 748),
	(1172, 1, 30, 0, 0, 0, 0, 0, 0, 3.7001, 749),
	(1175, 1, 30, 0, 0, 0, 0, 0, 0, 2.61799, 752),
	(1176, 0, 1, 133, 0, 0, 0, 0, 0, 0, 753),
	(1173, 2, 32, 89, 0, 0, 0, 0, 0, 0, 754),
	(1174, 2, 32, 308, 0, 0, 0, 0, 0, 0, 755),
	(1177, 1, 30, 0, 0, 0, 0, 0, 0, 4.83456, 756),
	(1177, 14, 30, 0, 0, 0, 0, 0, 0, 4.39823, 757),
	(1178, 1, 30, 0, 0, 0, 0, 0, 0, 0.331613, 758),
	(1179, 1, 30, 0, 0, 0, 0, 0, 0, 2.37365, 759),
	(1180, 1, 30, 0, 0, 0, 0, 0, 0, 3.12414, 760),
	(1181, 1, 30, 0, 0, 0, 0, 0, 0, 5.46288, 761),
	(1182, 1, 30, 0, 0, 0, 0, 0, 0, 2.86234, 762),
	(1183, 1, 30, 0, 0, 0, 0, 0, 0, 1.64061, 763),
	(1184, 1, 30, 0, 0, 0, 0, 0, 0, 3.50811, 764),
	(1185, 1, 30, 0, 0, 0, 0, 0, 0, 2.84489, 765),
	(1186, 1, 30, 0, 0, 0, 0, 0, 0, 4.72984, 766),
	(1187, 1, 30, 0, 0, 0, 0, 0, 0, 2.49582, 767),
	(1188, 1, 18, 1000, 0, 0, 0, 0, 0, 0, 768),
	(1189, 0, 0, 0, 0, 36, 0, 0, 0, 0, 769),
	(1190, 1, 30, 0, 0, 0, 0, 0, 0, 5.42797, 770),
	(1191, 1, 30, 0, 0, 0, 0, 0, 0, 1.48353, 771),
	(1192, 1, 30, 0, 0, 0, 0, 0, 0, 5.77704, 772),
	(1193, 0, 1, 38, 0, 0, 0, 0, 0, 0, 773),
	(1193, 1, 16, 6675, 0, 0, 0, 0, 0, 0, 774),
	(1193, 2, 1, 375, 1, 0, 0, 0, 0, 0, 775),
	(1194, 0, 15, 52059, 4, 28387, 30, 0, 0, 0, 776),
	(1195, 0, 1, 30, 0, 0, 0, 0, 0, 3.26776, 777),
	(1196, 1, 30, 0, 0, 0, 0, 0, 0, 5.84679, 778),
	(1197, 1, 30, 0, 0, 0, 0, 0, 0, 1.48722, 779),
	(1198, 0, 15, 45612, 1, 0, 0, 0, 0, 0, 780),
	(1198, 2, 15, 45609, 1, 0, 0, 0, 0, 0, 781),
	(1200, 0, 1, 1, 153, 0, 0, 0, 0, 0, 783),
	(1201, 1, 1, 233, 1, 0, 0, 0, 0, 0, 784),
	(1202, 1, 1, 18, 0, 0, 0, 0, 0, 0, 785),
	(1203, 1, 1, 438, 1, 0, 0, 0, 0, 0, 786),
	(1204, 1, 30, 0, 0, 0, 0, 0, 0, 1.39626, 787),
	(1205, 1, 30, 0, 0, 0, 0, 0, 0, 1.5708, 788),
	(1206, 1, 30, 0, 0, 0, 0, 0, 0, 3.9968, 789),
	(1207, 1, 30, 0, 0, 0, 0, 0, 0, 0.331613, 790),
	(1208, 1, 30, 0, 0, 0, 0, 0, 0, 2.33874, 791),
	(1209, 1, 30, 0, 0, 0, 0, 0, 0, 3.82227, 792),
	(1210, 1, 30, 0, 0, 0, 0, 0, 0, 3.9968, 793),
	(1211, 1, 30, 0, 0, 0, 0, 0, 0, 2.19912, 794),
	(1212, 1, 30, 0, 0, 0, 0, 0, 0, 2.30383, 795),
	(1213, 1, 30, 0, 0, 0, 0, 0, 0, 0.0349066, 796),
	(1214, 1, 30, 0, 0, 0, 0, 0, 0, 4.69494, 797),
	(1215, 1, 30, 0, 0, 0, 0, 0, 0, 2.53073, 798),
	(1216, 1, 30, 0, 0, 0, 0, 0, 0, 3.19395, 799),
	(1501600, 0, 1, 71, 0, 0, 0, 0, 0, 0, 800),
	(1501610, 5, 1, 71, 0, 0, 0, 0, 0, 0, 801),
	(1501620, 10, 1, 71, 0, 0, 0, 0, 0, 0, 802),
	(1501810, 0, 15, 50558, 1, 0, 0, 0, 0, 0, 803),
	(1501820, 5, 15, 50558, 1, 0, 0, 0, 0, 0, 804),
	(1501830, 10, 15, 50558, 1, 0, 0, 0, 0, 0, 805),
	(482, 0, 1, 1, 0, 0, 0, 0, 0, 0, 806),
	(483, 0, 1, 92, 0, 0, 0, 0, 0, 0, 807),
	(484, 0, 1, 11, 0, 0, 0, 0, 0, 0, 808),
	(485, 0, 15, 6668, 1, 0, 0, 0, 0, 0, 809),
	(486, 0, 15, 11542, 1, 0, 0, 0, 0, 0, 810),
	(487, 0, 16, 12845, 2, 0, 0, 0, 0, 0, 811),
	(8319701, 0, 30, 0, 0, 0, 0, 0, 0, 3.33358, 817),
	(8319702, 0, 30, 0, 0, 0, 0, 0, 0, 3.03687, 818),
	(8319501, 0, 30, 0, 0, 0, 0, 0, 0, 2.96706, 819),
	(8319502, 0, 30, 0, 0, 0, 0, 0, 0, 3.26377, 820),
	(683081, 1, 30, 0, 0, 0, 0, 0, 0, 0.191986, 822),
	(683091, 1, 30, 0, 0, 0, 0, 0, 0, 2.32129, 823),
	(686261, 0, 30, 0, 0, 0, 0, 0, 0, 1.27409, 824),
	(682921, 1, 30, 0, 0, 0, 0, 0, 0, 4.72984, 825),
	(682922, 1, 30, 0, 0, 0, 0, 0, 0, 6.0912, 826),
	(682923, 1, 30, 0, 0, 0, 0, 0, 0, 1.81514, 827),
	(682924, 1, 30, 0, 0, 0, 0, 0, 0, 3.56047, 828),
	(682961, 1, 30, 0, 0, 0, 0, 0, 0, 2.37365, 829),
	(682962, 1, 30, 0, 0, 0, 0, 0, 0, 2.16421, 830),
	(682963, 1, 30, 0, 0, 0, 0, 0, 0, 0.349066, 831),
	(682964, 1, 30, 0, 0, 0, 0, 0, 0, 2.16421, 832),
	(682901, 1, 30, 0, 0, 0, 0, 0, 0, 2.80998, 833),
	(682902, 1, 30, 0, 0, 0, 0, 0, 0, 6.02139, 834),
	(682903, 1, 30, 0, 0, 0, 0, 0, 0, 6.16101, 835),
	(682904, 1, 30, 0, 0, 0, 0, 0, 0, 6.00393, 836),
	(684701, 0, 30, 0, 0, 0, 0, 0, 0, 1.41372, 837),
	(684701, 1, 2, 83, 381, 0, 0, 0, 0, 0, 838),
	(684702, 1, 2, 83, 381, 0, 0, 0, 0, 0, 839),
	(684681, 0, 30, 0, 0, 0, 0, 0, 0, 3.83972, 840),
	(684681, 1, 2, 83, 381, 0, 0, 0, 0, 0, 841),
	(684682, 1, 2, 83, 381, 0, 0, 0, 0, 0, 842),
	(684691, 0, 30, 0, 0, 0, 0, 0, 0, 1.5708, 843),
	(684691, 1, 2, 83, 381, 0, 0, 0, 0, 0, 844),
	(684692, 1, 2, 83, 69, 0, 0, 0, 0, 0, 845),
	(1336191, 0, 30, 0, 0, 0, 0, 0, 0, 1.46608, 846),
	(1336191, 1, 2, 83, 69, 0, 0, 0, 0, 0, 847),
	(1336192, 0, 30, 0, 0, 0, 0, 0, 0, 4.63913, 848),
	(1336192, 1, 2, 83, 69, 0, 0, 0, 0, 0, 849),
	(1128651, 0, 30, 0, 0, 0, 0, 0, 0, 2.9147, 850),
	(1128652, 0, 30, 0, 0, 0, 0, 0, 0, 5.20108, 851),
	(1128661, 0, 30, 0, 0, 0, 0, 0, 0, 0.855211, 852),
	(1128662, 0, 30, 0, 0, 0, 0, 0, 0, 0.890118, 853),
	(1128663, 0, 30, 0, 0, 0, 0, 0, 0, 0.0698132, 854),
	(12698101, 0, 14, 52092, 1, 0, 0, 0, 0, 0, 855),
	(12698101, 2, 15, 52098, 1, 0, 0, 0, 0, 0, 856),
	(12698102, 0, 14, 52092, 1, 0, 0, 0, 0, 0, 857),
	(11026001, 0, 30, 0, 0, 0, 0, 0, 0, 3.00197, 858),
	(11026001, 1, 15, 51733, 1, 0, 0, 0, 0, 0, 859),
	(11026002, 1, 15, 51733, 1, 0, 0, 0, 0, 0, 860),
	(11026401, 1, 15, 51733, 1, 0, 0, 0, 0, 0, 861),
	(11026402, 1, 15, 51733, 1, 0, 0, 0, 0, 0, 862),
	(80, 0, 6, 530, 1, 0, 3915.08, 2111.54, 274.422, 0, 880),
	(81, 0, 6, 530, 1, 0, 3887.31, 2258.43, 214.298, 0, 881),
	(82, 0, 6, 530, 1, 0, 3726.48, 1961.26, 249.912, 0, 882),
	(83, 0, 6, 530, 1, 0, 4044.87, 2025.38, 267.544, 0, 883),
	(84, 0, 6, 530, 1, 0, 4148.98, 2042.91, 164.712, 0, 884),
	(85, 0, 6, 530, 1, 0, 3827.96, 1979.83, 275.021, 0, 885),
	(86, 0, 6, 530, 1, 0, 4151.25, 2042.39, 245.592, 0, 886),
	(87, 0, 6, 530, 1, 0, 3957.74, 1894.36, 269.926, 0, 887),
	(88, 0, 6, 530, 1, 0, 3990.15, 1735.37, 270.177, 0, 888),
	(89, 0, 6, 530, 1, 0, 4001.01, 1683.55, 137.226, 0, 889),
	(90, 0, 6, 530, 1, 0, 3696.55, 1954.49, 134.377, 0, 890),
	(488, 3, 15, 63295, 4, 33575, 30, 0, 0, 0, 891),
	(489, 3, 15, 63292, 4, 33575, 30, 0, 0, 0, 892),
	(490, 3, 15, 63294, 4, 33575, 30, 0, 0, 0, 893),
	(12556600, 2, 15, 68442, 1, 0, 0, 0, 0, 0, 912),
	(12556600, 10, 1, 1, 0, 0, 0, 0, 0, 0, 913),
	(12556600, 18, 14, 68442, 1, 0, 0, 0, 0, 0, 914),
	(11130700, 2, 1, 69, 1, 0, 0, 0, 0, 0, 916),
	(11130700, 17, 1, 0, 1, 0, 0, 0, 0, 0, 917),
	(8014900, 1, 35, 1, 5, 0, 0, 0, 0, 0, 920),
	(8014900, 20, 35, 2, 0, 801490, 0, 0, 0, 0, 921),
	(8025100, 1, 35, 1, 5, 0, 0, 0, 0, 0, 922),
	(8025100, 20, 35, 2, 0, 802510, 0, 0, 0, 0, 923),
	(4429600, 3, 32, 308, 0, 0, 0, 0, 0, 0, 924),
	(4429601, 3, 1, 234, 1, 0, 0, 0, 0, 0, 925),
	(4429601, 97, 1, 0, 1, 0, 0, 0, 0, 0, 926),
	(4429601, 100, 32, 89, 0, 0, 0, 0, 0, 0, 927),
	(4429602, 2, 32, 89, 0, 0, 0, 0, 0, 0, 928),
	(4429603, 3, 1, 234, 1, 0, 0, 0, 0, 0, 929),
	(4429603, 97, 1, 0, 1, 0, 0, 0, 0, 0, 930),
	(4430300, 3, 1, 69, 1, 0, 0, 0, 0, 0, 931),
	(4430300, 87, 1, 0, 1, 0, 0, 0, 0, 0, 932),
	(4430301, 3, 1, 16, 0, 0, 0, 0, 0, 0, 933),
	(1377500, 3, 1, 69, 1, 0, 0, 0, 0, 0, 934),
	(1377500, 235, 1, 0, 1, 0, 0, 0, 0, 0, 935),
	(11730800, 1, 1, 36, 0, 0, 0, 0, 0, 0, 937),
	(188701, 5, 1, 26, 1, 0, 0, 0, 0, 0, 906),
	(188701, 2, 0, 2, 0, 4286, 0, 0, 0, 0, 905),
	(188701, 2, 1, 69, 1, 0, 0, 0, 0, 0, 904),
	(188700, 2, 1, 16, 0, 0, 0, 0, 0, 0, 903),
	(188700, 2, 0, 2, 0, 4285, 0, 0, 0, 0, 902),
	(457490, 11, 1, 1, 0, 0, 0, 0, 0, 0, 45749),
	(849301, 0, 16, 6596, 2, 0, 0, 0, 0, 0, 201194),
	(849910, 0, 16, 6596, 2, 0, 0, 0, 0, 0, 201200),
	(2, 3, 1, 7, 0, 0, 0, 0, 0, 0, 2),
	(188702, 2, 0, 0, 0, 4287, 0, 0, 0, 0, 907),
	(5, 0, 0, 0, 0, 1119, 0, 0, 0, 0, 7),
	(6, 1, 0, 0, 0, 16099, 0, 0, 0, 0, 16),
	(6, 1, 1, 6, 0, 0, 0, 0, 0, 0, 17),
	(6, 7, 0, 0, 0, 16100, 0, 0, 0, 0, 18),
	(6, 7, 1, 1, 0, 0, 0, 0, 0, 0, 19),
	(8, 4, 0, 0, 0, 19593, 0, 0, 0, 0, 9),
	(7, 4, 0, 0, 0, 19592, 0, 0, 0, 0, 8);
/*!40000 ALTER TABLE `waypoint_scripts` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
