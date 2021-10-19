-- DB update 2021_10_13_01 -> 2021_10_13_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_13_01 2021_10_13_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632773438019686726'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632773438019686726');

DELETE FROM `waypoint_data` WHERE `id`=2190;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(2190, 1, -5640.79, -501.86, 396.715, 4.93611, 20000, 0, 0, 100, 0),
(2190, 2, -5640.07, -497.906, 396.669, 0, 0, 0, 0, 100, 0),
(2190, 3, -5635.95, -495.509, 396.678, 0, 0, 0, 0, 100, 0),
(2190, 4, -5632.68, -496.318, 396.702, 2.19912, 30000, 0, 0, 100, 0),
(2190, 5, -5635.95, -495.509, 396.678, 0, 0, 0, 0, 100, 0),
(2190, 6, -5640.07, -497.906, 396.669, 0, 0, 0, 0, 100, 0);



DELETE FROM `waypoint_data` WHERE `id`=18870;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(18870, 1, -4646.74, -1273.38, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 2, -4643.06, -1269.85, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 3, -4638.85, -1265.49, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 4, -4633.74, -1261.1, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 5, -4629.31, -1256.39, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 6, -4623.38, -1256.47, 503.383, 0, 0, 0, 0, 100, 0),
(18870, 7, -4622.47, -1258.75, 503.383, 0, 0, 0, 0, 100, 0),
(18870, 8, -4622.47, -1258.75, 503.383, 4.06662, 4500, 0, 188700, 100, 0),
(18870, 9, -4615.69, -1255.44, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 10, -4608.18, -1249.27, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 11, -4603.86, -1251.56, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 12, -4603.86, -1251.56, 503.382, 0.331613, 6000, 0, 188701, 100, 0),
(18870, 13, -4598.44, -1240.89, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 14, -4592.45, -1232.21, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 15, -4588.73, -1222.18, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 16, -4588.73, -1222.18, 503.382, 5.74213, 6000, 0, 0, 100, 0),
(18870, 17, -4593.64, -1214.16, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 18, -4598.71, -1219.35, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 19, -4604.79, -1227.24, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 20, -4610.73, -1236.66, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 21, -4613.16, -1252.02, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 22, -4618.21, -1264.09, 503.384, 0, 0, 0, 0, 100, 0),
(18870, 23, -4633.39, -1276.8, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 24, -4652.42, -1285.88, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 25, -4667.36, -1294, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 26, -4678.21, -1296.4, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 27, -4689.23, -1301.69, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 28, -4699.49, -1307.61, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 29, -4709.62, -1317.36, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 30, -4711.28, -1322.39, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 31, -4711.28, -1322.39, 503.382, 3.57792, 3000, 0, 0, 100, 0),
(18870, 32, -4702.81, -1325.27, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 33, -4696.29, -1325.81, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 34, -4689.63, -1325.2, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 35, -4686.07, -1319.19, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 36, -4683.05, -1314.02, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 37, -4675, -1312.6, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 38, -4664.88, -1306.13, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 39, -4662.04, -1298.12, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 40, -4659.43, -1288.83, 503.382, 0, 0, 0, 0, 100, 0),
(18870, 41, -4654.31, -1281.54, 503.382, 0.959392, 75000, 0, 0, 100, 0);


DELETE FROM `waypoint_scripts` WHERE `id` IN (188700, 188701);
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES 
(188700, 2, 0, 2, 0, 4285, 0, 0, 0, 0, 902),
(188700, 2, 1, 16, 0, 0, 0, 0, 0, 0, 903),
(188701, 2, 1, 69, 1, 0, 0, 0, 0, 0, 904),
(188701, 2, 0, 2, 0, 4286, 0, 0, 0, 0, 905),
(188701, 5, 1, 26, 1, 0, 0, 0, 0, 0, 906);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_13_02' WHERE sql_rev = '1632773438019686726';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
