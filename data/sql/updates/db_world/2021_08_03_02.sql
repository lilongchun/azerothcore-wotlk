-- DB update 2021_08_03_01 -> 2021_08_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_03_01 2021_08_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627304134519639700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627304134519639700');

-- Changed the coords just a bit to assure that no dwarf spawns in the same place as other
UPDATE `creature` SET `position_x` = -7183.29, `position_y` = -881.80, `position_z` = 163.93 WHERE (`id` = 24818) AND (`guid` = 4566);
UPDATE `creature` SET `position_x` = -7339.15, `position_y` = -1020.25, `position_z` = 178.65  WHERE (`id` = 24818) AND (`guid` = 5727);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_03_02' WHERE sql_rev = '1627304134519639700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
