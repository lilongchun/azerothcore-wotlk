-- Replace Pathing for Simone the Inconspicuous Entry: 14527 "Replace 347 points with correct 138 points"
SET @NPC := 24439;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-7134.7847,`position_y`=-630.74493,`position_z`=-267.7975 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-7134.7847,-630.74493,-267.7975,NULL,0,0,0,100,0),
(@PATH,2,-7112.881,-631.37476,-271.91296,NULL,0,0,0,100,0),
(@PATH,3,-7074.8813,-605.44464,-270.17688,NULL,0,0,0,100,0),
(@PATH,4,-7054.3345,-620.15985,-271.81717,NULL,0,0,0,100,0),
(@PATH,5,-7021.897,-642.62115,-272.09723,NULL,0,0,0,100,0),
(@PATH,6,-7002.4976,-673.55975,-272.09723,NULL,0,0,0,100,0),
(@PATH,7,-6990.5757,-697.3798,-269.27484,NULL,0,0,0,100,0),
(@PATH,8,-6979.525,-745.5412,-265.89474,NULL,0,0,0,100,0),
(@PATH,9,-6988.725,-773.3251,-269.71436,NULL,0,0,0,100,0),
(@PATH,10,-7016.588,-807.87726,-271.42642,NULL,0,0,0,100,0),
(@PATH,11,-7059.4795,-813.66675,-271.27228,NULL,0,0,0,100,0),
(@PATH,12,-7071.4243,-846.7138,-272.09723,NULL,0,0,0,100,0),
(@PATH,13,-7087.3223,-863.11597,-272.09723,NULL,0,0,0,100,0),
(@PATH,14,-7112.989,-884.3573,-271.5253,NULL,0,0,0,100,0),
(@PATH,15,-7150.9155,-892.54047,-270.88208,NULL,0,0,0,100,0),
(@PATH,16,-7178.579,-886.7773,-271.8714,NULL,0,0,0,100,0),
(@PATH,17,-7213.6143,-880.81396,-271.18903,NULL,0,0,0,100,0),
(@PATH,18,-7247.299,-904.3297,-272.2189,NULL,0,0,0,100,0),
(@PATH,19,-7288.475,-923.52765,-269.70987,NULL,0,0,0,100,0),
(@PATH,20,-7321.972,-926.8383,-270.27194,NULL,0,0,0,100,0),
(@PATH,21,-7355.6616,-955.1081,-271.30902,NULL,0,0,0,100,0),
(@PATH,22,-7375.56,-987.6084,-271.52667,NULL,0,0,0,100,0),
(@PATH,23,-7380.3325,-1001.1614,-271.47223,NULL,0,0,0,100,0),
(@PATH,24,-7385.1216,-1031.2078,-271.74933,NULL,0,0,0,100,0),
(@PATH,25,-7405.0635,-1054.3894,-270.33633,NULL,0,0,0,100,0),
(@PATH,26,-7439.9907,-1089.5543,-270.53452,NULL,0,0,0,100,0),
(@PATH,27,-7466.9673,-1125.9111,-271.43692,NULL,0,0,0,100,0),
(@PATH,28,-7495.157,-1158.4603,-269.4523,NULL,0,0,0,100,0),
(@PATH,29,-7516.9517,-1177.9064,-271.38983,NULL,0,0,0,100,0),
(@PATH,30,-7513.4863,-1215.7516,-271.1416,NULL,0,0,0,100,0),
(@PATH,31,-7503.577,-1250.8982,-269.47784,NULL,0,0,0,100,0),
(@PATH,32,-7514.725,-1283.8434,-271.59552,NULL,0,0,0,100,0),
(@PATH,33,-7547.4697,-1312.8674,-271.15323,NULL,0,0,0,100,0),
(@PATH,34,-7567.815,-1341.8278,-271.92902,NULL,0,0,0,100,0),
(@PATH,35,-7602.6797,-1358.1893,-272.09723,NULL,0,0,0,100,0),
(@PATH,36,-7645.7256,-1381.2828,-269.63596,NULL,0,0,0,100,0),
(@PATH,37,-7675.2725,-1405.7223,-270.64542,NULL,0,0,0,100,0),
(@PATH,38,-7708.078,-1419.9424,-269.488,NULL,0,0,0,100,0),
(@PATH,39,-7741.526,-1420.2039,-271.72223,NULL,0,0,0,100,0),
(@PATH,40,-7787.6704,-1425.8127,-270.68732,NULL,0,0,0,100,0),
(@PATH,41,-7814.452,-1395.7693,-270.8106,NULL,0,0,0,100,0),
(@PATH,42,-7831.7734,-1374.3108,-271.9671,NULL,0,0,0,100,0),
(@PATH,43,-7858.1973,-1358.1388,-272.14966,NULL,0,0,0,100,0),
(@PATH,44,-7863.499,-1334.1305,-273.44678,NULL,0,0,0,100,0),
(@PATH,45,-7869.133,-1288.7773,-271.85422,NULL,0,0,0,100,0),
(@PATH,46,-7876.066,-1254.8944,-270.12402,NULL,0,0,0,100,0),
(@PATH,47,-7908.994,-1234.9504,-268.24835,NULL,0,0,0,100,0),
(@PATH,48,-7941.7363,-1239.0117,-271.4183,NULL,0,0,0,100,0),
(@PATH,49,-7988.922,-1240.2358,-268.86972,NULL,0,0,0,100,0),
(@PATH,50,-8010.9375,-1227.1108,-271.56824,NULL,0,0,0,100,0),
(@PATH,51,-8025.8813,-1189.5878,-271.56995,NULL,0,0,0,100,0),
(@PATH,52,-8015.186,-1152.5828,-269.4848,NULL,0,0,0,100,0),
(@PATH,53,-8012.1313,-1111.9603,-269.59982,NULL,0,0,0,100,0),
(@PATH,54,-8028.683,-1079.0793,-272.09723,NULL,0,0,0,100,0),
(@PATH,55,-8040.113,-1033.2528,-270.04434,NULL,0,0,0,100,0),
(@PATH,56,-8028.7397,-998.02606,-271.79742,NULL,0,0,0,100,0),
(@PATH,57,-8024.5713,-961.2599,-272.4751,NULL,0,0,0,100,0),
(@PATH,58,-8023.259,-928.99884,-271.43112,NULL,0,0,0,100,0),
(@PATH,59,-7997.295,-890.99414,-270.72998,NULL,0,0,0,100,0),
(@PATH,60,-7962.9575,-880.5515,-271.6837,NULL,0,0,0,100,0),
(@PATH,61,-7929.8647,-875.35187,-273.14883,NULL,0,0,0,100,0),
(@PATH,62,-7893.059,-872.51105,-269.61176,NULL,0,0,0,100,0),
(@PATH,63,-7858.724,-872.86163,-267.2743,NULL,0,0,0,100,0),
(@PATH,64,-7825.4307,-876.4685,-264.55084,NULL,0,0,0,100,0),
(@PATH,65,-7792.8794,-878.449,-267.72003,NULL,0,0,0,100,0),
(@PATH,66,-7756.059,-882.2704,-271.15253,NULL,0,0,0,100,0),
(@PATH,67,-7721.0957,-885.8583,-271.75806,NULL,0,0,0,100,0),
(@PATH,68,-7687.2944,-891.8414,-269.67856,NULL,0,0,0,100,0),
(@PATH,69,-7659.546,-899.9168,-270.8618,NULL,0,0,0,100,0),
(@PATH,70,-7624.8525,-907.3125,-268.2148,NULL,0,0,0,100,0),
(@PATH,71,-7659.546,-899.9168,-270.8618,NULL,0,0,0,100,0),
(@PATH,72,-7687.2944,-891.8414,-269.67856,NULL,0,0,0,100,0),
(@PATH,73,-7721.0957,-885.8583,-271.75806,NULL,0,0,0,100,0),
(@PATH,74,-7756.059,-882.2704,-271.15253,NULL,0,0,0,100,0),
(@PATH,75,-7792.842,-878.43945,-267.61237,NULL,0,0,0,100,0),
(@PATH,76,-7825.4307,-876.4685,-264.55084,NULL,0,0,0,100,0),
(@PATH,77,-7858.724,-872.86163,-267.2743,NULL,0,0,0,100,0),
(@PATH,78,-7893.059,-872.51105,-269.61176,NULL,0,0,0,100,0),
(@PATH,79,-7929.8647,-875.35187,-273.14883,NULL,0,0,0,100,0),
(@PATH,80,-7962.9575,-880.5515,-271.6837,NULL,0,0,0,100,0),
(@PATH,81,-7997.297,-891.0057,-270.69116,NULL,0,0,0,100,0),
(@PATH,82,-8023.2617,-929.00977,-271.40988,NULL,0,0,0,100,0),
(@PATH,83,-8024.5713,-961.2599,-272.4751,NULL,0,0,0,100,0),
(@PATH,84,-8028.7397,-998.02606,-271.79742,NULL,0,0,0,100,0),
(@PATH,85,-8040.113,-1033.2528,-270.04434,NULL,0,0,0,100,0),
(@PATH,86,-8028.683,-1079.0793,-272.09723,NULL,0,0,0,100,0),
(@PATH,87,-8012.1313,-1111.9603,-269.59982,NULL,0,0,0,100,0),
(@PATH,88,-8015.186,-1152.5828,-269.4848,NULL,0,0,0,100,0),
(@PATH,89,-8025.8813,-1189.5878,-271.56995,NULL,0,0,0,100,0),
(@PATH,90,-8010.9375,-1227.1108,-271.56824,NULL,0,0,0,100,0),
(@PATH,91,-7988.922,-1240.2358,-268.86972,NULL,0,0,0,100,0),
(@PATH,92,-7941.922,-1238.9512,-271.4183,NULL,0,0,0,100,0),
(@PATH,93,-7908.994,-1234.9504,-268.24835,NULL,0,0,0,100,0),
(@PATH,94,-7876.066,-1254.8944,-270.12402,NULL,0,0,0,100,0),
(@PATH,95,-7869.133,-1288.7773,-271.85422,NULL,0,0,0,100,0),
(@PATH,96,-7863.499,-1334.1305,-273.44678,NULL,0,0,0,100,0),
(@PATH,97,-7858.1973,-1358.1388,-272.14966,NULL,0,0,0,100,0),
(@PATH,98,-7831.7734,-1374.3108,-271.9671,NULL,0,0,0,100,0),
(@PATH,99,-7814.452,-1395.7693,-270.8106,NULL,0,0,0,100,0),
(@PATH,100,-7787.6704,-1425.8127,-270.68732,NULL,0,0,0,100,0),
(@PATH,101,-7741.526,-1420.2039,-271.72223,NULL,0,0,0,100,0),
(@PATH,102,-7708.078,-1419.9424,-269.488,NULL,0,0,0,100,0),
(@PATH,103,-7675.2725,-1405.7223,-270.64542,NULL,0,0,0,100,0),
(@PATH,104,-7645.7256,-1381.2828,-269.63596,NULL,0,0,0,100,0),
(@PATH,105,-7602.6797,-1358.1893,-272.09723,NULL,0,0,0,100,0),
(@PATH,106,-7567.815,-1341.8278,-271.92902,NULL,0,0,0,100,0),
(@PATH,107,-7547.4697,-1312.8674,-271.15323,NULL,0,0,0,100,0),
(@PATH,108,-7514.725,-1283.8434,-271.59552,NULL,0,0,0,100,0),
(@PATH,109,-7503.577,-1250.8982,-269.47784,NULL,0,0,0,100,0),
(@PATH,110,-7513.4863,-1215.7516,-271.1416,NULL,0,0,0,100,0),
(@PATH,111,-7516.9746,-1177.9004,-271.4909,NULL,0,0,0,100,0),
(@PATH,112,-7495.157,-1158.4603,-269.4523,NULL,0,0,0,100,0),
(@PATH,113,-7466.9673,-1125.9111,-271.43692,NULL,0,0,0,100,0),
(@PATH,114,-7439.9907,-1089.5543,-270.53452,NULL,0,0,0,100,0),
(@PATH,115,-7405.0635,-1054.3894,-270.33633,NULL,0,0,0,100,0),
(@PATH,116,-7385.1216,-1031.2078,-271.74933,NULL,0,0,0,100,0),
(@PATH,117,-7380.3325,-1001.1614,-271.47223,NULL,0,0,0,100,0),
(@PATH,118,-7375.56,-987.6084,-271.52667,NULL,0,0,0,100,0),
(@PATH,119,-7355.6616,-955.1081,-271.30902,NULL,0,0,0,100,0),
(@PATH,120,-7321.972,-926.8383,-270.27194,NULL,0,0,0,100,0),
(@PATH,121,-7288.475,-923.52765,-269.70987,NULL,0,0,0,100,0),
(@PATH,122,-7247.299,-904.3297,-272.2189,NULL,0,0,0,100,0),
(@PATH,123,-7213.666,-880.8672,-271.22223,NULL,0,0,0,100,0),
(@PATH,124,-7178.579,-886.7773,-271.8714,NULL,0,0,0,100,0),
(@PATH,125,-7150.9155,-892.54047,-270.88208,NULL,0,0,0,100,0),
(@PATH,126,-7112.989,-884.3573,-271.5253,NULL,0,0,0,100,0),
(@PATH,127,-7087.3223,-863.11597,-272.09723,NULL,0,0,0,100,0),
(@PATH,128,-7071.4243,-846.7138,-272.09723,NULL,0,0,0,100,0),
(@PATH,129,-7059.4795,-813.66675,-271.27228,NULL,0,0,0,100,0),
(@PATH,130,-7016.588,-807.87726,-271.42642,NULL,0,0,0,100,0),
(@PATH,131,-6988.725,-773.3251,-269.71436,NULL,0,0,0,100,0),
(@PATH,132,-6979.525,-745.5412,-265.89474,NULL,0,0,0,100,0),
(@PATH,133,-6990.5757,-697.3798,-269.27484,NULL,0,0,0,100,0),
(@PATH,134,-7002.4976,-673.55975,-272.09723,NULL,0,0,0,100,0),
(@PATH,135,-7021.897,-642.62115,-272.09723,NULL,0,0,0,100,0),
(@PATH,136,-7054.3345,-620.15985,-271.81717,NULL,0,0,0,100,0),
(@PATH,137,-7074.8813,-605.44464,-270.17688,NULL,0,0,0,100,0),
(@PATH,138,-7112.881,-631.37476,-271.91296,NULL,0,0,0,100,0);
