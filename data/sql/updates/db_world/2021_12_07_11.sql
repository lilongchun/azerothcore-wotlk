-- DB update 2021_12_07_10 -> 2021_12_07_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_07_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_07_10 2021_12_07_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638623866801763400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638623866801763400');

DELETE FROM `spell_script_names` WHERE `spell_id`=19577;
INSERT INTO `spell_script_names` VALUES
(19577,'spell_hun_intimidation');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_07_11' WHERE sql_rev = '1638623866801763400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
