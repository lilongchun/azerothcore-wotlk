-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица acore_world.playercreateinfo_cast_spell
DROP TABLE IF EXISTS `playercreateinfo_cast_spell`;
CREATE TABLE IF NOT EXISTS `playercreateinfo_cast_spell` (
  `raceMask` INT unsigned NOT NULL DEFAULT 0,
  `classMask` INT unsigned NOT NULL DEFAULT 0,
  `spell` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `note` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_world.playercreateinfo_cast_spell: 2 rows
DELETE FROM `playercreateinfo_cast_spell`;
/*!40000 ALTER TABLE `playercreateinfo_cast_spell` DISABLE KEYS */;
INSERT INTO `playercreateinfo_cast_spell` (`raceMask`, `classMask`, `spell`, `note`) VALUES
	(0, 32, 48266, 'Death Knight - Blood Presence'),
	(0, 1, 2457, 'Warrior - Battle Stance');
/*!40000 ALTER TABLE `playercreateinfo_cast_spell` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
