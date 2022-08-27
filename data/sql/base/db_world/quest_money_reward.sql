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

-- Dumpar struktur för tabell acore_world.quest_money_reward
DROP TABLE IF EXISTS `quest_money_reward`;
CREATE TABLE IF NOT EXISTS `quest_money_reward` (
  `Level` int NOT NULL DEFAULT '0',
  `Money0` int NOT NULL DEFAULT '0',
  `Money1` int NOT NULL DEFAULT '0',
  `Money2` int NOT NULL DEFAULT '0',
  `Money3` int NOT NULL DEFAULT '0',
  `Money4` int NOT NULL DEFAULT '0',
  `Money5` int NOT NULL DEFAULT '0',
  `Money6` int NOT NULL DEFAULT '0',
  `Money7` int NOT NULL DEFAULT '0',
  `Money8` int NOT NULL DEFAULT '0',
  `Money9` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.quest_money_reward: 80 rows
DELETE FROM `quest_money_reward`;
/*!40000 ALTER TABLE `quest_money_reward` DISABLE KEYS */;
INSERT INTO `quest_money_reward` (`Level`, `Money0`, `Money1`, `Money2`, `Money3`, `Money4`, `Money5`, `Money6`, `Money7`, `Money8`, `Money9`) VALUES
	(1, 0, 2, 4, 8, 12, 15, 30, 50, 75, 0),
	(2, 0, 3, 8, 17, 25, 35, 65, 100, 125, 0),
	(3, 0, 5, 13, 25, 40, 50, 100, 150, 200, 0),
	(4, 0, 7, 20, 35, 55, 75, 150, 225, 300, 0),
	(5, 0, 10, 25, 50, 75, 100, 200, 300, 400, 0),
	(6, 0, 13, 35, 65, 100, 125, 250, 400, 500, 0),
	(7, 0, 17, 45, 85, 125, 175, 350, 500, 700, 0),
	(8, 0, 22, 55, 110, 175, 225, 450, 700, 900, 0),
	(9, 0, 30, 70, 150, 200, 300, 600, 900, 1200, 0),
	(10, 0, 35, 85, 175, 250, 350, 700, 1000, 1300, 0),
	(11, 0, 40, 100, 200, 300, 400, 800, 1300, 1700, 0),
	(12, 0, 50, 125, 250, 350, 500, 1000, 1500, 2000, 0),
	(13, 0, 55, 150, 300, 400, 600, 1100, 1700, 2300, 0),
	(14, 0, 65, 150, 300, 500, 600, 1300, 2000, 2700, 0),
	(15, 0, 70, 175, 350, 500, 700, 1400, 2000, 2700, 0),
	(16, 0, 80, 200, 400, 600, 800, 1600, 2500, 3300, 0),
	(17, 0, 90, 225, 450, 700, 900, 1800, 2500, 3300, 0),
	(18, 0, 100, 250, 500, 700, 1000, 2000, 3000, 4000, 0),
	(19, 0, 100, 250, 500, 800, 1100, 2000, 3000, 4000, 0),
	(20, 0, 125, 300, 600, 900, 1200, 2500, 3500, 4700, 0),
	(21, 0, 125, 350, 700, 1000, 1300, 2500, 4000, 5300, 0),
	(22, 0, 150, 350, 700, 1100, 1400, 3000, 4500, 6000, 0),
	(23, 0, 150, 400, 800, 1200, 1500, 3000, 4500, 6000, 0),
	(24, 0, 175, 400, 800, 1300, 1700, 3500, 5000, 6700, 0),
	(25, 0, 175, 500, 900, 1400, 1800, 3500, 5500, 7300, 0),
	(26, 0, 200, 500, 1000, 1500, 2000, 4000, 6000, 8000, 0),
	(27, 0, 225, 600, 1100, 1700, 2200, 4500, 6500, 8700, 0),
	(28, 0, 250, 600, 1200, 1800, 2500, 5000, 7000, 9300, 0),
	(29, 0, 250, 600, 1300, 1900, 2500, 5000, 7500, 10000, 0),
	(30, 0, 250, 700, 1400, 2100, 2500, 5500, 8000, 10700, 0),
	(31, 0, 300, 700, 1500, 2200, 3000, 6000, 9000, 12000, 0),
	(32, 0, 300, 800, 1600, 2500, 3000, 6500, 9500, 12700, 0),
	(33, 0, 350, 800, 1700, 2500, 3500, 6500, 10000, 13300, 0),
	(34, 0, 350, 900, 1700, 2500, 3500, 7000, 10500, 14000, 0),
	(35, 0, 350, 900, 1800, 2500, 3500, 7500, 11000, 14700, 0),
	(36, 0, 400, 1000, 2000, 3000, 4000, 7500, 11500, 15300, 0),
	(37, 0, 400, 1000, 2000, 3000, 4000, 8000, 12000, 16000, 0),
	(38, 0, 400, 1100, 2000, 3000, 4500, 8500, 13000, 17300, 0),
	(39, 0, 500, 1100, 2500, 3500, 4500, 9000, 14000, 18700, 0),
	(40, 0, 500, 1200, 2500, 3500, 5000, 10000, 15000, 20000, 0),
	(41, 0, 500, 1300, 2500, 4000, 5500, 11000, 16000, 21300, 0),
	(42, 0, 600, 1400, 3000, 4500, 5500, 11500, 17000, 22700, 0),
	(43, 0, 600, 1500, 3000, 4500, 6000, 12000, 18000, 24000, 0),
	(44, 0, 600, 1600, 3000, 4500, 6500, 12500, 19000, 25300, 0),
	(45, 0, 600, 1600, 3000, 5000, 6500, 13000, 19500, 26000, 0),
	(46, 0, 700, 1700, 3500, 5000, 6500, 13000, 20000, 26700, 0),
	(47, 0, 700, 1700, 3500, 5000, 7000, 13500, 20500, 27300, 0),
	(48, 0, 700, 1700, 3500, 5000, 7000, 14000, 21000, 28000, 0),
	(49, 0, 700, 1800, 3500, 5500, 7000, 14000, 21000, 28000, 0),
	(50, 0, 700, 1800, 3500, 5500, 7500, 14500, 22000, 29300, 0),
	(51, 0, 800, 1900, 4000, 5500, 7500, 15000, 22500, 30000, 0),
	(52, 0, 800, 1900, 4000, 6000, 7500, 15500, 23000, 30700, 0),
	(53, 0, 800, 2000, 4000, 6000, 8000, 16000, 24000, 32000, 0),
	(54, 0, 800, 2000, 4000, 6000, 8000, 16500, 24500, 32700, 0),
	(55, 0, 800, 2100, 4000, 6000, 8500, 16500, 25000, 33300, 0),
	(56, 0, 800, 2100, 4000, 6500, 8500, 17000, 25500, 34000, 0),
	(57, 0, 900, 2200, 4500, 6500, 8500, 17000, 26000, 34700, 0),
	(58, 0, 900, 2200, 4500, 6500, 9000, 17500, 26500, 35300, 0),
	(59, 0, 900, 2200, 4500, 6500, 9000, 18000, 26500, 35300, 0),
	(60, 0, 900, 2300, 4500, 7000, 9000, 18000, 27000, 36000, 0),
	(61, 0, 2000, 5200, 10000, 16000, 20000, 40000, 60000, 80000, 0),
	(62, 0, 2800, 7000, 14000, 21000, 27000, 54000, 81000, 108000, 0),
	(63, 0, 3000, 7400, 15000, 23000, 29000, 58000, 87000, 116000, 0),
	(64, 0, 3200, 8000, 16000, 24000, 31000, 62000, 93000, 124000, 0),
	(65, 0, 3400, 8400, 17000, 26000, 33000, 66000, 99000, 132000, 0),
	(66, 0, 3600, 9000, 18000, 27000, 35000, 70000, 105000, 140000, 0),
	(67, 0, 3800, 9400, 19000, 29000, 37000, 74000, 111000, 148000, 0),
	(68, 0, 4000, 10000, 20000, 30000, 39000, 78000, 117000, 156000, 0),
	(69, 0, 4200, 10400, 21000, 32000, 41000, 82000, 123000, 164000, 0),
	(70, 0, 4400, 11200, 22000, 34000, 44000, 88000, 132000, 176000, 0),
	(71, 0, 4800, 12000, 24000, 37000, 47000, 94000, 141000, 188000, 0),
	(72, 0, 5000, 12800, 25000, 39000, 50000, 100000, 150000, 200000, 0),
	(73, 0, 5400, 13600, 27000, 41000, 53000, 106000, 159000, 212000, 0),
	(74, 0, 5600, 14400, 28000, 44000, 56000, 112000, 168000, 224000, 0),
	(75, 0, 6000, 15000, 30000, 46000, 59000, 118000, 177000, 236000, 0),
	(76, 0, 6200, 15800, 31000, 48000, 62000, 124000, 186000, 248000, 0),
	(77, 0, 6600, 16600, 33000, 51000, 65000, 130000, 195000, 260000, 0),
	(78, 0, 6800, 17400, 34000, 53000, 68000, 136000, 204000, 272000, 0),
	(79, 0, 7200, 18200, 36000, 55000, 71000, 142000, 213000, 284000, 0),
	(80, 0, 7400, 19000, 37000, 58000, 74000, 148000, 222000, 296000, 0);
/*!40000 ALTER TABLE `quest_money_reward` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
