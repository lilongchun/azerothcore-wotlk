-- DB update 2022_04_11_04 -> 2022_04_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_11_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_11_04 2022_04_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649799370491572700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649799370491572700');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 3847;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(3847, 'at_orb_of_command');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_13_00' WHERE sql_rev = '1649799370491572700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
