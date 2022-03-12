-- DB update 2022_03_06_16 -> 2022_03_06_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_16 2022_03_06_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646159359882126100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646159359882126100');

SET @NPC := 993;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11729.1, 652.077, 49.8425, 100, 0),
(@PATH, 2, -11728.6, 649.063, 49.8904, 100, 0),
(@PATH, 3, -11727.9, 644.038, 50.0638, 100, 0),
(@PATH, 4, -11727.5, 640.971, 50.1403, 100, 0),
(@PATH, 5, -11726.9, 636.891, 50.1648, 100, 0),
(@PATH, 6, -11726.3, 632.808, 50.2481, 100, 0),
(@PATH, 7, -11725.7, 628.724, 50.1639, 100, 0),
(@PATH, 8, -11724.9, 623.62, 50.1273, 100, 0),
(@PATH, 9, -11724.5, 620.575, 49.9595, 100, 0),
(@PATH, 10, -11723.8, 617.002, 50.0048, 100, 0),
(@PATH, 11, -11722.6, 613.184, 49.9914, 100, 0),
(@PATH, 12, -11721.4, 609.301, 50.3733, 100, 0),
(@PATH, 13, -11720.2, 605.48, 50.6979, 100, 0),
(@PATH, 14, -11719.2, 602.098, 50.7631, 100, 10000),
(@PATH, 15, -11719, 601.617, 50.7631, 100, 0),
(@PATH, 16, -11719, 601.617, 50.7631, 100, 0),
(@PATH, 17, -11718.7, 600.597, 50.7631, 100, 0),
(@PATH, 18, -11718.5, 597.234, 50.8049, 100, 0),
(@PATH, 19, -11718.2, 593.173, 50.6125, 100, 0),
(@PATH, 20, -11717.8, 589.156, 50.3127, 100, 0),
(@PATH, 21, -11718.1, 584.739, 50.0659, 100, 0),
(@PATH, 22, -11718.6, 579.575, 49.9016, 100, 0),
(@PATH, 23, -11718.9, 576.562, 49.8795, 100, 0),
(@PATH, 24, -11719.3, 572.543, 50.018, 100, 0),
(@PATH, 25, -11719.7, 568.499, 50.1814, 100, 0),
(@PATH, 26, -11720.3, 564.292, 50.1759, 100, 0),
(@PATH, 27, -11721.1, 559.292, 50.1227, 100, 0),
(@PATH, 28, -11721.7, 556.284, 50.2884, 100, 0),
(@PATH, 29, -11723.5, 550.626, 49.8419, 100, 0),
(@PATH, 30, -11724.9, 547.941, 49.8857, 100, 0),
(@PATH, 31, -11727.2, 543.531, 50.5937, 100, 0),
(@PATH, 32, -11727.6, 542.86, 50.6372, 100, 0),
(@PATH, 33, -11729.5, 546.951, 50.1721, 100, 25000),
(@PATH, 34, -11729.7, 552.846, 49.6915, 100, 0),
(@PATH, 35, -11728.7, 555.032, 49.6064, 100, 0),
(@PATH, 36, -11728, 558.639, 49.5974, 100, 0),
(@PATH, 37, -11727.4, 563.583, 49.7007, 100, 0),
(@PATH, 38, -11727.1, 566.771, 49.7259, 100, 0),
(@PATH, 39, -11726.3, 571.906, 49.7898, 100, 0),
(@PATH, 40, -11725.8, 574.903, 49.8855, 100, 0),
(@PATH, 41, -11725.1, 578.891, 50.0641, 100, 0),
(@PATH, 42, -11725.2, 581.784, 50.2136, 100, 0),
(@PATH, 43, -11726, 585.468, 50.2894, 100, 0),
(@PATH, 44, -11727, 589.343, 50.3408, 100, 0),
(@PATH, 45, -11728.3, 594.23, 50.3497, 100, 0),
(@PATH, 46, -11729.4, 598.112, 50.3159, 100, 0),
(@PATH, 47, -11730, 600.554, 50.3024, 100, 0),
(@PATH, 48, -11730.3, 601.536, 50.3322, 100, 10000),
(@PATH, 49, -11730.3, 601.536, 50.3322, 100, 0),
(@PATH, 50, -11731.6, 605.715, 50.2631, 100, 0),
(@PATH, 51, -11732, 609.408, 50.2946, 100, 0),
(@PATH, 52, -11732, 613.836, 50.2631, 100, 0),
(@PATH, 53, -11731.9, 617.991, 50.3697, 100, 0),
(@PATH, 54, -11731.7, 622.098, 50.3645, 100, 0),
(@PATH, 55, -11731.5, 626.177, 50.4558, 100, 0),
(@PATH, 56, -11731.3, 630.266, 50.4626, 100, 0),
(@PATH, 57, -11731.3, 634.631, 50.4137, 100, 0),
(@PATH, 58, -11731.8, 637.645, 50.4173, 100, 0),
(@PATH, 59, -11732.4, 641.694, 50.4162, 100, 0),
(@PATH, 60, -11733, 645.683, 50.3772, 100, 0),
(@PATH, 61, -11733.6, 649.737, 50.4702, 100, 0),
(@PATH, 62, -11734.3, 655.278, 50.5861, 100, 0),
(@PATH, 63, -11734.2, 658.323, 50.456, 100, 0),
(@PATH, 64, -11734.1, 662.368, 50.4382, 100, 0),
(@PATH, 65, -11734, 666.449, 50.2593, 100, 0),
(@PATH, 66, -11733.8, 670.525, 50.1161, 100, 0),
(@PATH, 67, -11733.7, 674.594, 50.0015, 100, 0),
(@PATH, 68, -11733.6, 678.656, 50.167, 100, 0),
(@PATH, 69, -11733.4, 682.706, 50.1734, 100, 0),
(@PATH, 70, -11731.3, 688.403, 50.4878, 100, 0),
(@PATH, 71, -11726.6, 691.053, 50.2618, 100, 0),
(@PATH, 72, -11722.6, 691.871, 49.9767, 100, 0),
(@PATH, 73, -11719.6, 692.478, 50.0311, 100, 0),
(@PATH, 74, -11715.6, 693.287, 49.9061, 100, 0),
(@PATH, 75, -11711.6, 694.09, 49.872, 100, 0),
(@PATH, 76, -11706.7, 695.091, 49.6845, 100, 0),
(@PATH, 77, -11703.7, 695.689, 49.7073, 100, 0),
(@PATH, 78, -11699.7, 696.484, 49.6709, 100, 0),
(@PATH, 79, -11698.2, 696.78, 49.6749, 100, 10000),
(@PATH, 80, -11698.2, 696.78, 49.6749, 100, 0),
(@PATH, 81, -11693.9, 698.084, 49.9011, 100, 0),
(@PATH, 82, -11690.1, 699.25, 50.0499, 100, 0),
(@PATH, 83, -11690.2, 694.13, 49.9508, 100, 0),
(@PATH, 84, -11693.3, 691.999, 49.7123, 100, 0),
(@PATH, 85, -11697, 690.493, 49.7999, 100, 0),
(@PATH, 86, -11701.8, 688.769, 49.9422, 100, 0),
(@PATH, 87, -11705.6, 687.426, 50.2311, 100, 0),
(@PATH, 88, -11708.5, 686.405, 50.3715, 100, 0),
(@PATH, 89, -11712.4, 685.051, 50.4248, 100, 0),
(@PATH, 90, -11716.7, 683.555, 50.1796, 100, 0),
(@PATH, 91, -11721.1, 682.019, 49.9105, 100, 0),
(@PATH, 92, -11724, 681.016, 49.614, 100, 0),
(@PATH, 93, -11726, 680.126, 49.557, 100, 0),
(@PATH, 94, -11728.2, 677.159, 49.5311, 100, 0),
(@PATH, 95, -11728.9, 674.756, 49.4849, 100, 0),
(@PATH, 96, -11729.2, 671.022, 49.5853, 100, 0),
(@PATH, 97, -11729.3, 666.006, 49.7676, 100, 0),
(@PATH, 98, -11729.4, 662.957, 49.7512, 100, 0),
(@PATH, 99, -11729.5, 658.851, 49.8954, 100, 0),
(@PATH, 100, -11729.5, 655.439, 49.9182, 100, 0);

SET @NPC := 994;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11617.5, `position_y` = 606.901, `position_z` = 49.6096, `orientation` = 3.47745 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11617.5, 606.901, 49.6096, 100, 0),
(@PATH, 2, -11615.1, 614.486, 50.0947, 100, 0),
(@PATH, 3, -11607.7, 621.967, 50.8413, 100, 0),
(@PATH, 4, -11611, 619.628, 50.6383, 100, 0),
(@PATH, 5, -11615.6, 613.314, 49.9656, 100, 0),
(@PATH, 6, -11618.6, 596.542, 49.0794, 100, 0),
(@PATH, 7, -11623.8, 592.278, 49.5931, 100, 0),
(@PATH, 8, -11631.5, 590.479, 50.5395, 100, 0),
(@PATH, 9, -11643.6, 589.637, 50.2152, 100, 0),
(@PATH, 10, -11650.2, 608.574, 50.1644, 100, 0),
(@PATH, 11, -11645.5, 639.376, 50.6489, 100, 0),
(@PATH, 12, -11644.4, 663.842, 50.2059, 100, 0),
(@PATH, 13, -11644.4, 647.661, 50.7059, 100, 0),
(@PATH, 14, -11650.4, 615.773, 50.1792, 100, 0),
(@PATH, 15, -11648, 589.458, 50.1729, 100, 0),
(@PATH, 16, -11624.7, 591.707, 49.6399, 100, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_17' WHERE sql_rev = '1646159359882126100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
