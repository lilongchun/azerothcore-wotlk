-- DB update 2021_10_15_02 -> 2021_10_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_15_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_15_02 2021_10_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634042303141509213'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634042303141509213');

-- Removes invalid Firebloom drops from various NPCs
DELETE FROM `creature_loot_template` WHERE `item` = 4625 AND `entry` NOT IN (1812, 1851, 5481, 5485, 5490, 5881, 6509, 6510, 6511, 6512, 6517, 6518, 
6519, 6527, 7100, 7101, 7139, 7584, 8384, 11462, 12219, 12220, 12223, 12224, 13022, 13141, 13142);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_16_00' WHERE sql_rev = '1634042303141509213';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
