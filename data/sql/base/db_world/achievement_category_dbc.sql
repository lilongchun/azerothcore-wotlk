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

-- Dumping structure for table acore_world.achievement_category_dbc
DROP TABLE IF EXISTS `achievement_category_dbc`;
CREATE TABLE IF NOT EXISTS `achievement_category_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Parent` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Name_Lang_esES` varchar(100) DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Ui_Order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table acore_world.achievement_category_dbc: 0 rows
DELETE FROM `achievement_category_dbc`;
/*!40000 ALTER TABLE `achievement_category_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `achievement_category_dbc` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
