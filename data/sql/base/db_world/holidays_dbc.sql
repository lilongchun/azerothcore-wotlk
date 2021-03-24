/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `holidays_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `holidays_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Duration_1` INT NOT NULL DEFAULT 0,
  `Duration_2` INT NOT NULL DEFAULT 0,
  `Duration_3` INT NOT NULL DEFAULT 0,
  `Duration_4` INT NOT NULL DEFAULT 0,
  `Duration_5` INT NOT NULL DEFAULT 0,
  `Duration_6` INT NOT NULL DEFAULT 0,
  `Duration_7` INT NOT NULL DEFAULT 0,
  `Duration_8` INT NOT NULL DEFAULT 0,
  `Duration_9` INT NOT NULL DEFAULT 0,
  `Duration_10` INT NOT NULL DEFAULT 0,
  `Date_1` INT NOT NULL DEFAULT 0,
  `Date_2` INT NOT NULL DEFAULT 0,
  `Date_3` INT NOT NULL DEFAULT 0,
  `Date_4` INT NOT NULL DEFAULT 0,
  `Date_5` INT NOT NULL DEFAULT 0,
  `Date_6` INT NOT NULL DEFAULT 0,
  `Date_7` INT NOT NULL DEFAULT 0,
  `Date_8` INT NOT NULL DEFAULT 0,
  `Date_9` INT NOT NULL DEFAULT 0,
  `Date_10` INT NOT NULL DEFAULT 0,
  `Date_11` INT NOT NULL DEFAULT 0,
  `Date_12` INT NOT NULL DEFAULT 0,
  `Date_13` INT NOT NULL DEFAULT 0,
  `Date_14` INT NOT NULL DEFAULT 0,
  `Date_15` INT NOT NULL DEFAULT 0,
  `Date_16` INT NOT NULL DEFAULT 0,
  `Date_17` INT NOT NULL DEFAULT 0,
  `Date_18` INT NOT NULL DEFAULT 0,
  `Date_19` INT NOT NULL DEFAULT 0,
  `Date_20` INT NOT NULL DEFAULT 0,
  `Date_21` INT NOT NULL DEFAULT 0,
  `Date_22` INT NOT NULL DEFAULT 0,
  `Date_23` INT NOT NULL DEFAULT 0,
  `Date_24` INT NOT NULL DEFAULT 0,
  `Date_25` INT NOT NULL DEFAULT 0,
  `Date_26` INT NOT NULL DEFAULT 0,
  `Region` INT NOT NULL DEFAULT 0,
  `Looping` INT NOT NULL DEFAULT 0,
  `CalendarFlags_1` INT NOT NULL DEFAULT 0,
  `CalendarFlags_2` INT NOT NULL DEFAULT 0,
  `CalendarFlags_3` INT NOT NULL DEFAULT 0,
  `CalendarFlags_4` INT NOT NULL DEFAULT 0,
  `CalendarFlags_5` INT NOT NULL DEFAULT 0,
  `CalendarFlags_6` INT NOT NULL DEFAULT 0,
  `CalendarFlags_7` INT NOT NULL DEFAULT 0,
  `CalendarFlags_8` INT NOT NULL DEFAULT 0,
  `CalendarFlags_9` INT NOT NULL DEFAULT 0,
  `CalendarFlags_10` INT NOT NULL DEFAULT 0,
  `HolidayNameID` INT NOT NULL DEFAULT 0,
  `HolidayDescriptionID` INT NOT NULL DEFAULT 0,
  `TextureFilename` varchar(100) DEFAULT NULL,
  `Priority` INT NOT NULL DEFAULT 0,
  `CalendarFilterType` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `holidays_dbc` WRITE;
/*!40000 ALTER TABLE `holidays_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `holidays_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

