/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `creature_summon_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_summon_groups` 
(
  `summonerId` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `summonerType` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `entry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `position_x` float NOT NULL DEFAULT 0,
  `position_y` float NOT NULL DEFAULT 0,
  `position_z` float NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0,
  `summonType` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `summonTime` int(10) unsigned NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `creature_summon_groups` WRITE;
/*!40000 ALTER TABLE `creature_summon_groups` DISABLE KEYS */;
INSERT INTO `creature_summon_groups` VALUES 
(28952,0,1,28988,6810.89,-4592.67,440.678,1.29927,3,100000),
(28952,0,1,28988,6806.19,-4595.94,440.678,1.25002,3,100000),
(28952,0,1,28988,6822.09,-4599.02,440.678,1.46911,3,100000),
(28952,0,1,28988,6797.53,-4594.82,440.685,1.13757,3,100000),
(28952,0,1,28988,6827.48,-4601.45,440.678,1.54302,3,100000),
(28952,0,1,28988,6817.19,-4601.69,440.678,1.40949,3,100000),
(28952,0,1,28988,6834.82,-4602.4,440.678,1.6388,3,100000),
(28952,0,1,28988,6805.29,-4601.96,440.678,1.2631,3,100000),
(28952,0,1,28988,6765.52,-4543.85,440.678,0.27867,3,100000),
(28952,0,1,28988,6764.08,-4549.87,440.678,0.355846,3,100000),
(28952,0,1,28988,6765.49,-4564.42,440.678,0.545472,3,100000),
(28952,0,1,28988,6763.99,-4537.71,440.678,0.183667,3,100000),
(28952,0,1,28988,6827,-4607.5,440.678,1.53924,3,100000),
(28952,0,1,28988,6763.61,-4558.38,440.678,0.461986,3,100000),
(28952,0,1,28988,6796.73,-4602.54,441.014,1.16764,3,100000),
(28952,0,1,28988,6832.64,-4607.75,440.678,1.60796,3,100000),
(28952,0,1,28988,6810.65,-4609.51,440.698,1.34902,3,100000),
(28952,0,1,28988,6821.64,-4610.6,440.678,1.47767,3,100000),
(28952,0,1,28988,6759.29,-4545.87,440.828,0.281769,3,100000),
(28952,0,1,28988,6758.29,-4555.15,440.715,0.393915,3,100000),
(28952,0,1,28988,6758.89,-4536.41,441.803,0.152804,3,100000),
(28952,0,1,28988,6759.16,-4564.06,440.789,0.500673,3,100000),
(28952,0,1,28988,6800.31,-4611.48,442.084,1.24255,3,100000),
(28952,0,1,28988,6755.44,-4540.72,441.901,0.202217,3,100000),
(28952,0,1,28988,6756.49,-4531.06,443.526,0.0756623,3,100000),
(28952,0,1,28988,6754.28,-4551.22,440.866,0.328856,3,100000),
(28952,0,1,28988,6815.62,-4616.65,440.715,1.41868,3,100000),
(28952,0,1,28988,6753.75,-4559.58,441.229,0.422191,3,100000),
(28952,0,1,28988,6750.04,-4544.23,441.715,0.230931,3,100000),
(28952,0,1,28988,6748.17,-4550.87,441.95,0.301857,3,100000),
(28952,0,1,28988,6901.17,-4516.72,440.678,3.26399,3,100000),
(28952,0,1,28988,6904.16,-4525.25,440.678,3.1453,3,100000),
(28952,0,1,28988,6843.42,-4464.69,440.678,4.48874,3,100000),
(28952,0,1,28988,6894.44,-4500.12,440.678,3.51498,3,100000),
(28952,0,1,28988,6908.48,-4530.96,440.678,3.0727,3,100000),
(28952,0,1,28988,6851.52,-4464.19,440.678,4.36897,3,100000),
(28952,0,1,28988,6903.38,-4508.44,440.678,3.36902,3,100000),
(28952,0,1,28988,6862.6,-4466.07,440.678,4.20554,3,100000),
(28952,0,1,28988,6907.35,-4513.6,440.678,3.29367,3,100000),
(28952,0,1,28988,6847.21,-4459.86,440.68,4.4502,3,100000),
(28952,0,1,28988,6901.39,-4500.22,440.678,3.48038,3,100000),
(28952,0,1,28988,6910.76,-4518.52,440.678,3.22766,3,100000),
(28952,0,1,28988,6877.53,-4472.05,440.678,3.98147,3,100000),
(28952,0,1,28988,6906.05,-4501.92,440.678,3.44103,3,100000),
(28952,0,1,28988,6855.15,-4457.84,440.204,4.35123,3,100000),
(28952,0,1,28988,6903.09,-4495.18,440.678,3.53309,3,100000),
(28952,0,1,28988,6871.4,-4463.92,440.678,4.11605,3,100000),
(28952,0,1,28988,6911.42,-4507.55,440.678,3.35772,3,100000),
(28952,0,1,28988,6916.01,-4518.93,440.681,3.21775,3,100000),
(28952,0,1,28988,6864.76,-4459.2,440.678,4.2248,3,100000),
(33280,0,0,33292,1993.54,-17.934,324.973,0,6,0),
(33280,0,0,33292,1968.16,-42.6564,324.968,0,6,0),
(33280,0,0,33292,1952.9,-27.3639,325.693,0,6,0),
(33280,0,0,33292,1991.67,-65.3991,328.343,0,6,0),
(33280,0,0,33292,2018.57,4.08873,328.874,0,6,0),
(33280,0,0,33292,2034.44,-25.2996,329.055,0,6,0),
(33280,0,1,34072,1964.6,-42.7056,325.085,0,3,60000),
(33280,0,1,34072,1986.94,-46.2108,324.98,0,3,60000),
(33280,0,1,34072,1989.49,-6.69694,325.079,0,3,60000),
(33280,0,1,34072,1965.52,-8.0893,324.948,0,3,60000),
(33280,0,2,34072,2000.84,-25.4001,325.192,0,3,60000),
(33280,0,2,34072,1960.22,-26.1414,325.01,0,3,60000),
(33280,0,2,34072,1976.3,-47.8254,325.112,0,3,60000),
(33280,0,2,34072,1997.69,-37.4608,325.039,0,3,60000),
(33280,0,2,34072,1998.07,-13.3567,325.167,0,3,60000),
(33280,0,2,34072,1976.99,-3.95909,325.169,0,3,60000),
(33890,0,0,33523,2117.71,-25.2707,242.73,3.14159,3,60000),
(33890,0,0,33535,2107.96,-37.2935,242.73,2.02458,3,60000),
(33890,0,0,33536,2092.35,-25.2604,242.73,6.26573,3,60000),
(33890,0,0,33495,2109.76,-14.3797,242.73,4.20624,3,60000),
(33890,0,0,33720,2146.88,-17.0312,239.806,3.35103,3,60000),
(33890,0,0,33720,2146.24,-34.4045,239.806,3.01942,3,60000),
(33890,0,0,33717,2113.33,-65.7101,239.806,1.78024,3,60000),
(33890,0,0,33717,2139.83,-50.2865,239.806,2.46091,3,60000),
(33890,0,0,33719,2116.93,11.375,239.806,4.41568,3,60000),
(33890,0,0,33719,2136.64,-1.99653,239.806,3.83972,3,60000),
(33890,0,0,33716,2069.48,-5.69965,239.806,5.42797,3,60000),
(33890,0,0,33716,2069.3,-43.5317,239.801,0.471239,3,60000),
(33890,0,0,33552,2109.7,-25.0955,222.325,0,3,60000),
(33890,0,0,33990,2134.53,18.8688,239.804,1.85005,3,60000),
(33890,0,0,33990,2063.16,27.9584,244.271,5.28835,3,60000),
(33890,0,0,33990,2070.13,-73.0108,242.524,1.309,3,60000),
(33890,0,0,33990,2135.22,-41.4427,239.803,5.84685,3,60000),
(33890,0,0,33990,2088.25,5.05366,239.867,0.994838,3,60000),
(33890,0,0,33990,2119.23,1.42144,239.804,0,3,60000),
(33890,0,0,33990,2102.44,-75.0454,239.863,1.65806,3,60000),
(33890,0,1,33441,1908.56,-152.443,240.072,4.32842,3,60000),
(33890,0,1,33442,1903.6,-160.358,240.106,1.0821,3,60000),
(33890,0,1,33962,1919.11,-160.966,240.066,2.70078,3,60000),
(33890,0,1,33567,1917.56,-135.745,240.073,4.18879,3,60000),
(33890,0,1,33567,1919.12,-140.957,240.073,3.97935,3,60000),
(33890,0,1,33567,1948.47,-136.295,240.071,3.4383,3,60000),
(33890,0,1,33567,1956.44,-138.403,240.108,3.36848,3,60000),
(33890,0,1,33567,1952.96,-130.529,240.135,3.80482,3,60000),
(33890,0,1,33567,1902.13,-111.359,240.07,4.85202,3,60000),
(33890,0,1,33567,1905.33,-104.786,240.052,4.76475,3,60000),
(33890,0,1,33567,1897.34,-106.608,240.144,4.93928,3,60000),
(33890,0,1,33567,1912.13,-136.934,240.073,4.18879,3,60000),
(33890,0,1,33552,1906.23,-155.894,223.473,0,3,60000),
(33890,0,1,33990,1863.9,-100.936,240.073,5.23599,3,60000),
(33890,0,1,33990,1948.67,-152.448,240.073,1.91986,3,60000),
(33890,0,1,33990,1932.21,-93.628,240.073,4.85202,3,60000),
(33890,0,1,33990,1964.46,-149.594,240.073,3.38594,3,60000),
(33890,0,1,33990,1992.46,-131.212,240.073,3.45575,3,60000),
(33890,0,1,33990,1901.19,-90.4624,240.073,0.139626,3,60000),
(33890,0,1,33990,1923.75,-164.534,240.073,3.45575,3,60000),
(33890,0,1,33990,1905.94,-133.165,240.073,5.77704,3,60000),
(33890,0,2,33436,1931.06,60.5659,241.501,2.08425,3,60000),
(33890,0,2,33437,1928.35,66.0519,242.46,5.11381,3,60000),
(33890,0,2,33433,1956.5,72.1946,239.749,3.28122,3,60000),
(33890,0,2,33433,1951.04,49.8887,239.749,2.49582,3,60000),
(33890,0,2,33433,1931.14,38.4695,239.749,1.71042,3,60000),
(33890,0,2,33433,1908.99,44.2666,239.749,0.925025,3,60000),
(33890,0,2,33433,1897.34,64.3142,239.749,0.139626,3,60000),
(33890,0,2,33433,1903.39,86.6029,239.749,5.61996,3,60000),
(33890,0,2,33433,1923.34,98.0123,239.749,4.83456,3,60000),
(33890,0,2,33433,1945.44,92.1795,239.749,4.04916,3,60000),
(33890,0,2,33552,1929.16,67.7569,221.732,0,3,60000),
(33890,0,2,33990,1941.56,109.481,239.75,3.31613,3,60000),
(33890,0,2,33990,1922.55,54.68,241.126,0.191986,3,60000),
(33890,0,2,33990,1893.15,44.2434,239.75,0,3,60000),
(33890,0,2,33990,1926.53,43.2621,239.75,0.994838,3,60000),
(33890,0,2,33990,1904.3,73.7044,239.75,4.27606,3,60000),
(33890,0,2,33990,1955.17,85.2615,239.75,4.04916,3,60000),
(29173,0,5,29182,2262.11,-5306.27,82.0455,1.20998,6,3000),
(29173,0,5,29181,2303.44,-5304.62,81.9966,1.42203,6,3000),
(29173,0,5,29180,2257.25,-5293.32,82.0388,0.766227,6,3000),
(29173,0,5,29179,2273.53,-5305.79,85.4119,1.19427,6,3000),
(29173,0,5,29178,2270.34,-5304.53,84.2972,1.10002,6,3000),
(29173,0,5,29177,2313.33,-5301.5,81.9964,1.2139,6,3000),
(29173,0,5,29176,2295.58,-5298.61,81.9964,1.24925,6,3000),
(29173,0,5,29174,2310.75,-5297.58,81.9962,1.42204,6,3000),
(29173,0,5,29174,2307.29,-5297.06,81.9962,1.42204,6,3000),
(29173,0,5,29174,2303.9,-5296.55,81.9962,1.42204,6,3000),
(29173,0,5,29174,2300.51,-5296.04,81.9962,1.42204,6,3000),
(29173,0,5,29174,2297.05,-5295.53,81.9962,1.42204,6,3000),
(29173,0,5,29174,2261.48,-5303.23,82.1675,1.13536,6,3000),
(29173,0,5,29174,2264.53,-5304.65,82.1662,1.13536,6,3000),
(29173,0,5,29174,2267.68,-5306.12,82.8637,1.13536,6,3000),
(29173,0,5,29174,2267.79,-5302.76,82.6248,1.04111,6,3000),
(29173,0,5,29174,2314.22,-5298.1,81.9962,1.42204,6,3000),
(29173,0,5,29174,2310.23,-5300.54,81.9966,1.42596,6,3000),
(29173,0,5,29174,2302.11,-5302.37,81.9971,1.43381,6,3000),
(29173,0,5,29174,2305.58,-5302.85,81.9971,1.43381,6,3000),
(29173,0,5,29174,2303.44,-5299.55,81.9966,1.42596,6,3000),
(29173,0,5,29174,2298.8,-5298.87,81.9966,1.45738,6,3000),
(29173,0,5,29174,2264.69,-5301.14,82.1679,1.09217,6,3000),
(29173,0,5,29174,2261.64,-5299.56,82.1679,1.09217,6,3000),
(29173,0,5,29174,2258.53,-5297.95,82.1679,1.09217,6,3000),
(29173,0,5,29174,2306.83,-5300.05,81.9966,1.42596,6,3000),
(29173,0,5,29174,2295.31,-5301.44,81.9971,1.43381,6,3000),
(29173,0,5,29174,2308.98,-5303.32,81.9971,1.43381,6,3000),
(29173,0,5,29174,2312.5,-5303.8,81.9964,1.43381,6,3000),
(29173,0,5,29174,2255.37,-5296.31,82.1673,1.09217,6,3000),
(29173,0,5,29174,2258.88,-5294.71,82.1674,1.09217,6,3000),
(29173,0,5,29174,2261.92,-5296.29,82.1674,1.09217,6,3000),
(29173,0,5,29174,2265.03,-5297.9,82.1674,1.09217,6,3000),
(29173,0,5,29174,2268.2,-5299.54,82.6949,1.09217,6,3000),
(29173,0,5,29174,2271.18,-5301.09,83.9718,1.09217,6,3000),
(29173,0,5,29174,2258.18,-5301.7,82.1675,1.13536,6,3000),
(29173,0,5,29174,2254.95,-5300.19,82.1675,1.10787,6,3000),
(29173,0,5,29174,2298.85,-5301.92,81.9971,1.43381,6,3000),
(29173,0,3,29206,2451.21,-5139.14,79.4415,4.01864,6,3000),
(29173,0,3,29206,2444.23,-5127.52,79.7291,4.11681,6,3000),
(29173,0,3,29206,2407.3,-5137.28,83.5367,4.10503,6,3000),
(29173,0,3,29206,2432.03,-5178.66,78.1408,3.57096,6,3000),
(29173,0,1,29206,2430.18,-5120.74,80.6734,4.34065,6,3000),
(29173,0,1,29206,2439.44,-5147.43,81.6538,3.6927,6,3000),
(29173,0,1,29206,2420.04,-5150.5,84.7892,3.97151,6,3000),
(29173,0,1,29206,2425.05,-5134.18,83.5648,3.90083,6,3000),
(29173,0,4,29219,2422.32,-5117.07,80.2242,3.96366,6,3000),
(29173,0,4,29219,2439.43,-5123.46,80.0141,4.28567,6,3000),
(29173,0,4,29219,2440.55,-5165.58,79.717,3.42174,6,3000),
(29173,0,4,29219,2431.03,-5161.67,82.4211,4.5959,6,3000),
(29173,0,4,29219,2425.89,-5143.18,84.2876,2.89552,6,3000),
(29173,0,2,29219,2433.79,-5127.07,82.0957,2.89552,6,3000),
(29173,0,2,29219,2442.79,-5133.61,81.1154,2.14939,6,3000),
(29173,0,2,29219,2433.87,-5116.75,79.4494,3.70055,6,3000),
(29173,0,2,29219,2445.39,-5141.42,80.5549,3.79873,6,3000),
(29173,0,2,29219,2414.89,-5151.82,84.3642,3.90475,6,3000),
(29173,0,0,29219,2405.41,-5147.17,83.8279,3.46101,6,3000),
(29173,0,0,29219,2413.18,-5144.6,84.5541,3.46101,6,3000),
(29173,0,0,29219,2413.82,-5167.85,81.1358,4.19535,6,3000),
(29173,0,0,29219,2434.9,-5152.75,82.7998,4.19535,6,3000),
(29173,0,0,29219,2421.51,-5125.91,82.0584,4.16001,6,3000),
(29173,0,30,29204,2436.04,-5132.31,82.8884,3.90954,6,3000),
(29173,0,30,29200,2431.82,-5130.47,83.3011,4.04916,6,3000),
(29173,0,30,29199,2438.45,-5137.02,82.6968,4.13643,6,3000),
(29173,0,30,29190,2435.99,-5097.61,82.9616,5.06145,6,3000),
(29173,0,30,29190,2453.18,-5183.31,76.1869,3.22886,6,3000),
(9520,0,4,9538,-7189.04,-1082.2,240.76,2.24,3,30000),
(9520,0,4,9539,-7184.77,-1078.76,240.76,2.87,3,30000),
(9520,0,3,7042,-7399.23,-1111.12,278.08,2.07,4,30000),
(9520,0,3,7042,-7394.24,-1106.84,278.08,3.04,4,30000),
(9520,0,3,7042,-7394.3,-1099.77,278.08,3.23,4,30000),
(9520,0,2,7043,-8017.37,-1244.61,134.45,3.05,4,30000),
(9520,0,2,7043,-8035.7,-1244.65,133.53,6.09,4,30000),
(9520,0,2,7027,-8028.86,-1234.06,134.5,4.8,4,30000),
(9520,0,2,7027,-8018.37,-1234.22,135.76,4.45,4,30000),
(9520,0,1,7027,-7731.36,-1516.09,133.15,1.85,4,30000),
(9520,0,1,7027,-7738.19,-1517.31,132.64,1.25,4,30000),
(9520,0,1,7027,-7745.39,-1511.42,131.82,0.43,4,30000),
(9520,0,1,7027,-7728.03,-1507.43,132.84,0.45,4,30000),
(32239,0,1,32312,6160.26,2702.05,573.92,2.04,3,200000),
(32239,0,1,32311,6163.98,2699.9,573.92,2.04,3,200000),
(32239,0,1,32310,6159.74,2697.9,573.92,2.04,3,200000),
(32239,0,1,32309,6161.26,2700.05,573.92,2.04,3,200000),
(32239,0,1,32309,6164.98,2697.9,573.92,2.04,3,200000),
(32239,0,1,32309,6160.74,2695.9,573.92,2.04,3,200000),
(18528,0,2,21701,-3552,657.34,0.31,4.69,3,300000),
(18528,0,2,21701,-3555.48,654.04,0.84,4.69,3,300000),
(18528,0,2,21701,-3559,650.45,1.5,4.69,3,300000),
(18528,0,2,21701,-3573,657.34,0.31,4.69,3,300000),
(18528,0,2,21701,-3569.48,654.04,0.84,4.69,3,300000),
(18528,0,2,21701,-3566,650.45,1.5,4.69,3,300000),
(18528,0,2,21701,-3562.56,647.24,2.16,4.69,3,300000),
(18528,0,2,22989,-3553.2,641.9,3.7,4.69,3,300000),
(18528,0,2,22990,-3569.58,642.18,3.37,4.73,3,300000),
(18528,0,1,23152,-3571.58,480.7,22.7,1.42,3,300000),
(18528,0,1,22988,-3568.08,505.66,20.46,1.24,3,300000),
(18528,0,1,22988,-3574.78,507.94,20.56,1.28,3,300000),
(18528,0,1,22988,-3581.3,510.47,20.8,1.31,3,300000),
(18528,0,1,22988,-3540.21,525.23,19.24,1.66,3,300000),
(18528,0,1,22988,-3545.93,524.68,18.38,1.66,3,300000),
(18528,0,1,22988,-3551.78,524.12,18.2,1.76,3,300000),
(18528,0,1,22857,-3566.11,563.07,13.65,1.54,3,300000),
(18528,0,1,22857,-3553.42,562.74,14.34,1.54,3,300000),
(20923,0,1,17462,480.69,311.13,1.94,3.14,4,30000),
(20923,0,1,17462,480.81,313.44,1.94,3.14,4,30000),
(20923,0,1,17462,480.93,315.74,1.94,3.14,4,30000),
(20923,0,1,17462,481.08,318.12,1.94,3.14,4,30000),
(20923,0,1,17462,481.27,320.42,1.95,3.14,4,30000),
(20923,0,1,17462,484.73,321.79,1.95,3.14,4,30000),
(17461,0,1,17462,480.69,311.13,1.94,3.14,4,30000),
(17461,0,1,17462,480.81,313.44,1.94,3.14,4,30000),
(17461,0,1,17462,480.93,315.74,1.94,3.14,4,30000),
(17461,0,1,17462,481.08,318.12,1.94,3.14,4,30000),
(17461,0,1,17462,481.27,320.42,1.95,3.14,4,30000),
(17461,0,1,17462,484.73,321.79,1.95,3.14,4,30000),
(23191,0,1,23319,494.203,343.868,112.784,2.04859,8,0),
(23191,0,1,23319,496.254,344.93,112.784,2.04859,8,0),
(23191,0,1,23319,498.368,346.025,112.784,2.00539,8,0),
(23191,0,1,23319,512.194,365.354,112.784,2.68476,8,0),
(23191,0,1,23319,514.263,369.563,112.784,2.68476,8,0),
(23191,0,1,23319,516.332,373.772,112.784,2.65335,8,0),
(23191,0,1,23319,502.57,454.24,112.784,4.16916,8,0),
(23191,0,1,23319,497.54,459.01,112.784,4.16916,8,0),
(23191,0,1,23319,500.08,456.6,112.784,4.16916,8,0),
(23191,0,1,23319,513.092,437.517,112.784,3.71757,8,0),
(23191,0,1,23319,515.036,434.523,112.784,3.71757,8,0),
(23191,0,1,23319,516.943,431.587,112.784,3.71757,8,0),
(23191,0,1,23319,526.781,409.258,112.784,3.16779,8,0),
(23191,0,1,23319,526.842,406.949,112.784,3.16779,8,0),
(23191,0,1,23319,527.15,395.193,112.784,3.16779,8,0),
(23191,0,1,23319,527.21,392.884,112.784,3.16779,8,0),
(23191,0,1,23319,527.058,398.692,112.784,3.16779,8,0),
(23191,0,1,23319,526.963,402.33,112.784,3.16779,8,0),
(5661,0,0,5680,1735.93,378.124,-62.2055,3.71755,1,60000),
(5661,0,0,5680,1734.36,379.952,-62.2058,3.92699,1,60000),
(5661,0,0,5681,1734.67,379.246,-62.2881,-2.78843,1,60000),
(5661,0,1,5686,1734.68,378.533,-62.1315,3.85718,1,60000),
(5661,0,1,5685,1735.24,380.689,-62.2077,3.85718,1,60000),
(5661,0,2,5687,1735.33,379.152,-62.206,3.82227,1,60000),
(15402,0,0,15958,8749.5,-7132.6,35.3198,3.8165,1,180000),
(15402,0,0,15656,8755.38,-7131.52,35.3096,3.8165,1,180000),
(15402,0,0,15656,8753.2,-7125.98,35.3199,3.8165,1,180000),
(4484,0,0,3879,3491.09,214.76,11.36,3.3,1,30000),
(4484,0,0,3879,3491.18,212.28,11.25,3.03,1,30000),
(4484,0,0,3879,3490.74,210.59,11.32,3.03,1,30000),
(4484,0,0,3879,3490.46,208.78,11.39,2.93,1,30000),
(4484,0,1,3893,3782.51,145.57,8.54,2.93,1,30000),
(4484,0,1,3893,3778.84,143.46,8.41,2.93,1,30000),
(4484,0,1,3893,3782.26,149.61,8.34,2.93,1,30000),
(4484,0,2,3900,4108.34,53.69,26.18,2.93,1,30000),
(4484,0,2,3898,4114.55,54.48,27.21,2.93,1,30000),
(4484,0,2,3899,4116.81,50.14,26.15,2.93,1,30000),
(35501,0,1,35372,8378.49,857.536,548.197,6.15827,1,900000),
(35501,0,1,35368,8378.62,857.509,548.19,0.103886,1,900000),
(35501,0,1,35460,8431.85,783.523,547.189,4.80006,1,900000),
(35501,0,1,35460,8431.82,786.166,547.023,4.75293,1,900000),
(35501,0,1,35460,8432.08,788.975,547.023,4.72544,1,900000),
(35501,0,1,35460,8431.93,792.52,547.023,4.73172,1,900000),
(35501,0,1,35361,8514.48,1002.04,547.543,1.54998,1,900000),
(35501,0,2,35321,8627.39,825.621,547.844,6.00138,1,900000),
(35501,0,2,35320,8627.42,825.719,547.844,6.09736,1,900000),
(35501,0,2,35322,8598.43,782.77,547.233,4.03508,1,900000),
(35501,0,2,35322,8599.85,786.899,547.106,0,1,900000),
(35501,0,2,35322,8599.95,789.887,547.102,0,1,900000),
(35501,0,2,35322,8600.09,792.962,547.092,0,1,900000),
(35501,0,2,35361,8514.87,999.861,547.536,1.56404,1,900000),
(35501,0,3,35361,8516.17,857.121,558.224,1.62047,1,900000),
(21024,0,0,21129,-3604.79,1913.46,47.8023,4.95674,1,110000),
(21024,0,0,21130,-3596.97,1913.55,47.7881,4.57276,1,110000),
(21024,0,0,21131,-3612.32,1910.8,47.6241,5.55015,1,110000),
(21024,0,0,21132,-3590.55,1911.16,47.3816,4.04916,1,110000),
(21024,0,0,21071,-3590.55,1911.16,47.3816,4.04916,1,110000),
(25602,0,0,26097,3483.05,4114.15,18.4848,3.19395,1,40000),
(25602,0,0,26097,3486.64,4116.4,18.4848,3.40339,1,40000),
(25602,0,0,26097,3483.65,4112.26,18.4848,2.9147,1,40000),
(25602,0,0,26097,3481.73,4118.21,18.4848,3.92699,1,40000),
(25602,0,0,26097,3485.34,4117.49,18.4848,3.54302,1,40000),
(25602,0,0,26097,3482.17,4116.4,18.4848,3.61283,1,40000),
(25602,0,0,26097,3485.66,4113.34,18.4848,3.12414,1,40000),
(25602,0,0,26097,3483.95,4118.28,18.4848,3.68265,1,40000),
(25602,0,0,26097,3484.03,4115.05,18.4848,3.31613,1,40000),
(25602,0,0,26097,3484.06,4116.23,18.4847,3.56047,1,40000),
(17843,0,1,17875,-1928.62,-11923,47.6502,1.88496,1,60000),
(17843,0,1,17875,-1910.81,-11892.8,43.875,0.541052,1,60000),
(17843,0,1,17875,-1921.78,-11862.5,51.3028,3.89208,1,60000),
(17843,0,1,17875,-1932.15,-11854.4,51.7948,2.9147,1,60000),
(17843,0,1,17875,-1909.91,-11867.8,44.2784,4.64258,1,60000),
(17843,0,1,17875,-1918.49,-11907.4,46.2081,0.541052,1,60000),
(23780,0,1,24041,1872.43,-6088.86,16.2164,4.48073,1,120000),
(23780,0,1,24044,1874.47,-6086.84,16.1889,4.50295,1,120000),
(23780,0,1,24044,1869.65,-6086.07,15.5403,4.57276,1,120000),
(23780,0,1,24044,1874.85,-6082.17,15.5215,4.50295,1,120000),
(23780,0,1,24044,1869.97,-6082.04,15.1316,4.57276,1,120000),
(23780,0,2,23883,1860.4,-6158.92,23.7032,1.48353,1,120000),
(23780,0,2,23883,1861.82,-6159.1,23.7135,1.51844,1,120000),
(23780,0,2,23883,1863.59,-6159.38,23.7355,1.5708,1,120000),
(23780,0,2,23883,1865.44,-6159.76,23.7657,1.58825,1,120000),
(23780,0,2,23883,1867.87,-6161.88,23.7801,1.64061,1,120000),
(23780,0,2,23883,1865.96,-6161.61,23.7731,1.6057,1,120000),
(23780,0,2,23883,1867.11,-6160.07,23.774,1.64061,1,120000),
(23780,0,2,23883,1860.73,-6160.7,23.7312,1.64061,1,120000),
(23780,0,2,23883,1862.24,-6161.04,23.7442,1.53589,1,120000),
(23780,0,2,23883,1864.23,-6161.25,23.7662,1.5708,1,120000),
(25335,0,1,25351,3981.68,5766.3,71.6903,1.50855,3,100000),
(25335,0,1,25351,3972.01,5783.71,74.185,5.85625,3,100000),
(25335,0,1,25351,3996.72,5773.32,70.84,2.77288,3,100000),
(25335,0,1,25350,3988.27,5792,74.1844,4.44349,3,100000),
(25335,0,1,25351,3969.23,5768.75,72.6969,0.549799,3,100000),
(1,2,1,14524,6204.05,-1172.58,370.079,0.86052,3,100000),
(1,2,1,14525,6246.95,-1155.99,366.183,2.90269,3,100000),
(1,2,1,14526,6193.45,-1137.83,366.261,5.77332,3,100000),
(21024,0,1,21738,-3587.23,1892.89,47.3237,2.19912,1,37000),
(21024,0,1,21739,-3598.68,1888.02,47.3237,1.69297,1,37000),
(21024,0,1,21740,-3605.31,1884.48,47.3237,1.309,1,37000),
(21024,0,1,21741,-3591.87,1886.82,47.3237,1.85005,1,37000),
(21310,0,0,21685,-3600.32,1898.6,47.3654,4.92183,1,600000),
(21310,0,0,21686,-3603.86,1900.85,47.3654,4.93109,1,600000),
(21310,0,0,21687,-3597.99,1902.12,47.3654,4.84868,1,600000),
(21700,0,0,21768,-3726.07,1040.51,56.0398,4.85202,1,60000),
(21700,0,0,21776,-3730.32,1041.37,56.04,4.72222,1,60000),
(21700,0,0,21776,-3722.4,1041.25,56.0398,4.72222,1,60000),
(12858,0,0,12860,1776.73,-2049.06,109.83,1.54,4,25000),
(12858,0,0,12896,1774.64,-2049.41,109.83,1.4,4,25000),
(12858,0,0,12897,1778.73,-2049.5,109.83,1.67,4,25000),
(3678,0,1,5755,-57.49,280.59,-92.84,5.22,4,60000),
(3678,0,1,5048,-61.81,271.145,-92.84,0.36,4,60000),
(3678,0,1,5048,-47.61,271.52,-92.84,2.54,4,60000),
(4275,0,1,4627,-140.794,2178.04,128.448,4.09,4,60000),
(4275,0,1,4627,-145.905,2180.52,128.448,4.183,4,60000),
(4275,0,1,4627,-153.11,2168.62,128.448,1.026,4,60000),
(4275,0,1,4627,-148.199,2165.65,128.448,1.026,4,60000),
(21121,1,1,4978,-862.43,-154.937,-25.871,0.06,4,60000),
(21121,1,1,4978,-775.404,-174.132,-25.871,3.185,4,60000),
(21120,1,1,4823,-862.193,-174.251,-25.871,6.182,4,60000),
(21120,1,1,4823,-862.43,-154.937,-25.871,0.06,4,60000),
(21120,1,1,4823,-775.404,-174.132,-25.871,3.185,4,60000),
(21120,1,1,4823,-775.431,-153.853,-25.871,3.207,4,60000),
(21119,1,1,4977,-862.193,-174.251,-25.871,6.182,4,60000),
(21119,1,1,4977,-862.43,-154.937,-25.871,0.06,4,60000),
(21119,1,1,4977,-775.404,-174.132,-25.871,3.185,4,60000),
(21119,1,1,4977,-775.431,-153.853,-25.871,3.207,4,60000),
(21118,1,1,4825,-862.193,-174.251,-25.871,6.182,4,60000),
(21118,1,1,4825,-862.43,-154.937,-25.871,0.06,4,60000),
(21118,1,1,4825,-775.404,-174.132,-25.871,3.185,4,60000),
(21118,1,1,4825,-775.431,-153.853,-25.871,3.207,4,60000),
(7998,0,4,6215,-494.195,-89.553,-149.131,3.254,4,60000),
(7998,0,4,7361,-495.24,-90.808,-149.493,3.238,4,60000),
(7998,0,3,6207,-490.554,-89.114,-148.055,3.23,4,60000),
(7998,0,3,6207,-490.732,-90.739,-148.091,3.23,4,60000),
(7998,0,3,6207,-491.995,-87.619,-148.197,3.23,4,60000),
(7998,0,3,6207,-493.349,-90.845,-148.882,3.717,4,60000),
(7998,0,3,6207,-494.595,-87.516,-149.116,3.344,4,60000),
(7998,0,2,6207,-548.692,-111.089,-154.09,0.621,4,60000),
(7998,0,2,6207,-552.154,-112.476,-153.349,0.621,4,60000),
(7998,0,2,6207,-555.263,-113.802,-152.737,0.311,4,60000),
(7998,0,2,6207,-557.63,-114.514,-152.209,0.641,4,60000),
(7998,0,1,6207,-554.03,-115.983,-152.635,0.695,4,60000),
(7998,0,1,6207,-550.708,-116.436,-153.103,0.679,4,60000),
(7998,0,1,6207,-552.534,-110.012,-153.577,0.747,4,60000),
(7998,0,1,6207,-547.274,-114.109,-153.952,0.735,4,60000),
(7998,0,1,6207,-547.736,-105.154,-155.176,0.372,4,60000),
(7998,0,1,6207,-546.905,-108.34,-154.877,0.729,4,60000),
(7998,0,1,6207,-548.692,-111.089,-154.09,0.621,4,60000),
(7998,0,1,6207,-552.154,-112.476,-153.349,0.621,4,60000),
(7998,0,1,6207,-555.263,-113.802,-152.737,0.311,4,60000),
(7998,0,1,6207,-557.63,-114.514,-152.209,0.641,4,60000),
(3975,0,1,6575,1926.62,-437.66,18.1,0,4,60000),
(3975,0,1,6575,1922.62,-435.66,18.1,0,4,60000),
(3975,0,1,6575,1923.62,-440.66,18.1,0,4,60000),
(3975,0,1,6575,1925.62,-437.66,18.1,0,4,60000),
(3975,0,1,6575,1922.62,-435.66,18.1,0,4,60000),
(3975,0,1,6575,1924.62,-433.66,18.1,0,4,60000),
(3975,0,1,6575,1925.62,-430.66,18.1,0,4,60000),
(3975,0,1,6575,1928.62,-427.66,18.1,0,4,60000),
(3975,0,1,6575,1920.62,-428.66,18.1,0,4,60000),
(3975,0,1,6575,1926.62,-433.66,18.1,0,4,60000),
(3975,0,1,6575,1923.62,-430.66,18.1,0,4,60000),
(3975,0,1,6575,1922.62,-431.66,18.1,0,4,60000),
(3975,0,1,6575,1926.62,-431.66,18.1,0,4,60000),
(3975,0,1,6575,1925.62,-418.66,18.1,0,4,60000),
(3975,0,1,6575,1926.62,-420.66,18.1,0,4,60000),
(3975,0,1,6575,1923.62,-422.66,18.1,0,4,60000),
(3975,0,1,6575,1925.62,-424.66,18.1,0,4,60000),
(3975,0,1,6575,1922.62,-426.66,18.1,0,4,60000),
(3975,0,1,6575,1924.62,-430.66,18.1,0,4,60000),
(3975,0,1,6575,1924.62,-431.66,18.1,0,4,60000),
(148917,1,3,7355,2487.94,804.222,43.1073,1.69297,8,0),
(148917,1,2,7351,2486.83,802.874,43.1988,2.9147,8,0),
(148917,1,2,7351,2489.08,806.591,43.211,3.68265,8,0),
(148917,1,2,7351,2543.29,911.245,46.3279,0.680678,8,0),
(148917,1,2,7351,2542.82,904.936,46.8091,4.64258,8,0),
(148917,1,1,7349,2527.02,829.979,48.065,0.698132,8,0),
(148917,1,1,7349,2524.04,834.485,48.3703,0.802851,8,0),
(148917,1,1,7349,2544.69,912.889,46.3991,2.1293,8,0),
(148917,1,1,7349,2541.49,911.176,46.2649,4.81711,8,0),
(148917,1,1,7349,2544.7,907.633,46.3801,1.6057,8,0),
(148917,1,1,7349,2541.25,907.094,46.642,2.02458,8,0),
(148917,1,1,7349,2489.91,804.795,43.2518,1.65806,8,0),
(148917,1,1,7349,2488.43,801.281,42.7037,4.29351,8,0),
(148917,1,1,7349,2485.41,804.115,43.6851,3.05433,8,0),
(148917,1,1,7349,2487.34,805.911,43.0836,2.84489,8,0),
(7604,0,4,7796,1883,1199.64,8.88,0,8,0),
(7604,0,4,7275,1885.4,1199.52,8.88,1.54,8,0),
(7604,0,3,7788,1878.03,1202.31,8.87,1,8,0),
(7604,0,3,8876,1907.39,1204.74,8.87,2.18,8,0),
(7604,0,3,7787,1870.57,1198,8.87,0.5,8,0),
(7604,0,3,7787,1898.18,1200,8.88,1.78,8,0),
(7604,0,3,7788,1872.82,1203.66,8.87,0.2,8,0),
(7604,0,2,8877,1899.63,1202.52,8.87,0,8,0),
(7604,0,2,7788,1889.94,1212.21,8.87,0,8,0),
(7604,0,2,8876,1883.76,1222.3,8.87,0,8,0),
(7604,0,2,7787,1886.93,1221.4,8.87,0,8,0),
(7604,0,2,7787,1894.72,1221.91,8.87,0,8,0),
(7604,0,2,7788,1878.57,1214.16,8.87,0,8,0),
(7604,0,2,7787,1886.97,1225.86,8.87,0,8,0),
(7604,0,2,8877,1873.63,1204.65,8.87,0,8,0),
(7604,0,2,7787,1882.07,1225.7,8.87,0,8,0),
(7604,0,2,8876,1898.23,1217.97,8.87,0,8,0),
(7604,0,2,7787,1879.02,1223.06,8.87,0,8,0),
(7604,0,2,7789,1874.18,1221.24,8.87,0,8,0),
(7604,0,2,7789,1874.45,1204.44,8.87,0,8,0),
(7604,0,2,8877,1896.46,1205.62,8.87,0,8,0),
(7604,0,2,7788,1893.07,1215.26,8.87,0,8,0),
(7604,0,2,7787,1892.28,1225.49,8.87,0,8,0),
(7604,0,2,8876,1877.4,1216.41,8.87,0,8,0),
(7604,0,2,7789,1894.64,1206.29,8.87,0,8,0),
(7604,0,2,7787,1890.08,1218.68,8.87,0,8,0),
(7604,0,2,8877,1877,1207.27,8.87,0,8,0),
(7604,0,2,7788,1883.74,1212.35,8.87,0,8,0),
(7604,0,2,7787,1883.5,1218.25,8.87,0,8,0),
(7604,0,2,8876,1889.82,1222.51,8.87,0,8,0),
(7604,0,2,7789,1902.83,1223.41,8.87,0,8,0),
(7604,0,1,8877,1899.63,1202.52,8.87,0,8,0),
(7604,0,1,8876,1877.4,1216.41,8.87,0,8,0),
(7604,0,1,8877,1873.63,1204.65,8.87,0,8,0),
(7604,0,1,8877,1877,1207.27,8.87,0,8,0),
(7604,0,1,7788,1883.74,1212.35,8.87,0,8,0),
(7604,0,1,7788,1878.57,1214.16,8.87,0,8,0),
(7604,0,1,7788,1893.07,1215.26,8.87,0,8,0),
(7604,0,1,8876,1889.82,1222.51,8.87,0,8,0),
(7604,0,1,7787,1886.93,1221.4,8.87,0,8,0),
(7604,0,1,7787,1883.5,1218.25,8.87,0,8,0),
(7604,0,1,7787,1894.72,1221.91,8.87,0,8,0),
(7604,0,1,7787,1886.97,1225.86,8.87,0,8,0),
(7604,0,1,8877,1896.46,1205.62,8.87,0,8,0),
(7604,0,1,7787,1882.07,1225.7,8.87,0,8,0),
(7604,0,1,8876,1898.23,1217.97,8.87,0,8,0),
(7604,0,1,7789,1874.45,1204.44,8.87,0,8,0),
(7604,0,1,7787,1879.02,1223.06,8.87,0,8,0),
(7604,0,1,7788,1889.94,1212.21,8.87,0,8,0),
(7604,0,1,7787,1892.28,1225.49,8.87,0,8,0),
(7604,0,1,7789,1874.18,1221.24,8.87,0,8,0),
(7604,0,1,8876,1883.76,1222.3,8.87,0,8,0),
(7604,0,1,7787,1890.08,1218.68,8.87,0,8,0),
(7604,0,1,7789,1894.64,1206.29,8.87,0,8,0),
(10813,0,1,10390,3658.92,-3093.21,134.116,0,8,0),
(10813,0,1,10391,3653.96,-3099.73,134.116,0,8,0),
(10813,0,1,10390,3651.39,-3106.24,134.116,0,8,0),
(10813,0,1,10391,3643.22,-3106.79,134.116,0,8,0),
(10813,0,1,10390,3648.91,-3102.72,134.116,0,8,0),
(10813,0,1,10391,3618.24,-3099.54,134.121,0,8,0),
(10813,0,1,10390,3607.83,-3100.25,134.121,0,8,0),
(10813,0,1,10391,3598.81,-3102.8,134.121,0,8,0),
(10813,0,1,10390,3602.96,-3109.86,134.123,0,8,0),
(10813,0,1,10391,3607.56,-3104.59,134.123,0,8,0),
(10813,0,1,10390,3562.87,-3062.38,134.997,0,8,0),
(10813,0,1,10391,3551.59,-3074.17,134.997,0,8,0),
(10813,0,1,10390,3557.01,-3071.87,134.997,0,8,0),
(10813,0,1,10391,3559.72,-3066.74,134.997,0,8,0),
(10813,0,1,10390,3551.78,-3068.75,134.997,0,8,0),
(10813,0,1,10391,3497.39,-3073.18,134.998,0,8,0),
(10813,0,1,10390,3502.07,-3076.63,134.998,0,8,0),
(10813,0,1,10391,3493.92,-3077.44,134.998,0,8,0),
(10813,0,1,10390,3486.02,-3084.36,134.998,0,8,0),
(10813,0,1,10391,3491.83,-3084.56,134.998,0,8,0),
(10813,0,1,10390,3467.8,-3070.84,135.003,0,8,0),
(10813,0,1,10391,3460.88,-3071.18,135.003,0,8,0),
(10813,0,1,10390,3461.92,-3078.1,135.003,0,8,0),
(10813,0,1,10391,3455.45,-3075.42,135.003,0,8,0),
(10813,0,1,10390,3452.98,-3081.97,135.003,0,8,0),
(23452,0,1,23453,-3042.54,832.879,-9.42804,2.54627,4,30000),
(23452,0,1,23453,-3048.65,830.045,-10.5551,2.54627,4,30000),
(23452,0,1,23453,-3049.29,824.519,-10.5041,2.54627,4,30000),
(23452,0,1,23453,-3052.54,823.895,-10.5332,2.54627,4,30000),
(23452,0,1,23453,-3052.79,819.289,-10.477,2.54627,4,30000),
(23452,0,1,23453,-3044.22,836.612,-9.52011,2.36563,4,30000),
(23452,0,1,23453,-3057.13,815.938,-10.112,2.54627,4,30000),
(23434,0,1,23435,-4083.84,1071.03,31.9116,5.25591,4,30000),
(23434,0,1,23435,-4083.11,1075.08,32.5654,5.25591,4,30000),
(23434,0,1,23435,-4079.09,1073.98,31.8,5.25591,4,30000),
(23434,0,1,23435,-4077.84,1078.41,32.7097,5.25591,4,30000),
(23434,0,1,23435,-4075.08,1078.48,32.4796,5.25591,4,30000),
(23434,0,1,23435,-4072.8,1082.43,33.3564,5.25591,4,30000),
(23434,0,1,23435,-4068.49,1082.18,33.0106,5.25591,4,30000),
(23434,0,1,23435,-4067.44,1085.14,33.8085,5.25591,4,30000),
(25804,0,0,25988,3286.08,5655.42,52.98,1.25,1,20000),
(25804,0,0,25988,3291.2,5650.54,53.09,1.35,1,20000),
(25804,0,0,25989,3285.02,5648.22,51.93,1.35,1,20000),
(25804,0,0,25989,3290.59,5643.01,51.6,1.35,1,20000),
(25804,0,0,25989,3296.2,5645.08,52.65,1.35,1,20000),
(25804,0,0,25990,3292.17,5639.34,51.06,1.35,1,20000),
(25804,0,0,25990,3286.03,5640.44,50.38,1.35,1,20000),
(25804,0,0,25990,3279.33,5644,50.23,1.35,1,20000);
/*!40000 ALTER TABLE `creature_summon_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

