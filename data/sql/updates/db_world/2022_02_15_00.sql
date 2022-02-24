-- DB update 2022_02_14_05 -> 2022_02_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_14_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_14_05 2022_02_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644660802073805600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644660802073805600');

DELETE FROM `creature_formations` WHERE `leaderGuid`=84389;
INSERT INTO `creature_formations` VALUES
(84389,84389,0,0,7,0,0),
(84389,84388,0,0,7,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_15_00' WHERE sql_rev = '1644660802073805600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
