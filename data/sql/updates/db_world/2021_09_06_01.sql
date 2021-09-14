-- DB update 2021_09_06_00 -> 2021_09_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_06_00 2021_09_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630588319071631667'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630588319071631667');

-- Add Slowing poison and fade by aura
UPDATE `creature_template_addon` SET `auras` = '22766 8601' WHERE (`entry` = 7110);

-- Remove the casting of the slowing posion and sneak from smartAi as they now works on auras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` IN (0, 2));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_06_01' WHERE sql_rev = '1630588319071631667';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
