-- DB update 2023_09_15_02 -> 2023_09_17_00
-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/9912

UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` IN (46438, 46449, 46459, 46461, 46462, 46573, 46586, 46714, 46715, 46912, 46913, 46915, 46916, 46917, 46918, 46919, 46920, 46921, 46922, 46923, 46924, 46925, 46926, 46927, 46928, 46929, 46930, 46931, 46932, 46933, 46934, 46935, 46936, 46937, 46938, 46939, 46940, 46941, 46942, 46943, 46944, 46945, 46946, 46947, 46948, 46949, 46950, 46951, 46952, 46953, 46954, 46955, 46957, 46958, 46971, 46972, 46974, 46981, 46997, 46998, 46999, 47000, 47001, 47002, 47003, 47004, 47006, 47008, 47009, 47010, 47012, 47016, 47017, 47029, 47030, 47031, 47037, 47038, 47039, 47052, 47053, 47054, 47055, 47056, 47057, 47060, 47061, 47062, 47208, 47249, 47262, 47263, 47267, 47268, 47269, 47270, 47271, 47280, 47281, 47282, 47283, 47284, 47285, 47286, 47287, 47288, 47290, 47310, 47312, 47314, 47315, 47316, 47317, 47319, 47320, 47321, 47322, 47324, 47325, 47327, 47328, 47329, 47330, 47331, 47332, 47333, 47334, 47335, 47336, 47337, 47338, 47340, 47341, 47342, 47343, 47344, 47345, 47346, 47350, 47660, 47752, 47863, 47876, 47880, 47883, 47900, 47905, 47907, 47911, 47915, 47921, 47922, 47925, 47926, 47928, 49560, 49561, 49562, 49563, 49564, 49565, 49566, 49567, 49568, 49569, 49570, 49571, 49572, 49610, 49611, 49612, 49613, 49614, 49615, 49616, 49617, 49620, 49621, 49622, 49623, 49626, 49627, 49628, 49629, 49630, 49631, 49632, 49633, 49634, 49635, 49636, 49637, 49638, 49639, 49640, 49641, 49642, 49643, 49644, 49645, 49646, 49648);

UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` IN (47326, 47339, 47289);

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/9943

UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` IN (46439, 47917, 47916, 47931, 47913);
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` IN (46394, 49845, 49855);

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/10052
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` IN (49818, 49850, 49819);

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/10282
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` IN (46446, 46452, 46463, 47372, 47373, 47374, 47375, 47376, 47378, 47519, 47520, 47521, 47522, 47523, 47524, 47525, 47531, 47936, 49882, 49883, 49884, 49889, 49897, 49898, 49899);

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/10285
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` IN (47527, 46431, 46464, 47352, 47355, 47356, 47361, 47363, 47377, 47379, 47380, 47381, 47382, 47383, 47505, 47516, 47517, 47518, 47633, 47647, 47663, 47857, 47919, 47933, 47937, 49860, 49861, 49862, 49865, 49880, 49881, 49900);

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/12702
SET @GUID :=88354;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @GUID+0 AND @GUID+96;

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/12751
SET @GUID :=94862;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @GUID+0 AND @GUID+72;

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/12765 
SET @GUID :=72707;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @GUID+0 AND @GUID+45;

-- modernize https://github.com/azerothcore/azerothcore-wotlk/pull/12854
SET @GUID :=132314;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @GUID+0 AND @GUID+83;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` IN (@GUID+25, @GUID+38, @GUID+83);
