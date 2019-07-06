-- DB update 2019_07_05_01 -> 2019_07_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_05_01 2019_07_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561310607731551700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561310607731551700');

-- Warsong Marksman corpses on Garrosh's Landing should be dead
UPDATE `creature_addon` SET `bytes1`=0,`auras`=29266 WHERE `guid` IN (110545,110546,110540,110541,110544,110547,110551,110552,110553,110554);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
