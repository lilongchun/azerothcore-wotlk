-- DB update 2019_02_14_01 -> 2019_02_14_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_14_01 2019_02_14_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550020912374137400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550020912374137400');
-- Rabine Saturna missing text
DELETE FROM `gossip_menu` WHERE `MenuID` IN (5764,5765,5766,5767,5768);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(5764,6949),
(5765,6950),
(5766,6951),
(5767,6952),
(5768,6953);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (5102,5764,5765,5766,5767,5768);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5102,0,0,"Have you ever heard of a place called Dire Maul?",9534,1,1,5764,0,0,0,"",0,0),
(5764,0,0,"Why do you say that this is a coincidence, Rabine?",9536,1,1,5765,0,0,0,"",0,0),
(5765,0,0,"The Fruit of Fertility?",9538,1,1,5766,0,0,0,"",0,0),
(5766,0,0,"But something went wrong, didn't it?",9540,1,1,5767,0,0,0,"",0,0),
(5767,0,0,"What would happen if the Fruit of Fertility - or the Felvine - was allowed to be fully corrupted?",9542,1,1,5768,0,0,0,"",0,0),
(5768,0,0,"What would you have me do, Rabine?",6089,1,1,0,0,0,0,"",0,0);

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=11801;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11801 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11801,0,0,0,62,0,100,0,5768,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Rabine Saturna - On Gossip Option Selected - Close Gossip"),
(11801,0,1,0,62,0,100,0,5768,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rabine Saturna - On Gossip Option Selected - Say Line 0");

DELETE FROM `creature_text` WHERE `CreatureID`=11801;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11801,0,0,"Speak with me, $n - if you are willing, the Cenarion Circle would eagerly accept your generous offer of aid.  The threat posed by the Felvine of Eldre'Thalas is indeed dire.",12,0,100,273,0,0,9545,0,"Rabine Saturna");
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
