-- DB update 2021_12_05_07 -> 2021_12_05_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_05_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_05_07 2021_12_05_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638733140143862200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638733140143862200');

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (2, 24) AND `guid` = 24;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(2, 24);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_05_08' WHERE sql_rev = '1638733140143862200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
