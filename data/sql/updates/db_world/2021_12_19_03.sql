-- DB update 2021_12_19_02 -> 2021_12_19_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_19_02 2021_12_19_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639782398015144058'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639782398015144058');

-- Zeb'Tela

-- Update some existing spawn movement
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `guid` IN (81968);
UPDATE `creature` SET `wander_distance`=6, `MovementType`=1 WHERE `guid` IN (81963);

-- Respawn moving spawns
DELETE FROM `creature` WHERE `guid` IN (81949,81929,81985,81978,81984,81948,81945,81993,81990,81980,81972,81955,81981,81947,81956,81954,81950,81951,81952,81986);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(81949, 16344, 530, 0, 0, 1, 1, 0, 0, 7419.2363, -7783.987, 139.39561, 3.056822061538696289, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81929, 16344, 530, 0, 0, 1, 1, 0, 0, 7512.636, -7820.2397, 147.92635, 4.534334659576416015, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81985, 16344, 530, 0, 0, 1, 1, 0, 0, 7280.2407, -7721.441, 149.27982, 3.877980232238769531, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81978, 16344, 530, 0, 0, 1, 1, 0, 0, 7257.9775, -7751.0024, 150.05153, 0.743594646453857421, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(81984, 16344, 530, 0, 0, 1, 1, 0, 0, 7243.5347, -7799.1196, 148.66646, 5.43861246109008789, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81948, 16469, 530, 0, 0, 1, 1, 0, 0, 7415.7676, -7815.705, 145.06056, 0.632958769798278808, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81945, 16469, 530, 0, 0, 1, 1, 0, 0, 7485.4004, -7848.9585, 153.59586, 6.17142343521118164, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81993, 16469, 530, 0, 0, 1, 1, 0, 0, 7447.4263, -7848.0566, 154.17485, 3.502791404724121093, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81990, 16469, 530, 0, 0, 1, 1, 0, 0, 7416.5356, -7881.026, 157.72629, 1.465280413627624511, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81980, 16469, 530, 0, 0, 1, 1, 0, 0, 7411.854, -7846.0547, 151.3382, 5.595841884613037109, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81972, 16469, 530, 0, 0, 1, 1, 0, 0, 7316.434, -7749.9126, 150.19304, 0.698131680488586425, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(81955, 16469, 530, 0, 0, 1, 1, 0, 0, 7384.8203, -7789.4756, 148.0061, 1.486722588539123535, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Pathing for Shadowpine Headhunter Entry: 16344
SET @NPC := 81978;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7258.202,-7750.8794,149.97585,0,0,0,0,100,0),
(@PATH,2,7263.636,-7745.7993,150.02885,0,0,0,0,100,0),
(@PATH,3,7274.5576,-7743.8994,150.07483,0,0,0,0,100,0),
(@PATH,4,7286.541,-7746.862,149.86967,0,0,0,0,100,0),
(@PATH,5,7295.229,-7756.6787,150.00693,0,0,0,0,100,0),
(@PATH,6,7297.9673,-7767.8813,150.08061,0,0,0,0,100,0),
(@PATH,7,7293.8223,-7781.9375,150.04262,0,0,0,0,100,0),
(@PATH,8,7289.0557,-7785.704,150.00694,0,0,0,0,100,0),
(@PATH,9,7281.8384,-7777.5815,150.01852,0,0,0,0,100,0),
(@PATH,10,7268.9795,-7774.613,150.01855,0,0,0,0,100,0),
(@PATH,11,7265.916,-7769.981,154.04512,0,0,0,0,100,0),
(@PATH,12,7265.446,-7763.79,157.17235,0,0,0,0,100,0),
(@PATH,13,7267.7837,-7761.606,157.55678,0,0,0,0,100,0),
(@PATH,14,7259.4453,-7751.2056,157.47147,0,0,0,0,100,0),
(@PATH,15,7268.2944,-7746.613,160.31723,0,0,0,0,100,0),
(@PATH,16,7278.9263,-7748.2188,163.00287,0,0,0,0,100,0),
(@PATH,17,7277.5244,-7757.76,162.9371,0,0,0,0,100,0),
(@PATH,18,7263.0376,-7761.8213,163.12181,0,0,0,0,100,0),
(@PATH,19,7262.1196,-7774.9116,162.90855,0,0,0,0,100,0),
(@PATH,20,7275.001,-7780.8257,162.97664,0,0,0,0,100,0),
(@PATH,21,7285.827,-7774.478,163.06828,0,0,0,0,100,0),
(@PATH,22,7283.971,-7762.127,162.91946,0,0,0,0,100,0),
(@PATH,23,7277.48,-7757.5894,162.9371,0,0,0,0,100,0),
(@PATH,24,7278.7754,-7748.2197,163.00192,0,0,0,0,100,0),
(@PATH,25,7268.5405,-7746.4463,160.4307,0,0,0,0,100,0),
(@PATH,26,7259.372,-7751.316,157.4678,0,0,0,0,100,0),
(@PATH,27,7267.987,-7761.7563,157.5504,0,0,0,0,100,0),
(@PATH,28,7265.2964,-7763.809,157.13445,0,0,0,0,100,0),
(@PATH,29,7266.004,-7769.9316,154.05118,0,0,0,0,100,0),
(@PATH,30,7268.964,-7774.558,150.01855,0,0,0,0,100,0),
(@PATH,31,7281.7427,-7777.3994,150.01852,0,0,0,0,100,0),
(@PATH,32,7289.153,-7785.686,150.00694,0,0,0,0,100,0),
(@PATH,33,7285.067,-7789.7275,150.01303,0,0,0,0,100,0),
(@PATH,34,7273.7373,-7792.133,150.09383,0,0,0,0,100,0),
(@PATH,35,7260.405,-7786.9565,150.26334,0,0,0,0,100,0),
(@PATH,36,7251.7554,-7777.3613,149.98994,0,0,0,0,100,0),
(@PATH,37,7249.858,-7766.422,149.84254,0,0,0,0,100,0),
(@PATH,38,7253.851,-7754.848,149.85915,0,0,0,0,100,0);

-- Pathing for Shadowpine Headhunter Entry: 16344
SET @NPC := 81961;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7414.264,-7944.118,161.23946,0,0,0,0,100,0),
(@PATH,2,7420.3,-7944.3804,161.23921,0,0,0,0,100,0),
(@PATH,3,7429.6304,-7952.7856,161.32332,0,0,0,0,100,0),
(@PATH,4,7433.213,-7966.144,161.48193,0,0,0,0,100,0),
(@PATH,5,7430.9116,-7977.678,161.2379,0,0,0,0,100,0),
(@PATH,6,7423.58,-7985.981,161.09033,0,0,0,0,100,0),
(@PATH,7,7412.2812,-7990.2476,161.09694,0,0,0,0,100,0),
(@PATH,8,7405.3647,-7989.3306,161.2224,0,0,0,0,100,0),
(@PATH,9,7398.2354,-7987.233,161.26407,0,0,0,0,100,0),
(@PATH,10,7390.521,-7979.5923,161.28032,0,0,0,0,100,0),
(@PATH,11,7385.2266,-7969.678,161.08498,0,0,0,0,100,0),
(@PATH,12,7388.7065,-7956.606,161.23788,0,0,0,0,100,0),
(@PATH,13,7395.5225,-7947.336,161.31583,0,0,0,0,100,0),
(@PATH,14,7409.83,-7942.2666,161.27107,0,0,0,0,100,0),
(@PATH,15,7414.193,-7944.009,161.2392,0,0,0,0,100,0),
(@PATH,16,7412.561,-7951.6353,161.2495,0,0,0,0,100,0),
(@PATH,17,7418.3247,-7966.836,161.2495,0,0,0,0,100,0),
(@PATH,18,7416.762,-7971.569,164.88843,0,0,0,0,100,0),
(@PATH,19,7415.1436,-7973.914,166.44054,0,0,0,0,100,0),
(@PATH,20,7411.6885,-7975.5063,168.455,0,0,0,0,100,0),
(@PATH,21,7409.052,-7974.6455,168.67279,0,0,0,0,100,0),
(@PATH,22,7406.079,-7988.408,168.68936,0,0,0,0,100,0),
(@PATH,23,7396.5503,-7984.079,171.50865,0,0,0,0,100,0),
(@PATH,24,7391.742,-7975.288,174.23001,0,0,0,0,100,0),
(@PATH,25,7398.657,-7969.9062,174.16806,0,0,0,0,100,0),
(@PATH,26,7401.4116,-7959.6943,174.17632,0,0,0,0,100,0),
(@PATH,27,7409.541,-7954.944,174.26196,0,0,0,0,100,0),
(@PATH,28,7419.0493,-7957.5645,174.21721,0,0,0,0,100,0),
(@PATH,29,7422.388,-7966.5024,174.21222,0,0,0,0,100,0),
(@PATH,30,7419.164,-7975.8193,174.0589,0,0,0,0,100,0),
(@PATH,31,7409.298,-7978.3457,174.33737,0,0,0,0,100,0),
(@PATH,32,7399.1157,-7970.7554,174.16806,0,0,0,0,100,0),
(@PATH,33,7391.3403,-7974.5845,174.23312,0,0,0,0,100,0),
(@PATH,34,7396.579,-7984.086,171.49792,0,0,0,0,100,0),
(@PATH,35,7406.079,-7988.408,168.68936,0,0,0,0,100,0),
(@PATH,36,7409.0454,-7974.863,168.74214,0,0,0,0,100,0),
(@PATH,37,7411.732,-7975.6675,168.44293,0,0,0,0,100,0),
(@PATH,38,7415.1167,-7973.88,166.44194,0,0,0,0,100,0),
(@PATH,39,7416.6807,-7971.3926,164.77481,0,0,0,0,100,0),
(@PATH,40,7418.2363,-7966.9897,161.2495,0,0,0,0,100,0),
(@PATH,41,7412.587,-7951.5757,161.2495,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_19_03' WHERE sql_rev = '1639782398015144058';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
