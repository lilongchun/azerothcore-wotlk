-- DB update 2021_07_06_02 -> 2021_07_06_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_06_02 2021_07_06_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625244599291561100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625244599291561100');

UPDATE `quest_template` SET `QuestType` = 2 WHERE (`ID` = 1559);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_06_03' WHERE sql_rev = '1625244599291561100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
