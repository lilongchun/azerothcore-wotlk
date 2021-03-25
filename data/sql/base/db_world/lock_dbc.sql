/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `lock_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `lock_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Type_1` INT NOT NULL DEFAULT 0,
  `Type_2` INT NOT NULL DEFAULT 0,
  `Type_3` INT NOT NULL DEFAULT 0,
  `Type_4` INT NOT NULL DEFAULT 0,
  `Type_5` INT NOT NULL DEFAULT 0,
  `Type_6` INT NOT NULL DEFAULT 0,
  `Type_7` INT NOT NULL DEFAULT 0,
  `Type_8` INT NOT NULL DEFAULT 0,
  `Index_1` INT NOT NULL DEFAULT 0,
  `Index_2` INT NOT NULL DEFAULT 0,
  `Index_3` INT NOT NULL DEFAULT 0,
  `Index_4` INT NOT NULL DEFAULT 0,
  `Index_5` INT NOT NULL DEFAULT 0,
  `Index_6` INT NOT NULL DEFAULT 0,
  `Index_7` INT NOT NULL DEFAULT 0,
  `Index_8` INT NOT NULL DEFAULT 0,
  `Skill_1` INT NOT NULL DEFAULT 0,
  `Skill_2` INT NOT NULL DEFAULT 0,
  `Skill_3` INT NOT NULL DEFAULT 0,
  `Skill_4` INT NOT NULL DEFAULT 0,
  `Skill_5` INT NOT NULL DEFAULT 0,
  `Skill_6` INT NOT NULL DEFAULT 0,
  `Skill_7` INT NOT NULL DEFAULT 0,
  `Skill_8` INT NOT NULL DEFAULT 0,
  `Action_1` INT NOT NULL DEFAULT 0,
  `Action_2` INT NOT NULL DEFAULT 0,
  `Action_3` INT NOT NULL DEFAULT 0,
  `Action_4` INT NOT NULL DEFAULT 0,
  `Action_5` INT NOT NULL DEFAULT 0,
  `Action_6` INT NOT NULL DEFAULT 0,
  `Action_7` INT NOT NULL DEFAULT 0,
  `Action_8` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lock_dbc` WRITE;
/*!40000 ALTER TABLE `lock_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `lock_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

