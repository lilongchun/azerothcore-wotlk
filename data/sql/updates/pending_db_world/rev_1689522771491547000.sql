DELETE FROM `pet_levelstats` WHERE `creature_entry` IN (416,1860,1863,417,17252,89);
INSERT INTO `pet_levelstats` (`creature_entry`,`level`,`hp`,`mana`,`armor`,`str`,`agi`,`sta`,`inte`,`spi`,`min_dmg`,`max_dmg`) VALUES
-- Imp
(416,1,34,10,22,20,20,20,25,23,0,1),
(416,2,43,48,21,21,20,20,26,24,1,2),
(416,3,56,57,32,22,20,21,27,25,2,4),
(416,4,68,66,57,23,21,21,29,26,3,6),
(416,5,80,76,87,23,21,22,30,27,4,8),
(416,6,92,85,122,24,21,22,31,28,6,10),
(416,7,105,95,166,25,21,23,32,29,7,12),
(416,8,119,105,216,26,21,23,33,30,8,13),
(416,9,134,115,275,27,21,23,35,32,9,14),
(416,10,149,126,342,27,22,24,36,33,9,15),
(416,11,167,151,362,28,22,24,39,35,10,16),
(416,12,184,177,384,29,22,26,44,38,11,17),
(416,13,202,198,405,30,22,26,47,40,11,18),
(416,14,220,234,429,31,22,28,56,45,12,19),
(416,15,239,260,451,32,23,29,61,48,12,20),
(416,16,257,282,475,34,23,30,64,50,13,21),
(416,17,277,309,498,36,23,31,68,53,14,23),
(416,18,297,336,519,37,23,32,72,55,15,24),
(416,19,318,368,543,38,23,33,76,58,17,26),
(416,20,340,396,565,40,24,35,81,61,17,27),
(416,21,362,419,588,42,24,35,84,64,18,28),
(416,22,389,447,612,44,24,37,89,67,19,30),
(416,23,415,476,633,45,24,37,92,69,20,31),
(416,24,444,509,657,46,25,39,97,73,20,31),
(416,25,471,538,679,47,25,40,101,75,21,33),
(416,26,502,563,701,49,25,41,105,78,21,34),
(416,27,532,597,725,50,25,43,110,81,23,35),
(416,28,562,652,747,52,25,43,121,86,23,36),
(416,29,591,682,770,54,26,45,126,89,23,37),
(416,30,618,717,792,54,26,46,131,92,25,39),
(416,31,646,743,814,56,26,47,134,95,26,40),
(416,32,674,779,838,57,26,49,139,98,27,41),
(416,33,701,810,860,59,27,49,143,101,27,42),
(416,34,728,842,883,60,27,51,147,104,27,43),
(416,35,757,884,904,62,27,52,152,107,28,44),
(416,36,785,911,972,63,28,53,156,110,29,45),
(416,37,814,943,1045,64,28,55,161,114,30,47),
(416,38,843,982,1118,66,28,55,165,116,31,48),
(416,39,873,1015,1196,68,28,57,170,120,32,49),
(416,40,904,1053,1277,70,29,59,174,123,33,51),
(416,41,932,1087,1363,72,29,59,178,126,35,54),
(416,42,970,1145,1454,77,29,61,190,131,37,57),
(416,43,1008,1180,1546,81,29,62,194,134,39,60),
(416,44,1047,1214,1646,88,30,63,199,138,42,65),
(416,45,1087,1254,1747,91,30,65,204,141,45,75),
(416,46,1127,1294,1782,93,30,66,208,144,46,70),
(416,47,1170,1330,1818,95,31,68,213,148,47,72),
(416,48,1212,1366,1851,97,31,68,218,151,48,73),
(416,49,1257,1412,1887,99,31,70,223,155,49,75),
(416,50,1302,1449,1920,101,32,72,228,158,51,77),
(416,51,1347,1487,1956,103,32,73,232,161,51,78),
(416,52,1394,1534,1991,105,32,74,237,165,52,80),
(416,53,1441,1572,2025,107,33,75,241,168,54,82),
(416,54,1489,1615,2060,109,33,77,247,172,54,83),
(416,55,1537,1654,2093,111,33,79,252,176,56,85),
(416,56,1587,1717,2131,114,34,80,265,181,57,87),
(416,57,1637,1762,2165,116,34,81,271,185,58,88),
(416,58,1688,1802,2198,117,34,82,275,188,69,105),
(416,59,1741,1847,2234,120,35,84,281,193,75,114),
(416,60,1793,1897,2427,122,35,86,286,196,109,165),
(416,61,1848,1938,2617,125,35,87,286,206,116,175),
(416,62,1903,1984,2807,126,35,89,286,212,124,187),
(416,63,1958,2031,2998,129,36,90,286,220,132,199),
(416,64,2014,2078,3188,131,36,92,287,226,139,211),
(416,65,2071,2125,3378,134,36,94,288,233,148,223),
(416,66,2131,2173,3569,135,37,94,297,239,156,236),
(416,67,2192,2226,3759,138,37,96,306,246,164,248),
(416,68,2255,2270,3949,140,37,97,312,251,192,290),
(416,69,2317,2319,4141,143,38,99,319,257,211,317),
(416,70,2381,2374,4330,145,38,101,327,263,228,343),
(416,71,2526,2419,4524,147,41,102,331,269,235,354),
(416,72,2666,2475,4717,150,44,104,335,275,242,364),
(416,73,2809,2526,4910,153,47,105,339,281,249,374),
(416,74,2955,2577,5104,168,51,107,343,333,256,385),
(416,75,3102,2634,5299,185,55,109,347,339,264,397),
(416,76,3250,2686,5492,203,59,110,351,344,271,408),
(416,77,3401,2743,5688,224,64,113,355,349,279,420),
(416,78,3553,2791,5881,246,68,114,360,355,287,432),
(416,79,3709,2850,6078,270,74,116,364,360,295,444),
(416,80,3867,2908,6273,297,79,118,369,367,305,458),
-- Voidwalker
(1860,1,1,1,1,1,1,1,1,1,1,1),
(1860,2,1,1,1,1,1,1,1,1,1,1),
(1860,3,1,1,1,1,1,1,1,1,1,1),
(1860,4,1,1,1,1,1,1,1,1,1,1),
(1860,5,1,1,1,1,1,1,1,1,1,1),
(1860,6,1,1,1,1,1,1,1,1,1,1),
(1860,7,1,1,1,1,1,1,1,1,1,1),
(1860,8,1,1,1,1,1,1,1,1,1,1),
(1860,9,1,1,1,1,1,1,1,1,1,1),
(1860,10,205,147,831,29,10,29,25,27,7,13),
(1860,11,229,158,875,30,10,32,26,28,8,14),
(1860,12,253,192,931,31,10,36,27,29,9,15),
(1860,13,278,203,987,32,11,40,28,30,9,15),
(1860,14,304,228,1044,33,11,44,29,31,9,16),
(1860,15,331,252,1102,34,12,48,31,32,11,18),
(1860,16,358,275,1160,36,12,52,31,33,11,19),
(1860,17,385,300,1217,38,12,55,32,34,13,21),
(1860,18,415,314,1273,39,13,59,34,36,12,21),
(1860,19,444,352,1330,40,13,63,34,37,13,22),
(1860,20,476,378,1386,42,14,67,36,38,14,23),
(1860,21,510,393,1446,44,14,71,37,39,15,25),
(1860,22,548,420,1503,46,14,75,38,41,15,25),
(1860,23,586,448,1559,47,15,79,39,42,16,26),
(1860,24,628,477,1617,49,16,83,40,43,16,27),
(1860,25,671,505,1672,50,16,87,42,44,18,29),
(1860,26,716,534,1729,52,16,91,43,46,19,30),
(1860,27,759,564,1788,53,17,95,43,47,19,31),
(1860,28,805,582,1842,55,17,99,45,48,20,32),
(1860,29,850,625,1900,57,18,103,46,49,20,32),
(1860,30,892,657,1955,57,18,107,48,51,21,34),
(1860,31,935,677,2012,59,19,111,49,52,22,35),
(1860,32,977,720,2071,60,19,115,50,53,22,36),
(1860,33,1021,742,2125,62,20,119,51,54,23,37),
(1860,34,1064,776,2184,63,20,123,52,56,23,37),
(1860,35,1110,822,2238,65,21,127,54,57,24,39),
(1860,36,1155,845,2415,66,21,131,55,59,25,40),
(1860,37,1202,880,2602,68,21,135,56,60,26,41),
(1860,38,1249,917,2795,70,22,139,58,62,26,42),
(1860,39,1298,953,3002,72,22,143,59,63,27,43),
(1860,40,1349,988,3219,74,23,148,61,65,28,44),
(1860,41,1395,1026,3444,76,23,152,62,66,30,47),
(1860,42,1453,1064,3685,81,23,156,63,67,31,49),
(1860,43,1510,1104,3936,86,24,160,65,69,34,53),
(1860,44,1569,1143,4203,93,25,164,65,70,36,58),
(1860,45,1626,1182,4480,96,25,169,67,72,38,60),
(1860,46,1689,1223,4573,98,26,173,68,73,38,61),
(1860,47,1751,1264,4641,100,26,177,70,75,40,63),
(1860,48,1815,1306,4749,102,27,181,72,76,40,64),
(1860,49,1881,1348,4841,104,27,186,73,78,42,66),
(1860,50,1949,1393,4931,107,28,190,75,80,43,68),
(1860,51,2017,1436,5018,109,29,194,76,81,43,68),
(1860,52,2087,1482,5110,111,29,199,77,82,45,71),
(1860,53,2158,1528,5200,113,30,203,79,84,45,72),
(1860,54,2229,1573,5287,115,30,207,80,85,47,74),
(1860,55,2300,1631,5376,117,31,212,82,88,48,75),
(1860,56,2375,1667,5468,120,31,216,83,89,48,76),
(1860,57,2450,1727,5556,122,32,221,84,90,50,78),
(1860,58,2527,1764,5645,124,33,225,87,92,63,99),
(1860,59,2606,1825,5734,127,33,230,88,94,68,107),
(1860,60,2686,1876,6236,129,34,234,90,96,87,134),
(1860,61,2767,1915,6730,132,35,239,105,99,100,154),
(1860,62,2849,1979,7223,133,36,243,108,102,110,169),
(1860,63,2932,2019,7717,136,37,248,112,105,117,180),
(1860,64,3014,2084,8210,138,38,252,115,108,125,191),
(1860,65,3101,2150,8704,141,39,257,119,110,132,202),
(1860,66,3189,2193,9197,143,39,261,122,113,140,214),
(1860,67,3280,2260,9693,146,41,266,124,115,148,226),
(1860,68,3374,2304,10186,148,41,271,127,118,173,264),
(1860,69,3468,2373,10679,151,42,275,130,120,189,289),
(1860,70,3564,2431,11173,153,43,280,133,122,207,314),
(1860,71,3742,2489,11670,155,47,285,134,125,212,323),
(1860,72,3915,2550,12165,158,50,289,136,127,218,332),
(1860,73,4094,2610,12662,161,54,294,138,130,225,342),
(1860,74,4276,2671,13159,177,58,299,139,190,231,352),
(1860,75,4461,2744,13658,195,63,304,141,194,238,362),
(1860,76,4647,2807,14155,214,67,309,143,196,244,371),
(1860,77,4837,2870,14652,236,72,314,144,200,250,381),
(1860,78,5029,2935,15151,260,78,318,146,202,257,392),
(1860,79,5226,3000,15650,285,84,323,148,206,264,403),
(1860,80,5428,3077,16148,314,90,328,150,209,271,414),
-- Succubus
(1863,1,1,1,1,1,1,1,1,1,1,1),
(1863,2,1,1,1,1,1,1,1,1,1,1),
(1863,3,1,1,1,1,1,1,1,1,1,1),
(1863,4,1,1,1,1,1,1,1,1,1,1),
(1863,5,1,1,1,1,1,1,1,1,1,1),
(1863,6,1,1,1,1,1,1,1,1,1,1),
(1863,7,1,1,1,1,1,1,1,1,1,1),
(1863,8,1,1,1,1,1,1,1,1,1,1),
(1863,9,1,1,1,1,1,1,1,1,1,1),
(1863,10,1,1,1,1,1,1,1,1,1,1),
(1863,11,1,1,1,1,1,1,1,1,1,1),
(1863,12,1,1,1,1,1,1,1,1,1,1),
(1863,13,1,1,1,1,1,1,1,1,1,1),
(1863,14,1,1,1,1,1,1,1,1,1,1),
(1863,15,1,1,1,1,1,1,1,1,1,1),
(1863,16,1,1,1,1,1,1,1,1,1,1),
(1863,17,1,1,1,1,1,1,1,1,1,1),
(1863,18,1,1,1,1,1,1,1,1,1,1),
(1863,19,1,1,1,1,1,1,1,1,1,1),
(1863,20,387,378,836,42,14,67,36,38,19,31),
(1863,21,415,393,872,44,14,71,37,39,21,32),
(1863,22,445,420,906,46,14,75,38,41,21,33),
(1863,23,477,448,940,47,15,79,39,42,22,35),
(1863,24,511,477,975,49,16,83,40,43,23,36),
(1863,25,546,505,1008,50,16,87,42,44,24,38),
(1863,26,583,534,1042,52,16,91,43,46,25,39),
(1863,27,618,564,1078,53,17,95,43,47,26,40),
(1863,28,656,582,1110,55,17,99,45,48,27,42),
(1863,29,693,625,1145,57,18,103,46,49,28,43),
(1863,30,727,657,1178,57,18,107,48,51,29,44),
(1863,31,762,677,1213,59,19,111,49,52,30,46),
(1863,32,796,720,1248,60,19,115,50,53,30,47),
(1863,33,832,742,1281,62,20,119,51,54,32,48),
(1863,34,867,776,1316,63,20,123,52,56,32,49),
(1863,35,904,822,1349,65,21,127,54,57,33,51),
(1863,36,941,845,1455,66,21,131,55,59,35,53),
(1863,37,980,880,1567,68,21,135,56,60,35,54),
(1863,38,1017,917,1683,70,22,139,58,62,36,55),
(1863,39,1058,953,1807,72,22,143,59,63,37,57),
(1863,40,1099,961,1937,74,23,148,61,65,38,58),
(1863,41,1137,1026,2072,76,23,152,62,66,41,62),
(1863,42,1185,1064,2216,81,23,156,63,67,43,65),
(1863,43,1232,1104,2367,86,24,160,65,69,46,70),
(1863,44,1279,1143,2527,93,25,164,65,70,50,76),
(1863,45,1326,1182,2693,96,25,169,67,72,52,79),
(1863,46,1377,1223,2749,98,26,173,68,73,53,80),
(1863,47,1393,1264,2802,100,26,177,70,75,55,83),
(1863,48,1481,1306,2855,102,27,181,72,76,55,84),
(1863,49,1535,1348,2910,104,27,186,73,78,57,87),
(1863,50,1590,1393,2964,107,28,190,75,80,59,89),
(1863,51,1646,1436,3017,109,29,194,76,81,59,90),
(1863,52,1702,1482,3072,111,29,199,77,82,61,93),
(1863,53,1761,1528,3126,113,30,203,79,84,62,94),
(1863,54,1818,1573,3178,115,30,207,80,85,64,97),
(1863,55,1877,1631,3232,117,31,212,82,88,65,98),
(1863,56,1938,1667,3287,120,31,216,83,89,66,100),
(1863,57,1999,1727,3340,122,32,221,84,90,68,103),
(1863,58,2062,1764,3394,124,33,225,87,92,85,128),
(1863,59,2127,1825,3447,127,33,230,88,94,91,137),
(1863,60,2193,1876,3748,129,34,234,90,96,113,171),
(1863,61,2258,1915,4044,132,35,239,105,99,130,195),
(1863,62,2326,1979,4340,133,36,243,108,102,142,214),
(1863,63,2392,2019,4636,136,37,248,112,105,151,227),
(1863,64,2460,2084,4932,138,38,252,115,108,160,241),
(1863,65,2531,2150,5228,141,39,257,119,110,170,255),
(1863,66,2603,2193,5523,143,39,261,122,113,180,270),
(1863,67,2678,2260,5821,146,41,266,124,115,190,285),
(1863,68,2754,2304,6116,148,41,271,127,118,220,331),
(1863,69,2832,2373,6412,151,42,275,130,120,241,361),
(1863,70,2910,2431,6708,153,43,280,133,122,261,392),
(1863,71,3070,2489,7007,155,47,285,134,125,269,403),
(1863,72,3225,2550,7305,158,50,289,136,127,276,415),
(1863,73,3384,2610,7604,161,54,294,138,130,284,427),
(1863,74,3546,2671,7903,177,58,299,139,190,293,440),
(1863,75,3710,2744,8204,195,63,304,141,194,302,453),
(1863,76,3874,2807,8503,214,67,309,143,196,310,466),
(1863,77,4044,2870,8803,236,72,314,144,200,320,480),
(1863,78,4214,2935,9104,260,78,318,146,202,330,494),
(1863,79,4387,3000,9405,285,84,323,148,206,340,509),
(1863,80,4567,3077,9706,314,90,328,150,209,350,524),
-- Felhunter
(417,1,1,1,1,1,1,1,1,1,1,1),
(417,2,1,1,1,1,1,1,1,1,1,1),
(417,3,1,1,1,1,1,1,1,1,1,1),
(417,4,1,1,1,1,1,1,1,1,1,1),
(417,5,1,1,1,1,1,1,1,1,1,1),
(417,6,1,1,1,1,1,1,1,1,1,1),
(417,7,1,1,1,1,1,1,1,1,1,1),
(417,8,1,1,1,1,1,1,1,1,1,1),
(417,9,1,1,1,1,1,1,1,1,1,1),
(417,10,1,1,1,1,1,1,1,1,1,1),
(417,11,1,1,1,1,1,1,1,1,1,1),
(417,12,1,1,1,1,1,1,1,1,1,1),
(417,13,1,1,1,1,1,1,1,1,1,1),
(417,14,1,1,1,1,1,1,1,1,1,1),
(417,15,1,1,1,1,1,1,1,1,1,1),
(417,16,1,1,1,1,1,1,1,1,1,1),
(417,17,1,1,1,1,1,1,1,1,1,1),
(417,18,1,1,1,1,1,1,1,1,1,1),
(417,19,1,1,1,1,1,1,1,1,1,1),
(417,20,1,1,1,1,1,1,1,1,1,1),
(417,21,1,1,1,1,1,1,1,1,1,1),
(417,22,1,1,1,1,1,1,1,1,1,1),
(417,23,1,1,1,1,1,1,1,1,1,1),
(417,24,1,1,1,1,1,1,1,1,1,1),
(417,25,1,1,1,1,1,1,1,1,1,1),
(417,26,1,1,1,1,1,1,1,1,1,1),
(417,27,1,1,1,1,1,1,1,1,1,1),
(417,28,1,1,1,1,1,1,1,1,1,1),
(417,29,1,1,1,1,1,1,1,1,1,1),
(417,30,770,657,946,57,18,107,48,51,19,31),
(417,31,807,677,974,59,19,111,49,52,19,32),
(417,32,844,720,1002,60,19,115,50,53,19,32),
(417,33,882,742,1028,62,20,119,51,54,20,33),
(417,34,919,776,1057,63,20,123,52,56,20,34),
(417,35,958,822,1083,65,21,127,54,57,21,35),
(417,36,997,845,1168,66,21,131,55,59,22,36),
(417,37,1038,880,1257,68,21,135,56,60,23,37),
(417,38,1078,917,1350,70,22,139,58,62,23,37),
(417,39,1120,953,1450,72,22,143,59,63,24,39),
(417,40,1165,988,1554,74,23,148,61,65,24,40),
(417,41,1204,1026,1662,76,23,152,62,66,26,43),
(417,42,1255,1064,1777,81,23,156,63,67,27,45),
(417,43,1304,1104,1898,86,24,160,65,69,30,48),
(417,44,1354,1143,2026,93,25,164,65,70,32,52),
(417,45,1404,1182,2159,96,25,169,67,72,34,54),
(417,46,1458,1223,2204,98,26,173,68,73,34,55),
(417,47,1512,1264,2246,100,26,177,70,75,35,57),
(417,48,1567,1306,2289,102,27,181,72,76,36,58),
(417,49,1624,1348,2333,104,27,186,73,78,37,60),
(417,50,1683,1393,2376,107,28,190,75,80,38,61),
(417,51,1742,1436,2419,109,29,194,76,81,38,62),
(417,52,1802,1482,2463,111,29,199,77,82,40,64),
(417,53,1863,1528,2506,113,30,203,79,84,40,65),
(417,54,1925,1573,2548,115,30,207,80,85,42,67),
(417,55,1986,1631,2591,117,31,212,82,88,42,68),
(417,56,2051,1667,2635,120,31,216,83,89,43,69),
(417,57,2116,1727,2678,122,32,221,84,90,44,71),
(417,58,2182,1764,2721,124,33,225,87,92,57,89),
(417,59,2251,1825,2764,127,33,230,88,94,61,97),
(417,60,2320,1876,3005,129,34,234,90,96,78,122),
(417,61,2389,1915,3242,132,35,239,105,99,90,140),
(417,62,2460,1979,3479,133,36,243,108,102,100,154),
(417,63,2531,2019,3716,136,37,248,112,105,107,165),
(417,64,2602,2084,3953,138,38,252,115,108,113,175),
(417,65,2678,2150,4190,141,39,257,119,110,120,185),
(417,66,2754,2193,4426,143,39,261,122,113,128,197),
(417,67,2833,2260,4665,146,41,266,124,115,135,208),
(417,68,2913,2304,4901,148,41,271,127,118,158,243),
(417,69,2995,2373,5138,151,42,275,130,120,173,266),
(417,70,3077,2431,5375,153,43,280,133,122,189,289),
(417,71,3242,2489,5615,155,47,285,134,125,194,297),
(417,72,3401,2550,5854,158,50,289,136,127,200,306),
(417,73,3566,2610,6094,161,54,294,138,130,206,315),
(417,74,3733,2671,6334,177,58,299,139,190,212,324),
(417,75,3903,2744,6575,195,63,304,141,194,217,333),
(417,76,4072,2807,6815,214,67,309,143,196,222,341),
(417,77,4247,2870,7056,236,72,314,144,200,228,350),
(417,78,4422,2935,7298,260,78,318,146,202,234,359),
(417,79,4602,3000,7540,285,84,323,148,206,240,369),
(417,80,4787,3077,7782,314,90,328,150,209,246,379),
-- Felguard
(17252,1,1,1,1,1,1,1,1,1,1,1),
(17252,2,1,1,1,1,1,1,1,1,1,1),
(17252,3,1,1,1,1,1,1,1,1,1,1),
(17252,4,1,1,1,1,1,1,1,1,1,1),
(17252,5,1,1,1,1,1,1,1,1,1,1),
(17252,6,1,1,1,1,1,1,1,1,1,1),
(17252,7,1,1,1,1,1,1,1,1,1,1),
(17252,8,1,1,1,1,1,1,1,1,1,1),
(17252,9,1,1,1,1,1,1,1,1,1,1),
(17252,10,1,1,1,1,1,1,1,1,1,1),
(17252,11,1,1,1,1,1,1,1,1,1,1),
(17252,12,1,1,1,1,1,1,1,1,1,1),
(17252,13,1,1,1,1,1,1,1,1,1,1),
(17252,14,1,1,1,1,1,1,1,1,1,1),
(17252,15,1,1,1,1,1,1,1,1,1,1),
(17252,16,1,1,1,1,1,1,1,1,1,1),
(17252,17,1,1,1,1,1,1,1,1,1,1),
(17252,18,1,1,1,1,1,1,1,1,1,1),
(17252,19,1,1,1,1,1,1,1,1,1,1),
(17252,20,1,1,1,1,1,1,1,1,1,1),
(17252,21,1,1,1,1,1,1,1,1,1,1),
(17252,22,1,1,1,1,1,1,1,1,1,1),
(17252,23,1,1,1,1,1,1,1,1,1,1),
(17252,24,1,1,1,1,1,1,1,1,1,1),
(17252,25,1,1,1,1,1,1,1,1,1,1),
(17252,26,1,1,1,1,1,1,1,1,1,1),
(17252,27,1,1,1,1,1,1,1,1,1,1),
(17252,28,1,1,1,1,1,1,1,1,1,1),
(17252,29,1,1,1,1,1,1,1,1,1,1),
(17252,30,1,1,1,1,1,1,1,1,1,1),
(17252,31,1,1,1,1,1,1,1,1,1,1),
(17252,32,1,1,1,1,1,1,1,1,1,1),
(17252,33,1,1,1,1,1,1,1,1,1,1),
(17252,34,1,1,1,1,1,1,1,1,1,1),
(17252,35,1,1,1,1,1,1,1,1,1,1),
(17252,36,1,1,1,1,1,1,1,1,1,1),
(17252,37,1,1,1,1,1,1,1,1,1,1),
(17252,38,1,1,1,1,1,1,1,1,1,1),
(17252,39,1,1,1,1,1,1,1,1,1,1),
(17252,40,1,1,1,1,1,1,1,1,1,1),
(17252,41,1,1,1,1,1,1,1,1,1,1),
(17252,42,1,1,1,1,1,1,1,1,1,1),
(17252,43,1,1,1,1,1,1,1,1,1,1),
(17252,44,1,1,1,1,1,1,1,1,1,1),
(17252,45,1,1,1,1,1,1,1,1,1,1),
(17252,46,1,1,1,1,1,1,1,1,1,1),
(17252,47,1,1,1,1,1,1,1,1,1,1),
(17252,48,1,1,1,1,1,1,1,1,1,1),
(17252,49,1,1,1,1,1,1,1,1,1,1),
(17252,50,1949,1393,4285,107,28,190,75,80,54,83),
(17252,51,2017,1436,4361,109,29,194,76,81,55,84),
(17252,52,2087,1482,4441,111,29,199,77,82,57,87),
(17252,53,2158,1528,4519,113,30,203,79,84,58,88),
(17252,54,2229,1573,4594,115,30,207,80,85,60,91),
(17252,55,2300,1631,4672,117,31,212,82,88,61,92),
(17252,56,2375,1667,4752,120,31,216,83,89,61,94),
(17252,57,2450,1727,4828,122,32,221,84,90,63,96),
(17252,58,2527,1764,4906,124,33,225,87,92,79,120),
(17252,59,2606,1825,4983,127,33,230,88,94,85,129),
(17252,60,2686,1876,5419,129,34,234,90,96,106,161),
(17252,61,2767,1915,5848,132,35,239,105,99,122,184),
(17252,62,2849,1979,6276,133,36,243,108,102,134,202),
(17252,63,2932,2019,6705,136,37,248,112,105,142,215),
(17252,64,3014,2084,7134,138,38,252,115,108,151,228),
(17252,65,3101,2150,7563,141,39,257,119,110,160,241),
(17252,66,3189,2193,7990,143,39,261,122,113,169,255),
(17252,67,3280,2260,8422,146,41,266,124,115,179,269),
(17252,68,3374,2304,8849,148,41,271,127,118,208,314),
(17252,69,3468,2373,9278,151,42,275,130,120,227,342),
(17252,70,3564,2431,9707,153,43,280,133,122,247,372),
(17252,71,3742,2489,10139,155,47,285,134,125,254,382),
(17252,72,3915,2550,10569,158,50,289,136,127,261,393),
(17252,73,4094,2610,11001,161,54,294,138,130,268,404),
(17252,74,4276,2671,11433,177,58,299,139,190,277,417),
(17252,75,4461,2744,11867,195,63,304,141,194,285,429),
(17252,76,4647,2807,12299,214,67,309,143,196,266,441),
(17252,77,4837,2870,12731,236,72,314,144,200,302,454),
(17252,78,5029,2935,13165,260,78,318,146,202,310,467),
(17252,79,5226,3000,13599,285,84,323,148,206,320,481),
(17252,80,5428,3077,14033,314,90,328,150,209,329,495),
-- Infernal
(89,1,1,1,1,1,1,1,1,1,1,1),
(89,2,1,1,1,1,1,1,1,1,1,1),
(89,3,1,1,1,1,1,1,1,1,1,1),
(89,4,1,1,1,1,1,1,1,1,1,1),
(89,5,1,1,1,1,1,1,1,1,1,1),
(89,6,1,1,1,1,1,1,1,1,1,1),
(89,7,1,1,1,1,1,1,1,1,1,1),
(89,8,1,1,1,1,1,1,1,1,1,1),
(89,9,1,1,1,1,1,1,1,1,1,1),
(89,10,1,1,1,1,1,1,1,1,1,1),
(89,11,1,1,1,1,1,1,1,1,1,1),
(89,12,1,1,1,1,1,1,1,1,1,1),
(89,13,1,1,1,1,1,1,1,1,1,1),
(89,14,1,1,1,1,1,1,1,1,1,1),
(89,15,1,1,1,1,1,1,1,1,1,1),
(89,16,1,1,1,1,1,1,1,1,1,1),
(89,17,1,1,1,1,1,1,1,1,1,1),
(89,18,1,1,1,1,1,1,1,1,1,1),
(89,19,1,1,1,1,1,1,1,1,1,1),
(89,20,1,1,1,1,1,1,1,1,1,1),
(89,21,1,1,1,1,1,1,1,1,1,1),
(89,22,1,1,1,1,1,1,1,1,1,1),
(89,23,1,1,1,1,1,1,1,1,1,1),
(89,24,1,1,1,1,1,1,1,1,1,1),
(89,25,1,1,1,1,1,1,1,1,1,1),
(89,26,1,1,1,1,1,1,1,1,1,1),
(89,27,1,1,1,1,1,1,1,1,1,1),
(89,28,1,1,1,1,1,1,1,1,1,1),
(89,29,1,1,1,1,1,1,1,1,1,1),
(89,30,1,1,1,1,1,1,1,1,1,1),
(89,31,1,1,1,1,1,1,1,1,1,1),
(89,32,1,1,1,1,1,1,1,1,1,1),
(89,33,1,1,1,1,1,1,1,1,1,1),
(89,34,1,1,1,1,1,1,1,1,1,1),
(89,35,1,1,1,1,1,1,1,1,1,1),
(89,36,1,1,1,1,1,1,1,1,1,1),
(89,37,1,1,1,1,1,1,1,1,1,1),
(89,38,1,1,1,1,1,1,1,1,1,1),
(89,39,1,1,1,1,1,1,1,1,1,1),
(89,40,1,1,1,1,1,1,1,1,1,1),
(89,41,1,1,1,1,1,1,1,1,1,1),
(89,42,1,1,1,1,1,1,1,1,1,1),
(89,43,1,1,1,1,1,1,1,1,1,1),
(89,44,1,1,1,1,1,1,1,1,1,1),
(89,45,1,1,1,1,1,1,1,1,1,1),
(89,46,1,1,1,1,1,1,1,1,1,1),
(89,47,1,1,1,1,1,1,1,1,1,1),
(89,48,1,1,1,1,1,1,1,1,1,1),
(89,49,1,1,1,1,1,1,1,1,1,1),
(89,50,4577,1692,4931,107,28,190,75,80,243,327),
(89,51,4733,1747,5018,109,29,194,76,81,250,330),
(89,52,4883,1793,5110,111,29,199,77,82,251,338),
(89,53,5048,1850,5200,113,30,203,79,84,258,346),
(89,54,5209,1895,5287,115,30,207,80,85,263,354),
(89,55,5372,1965,5376,117,31,212,82,88,270,361),
(89,56,5533,2012,5468,120,31,216,83,89,276,362),
(89,57,5704,2072,5556,122,32,221,84,90,279,377),
(89,58,8002,2121,5645,124,33,225,87,92,329,450),
(89,59,8302,2182,5734,127,33,230,88,94,352,478),
(89,60,9892,2244,6236,129,34,234,90,96,430,587),
(89,61,10241,2295,6730,132,35,239,105,99,472,659),
(89,62,10598,2359,7223,133,36,243,108,102,517,707),
(89,63,10960,2410,7717,136,37,248,112,105,541,762),
(89,64,11317,2487,8210,138,38,252,115,108,583,772),
(89,65,11714,2553,8704,141,39,257,119,110,600,852),
(89,66,12106,2607,9197,143,39,261,122,113,632,871),
(89,67,12505,2686,9693,146,41,266,124,115,675,929),
(89,68,13768,2730,10186,148,41,271,127,118,763,1028),
(89,69,15674,2810,10679,151,42,275,130,120,826,1176),
(89,70,17579,2880,11173,153,43,280,133,122,907,1282),
(89,71,18254,2938,11670,155,47,285,134,125,928,1311),
(89,72,18941,3010,12165,158,50,289,136,127,940,1337),
(89,73,19649,3082,12662,161,54,294,138,130,1006,1384),
(89,74,20371,3154,13159,177,58,299,139,190,1010,1442),
(89,75,21131,3227,13658,195,63,304,141,194,1052,1462),
(89,76,21908,3302,14155,214,67,309,143,196,1091,1537),
(89,77,22698,3376,14652,236,72,314,144,200,1136,1581),
(89,78,23531,3453,15151,260,78,318,146,202,1165,1657),
(89,79,24381,3529,15650,285,84,323,148,206,1224,1687),
(89,80,252610,3618,16148,314,90,328,150,209,1263,1768);
