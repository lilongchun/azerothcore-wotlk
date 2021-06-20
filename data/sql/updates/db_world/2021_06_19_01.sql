-- DB update 2021_06_19_00 -> 2021_06_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_19_00 2021_06_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623567336541521130'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623567336541521130');

-- Deletes Empty Tainted/Cursed Jars from various creatures
DELETE FROM `creature_loot_template` WHERE `Entry` IN (742, 2655, 2656, 5308, 5331, 5424, 5833, 6201, 6508, 6556, 6557, 6559, 7086, 7086, 7092, 7093, 7126, 7132, 8959, 9477, 11053, 12221) AND `Item` IN (11948, 11914);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_19_01' WHERE sql_rev = '1623567336541521130';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
