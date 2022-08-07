--
-- Pathing for Sand Vortex Entry: 15428
SET @NPC := 144680;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-9524.06,`position_y`=1881.9224,`position_z`=85.64029 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0,25160);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9467.716,1801.2075,85.68075,0,0,0,0,100,0),
(@PATH,2,-9433.638,1767.3511,85.68072,0,0,0,0,100,0),
(@PATH,3,-9400.586,1733.8876,85.68073,0,0,0,0,100,0),
(@PATH,4,-9366.376,1733.2712,85.65805,0,0,0,0,100,0),
(@PATH,5,-9333.135,1732.013,85.61758,0,0,0,0,100,0),
(@PATH,6,-9300.71,1733.3823,85.68074,0,0,0,0,100,0),
(@PATH,7,-9266.841,1766.4036,85.68074,0,0,0,0,100,0),
(@PATH,8,-9234.005,1800.0885,85.68074,0,0,0,0,100,0),
(@PATH,9,-9200.683,1833.4056,85.68073,0,0,0,0,100,0),
(@PATH,10,-9168.018,1866.673,86.23005,0,0,0,0,100,0),
(@PATH,11,-9171.645,1901.1793,85.68071,0,0,0,0,100,0),
(@PATH,12,-9173.781,1933.2633,85.68071,0,0,0,0,100,0),
(@PATH,13,-9195.187,1966.727,86.19511,0,0,0,0,100,0),
(@PATH,14,-9220.778,1999.9199,85.68075,0,0,0,0,100,0),
(@PATH,15,-9256.546,2032.9481,86.04485,0,0,0,0,100,0),
(@PATH,16,-9289.013,2066.2517,87.10255,0,0,0,0,100,0),
(@PATH,17,-9333.082,2071.4539,85.99686,0,0,0,0,100,0),
(@PATH,18,-9366.466,2075.198,86.651405,0,0,0,0,100,0),
(@PATH,19,-9399.833,2040.6716,86.5944,0,0,0,0,100,0),
(@PATH,20,-9432.466,2006.033,85.930725,0,0,0,0,100,0),
(@PATH,21,-9466.139,1975.4115,85.92978,0,0,0,0,100,0),
(@PATH,22,-9499.492,1940.9631,85.67978,0,0,0,0,100,0),
(@PATH,23,-9525.446,1900.1099,85.680725,0,0,0,0,100,0),
(@PATH,24,-9519.793,1870.9224,85.68071,0,0,0,0,100,0),
(@PATH,25,-9499.598,1833.6816,85.68074,0,0,0,0,100,0);

-- Pathing for Sand Vortex Entry: 15428
SET @NPC := 144679;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-9228.479,`position_y`=1925.3331,`position_z`=85.64147 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0,25160);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9267.194,1866.0243,85.597404,0,0,0,0,100,0),
(@PATH,2,-9299.206,1833.0114,85.52548,0,0,0,0,100,0),
(@PATH,3,-9333.244,1799.9004,83.67978,0,0,0,0,100,0),
(@PATH,4,-9366.875,1774.673,85.68073,0,0,0,0,100,0),
(@PATH,5,-9393.9375,1800.2031,85.642654,0,0,0,0,100,0),
(@PATH,6,-9399.323,1833.3334,85.68074,0,0,0,0,100,0),
(@PATH,7,-9425.436,1859.5237,85.63606,0,0,0,0,100,0),
(@PATH,8,-9461.292,1861.6554,85.68074,0,0,0,0,100,0),
(@PATH,9,-9466.752,1899.8247,85.68074,0,0,0,0,100,0),
(@PATH,10,-9432.557,1932.738,84.57658,0,0,0,0,100,0),
(@PATH,11,-9400.856,1965.8516,86.60922,0,0,0,0,100,0),
(@PATH,12,-9369.419,2000.3989,85.680725,0,0,0,0,100,0),
(@PATH,13,-9332.606,2018.017,85.68073,0,0,0,0,100,0),
(@PATH,14,-9311.325,1999.8208,85.68074,0,0,0,0,100,0),
(@PATH,15,-9310.085,1969.1917,85.68074,0,0,0,0,100,0),
(@PATH,16,-9285.372,1947.293,85.68074,0,0,0,0,100,0),
(@PATH,17,-9255.054,1952.4874,85.68074,0,0,0,0,100,0),
(@PATH,18,-9225.013,1923.3672,85.68074,0,0,0,0,100,0),
(@PATH,19,-9233.319,1899.1927,85.68073,0,0,0,0,100,0);
