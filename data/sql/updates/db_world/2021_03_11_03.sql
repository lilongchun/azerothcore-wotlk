-- DB update 2021_03_11_02 -> 2021_03_11_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_03_11_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_03_11_02 2021_03_11_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1615212672744788600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615212672744788600');

DELETE FROM `gameobject` WHERE (`id` = 19017) AND (`guid` IN (34017));
INSERT INTO `gameobject` VALUES
(34017, 19017, 530, 0, 0, 1, 1, 6828.494141, -5699.43457, -54.572094, 5.24845, 0, 0, 0.996917, -0.078459, 180, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
