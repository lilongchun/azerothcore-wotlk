/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `log_arena_memberstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `log_arena_memberstats` 
(
  `fight_id` INT unsigned NOT NULL,
  `member_id` TINYINT unsigned NOT NULL,
  `name` char(20) NOT NULL,
  `guid` INT unsigned NOT NULL,
  `team` INT unsigned NOT NULL,
  `account` INT unsigned NOT NULL,
  `ip` char(15) NOT NULL,
  `damage` INT unsigned NOT NULL,
  `heal` INT unsigned NOT NULL,
  `kblows` INT unsigned NOT NULL,
  PRIMARY KEY (`fight_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log_arena_memberstats` WRITE;
/*!40000 ALTER TABLE `log_arena_memberstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_arena_memberstats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

