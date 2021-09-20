-- DB update 2021_09_18_04 -> 2021_09_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_18_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_18_04 2021_09_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630930325081449726'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630930325081449726');

-- Move Ashenvale Elder Bear spawn slightly
UPDATE `creature` SET `position_x` = 2240, `position_y` = -1842.7, `position_z` = 81.7 WHERE `id` = 3810 AND `guid` = 34360;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_19_00' WHERE sql_rev = '1630930325081449726';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
