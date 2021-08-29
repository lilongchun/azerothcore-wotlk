/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_banned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_banned` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `bandate` INT unsigned NOT NULL DEFAULT 0,
  `unbandate` INT unsigned NOT NULL DEFAULT 0,
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` TINYINT unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`guid`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Ban List';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_banned` WRITE;
/*!40000 ALTER TABLE `character_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_banned` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

