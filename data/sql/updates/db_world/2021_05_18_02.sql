-- DB update 2021_05_18_01 -> 2021_05_18_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_18_01 2021_05_18_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620836710197850400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620836710197850400');
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=23786;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23786 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2378600 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23786,0,0,0,11,0,100,0,0,0,0,0,80,2378600,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stonemaul Spirit - On Spawn - Run Script"),
(23786,0,9,0,0,0,15,0,0,0,0,0,1,1,0,0,0,0,0,2,0,0,0,0,0,0,0,"Stonemaul Spirit - In Combat - Say Line 1"),
(2378600,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stonemaul Spirit - On Script - Say Line 0"),
(2378600,9,1,0,0,0,100,0,2000,2000,0,0,49,0,0,0,0,0,0,23,0,0,0,0,0,0,0,"Stonemaul Spirit - On Script - Start Attacking");


DELETE FROM `creature_text` WHERE `CreatureID`=23786;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23786,0,0,"Me crush puny friend of dragons!",12,0,100,15,0,0,22416,0,"Stonemaul Spirit"),
(23786,0,1,"You leave Stonemaul lands now!",12,0,100,15,0,0,22417,0,"Stonemaul Spirit"),
(23786,0,2,"Why you wake ghost? Where other Stonemauls?!",12,0,100,15,0,0,22418,0,"Stonemaul Spirit"),
(23786,1,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1925,0,"Stonemaul Spirit"),
(23786,1,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Stonemaul Spirit"),
(23786,1,2,"I'll crush you!",12,0,100,0,0,0,1927,0,"Stonemaul Spirit");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
