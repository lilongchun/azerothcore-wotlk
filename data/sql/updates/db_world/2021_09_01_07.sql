-- DB update 2021_09_01_06 -> 2021_09_01_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_06 2021_09_01_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630007612293972500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630007612293972500');

UPDATE `creature_addon` SET `path_id`=0 WHERE `guid` IN (3477,3560,3571);
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (3477,3560,3571);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_07' WHERE sql_rev = '1630007612293972500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
