/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `skilllineability_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `skilllineability_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `SkillLine` INT NOT NULL DEFAULT 0,
  `Spell` INT NOT NULL DEFAULT 0,
  `RaceMask` INT NOT NULL DEFAULT 0,
  `ClassMask` INT NOT NULL DEFAULT 0,
  `MinSkillLineRank` INT NOT NULL DEFAULT 0,
  `SupercededBySpell` INT NOT NULL DEFAULT 0,
  `AcquireMethod` INT NOT NULL DEFAULT 0,
  `TrivialSkillLineRankHigh` INT NOT NULL DEFAULT 0,
  `TrivialSkillLineRankLow` INT NOT NULL DEFAULT 0,
  `CharacterPoints_1` INT NOT NULL DEFAULT 0,
  `CharacterPoints_2` INT NOT NULL DEFAULT 0,
  `TradeSkillCategoryID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `skilllineability_dbc` WRITE;
/*!40000 ALTER TABLE `skilllineability_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `skilllineability_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

