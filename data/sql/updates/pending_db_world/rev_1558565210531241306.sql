INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558565210531241306');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8905;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 9476 AND `source_type` = 0 AND `id` IN (4,5,6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(9476,0,4,5,4,0,100,1,0,0,0,0,0,19,768,0,0,0,0,0,11,8905,50,0,0,0,0,0,0,'Watchman Doomgrip - On Aggro - Remove Unit Flags from ''Warbringer Construct'' (8905)'),
(9476,0,5,6,61,0,100,0,0,0,0,0,0,8,2,0,0,0,0,0,11,8905,50,0,0,0,0,0,0,'Watchman Doomgrip - Linked - Set React State ''Aggressive'' for ''Warbringer Construct'' (8905)'),
(9476,0,6,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Watchman Doomgrip - Linked - Say Line 0');
