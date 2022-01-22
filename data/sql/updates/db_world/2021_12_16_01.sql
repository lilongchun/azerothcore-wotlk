-- DB update 2021_12_16_00 -> 2021_12_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_16_00 2021_12_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638616990639666200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638616990639666200');

ALTER TABLE `npc_trainer` ADD COLUMN `ReqSpell` INT UNSIGNED DEFAULT 0 NOT NULL AFTER `ReqLevel`; 

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_16_01' WHERE sql_rev = '1638616990639666200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
