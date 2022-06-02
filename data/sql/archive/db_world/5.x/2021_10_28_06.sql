-- DB update 2021_10_28_05 -> 2021_10_28_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_28_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_28_05 2021_10_28_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634953274063126700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634953274063126700');

UPDATE `spell_proc_event` SET `procFlags` = `procFlags`|16384 WHERE `entry` = 16164;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_28_06' WHERE sql_rev = '1634953274063126700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
