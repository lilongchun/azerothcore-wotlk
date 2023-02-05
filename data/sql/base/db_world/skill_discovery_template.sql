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

-- Dumping structure for table acore_world.skill_discovery_template
DROP TABLE IF EXISTS `skill_discovery_template`;
CREATE TABLE IF NOT EXISTS `skill_discovery_template` (
  `spellId` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the discoverable spell',
  `reqSpell` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'spell requirement',
  `reqSkillValue` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'skill points requirement',
  `chance` float NOT NULL DEFAULT '0' COMMENT 'chance to discover',
  PRIMARY KEY (`spellId`,`reqSpell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Skill Discovery System';

-- Dumping data for table acore_world.skill_discovery_template: 347 rows
DELETE FROM `skill_discovery_template`;
/*!40000 ALTER TABLE `skill_discovery_template` DISABLE KEYS */;
INSERT INTO `skill_discovery_template` (`spellId`, `reqSpell`, `reqSkillValue`, `chance`) VALUES
	(28580, 0, 0, 0.1),
	(28581, 0, 0, 0.1),
	(28582, 0, 0, 0.1),
	(28583, 0, 0, 0.1),
	(28584, 0, 0, 0.1),
	(28585, 0, 0, 0.1),
	(28586, 0, 0, 0.1),
	(28587, 0, 0, 0.1),
	(28588, 0, 0, 0.1),
	(28589, 0, 0, 0.1),
	(28590, 0, 0, 0.1),
	(28591, 0, 0, 0.1),
	(41458, 28575, 0, 30),
	(41500, 28571, 0, 30),
	(41501, 28572, 0, 30),
	(41502, 28573, 0, 30),
	(41503, 28576, 0, 30),
	(53771, 60350, 400, 50),
	(53773, 60350, 400, 50),
	(53774, 60350, 400, 50),
	(53775, 60350, 400, 50),
	(53776, 60350, 400, 50),
	(53777, 60350, 400, 50),
	(53779, 60350, 400, 50),
	(53780, 60350, 400, 50),
	(53781, 60350, 400, 50),
	(53782, 60350, 400, 50),
	(53783, 60350, 400, 50),
	(53784, 60350, 400, 50),
	(53895, 60893, 400, 100),
	(53904, 60893, 400, 100),
	(54220, 60893, 400, 100),
	(54221, 60893, 400, 100),
	(54222, 60893, 400, 100),
	(56519, 60893, 400, 100),
	(56944, 61177, 385, 100),
	(56944, 61756, 0, 100),
	(56946, 61177, 385, 100),
	(56946, 61756, 0, 100),
	(56947, 61177, 385, 100),
	(56947, 61756, 0, 100),
	(56949, 61177, 385, 100),
	(56949, 61756, 0, 100),
	(56950, 61177, 385, 100),
	(56950, 61756, 0, 100),
	(56954, 61177, 385, 100),
	(56954, 61756, 0, 100),
	(56958, 61177, 385, 100),
	(56958, 61756, 0, 100),
	(56960, 61177, 385, 100),
	(56960, 61756, 0, 100),
	(56965, 61288, 350, 100),
	(56975, 61177, 385, 100),
	(56975, 61756, 0, 100),
	(56977, 61177, 385, 100),
	(56977, 61756, 0, 100),
	(56980, 61177, 385, 100),
	(56980, 61756, 0, 100),
	(56983, 61177, 385, 100),
	(56983, 61756, 0, 100),
	(56986, 61177, 385, 100),
	(56986, 61756, 0, 100),
	(56987, 61177, 385, 100),
	(56987, 61756, 0, 100),
	(56988, 61177, 385, 100),
	(56988, 61756, 0, 100),
	(56989, 61177, 385, 100),
	(56989, 61756, 0, 100),
	(56990, 61288, 350, 100),
	(56996, 61177, 385, 100),
	(56996, 61756, 0, 100),
	(56998, 61177, 385, 100),
	(56998, 61756, 0, 100),
	(56999, 61177, 385, 100),
	(56999, 61756, 0, 100),
	(57006, 61177, 385, 100),
	(57006, 61756, 0, 100),
	(57010, 61177, 385, 100),
	(57010, 61756, 0, 100),
	(57011, 61177, 385, 100),
	(57011, 61756, 0, 100),
	(57012, 61177, 385, 100),
	(57012, 61756, 0, 100),
	(57013, 61177, 385, 100),
	(57013, 61756, 0, 100),
	(57014, 61177, 385, 100),
	(57014, 61756, 0, 100),
	(57019, 61177, 385, 100),
	(57019, 61756, 0, 100),
	(57021, 61177, 385, 100),
	(57021, 61756, 0, 100),
	(57028, 61177, 385, 100),
	(57028, 61756, 0, 100),
	(57034, 61177, 385, 100),
	(57034, 61756, 0, 100),
	(57035, 61177, 385, 100),
	(57035, 61756, 0, 100),
	(57036, 61177, 385, 100),
	(57036, 61756, 0, 100),
	(57112, 61177, 385, 100),
	(57112, 61756, 0, 100),
	(57115, 61177, 385, 100),
	(57115, 61756, 0, 100),
	(57116, 61177, 385, 100),
	(57116, 61756, 0, 100),
	(57117, 61177, 385, 100),
	(57117, 61756, 0, 100),
	(57124, 61177, 385, 100),
	(57124, 61756, 0, 100),
	(57126, 61177, 385, 100),
	(57126, 61756, 0, 100),
	(57127, 61177, 385, 100),
	(57127, 61756, 0, 100),
	(57128, 61177, 385, 100),
	(57128, 61756, 0, 100),
	(57130, 61177, 385, 100),
	(57130, 61756, 0, 100),
	(57152, 61177, 385, 100),
	(57152, 61756, 0, 100),
	(57153, 61177, 385, 100),
	(57153, 61756, 0, 100),
	(57155, 61177, 385, 100),
	(57155, 61756, 0, 100),
	(57159, 61177, 385, 100),
	(57159, 61756, 0, 100),
	(57160, 61177, 385, 100),
	(57160, 61756, 0, 100),
	(57164, 61177, 385, 100),
	(57164, 61756, 0, 100),
	(57166, 61177, 385, 100),
	(57166, 61756, 0, 100),
	(57169, 61177, 385, 100),
	(57169, 61756, 0, 100),
	(57170, 61177, 385, 100),
	(57170, 61756, 0, 100),
	(57181, 61177, 385, 100),
	(57181, 61756, 0, 100),
	(57189, 61177, 385, 100),
	(57189, 61756, 0, 100),
	(57190, 61177, 385, 100),
	(57190, 61756, 0, 100),
	(57191, 61177, 385, 100),
	(57191, 61756, 0, 100),
	(57193, 61177, 385, 100),
	(57193, 61756, 0, 100),
	(57195, 61177, 385, 100),
	(57195, 61756, 0, 100),
	(57198, 61177, 385, 100),
	(57198, 61756, 0, 100),
	(57199, 61177, 385, 100),
	(57199, 61756, 0, 100),
	(57202, 61177, 385, 100),
	(57202, 61756, 0, 100),
	(57207, 61177, 385, 100),
	(57207, 61756, 0, 100),
	(57208, 61177, 385, 100),
	(57208, 61756, 0, 100),
	(57209, 61288, 325, 100),
	(57211, 61177, 385, 100),
	(57211, 61756, 0, 100),
	(57212, 61177, 385, 100),
	(57212, 61756, 0, 100),
	(57214, 61177, 385, 100),
	(57214, 61756, 0, 100),
	(57215, 61288, 300, 100),
	(57217, 61288, 325, 100),
	(57218, 61177, 385, 100),
	(57218, 61756, 0, 100),
	(57220, 61177, 385, 100),
	(57220, 61756, 0, 100),
	(57223, 61177, 385, 100),
	(57223, 61756, 0, 100),
	(57225, 61177, 385, 100),
	(57225, 61756, 0, 100),
	(57228, 61288, 300, 100),
	(57229, 61288, 300, 100),
	(57230, 61288, 300, 100),
	(57232, 61177, 385, 100),
	(57232, 61756, 0, 100),
	(57233, 61177, 385, 100),
	(57233, 61756, 0, 100),
	(57234, 61177, 385, 100),
	(57234, 61756, 0, 100),
	(57235, 61177, 385, 100),
	(57235, 61756, 0, 100),
	(57237, 61177, 385, 100),
	(57237, 61756, 0, 100),
	(57243, 61177, 385, 100),
	(57243, 61756, 0, 100),
	(57247, 61177, 385, 100),
	(57247, 61756, 0, 100),
	(57248, 61177, 385, 100),
	(57248, 61756, 0, 100),
	(57250, 61177, 385, 100),
	(57250, 61756, 0, 100),
	(57253, 61288, 350, 100),
	(57258, 61177, 385, 100),
	(57258, 61756, 0, 100),
	(57260, 61177, 385, 100),
	(57260, 61756, 0, 100),
	(57261, 61177, 385, 100),
	(57261, 61756, 0, 100),
	(57263, 61177, 385, 100),
	(57263, 61756, 0, 100),
	(57264, 61177, 385, 100),
	(57264, 61756, 0, 100),
	(57267, 61177, 385, 100),
	(57267, 61756, 0, 100),
	(57268, 61177, 385, 100),
	(57268, 61756, 0, 100),
	(57273, 61177, 385, 100),
	(57273, 61756, 0, 100),
	(57276, 61177, 385, 100),
	(57276, 61756, 0, 100),
	(57719, 61177, 385, 100),
	(57719, 61756, 0, 100),
	(58286, 61288, 100, 100),
	(58287, 61288, 150, 100),
	(58288, 61288, 100, 100),
	(58289, 61288, 75, 100),
	(58296, 61288, 75, 100),
	(58297, 61288, 200, 100),
	(58298, 61288, 75, 100),
	(58299, 61288, 75, 100),
	(58300, 61288, 75, 100),
	(58301, 61288, 75, 100),
	(58302, 61288, 150, 100),
	(58303, 61288, 75, 100),
	(58305, 61288, 100, 100),
	(58306, 61288, 75, 100),
	(58307, 61288, 125, 100),
	(58308, 61288, 75, 100),
	(58310, 61288, 75, 100),
	(58311, 61288, 100, 100),
	(58312, 61288, 75, 100),
	(58313, 61288, 75, 100),
	(58314, 61288, 75, 100),
	(58315, 61288, 100, 100),
	(58316, 61288, 150, 100),
	(58317, 61288, 75, 100),
	(58318, 61288, 75, 100),
	(58319, 61288, 175, 100),
	(58320, 61288, 100, 100),
	(58321, 61288, 150, 100),
	(58322, 61177, 385, 100),
	(58322, 61288, 350, 100),
	(58322, 61756, 0, 100),
	(58323, 61288, 75, 100),
	(58324, 61288, 125, 100),
	(58325, 61288, 100, 100),
	(58326, 61288, 75, 100),
	(58327, 61288, 200, 100),
	(58328, 61288, 125, 100),
	(58329, 61288, 150, 100),
	(58330, 61288, 150, 100),
	(58331, 61288, 125, 100),
	(58332, 61288, 100, 100),
	(58333, 61288, 150, 100),
	(58336, 61288, 100, 100),
	(58337, 61288, 75, 100),
	(58338, 61288, 150, 100),
	(58339, 61288, 150, 100),
	(58340, 61288, 125, 100),
	(58341, 61177, 385, 100),
	(58341, 61288, 350, 100),
	(58341, 61756, 0, 100),
	(58342, 61288, 75, 100),
	(58343, 61288, 75, 100),
	(58344, 61288, 75, 100),
	(58345, 61288, 100, 100),
	(58346, 61288, 75, 100),
	(58347, 61288, 325, 100),
	(59315, 61288, 150, 100),
	(59326, 61288, 100, 100),
	(59559, 61177, 385, 100),
	(59559, 61756, 0, 100),
	(59560, 61177, 385, 100),
	(59560, 61756, 0, 100),
	(59561, 61177, 385, 100),
	(59561, 61756, 0, 100),
	(60354, 60893, 400, 100),
	(60355, 60893, 400, 100),
	(60356, 60893, 400, 100),
	(60357, 60893, 400, 100),
	(60365, 60893, 400, 100),
	(60366, 60893, 400, 100),
	(61677, 61177, 385, 100),
	(61677, 61756, 0, 100),
	(62410, 60893, 400, 100),
	(64246, 64323, 0, 100),
	(64247, 64323, 0, 100),
	(64248, 64323, 0, 100),
	(64249, 64323, 0, 100),
	(64250, 64323, 0, 100),
	(64251, 64323, 0, 100),
	(64252, 64323, 0, 100),
	(64253, 64323, 0, 100),
	(64254, 64323, 0, 100),
	(64255, 64323, 0, 100),
	(64256, 64323, 0, 100),
	(64257, 64323, 0, 100),
	(64268, 64323, 0, 100),
	(64270, 64323, 0, 100),
	(64271, 64323, 0, 100),
	(64273, 64323, 0, 100),
	(64274, 64323, 0, 100),
	(64275, 64323, 0, 100),
	(64276, 64323, 0, 100),
	(64277, 64323, 0, 100),
	(64278, 64323, 0, 100),
	(64279, 64323, 0, 100),
	(64280, 64323, 0, 100),
	(64281, 64323, 0, 100),
	(64282, 64323, 0, 100),
	(64283, 64323, 0, 100),
	(64284, 64323, 0, 100),
	(64285, 64323, 0, 100),
	(64286, 64323, 0, 100),
	(64287, 64323, 0, 100),
	(64288, 64323, 0, 100),
	(64289, 64323, 0, 100),
	(64291, 64323, 0, 100),
	(64294, 64323, 0, 100),
	(64295, 64323, 0, 100),
	(64296, 64323, 0, 100),
	(64297, 64323, 0, 100),
	(64298, 64323, 0, 100),
	(64299, 64323, 0, 100),
	(64300, 64323, 0, 100),
	(64302, 64323, 0, 100),
	(64303, 64323, 0, 100),
	(64304, 64323, 0, 100),
	(64305, 64323, 0, 100),
	(64307, 64323, 0, 100),
	(64308, 64323, 0, 100),
	(64309, 64323, 0, 100),
	(64310, 64323, 0, 100),
	(64311, 64323, 0, 100),
	(64312, 64323, 0, 100),
	(64313, 64323, 0, 100),
	(64314, 64323, 0, 100),
	(64315, 64323, 0, 100),
	(64316, 64323, 0, 100),
	(64317, 64323, 0, 100),
	(64318, 64323, 0, 100),
	(65245, 64323, 0, 100),
	(68166, 61288, 350, 100);
/*!40000 ALTER TABLE `skill_discovery_template` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
