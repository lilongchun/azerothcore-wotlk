INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548606393549139336');


DROP TABLE IF EXISTS `gameobject_template_addon`;
CREATE TABLE `gameobject_template_addon`(
    `entry` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
    `flags` int(10) unsigned NOT NULL DEFAULT '0',
    `mingold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `maxgold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`)
SELECT `entry`, `faction`, `flags` FROM `gameobject_template`;

ALTER TABLE `gameobject_template`
DROP COLUMN `faction`,
DROP COLUMN `flags`,
CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';
