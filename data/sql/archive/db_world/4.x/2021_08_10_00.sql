-- DB update 2021_08_09_04 -> 2021_08_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_09_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_09_04 2021_08_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628103343468216300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628103343468216300');

-- Removed the quest Sartheril's Haven(9395) from the quest chain starting at The Wayward Apprentice [9254]
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 9395);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_10_00' WHERE sql_rev = '1628103343468216300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
