-- DB update 2021_07_09_05 -> 2021_07_09_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_09_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_09_05 2021_07_09_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625666226723560650'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625666226723560650');

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Zangen Stonehoof in Thunder Bluff.' WHERE `ID` = 1195;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_09_06' WHERE sql_rev = '1625666226723560650';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
