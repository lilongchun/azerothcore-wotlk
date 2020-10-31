INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602815099418099300');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- source: http://wotlk.cavernoftime.com/npc=11443
UPDATE `creature_template` SET `spell1`=0, `spell2`=0, `AIName`='SmartAI' WHERE  `entry`=11443;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11443);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(11443, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 35000, 45000, 0, 75, 6742, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Ogre-Mage - In Combat - Cast 6742'),
(11443, 0, 1, 0, 0, 0, 100, 0, 4000, 7500, 12500, 17000, 0, 11, 10179, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Ogre-Mage - In Combat - Cast 10179'),
(11443, 0, 2, 0, 0, 0, 100, 0, 11000, 18000, 25000, 33000, 0, 11, 10149, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Ogre-Mage - In Combat - Cast 10149');

