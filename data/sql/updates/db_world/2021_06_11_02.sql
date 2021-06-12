-- DB update 2021_06_11_01 -> 2021_06_11_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_11_01 2021_06_11_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622671275114677000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622671275114677000');

SET @ANNOUNCE = 14;
SET @FISHING_POOLS = 15;
SET @TURN_INS = 62;
UPDATE `game_event` SET `start_time` = '2016-10-29 00:00:00' WHERE `eventEntry` = @ANNOUNCE;
UPDATE `game_event` SET `start_time` = '2016-10-30 14:00:00' WHERE `eventEntry` IN (@FISHING_POOLS, @TURN_INS);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_11_02' WHERE sql_rev = '1622671275114677000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
