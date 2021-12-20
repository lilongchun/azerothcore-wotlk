INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640038807964241732');

-- Deatholme

-- Nerubis Centurion
DELETE FROM  `creature_addon` WHERE `guid` IN (82916);
DELETE FROM `creature` WHERE `guid` IN (82818,82829,82840,82846,82850,82848,82839,82842,82815,82901,82887,82855,82888,82881,82928,82896,82909,82908,82910,82852,82920,82922,82900,82867,82864,82916,82932,82911,82919);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82818, 16319, 530, 0, 0, 1, 1, 0, 0, 6581.105, -6485.4365, 33.233646, 1.099293708801269531, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82829, 16319, 530, 0, 0, 1, 1, 0, 0, 6561.8086, -6515.17, 38.09421, 0.494669109582901, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82840, 16319, 530, 0, 0, 1, 1, 0, 0, 6550.5103, -6552.3706, 44.199574, 1.56420302391052246, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82846, 16319, 530, 0, 0, 1, 1, 0, 0, 6412.5293, -6518.6606, 74.43074, 2.714493751525878906, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82850, 16319, 530, 0, 0, 1, 1, 0, 0, 6384.405, -6509.0117, 72.4992, 0.564837634563446044, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82848, 16319, 530, 0, 0, 1, 1, 0, 0, 6384.482, -6481.5454, 67.04174, 2.160831212997436523, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82839, 16319, 530, 0, 0, 1, 1, 0, 0, 6576.7744, -6546.7017, 43.80678, 1.487325429916381835, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82842, 16319, 530, 0, 0, 1, 1, 0, 0, 6516.4673, -6586.0903, 48.73308, 3.798866748809814453, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82815, 16319, 530, 0, 0, 1, 1, 0, 0, 6612.5894, -6513.6636, 39.64091, 1.849565863609313964, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82901, 16319, 530, 0, 0, 1, 1, 0, 0, 6353.674, -6482.568, 75.093994, 0.246163085103034973, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82887, 16319, 530, 0, 0, 1, 1, 0, 0, 6317.2114, -6517.228, 87.92992, 5.205874443054199218, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82855, 16319, 530, 0, 0, 1, 1, 0, 0, 6365.7876, -6544.7544, 96.196976, 3.007664203643798828, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82888, 16319, 530, 0, 0, 1, 1, 0, 0, 6268.5576, -6495.762, 83.62719, 5.618587493896484375, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82881, 16319, 530, 0, 0, 1, 1, 0, 0, 6283.7954, -6419.302, 80.687416, 5.597385883331298828, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82928, 16319, 530, 0, 0, 1, 1, 0, 0, 6350.3813, -6350.46, 72.53874, 5.418449878692626953, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82896, 16319, 530, 0, 0, 1, 1, 0, 0, 6353.174, -6384.0405, 76.554146, 3.484583854675292968, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82909, 16319, 530, 0, 0, 1, 1, 0, 0, 6384.963, -6249.8877, 68.4682, 1.034315466880798339, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82908, 16319, 530, 0, 0, 1, 1, 0, 0, 6417.8384, -6220.2114, 68.71284, 3.629754304885864257, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82910, 16319, 530, 0, 0, 1, 1, 0, 0, 6450.1147, -6217.4277, 65.11041, 0.223844408988952636, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82852, 16319, 530, 0, 0, 1, 1, 0, 0, 6393.963, -6224.432, 71.70565, 1.079248666763305664, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82920, 16319, 530, 0, 0, 1, 1, 0, 0, 6585.8735, -6189.143, 55.144135, 5.561457157135009765, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82922, 16319, 530, 0, 0, 1, 1, 0, 0, 6555.6196, -6216.8433, 56.825527, 4.448106765747070312, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82900, 16319, 530, 0, 0, 1, 1, 0, 0, 6582.4326, -6217.3813, 51.98594, 4.87725687026977539, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82867, 16319, 530, 0, 0, 1, 1, 0, 0, 6280.9917, -6284.755, 80.68736, 3.94175267219543457, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82864, 16319, 530, 0, 0, 1, 1, 0, 0, 6255.983, -6312.3267, 80.68742, 3.191378116607666015, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82916, 16319, 530, 0, 0, 1, 1, 0, 0, 6270.9087, -6235.134, 80.71322, 4.917645454406738281, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82932, 16319, 530, 0, 0, 1, 1, 0, 0, 6353.2896, -6225.4243, 75.45075, 5.723421573638916015, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82911, 16319, 530, 0, 0, 1, 1, 0, 0, 6318.155, -6214.5474, 81.09549, 6.2657318115234375, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82919, 16319, 530, 0, 0, 1, 1, 0, 0, 6452.447, -6187.0083, 69.44556, 5.913648128509521484, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Eye of Dar'Khan
DELETE FROM `creature` WHERE `guid` IN (82809,82812,82821,82825,82828,82837,82838,82843,82849,82851,82854,82857,82860,82866,82872,82878,82885,82894,82904,82905,82918,82924,82925,82926,82930,82933,82934,82935,82939,82841,82897,82767);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82809, 16320, 530, 0, 0, 1, 1, 0, 0, 6690.8457, -6483.707, 29.342876, 6.038839340209960937, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0), -- .go xyz 6690.8457 -6483.707 29.342876
(82812, 16320, 530, 0, 0, 1, 1, 0, 0, 6698.8833, -6463.1177, 29.342873, 5.637413501739501953, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82821, 16320, 530, 0, 0, 1, 1, 0, 0, 6387.891, -6347.7515, 66.296326, 0.713450491428375244, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82825, 16320, 530, 0, 0, 1, 1, 0, 0, 6519.682, -6289.811, 48.231308, 0.18513798713684082, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82828, 16320, 530, 0, 0, 1, 1, 0, 0, 6614.4375, -6250.9478, 38.99294, 3.669034719467163085, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82837, 16320, 530, 0, 0, 1, 1, 0, 0, 6548.8677, -6449.5454, 36.760605, 2.419903993606567382, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82838, 16320, 530, 0, 0, 1, 1, 0, 0, 6481.387, -6550.543, 46.675175, 2.897648334503173828, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82843, 16320, 530, 0, 0, 1, 1, 0, 0, 6426.6904, -6652.983, 108.64974, 2.294112920761108398, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82849, 16320, 530, 0, 0, 1, 1, 0, 0, 6347.2617, -6434.587, 78.15677, 0.837758064270019531, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82851, 16320, 530, 0, 0, 1, 1, 0, 0, 6338.648, -6424.5195, 78.06884, 0.698131680488586425, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82854, 16320, 530, 0, 0, 1, 1, 0, 0, 6316.83, -6416.3457, 80.13354, 2.197876691818237304, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82857, 16320, 530, 0, 0, 1, 1, 0, 0, 6444.4673, -6383.0977, 55.26159, 4.433136463165283203, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82860, 16320, 530, 0, 0, 1, 1, 0, 0, 6412.2056, -6424.15, 61.375404, 3.799595594406127929, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82866, 16320, 530, 0, 0, 1, 1, 0, 0, 6335.4595, -6372.7456, 78.19714, 5.8817596435546875, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82872, 16320, 530, 0, 0, 1, 1, 0, 0, 6336.436, -6361.6865, 78.108734, 6.108652114868164062, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82878, 16320, 530, 0, 0, 1, 1, 0, 0, 6285.2627, -6382.6597, 79.24579, 3.987816810607910156, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82885, 16320, 530, 0, 0, 1, 1, 0, 0, 6289.733, -6342.1636, 79.24578, 2.780841827392578125, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82894, 16320, 530, 0, 0, 1, 1, 0, 0, 6352.841, -6277.444, 73.46697, 5.515240192413330078, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82904, 16320, 530, 0, 0, 1, 1, 0, 0, 6343.5283, -6287.599, 73.39533, 5.846852779388427734, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82905, 16320, 530, 0, 0, 1, 1, 0, 0, 6456.2056, -6346.8164, 55.26159, 1.239183783531188964, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82918, 16320, 530, 0, 0, 1, 1, 0, 0, 6462.136, -6349.0327, 55.26159, 1.675516128540039062, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82924, 16320, 530, 0, 0, 1, 1, 0, 0, 6442.046, -6406.1797, 48.76159, 2.450567960739135742, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- Can be Wailer
(82925, 16320, 530, 0, 0, 1, 1, 0, 0, 6450.625, -6384.8076, 55.26159, 4.345870018005371093, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82926, 16320, 530, 0, 0, 1, 1, 0, 0, 6552.5303, -6347.474, 32.128654, 5.808512687683105468, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82930, 16320, 530, 0, 0, 1, 1, 0, 0, 6584.2617, -6317.007, 36.20228, 3.608769655227661132, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82933, 16320, 530, 0, 0, 1, 1, 0, 0, 6518.7036, -6383.5503, 47.221962, 0.236396104097366333, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82934, 16320, 530, 0, 0, 1, 1, 0, 0, 6581.898, -6383.8223, 31.229975, 5.945767402648925781, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82935, 16320, 530, 0, 0, 1, 1, 0, 0, 6630.923, -6333.9854, 30.183636, 3.019419670104980468, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82939, 16320, 530, 0, 0, 1, 1, 0, 0, 6633.2104, -6322.741, 29.895441, 2.94960641860961914, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82841, 16320, 530, 0, 0, 1, 1, 0, 0, 6649.8555, -6382.1978, 32.87445, 1.585994124412536621, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82897, 16320, 530, 0, 0, 1, 1, 0, 0, 6527.3145, -6542.19, 43.84596, 4.983845233917236328, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- Can be Wailer
(82767, 16320, 530, 0, 0, 1, 1, 0, 0, 6606.573, -6337.9863, 33.237904, 4.864778041839599609, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0); -- Can be Wailer

-- Wailer
DELETE FROM `creature` WHERE `guid` IN (82817,82819,82831,82832,82833,82835,82836,82844,82858,82859,82868,82870,82884,82890,82892,82895,82921,82923);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82817, 16321, 530, 0, 0, 1, 1, 0, 0, 6580.734, -6416.3257, 31.395319, 3.487795114517211914, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82819, 16321, 530, 0, 0, 1, 1, 0, 0, 6510.619, -6498.2026, 43.84535, 5.911339759826660156, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82831, 16321, 530, 0, 0, 1, 1, 0, 0, 6450.608, -6515.305, 52.312653, 1.643528461456298828, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82832, 16321, 530, 0, 0, 1, 1, 0, 0, 6518.195, -6448.2993, 42.603424, 0.752936065196990966, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82833, 16321, 530, 0, 0, 1, 1, 0, 0, 6506.5547, -6530.171, 43.84487, 4.447039604187011718, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82835, 16321, 530, 0, 0, 1, 1, 0, 0, 6552.278, -6285.858, 45.942696, 5.813094615936279296, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82836, 16321, 530, 0, 0, 1, 1, 0, 0, 6648.2915, -6250.9307, 32.150692, 4.424261093139648437, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82844, 16321, 530, 0, 0, 1, 1, 0, 0, 6534.129, -6520.196, 43.845264, 6.100297927856445312, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82858, 16321, 530, 0, 0, 1, 1, 0, 0, 6418.5947, -6639.48, 108.649734, 4.570575237274169921, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82859, 16321, 530, 0, 0, 1, 1, 0, 0, 6310.88, -6458.9, 86.28304, 5.16617441177368164, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- Can be Eye of Dar'Khan
(82868, 16321, 530, 0, 0, 1, 1, 0, 0, 6349.7134, -6366.2993, 78.18733, 0.866246461868286132, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82870, 16321, 530, 0, 0, 1, 1, 0, 0, 6313.026, -6294.39, 77.58217, 0.643256783485412597, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82884, 16321, 530, 0, 0, 1, 1, 0, 0, 6416.976, -6292.7803, 62.211525, 5.858962535858154296, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82890, 16321, 530, 0, 0, 1, 1, 0, 0, 6437.366, -6360.5957, 41.35911, 1.245625138282775878, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- Can be Eye of Dar'Khan
(82892, 16321, 530, 0, 0, 1, 1, 0, 0, 6518.112, -6349.2173, 42.795288, 1.772591233253479003, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82895, 16321, 530, 0, 0, 1, 1, 0, 0, 6552.026, -6382.497, 33.381325, 0.169888362288475036, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82921, 16321, 530, 0, 0, 1, 1, 0, 0, 6603.429, -6332.975, 33.57106, 0.338266193866729736, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- Can be Eye of Dar'Khan
(82923, 16321, 530, 0, 0, 1, 1, 0, 0, 6584.1274, -6349.961, 31.46612, 0.468069463968276977, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Deathome Necromancer
DELETE FROM  `creature_addon` WHERE `guid` IN (82886);
DELETE FROM `creature` WHERE `guid` IN (82820,82824,82863,82871,82874,82886,82903,82906,82914,82927,82931,82937,82915,82879,82899,82827,82823,82822,152294,152295,152296,82826);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(82820, 16317, 530, 0, 0, 1, 1, 0, 0, 6438.0454, -6632.3657, 107.51494, 1.718067049980163574, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(82906, 16317, 530, 0, 0, 1, 1, 0, 0, 6505.496, -6231.982, 53.717964, 1.884955525398254394, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82914, 16317, 530, 0, 0, 1, 1, 0, 0, 6488.451, -6221.528, 52.54526, 0.72149360179901123, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82899, 16317, 530, 0, 0, 1, 1, 0, 0, 6639.3306, -6308.48, 29.3999, 5.742841720581054687, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82827, 16317, 530, 0, 0, 1, 1, 0, 0, 6647.742, -6292.4717, 29.349953, 2.970809459686279296, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82823, 16317, 530, 0, 0, 1, 1, 0, 0, 6640.0557, -6351.424, 29.430994, 4.101523876190185546, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82822, 16317, 530, 0, 0, 1, 1, 0, 0, 6653.115, -6366.086, 31.320513, 0.902625679969787597, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(82931, 16317, 530, 0, 0, 1, 1, 0, 0, 6461.7744, -6346.426, 41.291985, 2.792526721954345703, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82937, 16317, 530, 0, 0, 1, 1, 0, 0, 6448.702, -6383.246, 41.319817, 2.792526721954345703, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82915, 16317, 530, 0, 0, 1, 1, 0, 0, 6470.639, -6380.8696, 27.286062, 1.919862151145935058, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82879, 16317, 530, 0, 0, 1, 1, 0, 0, 6477.12, -6363.0093, 27.286095, 3.787364482879638671, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82824, 16317, 530, 0, 0, 1, 1, 0, 0, 6297.0513, -6472.9165, 83.28334, 0.750491559505462646, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82863, 16317, 530, 0, 0, 1, 1, 0, 0, 6296.8594, -6455.6494, 83.28348, 5.585053443908691406, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82871, 16317, 530, 0, 0, 1, 1, 0, 0, 6313.0225, -6474.518, 83.283554, 2.251474618911743164, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82874, 16317, 530, 0, 0, 1, 1, 0, 0, 6301.094, -6257.4937, 77.823, 0.715584993362426757, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82886, 16317, 530, 0, 0, 1, 1, 0, 0, 6300.626, -6239.95, 77.82277, 5.567600250244140625, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82903, 16317, 530, 0, 0, 1, 1, 0, 0, 6318.4634, -6239.1562, 77.82291, 4.084070205688476562, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82927, 16317, 530, 0, 0, 1, 1, 0, 0, 6479.73, -6289.819, 48.917976, 3.141592741012573242, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(82826, 16317, 530, 0, 0, 1, 1, 0, 0, 6463.9507, -6441.8706, 52.459564, 3.525565147399902343, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

-- Pathing for Eye of Dar'Khan Entry: 16320
SET @NPC := 82924;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6440.541,-6404.935,48.678257,0,0,0,0,100,0),
(@PATH,2,6444.9004,-6388.83,55.178253,0,0,0,0,100,0),
(@PATH,3,6463.772,-6386.225,55.178253,0,0,0,0,100,0),
(@PATH,4,6476.8877,-6374.0874,55.178253,0,0,0,0,100,0),
(@PATH,5,6473.8574,-6357.6675,55.178253,0,0,0,0,100,0),
(@PATH,6,6461.002,-6344.553,55.17825,0,0,0,0,100,0),
(@PATH,7,6465.8374,-6327.139,48.678253,0,0,0,0,100,0),
(@PATH,8,6459.9263,-6344.304,55.17825,0,0,0,0,100,0),
(@PATH,9,6443.672,-6346.737,55.178253,0,0,0,0,100,0),
(@PATH,10,6430.7715,-6360.6836,55.178257,0,0,0,0,100,0),
(@PATH,11,6433.597,-6375.9814,55.178253,0,0,0,0,100,0),
(@PATH,12,6445.1396,-6388.9487,55.178253,0,0,0,0,100,0);

-- Pathing for Wailer Entry: 16321
SET @NPC := 82890;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6437.5186,-6360.555,41.274178,0,0,0,0,100,0),
(@PATH,2,6443.685,-6341.853,41.28399,0,0,0,0,100,0),
(@PATH,3,6459.643,-6345.693,41.231594,0,0,0,0,100,0),
(@PATH,4,6453.3857,-6365.392,33.73314,0,0,0,0,100,0),
(@PATH,5,6447.2607,-6384.748,41.241745,0,0,0,0,100,0),
(@PATH,6,6431.593,-6378.988,41.283688,0,0,0,0,100,0);

-- Pathing for Deatholme Necromancer Entry: 16317
SET @NPC := 82820;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6444.2,-6630.5723,107.43155,0,0,0,0,100,0),
(@PATH,2,6446.932,-6638.233,107.43153,0,0,0,0,100,0),
(@PATH,3,6439.8594,-6639.9604,107.43153,0,0,0,0,100,0),
(@PATH,4,6432.4404,-6639.784,107.43147,0,0,0,0,100,0),
(@PATH,5,6430.6646,-6633.2407,107.43142,0,0,0,0,100,0),
(@PATH,6,6437.4673,-6629.4204,107.43252,0,0,0,0,100,0),
(@PATH,7,6436.307,-6617.6685,107.43679,0,0,0,0,100,0),
(@PATH,8,6428.377,-6618.2983,108.83984,0,0,0,0,100,0),
(@PATH,9,6425.949,-6612.903,110.86264,0,0,0,0,100,0),
(@PATH,10,6433.3545,-6608.82,112.12465,0,0,0,0,100,0),
(@PATH,11,6431.04,-6597.619,112.112946,0,0,0,0,100,0),
(@PATH,12,6427.622,-6582.77,104.55625,0,0,0,0,100,0),
(@PATH,13,6420.908,-6562.3096,93.8155,0,0,0,0,100,0),
(@PATH,14,6410.6685,-6531.1274,78.82597,0,0,0,0,100,0),
(@PATH,15,6426.4644,-6501.941,61.985027,0,0,0,0,100,0),
(@PATH,16,6423.596,-6474.2803,60.17094,0,0,0,0,100,0),
(@PATH,17,6400.303,-6455.1387,64.86885,0,0,0,0,100,0),
(@PATH,18,6384.439,-6432.3276,68.311905,0,0,0,0,100,0),
(@PATH,19,6373.331,-6421.0195,69.67177,0,0,0,0,100,0),
(@PATH,20,6352.8076,-6420.325,74.81633,0,0,0,0,100,0),
(@PATH,21,6341.1035,-6394.82,77.11251,0,0,0,0,100,0),
(@PATH,22,6343.9443,-6370.154,78.17843,0,0,0,0,100,0),
(@PATH,23,6315.4062,-6364.964,82.71208,0,0,0,0,100,0),
(@PATH,24,6312.8486,-6371.8594,81.93016,0,0,0,0,100,0),
(@PATH,25,6308.0522,-6373.319,80.43952,0,0,0,0,100,0),
(@PATH,26,6305.5913,-6370.229,78.96046,0,0,0,0,100,0),
(@PATH,27,6306.1313,-6365.193,78.0242,0,0,0,0,100,0),
(@PATH,28,6293.241,-6363.972,78.01947,0,0,0,0,100,0),
(@PATH,29,6288.9956,-6370.0337,78.01902,0,0,0,0,100,0),
(@PATH,30,6281.944,-6368.2056,78.01895,0,0,0,0,100,0),
(@PATH,31,6282.2734,-6362.0835,78.01893,0,0,0,0,100,0),
(@PATH,32,6284.575,-6355.039,78.018814,0,0,0,0,100,0),
(@PATH,33,6291.5566,-6355.142,78.018814,0,0,0,0,100,0),
(@PATH,34,6293.3994,-6363.5737,78.01958,0,0,0,0,100,0),
(@PATH,35,6306.303,-6365.2314,78.02419,0,0,0,0,100,0),
(@PATH,36,6307.6943,-6357.813,79.52273,0,0,0,0,100,0),
(@PATH,37,6311.4233,-6356.2075,80.77782,0,0,0,0,100,0),
(@PATH,38,6313.9126,-6358.6934,81.895996,0,0,0,0,100,0),
(@PATH,39,6315.084,-6365.1807,82.712074,0,0,0,0,100,0),
(@PATH,40,6343.97,-6368.3,78.30343,0,0,0,0,100,0),
(@PATH,41,6334.7017,-6348.614,76.99017,0,0,0,0,100,0),
(@PATH,42,6334.566,-6330.542,74.59479,0,0,0,0,100,0),
(@PATH,43,6345.843,-6310.8257,72.9151,0,0,0,0,100,0),
(@PATH,44,6361.7275,-6300.463,69.55255,0,0,0,0,100,0),
(@PATH,45,6372.3257,-6307.799,67.70804,0,0,0,0,100,0),
(@PATH,46,6373.076,-6343.7207,68.17,0,0,0,0,100,0),
(@PATH,47,6372.2446,-6381.3496,68.32991,0,0,0,0,100,0),
(@PATH,48,6375.579,-6417.268,69.32411,0,0,0,0,100,0),
(@PATH,49,6393.839,-6445.1826,66.298775,0,0,0,0,100,0),
(@PATH,50,6418.558,-6472.2637,61.16142,0,0,0,0,100,0),
(@PATH,51,6423.5464,-6501.725,63.00944,0,0,0,0,100,0),
(@PATH,52,6405.983,-6527.5947,76.49272,0,0,0,0,100,0),
(@PATH,53,6421.408,-6568.244,96.72227,0,0,0,0,100,0),
(@PATH,54,6431.7036,-6597.3677,112.112946,0,0,0,0,100,0),
(@PATH,55,6433.4023,-6608.9053,112.12465,0,0,0,0,100,0),
(@PATH,56,6440.3096,-6609.407,111.29323,0,0,0,0,100,0),
(@PATH,57,6443.0796,-6612.839,109.89208,0,0,0,0,100,0),
(@PATH,58,6440.953,-6616.777,108.32228,0,0,0,0,100,0),
(@PATH,59,6436.0415,-6617.8564,107.43681,0,0,0,0,100,0),
(@PATH,60,6437.636,-6629.6074,107.43236,0,0,0,0,100,0);

-- Pathing for Wailer Entry: 16321
SET @NPC := 82921;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6625.879,-6328.6587,31.079706,0,0,0,0,100,0),
(@PATH,2,6645.555,-6329.0083,30.264267,0,0,0,0,100,0),
(@PATH,3,6662.78,-6331.4277,20.891985,0,0,0,0,100,0),
(@PATH,4,6661.217,-6346.813,15.346255,0,0,0,0,100,0),
(@PATH,5,6643.81,-6344.2827,9.439028,0,0,0,0,100,0),
(@PATH,6,6661.217,-6346.813,15.346255,0,0,0,0,100,0),
(@PATH,7,6662.78,-6331.4277,20.891985,0,0,0,0,100,0),
(@PATH,8,6645.555,-6329.0083,30.264267,0,0,0,0,100,0),
(@PATH,9,6625.879,-6328.6587,31.079706,0,0,0,0,100,0),
(@PATH,10,6609.327,-6337.966,33.19819,0,0,0,0,100,0),
(@PATH,11,6612.3804,-6376.4907,31.163116,0,0,0,0,100,0),
(@PATH,12,6612.5703,-6418.111,29.38384,0,0,0,0,100,0),
(@PATH,13,6613.9624,-6441.6025,29.34684,0,0,0,0,100,0),
(@PATH,14,6645.737,-6453.694,29.384539,0,0,0,0,100,0),
(@PATH,15,6613.9624,-6441.6025,29.34684,0,0,0,0,100,0),
(@PATH,16,6612.5703,-6418.111,29.38384,0,0,0,0,100,0),
(@PATH,17,6612.3804,-6376.4907,31.163116,0,0,0,0,100,0),
(@PATH,18,6609.327,-6337.966,33.19819,0,0,0,0,100,0);

-- Pathing for Wailer Entry: 16321
SET @NPC := 82859;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6311.072,-6459.2603,86.010414,0,0,0,0,100,0),
(@PATH,2,6331.158,-6440.609,86.01065,0,0,0,0,100,0),
(@PATH,3,6350.8755,-6420.582,75.2802,0,0,0,0,100,0),
(@PATH,4,6340.5425,-6388.816,77.655235,0,0,0,0,100,0),
(@PATH,5,6339.8394,-6367.8584,78.254845,0,0,0,0,100,0),
(@PATH,6,6321.7188,-6365.26,82.70318,0,0,0,0,100,0),
(@PATH,7,6294.7524,-6363.3545,78.02053,0,0,0,0,100,0),
(@PATH,8,6289.937,-6369.514,78.019,0,0,0,0,100,0),
(@PATH,9,6283.0186,-6368.5527,78.01901,0,0,0,0,100,0),
(@PATH,10,6280.7183,-6361.8657,78.018906,0,0,0,0,100,0),
(@PATH,11,6285.132,-6353.9897,78.01891,0,0,0,0,100,0),
(@PATH,12,6293.1924,-6355.1284,78.01885,0,0,0,0,100,0),
(@PATH,13,6295.1597,-6363.1777,78.02081,0,0,0,0,100,0),
(@PATH,14,6321.7188,-6365.26,82.70318,0,0,0,0,100,0),
(@PATH,15,6339.944,-6367.943,78.231895,0,0,0,0,100,0),
(@PATH,16,6332.289,-6341.179,75.878296,0,0,0,0,100,0),
(@PATH,17,6341.5337,-6310.715,73.52423,0,0,0,0,100,0),
(@PATH,18,6357.104,-6296.876,70.682396,0,0,0,0,100,0),
(@PATH,19,6335.2017,-6271.648,80.81339,0,0,0,0,100,0),
(@PATH,20,6316.421,-6254.0713,80.81314,0,0,0,0,100,0),
(@PATH,21,6335.2017,-6271.648,80.81339,0,0,0,0,100,0),
(@PATH,22,6357.104,-6296.876,70.682396,0,0,0,0,100,0),
(@PATH,23,6341.5337,-6310.715,73.52423,0,0,0,0,100,0),
(@PATH,24,6332.289,-6341.179,75.878296,0,0,0,0,100,0),
(@PATH,25,6339.944,-6367.943,78.231895,0,0,0,0,100,0),
(@PATH,26,6321.7188,-6365.26,82.70318,0,0,0,0,100,0),
(@PATH,27,6295.1597,-6363.1777,78.02081,0,0,0,0,100,0),
(@PATH,28,6293.1924,-6355.1284,78.01885,0,0,0,0,100,0),
(@PATH,29,6285.132,-6353.9897,78.01891,0,0,0,0,100,0),
(@PATH,30,6280.7183,-6361.8657,78.018906,0,0,0,0,100,0),
(@PATH,31,6282.932,-6368.5405,78.019,0,0,0,0,100,0),
(@PATH,32,6289.937,-6369.514,78.019,0,0,0,0,100,0),
(@PATH,33,6294.7524,-6363.3545,78.02053,0,0,0,0,100,0),
(@PATH,34,6321.7188,-6365.26,82.70318,0,0,0,0,100,0),
(@PATH,35,6339.8394,-6367.8584,78.254845,0,0,0,0,100,0),
(@PATH,36,6340.5425,-6388.816,77.655235,0,0,0,0,100,0),
(@PATH,37,6350.8755,-6420.582,75.2802,0,0,0,0,100,0),
(@PATH,38,6331.158,-6440.609,86.01065,0,0,0,0,100,0);

-- Pathing for Eye of Dar'Khan Entry: 16320
SET @NPC := 82720;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6528.111,-6542.729,44.030396,0,0,0,0,100,0),
(@PATH,2,6541.263,-6537.1523,43.762016,0,0,0,0,100,0),
(@PATH,3,6547.0454,-6508.0747,43.76202,0,0,0,0,100,0),
(@PATH,4,6524.5493,-6488.25,43.762016,0,0,0,0,100,0),
(@PATH,5,6495.8267,-6497.5483,43.762016,0,0,0,0,100,0),
(@PATH,6,6490.643,-6511.984,43.763157,0,0,0,0,100,0),
(@PATH,7,6475.936,-6507.128,43.478443,0,0,0,0,100,0),
(@PATH,8,6469.5747,-6485.125,49.039627,0,0,0,0,100,0),
(@PATH,9,6433.232,-6483.027,57.58427,0,0,0,0,100,0),
(@PATH,10,6415.268,-6516.4033,72.03154,0,0,0,0,100,0),
(@PATH,11,6417.59,-6547.105,87.16682,0,0,0,0,100,0),
(@PATH,12,6424.33,-6580.4414,103.32456,0,0,0,0,100,0),
(@PATH,13,6431.557,-6597.204,112.112946,0,0,0,0,100,0),
(@PATH,14,6435.5737,-6618.178,107.43684,0,0,0,0,100,0),
(@PATH,15,6437.407,-6627.4766,107.43386,0,0,0,0,100,0),
(@PATH,16,6445.8813,-6631.8926,107.43158,0,0,0,0,100,0),
(@PATH,17,6444.9604,-6640.557,107.43145,0,0,0,0,100,0),
(@PATH,18,6435.163,-6642.8696,107.43157,0,0,0,0,100,0),
(@PATH,19,6430.3027,-6636.2915,107.43142,0,0,0,0,100,0),
(@PATH,20,6437.226,-6627.4956,107.43388,0,0,0,0,100,0),
(@PATH,21,6431.557,-6597.204,112.112946,0,0,0,0,100,0),
(@PATH,22,6424.6523,-6580.4253,103.21543,0,0,0,0,100,0),
(@PATH,23,6417.7334,-6546.5415,87.03327,0,0,0,0,100,0),
(@PATH,24,6415.627,-6516.387,71.89055,0,0,0,0,100,0),
(@PATH,25,6433.894,-6483.7285,57.45766,0,0,0,0,100,0),
(@PATH,26,6469.92,-6484.185,49.110916,0,0,0,0,100,0),
(@PATH,27,6475.4478,-6507.225,43.58391,0,0,0,0,100,0),
(@PATH,28,6490.4746,-6512.357,43.764698,0,0,0,0,100,0),
(@PATH,29,6489.6885,-6527.135,43.76202,0,0,0,0,100,0),
(@PATH,30,6511.2764,-6547.3384,43.76202,0,0,0,0,100,0);

-- Pathing for Eye of Dar'Khan Entry: 16320
SET @NPC := 82767;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6606.876,-6339.9575,33.090767,0,0,0,0,100,0),
(@PATH,2,6604.1157,-6299.53,36.815086,0,0,0,0,100,0),
(@PATH,3,6591.0986,-6278.466,40.488758,0,0,0,0,100,0),
(@PATH,4,6563.827,-6261.2964,46.16224,0,0,0,0,100,0),
(@PATH,5,6532.6035,-6256.35,50.975044,0,0,0,0,100,0),
(@PATH,6,6505.854,-6259.1313,52.651924,0,0,0,0,100,0),
(@PATH,7,6471.2495,-6250.9185,57.207436,0,0,0,0,100,0),
(@PATH,8,6434.434,-6249.797,62.101307,0,0,0,0,100,0),
(@PATH,9,6403.1953,-6269.108,65.04057,0,0,0,0,100,0),
(@PATH,10,6379.725,-6300.803,67.23367,0,0,0,0,100,0),
(@PATH,11,6370.577,-6334.9185,67.83833,0,0,0,0,100,0),
(@PATH,12,6372.9697,-6374.8594,68.159256,0,0,0,0,100,0),
(@PATH,13,6374.183,-6410.276,69.19911,0,0,0,0,100,0),
(@PATH,14,6387.049,-6434.1064,67.99421,0,0,0,0,100,0),
(@PATH,15,6408.245,-6463.687,63.165974,0,0,0,0,100,0),
(@PATH,16,6430.6562,-6479.1294,58.14433,0,0,0,0,100,0),
(@PATH,17,6462.041,-6481.816,50.95461,0,0,0,0,100,0),
(@PATH,18,6481.3667,-6477.1123,48.59297,0,0,0,0,100,0),
(@PATH,19,6519.1084,-6473.5024,42.57104,0,0,0,0,100,0),
(@PATH,20,6551.726,-6479.587,36.458794,0,0,0,0,100,0),
(@PATH,21,6567.219,-6477.04,34.866673,0,0,0,0,100,0),
(@PATH,22,6595.6406,-6456.715,30.078915,0,0,0,0,100,0),
(@PATH,23,6611.639,-6435.965,29.225258,0,0,0,0,100,0),
(@PATH,24,6612.4146,-6397.66,30.070587,0,0,0,0,100,0),
(@PATH,25,6610.1836,-6367.604,31.729523,0,0,0,0,100,0);

-- Add SAI for some Deatholme Necromancers
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-82824,-82863,-82871,-82874,-82886,-82903,-82927,-82826) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1631700) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-82824,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82824,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82824,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82824,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82824,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82863,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82863,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82863,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82863,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82863,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82871,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82871,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82871,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82871,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82871,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82874,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82874,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82874,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82874,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82874,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82886,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82886,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82886,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82886,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82886,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82903,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82903,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82903,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82903,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82903,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82927,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82927,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82927,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82927,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82927,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(-82826,0,0,0,1,0,100,0,1000,1000,300000,300000,0,11,29066,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Cast ''Summon Dreadbone Skeleton'''),
(-82826,0,1,0,0,0,100,0,0,0,3400,4800,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Deatholme Necromancer - In Combat CMC - Cast ''Shadow Bolt'''),
(-82826,0,2,0,2,0,100,0,0,20,8000,12000,0,11,29067,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-20% Health - Cast ''Slave Drain'''),
(-82826,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Between 0-15% Health - Flee For Assist (No Repeat)'),
(-82826,0,4,0,1,0,100,0,10000,40000,50000,55000,0,80,1631700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Out of Combat - Run Script'),

(1631700,9,0,0,0,0,100,0,3000,3000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Script - Kneel'),
(1631700,9,1,0,0,0,100,0,0,0,0,0,0,11,21157,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Script - Cast ''Dark Channeling'''),
(1631700,9,2,0,0,0,100,0,7000,10000,0,0,0,92,0,21157,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Script - Stop casting ''Dark Channeling'''),
(1631700,9,3,0,0,0,100,0,3000,3000,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Deatholme Necromancer - Script - Kneel');
