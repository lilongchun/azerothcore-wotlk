-- DB update 2022_03_27_00 -> 2022_03_27_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_00 2022_03_27_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647566741929769300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647566741929769300');

SET @LEADERGUID := 84648;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84639, 84650);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84639, 0, 0, 3),
(@LEADERGUID, 84650, 0, 0, 3);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_01' WHERE sql_rev = '1647566741929769300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
