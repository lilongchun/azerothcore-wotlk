-- DB update 2022_03_09_01 -> 2022_03_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_09_01 2022_03_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646885819239561900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646885819239561900');

SET @LEADERGUID := 84592;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84591, 84590, 84589, 84573);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84591, 0, 0, 3),
(@LEADERGUID, 84590, 0, 0, 3),
(@LEADERGUID, 84589, 0, 0, 3),
(@LEADERGUID, 84573, 0, 0, 3);

SET @LEADERGUID := 84558;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84135, 84559, 84560, 84561, 84134, 84136, 84137, 84139, 84138, 84144, 84148, 84146, 84202);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84135, 0, 0, 3),
(@LEADERGUID, 84559, 0, 0, 3),
(@LEADERGUID, 84560, 0, 0, 3),
(@LEADERGUID, 84561, 0, 0, 3),
(@LEADERGUID, 84134, 0, 0, 3),
(@LEADERGUID, 84136, 0, 0, 3),
(@LEADERGUID, 84137, 0, 0, 3),
(@LEADERGUID, 84138, 0, 0, 3),
(@LEADERGUID, 84139, 0, 0, 3),
(@LEADERGUID, 84144, 0, 0, 3),
(@LEADERGUID, 84148, 0, 0, 3),
(@LEADERGUID, 84146, 0, 0, 3),
(@LEADERGUID, 84202, 0, 0, 3);

SET @LEADERGUID := 84557;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84196, 84195, 84183, 84553, 84193, 84191, 84189, 84187, 84548, 84185, 84184, 84182, 84546);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84196, 0, 0, 3),
(@LEADERGUID, 84195, 0, 0, 3),
(@LEADERGUID, 84183, 0, 0, 3),
(@LEADERGUID, 84553, 0, 0, 3),
(@LEADERGUID, 84193, 0, 0, 3),
(@LEADERGUID, 84191, 0, 0, 3),
(@LEADERGUID, 84189, 0, 0, 3),
(@LEADERGUID, 84187, 0, 0, 3),
(@LEADERGUID, 84548, 0, 0, 3),
(@LEADERGUID, 84185, 0, 0, 3),
(@LEADERGUID, 84184, 0, 0, 3),
(@LEADERGUID, 84182, 0, 0, 3),
(@LEADERGUID, 84546, 0, 0, 3);

SET @LEADERGUID := 84625;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84142, 84203, 84141, 84143, 84598, 84145, 84147, 84140, 84149, 84601, 84599, 84151, 84150);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84142, 0, 0, 3),
(@LEADERGUID, 84203, 0, 0, 3),
(@LEADERGUID, 84141, 0, 0, 3),
(@LEADERGUID, 84143, 0, 0, 3),
(@LEADERGUID, 84598, 0, 0, 3),
(@LEADERGUID, 84145, 0, 0, 3),
(@LEADERGUID, 84147, 0, 0, 3),
(@LEADERGUID, 84140, 0, 0, 3),
(@LEADERGUID, 84149, 0, 0, 3),
(@LEADERGUID, 84601, 0, 0, 3),
(@LEADERGUID, 84599, 0, 0, 3),
(@LEADERGUID, 84151, 0, 0, 3),
(@LEADERGUID, 84150, 0, 0, 3);

SET @LEADERGUID := 84840;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84653, 84169, 84170, 84167, 84651, 84162, 84171, 84166, 84173, 84652, 84179, 84178, 84176);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84653, 0, 0, 3),
(@LEADERGUID, 84169, 0, 0, 3),
(@LEADERGUID, 84170, 0, 0, 3),
(@LEADERGUID, 84167, 0, 0, 3),
(@LEADERGUID, 84651, 0, 0, 3),
(@LEADERGUID, 84162, 0, 0, 3),
(@LEADERGUID, 84171, 0, 0, 3),
(@LEADERGUID, 84166, 0, 0, 3),
(@LEADERGUID, 84173, 0, 0, 3),
(@LEADERGUID, 84652, 0, 0, 3),
(@LEADERGUID, 84179, 0, 0, 3),
(@LEADERGUID, 84178, 0, 0, 3),
(@LEADERGUID, 84176, 0, 0, 3);

SET @LEADERGUID := 85756;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 85581, 84174, 84175, 84177, 84172, 84165, 84168, 84180, 85601, 84181, 84163, 84164);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 85581, 0, 0, 3),
(@LEADERGUID, 84174, 0, 0, 3),
(@LEADERGUID, 84175, 0, 0, 3),
(@LEADERGUID, 84177, 0, 0, 3),
(@LEADERGUID, 84172, 0, 0, 3),
(@LEADERGUID, 84165, 0, 0, 3),
(@LEADERGUID, 84168, 0, 0, 3),
(@LEADERGUID, 84180, 0, 0, 3),
(@LEADERGUID, 85601, 0, 0, 3),
(@LEADERGUID, 84181, 0, 0, 3),
(@LEADERGUID, 84163, 0, 0, 3),
(@LEADERGUID, 84164, 0, 0, 3);

SET @LEADERGUID := 85759;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 85757, 84157, 84152, 84153, 84158, 84156, 84155, 84161, 85758, 85775, 84160, 84159, 84154);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 85757, 0, 0, 3),
(@LEADERGUID, 84157, 0, 0, 3),
(@LEADERGUID, 84152, 0, 0, 3),
(@LEADERGUID, 84153, 0, 0, 3),
(@LEADERGUID, 84158, 0, 0, 3),
(@LEADERGUID, 84156, 0, 0, 3),
(@LEADERGUID, 84155, 0, 0, 3),
(@LEADERGUID, 84161, 0, 0, 3),
(@LEADERGUID, 85758, 0, 0, 3),
(@LEADERGUID, 85775, 0, 0, 3),
(@LEADERGUID, 84160, 0, 0, 3),
(@LEADERGUID, 84159, 0, 0, 3),
(@LEADERGUID, 84154, 0, 0, 3);

SET @LEADERGUID := 84634;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84628, 84635);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84628, 0, 0, 3),
(@LEADERGUID, 84635, 0, 0, 3);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_10_00' WHERE sql_rev = '1646885819239561900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
