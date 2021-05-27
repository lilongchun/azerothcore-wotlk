-- DB update 2021_05_25_04 -> 2021_05_25_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_25_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_25_04 2021_05_25_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621426406097836315'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621426406097836315');

SET @REF_TIGERSTRIKE_MANTLE := 24053;

-- 4287 - Scarlet Gallant
-- 4291 - Scarlet Diviner
-- 4296 - Scarlet Adept
-- 4299 - Scarlet Chaplain
-- 4306 - Scarlet Torturer
-- 4540 - Scarlet Monk
DELETE FROM `creature_loot_template` 
WHERE `Reference` = @REF_TIGERSTRIKE_MANTLE AND `entry` IN (4287, 4291, 4296, 4299, 4306, 4540);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
