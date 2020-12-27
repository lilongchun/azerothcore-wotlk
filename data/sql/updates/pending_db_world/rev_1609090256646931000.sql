INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609090256646931000');

-- Cleanup existing creatures
DELETE FROM creature WHERE GUID IN (
    85883 -- Yellowgill Frenzy, will be replaced by 145345 (otherwise would be duplicate)
);

-- Fix existing creatures (missing wandering behaviour)
UPDATE `creature` SET `wander_distance` = 15, `MovementType` = 1 WHERE `guid` IN (
    85886, -- Yellowgill Frenzy
    82791, -- Lesser Scourgebat
    82793, -- Lesser Scourgebat
    82794, -- Lesser Scourgebat
    82800, -- Lesser Scourgebat
    82802, -- Lesser Scourgebat
    82554, -- Whitetail Frenzy
    82555  -- Whitetail Frenzy
);
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (
    55814, -- Crazed Dragonhawk
    55897, -- Crazed Dragonhawk
    55922, -- Springpaw Stalker
    55942, -- Springpaw Stalker
    55945, -- Springpaw Stalker
    55946, -- Springpaw Stalker
    55980, -- Springpaw Stalker
    55981, -- Springpaw Stalker
    55983, -- Springpaw Stalker
    55984, -- Springpaw Stalker
    55749, -- Feral Dragonhawk Hatchling
    55768, -- Feral Dragonhawk Hatchling
    55775, -- Feral Dragonhawk Hatchling
    55778, -- Feral Dragonhawk Hatchling
    55786  -- Feral Dragonhawk Hatchling
);

-- #################### Import original fix by @Kittnz from TC, adapted to AC ####################

SET @CGUID:=145211;

-- Add missing creature spawns in Ghostlands & Eversong Woods
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+215;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`) VALUES
(@CGUID+0  , 1420, 530, 6785.898, -7607.692, 128.1121, 3.815103, 120, 0), -- Toad
(@CGUID+1  , 1420, 530, 6753.482, -7647.198, 128.3187, 3.793595, 120, 0), -- 1420 (Area: -1)
(@CGUID+2  , 2914, 530, 6830.517, -7396.761, 46.36444, 2.204267, 120, 0), -- Snake
(@CGUID+3  , 2914, 530, 6967.708, -7464.932, 47.05861, 1.433785, 120, 0), -- 2914 (Area: 3508)
(@CGUID+4  , 2914, 530, 6764.093, -7363.276, 50.46708, 2.048597, 120, 0), -- 2914 (Area: 3517)
(@CGUID+5  , 2914, 530, 6703.647, -7402.308, 51.60884, 5.743487, 120, 0), -- 2914 (Area: 3517)
(@CGUID+6  , 2914, 530, 9898.549, -6844.095, 21.79119, 5.635744, 120, 0), -- 2914 (Area: 0)
(@CGUID+7  , 2914, 530, 9200.372, -7787.419, 114.7875, 3.199877, 120, 0), -- 2914 (Area: 3480)
(@CGUID+8  , 2914, 530, 9155.745, -7848.188, 106.3085, 5.677832, 120, 0), -- 2914 (Area: 3480) (possible waypoints or random movement)
(@CGUID+9  , 2914, 530, 8850.941, -7711.045, 142.8265, 0.9482585, 120, 0), -- 2914 (Area: 0)
(@CGUID+10 , 2914, 530, 8728.21, -7871.131, 167.5767, 3.596344, 120, 0), -- 2914 (Area: 3476)
(@CGUID+11 , 2914, 530, 8637.07, -8030.312, 172.4991, 0.7605414, 120, 0), -- 2914 (Area: 3476) (possible waypoints or random movement)
(@CGUID+12 , 2914, 530, 8105.803, -7868.944, 182.6229, 3.106677, 120, 0), -- 2914 (Area: 3476)
(@CGUID+13 , 13321, 530, 6804.864, -7692.796, 123.9494, 1.613627, 120, 0), -- Frog
(@CGUID+14 , 13321, 530, 7139.874, -6836.952, 42.78193, 3.004393, 120, 0), -- 13321 (Area: 0)
(@CGUID+15 , 13321, 530, 6874.098, -6292.956, 28.83097, 2.986305, 120, 0), -- 13321 (Area: 0)
(@CGUID+16 , 13321, 530, 6896.695, -6237.083, 27.97087, 3.193066, 120, 0), -- 13321 (Area: 0)
(@CGUID+17 , 16355, 530, 6590.018, -6665.895, 47.47748, 3.028023, 120, 0), -- Lesser Scourgebat
(@CGUID+18 , 16355, 530, 6615.374, -6649.544, 47.67059, 2.618959, 120, 0), -- 16355 (Area: 3861)
(@CGUID+19 , 16355, 530, 6678.834, -6669.411, 46.41251, 2.527587, 120, 0), -- 16355 (Area: 3861)
(@CGUID+20 , 16355, 530, 6751.53, -6650.502, 40.92892, 3.361847, 120, 0), -- 16355 (Area: 3861)
(@CGUID+21 , 16355, 530, 6694.581, -6614.153, 42.82938, 1.788726, 120, 0), -- 16355 (Area: 3861)
(@CGUID+22 , 16355, 530, 6746.584, -6637.266, 40.26681, 1.167443, 120, 0), -- 16355 (Area: 3861)
(@CGUID+23 , 16355, 530, 6613.917, -6613.427, 45.56771, 1.741399, 120, 0), -- 16355 (Area: 0)
(@CGUID+24 , 16355, 530, 6709.029, -6582.425, 38.43601, 3.079052, 120, 0), -- 16355 (Area: 0)
(@CGUID+25 , 16355, 530, 6655.542, -6584.168, 47.69909, 1.860139, 120, 0), -- 16355 (Area: 0)
(@CGUID+26 , 16355, 530, 6777.141, -6576.169, 22.53009, 2.004029, 120, 0), -- 16355 (Area: 5779)
(@CGUID+27 , 16355, 530, 6820.745, -6629.127, 29.34797, 4.576158, 120, 0), -- 16355 (Area: 0)
(@CGUID+28 , 16355, 530, 6913.5, -6392.067, 32.9911, 1.252754, 120, 0), -- 16355 (Area: 3514)
(@CGUID+29 , 16355, 530, 6786.887, -6389.533, 33.69895, 1.401155, 120, 0), -- 16355 (Area: 3514)
(@CGUID+30 , 16355, 530, 6834.158, -6266.923, 28.88157, 0.7696482, 120, 0), -- 16355 (Area: 0)
(@CGUID+31 , 16355, 530, 6811.086, -6309.688, 32.27558, 6.07257, 120, 0), -- 16355 (Area: 0)
(@CGUID+32 , 16355, 530, 6746.925, -6374.906, 38.59792, 0.9527051, 120, 0), -- 16355 (Area: 0)
(@CGUID+33 , 16355, 530, 6743.388, -6254.041, 35.68666, 0.4505479, 120, 0), -- 16355 (Area: 0)
(@CGUID+34 , 16352, 530, 6607.711, -7228.053, 47.55958, 2.182768, 120, 0), -- Greater Spindleweb
(@CGUID+35 , 16352, 530, 6840.333, -6911.398, 80.30796, 5.87111, 120, 0), -- 16352 (Area: 0)
(@CGUID+36 , 16352, 530, 6950.854, -6882.652, 51.16842, 4.52, 120, 0), -- 16352 (Area: 3506)
(@CGUID+37 , 16352, 530, 6768.055, -6851.429, 87.48727, 5.528165, 120, 0), -- 16352 (Area: 0)
(@CGUID+38 , 16352, 530, 6770.479, -6850.35, 87.49597, 3.62482, 120, 0), -- 16352 (Area: 0)
(@CGUID+39 , 16352, 530, 6559.612, -6826.08, 105.455, 4.570914, 120, 0), -- 16352 (Area: 0)
(@CGUID+40 , 16352, 530, 6601.431, -6767.694, 109.1149, 4.307267, 120, 0), -- 16352 (Area: 0)
(@CGUID+41 , 16352, 530, 6599.975, -6751.242, 116.5198, 3.551486, 120, 0), -- 16352 (Area: 0)
(@CGUID+42 , 16352, 530, 7008.281, -6705.673, 28.26144, 4.884287, 120, 0), -- 16352 (Area: 0)
(@CGUID+43 , 16352, 530, 6871.393, -6317.614, 32.46682, 3.043771, 120, 0), -- 16352 (Area: 3514)
(@CGUID+44 , 16352, 530, 6878.775, -6305.776, 31.08891, 5.672717, 120, 0), -- 16352 (Area: 3514)
(@CGUID+45 , 16352, 530, 6843.483, -6281.33, 26.38034, 3.213944, 120, 0), -- 16352 (Area: 0)
(@CGUID+46 , 16352, 530, 6876.344, -6120.826, 27.65071, 0.7722683, 120, 0), -- 16352 (Area: 0)
(@CGUID+47 , 16352, 530, 6918.788, -6012.118, 16.0651, 0.2698549, 120, 0), -- 16352 (Area: 0)
(@CGUID+48 , 16352, 530, 6780.824, -5914.694, 55.04383, 4.475933, 120, 0), -- 16352 (Area: 0)
(@CGUID+49 , 16352, 530, 6833.493, -5866.168, 14.88271, 0.9358938, 120, 0), -- 16352 (Area: 0)
(@CGUID+50 , 16352, 530, 6840.229, -5885.817, 18.84746, 0.9175394, 120, 0), -- 16352 (Area: 0)
(@CGUID+51 , 16352, 530, 6880.296, -5831.833, 12.60031, 4.379216, 120, 0), -- 16352 (Area: 0)
(@CGUID+52 , 16352, 530, 6921.029, -5888.282, 11.06036, 3.010598, 120, 0), -- 16352 (Area: 0)
(@CGUID+53 , 16349, 530, 6889.151, -7353.237, 48.22483, 4.51504, 120, 0), -- Ghostclaw Ravager
(@CGUID+54 , 16349, 530, 6842.837, -7303.427, 54.16766, 1.288876, 120, 0), -- 16349 (Area: 3517)
(@CGUID+55 , 16349, 530, 6546.021, -7284.988, 56.26369, 1.260878, 120, 0), -- 16349 (Area: 3517)
(@CGUID+56 , 16349, 530, 6679.54, -7225.896, 45.35223, 4.113977, 120, 0), -- 16349 (Area: 3517)
(@CGUID+57 , 16349, 530, 6643.776, -7193.75, 54.53874, 0, 120, 0), -- 16349 (Area: 3517)
(@CGUID+58 , 16349, 530, 6814.677, -6882.684, 88.09016, 2.293302, 120, 0), -- 16349 (Area: 0)
(@CGUID+59 , 16349, 530, 6721.141, -6838.881, 103.265, 6.057627, 120, 0), -- 16349 (Area: 0)
(@CGUID+60 , 16349, 530, 6697.734, -6834.776, 102.7457, 6.008372, 120, 0), -- 16349 (Area: 0)
(@CGUID+61 , 16349, 530, 6650.794, -6857.804, 114.3118, 2.645206, 120, 0), -- 16349 (Area: 0)
(@CGUID+62 , 16349, 530, 6848.059, -6343.108, 31.09843, 4.492753, 120, 0), -- 16349 (Area: 3514)
(@CGUID+63 , 16349, 530, 6946.989, -6384.78, 39.4313, 4.954051, 120, 0), -- 16349 (Area: 3514)
(@CGUID+64 , 16349, 530, 6912.969, -6363.86, 34.72787, 3.331182, 120, 0), -- 16349 (Area: 3514)
(@CGUID+65 , 16349, 530, 6766.795, -6363.485, 39.13235, 0.5625338, 120, 0), -- 16349 (Area: 0)
(@CGUID+66 , 16349, 530, 6946.226, -6247.874, 32.41405, 5.925901, 120, 0), -- 16349 (Area: 0)
(@CGUID+67 , 16349, 530, 6788.563, -6065.623, 76.42849, 3.921466, 120, 0), -- 16349 (Area: 0)
(@CGUID+68 , 16349, 530, 6792.339, -6061.395, 74.22968, 3.969122, 120, 0), -- 16349 (Area: 0)
(@CGUID+69 , 16349, 530, 6810.644, -5954.92, 53.78344, 3.796812, 120, 0), -- 16349 (Area: 0)
(@CGUID+70 , 16348, 530, 7063.472, -7130.528, 46.0153, 6.204991, 120, 0), -- Ghostclaw Lynx
(@CGUID+71 , 16348, 530, 7284.161, -6991.957, 49.69464, 1.443535, 120, 0), -- 16348 (Area: 0)
(@CGUID+72 , 16348, 530, 7213.42, -6959.183, 48.15844, 1.778343, 120, 0), -- 16348 (Area: 0)
(@CGUID+73 , 16348, 530, 7250.096, -6969.17, 47.61874, 1.986341, 120, 0), -- 16348 (Area: 0)
(@CGUID+74 , 16348, 530, 7050.619, -6915.433, 49.37156, 2.73385, 120, 0), -- 16348 (Area: 0)
(@CGUID+75 , 16348, 530, 7451.216, -7814.882, 147.9057, 3.899374, 120, 0), -- 16348 (Area: 3516)
(@CGUID+76 , 16348, 530, 7396.958, -7735.421, 126.7814, 2.59045, 120, 0), -- 16348 (Area: 3516)
(@CGUID+77 , 16348, 530, 7340.802, -7687.29, 114.7227, 0.2125256, 120, 0), -- 16348 (Area: 3516)
(@CGUID+78 , 16348, 530, 7183.236, -7268.509, 46.15837, 4.739726, 120, 0), -- 16348 (Area: -1)
(@CGUID+79 , 16348, 530, 7229.547, -7256.011, 50.49553, 3.413854, 120, 0), -- 16348 (Area: -1)
(@CGUID+80 , 16348, 530, 7087.505, -7228.648, 47.83735, 2.820592, 120, 0), -- 16348 (Area: -1)
(@CGUID+81 , 16348, 530, 7216.22, -6980.535, 45.21544, 2.602345, 120, 0), -- 16348 (Area: -1)
(@CGUID+82 , 16348, 530, 7314.215, -6966.182, 50.0986, 1.607889, 120, 0), -- 16348 (Area: 0)
(@CGUID+83 , 16348, 530, 7330.698, -6964.013, 48.61691, 2.429726, 120, 0), -- 16348 (Area: 0)
(@CGUID+84 , 16348, 530, 7381.186, -6840.756, 49.09549, 5.203093, 120, 0), -- 16348 (Area: 0)
(@CGUID+85 , 16348, 530, 7338.635, -6880.206, 47.74126, 3.243301, 120, 0), -- 16348 (Area: 0)
(@CGUID+86 , 16348, 530, 7245.959, -6846.432, 44.47991, 3.107588, 120, 0), -- 16348 (Area: 0)
(@CGUID+87 , 16348, 530, 7271.94, -6770.036, 41.23086, 3.766337, 120, 0), -- 16348 (Area: 0)
(@CGUID+88 , 16348, 530, 7214.612, -6826.908, 47.06087, 1.656858, 120, 0), -- 16348 (Area: 0)
(@CGUID+89 , 16354, 530, 7076.276, -6972.893, 46.59879, 5.554435, 120, 0), -- Vampiric Mistbat
(@CGUID+90 , 16354, 530, 7017.884, -6890.591, 51.47795, 0.1461384, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+91 , 16354, 530, 7113.623, -6924.28, 47.51407, 1.275599, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+92 , 16354, 530, 7120.204, -6986.206, 46.46815, 3.014331, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+93 , 16354, 530, 7042.884, -7063.796, 47.43617, 0.2345574, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+94 , 16354, 530, 7126.826, -6958.08, 46.08292, 1.337121, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+95 , 16354, 530, 7014.953, -7154.451, 44.05517, 4.580289, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+96 , 16354, 530, 7049.035, -7179.571, 44.51942, 2.854439, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+97 , 16354, 530, 7192.258, -6990.721, 45.789, 6.118358, 120, 0), -- 16354 (Area: 3493) (Auras: 29363 - 29363)
(@CGUID+98 , 16354, 530, 7297.3, -6952.889, 48.22968, 0.04103268, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+99 , 16354, 530, 7256.268, -6915.919, 49.01978, 6.275373, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+100, 16354, 530, 7100.769, -6852.027, 48.50787, 3.594324, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+101, 16354, 530, 7115.031, -6797.596, 43.95771, 4.893901, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+102, 16354, 530, 7046.083, -6001.001, 5.373741, 1.707996, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+103, 16354, 530, 7657.632, -7820.115, 155.0192, 0.007812341, 120, 0), -- 16354 (Area: 5780) (Auras: 29363 - 29363)
(@CGUID+104, 16354, 530, 7625.615, -7846.144, 163.4028, 4.013608, 120, 0), -- 16354 (Area: 5780) (Auras: 29363 - 29363)
(@CGUID+105, 16354, 530, 7122.203, -7253.339, 46.5706, 5.714052, 120, 0), -- 16354 (Area: -1) (Auras: 29363 - 29363)
(@CGUID+106, 16354, 530, 7217.567, -6982.356, 45.42596, 2.619296, 120, 0), -- 16354 (Area: -1) (Auras: 29363 - 29363)
(@CGUID+107, 16354, 530, 7117.631, -7009.641, 45.96103, 1.385088, 120, 0), -- 16354 (Area: -1) (Auras: 29363 - 29363)
(@CGUID+108, 16354, 530, 7166.285, -6976.54, 44.8732, 4.951204, 120, 0), -- 16354 (Area: -1) (Auras: 29363 - 29363)
(@CGUID+109, 16354, 530, 7312.727, -6912.875, 50.63189, 4.525721, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+110, 16354, 530, 7320.769, -6873.548, 46.65247, 4.479732, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+111, 16354, 530, 7280.374, -6883.919, 46.72137, 2.94094, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+112, 16354, 530, 7311.557, -6785.887, 42.1341, 3.170881, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+113, 16354, 530, 7346.644, -6818.584, 45.92062, 3.949025, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+114, 16354, 530, 7288.737, -6849.499, 44.25882, 4.882647, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+115, 16354, 530, 7377.227, -6753.976, 31.68961, 0.03127035, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+116, 16354, 530, 7416.598, -6716.583, 28.30837, 0.7370265, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+117, 16354, 530, 7353.333, -6720.048, 30.60197, 2.399705, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+118, 16354, 530, 7259.75, -6787.555, 40.84682, 6.201098, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+119, 16354, 530, 7108.942, -6779.335, 39.96529, 5.709267, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+120, 16354, 530, 7133.71, -6917.99, 50.83417, 2.893063, 120, 0), -- 16354 (Area: 0) (Auras: 29363 - 29363)
(@CGUID+121, 16405, 530, 6988.21, -5644.906, -3.24633, 3.193715, 120, 0), -- Whitetail Frenzy (fishy!)
(@CGUID+122, 16405, 530, 7185.634, -5581.585, -7.89854, 1.237991, 120, 0), -- 16405 (Area: 3455) (possible waypoints or random movement)
(@CGUID+123, 16405, 530, 7125.062, -5516.672, -5.845787, 0.05448707, 120, 0), -- 16405 (Area: 3455)
(@CGUID+124, 16405, 530, 7250.163, -5645.383, -4.686822, 1.609466, 120, 0), -- 16405 (Area: 3455) (possible waypoints or random movement)
(@CGUID+125, 16405, 530, 7251.583, -5518.657, -14.82046, 5.090523, 120, 0), -- 16405 (Area: 3455)
(@CGUID+126, 16405, 530, 7319, -5583.684, -5.345567, 4.631339, 120, 0), -- 16405 (Area: 3455)
(@CGUID+127, 16405, 530, 7385.255, -5514.504, -23.83957, 4.482534, 120, 0), -- 16405 (Area: 3455)
(@CGUID+128, 16404, 530, 7453.585, -5582.35, -4.679311, 1.291544, 120, 0), -- Yellowgill Frenzy (fishy!)
(@CGUID+129, 16404, 530, 7650.671, -5514.592, -49.15406, 0.4712389, 120, 0), -- 16404 (Area: 3455)
(@CGUID+130, 16404, 530, 7584.502, -5583.413, -24.85344, 3.455752, 120, 0), -- 16404 (Area: 3455)
(@CGUID+131, 16404, 530, 7583.759, -5452.181, -46.03991, 2.70526, 120, 0), -- 16404 (Area: 3455)
(@CGUID+132, 16404, 530, 7714.01, -5449.991, -64.69885, 5.61996, 120, 0), -- 16404 (Area: 3455)
(@CGUID+133, 16404, 530, 7646.778, -5386.804, -65.33501, 3.752458, 120, 0), -- 16404 (Area: 3455)
(@CGUID+134, 16404, 530, 7782.522, -5520.318, -25.0596, 2.251475, 120, 0), -- 16404 (Area: 3455)
(@CGUID+135, 16404, 530, 7851.458, -5451.522, -47.55369, 0.6981317, 120, 0), -- 16404 (Area: 3455)
(@CGUID+136, 16404, 530, 7916.752, -5518.634, -40.62648, 0.08726646, 120, 0), -- 16404 (Area: 3455)
(@CGUID+137, 16404, 530, 7981.461, -5584.885, -4.679321, 2.984513, 120, 0), -- 16404 (Area: 3455)
(@CGUID+138, 16404, 530, 7981.47, -5453.279, -45.36422, 2.443461, 120, 0), -- 16404 (Area: 3455)
(@CGUID+139, 16404, 530, 8049.632, -5517.96, -25.7112, 5.201081, 120, 0), -- 16404 (Area: 3455)
(@CGUID+140, 16404, 530, 8116.961, -5448.617, -46.06174, 0.6981317, 120, 0), -- 16404 (Area: 3455)
(@CGUID+141, 16404, 530, 8115.655, -5582.934, -4.67935, 3.071779, 120, 0), -- 16404 (Area: 3455)
(@CGUID+142, 16404, 530, 8181.515, -5517.779, -21.47383, 3.996804, 120, 0), -- 16404 (Area: 3455)
(@CGUID+143, 33712, 530, 8581.657, -5615.35, -1.142317, 1.903857, 120, 0), -- Golden Crawler
(@CGUID+144, 33712, 530, 8504.382, -5543.861, -1.478864, 3.13378, 120, 0), -- 33712 (Area: 3460)
(@CGUID+145, 33712, 530, 8514.937, -5619.518, -0.04902005, 2.168977, 120, 0), -- 33712 (Area: 3460)
(@CGUID+146, 33712, 530, 8415.799, -5584.587, -1.309665, 0, 120, 0), -- 33712 (Area: 3460)
(@CGUID+147, 33712, 530, 8332.279, -5641.95, -1.466211, 2.25529, 120, 0), -- 33712 (Area: 3460)
(@CGUID+148, 33712, 530, 8283.341, -5648.665, -1.085784, 0, 120, 0), -- 33712 (Area: 3460)
(@CGUID+149, 33712, 530, 8282.833, -5682.408, 1.912665, 1.05757, 120, 0), -- 33712 (Area: 3460)
(@CGUID+150, 33712, 530, 8293.516, -5772.522, 0.8719814, 5.366834, 120, 0), -- 33712 (Area: 3460)
(@CGUID+151, 33712, 530, 8308.861, -5862.752, 0.241255, 6.083331, 120, 0), -- 33712 (Area: 3460)
(@CGUID+152, 33712, 530, 9197.843, -5831.596, -1.436119, 3.801267, 120, 0), -- 33712 (Area: 3911)
(@CGUID+153, 33712, 530, 9354.067, -5992.446, 0.5006291, 4.806949, 120, 0), -- 33712 (Area: 3911)
(@CGUID+154, 33712, 530, 9355.795, -6054.746, -10.57742, 5.58345, 120, 0), -- 33712 (Area: 3911)
(@CGUID+155, 15372, 530, 10655.46, -6208.573, 44.35903, 3.352107, 120, 0), -- Springpaw Lynx
(@CGUID+156, 15372, 530, 10664.23, -6132.04, 28.6685, 2.430012, 120, 0), -- 15372 (Area: 3431)
(@CGUID+157, 15372, 530, 10680.05, -6169.8, 39.0421, 1.041597, 120, 0), -- 15372 (Area: 3431)
(@CGUID+158, 721, 530, 8518.23, -5731.495, 13.00602, 3.633779, 120, 0), -- Rabbit
(@CGUID+159, 721, 530, 8639.186, -5761.18, 11.46758, 3.938846, 120, 0), -- 721 (Area: 3460)
(@CGUID+160, 721, 530, 8778.733, -5847.375, 7.75886, 4.726789, 120, 0), -- 721 (Area: 3460)
(@CGUID+161, 721, 530, 8984.896, -5983.854, 19.71628, 4.000124, 120, 0), -- 721 (Area: 3911)
(@CGUID+162, 721, 530, 9145.909, -5946.4, 28.77039, 2.019282, 120, 0), -- 721 (Area: 3911)
(@CGUID+163, 721, 530, 9231.008, -6160.386, 25.5099, 0.5819958, 120, 0), -- 721 (Area: 3911)
(@CGUID+164, 721, 530, 9452.181, -7939.893, 11.60837, 3.357151, 120, 0), -- 721 (Area: 3472)
(@CGUID+165, 721, 530, 9438.168, -7889.708, 21.39819, 2.464021, 120, 0), -- 721 (Area: 3472)
(@CGUID+166, 721, 530, 9396.646, -7802.477, 55.43135, 0.6543702, 120, 0), -- 721 (Area: 3480)
(@CGUID+167, 4075, 530, 6658.765, -6295.493, 29.20658, 2.160989, 120, 0), -- Rat
(@CGUID+168, 4075, 530, 7113.27, -5958.493, 12.98514, 1.957865, 120, 0), -- 4075 (Area: 0)
(@CGUID+169, 4075, 530, 7308.667, -5989.029, 16.2368, 2.572109, 120, 0), -- 4075 (Area: 3491)
(@CGUID+170, 15649, 530, 10060.82, -6872.714, 24.29431, 4.285359, 120, 0), -- Feral Dragonhawk Hatchling
(@CGUID+171, 15651, 530, 8653.924, -5784.069, 18.15051, 3.120111, 120, 0), -- Springpaw Stalker
(@CGUID+172, 15651, 530, 10048.03, -6717.27, 31.03372, 4.651473, 120, 0), -- 15651 (Area: 3533)
(@CGUID+173, 15651, 530, 10116.2, -7079.959, 11.65078, 5.202464, 120, 0), -- 15651 (Area: 0)
(@CGUID+174, 15651, 530, 10119.57, -7117.229, 11.13619, 5.610377, 120, 0), -- 15651 (Area: 0)
(@CGUID+175, 15651, 530, 10245.07, -7154.263, 5.379348, 3.824573, 120, 0), -- 15651 (Area: 0)
(@CGUID+176, 15651, 530, 10312.5, -7285.686, 10.4436, 3.958998, 120, 0), -- 15651 (Area: 0)
(@CGUID+177, 15651, 530, 0155.74, -7315.172, 46.89272, 1.747505, 120, 0), -- 15651 (Area: 0)
(@CGUID+178, 15651, 530, 10212.78, -7312.304, 43.83004, 2.297004, 120, 0), -- 15651 (Area: 0)
(@CGUID+179, 15651, 530, 10120.49, -7380.654, 41.25549, 3.739351, 120, 0), -- 15651 (Area: 0)
(@CGUID+180, 15651, 530, 10222.12, -7377.514, 42.6799, 6.21672, 120, 0), -- 15651 (Area: 0)
(@CGUID+181, 15651, 530, 10287.61, -7510.908, 45.47846, 4.328416, 120, 0), -- 15651 (Area: 0)
(@CGUID+182, 15651, 530, 10307.25, -7600.326, 27.67019, 1.3225, 120, 0), -- 15651 (Area: 0)
(@CGUID+183, 15651, 530, 10261.34, -7483.148, 64.01847, 4.310963, 120, 0), -- 15651 (Area: 0)
(@CGUID+184, 15651, 530, 10222.87, -7613.924, 61.70162, 2.482553, 120, 0), -- 15651 (Area: 0)
(@CGUID+185, 15650, 530, 10279.31, -7324.253, 33.49329, 4.19599, 120, 0), -- Crazed Dragonhawk
(@CGUID+186, 15650, 530, 10192.26, -7320.828, 45.92649, 5.882011, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+187, 15650, 530, 10171.51, -7404.468, 48.17466, 5.125631, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+188, 15650, 530, 10225.49, -7453.733, 75.07253, 4.820997, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+189, 15650, 530, 10095.22, -7399.66, 33.8582, 1.982334, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+190, 15650, 530, 10089.92, -7352.991, 24.48084, 3.473843, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+191, 15650, 530, 10304.47, -7592.876, 23.93329, 4.038411, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+192, 15650, 530, 9840.896, -7878.327, 39.42878, 0.1114382, 120, 0), -- 15650 (Area: 3472) (Auras: 29119 - 29119)
(@CGUID+193, 15650, 530, 9008.495, -8056.905, 185.9688, 1.125495, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+194, 15650, 530, 9009.816, -7833.289, 159.5567, 4.887175, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+195, 15650, 530, 9015.15, -7667.337, 140.8466, 4.705554, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+196, 15650, 530, 8824.381, -7819.187, 175.3332, 3.444827, 120, 0), -- 15650 (Area: 0) (Auras: 29119 - 29119)
(@CGUID+197, 15650, 530, 8785.419, -7913.549, 175.9667, 0.7577809, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+198, 15650, 530, 8848.306, -7942.777, 220.488, 5.064994, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+199, 15650, 530, 8333.768, -8008.462, 206.4037, 2.313344, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+200, 15650, 530, 8269.027, -8019.356, 224.7379, 5.511599, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+201, 15650, 530, 8213.844, -7896.639, 190.6529, 2.801, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+202, 15650, 530, 8216.283, -7952.173, 209.498, 1.65485, 120, 0), -- 15650 (Area: 3476) (Auras: 29119 - 29119)
(@CGUID+203, 16541, 530, 7244.089, -7125.762, 61.12453, 0.4067548, 120, 0), -- Ghostlands Guardian
(@CGUID+204, 16541, 530, 7182.639, -7079.073, 56.25724, 2.565634, 120, 0), -- 16541 (Area: 0)
(@CGUID+205, 16541, 530, 7168.553, -7095.772, 56.25724, 2.426008, 120, 0), -- 16541 (Area: 0)
(@CGUID+206, 14881, 530, 6908.589, -7112.601, 45.76462, 0.250855, 120, 0), -- Spider
(@CGUID+207, 14881, 530, 7087.832, -7109.549, 46.94461, 3.255385, 120, 0), -- 14881 (Area: 0)
(@CGUID+208, 14881, 530, 6913.161, -6316.999, 33.59887, 5.188184, 120, 0), -- 14881 (Area: 3514)
(@CGUID+209, 14881, 530, 7177.549, -7263.504, 45.25873, 4.996254, 120, 0), -- 14881 (Area: -1) (possible waypoints or random movement)
(@CGUID+210, 14881, 530, 7295.609, -7026.236, 48.24609, 0.2017749, 120, 0), -- 14881 (Area: -1) (possible waypoints or random movement)
(@CGUID+211, 14881, 530, 7120.973, -6668.307, 45.87799, 1.187052, 120, 0), -- 14881 (Area: 0)
(@CGUID+212, 33713, 530, 6896.669, -5765.082, -2.75388, 1.12993, 120, 0), -- Rotting Crawler
(@CGUID+213, 33713, 530, 6853.869, -5738.312, -9.519895, 1.390244, 120, 0), -- 33713 (Area: 0)
(@CGUID+214, 33713, 530, 7173.716, -5696.389, -4.92298, 4.901935, 120, 0), -- 33713 (Area: 3491)
(@CGUID+215, 33713, 530, 7336.688, -5723.884, 0.3463151, 6.180531, 120, 0); -- 33713 (Area: 3491)

-- Update movement
UPDATE `creature` SET `wander_distance`=15, `MovementType`=1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+215;
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `guid` IN (@CGUID+203, @CGUID+204, @CGUID+205, @CGUID+206);
