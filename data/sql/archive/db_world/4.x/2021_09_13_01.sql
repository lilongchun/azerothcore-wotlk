-- DB update 2021_09_13_00 -> 2021_09_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_13_00 2021_09_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631088531210049294'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631088531210049294');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(33554432) WHERE `entry` = 3917;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_13_01' WHERE sql_rev = '1631088531210049294';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
