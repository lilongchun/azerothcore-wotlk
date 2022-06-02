-- DB update 2021_07_23_07 -> 2021_07_23_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_07 2021_07_23_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626802354783547000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626802354783547000');

-- Fixed the z position so now nodes are on ground level
UPDATE `gameobject` SET `position_z` = 16.463600 WHERE (`guid` IN (73680, 73681, 73682, 73683, 73684));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_08' WHERE sql_rev = '1626802354783547000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
