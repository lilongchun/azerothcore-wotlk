--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (29962, 37051, 37052, 37053, 29969));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 29962, 0, 0, 31, 0, 3, 17172, 0, 0, 0, 0, '', 'Summon Water Elementals (29962) can only target Shade of Aran Teleport NE (17172)'),
(13, 1, 37051, 0, 0, 31, 0, 3, 17175, 0, 0, 0, 0, '', 'Summon Water Elementals (37051) can only target Shade of Aran Teleport NW (17175)'),
(13, 1, 37052, 0, 0, 31, 0, 3, 17174, 0, 0, 0, 0, '', 'Summon Water Elementals (37052) can only target Shade of Aran Teleport SW (17174)'),
(13, 1, 37053, 0, 0, 31, 0, 3, 17173, 0, 0, 0, 0, '', 'Summon Water Elementals (37053) can only target Shade of Aran Teleport SE (17173)'),
(13, 1, 29969, 0, 0, 31, 0, 3, 17161, 0, 0, 0, 0, '', 'Summon Blizzard (29969) can only target Blizzard (Shade of Aran) (17161)');

SET @NPC := 135127;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-11179.069,`position_y`=-1903.9922,`position_z`=231.99551 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11179.069,-1903.9922,231.99551,NULL,0,0,0,100,0),
(@PATH,2,-11175.637,-1898.6766,231.99551,NULL,0,0,0,100,0),
(@PATH,3,-11170.077,-1896.4208,231.99551,NULL,0,0,0,100,0),
(@PATH,4,-11163.756,-1896.4015,231.99551,NULL,0,0,0,100,0),
(@PATH,5,-11157.39,-1897.875,231.99551,NULL,0,0,0,100,0),
(@PATH,6,-11152.051,-1901.6866,231.99551,NULL,0,0,0,100,0),
(@PATH,7,-11148.58,-1906.875,231.99551,NULL,0,0,0,100,0),
(@PATH,8,-11148.341,-1914.24,231.99551,NULL,0,0,0,100,0),
(@PATH,9,-11149.94,-1919.9163,231.99551,NULL,0,0,0,100,0),
(@PATH,10,-11154.768,-1924.6886,231.99551,NULL,0,0,0,100,0),
(@PATH,11,-11160.866,-1927.3403,231.99551,NULL,0,0,0,100,0),
(@PATH,12,-11166.848,-1927.012,231.99551,NULL,0,0,0,100,0),
(@PATH,13,-11173.295,-1925.4417,231.99551,NULL,0,0,0,100,0),
(@PATH,14,-11178.082,-1922.4479,231.99551,NULL,0,0,0,100,0),
(@PATH,15,-11180.802,-1915.3156,231.99551,NULL,0,0,0,100,0),
(@PATH,16,-11181.109,-1909.6647,231.99551,NULL,0,0,0,100,0);
