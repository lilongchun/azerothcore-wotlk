-- DB update 2021_11_05_12 -> 2021_11_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_05_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_05_12 2021_11_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635882514407659976'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635882514407659976');

-- Fix equipment for Southsea Swashbuckler
UPDATE `creature_equip_template` SET `ItemID1`=1897, `ItemID2`=0 WHERE `CreatureID`=7858;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_06_00' WHERE sql_rev = '1635882514407659976';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
