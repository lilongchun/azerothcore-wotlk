INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558178374227706700');

-- Pathing for Drakkari Gutripper Entry: 26641 (Two creatures with movement "2" in creature table)
SET @NPC := 127456;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-483.0405,`position_y`=-649.0012,`position_z`=28.58858 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-486.0568,-648.8849,28.58832,0,0,0,100,0),
(@PATH,2,-483.0405,-649.0012,28.58858,0,0,0,100,0),
(@PATH,3,-480.0255,-649.1176,28.58883,0,0,0,100,0),
(@PATH,4,-477.0105,-649.2339,28.58909,0,0,0,100,0),
(@PATH,5,-474.0007,-649.3502,28.59028,0,0,0,100,0),
(@PATH,6,-470.9918,-649.4663,28.59031,0,0,0,100,0),
(@PATH,7,-467.9779,-649.5826,28.59035,0,0,0,100,0),
(@PATH,8,-464.9656,-649.6989,28.55288,0,0,0,100,0),
(@PATH,9,-461.9586,-649.815,28.50968,0,0,0,100,0),
(@PATH,10,-460.1104,-649.8864,28.4215,0,0,0,100,0),
(@PATH,11,-464.2306,-649.7274,28.54232,0,0,0,100,0),
(@PATH,12,-467.2433,-649.611,28.59036,0,0,0,100,0),
(@PATH,13,-470.2549,-649.4948,28.59032,0,0,0,100,0),
(@PATH,14,-473.2637,-649.3786,28.59029,0,0,0,100,0),
(@PATH,15,-476.2737,-649.2624,28.58915,0,0,0,100,0),
(@PATH,16,-479.2837,-649.1462,28.5889,0,0,0,100,0),
(@PATH,17,-483.0405,-649.0012,28.58858,0,0,0,100,0);

-- Pathing for Drakkari Gutripper Entry: 26641
SET @NPC := 127457;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-483.2729,`position_y`=-654.9966,`position_z`=28.59017 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-486.2876,-654.8802,28.58992,0,0,0,100,0),
(@PATH,2,-483.2729,-654.9966,28.59017,0,0,0,100,0),
(@PATH,3,-480.2569,-655.113,28.59199,0,0,0,100,0),
(@PATH,4,-477.2439,-655.2294,28.59203,0,0,0,100,0),
(@PATH,5,-474.2319,-655.3456,28.59206,0,0,0,100,0),
(@PATH,6,-471.2233,-655.4618,28.5921,0,0,0,100,0),
(@PATH,7,-468.2094,-655.5781,28.59213,0,0,0,100,0),
(@PATH,8,-465.1971,-655.6944,28.55799,0,0,0,100,0),
(@PATH,9,-462.19,-655.8105,28.51479,0,0,0,100,0),
(@PATH,10,-460.3419,-655.8818,28.48824,0,0,0,100,0),
(@PATH,11,-464.463,-655.7228,28.54745,0,0,0,100,0),
(@PATH,12,-467.4753,-655.6064,28.59214,0,0,0,100,0),
(@PATH,13,-470.4877,-655.4902,28.59211,0,0,0,100,0),
(@PATH,14,-473.4938,-655.3741,28.59207,0,0,0,100,0),
(@PATH,15,-476.5032,-655.2579,28.59204,0,0,0,100,0),
(@PATH,16,-479.5138,-655.1417,28.592,0,0,0,100,0),
(@PATH,17,-483.2729,-654.9966,28.59017,0,0,0,100,0);
