-- DB update 2021_09_01_31 -> 2021_09_01_32
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_31';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_31 2021_09_01_32 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630416137992915266'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630416137992915266');

-- Move Tin Vein 63486 slightly so it is accessible to players
UPDATE `gameobject` SET `position_x` = -10483.46, `position_y` = 1969.77, `position_z` =  12.065  WHERE `id` = 1732 AND `guid` = 63486;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_32' WHERE sql_rev = '1630416137992915266';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
