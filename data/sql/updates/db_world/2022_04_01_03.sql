-- DB update 2022_04_01_02 -> 2022_04_01_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_02 2022_04_01_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647830174089422864'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647830174089422864');

-- Trial of the Crusider - NPC_DARK_ESSENCE
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 34567;
-- Trial of the Crusider - NPC_LIGHT_ESSENCE
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 34568;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_03' WHERE sql_rev = '1647830174089422864';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
