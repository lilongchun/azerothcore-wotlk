-- DB update 2022_04_01_00 -> 2022_04_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_00 2022_04_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647709960805661700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647709960805661700');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (34146,34150,34151);

SET @CGUID := 2000059;
DELETE FROM `creature` WHERE `guid`=@CGUID AND `id1`=34150;
INSERT INTO `creature` VALUES
(@CGUID,34150,0,0,603,0,0,3,1,0,1873.25,-288.23,412.30,3.90,180,0,0,12600,0,0,0,0,0,'',12340);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_01' WHERE sql_rev = '1647709960805661700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
