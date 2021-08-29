-- DB update 2021_01_20_01 -> 2021_01_20_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_20_01 2021_01_20_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1610238998819516081'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610238998819516081');

UPDATE `creature` SET `MovementType`=2, `currentwaypoint`=1 WHERE `guid` IN (13990, 13991, 13992);

DELETE FROM `creature_addon` WHERE (`guid` IN (13990, 13991, 13992));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(13991, 139910, 0, 0, 4097, 0, 0, NULL),
(13992, 139920, 0, 0, 4097, 0, 0, NULL),
(13990, 139900, 0, 0, 4097, 0, 0, NULL);

SET @diff_x1 = 1;
SET @diff_x2 = 1.85;
SET @diff_y1 = 1.73; -- -1.73
SET @diff_y2 = 0.97;

DELETE FROM `waypoint_data` WHERE `id` IN (139900, 139910, 139920);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(139900,1,-1163.84,-2039.64,92.329,0.778403),
(139900,2,-1155.26,-2030.92,92.3441,0.794111),
(139900,3,-1146.76,-2025.56,91.9018,0.562419),
(139900,4,-1138.97,-2020.69,91.7124,0.640959),
(139900,5,-1127.73,-2012.34,90.3264,0.625251),
(139900,6,-1116.3,-2004.25,87.966,0.597762),
(139900,7,-1104.73,-1996.37,86.8092,0.601689),
(139900,8,-1095.69,-1989.63,87.3704,0.707718),
(139900,9,-1085.47,-1980.06,88.4313,0.766622),
(139900,10,-1075.47,-1970.27,89.2527,0.790184),
(139900,11,-1065.57,-1960.37,89.5806,0.739133),
(139900,12,-1054.95,-1951.25,91.6132,0.754841),
(139900,13,-1037.63,-1936.87,91.303,0.315018),
(139900,14,-1031.23,-1935.6,91.0524,6.24477),
(139900,15,-1018.69,-1937.2,91.2356,6.00916),
(139900,16,-1009.08,-1941.33,91.6321,5.68322),
(139900,17,-1000.52,-1948.73,91.6426,5.45938),
(139900,18,-990.914,-1958.9,91.8159,5.53792),
(139900,19,-983.567,-1964.32,92.0828,5.74998),
(139900,20,-971.49,-1971.4,91.9302,5.74212),
(139900,21,-963.513,-1976.74,92.2916,5.64002),
(139900,22,-949.908,-1985.93,91.5116,6.10734),
(139900,23,-942.074,-1986.29,91.684,0.126528),
(139900,24,-934.487,-1983.16,91.8781,0.617402),
(139900,25,-927.677,-1976.49,91.8453,1.00225),
(139900,26,-917.012,-1962.43,92.4899,0.503519),
(139900,27,-912.48,-1961.02,92.6773,6.24871),
(139900,28,-912.48,-1961.02,92.6773,6.24871),
(139900,29,-901.182,-1962.18,93.0181,5.98167),
(139900,30,-884.309,-1971.16,93.3765,5.6361),
(139900,31,-873.323,-1981.73,92.9514,5.23555),
(139900,32,-870.22,-1988.95,92.2641,5.01171),
(139900,33,-868.573,-2000.59,90.4552,4.76038),
(139900,34,-869.798,-2009.64,88.3658,4.43052),
(139900,35,-869.798,-2009.64,88.3658,4.43052),
(139900,36,-874.149,-2022.94,84.0626,4.46194),
(139900,37,-875.511,-2029.78,82.3593,4.56796),
(139900,38,-875.861,-2035.86,81.6462,4.78002),
(139900,39,-875.861,-2035.86,81.6462,4.78002),
(139900,40,-874.428,-2054.12,81.1732,4.59545),
(139900,41,-875.172,-2058.42,81.7428,4.48942),
(139900,42,-875.172,-2058.42,81.7428,4.48942),
(139900,43,-878.827,-2074.61,84.8399,4.63472),
(139900,44,-878.94,-2078.52,85.8663,4.73682),
(139900,45,-879.085,-2094.22,89.8159,4.51299),
(139900,46,-879.085,-2094.22,89.8159,4.51299),
(139900,47,-882.508,-2107.79,91.7992,4.44623),
(139900,48,-885.841,-2121.38,93.3342,4.43052),
(139900,49,-890.019,-2134.72,95.0228,4.52084),
(139900,50,-891.734,-2148.61,93.0664,4.61902),
(139900,51,-892.999,-2158.92,93.0222,4.51299),
(139900,52,-896.872,-2184.37,93.1021,4.47764),
(139900,53,-898.9,-2190.57,93.5871,4.19883),
(139900,54,-908.599,-2206.56,92.8768,3.96321),
(139900,55,-919.849,-2216.23,92.9446,3.75508),
(139900,56,-926.924,-2220.54,91.9927,3.65298),
(139900,57,-939.19,-2227.29,93.8277,3.64512),
(139900,58,-951.475,-2234.01,93.4212,3.59407),
(139900,59,-964.327,-2239.55,94.0063,3.50768),
(139900,60,-970.104,-2241.32,93.6923,3.40165),
(139900,61,-983.625,-2244.93,92.8864,3.49983),
(139900,62,-1003.08,-2254.73,92.8758,3.71188),
(139900,63,-1014.4,-2262.96,93.8607,3.79828),
(139900,64,-1021.98,-2268.85,93.6578,3.67261),
(139900,65,-1027.46,-2271.52,93.5807,3.44877),
(139900,66,-1035.48,-2273.72,92.8945,3.34275),
(139900,67,-1041.95,-2274.72,92.3594,3.23672),
(139900,68,-1054.43,-2276.54,91.0989,3.49983),
(139900,69,-1059.01,-2279.04,90.5081,3.75508),
(139900,70,-1065.69,-2283.98,90.095,3.86896),
(139900,71,-1078.1,-2294.25,91.1205,3.6412),
(139900,72,-1090.36,-2301.01,91.7954,3.68832),
(139900,73,-1103.82,-2306.93,91.869,3.22101),
(139900,74,-1110.65,-2306,91.6284,2.71835),
(139900,75,-1120.22,-2300.76,90.5557,2.49059),
(139900,76,-1127.45,-2293.8,89.3242,2.2746),
(139900,77,-1133.71,-2283.89,87.7026,1.9251),
(139900,78,-1133.71,-2283.89,87.7026,1.9251),
(139900,79,-1138.44,-2270.71,84.846,1.90939),
(139900,80,-1143.59,-2257.7,83.7522,1.98008),
(139900,81,-1147.41,-2249.41,84.4206,2.10182),
(139900,82,-1154.96,-2237.62,85.5433,2.18036),
(139900,83,-1163.01,-2226.26,85.3018,2.07825),
(139900,84,-1168.67,-2215.42,85.647,1.97222),
(139900,85,-1175.52,-2196.08,87.4019,1.98793),
(139900,86,-1177.88,-2191.38,88.0981,2.10182),
(139900,87,-1184.32,-2181.51,89.6795,2.21177),
(139900,88,-1190.2,-2174.5,90.7129,2.32173),
(139900,89,-1199.41,-2165.2,92.1156,2.21962),
(139900,90,-1207.39,-2153.7,92.9348,2.1725),
(139900,91,-1212.19,-2147.5,92.9004,2.27853),
(139900,92,-1219.43,-2138.75,92.6938,2.15679),
(139900,93,-1228.51,-2119.14,92.8527,1.65807),
(139900,94,-1227.87,-2112.21,92.012,1.28893),
(139900,95,-1227.87,-2112.21,92.012,1.28893),
(139900,96,-1223.25,-2099,92.2144,1.20646),
(139900,97,-1213.01,-2075.87,91.8991,0.966915),
(139900,98,-1208.34,-2070.73,92.348,0.711661),
(139900,99,-1197.42,-2061.97,93.0869,0.66061),
(139900,100,-1191.3,-2057.78,93.244,0.558508),
(139900,101,-1179.36,-2050.48,93.4187,0.566362),
(139910,1,-1163.84-(@diff_x1),-2039.64+(@diff_y1),92.329,0.778403),
(139910,2,-1155.26-(@diff_x1),-2030.92+(@diff_y1),92.3441,0.794111),
(139910,3,-1146.76-(@diff_x1),-2025.56+(@diff_y1),91.9018,0.562419),
(139910,4,-1138.97-(@diff_x1),-2020.69+(@diff_y1),91.7124,0.640959),
(139910,5,-1127.73-(@diff_x1),-2012.34+(@diff_y1),90.3264,0.625251),
(139910,6,-1116.3-(@diff_x1),-2004.25+(@diff_y1),87.966,0.597762),
(139910,7,-1104.73-(@diff_x1),-1996.37+(@diff_y1),86.8092,0.601689),
(139910,8,-1095.69-(@diff_x1),-1989.63+(@diff_y1),87.3704,0.707718),
(139910,9,-1085.47-(@diff_x1),-1980.06+(@diff_y1),88.4313,0.766622),
(139910,10,-1075.47-(@diff_x1),-1970.27+(@diff_y1),89.2527,0.790184),
(139910,11,-1065.57-(@diff_x1),-1960.37+(@diff_y1),89.5806,0.739133),
(139910,12,-1054.95-(@diff_x1),-1951.25+(@diff_y1),91.6132,0.754841),
(139910,13,-1037.63-(@diff_x1),-1936.87+(@diff_y1),91.303,0.315018),
(139910,14,-1031.23-(@diff_x1),-1935.6+(@diff_y1),91.0524,6.24477),
(139910,15,-1018.69-(@diff_x1),-1937.2+(@diff_y1),91.2356,6.00916),
(139910,16,-1009.08-(@diff_x1),-1941.33+(@diff_y1),91.6321,5.68322),
(139910,17,-1000.52-(@diff_x1),-1948.73+(@diff_y1),91.6426,5.45938),
(139910,18,-990.914-(@diff_x1),-1958.9+(@diff_y1),91.8159,5.53792),
(139910,19,-983.567-(@diff_x1),-1964.32+(@diff_y1),92.0828,5.74998),
(139910,20,-971.49-(@diff_x1),-1971.4+(@diff_y1),91.9302,5.74212),
(139910,21,-963.513-(@diff_x1),-1976.74+(@diff_y1),92.2916,5.64002),
(139910,22,-949.908-(@diff_x1),-1985.93+(@diff_y1),91.5116,6.10734),
(139910,23,-942.074-(@diff_x1),-1986.29+(@diff_y1),91.684,0.126528),
(139910,24,-934.487-(@diff_x1),-1983.16+(@diff_y1),91.8781,0.617402),
(139910,25,-927.677-(@diff_x1),-1976.49+(@diff_y1),91.8453,1.00225),
(139910,26,-917.012-(@diff_x1),-1962.43+(@diff_y1),92.4899,0.503519),
(139910,27,-912.48-(@diff_x1),-1961.02+(@diff_y1),92.6773,6.24871),
(139910,28,-912.48-(@diff_x1),-1961.02+(@diff_y1),92.6773,6.24871),
(139910,29,-901.182-(@diff_x1),-1962.18+(@diff_y1),93.0181,5.98167),
(139910,30,-884.309-(@diff_x1),-1971.16+(@diff_y1),93.3765,5.6361),
(139910,31,-873.323-(@diff_x1),-1981.73+(@diff_y1),92.9514,5.23555),
(139910,32,-870.22-(@diff_x1),-1988.95+(@diff_y1),92.2641,5.01171),
(139910,33,-868.573-(@diff_x1),-2000.59+(@diff_y1),90.4552,4.76038),
(139910,34,-869.798-(@diff_x1),-2009.64+(@diff_y1),88.3658,4.43052),
(139910,35,-869.798-(@diff_x1),-2009.64+(@diff_y1),88.3658,4.43052),
(139910,36,-874.149-(@diff_x1),-2022.94+(@diff_y1),84.0626,4.46194),
(139910,37,-875.511-(@diff_x1),-2029.78+(@diff_y1),82.3593,4.56796),
(139910,38,-875.861-(@diff_x1),-2035.86+(@diff_y1),81.6462,4.78002),
(139910,39,-875.861-(@diff_x1),-2035.86+(@diff_y1),81.6462,4.78002),
(139910,40,-874.428-(@diff_x1),-2054.12+(@diff_y1),81.1732,4.59545),
(139910,41,-875.172-(@diff_x1),-2058.42+(@diff_y1),81.7428,4.48942),
(139910,42,-875.172-(@diff_x1),-2058.42+(@diff_y1),81.7428,4.48942),
(139910,43,-878.827-(@diff_x1),-2074.61+(@diff_y1),84.8399,4.63472),
(139910,44,-878.94-(@diff_x1),-2078.52+(@diff_y1),85.8663,4.73682),
(139910,45,-879.085-(@diff_x1),-2094.22+(@diff_y1),89.8159,4.51299),
(139910,46,-879.085-(@diff_x1),-2094.22+(@diff_y1),89.8159,4.51299),
(139910,47,-882.508-(@diff_x1),-2107.79+(@diff_y1),91.7992,4.44623),
(139910,48,-885.841-(@diff_x1),-2121.38+(@diff_y1),93.3342,4.43052),
(139910,49,-890.019-(@diff_x1),-2134.72+(@diff_y1),95.0228,4.52084),
(139910,50,-891.734-(@diff_x1),-2148.61+(@diff_y1),93.0664,4.61902),
(139910,51,-892.999-(@diff_x1),-2158.92+(@diff_y1),93.0222,4.51299),
(139910,52,-896.872-(@diff_x1),-2184.37+(@diff_y1),93.1021,4.47764),
(139910,53,-898.9-(@diff_x1),-2190.57+(@diff_y1),93.5871,4.19883),
(139910,54,-908.599-(@diff_x1),-2206.56+(@diff_y1),92.8768,3.96321),
(139910,55,-919.849-(@diff_x1),-2216.23+(@diff_y1),92.9446,3.75508),
(139910,56,-926.924-(@diff_x1),-2220.54+(@diff_y1),91.9927,3.65298),
(139910,57,-939.19-(@diff_x1),-2227.29+(@diff_y1),93.8277,3.64512),
(139910,58,-951.475-(@diff_x1),-2234.01+(@diff_y1),93.4212,3.59407),
(139910,59,-964.327-(@diff_x1),-2239.55+(@diff_y1),94.0063,3.50768),
(139910,60,-970.104-(@diff_x1),-2241.32+(@diff_y1),93.6923,3.40165),
(139910,61,-983.625-(@diff_x1),-2244.93+(@diff_y1),92.8864,3.49983),
(139910,62,-1003.08-(@diff_x1),-2254.73+(@diff_y1),92.8758,3.71188),
(139910,63,-1014.4-(@diff_x1),-2262.96+(@diff_y1),93.8607,3.79828),
(139910,64,-1021.98-(@diff_x1),-2268.85+(@diff_y1),93.6578,3.67261),
(139910,65,-1027.46-(@diff_x1),-2271.52+(@diff_y1),93.5807,3.44877),
(139910,66,-1035.48-(@diff_x1),-2273.72+(@diff_y1),92.8945,3.34275),
(139910,67,-1041.95-(@diff_x1),-2274.72+(@diff_y1),92.3594,3.23672),
(139910,68,-1054.43-(@diff_x1),-2276.54+(@diff_y1),91.0989,3.49983),
(139910,69,-1059.01-(@diff_x1),-2279.04+(@diff_y1),90.5081,3.75508),
(139910,70,-1065.69-(@diff_x1),-2283.98+(@diff_y1),90.095,3.86896),
(139910,71,-1078.1-(@diff_x1),-2294.25+(@diff_y1),91.1205,3.6412),
(139910,72,-1090.36-(@diff_x1),-2301.01+(@diff_y1),91.7954,3.68832),
(139910,73,-1103.82-(@diff_x1),-2306.93+(@diff_y1),91.869,3.22101),
(139910,74,-1110.65-(@diff_x1),-2306,91.6284+(@diff_y1),2.71835),
(139910,75,-1120.22-(@diff_x1),-2300.76+(@diff_y1),90.5557,2.49059),
(139910,76,-1127.45-(@diff_x1),-2293.8+(@diff_y1),89.3242,2.2746),
(139910,77,-1133.71-(@diff_x1),-2283.89+(@diff_y1),87.7026,1.9251),
(139910,78,-1133.71-(@diff_x1),-2283.89+(@diff_y1),87.7026,1.9251),
(139910,79,-1138.44-(@diff_x1),-2270.71+(@diff_y1),84.846,1.90939),
(139910,80,-1143.59-(@diff_x1),-2257.7+(@diff_y1),83.7522,1.98008),
(139910,81,-1147.41-(@diff_x1),-2249.41+(@diff_y1),84.4206,2.10182),
(139910,82,-1154.96-(@diff_x1),-2237.62+(@diff_y1),85.5433,2.18036),
(139910,83,-1163.01-(@diff_x1),-2226.26+(@diff_y1),85.3018,2.07825),
(139910,84,-1168.67-(@diff_x1),-2215.42+(@diff_y1),85.647,1.97222),
(139910,85,-1175.52-(@diff_x1),-2196.08+(@diff_y1),87.4019,1.98793),
(139910,86,-1177.88-(@diff_x1),-2191.38+(@diff_y1),88.0981,2.10182),
(139910,87,-1184.32-(@diff_x1),-2181.51+(@diff_y1),89.6795,2.21177),
(139910,88,-1190.2-(@diff_x1),-2174.5+(@diff_y1),90.7129,2.32173),
(139910,89,-1199.41-(@diff_x1),-2165.2+(@diff_y1),92.1156,2.21962),
(139910,90,-1207.39-(@diff_x1),-2153.7+(@diff_y1),92.9348,2.1725),
(139910,91,-1212.19-(@diff_x1),-2147.5+(@diff_y1),92.9004,2.27853),
(139910,92,-1219.43-(@diff_x1),-2138.75+(@diff_y1),92.6938,2.15679),
(139910,93,-1228.51-(@diff_x1),-2119.14+(@diff_y1),92.8527,1.65807),
(139910,94,-1227.87-(@diff_x1),-2112.21+(@diff_y1),92.012,1.28893),
(139910,95,-1227.87-(@diff_x1),-2112.21+(@diff_y1),92.012,1.28893),
(139910,96,-1223.25-(@diff_x1),-2099,92.2144+(@diff_y1),1.20646),
(139910,97,-1213.01-(@diff_x1),-2075.87+(@diff_y1),91.8991,0.966915),
(139910,98,-1208.34-(@diff_x1),-2070.73+(@diff_y1),92.348,0.711661),
(139910,99,-1197.42-(@diff_x1),-2061.97+(@diff_y1),93.0869,0.66061),
(139910,100,-1191.3-(@diff_x1),-2057.78+(@diff_y1),93.244,0.558508),
(139910,101,-1179.36-(@diff_x1),-2050.48+(@diff_y1),93.4187,0.566362),
(139920,1,-1163.84-(@diff_x2),-2039.64-(@diff_y2),92.329,0.778403),
(139920,2,-1155.26-(@diff_x2),-2030.92-(@diff_y2),92.3441,0.794111),
(139920,3,-1146.76-(@diff_x2),-2025.56-(@diff_y2),91.9018,0.562419),
(139920,4,-1138.97-(@diff_x2),-2020.69-(@diff_y2),91.7124,0.640959),
(139920,5,-1127.73-(@diff_x2),-2012.34-(@diff_y2),90.3264,0.625251),
(139920,6,-1116.3-(@diff_x2),-2004.25-(@diff_y2),87.966,0.597762),
(139920,7,-1104.73-(@diff_x2),-1996.37-(@diff_y2),86.8092,0.601689),
(139920,8,-1095.69-(@diff_x2),-1989.63-(@diff_y2),87.3704,0.707718),
(139920,9,-1085.47-(@diff_x2),-1980.06-(@diff_y2),88.4313,0.766622),
(139920,10,-1075.47-(@diff_x2),-1970.27-(@diff_y2),89.2527,0.790184),
(139920,11,-1065.57-(@diff_x2),-1960.37-(@diff_y2),89.5806,0.739133),
(139920,12,-1054.95-(@diff_x2),-1951.25-(@diff_y2),91.6132,0.754841),
(139920,13,-1037.63-(@diff_x2),-1936.87-(@diff_y2),91.303,0.315018),
(139920,14,-1031.23-(@diff_x2),-1935.6-(@diff_y2),91.0524,6.24477),
(139920,15,-1018.69-(@diff_x2),-1937.2-(@diff_y2),91.2356,6.00916),
(139920,16,-1009.08-(@diff_x2),-1941.33-(@diff_y2),91.6321,5.68322),
(139920,17,-1000.52-(@diff_x2),-1948.73-(@diff_y2),91.6426,5.45938),
(139920,18,-990.914-(@diff_x2),-1958.9-(@diff_y2),91.8159,5.53792),
(139920,19,-983.567-(@diff_x2),-1964.32-(@diff_y2),92.0828,5.74998),
(139920,20,-971.49-(@diff_x2),-1971.4-(@diff_y2),91.9302,5.74212),
(139920,21,-963.513-(@diff_x2),-1976.74-(@diff_y2),92.2916,5.64002),
(139920,22,-949.908-(@diff_x2),-1985.93-(@diff_y2),91.5116,6.10734),
(139920,23,-942.074-(@diff_x2),-1986.29-(@diff_y2),91.684,0.126528),
(139920,24,-934.487-(@diff_x2),-1983.16-(@diff_y2),91.8781,0.617402),
(139920,25,-927.677-(@diff_x2),-1976.49-(@diff_y2),91.8453,1.00225),
(139920,26,-917.012-(@diff_x2),-1962.43-(@diff_y2),92.4899,0.503519),
(139920,27,-912.48-(@diff_x2),-1961.02-(@diff_y2),92.6773,6.24871),
(139920,28,-912.48-(@diff_x2),-1961.02-(@diff_y2),92.6773,6.24871),
(139920,29,-901.182-(@diff_x2),-1962.18-(@diff_y2),93.0181,5.98167),
(139920,30,-884.309-(@diff_x2),-1971.16-(@diff_y2),93.3765,5.6361),
(139920,31,-873.323-(@diff_x2),-1981.73-(@diff_y2),92.9514,5.23555),
(139920,32,-870.22-(@diff_x2),-1988.95-(@diff_y2),92.2641,5.01171),
(139920,33,-868.573-(@diff_x2),-2000.59-(@diff_y2),90.4552,4.76038),
(139920,34,-869.798-(@diff_x2),-2009.64-(@diff_y2),88.3658,4.43052),
(139920,35,-869.798-(@diff_x2),-2009.64-(@diff_y2),88.3658,4.43052),
(139920,36,-874.149-(@diff_x2),-2022.94-(@diff_y2),84.0626,4.46194),
(139920,37,-875.511-(@diff_x2),-2029.78-(@diff_y2),82.3593,4.56796),
(139920,38,-875.861-(@diff_x2),-2035.86-(@diff_y2),81.6462,4.78002),
(139920,39,-875.861-(@diff_x2),-2035.86-(@diff_y2),81.6462,4.78002),
(139920,40,-874.428-(@diff_x2),-2054.12-(@diff_y2),81.1732,4.59545),
(139920,41,-875.172-(@diff_x2),-2058.42-(@diff_y2),81.7428,4.48942),
(139920,42,-875.172-(@diff_x2),-2058.42-(@diff_y2),81.7428,4.48942),
(139920,43,-878.827-(@diff_x2),-2074.61-(@diff_y2),84.8399,4.63472),
(139920,44,-878.94-(@diff_x2),-2078.52-(@diff_y2),85.8663,4.73682),
(139920,45,-879.085-(@diff_x2),-2094.22-(@diff_y2),89.8159,4.51299),
(139920,46,-879.085-(@diff_x2),-2094.22-(@diff_y2),89.8159,4.51299),
(139920,47,-882.508-(@diff_x2),-2107.79-(@diff_y2),91.7992,4.44623),
(139920,48,-885.841-(@diff_x2),-2121.38-(@diff_y2),93.3342,4.43052),
(139920,49,-890.019-(@diff_x2),-2134.72-(@diff_y2),95.0228,4.52084),
(139920,50,-891.734-(@diff_x2),-2148.61-(@diff_y2),93.0664,4.61902),
(139920,51,-892.999-(@diff_x2),-2158.92-(@diff_y2),93.0222,4.51299),
(139920,52,-896.872-(@diff_x2),-2184.37-(@diff_y2),93.1021,4.47764),
(139920,53,-898.9-(@diff_x2),-2190.57-(@diff_y2),93.5871,4.19883),
(139920,54,-908.599-(@diff_x2),-2206.56-(@diff_y2),92.8768,3.96321),
(139920,55,-919.849-(@diff_x2),-2216.23-(@diff_y2),92.9446,3.75508),
(139920,56,-926.924-(@diff_x2),-2220.54-(@diff_y2),91.9927,3.65298),
(139920,57,-939.19-(@diff_x2),-2227.29-(@diff_y2),93.8277,3.64512),
(139920,58,-951.475-(@diff_x2),-2234.01-(@diff_y2),93.4212,3.59407),
(139920,59,-964.327-(@diff_x2),-2239.55-(@diff_y2),94.0063,3.50768),
(139920,60,-970.104-(@diff_x2),-2241.32-(@diff_y2),93.6923,3.40165),
(139920,61,-983.625-(@diff_x2),-2244.93-(@diff_y2),92.8864,3.49983),
(139920,62,-1003.08-(@diff_x2),-2254.73-(@diff_y2),92.8758,3.71188),
(139920,63,-1014.4-(@diff_x2),-2262.96-(@diff_y2),93.8607,3.79828),
(139920,64,-1021.98-(@diff_x2),-2268.85-(@diff_y2),93.6578,3.67261),
(139920,65,-1027.46-(@diff_x2),-2271.52-(@diff_y2),93.5807,3.44877),
(139920,66,-1035.48-(@diff_x2),-2273.72-(@diff_y2),92.8945,3.34275),
(139920,67,-1041.95-(@diff_x2),-2274.72-(@diff_y2),92.3594,3.23672),
(139920,68,-1054.43-(@diff_x2),-2276.54-(@diff_y2),91.0989,3.49983),
(139920,69,-1059.01-(@diff_x2),-2279.04-(@diff_y2),90.5081,3.75508),
(139920,70,-1065.69-(@diff_x2),-2283.98-(@diff_y2),90.095,3.86896),
(139920,71,-1078.1-(@diff_x2),-2294.25-(@diff_y2),91.1205,3.6412),
(139920,72,-1090.36-(@diff_x2),-2301.01-(@diff_y2),91.7954,3.68832),
(139920,73,-1103.82-(@diff_x2),-2306.93-(@diff_y2),91.869,3.22101),
(139920,74,-1110.65-(@diff_x2),-2306,91.6284-(@diff_y2),2.71835),
(139920,75,-1120.22-(@diff_x2),-2300.76-(@diff_y2),90.5557,2.49059),
(139920,76,-1127.45-(@diff_x2),-2293.8-(@diff_y2),89.3242,2.2746),
(139920,77,-1133.71-(@diff_x2),-2283.89-(@diff_y2),87.7026,1.9251),
(139920,78,-1133.71-(@diff_x2),-2283.89-(@diff_y2),87.7026,1.9251),
(139920,79,-1138.44-(@diff_x2),-2270.71-(@diff_y2),84.846,1.90939),
(139920,80,-1143.59-(@diff_x2),-2257.7-(@diff_y2),83.7522,1.98008),
(139920,81,-1147.41-(@diff_x2),-2249.41-(@diff_y2),84.4206,2.10182),
(139920,82,-1154.96-(@diff_x2),-2237.62-(@diff_y2),85.5433,2.18036),
(139920,83,-1163.01-(@diff_x2),-2226.26-(@diff_y2),85.3018,2.07825),
(139920,84,-1168.67-(@diff_x2),-2215.42-(@diff_y2),85.647,1.97222),
(139920,85,-1175.52-(@diff_x2),-2196.08-(@diff_y2),87.4019,1.98793),
(139920,86,-1177.88-(@diff_x2),-2191.38-(@diff_y2),88.0981,2.10182),
(139920,87,-1184.32-(@diff_x2),-2181.51-(@diff_y2),89.6795,2.21177),
(139920,88,-1190.2-(@diff_x2),-2174.5-(@diff_y2),90.7129,2.32173),
(139920,89,-1199.41-(@diff_x2),-2165.2-(@diff_y2),92.1156,2.21962),
(139920,90,-1207.39-(@diff_x2),-2153.7-(@diff_y2),92.9348,2.1725),
(139920,91,-1212.19-(@diff_x2),-2147.5-(@diff_y2),92.9004,2.27853),
(139920,92,-1219.43-(@diff_x2),-2138.75-(@diff_y2),92.6938,2.15679),
(139920,93,-1228.51-(@diff_x2),-2119.14-(@diff_y2),92.8527,1.65807),
(139920,94,-1227.87-(@diff_x2),-2112.21-(@diff_y2),92.012,1.28893),
(139920,95,-1227.87-(@diff_x2),-2112.21-(@diff_y2),92.012,1.28893),
(139920,96,-1223.25-(@diff_x2),-2099,92.2144-(@diff_y2),1.20646),
(139920,97,-1213.01-(@diff_x2),-2075.87-(@diff_y2),91.8991,0.966915),
(139920,98,-1208.34-(@diff_x2),-2070.73-(@diff_y2),92.348,0.711661),
(139920,99,-1197.42-(@diff_x2),-2061.97-(@diff_y2),93.0869,0.66061),
(139920,100,-1191.3-(@diff_x2),-2057.78-(@diff_y2),93.244,0.558508),
(139920,101,-1179.36-(@diff_x2),-2050.48-(@diff_y2),93.4187,0.566362);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
