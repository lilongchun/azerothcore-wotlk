-- DB update 2021_10_28_01 -> 2021_10_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_28_01 2021_10_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626440153363170757'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626440153363170757');

-- -- Simone the Inconspicuous
SET @SIMONE_WPID := 2443900;

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@SIMONE_WPID,1,-7135.38,-632.426,-267.289,0,0,0,0,100,0),
(@SIMONE_WPID,2,-7123.46,-632.183,-270.63,0,0,0,0,100,0),
(@SIMONE_WPID,3,-7111.61,-632.079,-272.327,0,0,0,0,100,0),
(@SIMONE_WPID,4,-7102.19,-625.129,-270.782,0,0,0,0,100,0),
(@SIMONE_WPID,5,-7093.09,-618.408,-271.013,0,0,0,0,100,0),
(@SIMONE_WPID,6,-7083.48,-611.314,-270.053,0,0,0,0,100,0),
(@SIMONE_WPID,7,-7073.85,-604.336,-270.318,0,0,0,0,100,0),
(@SIMONE_WPID,8,-7064.50,-611.130,-271.627,0,0,0,0,100,0),
(@SIMONE_WPID,9,-7055.15,-617.920,-271.757,0,0,0,0,100,0),
(@SIMONE_WPID,10,-7045.73,-624.768,-272.084,0,0,0,0,100,0),
(@SIMONE_WPID,11,-7036.41,-631.543,-271.606,0,0,0,0,100,0),
(@SIMONE_WPID,12,-7028.90,-637.001,-271.888,0,0,0,0,100,0),
(@SIMONE_WPID,13,-7021.6,-642.837,-272.155,0,0,0,0,100,0),
(@SIMONE_WPID,14,-7015.69,-652.915,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,15,-7009.78,-662.996,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,16,-7003.90,-673.045,-272.215,0,0,0,0,100,0),
(@SIMONE_WPID,17,-6999.91,-679.855,-271.857,0,0,0,0,100,0),
(@SIMONE_WPID,18,-6994.73,-688.690,-270.518,0,0,0,0,100,0),
(@SIMONE_WPID,19,-6989.87,-698.109,-269.301,0,0,0,0,100,0),
(@SIMONE_WPID,20,-6987.37,-709.513,-268.536,0,0,0,0,100,0),
(@SIMONE_WPID,21,-6984.88,-720.872,-267.025,0,0,0,0,100,0),
(@SIMONE_WPID,22,-6982.18,-733.157,-265.618,0,0,0,0,100,0),
(@SIMONE_WPID,23,-6979.9,-745.278,-265.937,0,0,0,0,100,0),
(@SIMONE_WPID,24,-6984.47,-759.746,-267.759,0,0,0,0,100,0),
(@SIMONE_WPID,25,-6989.49,-774.052,-269.931,0,0,0,0,100,0),
(@SIMONE_WPID,26,-6996.69,-783.043,-272.410,0,0,0,0,100,0),
(@SIMONE_WPID,27,-7003.04,-790.963,-273.025,0,0,0,0,100,0),
(@SIMONE_WPID,28,-7009.76,-799.344,-272.041,0,0,0,0,100,0),
(@SIMONE_WPID,29,-7016.69,-807.647,-271.597,0,0,0,0,100,0),
(@SIMONE_WPID,30,-7027.44,-809.139,-272.117,0,0,0,0,100,0),
(@SIMONE_WPID,31,-7037.96,-810.598,-271.845,0,0,0,0,100,0),
(@SIMONE_WPID,32,-7048.82,-812.106,-271.697,0,0,0,0,100,0),
(@SIMONE_WPID,33,-7059.61,-813.457,-271.303,0,0,0,0,100,0),
(@SIMONE_WPID,34,-7063.79,-824.968,-271.531,0,0,0,0,100,0),
(@SIMONE_WPID,35,-7067.83,-836.058,-272.202,0,0,0,0,100,0),
(@SIMONE_WPID,36,-7072.05,-847.054,-272.178,0,0,0,0,100,0),
(@SIMONE_WPID,37,-7083.01,-857.189,-272.220,0,0,0,0,100,0),
(@SIMONE_WPID,38,-7093.29,-866.690,-272.204,0,0,0,0,100,0),
(@SIMONE_WPID,39,-7102.90,-875.574,-271.450,0,0,0,0,100,0),
(@SIMONE_WPID,40,-7112.65,-884.181,-271.47,0,0,0,0,100,0),
(@SIMONE_WPID,41,-7131.26,-888.674,-272.03,0,0,0,0,100,0),
(@SIMONE_WPID,42,-7149.97,-892.875,-271.069,0,0,0,0,100,0),
(@SIMONE_WPID,43,-7164.34,-890.150,-271.235,0,0,0,0,100,0),
(@SIMONE_WPID,44,-7179.54,-887.271,-272.052,0,0,0,0,100,0),
(@SIMONE_WPID,45,-7195.90,-884.171,-271.957,0,0,0,0,100,0),
(@SIMONE_WPID,46,-7212.15,-880.771,-271.128,0,0,0,0,100,0),
(@SIMONE_WPID,47,-7224.42,-889.063,-272.044,0,0,0,0,100,0),
(@SIMONE_WPID,48,-7236.21,-897.030,-271.225,0,0,0,0,100,0),
(@SIMONE_WPID,49,-7248.12,-904.753,-272.24,0,0,0,0,100,0),
(@SIMONE_WPID,50,-7262.07,-911.279,-271.53,0,0,0,0,100,0),
(@SIMONE_WPID,51,-7274.82,-917.243,-271.10,0,0,0,0,100,0),
(@SIMONE_WPID,52,-7287.81,-923.019,-269.745,0,0,0,0,100,0),
(@SIMONE_WPID,53,-7304.25,-925.122,-270.666,0,0,0,0,100,0),
(@SIMONE_WPID,54,-7320.84,-926.977,-270.566,0,0,0,0,100,0),
(@SIMONE_WPID,55,-7332.81,-937.077,-268.705,0,0,0,0,100,0),
(@SIMONE_WPID,56,-7344.05,-946.554,-269.778,0,0,0,0,100,0),
(@SIMONE_WPID,57,-7355.48,-955.622,-271.426,0,0,0,0,100,0),
(@SIMONE_WPID,58,-7363.46,-971.058,-271.653,0,0,0,0,100,0),
(@SIMONE_WPID,59,-7370.96,-985.551,-270.788,0,0,0,0,100,0),
(@SIMONE_WPID,60,-7379.42,-1001.29,-271.409,0,0,0,0,100,0),
(@SIMONE_WPID,61,-7382.82,-1016.07,-271.634,0,0,0,0,100,0),
(@SIMONE_WPID,62,-7386.35,-1030.34,-271.884,0,0,0,0,100,0),
(@SIMONE_WPID,63,-7396.97,-1042.43,-271.297,0,0,0,0,100,0),
(@SIMONE_WPID,64,-7407.61,-1054.53,-270.546,0,0,0,0,100,0),
(@SIMONE_WPID,65,-7418.18,-1066.56,-270.011,0,0,0,0,100,0),
(@SIMONE_WPID,66,-7428.43,-1078.22,-269.067,0,0,0,0,100,0),
(@SIMONE_WPID,67,-7439.16,-1089.87,-270.483,0,0,0,0,100,0),
(@SIMONE_WPID,68,-7448.63,-1101.55,-271.191,0,0,0,0,100,0),
(@SIMONE_WPID,69,-7458.12,-1113.23,-271.741,0,0,0,0,100,0),
(@SIMONE_WPID,70,-7467.71,-1125.05,-271.785,0,0,0,0,100,0),
(@SIMONE_WPID,71,-7477.41,-1137.00,-272.383,0,0,0,0,100,0),
(@SIMONE_WPID,72,-7486.49,-1148.19,-271.035,0,0,0,0,100,0),
(@SIMONE_WPID,73,-7495.84,-1159.14,-269.334,0,0,0,0,100,0),
(@SIMONE_WPID,74,-7505.72,-1168.37,-271.077,0,0,0,0,100,0),
(@SIMONE_WPID,75,-7516.62,-1178.08,-271.383,0,0,0,0,100,0),
(@SIMONE_WPID,76,-7513.66,-1192.83,-269.189,0,0,0,0,100,0),
(@SIMONE_WPID,77,-7510.67,-1207.70,-268.987,0,0,0,0,100,0),
(@SIMONE_WPID,78,-7507.72,-1222.45,-269.740,0,0,0,0,100,0),
(@SIMONE_WPID,79,-7504.78,-1237.10,-269.414,0,0,0,0,100,0),
(@SIMONE_WPID,80,-7502.42,-1252.06,-269.497,0,0,0,0,100,0),
(@SIMONE_WPID,81,-7508.60,-1268.31,-270.367,0,0,0,0,100,0),
(@SIMONE_WPID,82,-7515.1,-1284.46,-271.69,0,0,0,0,100,0),
(@SIMONE_WPID,83,-7525.54,-1295.88,-272.203,0,0,0,0,100,0),
(@SIMONE_WPID,84,-7536.01,-1307.33,-271.797,0,0,0,0,100,0),
(@SIMONE_WPID,85,-7546.40,-1318.69,-271.423,0,0,0,0,100,0),
(@SIMONE_WPID,86,-7557.08,-1330.10,-271.315,0,0,0,0,100,0),
(@SIMONE_WPID,87,-7567.9,-1341.3,-271.944,0,0,0,0,100,0),
(@SIMONE_WPID,88,-7580.95,-1348.04,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,89,-7593.97,-1354.76,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,90,-7607.09,-1361.54,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,91,-7620.15,-1368.28,-271.951,0,0,0,0,100,0),
(@SIMONE_WPID,92,-7633.01,-1374.92,-270.888,0,0,0,0,100,0),
(@SIMONE_WPID,93,-7646.1,-1381.3,-269.631,0,0,0,0,100,0),
(@SIMONE_WPID,94,-7656.14,-1389.83,-269.454,0,0,0,0,100,0),
(@SIMONE_WPID,95,-7666.01,-1398.22,-270.739,0,0,0,0,100,0),
(@SIMONE_WPID,96,-7676.36,-1406.48,-270.633,0,0,0,0,100,0),
(@SIMONE_WPID,97,-7692.53,-1413.05,-269.726,0,0,0,0,100,0),
(@SIMONE_WPID,98,-7708.69,-1419.4,-269.638,0,0,0,0,100,0),
(@SIMONE_WPID,99,-7724.40,-1420.53,-271.224,0,0,0,0,100,0),
(@SIMONE_WPID,100,-7740.18,-1421.67,-271.859,0,0,0,0,100,0),
(@SIMONE_WPID,101,-7755.93,-1422.77,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,102,-7771.74,-1423.79,-272.130,0,0,0,0,100,0),
(@SIMONE_WPID,103,-7787.49,-1424.71,-270.971,0,0,0,0,100,0),
(@SIMONE_WPID,104,-7798.61,-1412.12,-271.319,0,0,0,0,100,0),
(@SIMONE_WPID,105,-7809.72,-1399.56,-270.861,0,0,0,0,100,0),
(@SIMONE_WPID,106,-7821.00,-1386.80,-271.654,0,0,0,0,100,0),
(@SIMONE_WPID,107,-7832.38,-1374.35,-272.021,0,0,0,0,100,0),
(@SIMONE_WPID,108,-7845.21,-1366.23,-272.197,0,0,0,0,100,0),
(@SIMONE_WPID,109,-7858.07,-1357.97,-272.209,0,0,0,0,100,0),
(@SIMONE_WPID,110,-7860.70,-1341.49,-273.100,0,0,0,0,100,0),
(@SIMONE_WPID,111,-7863.34,-1324.98,-273.682,0,0,0,0,100,0),
(@SIMONE_WPID,112,-7865.98,-1308.50,-273.433,0,0,0,0,100,0),
(@SIMONE_WPID,113,-7868.57,-1291.81,-272.151,0,0,0,0,100,0),
(@SIMONE_WPID,114,-7872.47,-1273.80,-270.707,0,0,0,0,100,0),
(@SIMONE_WPID,115,-7876.33,-1255.73,-270.227,0,0,0,0,100,0),
(@SIMONE_WPID,116,-7887.35,-1249.17,-270.749,0,0,0,0,100,0),
(@SIMONE_WPID,117,-7898.39,-1242.60,-269.129,0,0,0,0,100,0),
(@SIMONE_WPID,118,-7909.28,-1236.23,-268.122,0,0,0,0,100,0),
(@SIMONE_WPID,119,-7925.09,-1237.18,-268.189,0,0,0,0,100,0),
(@SIMONE_WPID,120,-7940.84,-1238.14,-271.266,0,0,0,0,100,0),
(@SIMONE_WPID,121,-7956.59,-1239.09,-275.543,0,0,0,0,100,0),
(@SIMONE_WPID,122,-7972.21,-1240.03,-272.528,0,0,0,0,100,0),
(@SIMONE_WPID,123,-7988.08,-1240.85,-268.771,0,0,0,0,100,0),
(@SIMONE_WPID,124,-7999.08,-1234.36,-270.929,0,0,0,0,100,0),
(@SIMONE_WPID,125,-8010.71,-1227.33,-271.689,0,0,0,0,100,0),
(@SIMONE_WPID,126,-8015.59,-1214.45,-271.088,0,0,0,0,100,0),
(@SIMONE_WPID,127,-8021.35,-1199.28,-272.097,0,0,0,0,100,0),
(@SIMONE_WPID,128,-8025.09,-1189.04,-271.573,0,0,0,0,100,0),
(@SIMONE_WPID,129,-8022.23,-1176.40,-270.534,0,0,0,0,100,0),
(@SIMONE_WPID,130,-8019.31,-1163.49,-269.757,0,0,0,0,100,0),
(@SIMONE_WPID,131,-8016.32,-1150.74,-269.61,0,0,0,0,100,0),
(@SIMONE_WPID,132,-8015.35,-1137.60,-269.69,0,0,0,0,100,0),
(@SIMONE_WPID,133,-8014.40,-1124.57,-269.72,0,0,0,0,100,0),
(@SIMONE_WPID,134,-8013.32,-1110.68,-270.044,0,0,0,0,100,0),
(@SIMONE_WPID,135,-8021.14,-1093.60,-271.817,0,0,0,0,100,0),
(@SIMONE_WPID,136,-8028.9,-1076.55,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,137,-8032.49,-1062.30,-272.217,0,0,0,0,100,0),
(@SIMONE_WPID,138,-8036.17,-1047.71,-272.020,0,0,0,0,100,0),
(@SIMONE_WPID,139,-8039.74,-1032.95,-270.213,0,0,0,0,100,0),
(@SIMONE_WPID,140,-8035.83,-1020.34,-270.697,0,0,0,0,100,0),
(@SIMONE_WPID,141,-8031.94,-1007.78,-271.425,0,0,0,0,100,0),
(@SIMONE_WPID,142,-8028.18,-995.517,-271.951,0,0,0,0,100,0),
(@SIMONE_WPID,143,-8027.03,-979.111,-271.886,0,0,0,0,100,0),
(@SIMONE_WPID,144,-8025.88,-962.589,-272.389,0,0,0,0,100,0),
(@SIMONE_WPID,145,-8024.66,-945.162,-272.090,0,0,0,0,100,0),
(@SIMONE_WPID,146,-8023.5,-928.738,-271.488,0,0,0,0,100,0),
(@SIMONE_WPID,147,-8014.73,-916.33,-272.090,0,0,0,0,100,0),
(@SIMONE_WPID,148,-8005.56,-903.38,-271.879,0,0,0,0,100,0),
(@SIMONE_WPID,149,-7996.5,-890.744,-270.785,0,0,0,0,100,0),
(@SIMONE_WPID,150,-7978.12,-886.46,-271.507,0,0,0,0,100,0),
(@SIMONE_WPID,151,-7961.41,-882.57,-272.429,0,0,0,0,100,0),
(@SIMONE_WPID,152,-7944.55,-878.64,-272.776,0,0,0,0,100,0),
(@SIMONE_WPID,153,-7927.47,-874.764,-273.239,0,0,0,0,100,0),
(@SIMONE_WPID,154,-7911.44,-874.16,-271.360,0,0,0,0,100,0),
(@SIMONE_WPID,155,-7895.53,-873.57,-269.631,0,0,0,0,100,0),
(@SIMONE_WPID,156,-7878.9,-873.272,-269.206,0,0,0,0,100,0),
(@SIMONE_WPID,157,-7861.82,-873.50,-267.549,0,0,0,0,100,0),
(@SIMONE_WPID,158,-7843.57,-873.98,-267.831,0,0,0,0,100,0),
(@SIMONE_WPID,159,-7828.47,-875.61,-265.442,0,0,0,0,100,0),
(@SIMONE_WPID,160,-7814.7,-877.233,-263.584,0,0,0,0,100,0),
(@SIMONE_WPID,161,-7801.57,-878.34,-265.669,0,0,0,0,100,0),
(@SIMONE_WPID,162,-7788.56,-879.44,-268.830,0,0,0,0,100,0),
(@SIMONE_WPID,163,-7775.41,-880.693,-270.838,0,0,0,0,100,0),
(@SIMONE_WPID,164,-7760.87,-882.097,-271.186,0,0,0,0,100,0),
(@SIMONE_WPID,165,-7746.63,-883.473,-271.493,0,0,0,0,100,0),
(@SIMONE_WPID,166,-7731.77,-884.909,-271.199,0,0,0,0,100,0),
(@SIMONE_WPID,167,-7716.72,-886.51,-271.764,0,0,0,0,100,0),
(@SIMONE_WPID,168,-7705.04,-888.43,-270.271,0,0,0,0,100,0),
(@SIMONE_WPID,169,-7693.3,-890.351,-269.212,0,0,0,0,100,0),
(@SIMONE_WPID,170,-7678.78,-893.927,-270.579,0,0,0,0,100,0),
(@SIMONE_WPID,171,-7663.54,-897.683,-271.093,0,0,0,0,100,0),
(@SIMONE_WPID,172,-7648.84,-901.546,-271.142,0,0,0,0,100,0),
(@SIMONE_WPID,173,-7636.72,-903.835,-269.725,0,0,0,0,100,0),
(@SIMONE_WPID,174,-7624.75,-906.177,-268.369,0,0,0,0,100,0),
(@SIMONE_WPID,175,-7636.72,-903.835,-269.725,0,0,0,0,100,0),
(@SIMONE_WPID,176,-7648.84,-901.546,-271.142,0,0,0,0,100,0),
(@SIMONE_WPID,177,-7663.54,-897.683,-271.093,0,0,0,0,100,0),
(@SIMONE_WPID,178,-7678.78,-893.927,-270.579,0,0,0,0,100,0),
(@SIMONE_WPID,179,-7693.3,-890.351,-269.212,0,0,0,0,100,0),
(@SIMONE_WPID,180,-7705.04,-888.43,-270.271,0,0,0,0,100,0),
(@SIMONE_WPID,181,-7716.72,-886.51,-271.764,0,0,0,0,100,0),
(@SIMONE_WPID,182,-7731.77,-884.909,-271.199,0,0,0,0,100,0),
(@SIMONE_WPID,183,-7746.63,-883.473,-271.493,0,0,0,0,100,0),
(@SIMONE_WPID,184,-7760.87,-882.097,-271.186,0,0,0,0,100,0),
(@SIMONE_WPID,185,-7775.41,-880.693,-270.838,0,0,0,0,100,0),
(@SIMONE_WPID,186,-7788.56,-879.44,-268.830,0,0,0,0,100,0),
(@SIMONE_WPID,187,-7801.57,-878.34,-265.669,0,0,0,0,100,0),
(@SIMONE_WPID,188,-7814.7,-877.233,-263.584,0,0,0,0,100,0),
(@SIMONE_WPID,189,-7828.47,-875.61,-265.442,0,0,0,0,100,0),
(@SIMONE_WPID,190,-7843.57,-873.98,-267.831,0,0,0,0,100,0),
(@SIMONE_WPID,191,-7861.82,-873.50,-267.549,0,0,0,0,100,0),
(@SIMONE_WPID,192,-7878.9,-873.272,-269.206,0,0,0,0,100,0),
(@SIMONE_WPID,193,-7895.53,-873.57,-269.631,0,0,0,0,100,0),
(@SIMONE_WPID,194,-7911.44,-874.16,-271.360,0,0,0,0,100,0),
(@SIMONE_WPID,195,-7927.47,-874.764,-273.239,0,0,0,0,100,0),
(@SIMONE_WPID,196,-7944.55,-878.64,-272.776,0,0,0,0,100,0),
(@SIMONE_WPID,197,-7961.41,-882.57,-272.429,0,0,0,0,100,0),
(@SIMONE_WPID,198,-7978.12,-886.46,-271.507,0,0,0,0,100,0),
(@SIMONE_WPID,199,-7996.5,-890.744,-270.785,0,0,0,0,100,0),
(@SIMONE_WPID,200,-8005.56,-903.38,-271.879,0,0,0,0,100,0),
(@SIMONE_WPID,201,-8014.73,-916.33,-272.090,0,0,0,0,100,0),
(@SIMONE_WPID,202,-8023.5,-928.738,-271.488,0,0,0,0,100,0),
(@SIMONE_WPID,203,-8024.66,-945.162,-272.090,0,0,0,0,100,0),
(@SIMONE_WPID,204,-8025.88,-962.589,-272.389,0,0,0,0,100,0),
(@SIMONE_WPID,205,-8027.03,-979.111,-271.886,0,0,0,0,100,0),
(@SIMONE_WPID,206,-8028.18,-995.517,-271.951,0,0,0,0,100,0),
(@SIMONE_WPID,207,-8031.94,-1007.78,-271.425,0,0,0,0,100,0),
(@SIMONE_WPID,208,-8035.83,-1020.34,-270.697,0,0,0,0,100,0),
(@SIMONE_WPID,209,-8039.74,-1032.95,-270.213,0,0,0,0,100,0),
(@SIMONE_WPID,210,-8036.17,-1047.71,-272.020,0,0,0,0,100,0),
(@SIMONE_WPID,211,-8032.49,-1062.30,-272.217,0,0,0,0,100,0),
(@SIMONE_WPID,212,-8028.9,-1076.55,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,213,-8021.14,-1093.60,-271.817,0,0,0,0,100,0),
(@SIMONE_WPID,214,-8013.32,-1110.68,-270.044,0,0,0,0,100,0),
(@SIMONE_WPID,215,-8014.40,-1124.57,-269.72,0,0,0,0,100,0),
(@SIMONE_WPID,216,-8015.35,-1137.60,-269.69,0,0,0,0,100,0),
(@SIMONE_WPID,217,-8016.32,-1150.74,-269.61,0,0,0,0,100,0),
(@SIMONE_WPID,218,-8019.31,-1163.49,-269.757,0,0,0,0,100,0),
(@SIMONE_WPID,219,-8022.23,-1176.40,-270.534,0,0,0,0,100,0),
(@SIMONE_WPID,220,-8025.09,-1189.04,-271.573,0,0,0,0,100,0),
(@SIMONE_WPID,221,-8021.35,-1199.28,-272.097,0,0,0,0,100,0),
(@SIMONE_WPID,222,-8015.59,-1214.45,-271.088,0,0,0,0,100,0),
(@SIMONE_WPID,223,-8010.71,-1227.33,-271.689,0,0,0,0,100,0),
(@SIMONE_WPID,224,-7999.08,-1234.36,-270.929,0,0,0,0,100,0),
(@SIMONE_WPID,225,-7988.08,-1240.85,-268.771,0,0,0,0,100,0),
(@SIMONE_WPID,226,-7972.21,-1240.03,-272.528,0,0,0,0,100,0),
(@SIMONE_WPID,227,-7956.59,-1239.09,-275.543,0,0,0,0,100,0),
(@SIMONE_WPID,228,-7940.84,-1238.14,-271.266,0,0,0,0,100,0),
(@SIMONE_WPID,229,-7925.09,-1237.18,-268.189,0,0,0,0,100,0),
(@SIMONE_WPID,230,-7909.28,-1236.23,-268.122,0,0,0,0,100,0),
(@SIMONE_WPID,231,-7898.39,-1242.60,-269.129,0,0,0,0,100,0),
(@SIMONE_WPID,232,-7887.35,-1249.17,-270.749,0,0,0,0,100,0),
(@SIMONE_WPID,233,-7876.33,-1255.73,-270.227,0,0,0,0,100,0),
(@SIMONE_WPID,234,-7872.47,-1273.80,-270.707,0,0,0,0,100,0),
(@SIMONE_WPID,235,-7868.57,-1291.81,-272.151,0,0,0,0,100,0),
(@SIMONE_WPID,236,-7865.98,-1308.50,-273.433,0,0,0,0,100,0),
(@SIMONE_WPID,237,-7863.34,-1324.98,-273.682,0,0,0,0,100,0),
(@SIMONE_WPID,238,-7860.70,-1341.49,-273.100,0,0,0,0,100,0),
(@SIMONE_WPID,239,-7858.07,-1357.97,-272.209,0,0,0,0,100,0),
(@SIMONE_WPID,240,-7845.21,-1366.23,-272.197,0,0,0,0,100,0),
(@SIMONE_WPID,241,-7832.38,-1374.35,-272.021,0,0,0,0,100,0),
(@SIMONE_WPID,242,-7821.00,-1386.80,-271.654,0,0,0,0,100,0),
(@SIMONE_WPID,243,-7809.72,-1399.56,-270.861,0,0,0,0,100,0),
(@SIMONE_WPID,244,-7798.61,-1412.12,-271.319,0,0,0,0,100,0),
(@SIMONE_WPID,245,-7787.49,-1424.71,-270.971,0,0,0,0,100,0),
(@SIMONE_WPID,246,-7771.74,-1423.79,-272.130,0,0,0,0,100,0),
(@SIMONE_WPID,247,-7755.93,-1422.77,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,248,-7740.18,-1421.67,-271.859,0,0,0,0,100,0),
(@SIMONE_WPID,249,-7724.40,-1420.53,-271.224,0,0,0,0,100,0),
(@SIMONE_WPID,250,-7708.69,-1419.4,-269.638,0,0,0,0,100,0),
(@SIMONE_WPID,251,-7692.53,-1413.05,-269.726,0,0,0,0,100,0),
(@SIMONE_WPID,252,-7676.36,-1406.48,-270.633,0,0,0,0,100,0),
(@SIMONE_WPID,253,-7666.01,-1398.22,-270.739,0,0,0,0,100,0),
(@SIMONE_WPID,254,-7656.14,-1389.83,-269.454,0,0,0,0,100,0),
(@SIMONE_WPID,255,-7646.1,-1381.3,-269.631,0,0,0,0,100,0),
(@SIMONE_WPID,256,-7633.01,-1374.92,-270.888,0,0,0,0,100,0),
(@SIMONE_WPID,257,-7620.15,-1368.28,-271.951,0,0,0,0,100,0),
(@SIMONE_WPID,258,-7607.09,-1361.54,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,259,-7593.97,-1354.76,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,260,-7580.95,-1348.04,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,261,-7567.9,-1341.3,-271.944,0,0,0,0,100,0),
(@SIMONE_WPID,262,-7557.08,-1330.10,-271.315,0,0,0,0,100,0),
(@SIMONE_WPID,263,-7546.40,-1318.69,-271.423,0,0,0,0,100,0),
(@SIMONE_WPID,264,-7536.01,-1307.33,-271.797,0,0,0,0,100,0),
(@SIMONE_WPID,265,-7525.54,-1295.88,-272.203,0,0,0,0,100,0),
(@SIMONE_WPID,266,-7515.1,-1284.46,-271.69,0,0,0,0,100,0),
(@SIMONE_WPID,267,-7508.60,-1268.31,-270.367,0,0,0,0,100,0),
(@SIMONE_WPID,268,-7502.42,-1252.06,-269.497,0,0,0,0,100,0),
(@SIMONE_WPID,269,-7504.78,-1237.10,-269.414,0,0,0,0,100,0),
(@SIMONE_WPID,270,-7507.72,-1222.45,-269.740,0,0,0,0,100,0),
(@SIMONE_WPID,271,-7510.67,-1207.70,-268.987,0,0,0,0,100,0),
(@SIMONE_WPID,272,-7513.66,-1192.83,-269.189,0,0,0,0,100,0),
(@SIMONE_WPID,273,-7516.62,-1178.08,-271.383,0,0,0,0,100,0),
(@SIMONE_WPID,274,-7505.72,-1168.37,-271.077,0,0,0,0,100,0),
(@SIMONE_WPID,275,-7495.84,-1159.14,-269.334,0,0,0,0,100,0),
(@SIMONE_WPID,276,-7486.49,-1148.19,-271.035,0,0,0,0,100,0),
(@SIMONE_WPID,277,-7477.41,-1137.00,-272.383,0,0,0,0,100,0),
(@SIMONE_WPID,278,-7467.71,-1125.05,-271.785,0,0,0,0,100,0),
(@SIMONE_WPID,279,-7458.12,-1113.23,-271.741,0,0,0,0,100,0),
(@SIMONE_WPID,280,-7448.63,-1101.55,-271.191,0,0,0,0,100,0),
(@SIMONE_WPID,281,-7439.16,-1089.87,-270.483,0,0,0,0,100,0),
(@SIMONE_WPID,282,-7428.43,-1078.22,-269.067,0,0,0,0,100,0),
(@SIMONE_WPID,283,-7418.18,-1066.56,-270.011,0,0,0,0,100,0),
(@SIMONE_WPID,284,-7407.61,-1054.53,-270.546,0,0,0,0,100,0),
(@SIMONE_WPID,285,-7396.97,-1042.43,-271.297,0,0,0,0,100,0),
(@SIMONE_WPID,286,-7386.35,-1030.34,-271.884,0,0,0,0,100,0),
(@SIMONE_WPID,287,-7382.82,-1016.07,-271.634,0,0,0,0,100,0),
(@SIMONE_WPID,288,-7379.42,-1001.29,-271.409,0,0,0,0,100,0),
(@SIMONE_WPID,289,-7370.96,-985.551,-270.788,0,0,0,0,100,0),
(@SIMONE_WPID,290,-7363.46,-971.058,-271.653,0,0,0,0,100,0),
(@SIMONE_WPID,291,-7355.48,-955.622,-271.426,0,0,0,0,100,0),
(@SIMONE_WPID,292,-7344.05,-946.554,-269.778,0,0,0,0,100,0),
(@SIMONE_WPID,293,-7332.81,-937.077,-268.705,0,0,0,0,100,0),
(@SIMONE_WPID,294,-7320.84,-926.977,-270.566,0,0,0,0,100,0),
(@SIMONE_WPID,295,-7304.25,-925.122,-270.666,0,0,0,0,100,0),
(@SIMONE_WPID,296,-7287.81,-923.019,-269.745,0,0,0,0,100,0),
(@SIMONE_WPID,297,-7274.82,-917.243,-271.10,0,0,0,0,100,0),
(@SIMONE_WPID,298,-7262.07,-911.279,-271.53,0,0,0,0,100,0),
(@SIMONE_WPID,299,-7248.12,-904.753,-272.24,0,0,0,0,100,0),
(@SIMONE_WPID,300,-7236.21,-897.030,-271.225,0,0,0,0,100,0),
(@SIMONE_WPID,301,-7224.42,-889.063,-272.044,0,0,0,0,100,0),
(@SIMONE_WPID,302,-7212.15,-880.771,-271.128,0,0,0,0,100,0),
(@SIMONE_WPID,303,-7195.90,-884.171,-271.957,0,0,0,0,100,0),
(@SIMONE_WPID,304,-7179.54,-887.271,-272.052,0,0,0,0,100,0),
(@SIMONE_WPID,305,-7164.34,-890.150,-271.235,0,0,0,0,100,0),
(@SIMONE_WPID,306,-7149.97,-892.875,-271.069,0,0,0,0,100,0),
(@SIMONE_WPID,307,-7131.26,-888.674,-272.03,0,0,0,0,100,0),
(@SIMONE_WPID,308,-7112.65,-884.181,-271.47,0,0,0,0,100,0),
(@SIMONE_WPID,309,-7102.90,-875.574,-271.450,0,0,0,0,100,0),
(@SIMONE_WPID,310,-7093.29,-866.690,-272.204,0,0,0,0,100,0),
(@SIMONE_WPID,311,-7083.01,-857.189,-272.220,0,0,0,0,100,0),
(@SIMONE_WPID,312,-7072.05,-847.054,-272.178,0,0,0,0,100,0),
(@SIMONE_WPID,313,-7067.83,-836.058,-272.202,0,0,0,0,100,0),
(@SIMONE_WPID,314,-7063.79,-824.968,-271.531,0,0,0,0,100,0),
(@SIMONE_WPID,315,-7059.61,-813.457,-271.303,0,0,0,0,100,0),
(@SIMONE_WPID,316,-7048.82,-812.106,-271.697,0,0,0,0,100,0),
(@SIMONE_WPID,317,-7037.96,-810.598,-271.845,0,0,0,0,100,0),
(@SIMONE_WPID,318,-7027.44,-809.139,-272.117,0,0,0,0,100,0),
(@SIMONE_WPID,319,-7016.69,-807.647,-271.597,0,0,0,0,100,0),
(@SIMONE_WPID,320,-7009.76,-799.344,-272.041,0,0,0,0,100,0),
(@SIMONE_WPID,321,-7003.04,-790.963,-273.025,0,0,0,0,100,0),
(@SIMONE_WPID,322,-6996.69,-783.043,-272.410,0,0,0,0,100,0),
(@SIMONE_WPID,323,-6989.49,-774.052,-269.931,0,0,0,0,100,0),
(@SIMONE_WPID,324,-6984.47,-759.746,-267.759,0,0,0,0,100,0),
(@SIMONE_WPID,325,-6979.9,-745.278,-265.937,0,0,0,0,100,0),
(@SIMONE_WPID,326,-6982.18,-733.157,-265.618,0,0,0,0,100,0),
(@SIMONE_WPID,327,-6984.88,-720.872,-267.025,0,0,0,0,100,0),
(@SIMONE_WPID,328,-6987.37,-709.513,-268.536,0,0,0,0,100,0),
(@SIMONE_WPID,329,-6989.87,-698.109,-269.301,0,0,0,0,100,0),
(@SIMONE_WPID,330,-6994.73,-688.690,-270.518,0,0,0,0,100,0),
(@SIMONE_WPID,331,-6999.91,-679.855,-271.857,0,0,0,0,100,0),
(@SIMONE_WPID,332,-7003.90,-673.045,-272.215,0,0,0,0,100,0),
(@SIMONE_WPID,333,-7009.78,-662.996,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,334,-7015.69,-652.915,-272.221,0,0,0,0,100,0),
(@SIMONE_WPID,335,-7021.6,-642.837,-272.155,0,0,0,0,100,0),
(@SIMONE_WPID,336,-7028.90,-637.001,-271.888,0,0,0,0,100,0),
(@SIMONE_WPID,337,-7036.41,-631.543,-271.606,0,0,0,0,100,0),
(@SIMONE_WPID,338,-7045.73,-624.768,-272.084,0,0,0,0,100,0),
(@SIMONE_WPID,339,-7055.15,-617.920,-271.757,0,0,0,0,100,0),
(@SIMONE_WPID,340,-7064.50,-611.130,-271.627,0,0,0,0,100,0),
(@SIMONE_WPID,341,-7073.85,-604.336,-270.318,0,0,0,0,100,0),
(@SIMONE_WPID,342,-7083.48,-611.314,-270.053,0,0,0,0,100,0),
(@SIMONE_WPID,343,-7093.09,-618.408,-271.013,0,0,0,0,100,0),
(@SIMONE_WPID,344,-7102.19,-625.129,-270.782,0,0,0,0,100,0),
(@SIMONE_WPID,345,-7111.61,-632.079,-272.327,0,0,0,0,100,0),
(@SIMONE_WPID,346,-7123.46,-632.183,-270.63,0,0,0,0,100,0),
(@SIMONE_WPID,347,-7135.38,-632.426,-267.289,0,0,0,0,100,0);

SET @SIMONE_ENTRY := 14527;
SET @SIMONE_GUID := 24439;

-- Set MovementType and path_id
UPDATE `creature` SET `MovementType` = 2 WHERE (`id` = @SIMONE_ENTRY) AND (`guid` = @SIMONE_GUID);
UPDATE `creature_addon` SET `path_id` = @SIMONE_WPID WHERE (`guid` = @SIMONE_GUID);

-- Change the spawn location coordinates
DELETE FROM `creature` WHERE (`id` = @SIMONE_ENTRY) AND (`guid` IN (@SIMONE_GUID));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@SIMONE_GUID, @SIMONE_ENTRY, 1, 0, 0, 1, 1, 14588, 0, -7135.380859, -632.425903, -267.28894, 6.260877, 600, 0, 0, 19536, 12170, 2, 0, 0, 0, '', 0);

-- Allow player interaction, remove the quest item from the humanoid form, set Movement Type and change the Script Name
UPDATE `creature_template`
SET `npcflag` = 1,
    `unit_flags2` = 18432,
    `MovementType` = 2,
    `lootid` = 0,
    `ScriptName` = 'npc_simone'
WHERE (`entry` = @SIMONE_ENTRY);

-- Delete the unused loot_template
DELETE FROM `creature_loot_template` WHERE `Entry` = @SIMONE_ENTRY;

-- Add creature text for gossip option
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(@SIMONE_ENTRY, 0, 0, "I am not fooled by your disguise, temptress. Your time to die has come.", 0, 0, 0, 0, 0, 0, 9755, "Simone the Inconspicuous");

-- Correct Simone evil entry speed_walk
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14533);

-- Precious - Simone's pet
SET @PRECIOUS_ENTRY := 14528;
SET @PRECIOUS_GUID := 24440;

-- Change the spawn location coordinates
DELETE FROM `creature` WHERE (`id` = @PRECIOUS_ENTRY) AND (`guid` IN (@PRECIOUS_GUID));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@PRECIOUS_GUID, @PRECIOUS_ENTRY, 1, 0, 0, 1, 1, 855, 0, -7140.185547, -632.318848, -265.525787, 6.26088, 600, 0, 0, 3052, 0, 0, 0, 0, 0, '', 0);

-- Allow player interaction and change the Script Name
UPDATE `creature_template`
SET `npcflag` = 1,
    `unit_flags2` = 18432,
    `ScriptName` = 'npc_precious'
WHERE (`entry` = @PRECIOUS_ENTRY);

-- Correct Precious evil entry speed_walk
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14538);

-- Create a creature formation for Simone and Precious
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@SIMONE_GUID, @SIMONE_GUID, 0, 0, 515, 0, 0),
(@SIMONE_GUID, @PRECIOUS_GUID, 5, 180, 515, 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_28_02' WHERE sql_rev = '1626440153363170757';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
