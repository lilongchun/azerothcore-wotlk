-- DB update 2021_12_30_01 -> 2021_12_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_30_01 2021_12_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640875137436794000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640875137436794000');

UPDATE `gameobject` SET `map` = 30, `zoneId` = 0, `areaId` = 0 WHERE `guid` IN (11766,11765,11768,11767,11769) AND `id` = 2413;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_31_00' WHERE sql_rev = '1640875137436794000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
