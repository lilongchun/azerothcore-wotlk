-- DB update 2020_07_15_00 -> 2020_07_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_15_00 2020_07_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590526350564496900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590526350564496900');

DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1112;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1112, 8);
DELETE FROM `spell_group` WHERE `id` = 1112;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1112, 8219),
(1112, 8220),
(1112, 8221),
(1112, 8222);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
