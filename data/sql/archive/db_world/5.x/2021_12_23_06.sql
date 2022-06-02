-- DB update 2021_12_23_05 -> 2021_12_23_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_23_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_23_05 2021_12_23_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640271107041665100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640271107041665100');

-- Wind Stone Summons: Have talk event take target into consideration
UPDATE `smart_scripts`  SET `action_param3` = 1  WHERE `entryorguid` IN (15203, 15204, 15205, 15206, 15207, 15208, 15209, 15211, 15212, 15220, 15305, 15307) AND `source_type` = 0 AND `id` = 0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_23_06' WHERE sql_rev = '1640271107041665100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
