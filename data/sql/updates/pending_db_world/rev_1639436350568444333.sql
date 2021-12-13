INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639436350568444333');

-- Goldenmist Village,Ghostlands

-- Respawn from sniff
DELETE FROM `creature` WHERE `id` IN (16325,16326);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82178, 16325, 530, 0, 0, 1, 1, 0, 0, 7924.1406, -6264.849, 23.98444, 4.50060892105102539, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82191, 16326, 530, 0, 0, 1, 1, 0, 0, 7951.652, -6246.956, 21.331955, 0.951926112174987792, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82186, 16325, 530, 0, 0, 1, 1, 0, 0, 7946.1865, -6223.035, 21.048756, 1.001219868659973144, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82182, 16326, 530, 0, 0, 1, 1, 0, 0, 7884.153, -6184.2666, 19.973732, 0.693916201591491699, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82180, 16326, 530, 0, 0, 1, 1, 0, 0, 7912.078, -6182.9536, 20.292747, 4.290760993957519531, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82190, 16325, 530, 0, 0, 1, 1, 0, 0, 7932.2095, -6174.3906, 20.282307, 0.130610838532447814, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82175, 16326, 530, 0, 0, 1, 1, 0, 0, 7883.5547, -6219.013, 20.412382, 3.891213893890380859, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82177, 16325, 530, 0, 0, 1, 1, 0, 0, 7915.309, -6217.52, 20.674334, 5.500550270080566406, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82195, 16326, 530, 0, 0, 1, 1, 0, 0, 7982.828, -6212.4116, 22.400948, 2.623142719268798828, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82253, 16326, 530, 0, 0, 1, 1, 0, 0, 7851.346, -6083.6616, 15.76691, 1.397171616554260253, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82197, 16326, 530, 0, 0, 1, 1, 0, 0, 7884.009, -6154.151, 19.390705, 4.351996421813964843, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82201, 16326, 530, 0, 0, 1, 1, 0, 0, 7885.2563, -6119.94, 15.774515, 5.783095359802246093, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82176, 16326, 530, 0, 0, 1, 1, 0, 0, 7849.8584, -6144.432, 18.947191, 2.441301345825195312, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82209, 16325, 530, 0, 0, 1, 1, 0, 0, 7906.0415, -6099.844, 17.193802, 0.954984128475189208, 300, 6, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82200, 16325, 530, 0, 0, 1, 1, 0, 0, 7923.7095, -6123.0537, 15.654901, 3.856996774673461914, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82194, 16326, 530, 0, 0, 1, 1, 0, 0, 7949.8403, -6149.1333, 18.326675, 1.377329468727111816, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82241, 16325, 530, 0, 0, 1, 1, 0, 0, 7882.0425, -6047.1113, 15.85015, 2.172681331634521484, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82207, 16326, 530, 0, 0, 1, 1, 0, 0, 7982.3735, -6097.3584, 20.501244, 6.266892433166503906, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82208, 16325, 530, 0, 0, 1, 1, 0, 0, 7949.4126, -6084.691, 17.148935, 3.304414987564086914, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82211, 16325, 530, 0, 0, 1, 1, 0, 0, 7982.905, -6050.782, 15.981071, 3.82259535789489746, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82210, 16325, 530, 0, 0, 1, 1, 0, 0, 8018.232, -6079.3823, 17.076815, 5.676097869873046875, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82205, 16325, 530, 0, 0, 1, 1, 0, 0, 7980.283, -6133.307, 16.71964, 1.315873026847839355, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82193, 16325, 530, 0, 0, 1, 1, 0, 0, 7983.733, -6181.749, 20.936132, 5.728321075439453125, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82188, 16326, 530, 0, 0, 1, 1, 0, 0, 7938.724, -6191.994, 28.219397, 1.704865574836730957, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82196, 16326, 530, 0, 0, 1, 1, 0, 0, 7958.943, -6161.4053, 40.95791, 6.071894645690917968, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82187, 16325, 530, 0, 0, 1, 1, 0, 0, 7931.624, -6174.7896, 30.239658, 6.014050006866455078, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82189, 16325, 530, 0, 0, 1, 1, 0, 0, 7935.848, -6187.8286, 40.982826, 2.99234938621520996, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82198, 16326, 530, 0, 0, 1, 1, 0, 0, 7919.3203, -6145.587, 30.32982, 2.935590982437133789, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82185, 16325, 530, 0, 0, 1, 1, 0, 0, 7925.638, -6169.4062, 40.980644, 0.698257207870483398, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82164, 16325, 530, 0, 0, 1, 1, 0, 0, 7918.2485, -6285.859, 39.871353, 4.808445930480957031, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82181, 16326, 530, 0, 0, 1, 1, 0, 0, 7931.6284, -6241.9297, 23.999401, 0.303291857242584228, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82184, 16325, 530, 0, 0, 1, 1, 0, 0, 7944.5303, -6270.5225, 39.871468, 6.155948638916015625, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82179, 16326, 530, 0, 0, 1, 1, 0, 0, 7924.5347, -6265.3926, 39.8695, 3.829224586486816406, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82183, 16326, 530, 0, 0, 1, 1, 0, 0, 7904.702, -6258.8657, 39.871372, 4.025495529174804687, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82254, 16325, 530, 0, 0, 1, 1, 0, 0, 7883.9175, -6084.7993, 15.610306, 6.112714767456054687, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82242, 16326, 530, 0, 0, 1, 1, 0, 0, 7916.5376, -6050.6597, 14.849237, 0.474534064531326293, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82202, 16326, 530, 0, 0, 1, 1, 0, 0, 7967.782, -6105.538, 20.289742, 3.707983732223510742, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(82199, 16326, 530, 0, 0, 1, 1, 0, 0, 7927.2554, -6197.5405, 40.967323, 3.192673206329345703, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(82165, 16325, 530, 0, 0, 1, 1, 0, 0, 7927.6694, -6251.3506, 39.867928, 0.398686200380325317, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(82204, 16325, 530, 0, 0, 1, 1, 0, 0, 7893.7837, -6194.8364, 19.839214, 1.471103191375732421, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(82203, 16326, 530, 0, 0, 1, 1, 0, 0, 7929.932, -6221.11, 20.814545, 5.164243221282958984, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0);

-- Pathing for Quel'dorei Wraith Entry: 16326
SET @NPC := 82199;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7926.778,-6197.565,40.885117,0,0,0,0,100,0),
(@PATH,2,7913.846,-6190.5996,40.877453,0,0,0,0,100,0),
(@PATH,3,7906.8237,-6174.9434,40.871746,0,0,0,0,100,0),
(@PATH,4,7913.854,-6155.9536,40.86747,0,0,0,0,100,0),
(@PATH,5,7922.3384,-6152.981,40.88551,0,0,0,0,100,0),
(@PATH,6,7933.1816,-6149.7266,40.879845,0,0,0,0,100,0),
(@PATH,7,7952.7954,-6162.736,40.882893,0,0,0,0,100,0),
(@PATH,8,7952.955,-6185.335,40.877842,0,0,0,0,100,0),
(@PATH,9,7955.4272,-6164.0728,40.884415,0,0,0,0,100,0),
(@PATH,10,7958.068,-6153.7124,40.760914,0,0,0,0,100,0),
(@PATH,11,7947.1963,-6139.851,35.438225,0,0,0,0,100,0),
(@PATH,12,7930.239,-6140.1387,31.21633,0,0,0,0,100,0),
(@PATH,13,7919.366,-6145.9478,30.24434,0,0,0,0,100,0),
(@PATH,14,7931.097,-6174.3003,30.156332,0,0,0,0,100,0),
(@PATH,15,7937.8115,-6190.597,28.130934,0,0,0,0,100,0),
(@PATH,16,7928.5806,-6195.002,25.112514,0,0,0,0,100,0),
(@PATH,17,7919.8345,-6190.147,20.662216,0,0,0,0,100,0),
(@PATH,18,7914.204,-6184.247,20.210493,0,0,0,0,100,0),
(@PATH,19,7929.4185,-6175.338,20.198978,0,0,0,0,100,0),
(@PATH,20,7948.9263,-6165.6777,18.586208,0,0,0,0,100,0),
(@PATH,21,7929.4185,-6175.338,20.198978,0,0,0,0,100,0),
(@PATH,22,7914.204,-6184.247,20.210493,0,0,0,0,100,0),
(@PATH,23,7919.8345,-6190.147,20.662216,0,0,0,0,100,0),
(@PATH,24,7928.5806,-6195.002,25.112514,0,0,0,0,100,0),
(@PATH,25,7937.8115,-6190.597,28.130934,0,0,0,0,100,0),
(@PATH,26,7931.097,-6174.3003,30.156332,0,0,0,0,100,0),
(@PATH,27,7919.366,-6145.9478,30.24434,0,0,0,0,100,0),
(@PATH,28,7930.239,-6140.1387,31.21633,0,0,0,0,100,0),
(@PATH,29,7947.1963,-6139.851,35.438225,0,0,0,0,100,0),
(@PATH,30,7958.068,-6153.7124,40.760914,0,0,0,0,100,0),
(@PATH,31,7955.4272,-6164.0728,40.884415,0,0,0,0,100,0),
(@PATH,32,7952.955,-6185.335,40.877842,0,0,0,0,100,0),
(@PATH,33,7952.7954,-6162.736,40.882893,0,0,0,0,100,0),
(@PATH,34,7933.1816,-6149.7266,40.879845,0,0,0,0,100,0),
(@PATH,35,7922.4087,-6152.96,40.884678,0,0,0,0,100,0),
(@PATH,36,7913.854,-6155.9536,40.86747,0,0,0,0,100,0),
(@PATH,37,7906.8237,-6174.9434,40.871746,0,0,0,0,100,0),
(@PATH,38,7913.846,-6190.5996,40.877453,0,0,0,0,100,0);

-- Pathing for Quel'dorei Ghost Entry: 16325
SET @NPC := 82165;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7928.336,-6251.07,39.789845,0,0,0,0,100,0),
(@PATH,2,7942.463,-6263.8438,39.789032,0,0,0,0,100,0),
(@PATH,3,7951.663,-6271.606,39.78544,0,0,0,0,100,0),
(@PATH,4,7938.172,-6274.9453,39.789654,0,0,0,0,100,0),
(@PATH,5,7924.541,-6280.259,39.788685,0,0,0,0,100,0),
(@PATH,6,7930.7056,-6285.243,38.595303,0,0,0,0,100,0),
(@PATH,7,7940.613,-6285.119,34.780853,0,0,0,0,100,0),
(@PATH,8,7948.8335,-6277.5225,31.015858,0,0,0,0,100,0),
(@PATH,9,7951.5254,-6258.032,22.84983,0,0,0,0,100,0),
(@PATH,10,7949.146,-6241.6143,21.086964,0,0,0,0,100,0),
(@PATH,11,7941.3135,-6225.7456,21.197014,0,0,0,0,100,0),
(@PATH,12,7933.6304,-6224.18,20.774773,0,0,0,0,100,0),
(@PATH,13,7919.5684,-6231.8047,22.326181,0,0,0,0,100,0),
(@PATH,14,7899.366,-6252.4688,23.15271,0,0,0,0,100,0),
(@PATH,15,7899.981,-6272.6655,22.632402,0,0,0,0,100,0),
(@PATH,16,7912.7993,-6287.718,21.971735,0,0,0,0,100,0),
(@PATH,17,7934.7773,-6286.9863,21.6551,0,0,0,0,100,0),
(@PATH,18,7943.366,-6284.14,22.1551,0,0,0,0,100,0),
(@PATH,19,7949.163,-6273.1016,22.239817,0,0,0,0,100,0),
(@PATH,20,7946.224,-6249.0815,21.49944,0,0,0,0,100,0),
(@PATH,21,7956.5376,-6252.5923,21.548512,0,0,0,0,100,0),
(@PATH,22,7955.9644,-6264.2515,25.386383,0,0,0,0,100,0),
(@PATH,23,7949.4707,-6282.09,31.849789,0,0,0,0,100,0),
(@PATH,24,7936.527,-6289.4136,36.756546,0,0,0,0,100,0),
(@PATH,25,7924.4487,-6287.3223,39.78639,0,0,0,0,100,0),
(@PATH,26,7917.6494,-6290.4536,39.785217,0,0,0,0,100,0),
(@PATH,27,7914.0923,-6278.8076,39.78892,0,0,0,0,100,0),
(@PATH,28,7913.9946,-6272.1235,39.790344,0,0,0,0,100,0),
(@PATH,29,7908.618,-6265.1235,39.788147,0,0,0,0,100,0),
(@PATH,30,7898.3896,-6257.671,39.784756,0,0,0,0,100,0),
(@PATH,31,7911.2524,-6254.192,39.788036,0,0,0,0,100,0);

-- Pathing for Quel'dorei Wraith Entry: 16326
SET @NPC := 82202;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7967.502,-6105.7163,20.094091,0,1000,0,0,100,0),
(@PATH,2,7957.243,-6111.3784,16.94851,0,0,0,0,100,0),
(@PATH,3,7945.6616,-6107.3237,15.933738,0,0,0,0,100,0),
(@PATH,4,7934.987,-6107.5737,15.641746,0,0,0,0,100,0),
(@PATH,5,7929.5103,-6084.743,15.615221,0,0,0,0,100,0),
(@PATH,6,7915.262,-6074.3696,15.615221,0,0,0,0,100,0),
(@PATH,7,7904.2803,-6073.317,15.615221,0,0,0,0,100,0),
(@PATH,8,7890.0376,-6076.5854,15.641743,0,0,0,0,100,0),
(@PATH,9,7879.608,-6084.5312,15.776264,0,0,0,0,100,0),
(@PATH,10,7877.172,-6100.2466,15.766743,0,0,0,0,100,0),
(@PATH,11,7879.568,-6118.568,15.891743,0,0,0,0,100,0),
(@PATH,12,7901.28,-6130.992,16.021715,0,0,0,0,100,0),
(@PATH,13,7897.9785,-6142.7275,17.300959,0,0,0,0,100,0),
(@PATH,14,7887.461,-6166.7617,19.359974,0,0,0,0,100,0),
(@PATH,15,7881.093,-6191.506,20.167835,0,0,0,0,100,0),
(@PATH,16,7889.2676,-6193.2744,19.917835,0,0,0,0,100,0),
(@PATH,17,7905.548,-6186.3203,20.209417,0,0,0,0,100,0),
(@PATH,18,7912.153,-6174.936,20.209415,0,1000,0,0,100,0),
(@PATH,19,7905.548,-6186.3203,20.209417,0,0,0,0,100,0),
(@PATH,20,7889.2676,-6193.2744,19.917835,0,0,0,0,100,0),
(@PATH,21,7881.093,-6191.506,20.167835,0,0,0,0,100,0),
(@PATH,22,7887.461,-6166.7617,19.359974,0,0,0,0,100,0),
(@PATH,23,7897.9785,-6142.7275,17.300959,0,0,0,0,100,0),
(@PATH,24,7901.28,-6130.992,16.021715,0,0,0,0,100,0),
(@PATH,25,7879.568,-6118.568,15.891743,0,0,0,0,100,0),
(@PATH,26,7877.172,-6100.2466,15.766743,0,0,0,0,100,0),
(@PATH,27,7879.608,-6084.5312,15.776264,0,0,0,0,100,0),
(@PATH,28,7890.0376,-6076.5854,15.641743,0,0,0,0,100,0),
(@PATH,29,7904.2803,-6073.317,15.615221,0,0,0,0,100,0),
(@PATH,30,7915.262,-6074.3696,15.615221,0,0,0,0,100,0),
(@PATH,31,7929.5103,-6084.743,15.615221,0,0,0,0,100,0),
(@PATH,32,7934.987,-6107.5737,15.641746,0,0,0,0,100,0),
(@PATH,33,7945.6616,-6107.3237,15.933738,0,0,0,0,100,0),
(@PATH,34,7957.243,-6111.3784,16.94851,0,0,0,0,100,0);

-- Pathing for Quel'dorei Ghost Entry: 16325
SET @NPC := 82204;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7894.1787,-6190.887,19.678822,0,0,0,0,100,0),
(@PATH,2,7882.738,-6198.9175,20.292835,0,0,0,0,100,0),
(@PATH,3,7881.328,-6204.194,20.515882,0,0,0,0,100,0),
(@PATH,4,7888.9517,-6213.011,20.140882,0,0,0,0,100,0),
(@PATH,5,7897.163,-6220.2603,20.015882,0,0,0,0,100,0),
(@PATH,6,7913.0815,-6221.764,20.333506,0,0,0,0,100,0),
(@PATH,7,7933.9634,-6224.0767,20.774773,0,0,0,0,100,0),
(@PATH,8,7943.8003,-6222.4897,21.036247,0,0,0,0,100,0),
(@PATH,9,7965.021,-6206.302,19.208733,0,0,0,0,100,0),
(@PATH,10,7973.8604,-6188.483,19.357105,0,0,0,0,100,0),
(@PATH,11,7965.08,-6172.0996,19.106365,0,0,0,0,100,0),
(@PATH,12,7958.751,-6165.9106,18.237658,0,0,0,0,100,0),
(@PATH,13,7947.9404,-6137.9023,17.262316,0,0,0,0,100,0),
(@PATH,14,7940.4697,-6131.435,16.766747,0,0,0,0,100,0),
(@PATH,15,7933.29,-6113.5337,15.615221,0,0,0,0,100,0),
(@PATH,16,7937.0938,-6108.2656,15.641746,0,0,0,0,100,0),
(@PATH,17,7950.7544,-6108.513,16.266747,0,0,0,0,100,0),
(@PATH,18,7959.1763,-6116.01,17.18032,0,0,0,0,100,0),
(@PATH,19,7957.2173,-6124.023,17.141747,0,0,0,0,100,0),
(@PATH,20,7942.769,-6132.9614,16.891747,0,0,0,0,100,0),
(@PATH,21,7930.3013,-6124.448,15.990221,0,0,0,0,100,0),
(@PATH,22,7911.646,-6125.6064,15.625719,0,0,0,0,100,0),
(@PATH,23,7899.9507,-6128.35,15.677143,0,0,0,0,100,0),
(@PATH,24,7881.3423,-6120.8193,15.818134,0,0,0,0,100,0),
(@PATH,25,7877.9966,-6105.552,15.641743,0,0,0,0,100,0),
(@PATH,26,7882.7056,-6083.084,15.52956,0,0,0,0,100,0),
(@PATH,27,7899.779,-6073.521,15.641743,0,0,0,0,100,0),
(@PATH,28,7930.1494,-6086.416,15.615221,0,0,0,0,100,0),
(@PATH,29,7921.021,-6124.257,15.615221,0,0,0,0,100,0),
(@PATH,30,7903.9185,-6128.5967,15.740221,0,0,0,0,100,0),
(@PATH,31,7893.674,-6151.8003,18.139582,0,0,0,0,100,0),
(@PATH,32,7886.565,-6168.048,19.467518,0,0,0,0,100,0),
(@PATH,33,7881.5,-6191.525,20.167835,0,0,0,0,100,0),
(@PATH,34,7854.8613,-6212.9487,18.359207,0,0,0,0,100,0),
(@PATH,35,7879.8423,-6194.8975,20.292835,0,0,0,0,100,0);

-- Pathing for Quel'dorei Wraith Entry: 16326
SET @NPC := 82203;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7930.3525,-6221.976,20.826181,0,1000,0,0,100,0),
(@PATH,2,7942.526,-6222.151,21.024773,0,0,0,0,100,0),
(@PATH,3,7959.408,-6211.862,19.958244,0,0,0,0,100,0),
(@PATH,4,7971.3906,-6196.0615,18.935719,0,0,0,0,100,0),
(@PATH,5,7969.171,-6178.558,19.419361,0,0,0,0,100,0),
(@PATH,6,7957.9756,-6163.536,18.15697,0,0,0,0,100,0),
(@PATH,7,7952.809,-6148.634,18.137316,0,0,0,0,100,0),
(@PATH,8,7943.0366,-6130.9663,16.891747,0,0,0,0,100,0),
(@PATH,9,7932.9062,-6124.5527,16.12401,0,0,0,0,100,0),
(@PATH,10,7917.271,-6123.5425,15.615221,0,0,0,0,100,0),
(@PATH,11,7908.3223,-6124.477,15.615221,0,0,0,0,100,0),
(@PATH,12,7906.817,-6109.4727,17.065289,0,0,0,0,100,0),
(@PATH,13,7901.019,-6105.602,17.06456,0,0,0,0,100,0),
(@PATH,14,7899.2993,-6095.0693,17.06936,0,0,0,0,100,0),
(@PATH,15,7904.4517,-6088.529,17.08978,0,0,0,0,100,0),
(@PATH,16,7902.771,-6076.485,15.615221,0,1000,0,0,100,0),
(@PATH,17,7904.4517,-6088.529,17.08978,0,0,0,0,100,0),
(@PATH,18,7899.2993,-6095.0693,17.06936,0,0,0,0,100,0),
(@PATH,19,7901.019,-6105.602,17.06456,0,0,0,0,100,0),
(@PATH,20,7906.817,-6109.4727,17.065289,0,0,0,0,100,0),
(@PATH,21,7908.3223,-6124.477,15.615221,0,0,0,0,100,0),
(@PATH,22,7917.271,-6123.5425,15.615221,0,0,0,0,100,0),
(@PATH,23,7932.9062,-6124.5527,16.12401,0,0,0,0,100,0),
(@PATH,24,7943.0366,-6130.9663,16.891747,0,0,0,0,100,0),
(@PATH,25,7952.809,-6148.634,18.137316,0,0,0,0,100,0),
(@PATH,26,7957.9756,-6163.536,18.15697,0,0,0,0,100,0),
(@PATH,27,7969.171,-6178.558,19.419361,0,0,0,0,100,0),
(@PATH,28,7971.3906,-6196.0615,18.935719,0,0,0,0,100,0),
(@PATH,29,7959.408,-6211.862,19.958244,0,0,0,0,100,0),
(@PATH,30,7942.526,-6222.151,21.024773,0,0,0,0,100,0);
