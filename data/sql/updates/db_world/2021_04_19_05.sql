-- DB update 2021_04_19_04 -> 2021_04_19_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_19_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_19_04 2021_04_19_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618180915871216782'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618180915871216782');

DELETE FROM `creature_loot_template` WHERE `Reference` = 24048;
INSERT INTO `creature_loot_template` VALUES (2345, 24048, 24048, 4, 0, 1, 1, 1, 1, 'Dun Garok Rifleman - (ReferenceTable)');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
