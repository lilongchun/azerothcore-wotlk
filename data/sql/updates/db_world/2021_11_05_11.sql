-- DB update 2021_11_05_10 -> 2021_11_05_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_05_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_05_10 2021_11_05_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635880139183138212'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635880139183138212');

-- Fix Gossip for Myranda the Hag
DELETE FROM `gossip_menu` WHERE `MenuID`=3801 AND `TextID`=4773;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (3801,4773);

-- Condition for source Gossip menu condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=3801 AND `SourceEntry`=4773 AND `SourceId`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3801 AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 3801, 4773, 0, 1, 8, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show text if quest ''In Dreams'' is not rewarded'),
(14, 3801, 4773, 0, 1, 8, 0, 5862, 0, 0, 0, 0, 0, '', 'Only show text if quest ''Scarlet Subterfuge'' is rewarded'),
(14, 3801, 4773, 0, 0, 8, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show text if quest ''In Dreams'' is not rewarded'),
(14, 3801, 4773, 0, 0, 28, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show text if quest ''In Dreams'' is not complete'),
(14, 3801, 4773, 0, 0, 28, 0, 5862, 0, 0, 0, 0, 0, '', 'Only show text if quest ''Scarlet Subterfuge'' is complete'),
(14, 3801, 4773, 0, 1, 28, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show text if quest ''In Dreams'' is not complete'),
(15, 3801, 0, 0, 1, 1, 0, 17961, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if no ''Scarlet Illusion'' Aura'),
(15, 3801, 0, 0, 1, 8, 0, 5862, 0, 0, 0, 0, 0, '', 'Only show gossip menu option if quest ''Scarlet Subterfuge'' is rewarded'),
(15, 3801, 0, 0, 0, 1, 0, 17961, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if no ''Scarlet Illusion'' Aura'),
(15, 3801, 0, 0, 0, 8, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if quest ''In Dreams'' is not rewarded'),
(15, 3801, 0, 0, 0, 28, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if quest ''In Dreams'' is not complete'),
(15, 3801, 0, 0, 1, 8, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if quest ''In Dreams'' is not rewarded'),
(15, 3801, 0, 0, 1, 28, 0, 5944, 0, 0, 1, 0, 0, '', 'Only show gossip menu option if quest ''In Dreams'' is not complete'),
(15, 3801, 0, 0, 0, 28, 0, 5862, 0, 0, 0, 0, 0, '', 'Only show gossip menu option if quest ''Scarlet Subterfuge'' is complete');

-- Add SAI for Myranda the Hag
UPDATE `creature_template` SET `AIName`="SmartAI", `ScriptName`='' WHERE `entry`=11872;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11872 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(11872, 0, 0, 1, 62, 0, 100, 0, 3801, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Myranda the Hag - On Gossip Option 0 Selected - Close Gossip'),
(11872, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 85, 17961, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Myranda the Hag - On Gossip Option 0 Selected - Invoker Cast ''Scarlet Illusion''');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_05_11' WHERE sql_rev = '1635880139183138212';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
