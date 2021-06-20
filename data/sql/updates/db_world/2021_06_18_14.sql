-- DB update 2021_06_18_13 -> 2021_06_18_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_13 2021_06_18_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623660631649831200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623660631649831200');

DELETE FROM `spell_script_names` WHERE `spell_id` = 34428;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (34428, 'spell_warr_victory_rush');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_14' WHERE sql_rev = '1623660631649831200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
