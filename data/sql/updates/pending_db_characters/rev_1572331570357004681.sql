INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1572331570357004681');

CREATE TABLE IF NOT EXISTS `recovery_item` (
  `Guid` int(11) unsigned NOT NULL DEFAULT 0,
  `ItemEntry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ItemLevel` smallint(5) unsigned NOT NULL DEFAULT 0,
  `DisplayId` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Material` tinyint(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ItemEntry`),
  KEY `idx_guid` (`Guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `azeroth_mail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` int(10) unsigned NOT NULL DEFAULT 0,
  `subject` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `money` int(10) unsigned NOT NULL DEFAULT 0,
  `entry` int(10) unsigned NOT NULL DEFAULT 0,
  `count` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
