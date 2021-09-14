-- DB update 2021_08_24_00 -> 2021_08_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_24_00 2021_08_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629293337424377430'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629293337424377430');

UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 9198;
DELETE FROM `skinning_loot_template` WHERE `entry` = 9198;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_24_01' WHERE sql_rev = '1629293337424377430';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
