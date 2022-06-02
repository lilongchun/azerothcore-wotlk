-- DB update 2021_07_21_01 -> 2021_07_21_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_21_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_21_01 2021_07_21_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626358725875698500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626358725875698500');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (2569, 2570);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2569) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2570) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2569, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 100, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Mauler - Just Summoned - Attack Start'),
(2570, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Shaman - Just Summoned - Attack Start');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_21_02' WHERE sql_rev = '1626358725875698500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
