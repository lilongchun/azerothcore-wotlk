-- DB update 2021_10_20_06 -> 2021_10_20_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_20_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_20_06 2021_10_20_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634540496312439970'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634540496312439970');

-- Updates the quest completion text for the Art of the Armorsmith (Alliance) to Ironforge
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Grumnus Steelshaper in Ironforge.' WHERE `ID` = 5283;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_07' WHERE sql_rev = '1634540496312439970';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
