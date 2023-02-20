-- DB update 2023_02_19_02 -> 2023_02_19_03
--
DELETE FROM `waypoints` WHERE `entry`=17848;

DELETE FROM `waypoint_data` WHERE `id` IN (178480,178481);
INSERT INTO `waypoint_data` VALUES
(178480,1,2145.6123,124.77572,76.18501,NULL,0,1,0,100,0),
(178480,2,2146.5122,117.58604,76.04292,NULL,0,1,0,100,0),
(178480,3,2148.4314,101.62945,73.041336,NULL,0,1,0,100,0),
(178480,4,2151.864,88.83778,69.48506,NULL,0,1,0,100,0),
(178480,5,2149.0708,83.53852,69.1086,NULL,0,1,0,100,0),
(178480,6,2142.1206,79.21365,68.06233,NULL,0,1,0,100,0),
(178480,7,2132.0854,73.20009,64.77117,NULL,0,1,0,100,0),
(178480,8,2128.2366,71.17936,64.41205,NULL,1200,1,0,100,0),
(178480,9,2125.2478,89.376305,54.71777,NULL,0,1,0,100,0),
(178480,10,2119.832,93.372505,52.565914,NULL,0,1,0,100,0),
(178480,11,2113.8572,93.34234,52.590572,NULL,0,1,0,100,0),

(178481,1,2113.8572,93.34234,52.590572,NULL,0,0,0,100,0),
(178481,2,2111.2415,103.42893,52.565914,NULL,0,0,0,100,0),
(178481,3,2109.1719,113.15994,52.90283,NULL,0,0,0,100,0),
(178481,4,2107.6462,126.1786,52.565914,NULL,0,0,0,100,0),
(178481,5,2107.979,138.13727,52.546013,NULL,0,0,0,100,0),
(178481,6,2112.6594,153.49968,52.56591,NULL,0,0,0,100,0),
(178481,7,2120.5117,168.8968,52.81591,NULL,0,0,0,100,0),
(178481,8,2124.643,175.81912,52.92492,NULL,0,0,0,100,0),
(178481,9,2128.9448,182.75977,53.179924,NULL,0,0,0,100,0),
(178481,10,2138.4214,195.35818,52.565907,NULL,0,0,0,100,0),
(178481,11,2147.3398,204.56651,52.92638,NULL,0,0,0,100,0),
(178481,12,2160.0496,214.06728,52.56542,NULL,0,0,0,100,0),
(178481,13,2172.4766,224.48166,52.56554,NULL,0,0,0,100,0),
(178481,14,2179.8486,230.77225,52.565907,NULL,0,0,0,100,0),
(178481,15,2172.4766,224.48166,52.56554,NULL,0,0,0,100,0),
(178481,16,2160.0496,214.06728,52.56542,NULL,0,0,0,100,0),
(178481,17,2147.3398,204.56651,52.92638,NULL,0,0,0,100,0),
(178481,18,2138.4214,195.35818,52.565907,NULL,0,0,0,100,0),
(178481,19,2128.9448,182.75977,53.179924,NULL,0,0,0,100,0),
(178481,20,2124.643,175.81912,52.92492,NULL,0,0,0,100,0),
(178481,21,2120.5117,168.8968,52.81591,NULL,0,0,0,100,0),
(178481,22,2112.6594,153.49968,52.56591,NULL,0,0,0,100,0),
(178481,23,2107.979,138.13727,52.546013,NULL,0,0,0,100,0),
(178481,24,2107.6462,126.1786,52.565914,NULL,0,0,0,100,0),
(178481,25,2109.1719,113.15994,52.90283,NULL,0,0,0,100,0),
(178481,26,2111.2415,103.42893,52.565914,NULL,0,0,0,100,0);
