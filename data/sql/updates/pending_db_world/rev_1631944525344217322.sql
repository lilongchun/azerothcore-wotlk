INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631944525344217322');

-- Deletes Plaguebloom from all NPC loot tables 
DELETE FROM `creature_loot_template` WHERE `item` = 13466 AND `comment` LIKE '%Plaguebloom%';

