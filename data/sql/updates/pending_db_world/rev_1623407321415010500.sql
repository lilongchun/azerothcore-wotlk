INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623407321415010500');

-- Add correct gossip text
DELETE FROM `gossip_menu` WHERE `MenuID` IN (2991, 2992, 2993);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(2991, 3674),
(2992, 3675),
(2993, 3676);

-- Add chat emote text
DELETE FROM `creature_text` WHERE `CreatureID` = 10637 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`,`Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10637, 1, 0, 'Malyfous turns and points to his catalogue on the barrel.', 16, 0, 100, 25, 0, 0, 0, 0, 'Malyfous Darkhammer');

UPDATE `creature_text` SET `Emote` = 0 WHERE `CreatureID` = 10637 AND `GroupID` = 0;

-- Add script on gossip end
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10637;

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (10637, 1063700)) AND `source_type` IN (0, 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10637, 0, 0, 0, 62, 0, 100, 0, 2993, 0, 0, 0, 0, 80, 1063700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - On Gossip Option 0 Selected - Run Script'),
(1063700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - Script - Close Gossip'),
(1063700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 14, 49074, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - Script - Set Orientation'),
(1063700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - Script - Say Line 1'),
(1063700, 9, 3, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - Script - Say Line 0'),
(1063700, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malyfous Darkhammer - Script - Set Orientation');
