INSERT INTO version_db_world (`sql_rev`) VALUES ('1546538959760274673');

ALTER TABLE `game_event`
ADD COLUMN `announce` tinyint(3) unsigned NOT NULL DEFAULT 2 COMMENT '0 dont announce, 1 announce, 2 value from config' AFTER `world_event`;
