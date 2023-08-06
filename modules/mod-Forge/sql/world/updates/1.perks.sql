DROP table if exists acore_world.`perks`;
CREATE TABLE acore_world.`perks` (
  `id` int NOT NULL,
  `unique` tinyint DEFAULT NULL,
  `allowableClass` int DEFAULT -1,
  `permanent` tinyint DEFAULT 1,
  `chance` int DEFAULT 100,
  `category` tinyint DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `groupId` int DEFAULT NULL,
  `tags` varchar(64) NOT NULL DEFAULT 'I need tags!',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500500,0,1535,1,1,0,0,0,''),
    (500501,0,1494,1,1,0,0,0,''),
    (500502,0,1067,1,1,0,0,0,''),
    (500503,0,1131,1,1,0,0,0,''),
    (500505,0,1535,1,1,0,0,0,''),
    (500506,0,1494,1,1,0,0,0,''),
    (500507,0,1067,1,1,0,0,1,''),
    (500508,0,1131,1,1,0,0,0,''),
    (500509,0,1311,1,1,0,0,0,''),
    (500511,0,35,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500512,0,1059,1,1,0,0,0,''),
    (500513,0,2,1,1,0,0,0,''),
    (500514,1,99,1,1,0,0,0,''),
    (500515,0,1535,1,1,0,0,0,''),
    (500516,1,1535,1,1,0,0,0,''),
    (500517,1,1535,1,1,0,0,0,''),
    (500518,0,103,1,1,0,0,0,''),
    (500519,0,228,1,1,0,0,0,''),
    (500520,0,256,1,1,0,0,0,''),
    (500521,0,1088,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500522,0,18,1,1,0,0,0,''),
    (500523,0,192,1,1,0,0,0,''),
    (500524,0,448,1,1,0,0,0,''),
    (500525,0,1133,1,1,0,0,0,''),
    (500526,0,1032,1,1,0,0,0,''),
    (500527,0,105,1,1,0,0,0,''),
    (500528,0,1535,1,1,0,0,0,''),
    (500529,0,1494,1,1,0,0,0,''),
    (500530,0,1067,1,1,0,0,0,''),
    (500531,0,1131,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500533,1,1535,1,1,0,0,0,''),
    (500534,0,1315,1,1,0,0,0,''),
    (500535,0,1490,1,1,0,0,0,''),
    (500536,0,1535,1,1,0,0,0,''),
    (500537,0,260,1,1,0,0,0,''),
    (500538,0,1024,1,1,0,0,0,''),
    (500539,0,35,1,1,0,0,0,''),
    (500540,1,1106,1,1,0,0,0,''),
    (500541,1,1488,1,1,0,0,0,''),
    (500542,1,35,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500543,1,1036,1,1,0,0,0,''),
    (500545,1,1535,1,1,0,0,0,''),
    (500546,1,1106,1,1,0,0,0,''),
    (500547,0,1535,1,1,0,0,0,''),
    (500549,0,1535,1,1,0,0,0,''),
    (500550,0,1535,1,1,0,0,0,''),
    (500551,0,1032,1,1,0,0,0,''),
    (500552,0,1490,1,1,0,0,0,''),
    (500553,1,1535,1,1,0,0,0,''),
    (500554,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500557,1,448,1,1,0,0,1,''),
    (500558,1,256,1,1,0,0,1,''),
    (500559,1,192,1,1,0,0,1,''),
    (500560,1,1088,1,1,0,0,1,''),
    (500561,1,1146,1,1,0,0,1,''),
    (500700,1,1490,1,1,0,0,0,''),
    (500701,1,1535,1,1,0,0,0,''),
    (500702,1,1535,1,1,0,0,0,''),
    (500703,1,1106,1,1,0,0,0,''),
    (500704,1,1535,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (500705,0,1535,1,1,0,0,0,''),
    (500706,0,1488,1,1,0,0,0,''),
    (500707,0,1315,1,1,0,0,0,''),
    (500708,1,1059,1,1,0,0,0,''),
    (500709,1,1059,1,1,0,0,0,''),
    (600600,1,1535,1,1,0,0,0,''),
    (600602,1,1535,1,1,0,0,0,''),
    (600604,1,1535,1,1,0,0,0,''),
    (600606,1,1535,1,1,0,0,0,''),
    (600608,1,1535,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600609,1,1535,1,1,0,0,0,''),
    (600612,1,1535,1,1,0,0,0,''),
    (600614,1,1535,1,1,0,0,0,''),
    (600616,1,1535,1,1,0,0,0,''),
    (600618,1,1535,1,1,0,0,0,''),
    (600620,1,1106,1,1,0,0,0,''),
    (600622,1,1059,1,1,0,0,0,''),
    (600624,1,1535,1,1,0,0,0,''),
    (600626,1,1106,1,1,0,0,0,''),
    (600628,1,1059,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600630,1,1535,1,1,0,0,0,''),
    (600634,1,1501,1,1,0,0,0,''),
    (600636,1,1131,1,1,0,0,0,''),
    (600637,1,1518,1,1,0,0,0,''),
    (600638,1,1518,1,1,0,0,0,''),
    (600639,1,1501,1,1,0,0,0,''),
    (600640,1,1106,1,1,0,0,0,''),
    (600641,1,1131,1,1,0,0,0,''),
    (600642,1,1131,1,1,0,0,0,''),
    (600646,1,1517,1,1,0,0,2,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600660,1,1490,1,1,0,0,0,''),
    (600661,1,1490,1,1,0,0,0,''),
    (600662,1,1494,1,1,0,0,0,''),
    (600663,1,400,1,1,0,0,0,''),
    (600700,1,35,1,1,0,0,0,''),
    (600701,1,1100,1,1,0,0,0,''),
    (600702,1,1059,1,1,0,0,0,''),
    (600703,1,1488,1,1,0,0,0,''),
    (600704,1,1106,1,1,0,0,0,''),
    (600705,0,1063,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600706,1,1131,1,1,0,0,0,''),
    (600707,1,1490,1,1,0,0,0,''),
    (600709,1,13,1,1,0,0,0,''),
    (600710,1,1494,1,1,0,0,0,''),
    (600711,1,1535,1,1,0,0,0,''),
    (600712,1,1131,1,1,0,0,0,''),
    (600713,1,1033,1,1,0,0,0,''),
    (600715,1,1131,1,1,0,0,0,''),
    (600717,1,1131,1,1,0,0,0,''),
    (600718,1,1049,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600719,1,1490,1,1,0,0,0,''),
    (600720,1,4,1,1,0,0,0,''),
    (600721,1,4,1,1,0,0,0,''),
    (600722,1,1488,1,1,0,0,0,''),
    (600723,1,1106,1,1,0,0,0,''),
    (600724,0,260,1,1,0,0,0,''),
    (600725,0,1059,1,1,0,0,0,''),
    (600731,1,1535,1,1,0,0,0,''),
    (600732,1,1059,1,1,0,0,0,''),
    (600733,1,1059,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (600734,1,1059,1,1,0,0,0,''),
    (600735,1,1491,1,1,0,0,0,''),
    (600736,1,1059,1,1,0,0,0,''),
    (600737,1,1535,1,1,0,0,0,''),
    (700700,0,16,1,1,0,0,0,''),
    (700701,0,16,1,1,0,0,0,''),
    (700702,0,16,1,1,0,0,0,''),
    (700703,0,16,1,1,0,0,0,''),
    (700704,1,16,1,1,0,0,0,''),
    (700705,0,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700706,1,16,1,1,0,0,0,''),
    (700707,0,16,1,1,0,0,0,''),
    (700708,1,16,1,1,0,0,0,''),
    (700709,0,16,1,1,0,0,0,''),
    (700710,0,16,1,1,0,0,0,''),
    (700711,0,16,1,1,0,0,0,''),
    (700712,0,16,1,1,0,0,0,''),
    (700713,1,16,1,1,0,0,0,''),
    (700714,0,16,1,1,0,0,0,''),
    (700715,1,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700716,0,16,1,1,0,0,0,''),
    (700717,0,16,1,1,0,0,0,''),
    (700718,0,16,1,1,0,0,0,''),
    (700719,0,16,1,1,0,0,0,''),
    (700720,1,16,1,1,0,0,0,''),
    (700721,0,16,1,1,0,0,0,''),
    (700722,0,16,1,1,0,0,0,''),
    (700723,0,16,1,1,0,0,0,''),
    (700724,1,16,1,1,0,0,0,''),
    (700725,0,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700726,1,16,1,1,0,0,0,''),
    (700727,0,16,1,1,0,0,0,''),
    (700728,1,16,1,1,0,0,0,''),
    (700729,1,16,1,1,0,0,0,''),
    (700730,0,16,1,1,0,0,0,''),
    (700731,0,16,1,1,0,0,0,''),
    (700732,0,16,1,1,0,0,0,''),
    (700733,1,16,1,1,0,0,0,''),
    (700734,0,16,1,1,0,0,0,''),
    (700735,0,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700736,0,16,1,1,0,0,0,''),
    (700737,1,16,1,1,0,0,0,''),
    (700738,0,16,1,1,0,0,0,''),
    (700739,1,16,1,1,0,0,0,''),
    (700740,0,16,1,1,0,0,0,''),
    (700741,0,16,1,1,0,0,0,''),
    (700742,1,16,1,1,0,0,0,''),
    (700744,0,16,1,1,0,0,0,''),
    (700745,0,16,1,1,0,0,0,''),
    (700746,0,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700747,1,16,1,1,0,0,0,''),
    (700748,0,16,1,1,0,0,0,''),
    (700749,0,16,1,1,0,0,0,''),
    (700751,0,64,1,1,0,0,0,''),
    (700752,0,64,1,1,0,0,0,''),
    (700753,0,64,1,1,0,0,0,''),
    (700754,0,64,1,1,0,0,0,''),
    (700755,0,64,1,1,0,0,0,''),
    (700756,0,64,1,1,0,0,0,''),
    (700757,1,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700758,0,64,1,1,0,0,0,''),
    (700759,1,64,1,1,0,0,0,''),
    (700760,1,64,1,1,0,0,0,''),
    (700761,0,64,1,1,0,0,0,''),
    (700762,0,64,1,1,0,0,0,''),
    (700763,1,64,1,1,0,0,0,''),
    (700764,0,64,1,1,0,0,0,''),
    (700765,0,64,1,1,0,0,0,''),
    (700766,0,64,1,1,0,0,0,''),
    (700767,0,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700768,0,64,1,1,0,0,0,''),
    (700769,0,64,1,1,0,0,0,''),
    (700770,0,64,1,1,0,0,0,''),
    (700771,0,64,1,1,0,0,0,''),
    (700772,1,64,1,1,0,0,0,''),
    (700773,0,64,1,1,0,0,0,''),
    (700774,0,64,1,1,0,0,0,''),
    (700775,0,64,1,1,0,0,0,''),
    (700776,0,64,1,1,0,0,0,''),
    (700777,0,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700778,0,64,1,1,0,0,0,''),
    (700779,0,64,1,1,0,0,0,''),
    (700780,0,64,1,1,0,0,0,''),
    (700781,0,64,1,1,0,0,0,''),
    (700783,0,64,1,1,0,0,0,''),
    (700785,0,64,1,1,0,0,0,''),
    (700786,0,64,1,1,0,0,0,''),
    (700787,0,64,1,1,0,0,0,''),
    (700788,1,64,1,1,0,0,0,''),
    (700789,1,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700790,1,64,1,1,0,0,0,''),
    (700791,0,64,1,1,0,0,0,''),
    (700792,0,64,1,1,0,0,0,''),
    (700793,1,64,1,1,0,0,0,''),
    (700794,0,64,1,1,0,0,0,''),
    (700795,1,64,1,1,0,0,0,''),
    (700796,0,64,1,1,0,0,0,''),
    (700797,0,64,1,1,0,0,0,''),
    (700798,1,64,1,1,0,0,0,''),
    (700799,1,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700800,1,64,1,1,0,0,0,''),
    (700801,1,64,1,1,0,0,0,''),
    (700802,1,64,1,1,0,0,0,''),
    (700803,1,64,1,1,0,0,0,''),
    (700804,1,64,1,1,0,0,0,''),
    (700805,0,64,1,1,0,0,0,''),
    (700806,1,64,1,1,0,0,0,''),
    (700807,0,64,1,1,0,0,0,''),
    (700808,0,4,1,1,0,0,0,''),
    (700809,1,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700810,0,4,1,1,0,0,0,''),
    (700811,0,4,1,1,0,0,0,''),
    (700812,0,4,1,1,0,0,0,''),
    (700813,1,4,1,1,0,0,0,''),
    (700814,0,4,1,1,0,0,0,''),
    (700815,0,4,1,1,0,0,0,''),
    (700816,0,4,1,1,0,0,0,''),
    (700817,0,4,1,1,0,0,0,''),
    (700818,1,4,1,1,0,0,0,''),
    (700819,1,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700820,0,4,1,1,0,0,0,''),
    (700821,1,4,1,1,0,0,0,''),
    (700822,0,4,1,1,0,0,0,''),
    (700823,1,4,1,1,0,0,0,''),
    (700824,0,4,1,1,0,0,0,''),
    (700825,1,4,1,1,0,0,0,''),
    (700826,0,4,1,1,0,0,0,''),
    (700827,0,4,1,1,0,0,0,''),
    (700828,1,4,1,1,0,0,0,''),
    (700829,0,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700830,0,4,1,1,0,0,0,''),
    (700831,1,4,1,1,0,0,0,''),
    (700832,0,4,1,1,0,0,0,''),
    (700833,0,4,1,1,0,0,0,''),
    (700834,1,4,1,1,0,0,0,''),
    (700835,0,4,1,1,0,0,0,''),
    (700836,0,4,1,1,0,0,0,''),
    (700837,1,4,1,1,0,0,0,''),
    (700838,0,4,1,1,0,0,0,''),
    (700839,1,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700840,0,4,1,1,0,0,0,''),
    (700841,1,4,1,1,0,0,0,''),
    (700842,0,4,1,1,0,0,0,''),
    (700843,0,4,1,1,0,0,0,''),
    (700844,1,4,1,1,0,0,0,''),
    (700845,0,4,1,1,0,0,0,''),
    (700846,0,4,1,1,0,0,0,''),
    (700847,1,4,1,1,0,0,0,''),
    (700848,0,4,1,1,0,0,0,''),
    (700849,0,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700850,1,4,1,1,0,0,0,''),
    (700851,0,4,1,1,0,0,0,''),
    (700852,0,4,1,1,0,0,0,''),
    (700853,1,4,1,1,0,0,0,''),
    (700854,0,4,1,1,0,0,0,''),
    (700855,0,4,1,1,0,0,0,''),
    (700856,1,4,1,1,0,0,0,''),
    (700857,0,4,1,1,0,0,0,''),
    (700858,0,1,1,1,0,0,0,''),
    (700859,1,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700860,1,1,1,1,0,0,0,''),
    (700861,0,1,1,1,0,0,0,''),
    (700862,0,1,1,1,0,0,0,''),
    (700863,1,1,1,1,0,0,0,''),
    (700864,1,1,1,1,0,0,0,''),
    (700865,0,1,1,1,0,0,0,''),
    (700866,0,1,1,1,0,0,0,''),
    (700867,0,1,1,1,0,0,0,''),
    (700868,0,1,1,1,0,0,0,''),
    (700869,0,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700870,0,1,1,1,0,0,0,''),
    (700871,1,1,1,1,0,0,0,''),
    (700872,0,1,1,1,0,0,0,''),
    (700873,1,1,1,1,0,0,0,''),
    (700874,1,1,1,1,0,0,0,''),
    (700875,0,1,1,1,0,0,0,''),
    (700876,0,1,1,1,0,0,0,''),
    (700877,0,1,1,1,0,0,0,''),
    (700878,0,1,1,1,0,0,0,''),
    (700879,0,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700880,0,1,1,1,0,0,0,''),
    (700881,1,1,1,1,0,0,0,''),
    (700882,1,1,1,1,0,0,0,''),
    (700883,0,1,1,1,0,0,0,''),
    (700884,0,1,1,1,0,0,0,''),
    (700885,0,1,1,1,0,0,0,''),
    (700887,1,1,1,1,0,0,0,''),
    (700888,0,1,1,1,0,0,0,''),
    (700889,1,1,1,1,0,0,0,''),
    (700890,0,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700891,1,1,1,1,0,0,0,''),
    (700892,0,1,1,1,0,0,0,''),
    (700893,0,1,1,1,0,0,0,''),
    (700894,1,1,1,1,0,0,0,''),
    (700895,1,1,1,1,0,0,0,''),
    (700896,1,1,1,1,0,0,0,''),
    (700897,0,1,1,1,0,0,0,''),
    (700898,1,1,1,1,0,0,0,''),
    (700899,1,1,1,1,0,0,0,''),
    (700901,0,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700902,0,1,1,1,0,0,0,''),
    (700903,1,1,1,1,0,0,0,''),
    (700904,0,1,1,1,0,0,0,''),
    (700905,0,1,1,1,0,0,0,''),
    (700906,1,1,1,1,0,0,0,''),
    (700907,0,1,1,1,0,0,0,''),
    (700908,1,1,1,1,0,0,0,''),
    (700909,0,1,1,1,0,0,0,''),
    (700910,1,1,1,1,0,0,0,''),
    (700911,0,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700912,0,1,1,1,0,0,0,''),
    (700913,1,1,1,1,0,0,0,''),
    (700914,1,1,1,1,0,0,0,''),
    (700915,0,1,1,1,0,0,0,''),
    (700916,1,1,1,1,0,0,0,''),
    (700917,0,1,1,1,0,0,0,''),
    (700918,1,1,1,1,0,0,0,''),
    (700919,1,1,1,1,0,0,0,''),
    (700920,0,1,1,1,0,0,0,''),
    (700921,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700922,1,32,1,1,0,0,0,''),
    (700923,1,32,1,1,0,0,0,''),
    (700924,1,32,1,1,0,0,0,''),
    (700925,1,32,1,1,0,0,0,''),
    (700926,0,32,1,1,0,0,0,''),
    (700927,0,32,1,1,0,0,0,''),
    (700928,0,32,1,1,0,0,0,''),
    (700929,1,32,1,1,0,0,0,''),
    (700930,1,32,1,1,0,0,0,''),
    (700931,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700932,1,32,1,1,0,0,0,''),
    (700933,0,32,1,1,0,0,0,''),
    (700934,1,32,1,1,0,0,0,''),
    (700935,1,32,1,1,0,0,0,''),
    (700936,0,32,1,1,0,0,0,''),
    (700937,1,32,1,1,0,0,0,''),
    (700938,0,32,1,1,0,0,0,''),
    (700939,0,32,1,1,0,0,0,''),
    (700940,0,32,1,1,0,0,0,''),
    (700941,0,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700942,1,32,1,1,0,0,0,''),
    (700943,0,32,1,1,0,0,0,''),
    (700944,0,32,1,1,0,0,0,''),
    (700945,0,32,1,1,0,0,0,''),
    (700946,1,32,1,1,0,0,0,''),
    (700947,0,32,1,1,0,0,0,''),
    (700948,0,32,1,1,0,0,0,''),
    (700949,0,32,1,1,0,0,0,''),
    (700950,1,32,1,1,0,0,0,''),
    (700951,0,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700952,1,32,1,1,0,0,0,''),
    (700953,0,32,1,1,0,0,0,''),
    (700954,1,32,1,1,0,0,0,''),
    (700955,1,32,1,1,0,0,0,''),
    (700956,1,32,1,1,0,0,0,''),
    (700957,0,32,1,1,0,0,0,''),
    (700958,0,32,1,1,0,0,0,''),
    (700959,1,32,1,1,0,0,0,''),
    (700960,0,32,1,1,0,0,0,''),
    (700961,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700962,0,32,1,1,0,0,0,''),
    (700963,0,32,1,1,0,0,0,''),
    (700964,0,32,1,1,0,0,0,''),
    (700965,0,32,1,1,0,0,0,''),
    (700966,0,32,1,1,0,0,0,''),
    (700967,0,32,1,1,0,0,0,''),
    (700968,1,32,1,1,0,0,0,''),
    (700969,0,32,1,1,0,0,0,''),
    (700970,0,32,1,1,0,0,0,''),
    (700971,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700972,1,32,1,1,0,0,0,''),
    (700973,1,32,1,1,0,0,0,''),
    (700974,0,32,1,1,0,0,0,''),
    (700975,1,32,1,1,0,0,0,''),
    (700976,1,32,1,1,0,0,0,''),
    (700977,0,32,1,1,0,0,0,''),
    (700978,1,32,1,1,0,0,0,''),
    (700979,0,128,1,1,0,0,0,''),
    (700980,0,128,1,1,0,0,0,''),
    (700981,0,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700982,0,128,1,1,0,0,0,''),
    (700983,0,128,1,1,0,0,0,''),
    (700984,0,128,1,1,0,0,0,''),
    (700985,0,128,1,1,0,0,0,''),
    (700986,0,128,1,1,0,0,0,''),
    (700987,1,128,1,1,0,0,0,''),
    (700988,0,128,1,1,0,0,0,''),
    (700989,0,128,1,1,0,0,0,''),
    (700990,0,128,1,1,0,0,0,''),
    (700991,1,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (700992,1,128,1,1,0,0,0,''),
    (700993,1,128,1,1,0,0,0,''),
    (700994,1,128,1,1,0,0,0,''),
    (700995,0,128,1,1,0,0,0,''),
    (700996,0,128,1,1,0,0,0,''),
    (700997,0,128,1,1,0,0,0,''),
    (700998,0,128,1,1,0,0,0,''),
    (700999,1,128,1,1,0,0,0,''),
    (701000,1,128,1,1,0,0,0,''),
    (701001,0,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701002,1,128,1,1,0,0,0,''),
    (701003,0,128,1,1,0,0,0,''),
    (701004,1,128,1,1,0,0,0,''),
    (701005,0,128,1,1,0,0,0,''),
    (701006,0,128,1,1,0,0,0,''),
    (701007,0,128,1,1,0,0,0,''),
    (701008,0,128,1,1,0,0,0,''),
    (701009,0,128,1,1,0,0,0,''),
    (701010,0,128,1,1,0,0,0,''),
    (701011,0,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701012,0,128,1,1,0,0,0,''),
    (701013,0,128,1,1,0,0,0,''),
    (701014,0,128,1,1,0,0,0,''),
    (701015,0,128,1,1,0,0,0,''),
    (701016,1,128,1,1,0,0,0,''),
    (701017,0,128,1,1,0,0,0,''),
    (701018,0,128,1,1,0,0,0,''),
    (701019,0,128,1,1,0,0,0,''),
    (701020,0,128,1,1,0,0,0,''),
    (701021,0,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701022,0,128,1,1,0,0,0,''),
    (701023,1,128,1,1,0,0,0,''),
    (701024,1,128,1,1,0,0,0,''),
    (701025,0,128,1,1,0,0,0,''),
    (701026,0,128,1,1,0,0,0,''),
    (701027,0,128,1,1,0,0,0,''),
    (701028,0,128,1,1,0,0,0,''),
    (701029,1,128,1,1,0,0,0,''),
    (701031,1,128,1,1,0,0,0,''),
    (701032,0,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701033,0,128,1,1,0,0,0,''),
    (701034,1,128,1,1,0,0,0,''),
    (701035,0,128,1,1,0,0,0,''),
    (701036,1,128,1,1,0,0,0,''),
    (701037,0,128,1,1,0,0,0,''),
    (701038,0,128,1,1,0,0,0,''),
    (701039,0,128,1,1,0,0,0,''),
    (701040,0,128,1,1,0,0,0,''),
    (701041,0,256,1,1,0,0,0,''),
    (701042,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701043,1,256,1,1,0,0,0,''),
    (701044,1,256,1,1,0,0,0,''),
    (701045,0,256,1,1,0,0,0,''),
    (701046,0,256,1,1,0,0,0,''),
    (701047,1,256,1,1,0,0,0,''),
    (701048,1,256,1,1,0,0,0,''),
    (701050,0,256,1,1,0,0,0,''),
    (701052,0,256,1,1,0,0,0,''),
    (701053,1,256,1,1,0,0,0,''),
    (701054,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701055,1,256,1,1,0,0,0,''),
    (701056,1,256,1,1,0,0,0,''),
    (701057,0,256,1,1,0,0,0,''),
    (701058,0,256,1,1,0,0,0,''),
    (701059,1,256,1,1,0,0,0,''),
    (701060,0,256,1,1,0,0,0,''),
    (701061,0,256,1,1,0,0,0,''),
    (701062,0,256,1,1,0,0,0,''),
    (701063,0,256,1,1,0,0,0,''),
    (701064,1,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701065,0,256,1,1,0,0,0,''),
    (701066,0,256,1,1,0,0,0,''),
    (701067,0,256,1,1,0,0,0,''),
    (701068,1,256,1,1,0,0,0,''),
    (701069,0,256,1,1,0,0,0,''),
    (701070,0,256,1,1,0,0,0,''),
    (701071,0,256,1,1,0,0,0,''),
    (701072,0,256,1,1,0,0,0,''),
    (701073,1,256,1,1,0,0,0,''),
    (701074,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701075,0,256,1,1,0,0,0,''),
    (701076,0,256,1,1,0,0,0,''),
    (701077,1,256,1,1,0,0,0,''),
    (701078,1,256,1,1,0,0,0,''),
    (701079,1,256,1,1,0,0,0,''),
    (701080,0,256,1,1,0,0,0,''),
    (701081,0,256,1,1,0,0,0,''),
    (701082,0,256,1,1,0,0,0,''),
    (701083,0,256,1,1,0,0,0,''),
    (701084,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701085,1,256,1,1,0,0,0,''),
    (701086,0,256,1,1,0,0,0,''),
    (701087,1,256,1,1,0,0,0,''),
    (701088,0,256,1,1,0,0,0,''),
    (701089,0,256,1,1,0,0,0,''),
    (701090,1,256,1,1,0,0,0,''),
    (701091,1,256,1,1,0,0,0,''),
    (701092,0,256,1,1,0,0,0,''),
    (701093,0,256,1,1,0,0,0,''),
    (701094,0,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701096,0,256,1,1,0,0,0,''),
    (701097,0,256,1,1,0,0,0,''),
    (701098,1,256,1,1,0,0,0,''),
    (701099,0,256,1,1,0,0,0,''),
    (701100,0,256,1,1,0,0,0,''),
    (701101,0,256,1,1,0,0,0,''),
    (701102,0,256,1,1,0,0,0,''),
    (701103,1,256,1,1,0,0,0,''),
    (701104,1,8,1,1,0,0,0,''),
    (701105,0,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701106,1,8,1,1,0,0,0,''),
    (701107,0,8,1,1,0,0,0,''),
    (701108,0,8,1,1,0,0,0,''),
    (701109,1,8,1,1,0,0,0,''),
    (701110,0,8,1,1,0,0,0,''),
    (701111,0,8,1,1,0,0,0,''),
    (701112,0,8,1,1,0,0,0,''),
    (701113,1,8,1,1,0,0,0,''),
    (701114,1,8,1,1,0,0,0,''),
    (701115,1,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701116,1,8,1,1,0,0,0,''),
    (701117,0,8,1,1,0,0,0,''),
    (701118,0,8,1,1,0,0,0,''),
    (701119,1,8,1,1,0,0,0,''),
    (701120,0,8,1,1,0,0,0,''),
    (701121,1,8,1,1,0,0,0,''),
    (701122,0,8,1,1,0,0,0,''),
    (701123,1,8,1,1,0,0,0,''),
    (701124,0,8,1,1,0,0,0,''),
    (701125,1,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701126,0,8,1,1,0,0,0,''),
    (701127,0,8,1,1,0,0,0,''),
    (701128,0,8,1,1,0,0,0,''),
    (701129,0,8,1,1,0,0,0,''),
    (701130,1,8,1,1,0,0,0,''),
    (701131,1,8,1,1,0,0,0,''),
    (701132,0,8,1,1,0,0,0,''),
    (701133,1,8,1,1,0,0,0,''),
    (701134,0,8,1,1,0,0,0,''),
    (701135,0,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701136,0,8,1,1,0,0,0,''),
    (701137,0,8,1,1,0,0,0,''),
    (701138,1,8,1,1,0,0,0,''),
    (701139,1,8,1,1,0,0,0,''),
    (701140,1,8,1,1,0,0,0,''),
    (701141,0,8,1,1,0,0,0,''),
    (701142,0,8,1,1,0,0,0,''),
    (701143,0,8,1,1,0,0,0,''),
    (701144,0,8,1,1,0,0,0,''),
    (701145,0,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701146,1,8,1,1,0,0,0,''),
    (701147,1,8,1,1,0,0,0,''),
    (701148,1,8,1,1,0,0,0,''),
    (701149,1,8,1,1,0,0,0,''),
    (701150,0,8,1,1,0,0,0,''),
    (701151,0,8,1,1,0,0,0,''),
    (701152,1,8,1,1,0,0,0,''),
    (701153,0,8,1,1,0,0,0,''),
    (701154,1,8,1,1,0,0,0,''),
    (701155,1,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701157,0,2,1,1,0,0,0,''),
    (701158,1,2,1,1,0,0,0,''),
    (701159,0,2,1,1,0,0,0,''),
    (701160,1,2,1,1,0,0,0,''),
    (701161,1,2,1,1,0,0,0,''),
    (701162,0,2,1,1,0,0,0,''),
    (701163,0,2,1,1,0,0,0,''),
    (701164,0,2,1,1,0,0,0,''),
    (701165,0,2,1,1,0,0,0,''),
    (701166,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701167,0,2,1,1,0,0,0,''),
    (701168,1,2,1,1,0,0,0,''),
    (701169,1,2,1,1,0,0,0,''),
    (701170,0,2,1,1,0,0,0,''),
    (701171,1,2,1,1,0,0,0,''),
    (701172,0,2,1,1,0,0,0,''),
    (701173,0,2,1,1,0,0,0,''),
    (701174,1,2,1,1,0,0,0,''),
    (701175,1,2,1,1,0,0,0,''),
    (701176,1,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701177,0,2,1,1,0,0,0,''),
    (701178,1,2,1,1,0,0,0,''),
    (701179,0,2,1,1,0,0,0,''),
    (701180,1,2,1,1,0,0,0,''),
    (701181,1,2,1,1,0,0,0,''),
    (701182,1,2,1,1,0,0,0,''),
    (701183,0,2,1,1,0,0,0,''),
    (701184,1,2,1,1,0,0,0,''),
    (701185,0,2,1,1,0,0,0,''),
    (701186,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701187,1,2,1,1,0,0,0,''),
    (701188,1,2,1,1,0,0,0,''),
    (701189,0,2,1,1,0,0,0,''),
    (701190,0,2,1,1,0,0,0,''),
    (701191,1,2,1,1,0,0,0,''),
    (701192,0,2,1,1,0,0,0,''),
    (701193,1,2,1,1,0,0,0,''),
    (701194,0,2,1,1,0,0,0,''),
    (701195,0,2,1,1,0,0,0,''),
    (701196,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701197,1,2,1,1,0,0,0,''),
    (701198,0,2,1,1,0,0,0,''),
    (701199,1,2,1,1,0,0,0,''),
    (701200,1,2,1,1,0,0,0,''),
    (701201,1,2,1,1,0,0,0,''),
    (701202,0,2,1,1,0,0,0,''),
    (701203,0,2,1,1,0,0,0,''),
    (701204,0,2,1,1,0,0,0,''),
    (701205,1,2,1,1,0,0,0,''),
    (701206,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701207,1,2,1,1,0,0,0,''),
    (701208,1,2,1,1,0,0,0,''),
    (701209,0,2,1,1,0,0,0,''),
    (701210,0,2,1,1,0,0,0,''),
    (701211,0,2,1,1,0,0,0,''),
    (701212,0,2,1,1,0,0,0,''),
    (701213,0,2,1,1,0,0,0,''),
    (701214,0,2,1,1,0,0,0,''),
    (701215,1,2,1,1,0,0,0,''),
    (701216,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701217,0,1024,1,1,0,0,0,''),
    (701218,1,1024,1,1,0,0,0,''),
    (701220,0,1024,1,1,0,0,0,''),
    (701221,1,1024,1,1,0,0,0,''),
    (701222,0,1024,1,1,0,0,0,''),
    (701223,1,1024,1,1,0,0,0,''),
    (701224,1,1024,1,1,0,0,0,''),
    (701225,0,1024,1,1,0,0,0,''),
    (701226,1,1024,1,1,0,0,0,''),
    (701227,0,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701228,0,1024,1,1,0,0,0,''),
    (701229,1,1024,1,1,0,0,0,''),
    (701230,0,1024,1,1,0,0,0,''),
    (701231,1,1024,1,1,0,0,0,''),
    (701232,1,1024,1,1,0,0,0,''),
    (701233,1,1024,1,1,0,0,0,''),
    (701234,0,1024,1,1,0,0,0,''),
    (701235,0,1024,1,1,0,0,0,''),
    (701236,1,1024,1,1,0,0,0,''),
    (701237,0,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701238,0,1024,1,1,0,0,0,''),
    (701239,1,1024,1,1,0,0,0,''),
    (701240,0,1024,1,1,0,0,0,''),
    (701241,1,1024,1,1,0,0,0,''),
    (701242,0,1024,1,1,0,0,0,''),
    (701243,0,1024,1,1,0,0,0,''),
    (701244,1,1024,1,1,0,0,0,''),
    (701245,0,1024,1,1,0,0,0,''),
    (701246,0,1024,1,1,0,0,0,''),
    (701247,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701248,0,1024,1,1,0,0,0,''),
    (701249,1,1024,1,1,0,0,0,''),
    (701250,0,1024,1,1,0,0,0,''),
    (701251,1,1024,1,1,0,0,0,''),
    (701252,0,1024,1,1,0,0,0,''),
    (701253,0,1024,1,1,0,0,0,''),
    (701254,1,1024,1,1,0,0,0,''),
    (701255,0,1024,1,1,0,0,0,''),
    (701256,1,1024,1,1,0,0,0,''),
    (701257,0,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701258,1,1024,1,1,0,0,0,''),
    (701260,0,1024,1,1,0,0,0,''),
    (701261,0,1024,1,1,0,0,0,''),
    (701262,0,1024,1,1,0,0,0,''),
    (701263,0,1024,1,1,0,0,0,''),
    (701264,1,1024,1,1,0,0,0,''),
    (701265,0,1024,1,1,0,0,0,''),
    (701266,0,1024,1,1,0,0,0,''),
    (701267,1,1024,1,1,0,0,0,''),
    (701268,0,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701269,0,1024,1,1,0,0,0,''),
    (701270,1,1024,1,1,0,0,0,''),
    (701271,0,1024,1,1,0,0,0,''),
    (701272,0,1024,1,1,0,0,0,''),
    (701273,1,1024,1,1,0,0,0,''),
    (701274,0,1024,1,1,0,0,0,''),
    (701275,1,1024,1,1,0,0,0,''),
    (701276,0,1024,1,1,0,0,0,''),
    (701277,0,1024,1,1,0,0,0,''),
    (701278,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701279,0,1024,1,1,0,0,0,''),
    (701280,0,1024,1,1,0,0,0,''),
    (701281,1,1024,1,1,0,0,0,''),
    (701282,0,1024,1,1,0,0,0,''),
    (701283,1,1024,1,1,0,0,0,''),
    (701284,0,1024,1,1,0,0,0,''),
    (701285,1,1024,1,1,0,0,0,''),
    (701286,0,1024,1,1,0,0,0,''),
    (701287,1,1024,1,1,0,0,0,''),
    (701288,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (701289,0,1024,1,1,0,0,0,''),
    (701290,1,1024,1,1,0,0,0,''),
    (701291,0,1024,1,1,0,0,0,''),
    (701292,0,1024,1,1,0,0,0,''),
    (701293,1,1024,1,1,0,0,0,''),
    (701294,1,1024,1,1,0,0,0,''),
    (800800,1,128,1,1,0,0,0,''),
    (800801,1,128,1,1,0,0,0,''),
    (800802,1,1024,1,1,0,0,0,''),
    (800803,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800804,1,128,1,1,0,0,0,''),
    (800805,1,256,1,1,0,0,0,''),
    (800806,1,2,1,1,0,0,0,''),
    (800807,1,64,1,1,0,0,0,''),
    (800808,1,16,1,1,0,0,0,''),
    (800809,1,4,1,1,0,0,0,''),
    (800810,1,128,1,1,0,0,0,''),
    (800811,1,128,1,1,0,0,0,''),
    (800812,1,256,1,1,0,0,0,''),
    (800813,1,256,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800814,1,16,1,1,0,0,0,''),
    (800815,0,1535,1,1,0,0,0,''),
    (800816,0,1144,1,1,0,0,0,''),
    (800817,0,256,1,1,0,0,0,''),
    (800818,1,1,1,1,0,0,0,''),
    (800819,0,1,1,1,0,0,0,''),
    (800820,1,32,1,1,0,0,0,''),
    (800821,1,1024,1,1,0,0,0,''),
    (800822,1,4,1,1,0,0,0,''),
    (800823,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800824,1,4,1,1,0,0,0,''),
    (800825,1,256,1,1,0,0,0,''),
    (800826,1,1,1,1,0,0,0,''),
    (800827,1,2,1,1,0,0,0,''),
    (800828,0,1535,1,1,0,0,0,''),
    (800829,0,4,1,1,0,0,0,''),
    (800830,1,8,1,1,0,0,0,''),
    (800831,1,8,1,1,0,0,0,''),
    (800832,1,128,1,1,0,0,0,''),
    (800833,1,1024,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800834,1,8,1,1,0,0,0,''),
    (800835,1,1024,1,1,0,0,0,''),
    (800836,1,1,1,1,0,0,0,''),
    (800837,1,1131,1,1,0,0,0,''),
    (800838,1,1131,1,1,0,0,0,''),
    (800839,1,1131,1,1,0,0,0,''),
    (800840,1,1,1,1,0,0,0,''),
    (800841,0,1024,1,1,0,0,0,''),
    (800842,1,32,1,1,0,0,0,''),
    (800843,1,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800844,1,1,1,1,0,0,0,''),
    (800845,1,256,1,1,0,0,0,''),
    (800846,1,256,1,1,0,0,0,''),
    (800847,1,256,1,1,0,0,0,''),
    (800848,1,1024,1,1,0,0,0,''),
    (800849,1,64,1,1,0,0,0,''),
    (800850,1,2,1,1,0,0,0,''),
    (800851,1,8,1,1,0,0,0,''),
    (800852,1,32,1,1,0,0,0,''),
    (800853,1,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800854,1,4,1,1,0,0,0,''),
    (800855,1,16,1,1,0,0,0,''),
    (800856,1,16,1,1,0,0,0,''),
    (800857,1,4,1,1,0,0,0,''),
    (800858,0,4,1,1,0,0,0,''),
    (800859,0,4,1,1,0,0,0,''),
    (800860,0,4,1,1,0,0,0,''),
    (800861,1,64,1,1,0,0,0,''),
    (800862,1,64,1,1,0,0,0,''),
    (800863,0,2,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800864,1,2,1,1,0,0,0,''),
    (800865,0,8,1,1,0,0,0,''),
    (800866,1,4,1,1,0,0,0,''),
    (800867,1,256,1,1,0,0,0,''),
    (800868,1,128,1,1,0,0,0,''),
    (800869,1,16,1,1,0,0,0,''),
    (800870,0,256,1,1,0,0,0,''),
    (800871,0,128,1,1,0,0,0,''),
    (800872,1,1024,1,1,0,0,0,''),
    (800873,1,1,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800874,1,1024,1,1,0,0,0,''),
    (800875,1,4,1,1,0,0,0,''),
    (800876,1,16,1,1,0,0,0,''),
    (800877,1,128,1,1,0,0,0,''),
    (800878,1,2,1,1,0,0,0,''),
    (800879,1,32,1,1,0,0,0,''),
    (800880,1,16,1,1,0,0,0,''),
    (800881,1,8,1,1,0,0,0,''),
    (800882,1,8,1,1,0,0,0,''),
    (800883,1,64,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800884,1,64,1,1,0,0,0,''),
    (800885,1,1,1,1,0,0,0,''),
    (800886,1,1,1,1,0,0,0,''),
    (800887,1,1,1,1,0,0,0,''),
    (800888,1,1,1,1,0,0,0,''),
    (800889,1,1,1,1,0,0,0,''),
    (800890,1,256,1,1,0,0,0,''),
    (800891,1,2,1,1,0,0,0,''),
    (800892,1,4,1,1,0,0,0,''),
    (800893,1,4,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800894,1,4,1,1,0,0,0,''),
    (800895,1,32,1,1,0,0,0,''),
    (800896,1,1024,1,1,0,0,0,''),
    (800897,1,1024,1,1,0,0,0,''),
    (800898,1,1024,1,1,0,0,0,''),
    (800899,1,4,1,1,0,0,0,''),
    (800900,1,4,1,1,0,0,0,''),
    (800901,1,128,1,1,0,0,0,''),
    (800902,1,128,1,1,0,0,0,''),
    (800903,1,128,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800904,1,128,1,1,0,0,0,''),
    (800905,1,128,1,1,0,0,0,''),
    (800906,1,64,1,1,0,0,0,''),
    (800907,1,64,1,1,0,0,0,''),
    (800908,1,64,1,1,0,0,0,''),
    (800909,1,8,1,1,0,0,0,''),
    (800910,1,8,1,1,0,0,0,''),
    (800911,1,8,1,1,0,0,0,''),
    (800912,1,32,1,1,0,0,0,''),
    (800913,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800914,1,32,1,1,0,0,0,''),
    (800915,1,2,1,1,0,0,0,''),
    (800916,1,64,1,1,0,0,0,''),
    (800917,1,1024,1,1,0,0,0,''),
    (800918,1,256,1,1,0,0,0,''),
    (800919,1,256,1,1,0,0,0,''),
    (800920,1,1,1,1,0,0,0,''),
    (800921,1,1,1,1,0,0,0,''),
    (800922,1,16,1,1,0,0,0,''),
    (800923,1,16,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800924,0,256,1,1,0,0,0,''),
    (800925,1,256,1,1,0,0,0,''),
    (800926,1,1,1,1,0,0,0,''),
    (800927,0,256,1,1,0,0,0,''),
    (800928,1,2,1,1,0,0,0,''),
    (800929,1,2,1,1,0,0,0,''),
    (800930,1,1024,1,1,0,0,0,''),
    (800931,1,8,1,1,0,0,0,''),
    (800932,1,8,1,1,0,0,0,''),
    (800933,0,8,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800934,1,8,1,1,0,0,0,''),
    (800935,1,8,1,1,0,0,0,''),
    (800936,1,192,1,1,0,0,0,''),
    (800937,1,256,1,1,0,0,0,''),
    (800938,1,8,1,1,0,0,0,''),
    (800939,1,128,1,1,0,0,0,''),
    (800940,1,8,1,1,0,0,0,''),
    (800941,0,2,1,1,0,0,0,''),
    (800944,1,32,1,1,0,0,0,''),
    (800945,1,32,1,1,0,0,0,'');
INSERT INTO acore_world.perks (id,`unique`,allowableClass,permanent,chance,category,`type`,groupId,tags) VALUES
    (800946,1,260,1,1,0,0,0,''),
    (800947,0,64,1,1,0,0,0,''),
    (800948,0,64,1,1,0,0,0,'');
