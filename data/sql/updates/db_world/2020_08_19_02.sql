-- DB update 2020_08_19_01 -> 2020_08_19_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_19_01 2020_08_19_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1593176049024213800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1593176049024213800');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18341, 1834100, 1834101);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_pandemonius' WHERE `entry` = 18341;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
