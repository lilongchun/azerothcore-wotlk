-- DB update 2022_10_07_05 -> 2022_10_07_06
--
-- Not every GAMEOBJECT Captain Kelisendra's Cargo (180917) will be spawned at the same time and object bunching is possible (1 pool). 6 can be up at time (confirmed twice) and thier respawn seem very fast.

DELETE FROM `gameobject` WHERE `id`=180917;
SET @OGUID :=18017;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @GUID+39;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0, 180917, 530, 3430, 3460, 1, 1, 8881.802734375, -5735.43359375, 0.117886997759342193, 4.607671737670898437, 0, 0, -0.74314403533935546, 0.669131457805633544, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+1, 180917, 530, 3430, 3460, 1, 1, 8742.2236328125, -5697.8486328125, 0.245764002203941345, 1.570795774459838867, 0, 0, 0.707106590270996093, 0.707106947898864746, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+2, 180917, 530, 3430, 3460, 1, 1, 8669.2470703125, -5689.86279296875, 0.885070979595184326, 4.206246376037597656, 0, 0, -0.86162853240966796, 0.50753939151763916, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+3, 180917, 530, 3430, 3460, 1, 1, 8788.962890625, -5753.9541015625, 0.154392004013061523, 2.67034769058227539, 0, 0, 0.972369194030761718, 0.233448356389999389, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+4, 180917, 530, 3430, 3460, 1, 1, 8783.94140625, -5685.76123046875, 0.243977993726730346, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+5, 180917, 530, 3430, 3460, 1, 1, 8883.78515625, -5733.18310546875, -0.07398299872875213, 5.235987663269042968, 0, 0, -0.5, 0.866025388240814208, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+6, 180917, 530, 3430, 3460, 1, 1, 8670.87109375, -5685.01611328125, 0.471585988998413085, 5.218535900115966796, 0, 0, -0.507537841796875, 0.861629426479339599, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+7, 180917, 530, 3430, 3460, 1, 1, 8885.13671875, -5736.46484375, -0.12266399711370468, 3.159062385559082031, 0, 0, -0.99996185302734375, 0.008734640665352344, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+8, 180917, 530, 3430, 3460, 1, 1, 8741.5673828125, -5694.47509765625, -0.00841099955141544, 4.48549652099609375, 0, 0, -0.7826080322265625, 0.622514784336090087, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+9, 180917, 530, 3430, 3460, 1, 1, 8784.1865234375, -5743.7666015625, 0.156876996159553527, 2.809975385665893554, 0, 0, 0.986285209655761718, 0.165049895644187927, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+10, 180917, 530, 3430, 3460, 1, 1, 8621.2236328125, -5671.03857421875, 0.184166997671127319, 4.991643905639648437, 0, 0, -0.60181427001953125, 0.798636078834533691, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+11, 180917, 530, 3430, 3460, 1, 1, 8776.1357421875, -5688.74462890625, 0.475109994411468505, 4.555310726165771484, 0, 0, -0.76040554046630859, 0.649448513984680175, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+12, 180917, 530, 3430, 3460, 1, 1, 8842.1884765625, -5712.59619140625, 0.680698990821838378, 4.956737518310546875, 0, 0, -0.61566066741943359, 0.788011372089385986, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+13, 180917, 530, 3430, 3460, 1, 1, 8787.708984375, -5750.0869140625, 0.045983001589775085, 5.742135047912597656, 0, 0, -0.26723766326904296, 0.96363067626953125, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+14, 180917, 530, 3430, 3460, 1, 1, 8880.1494140625, -5730.4921875, 0.130083993077278137, 2.72271275520324707, 0, 0, 0.978147506713867187, 0.207912087440490722, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+15, 180917, 530, 3430, 3460, 1, 1, 8881.9365234375, -5731.9072265625, 0.042814001441001892, 5.113816738128662109, 0, 0, -0.55193614959716796, 0.833886384963989257, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+16, 180917, 530, 3430, 3460, 1, 1, 8783.9892578125, -5738.68359375, 0.175551995635032653, 4.398232460021972656, 0, 0, -0.80901622772216796, 0.587786316871643066, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+17, 180917, 530, 3430, 3460, 1, 1, 8849.580078125, -5712.47509765625, 0.612582981586456298, 5.393068790435791015, 0, 0, -0.43051052093505859, 0.902585566043853759, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+18, 180917, 530, 3430, 3460, 1, 1, 8747.5849609375, -5693.92626953125, 0.521658003330230712, 4.276057243347167968, 0, 0, -0.84339141845703125, 0.537299633026123046, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+19, 180917, 530, 3430, 3460, 1, 1, 8781.12109375, -5683, 0.007420999929308891, 4.206246376037597656, 0, 0, -0.86162853240966796, 0.50753939151763916, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+20, 180917, 530, 3430, 3460, 1, 1, 8783.9892578125, -5738.68359375, 0.175551995635032653, 4.398232460021972656, 0, 0, -0.80901622772216796, 0.587786316871643066, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+21, 180917, 530, 3430, 3460, 1, 1, 8843.9755859375, -5715.81982421875, 0.690900027751922607, 3.263772249221801757, 0, 0, -0.99813460303710937, 0.061051756143569946, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+22, 180917, 530, 3430, 3460, 1, 1, 8846.53125, -5711.57421875, 0.612381994724273681, 3.52557229995727539, 0, 0, -0.98162651062011718, 0.190812408924102783, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+23, 180917, 530, 3430, 3460, 1, 1, 8845.7255859375, -5713.32763671875, 0.679681003093719482, 3.333590030670166015, 0, 0, -0.99539566040039062, 0.095851235091686248, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+24, 180917, 530, 3430, 3460, 1, 1, 8680.0771484375, -5693.79736328125, 0.269024014472961425, 5.497788906097412109, 0, 0, -0.38268280029296875, 0.923879802227020263, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+25, 180917, 530, 3430, 3460, 1, 1, 8624.8623046875, -5674.0302734375, 0.550777018070220947, 1.221729278564453125, 0, 0, 0.573575973510742187, 0.819152355194091796, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+26, 180917, 530, 3430, 3460, 1, 1, 8618.5126953125, -5674.203125, 0.306627005338668823, 1.099556446075439453, 0, 0, 0.522498130798339843, 0.852640450000762939, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+27, 180917, 530, 3430, 3460, 1, 1, 8621.2236328125, -5671.03857421875, 0.184166997671127319, 4.991643905639648437, 0, 0, -0.60181427001953125, 0.798636078834533691, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+28, 180917, 530, 3430, 3460, 1, 1, 8775.6767578125, -5683.384765625, 0.09130900353193283, 4.520402908325195312, 0, 0, -0.77162456512451171, 0.636078238487243652, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+29, 180917, 530, 3430, 3460, 1, 1, 8777.2607421875, -5685.15576171875, 0.245699003338813781, 2.565631866455078125, 0, 0, 0.958819389343261718, 0.284016460180282592, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+30, 180917, 530, 3430, 3460, 1, 1, 8674.56640625, -5686.62744140625, 0.252530008554458618, 0.785396754741668701, 0, 0, 0.38268280029296875, 0.923879802227020263, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+31, 180917, 530, 3430, 3460, 1, 1, 8627.6865234375, -5674.00390625, 0.601273000240325927, 3.019413232803344726, 0, 0, 0.998134603037109375, 0.061051756143569946, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+32, 180917, 530, 3430, 3460, 1, 1, 8629.25, -5671.556640625, 0.449225008487701416, 4.468043327331542968, 0, 0, -0.7880105972290039, 0.615661680698394775, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+33, 180917, 530, 3430, 3460, 1, 1, 8626.0439453125, -5670.52734375, 0.292910009622573852, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+34, 180917, 530, 3430, 3460, 1, 1, 8883.1611328125, -5737.95166015625, 0.075424000620841979, 2.234017848968505859, 0, 0, 0.898793220520019531, 0.438372820615768432, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+35, 180917, 530, 3430, 3460, 1, 1, 8746.26171875, -5691.97216796875, 0.339785993099212646, 5.061456203460693359, 0, 0, -0.57357597351074218, 0.819152355194091796, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+36, 180917, 530, 3430, 3460, 1, 1, 8784.421875, -5747.7373046875, 0.232134997844696044, 1.396261811256408691, 0, 0, 0.642786979675292968, 0.766044974327087402, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+37, 180917, 530, 3430, 3460, 1, 1, 8673.607421875, -5689.6552734375, 0.596818983554840087, 2.338739633560180664, 0, 0, 0.920504570007324218, 0.3907318115234375, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+38, 180917, 530, 3430, 3460, 1, 1, 8848.1298828125, -5716.017578125, 0.576173007488250732, 3.001946926116943359, 0, 0, 0.997563362121582031, 0.069766148924827575, 30, 255, 1, 0), -- 180917 (Area: 3460 - Difficulty: 0)
(@OGUID+39, 180917, 530, 3430, 3460, 1, 1, 8743.2236328125, -5693.51123046875, 0.123534001410007476, 5.864306926727294921, 0, 0, -0.20791149139404296, 0.978147625923156738, 30, 255, 1, 0);

DELETE FROM `pool_template` WHERE `entry`=505;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(505, 6, 'Captain Kelisendra\'s Cargo (6 spawns)');
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+39;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+0, 505, 0, 'Captain Kelisendra\'s Cargo 1 of 40'),
(@OGUID+1, 505, 0, 'Captain Kelisendra\'s Cargo 2 of 40'),
(@OGUID+2, 505, 0, 'Captain Kelisendra\'s Cargo 3 of 40'),
(@OGUID+3, 505, 0, 'Captain Kelisendra\'s Cargo 4 of 40'),
(@OGUID+4, 505, 0, 'Captain Kelisendra\'s Cargo 5 of 40'),
(@OGUID+5, 505, 0, 'Captain Kelisendra\'s Cargo 6 of 40'),
(@OGUID+6, 505, 0, 'Captain Kelisendra\'s Cargo 7 of 40'),
(@OGUID+7, 505, 0, 'Captain Kelisendra\'s Cargo 8 of 40'),
(@OGUID+8, 505, 0, 'Captain Kelisendra\'s Cargo 9 of 40'),
(@OGUID+9, 505, 0, 'Captain Kelisendra\'s Cargo 10 of 40'),
(@OGUID+10, 505, 0, 'Captain Kelisendra\'s Cargo 11 of 40'),
(@OGUID+11, 505, 0, 'Captain Kelisendra\'s Cargo 12 of 40'),
(@OGUID+12, 505, 0, 'Captain Kelisendra\'s Cargo 13 of 40'),
(@OGUID+13, 505, 0, 'Captain Kelisendra\'s Cargo 14 of 40'),
(@OGUID+14, 505, 0, 'Captain Kelisendra\'s Cargo 15 of 40'),
(@OGUID+15, 505, 0, 'Captain Kelisendra\'s Cargo 16 of 40'),
(@OGUID+16, 505, 0, 'Captain Kelisendra\'s Cargo 17 of 40'),
(@OGUID+17, 505, 0, 'Captain Kelisendra\'s Cargo 18 of 40'),
(@OGUID+18, 505, 0, 'Captain Kelisendra\'s Cargo 19 of 40'),
(@OGUID+19, 505, 0, 'Captain Kelisendra\'s Cargo 20 of 40'),
(@OGUID+20, 505, 0, 'Captain Kelisendra\'s Cargo 21 of 40'),
(@OGUID+21, 505, 0, 'Captain Kelisendra\'s Cargo 22 of 40'),
(@OGUID+22, 505, 0, 'Captain Kelisendra\'s Cargo 23 of 40'),
(@OGUID+23, 505, 0, 'Captain Kelisendra\'s Cargo 24 of 40'),
(@OGUID+24, 505, 0, 'Captain Kelisendra\'s Cargo 25 of 40'),
(@OGUID+25, 505, 0, 'Captain Kelisendra\'s Cargo 26 of 40'),
(@OGUID+26, 505, 0, 'Captain Kelisendra\'s Cargo 27 of 40'),
(@OGUID+27, 505, 0, 'Captain Kelisendra\'s Cargo 28 of 40'),
(@OGUID+28, 505, 0, 'Captain Kelisendra\'s Cargo 29 of 40'),
(@OGUID+29, 505, 0, 'Captain Kelisendra\'s Cargo 30 of 40'),
(@OGUID+30, 505, 0, 'Captain Kelisendra\'s Cargo 31 of 40'),
(@OGUID+31, 505, 0, 'Captain Kelisendra\'s Cargo 32 of 40'),
(@OGUID+32, 505, 0, 'Captain Kelisendra\'s Cargo 33 of 40'),
(@OGUID+33, 505, 0, 'Captain Kelisendra\'s Cargo 34 of 40'),
(@OGUID+34, 505, 0, 'Captain Kelisendra\'s Cargo 35 of 40'),
(@OGUID+35, 505, 0, 'Captain Kelisendra\'s Cargo 36 of 40'),
(@OGUID+36, 505, 0, 'Captain Kelisendra\'s Cargo 37 of 40'),
(@OGUID+37, 505, 0, 'Captain Kelisendra\'s Cargo 38 of 40'),
(@OGUID+38, 505, 0, 'Captain Kelisendra\'s Cargo 39 of 40'),
(@OGUID+39, 505, 0, 'Captain Kelisendra\'s Cargo 40 of 40');
