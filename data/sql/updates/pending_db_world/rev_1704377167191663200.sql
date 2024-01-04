-- Update 'Commoner' spawns with sniffed values

SET @GEVENT1  := 1;  -- Midsummer
SET @GEVENT2  := 2;  -- Winter Veil
SET @GEVENT3  := 7;  -- Lunar Festival
SET @GEVENT4  := 9;  -- Noblegarden
SET @GEVENT5  := 10; -- Children's Week
SET @GEVENT6  := 12; -- Hallow's End
SET @GEVENT7  := 24; -- Brewfest
SET @GEVENT8  := 26; -- Pilgrim's Bounty
SET @GEVENT9  := 46; -- Spirit of Competition
SET @GEVENT10 := 50; -- Pirate's Day
SET @GEVENT11 := 51; -- Day of the Dead	

SET @CID1  := 18927; -- Human Commoner
SET @CID2  := 19148; -- Dwarf Commoner
SET @CID3  := 19169; -- Blood Elf Commoner
SET @CID4  := 19171; -- Draenei Commoner
SET @CID5  := 19172; -- Gnome Commoner
SET @CID6  := 19173; -- Night Elf Commoner
SET @CID7  := 19175; -- Orc Commoner
SET @CID8  := 19176; -- Tauren Commoner
SET @CID9  := 19177; -- Troll Commoner
SET @CID10 := 19178; -- Forsaken Commoner
SET @CID11 := 20102; -- Goblin Commoner

-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND (`guid` IN (10998, 10999, 11001, 11002, 11003, 11004, 121268, 121269, 129442, 129443, 129444, 129445, 240304, 240306, 240308, 240309, 240327, 240331, 240332, 240333, 240337, 240338, 62848, 62849, 724, 725, 726, 727, 84400, 84402, 84409, 84410, 84418, 84419, 84423, 84424, 84430, 84435, 84950, 84953, 85653, 85654, 86851, 86852, 86853, 86857, 86858, 87071, 91115, 91116, 91117, 91118, 91563, 91564, 91565, 91566, 91569, 91570, 91579, 91580, 91588, 91590, 91752, 91753, 91754, 91756, 91757, 91758, 91759, 91760, 91762, 91766, 91767, 91768, 91769, 91770, 91771, 91801));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(10998, @CID1, 0, 1, 1, 0, -8854.7783203125, 649.830322265625, 96.74169921875, 1.431169986724853515, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(10999, @CID1, 0, 1, 1, 0, -8855.7099609375, 651.84722900390625, 96.692138671875, 5.724679946899414062, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(11001, @CID10, 0, 1, 1, 0, 1573.044677734375, 265.955230712890625, -43.0193443298339843, 0.593411922454833984, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(11002, @CID10, 0, 1, 1, 0, 1574.55078125, 267.583160400390625, -43.0193443298339843, 3.769911050796508789, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(11003, @CID10, 0, 1, 1, 0, 1627.8011474609375, 224.5699920654296875, -43.01934814453125, 4.15388345718383789, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(11004, @CID10, 0, 1, 1, 0, 1626.697021484375, 222.6995391845703125, -43.0193443298339843, 1.01229095458984375, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(121268, @CID4, 530, 1, 1, 0, -4269.71337890625, -11336.509765625, 5.809307575225830078, 1.692969322204589843, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(121269, @CID4, 530, 1, 1, 0, -4270.05810546875, -11333.087890625, 5.5754547119140625, 4.677482128143310546, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(129442, @CID3, 530, 1, 1, 0, 9556.5556640625, -7157.376953125, 14.27987098693847656, 6.108652114868164062, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(129443, @CID3, 530, 1, 1, 0, 9558.3427734375, -7157.939453125, 14.31317806243896484, 2.635447263717651367, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(129444, @CID3, 530, 1, 1, 0, 9757.3935546875, -7485.69873046875, 13.61710166931152343, 4.764749050140380859, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(129445, @CID3, 530, 1, 1, 0, 9757.638671875, -7487.3740234375, 13.61667156219482421, 1.553343057632446289, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(240304, @CID1, 571, 1, 1, 0, 5664.31005859375, 666.2725830078125, 652.06396484375, 1.396263360977172851, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(240306, @CID1, 571, 1, 1, 0, 5664.3662109375, 668.046875, 652.05072021484375, 4.904375076293945312, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(240308, @CID3, 571, 1, 1, 0, 5899.0390625, 532.765625, 640.9793701171875, 4.904375076293945312, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(240309, @CID3, 571, 1, 1, 0, 5942.9462890625, 629.234375, 650.66796875, 1.570796370506286621, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(240327, @CID11, 1, 1, 1, 0, 6757.30322265625, -4667.43505859375, 724.2777099609375, 2.617993831634521484, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(240331, @CID11, 530, 1, 1, 0, -1875.9344482421875, 5376.2021484375, -12.3447761535644531, 0.820304751396179199, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(240332, @CID11, 530, 1, 1, 0, 3047.91015625, 3683.240478515625, 142.588531494140625, 5.183627605438232421, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(240333, @CID11, 1, 1, 1, 0, 6755.4677734375, -4666.119140625, 724.32305908203125, 5.585053443908691406, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(240337, @CID11, 530, 1, 1, 0, -1875.05517578125, 5378.03515625, -12.3447751998901367, 4.363323211669921875, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(240338, @CID11, 530, 1, 1, 0, 3049.17529296875, 3680.830322265625, 142.7080841064453125, 2.146754980087280273, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62848, @CID1, 0, 1, 1, 0, -8837.8984375, 553.15362548828125, 95.979736328125, 0.157079637050628662, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62849, @CID1, 0, 1, 1, 0, -8837.23828125, 554.91143798828125, 95.71685791015625, 5.044001579284667968, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(724, @CID11, 0, 1, 1, 0, -14440.1142578125, 509.033966064453125, 26.27169609069824218, 1.343903541564941406, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(725, @CID11, 0, 1, 1, 0, -14440.21484375, 510.300994873046875, 26.26188087463378906, 5.078907966613769531, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(726, @CID11, 0, 1, 1, 0, -14468.6923828125, 463.642486572265625, 36.9241485595703125, 4.136430263519287109, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(727, @CID11, 0, 1, 1, 0, -14469.5927734375, 462.22265625, 36.92478179931640625, 0.279252678155899047, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(84400, @CID4, 530, 1, 1, 0, -4044.452392578125, -11785.9892578125, 9.115586280822753906, 2.530727386474609375, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84402, @CID4, 530, 1, 1, 0, -3909.21826171875, -11614.7919921875, -138.1005859375, 3.176499128341674804, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84409, @CID4, 530, 1, 1, 0, -3811.420166015625, -11709.197265625, -106.409294128417968, 4.642575740814208984, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84410, @CID4, 530, 1, 1, 0, -4045.575927734375, -11784.9736328125, 9.106161117553710937, 5.602506637573242187, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84418, @CID3, 530, 1, 1, 0, 9663.5087890625, -7117.0068359375, 14.40693092346191406, 2.530727386474609375, 120, 0, 0, 0, 0, 0, "", 50664, 1, NULL),
(84419, @CID3, 530, 1, 1, 0, 9690.42578125, -7493.95166015625, 15.85786247253417968, 2.338741064071655273, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(84423, @CID3, 530, 1, 1, 0, 9662.27734375, -7116.19140625, 14.40640068054199218, 5.445427417755126953, 120, 0, 0, 0, 0, 0, "", 50664, 1, NULL),
(84424, @CID3, 530, 1, 1, 0, 9689.0654296875, -7493.0947265625, 15.86103248596191406, 6.195918560028076171, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(84430, @CID4, 530, 1, 1, 0, -3954.309814453125, -11702.189453125, -138.798614501953125, 2.652900457382202148, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84435, @CID4, 530, 1, 1, 0, -3955.854736328125, -11701.490234375, -138.819503784179687, 5.724679946899414062, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84950, @CID5, 0, 1, 1, 0, -4829.8798828125, -1173.2542724609375, 502.27734375, 2.49582076072692871, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(84953, @CID5, 0, 1, 1, 0, -4831.73681640625, -1172.5758056640625, 502.27752685546875, 6.195918560028076171, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(85653, @CID2, 0, 1, 1, 0, -4900.87353515625, -957.3143310546875, 501.541351318359375, 4.171336650848388671, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(85654, @CID2, 0, 1, 1, 0, -4901.8017578125, -958.95538330078125, 501.542877197265625, 1.01229095458984375, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(86851, @CID3, 530, 1, 1, 0, 9374.6689453125, -7155.087890625, 9.336748123168945312, 4.956735134124755859, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(86852, @CID3, 530, 1, 1, 0, 9375.072265625, -7157.06103515625, 9.255876541137695312, 1.605702877044677734, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(86853, @CID9, 1, 1, 1, 0, 1689.763916015625, -4334.845703125, 61.97504425048828125, 0.157079637050628662, 120, 0, 0, 0, 0, 0, "", 47720, 1, NULL),
(86857, @CID9, 1, 1, 1, 0, 1693.4039306640625, -4334.82763671875, 61.92371368408203125, 3.03687286376953125, 120, 0, 0, 0, 0, 0, "", 47720, 1, NULL),
(86858, @CID7, 1, 1, 1, 0, 1623.4410400390625, -4402.04541015625, 12.91891860961914062, 5.689773082733154296, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(87071, @CID7, 1, 1, 1, 0, 1625.002197265625, -4402.8759765625, 13.19661712646484375, 2.600540637969970703, 120, 0, 0, 0, 0, 0, "", 47720, 1, NULL),
(91115, @CID11, 1, 1, 1, 0, -924.65625, -3715.908935546875, 9.131733894348144531, 5.06145477294921875, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91116, @CID11, 1, 1, 1, 0, -924.09893798828125, -3718.003173828125, 9.185143470764160156, 1.692969322204589843, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91117, @CID11, 1, 1, 1, 0, -898.02410888671875, -3765.58935546875, 11.86798286437988281, 1.256637096405029296, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91118, @CID11, 1, 1, 1, 0, -897.12384033203125, -3763.225830078125, 11.98815059661865234, 4.328416347503662109, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91563, @CID8, 1, 1, 1, 0, -1240.5191650390625, 90.63541412353515625, 129.010406494140625, 4.834561824798583984, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91564, @CID8, 1, 1, 1, 0, -1240.88720703125, 87.83853912353515625, 129.19622802734375, 1.48352980613708496, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91565, @CID6, 1, 1, 1, 0, 9921.564453125, 2499.584716796875, 1317.771484375, 5.619960308074951171, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91566, @CID6, 1, 1, 1, 0, 9922.9716796875, 2498.760009765625, 1317.861083984375, 2.443460941314697265, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91569, @CID3, 530, 1, 1, 0, 9689.3330078125, -7345.38623046875, 11.91436386108398437, 4.206243515014648437, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91570, @CID3, 530, 1, 1, 0, 9687.9599609375, -7346.09228515625, 11.95601940155029296, 1.500983119010925292, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91579, @CID11, 0, 1, 1, 0, -14313.5224609375, 508.85296630859375, 8.691210746765136718, 4.276056766510009765, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(91580, @CID11, 0, 1, 1, 0, -14313.9521484375, 507.109161376953125, 8.688287734985351562, 1.221730470657348632, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(91588, @CID4, 530, 1, 1, 0, -3810.521728515625, -11710.6494140625, -106.411102294921875, 2.286381244659423828, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91590, @CID4, 530, 1, 1, 0, -3910.779541015625, -11615.693359375, -138.114547729492187, 0.820304751396179199, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(91752, @CID11, 1, 1, 1, 0, 6791.34375, -4747.0087890625, 701.61676025390625, 2.216568231582641601, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(91753, @CID11, 1, 1, 1, 0, -7144.11572265625, -3830.954345703125, 8.505434989929199218, 3.263765573501586914, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91754, @CID11, 1, 1, 1, 0, -7147.06396484375, -3830.216064453125, 8.5139617919921875, 6.056292533874511718, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91756, @CID11, 1, 1, 1, 0, -7219.65966796875, -3731.911376953125, 8.463495254516601562, 5.131268024444580078, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91757, @CID11, 1, 1, 1, 0, -7182.970703125, -3811.806884765625, 8.803952217102050781, 2.39110112190246582, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91758, @CID11, 1, 1, 1, 0, -7185.20068359375, -3809.253173828125, 9.013463020324707031, 5.515240192413330078, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91759, @CID11, 1, 1, 1, 0, -7053.61865234375, -3777.210205078125, 10.20470237731933593, 5.25344085693359375, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91760, @CID11, 1, 1, 1, 0, -7053.0048828125, -3779.90283203125, 10.14777183532714843, 1.535889744758605957, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91762, @CID11, 1, 1, 1, 0, -7217.572265625, -3735.163330078125, 8.453137397766113281, 2.286381244659423828, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91766, @CID11, 530, 1, 1, 0, -1818.9884033203125, 5305.673828125, -12.3448057174682617, 4.031710624694824218, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91767, @CID11, 530, 1, 1, 0, -1821.1177978515625, 5303.34521484375, -12.3448057174682617, 0.767944872379302978, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91768, @CID11, 530, 1, 1, 0, -1748.0755615234375, 5493.85791015625, -12.3448047637939453, 4.258603572845458984, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91769, @CID11, 530, 1, 1, 0, -1747.9027099609375, 5492.11279296875, -12.3448047637939453, 1.343903541564941406, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91770, @CID11, 530, 1, 1, 0, -1978.8189697265625, 5365.20654296875, -12.3448047637939453, 3.630284786224365234, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91771, @CID11, 530, 1, 1, 0, -1980.7156982421875, 5364.884765625, -12.322549819946289, 0.226892799139022827, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(91801, @CID11, 530, 1, 1, 0, -1884.1431884765625, 5766.55029296875, 129.641204833984375, 1.308996915817260742, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (@CID1, @CID3, @CID11)) AND (`guid` IN (62921, 62922, 62923, 62924, 62925, 62926, 62927, 62928, 62929, 62930, 62931, 62932, 62933, 62934, 62935, 62936, 62937, 62938, 62939, 62940, 62941, 62942, 62943, 62944, 62945, 62946));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(62921, @CID1, 571, 1, 1, 0, 5739.3583984375, 684.62152099609375, 644.19134521484375, 0.872664630413055419, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62922, @CID1, 571, 1, 1, 0, 5740.70947265625, 686.12152099609375, 643.89654541015625, 3.822271108627319335, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62923, @CID3, 571, 1, 1, 0, 5899.09619140625, 530.8975830078125, 641.05621337890625, 1.675516128540039062, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62924, @CID3, 571, 1, 1, 0, 5943.16845703125, 630.89410400390625, 650.6661376953125, 4.904375076293945312, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62925, @CID11, 1, 1, 1, 0, -1030.970703125, -3678.40576171875, 23.24793434143066406, 1.623156189918518066, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62926, @CID11, 1, 1, 1, 0, -1031.02783203125, -3676.19873046875, 23.18507194519042968, 4.694935798645019531, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62927, @CID11, 1, 1, 1, 0, 6706.6865234375, -4673.666015625, 721.51214599609375, 5.183627605438232421, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62928, @CID11, 1, 1, 1, 0, 6707.43115234375, -4675.7412109375, 721.14764404296875, 1.797689080238342285, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62929, @CID11, 1, 1, 1, 0, 6789.40380859375, -4744.7900390625, 701.61572265625, 5.497786998748779296, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62930, @CID11, 1, 1, 1, 0, 6808.54541015625, -4604.900390625, 710.5283203125, 0.314159274101257324, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62931, @CID11, 1, 1, 1, 0, 6812.02490234375, -4603.5087890625, 710.75250244140625, 3.630284786224365234, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62932, @CID11, 530, 1, 1, 0, -1808.356201171875, 5417.01025390625, -12.3448410034179687, 2.321287870407104492, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62933, @CID11, 530, 1, 1, 0, -1809.9249267578125, 5418.63720703125, -12.3448457717895507, 5.550147056579589843, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62934, @CID11, 530, 1, 1, 0, -1883.611572265625, 5769.2822265625, 129.641204833984375, 4.15388345718383789, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62935, @CID11, 530, 1, 1, 0, -1917.8135986328125, 5441.85009765625, -12.3448438644409179, 2.356194496154785156, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62936, @CID11, 530, 1, 1, 0, -1920.16845703125, 5443.51806640625, -12.3448352813720703, 5.864306449890136718, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62937, @CID11, 530, 1, 1, 0, -2174.136962890625, 5413.0625, 50.31124496459960937, 2.565634012222290039, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62938, @CID11, 530, 1, 1, 0, -2175.761962890625, 5414.6220703125, 50.31124114990234375, 5.602506637573242187, 120, 0, 0, 0, 0, 0, "", 49345, 1, NULL),
(62939, @CID11, 530, 1, 1, 0, 2975.743896484375, 3650.292236328125, 143.17138671875, 5.235987663269042968, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62940, @CID11, 530, 1, 1, 0, 2977.159912109375, 3648.09033203125, 143.5688934326171875, 1.93731546401977539, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62941, @CID11, 530, 1, 1, 0, 3073.345947265625, 3595.1220703125, 144.14971923828125, 1.274090290069580078, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62942, @CID11, 530, 1, 1, 0, 3073.896484375, 3597.2158203125, 144.14971923828125, 4.537856101989746093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(62943, @CID11, 571, 1, 1, 0, 5777.6494140625, 728.8992919921875, 618.63555908203125, 0.139626339077949523, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62944, @CID11, 571, 1, 1, 0, 5779.501953125, 729.07293701171875, 618.6434326171875, 3.228859186172485351, 120, 0, 0, 0, 0, 0, "", 48632, 1, NULL),
(62945, @CID11, 571, 1, 1, 0, 6191.5458984375, -1058.80908203125, 409.8868408203125, 0.383972436189651489, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(62946, @CID11, 571, 1, 1, 0, 6193.6259765625, -1057.967041015625, 409.848846435546875, 3.700098037719726562, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- remove duplicate spawns
DELETE FROM `creature` WHERE (`id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND (`guid` IN (240311, 240312, 240307, 240310, 91587, 84440, 240313, 84441, 240315, 240316, 240317, 240326, 134674, 240325, 134673, 240323, 240324, 86732, 86733, 240322, 240321, 134671, 134672, 240320, 240336, 240330, 240335, 240329, 240334, 240328));
DELETE FROM `creature_addon` WHERE (`guid` IN (240311, 240312, 240307, 240310, 91587, 84440, 240313, 84441, 240315, 240316, 240317, 240326, 134674, 240325, 134673, 240323, 240324, 86732, 86733, 240322, 240321, 134671, 134672, 240320, 240336, 240330, 240335, 240329, 240334, 240328));
DELETE FROM `game_event_creature` WHERE (`guid` IN (240311, 240312, 240307, 240310, 91587, 84440, 240313, 84441, 240315, 240316, 240317, 240326, 134674, 240325, 134673, 240323, 240324, 86732, 86733, 240322, 240321, 134671, 134672, 240320, 240336, 240330, 240335, 240329, 240334, 240328));

-- spawn commoners for all relevant events
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND `eventEntry` in (@GEVENT1, @GEVENT2, @GEVENT3, @GEVENT4, @GEVENT5, @GEVENT6, @GEVENT7, @GEVENT8, @GEVENT9, @GEVENT10, @GEVENT11);
INSERT INTO `game_event_creature` (SELECT @GEVENT1 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT2 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT3 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT4 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT5 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT6 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT7 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT8 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT9 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT10, `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT11, `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
