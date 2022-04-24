-- DB update 2022_04_19_00 -> 2022_04_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_19_00 2022_04_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650555787208782000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650555787208782000');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_igb_battle_experience_check';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(71201, 'spell_igb_battle_experience_check');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_21_00' WHERE sql_rev = '1650555787208782000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
