-- DB update 2021_10_02_00 -> 2021_10_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_02_00 2021_10_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632479021658969480'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632479021658969480');

-- Decreases the respawn time for Colonel Kurzen to 5 min
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 813 AND `guid` = 1481;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_03_00' WHERE sql_rev = '1632479021658969480';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
