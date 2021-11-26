-- DB update 2021_09_02_01 -> 2021_09_02_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_02_01 2021_09_02_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630420965081184382'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630420965081184382');

-- Make Yorus Barleybrew(6166) cast Drinking Barleybrew Scalder(8554) after accepting the quest The Rethban Gauntlet(1699)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6166;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6166) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6166, 0, 0, 0, 19, 0, 100, 0, 1699, 0, 0, 0, 0, 11, 8554, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Yorus Barleybrew - On Quest \'The Rethban Gauntlet\' Taken - Cast \'Drinking Barleybrew Scalder\'');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_02_02' WHERE sql_rev = '1630420965081184382';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
