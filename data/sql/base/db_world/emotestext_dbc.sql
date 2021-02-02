/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `emotestext_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emotestext_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `Name` varchar(100) DEFAULT NULL,
  `EmoteID` int(11) NOT NULL DEFAULT 0,
  `EmoteText_1` int(11) NOT NULL DEFAULT 0,
  `EmoteText_2` int(11) NOT NULL DEFAULT 0,
  `EmoteText_3` int(11) NOT NULL DEFAULT 0,
  `EmoteText_4` int(11) NOT NULL DEFAULT 0,
  `EmoteText_5` int(11) NOT NULL DEFAULT 0,
  `EmoteText_6` int(11) NOT NULL DEFAULT 0,
  `EmoteText_7` int(11) NOT NULL DEFAULT 0,
  `EmoteText_8` int(11) NOT NULL DEFAULT 0,
  `EmoteText_9` int(11) NOT NULL DEFAULT 0,
  `EmoteText_10` int(11) NOT NULL DEFAULT 0,
  `EmoteText_11` int(11) NOT NULL DEFAULT 0,
  `EmoteText_12` int(11) NOT NULL DEFAULT 0,
  `EmoteText_13` int(11) NOT NULL DEFAULT 0,
  `EmoteText_14` int(11) NOT NULL DEFAULT 0,
  `EmoteText_15` int(11) NOT NULL DEFAULT 0,
  `EmoteText_16` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `emotestext_dbc` WRITE;
/*!40000 ALTER TABLE `emotestext_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `emotestext_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

