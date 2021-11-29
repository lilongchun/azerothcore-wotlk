-- DB update 2021_10_24_03 -> 2021_10_24_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_24_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_24_03 2021_10_24_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634816731538879792'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634816731538879792');

UPDATE `creature` SET `MovementType`= 0 WHERE `guid`=161035;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_24_04' WHERE sql_rev = '1634816731538879792';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
