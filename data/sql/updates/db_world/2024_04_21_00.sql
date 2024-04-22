-- DB update 2024_04_20_01 -> 2024_04_21_00
-- Update gameobject '%Cauldron%' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (157969, 2719, 142690, 59850, 142693, 20877, 18342, 18345, 18341, 18340, 36396, 148511, 153220, 18084, 20878, 176574, 176559, 31580, 160421, 3266, 103772, 18083, 141845, 149029, 18079, 142118, 181445, 182575, 183827, 183895, 183922, 183923, 183924, 183925, 183926, 183927, 183930, 183931, 184003, 184355, 184370, 184373, 184472, 184475, 184715, 185180, 185283, 185289, 141851, 181322, 181315, 3315, 179704, 92099, 20870, 20871, 103663, 89931, 20872, 187879, 59530, 59529, 74078, 74075, 74076, 176899, 178524, 178572, 178573, 160470, 177284, 177285, 177286, 176393, 177289, 176392, 176361, 20970, 176273, 176275, 20869, 177244, 176091, 32879, 32880, 153124, 153125, 176278, 176284, 153576, 153577, 153579, 175984, 186656, 190021, 188495, 188246, 188248, 190618, 190619, 190620, 190630, 187690, 192916, 190936, 190937, 187714, 2076, 186451, 181327))
AND (`guid` IN (10195, 10215, 10652, 10787, 10831, 10833, 11637, 11771, 11772, 11832, 12349, 12450, 12452, 1358, 13768, 13981, 13987, 1425, 14678, 15118, 15482, 1632, 17263, 17273, 1733, 18130, 21761, 23180, 24692, 24746, 24773, 24774, 24775, 24776, 24777, 24778, 24779, 24780, 24865, 25154, 25171, 25174, 25336, 25338, 25527, 26040, 26161, 26167, 27124, 27291, 27366, 27887, 28656, 29558, 30087, 30091, 30095, 30099, 30118, 356, 35622, 35657, 35707, 35731, 35744, 391, 406, 42489, 42500, 42586, 44778, 44780, 45306, 45312, 45318, 45319, 45324, 45601, 45604, 45618, 46457, 47957, 48871, 49697, 49700, 49942, 49944, 50060, 50071, 50176, 50185, 50188, 50454, 56551, 57636, 57887, 58028, 58077, 59649, 59656, 59663, 59778, 60087, 60109, 60124, 61034, 62571, 66376, 66377, 67467, 6783, 7569, 9667));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(10195, 157969, 0, 0, 0, 1, 1, -11406.181640625, -796.03668212890625, 14.95203781127929687, 0.619591057300567626, 0, 0, 0.304863929748535156, 0.952395915985107421, 120, 255, 1, "", 46902, NULL),
(10215, 2719, 0, 0, 0, 1, 1, -7045.55908203125, -3637.40966796875, 241.6666717529296875, 3.394901275634765625, 0, 0, -0.9919900894165039, 0.126315817236900329, 120, 255, 1, "", 48120, NULL),
(10652, 142690, 0, 0, 0, 1, 1, -6272.8603515625, -3745.03955078125, 244.00347900390625, 3.14153456687927246, 0.026151657104492187, -0.04360389709472656, 0.998705863952636718, 0.001170857343822717, 120, 255, 1, "", 50664, NULL),
(10787, 59850, 0, 0, 0, 1, 1, -14478.34765625, 431.756195068359375, 36.19657135009765625, 0.837755441665649414, 0, 0, 0.406735420227050781, 0.91354602575302124, 120, 255, 1, "", 45572, NULL),
(10831, 142693, 0, 0, 0, 1, 1, -6767.74755859375, -3136.1806640625, 240.5193939208984375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45613, NULL),
(10833, 20877, 0, 0, 0, 1, 1, -5663.10888671875, -1566.8819580078125, 383.203582763671875, 4.967469215393066406, 0, 0, -0.61142349243164062, 0.791303575038909912, 120, 255, 1, "", 46368, NULL),
(11637, 18342, 0, 0, 0, 1, 1, -4840.22900390625, -4040.982666015625, 315.271240234375, 1.682155609130859375, 0.019510746002197265, -0.01745033264160156, 0.745106697082519531, 0.666431427001953125, 120, 255, 1, "", 48120, NULL),
(11771, 18345, 0, 0, 0, 1, 1, -6039.69775390625, -2985.59619140625, 401.95147705078125, 3.140588760375976562, 0.121858596801757812, -0.01299190521240234, 0.992460250854492187, 0.002085938351228833, 120, 255, 1, "", 50664, NULL),
(11772, 18341, 0, 0, 0, 1, 1, -5275.478515625, -2706.68798828125, 342.64849853515625, 3.140599012374877929, 0.013023853302001953, -0.10017871856689453, 0.994882583618164062, 0.001810595276765525, 120, 255, 1, "", 47720, NULL),
(11832, 18340, 0, 0, 0, 1, 1, -5049.2294921875, -2679.08251953125, 319.50946044921875, 0.825179338455200195, 0.039958953857421875, 0.017490386962890625, 0.400601387023925781, 0.915213584899902343, 120, 255, 1, "", 47720, NULL),
(12349, 36396, 0, 0, 0, 1, 1, -11306.451171875, -3404.673583984375, 7.467741966247558593, 3.586656570434570312, 0, 0, -0.975341796875, 0.220699742436408996, 120, 255, 1, "", 45772, NULL),
(12450, 148511, 0, 0, 0, 1, 1, -11044.8427734375, -3386.478759765625, 65.37012481689453125, 2.83248138427734375, 0, 0, 0.988080024719238281, 0.153941065073013305, 120, 255, 1, "", 46248, NULL),
(12452, 153220, 0, 0, 0, 1, 1, -11524.3017578125, -2852.418701171875, 7.3902130126953125, 3.142735719680786132, -0.01741981506347656, -0.06103897094726562, -0.99798202514648437, 0.001637745066545903, 120, 255, 1, "", 45772, NULL),
(1358, 18084, 1, 0, 0, 1, 1, -1265.079833984375, -5510.94970703125, 5.25556802749633789, 3.140863418579101562, -0.04796171188354492, 0.026146888732910156, 0.998505592346191406, 0.001619445742107927, 120, 255, 1, "", 45435, NULL),
(13768, 20878, 0, 0, 0, 1, 1, -3899.458251953125, -3033.807373046875, 11.03367328643798828, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 48632, NULL),
(13981, 176574, 0, 0, 0, 1, 1, -10802.025390625, -2192.3349609375, 117.13134765625, 6.237643718719482421, 0, 0, -0.02276897430419921, 0.99974071979522705, 120, 255, 1, "", 48632, NULL),
(13987, 176559, 0, 0, 0, 1, 1, -11003.669921875, -2307.094482421875, 117.1313934326171875, 2.460005044937133789, 0, 0, 0.9424896240234375, 0.334235370159149169, 120, 255, 1, "", 48632, NULL),
(1425, 31580, 1, 0, 0, 1, 1, 351.649322509765625, -4854.58349609375, 10.41963672637939453, 3.124123096466064453, 0, 0, 0.99996185302734375, 0.008734640665352344, 120, 255, 1, "", 45435, NULL),
(14678, 160421, 1, 0, 0, 1, 1, -1639.1549072265625, -4382.7197265625, 17.82378768920898437, 5.611233234405517578, 0, 0, -0.32969093322753906, 0.944088935852050781, 120, 255, 1, "", 50664, NULL),
(15118, 3266, 1, 0, 0, 1, 1, -4152.30712890625, -2193.78125, 50.18310546875, 3.176533222198486328, 0, 0, -0.999847412109375, 0.017469281330704689, 120, 255, 1, "", 45572, NULL),
(15482, 103772, 0, 0, 0, 1, 1, -2076.958251953125, -2135.189208984375, 21.12221717834472656, 3.080478668212890625, 0.022465705871582031, 0.021132469177246093, 0.999072074890136718, 0.030062029138207435, 120, 255, 1, "", 47168, NULL),
(1632, 18083, 1, 0, 0, 1, 1, -557.6788330078125, -4219.20849609375, 41.59037017822265625, 3.115344762802124023, 0.004419803619384765, 0.004305839538574218, 0.999895095825195312, 0.01310423482209444, 120, 255, 1, "", 45327, NULL),
(17263, 141845, 1, 0, 0, 1, 1, -7403.830078125, -4585.26904296875, 8.876789093017578125, 0.231924712657928466, 0, 0, 0.115702629089355468, 0.99328392744064331, 120, 255, 1, "", 45772, NULL),
(17273, 149029, 1, 0, 0, 1, 1, -8499.142578125, -3036.317626953125, 8.977961540222167968, 2.95832991600036621, 0, 0, 0.995804786682128906, 0.091503240168094635, 120, 255, 1, "", 45772, NULL),
(1733, 18079, 1, 0, 0, 1, 1, 313.71966552734375, -4661.78759765625, 16.12734413146972656, 3.176556825637817382, -0.03466272354125976, -0.0136871337890625, -0.99914455413818359, 0.017925642430782318, 120, 255, 1, "", 45327, NULL),
(18130, 142118, 1, 0, 0, 1, 1, -2934.614501953125, -1273.0382080078125, 72.20438385009765625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46158, NULL),
(21761, 181445, 530, 0, 0, 1, 1, 8679.9814453125, -7932.3349609375, 152.9143829345703125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45942, NULL),
(23180, 182575, 530, 0, 0, 1, 1, 1241.857666015625, 8493.8974609375, 23.134521484375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(24692, 183827, 530, 0, 0, 1, 1, -2552.796875, 5449.93505859375, 0.064805001020431518, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24746, 183895, 530, 0, 0, 1, 1, -2668.02783203125, 4369.15478515625, 36.00443649291992187, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24773, 183922, 530, 0, 0, 1, 1, -2680.010498046875, 4459.10791015625, 36.1190185546875, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24774, 183923, 530, 0, 0, 1, 1, 2662.958251953125, 6482.1162109375, 3.469566106796264648, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24775, 183924, 530, 0, 0, 1, 1, 2523.116455078125, 6686.43505859375, 3.497148990631103515, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(24776, 183925, 530, 0, 0, 1, 1, 2356.44970703125, 6528.1015625, 3.46956801414489746, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24777, 183926, 530, 0, 0, 1, 1, 2324.890625, 6711.6787109375, 17.086578369140625, 0.038830336183309555, 0, 0, 0.019413948059082031, 0.999811530113220214, 120, 255, 1, "", 45854, NULL),
(24778, 183927, 530, 0, 0, 1, 1, 1694.9271240234375, 6254.49853515625, 2.065490007400512695, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45942, NULL),
(24779, 183930, 530, 0, 0, 1, 1, 2356.87158203125, 7293.8193359375, 365.956787109375, 4.180065631866455078, 0, 0, -0.86819839477539062, 0.496217250823974609, 120, 255, 1, "", 45942, NULL),
(24780, 183931, 530, 0, 0, 1, 1, 1562.8160400390625, 6302.51904296875, 3.88653111457824707, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(24865, 184003, 530, 0, 0, 1, 1, 3665.8447265625, 6573.25244140625, 133.989410400390625, 1.343903779983520507, 0, 0, 0.622514724731445312, 0.782608091831207275, 120, 255, 1, "", 45942, NULL),
(25154, 184355, 530, 0, 0, 1, 1, 3238.96533203125, 5887.25537109375, -2.27546000480651855, 4.712389945983886718, 0.037006855010986328, 0.012340545654296875, -0.70699882507324218, 0.70613795518875122, 120, 255, 1, "", 45854, NULL),
(25171, 184370, 530, 0, 0, 1, 1, 3634.247314453125, 5249.26318359375, -18.2547931671142578, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(25174, 184373, 530, 0, 0, 1, 1, 3595.4453125, 5306.26025390625, -22.1728897094726562, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(25336, 184472, 530, 0, 0, 1, 1, 3213.538330078125, 5690.23193359375, -0.49235498905181884, 5.977754592895507812, 0, 0, -0.15212249755859375, 0.988361656665802001, 120, 255, 1, "", 45854, NULL),
(25338, 184475, 530, 0, 0, 1, 1, 3078.55908203125, 5863.0224609375, -0.02667200006544589, 5.742135047912597656, 0, 0, -0.26723766326904296, 0.96363067626953125, 120, 255, 1, "", 45854, NULL),
(25527, 184715, 530, 0, 0, 1, 1, -970.8125, 2172, 15.54283618927001953, 3.94444584846496582, 0, 0, -0.92050457000732421, 0.3907318115234375, 120, 255, 1, "", 45854, NULL),
(26040, 185180, 530, 0, 0, 1, 1, -1335.775390625, 2353.9306640625, 88.95517730712890625, 4.188792228698730468, 0, 0, -0.86602497100830078, 0.50000077486038208, 120, 255, 1, "", 45704, NULL),
(26161, 185283, 530, 0, 0, 1, 1, 2438.109375, 5737.91162109375, 272.2042236328125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(26167, 185289, 530, 0, 0, 1, 1, 2292.677001953125, 5757.18408203125, 269.552947998046875, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(27124, 141851, 209, 0, 0, 1, 1, 1909.48095703125, 1016.12677001953125, 11.51571846008300781, 2.792518377304077148, 0, 0, 0.984807014465332031, 0.173652306199073791, 7200, 255, 1, "", 49345, NULL),
(27291, 181322, 530, 0, 0, 1, 1, 7351.884765625, -7816.40283203125, 148.0069580078125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45942, NULL),
(27366, 181315, 530, 0, 0, 1, 1, 7645.99560546875, -7176.19091796875, 152.6761016845703125, 3.167797565460205078, 0, 0, -0.99991416931152343, 0.013101960532367229, 120, 255, 1, "", 45942, NULL),
(27887, 3315, 1, 0, 0, 1, 1, -1221.873779296875, -18.0720767974853515, 165.411224365234375, 3.115387916564941406, 0, 0, 0.999914169311523437, 0.013101960532367229, 120, 255, 1, "", 45435, NULL),
(28656, 179704, 309, 0, 0, 1, 1, -11548.8330078125, -1247.9774169921875, 78.28408050537109375, 3.9793548583984375, 0, 0, -0.9135446548461914, 0.406738430261611938, 7200, 255, 1, "", 48019, NULL),
(29558, 92099, 0, 0, 0, 1, 1, -9975.2314453125, -3654.420654296875, 21.69826698303222656, 2.661619186401367187, 0, 0, 0.971341133117675781, 0.237689673900604248, 120, 255, 1, "", 50664, NULL),
(30087, 20870, 0, 0, 0, 1, 1, 565.04864501953125, -277.395843505859375, 150.270782470703125, 6.146652698516845703, 0, 0, -0.06821346282958984, 0.997670710086822509, 120, 255, 1, "", 47168, NULL),
(30091, 20871, 0, 0, 0, 1, 1, 844.304931640625, -562.16192626953125, 141.905548095703125, 6.172833442687988281, 0, 0, -0.05514812469482421, 0.998478174209594726, 120, 255, 1, "", 46779, NULL),
(30095, 103663, 0, 0, 0, 1, 1, 253.0373077392578125, -1437.63916015625, 49.93048095703125, 3.708826541900634765, 0, 0, -0.96004962921142578, 0.279829770326614379, 120, 255, 1, "", 45613, NULL),
(30099, 89931, 0, 0, 0, 1, 1, 253.017364501953125, -1437.673583984375, 49.93165206909179687, 3.132858037948608398, 0, 0, 0.999990463256835937, 0.004367320332676172, 120, 255, 1, "", 45613, NULL),
(30118, 20872, 0, 0, 0, 1, 1, 681.5421142578125, -593.62762451171875, 162.83038330078125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45572, NULL),
(356, 187879, 571, 0, 0, 1, 1, 4207.36572265625, 4056.893798828125, 91.6207733154296875, 2.792518377304077148, 0, 0, 0.984807014465332031, 0.173652306199073791, 120, 255, 1, "", 46158, NULL),
(35622, 59530, 43, 0, 0, 1, 1, -69.809722900390625, -34.2418174743652343, -60.2395973205566406, 2.3547821044921875, 0.015677928924560546, 0.03179931640625, 0.923059463500976562, 0.383019834756851196, 7200, 255, 1, "", 53622, NULL),
(35657, 59529, 43, 0, 0, 1, 1, -286.253326416015625, -234.953399658203125, -63.6185035705566406, 3.456212043762207031, 0.010311603546142578, -0.01148509979248046, -0.98755168914794921, 0.156535655260086059, 7200, 255, 1, "", 53622, NULL),
(35707, 74078, 47, 0, 0, 1, 1, 2110.673095703125, 1543.941162109375, 81.49785614013671875, 0.820303261280059814, 0, 0, 0.398748397827148437, 0.917060375213623046, 7200, 255, 1, "", 51943, NULL),
(35731, 74075, 47, 0, 0, 1, 1, 2158.471923828125, 1413.6708984375, 74.1120758056640625, 0.820303261280059814, 0, 0, 0.398748397827148437, 0.917060375213623046, 7200, 255, 1, "", 51943, NULL),
(35744, 74076, 47, 0, 0, 1, 1, 2137.147705078125, 1923.770751953125, 66.4821624755859375, 0.820303261280059814, 0, 0, 0.398748397827148437, 0.917060375213623046, 7200, 255, 1, "", 51943, NULL),
(391, 176899, 0, 0, 0, 1, 1, -8138.421875, -1569.8853759765625, 133.5192108154296875, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 47612, NULL),
(406, 178524, 0, 0, 0, 1, 1, -7496.9130859375, -2173.036376953125, 165.4713897705078125, 5.256274700164794921, 0, 0, -0.49118995666503906, 0.871052503585815429, 120, 255, 1, "", 45772, NULL),
(42489, 178572, 0, 0, 0, 1, 1, -9492.125, -1930.1129150390625, 78.73984527587890625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45435, NULL),
(42500, 178573, 0, 0, 0, 1, 1, -9126.4912109375, -3231.55078125, 101.2188262939453125, 4.756025314331054687, -0.01012754440307617, 0.039875984191894531, -0.69037628173828125, 0.722279667854309082, 120, 255, 1, "", 48632, NULL),
(42586, 160470, 0, 0, 0, 1, 1, -9340.6962890625, -2297.04345703125, 71.59995269775390625, 3.063013076782226562, 0.013079643249511718, -0.00051307678222656, 0.999142646789550781, 0.039276301860809326, 120, 255, 1, "", 45435, NULL),
(44778, 177284, 0, 0, 0, 1, 1, 1659.44970703125, -732.3507080078125, 59.30325698852539062, 3.138877630233764648, 0, 0.052335739135742187, 0.998628616333007812, 0.001359317451715469, 120, 255, 1, "", 45613, NULL),
(44780, 177285, 0, 0, 0, 1, 1, 1750.3228759765625, -732.3680419921875, 59.94146728515625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45613, NULL),
(45306, 177286, 0, 0, 0, 1, 1, 962.346923828125, -1413.729248046875, 67.18117523193359375, 4.406959056854248046, 0.016182899475097656, 0.044300079345703125, -0.80493831634521484, 0.591481149196624755, 120, 255, 1, "", 45854, NULL),
(45312, 176393, 0, 0, 0, 1, 1, 1485.84033203125, -1863.154541015625, 58.44161605834960937, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(45318, 177289, 0, 0, 0, 1, 1, 1878.8004150390625, -1568.9149169921875, 58.9334869384765625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(45319, 176392, 0, 0, 0, 1, 1, 1690.46875, -2272.5625, 58.9361724853515625, 3.569205284118652343, -0.00945377349853515, 0.002411842346191406, -0.97719192504882812, 0.212133765220642089, 120, 255, 1, "", 45854, NULL),
(45324, 176361, 0, 0, 0, 1, 1, 1738.876708984375, -1184.9288330078125, 59.26894760131835937, 2.364918231964111328, 0, 0, 0.925539970397949218, 0.378649920225143432, 120, 255, 1, "", 45854, NULL),
(45601, 20970, 0, 0, 0, 1, 1, 2783.28466796875, -4814.7255859375, 80.58518218994140625, 3.141087770462036132, -0.0784468650817871, 0.017398834228515625, 0.99676513671875, 0.001619445742107927, 120, 255, 1, "", 45942, NULL),
(45604, 176273, 0, 0, 0, 1, 1, 2794.81689453125, -5585.4912109375, 161.77197265625, 2.469640254974365234, 0, 0, 0.944088935852050781, 0.329690933227539062, 120, 255, 1, "", 49345, NULL),
(45618, 176275, 0, 0, 0, 1, 1, 2609.157958984375, -5503.625, 158.0510406494140625, 3.141848087310791015, -0.04792261123657226, -0.04792213439941406, -0.99769783020019531, 0.002429168438538908, 120, 255, 1, "", 49345, NULL),
(46457, 20869, 0, 0, 0, 1, 1, 610.18231201171875, -427.19097900390625, 161.1328277587890625, 3.141554594039916992, 0.00436258316040039, 0.004362106323242187, -0.99998092651367187, 0, 120, 255, 1, "", 45572, NULL),
(47957, 177244, 1, 0, 0, 1, 1, 3349.37109375, 1013.63671875, 3.197114944458007812, 3.816494941711425781, 0, 0, -0.94360160827636718, 0.331083029508590698, 120, 255, 1, "", 45435, NULL),
(48871, 176091, 1, 0, 0, 1, 1, 6909.3271484375, -1820.1234130859375, 570.554931640625, 1.466075778007507324, 0, 0, 0.669130325317382812, 0.74314504861831665, 120, 255, 1, "", 45854, NULL),
(49697, 32879, 1, 0, 0, 1, 1, 10405.6162109375, 715.27911376953125, 1321.624267578125, 3.115387916564941406, 0, 0, 0.999914169311523437, 0.013101960532367229, 120, 255, 1, "", 46902, NULL),
(49700, 32880, 1, 0, 0, 1, 1, 9755.6806640625, 905.11285400390625, 1295.517333984375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46902, NULL),
(49942, 153124, 1, 0, 0, 1, 1, -5499.21875, 1197.7396240234375, 18.96612739562988281, 1.946041464805603027, 0.004910945892333984, 0.007212638854980468, 0.826558113098144531, 0.562783777713775634, 120, 255, 1, "", 45942, NULL),
(49944, 153125, 1, 0, 0, 1, 1, -5504.0556640625, 1197.6458740234375, 18.80996131896972656, 1.35262918472290039, -0.01361083984375, -0.01092338562011718, 0.625827789306640625, 0.779765963554382324, 120, 255, 1, "", 45942, NULL),
(50060, 176278, 1, 0, 0, 1, 1, -4599.15966796875, 1377.6285400390625, 107.1603927612304687, 0.750492870807647705, 0, 0, 0.366501808166503906, 0.930417299270629882, 120, 255, 1, "", 46248, NULL),
(50071, 176284, 1, 0, 0, 1, 1, -4414.02978515625, 1476.583740234375, 126.0102005004882812, 4.084071159362792968, 0, 0, -0.8910064697265625, 0.453990638256072998, 120, 255, 1, "", 46248, NULL),
(50176, 153576, 1, 0, 0, 1, 1, -3741.395751953125, 207.0902862548828125, 121.75433349609375, 3.097961187362670898, -0.03535795211791992, -0.02103424072265625, 0.998931884765625, 0.02103438414633274, 120, 255, 1, "", 50664, NULL),
(50185, 153577, 1, 0, 0, 1, 1, -3993.01220703125, -179.923614501953125, 139.4153289794921875, 3.115387916564941406, 0, 0, 0.999914169311523437, 0.013101960532367229, 120, 255, 1, "", 50664, NULL),
(50188, 153579, 1, 0, 0, 1, 1, -3661.646728515625, 260.977447509765625, 143.121185302734375, 3.115357398986816406, 0.021925926208496093, 0.008437156677246093, 0.999640464782714843, 0.01292332075536251, 120, 255, 1, "", 50664, NULL),
(50454, 175984, 1, 0, 0, 1, 1, 7510.90380859375, -1529.2379150390625, 156.67913818359375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 54261, NULL),
(56551, 186656, 571, 0, 0, 1, 1, 434.97027587890625, -4640.9560546875, 245.910919189453125, 4.014260292053222656, 0, 0, -0.90630722045898437, 0.422619491815567016, 120, 255, 1, "", 45772, NULL),
(57636, 190021, 571, 0, 0, 1, 1, 1623.4444580078125, -4828.783203125, 126.450592041015625, 3.063024282455444335, 0, 0, 0.999228477478027343, 0.039274025708436965, 120, 255, 1, "", 46158, NULL),
(57887, 188495, 571, 0, 0, 1, 1, 4893.92431640625, 294.055572509765625, 131.0809173583984375, 1.343903779983520507, 0.002308845520019531, -0.13435077667236328, 0.609956741333007812, 0.780959248542785644, 120, 255, 1, "", 46158, NULL),
(58028, 188246, 571, 0, 0, 1, 1, 4560.39306640625, -4171.35791015625, 173.485137939453125, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 48632, NULL),
(58077, 188248, 571, 0, 0, 1, 1, 4547.66650390625, -4213.87841796875, 170.4960784912109375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 47720, NULL),
(59649, 190618, 571, 0, 0, 1, 1, 5493.28125, -3456.926513671875, 350.32720947265625, 0.558503925800323486, 0, 0, 0.275636672973632812, 0.961261868476867675, 120, 255, 1, "", 46158, NULL),
(59656, 190619, 571, 0, 0, 1, 1, 5613.61376953125, -3476.75048828125, 350.326904296875, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 46158, NULL),
(59663, 190620, 571, 0, 0, 1, 1, 5581.158203125, -3535.220947265625, 350.326904296875, 5.550147056579589843, 0, 0, -0.358367919921875, 0.933580458164215087, 120, 255, 1, "", 46158, NULL),
(59778, 190630, 571, 0, 0, 1, 1, 5527.3017578125, -3380.555419921875, 350.326904296875, 0.750490784645080566, 0, 0, 0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 46158, NULL),
(60087, 187690, 571, 0, 0, 1, 1, 4022.256591796875, 3604.12548828125, 104.032501220703125, 5.84685373306274414, 0, 0, -0.21643924713134765, 0.976296067237854003, 120, 255, 1, "", 46158, NULL),
(60109, 187690, 571, 0, 0, 1, 1, 4125.6533203125, 3637.903564453125, 91.7763824462890625, 5.288348197937011718, 0, 0, -0.4771585464477539, 0.878817260265350341, 120, 255, 1, "", 46158, NULL),
(60124, 187690, 571, 0, 0, 1, 1, 3746.692626953125, 3519.831298828125, 69.34168243408203125, 4.328419685363769531, 0, 0, -0.82903671264648437, 0.559194147586822509, 120, 255, 1, "", 46158, NULL),
(61034, 187879, 571, 0, 0, 1, 1, 4356.13232421875, 4261.08154296875, 98.309539794921875, 6.195919513702392578, 0, 0, -0.04361915588378906, 0.999048233032226562, 120, 255, 1, "", 48632, NULL),
(62571, 192916, 571, 0, 0, 1, 1, 6705.7255859375, 3529.06884765625, 671.09417724609375, 4.398232460021972656, 0, 0, -0.80901622772216796, 0.587786316871643066, 120, 255, 1, "", 46368, NULL),
(66376, 190936, 609, 0, 0, 1, 4, 1993.154541015625, -5826.18408203125, 100.5062179565429687, 2.356194972991943359, 0, 0, 0.923879623413085937, 0.382683247327804565, 120, 255, 1, "", 50664, NULL),
(66377, 190937, 609, 0, 0, 1, 4, 1783.8404541015625, -5877.65185546875, 109.495758056640625, 3.700104713439941406, 0, 0, -0.96126079559326171, 0.275640487670898437, 120, 255, 1, "", 50664, NULL),
(67467, 187714, 595, 0, 0, 3, 1, 2306.792236328125, 1286.4755859375, 130.455230712890625, 3.016947269439697265, -0.0154275894165039, 0.115665435791015625, 0.991074562072753906, 0.064456820487976074, 7200, 255, 1, "", 46368, NULL),
(6783, 2076, 0, 0, 0, 1, 1, -12342.9033203125, 165.0902862548828125, 2.854399919509887695, 5.393068790435791015, -0.008056640625, 0.013510704040527343, -0.43035411834716796, 0.90252310037612915, 120, 255, 1, "", 45572, NULL),
(7569, 186451, 1, 0, 0, 1, 1, -3961.460205078125, -4983.7431640625, 2.522584915161132812, 2.687806606292724609, 0, 0, 0.974370002746582031, 0.224951311945915222, 120, 255, 1, "", 46779, NULL),
(9667, 181327, 530, 0, 0, 1, 1, 6610.27099609375, -7352.7568359375, 54.10820388793945312, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45942, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (105173, 180414, 186174, 186175, 186176, 186178))
AND (`guid` BETWEEN 23298 AND 23320);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(23298, 105173, 1, 0, 0, 1, 1, 2900.787353515625, 2465.590576171875, 138.2296905517578125, 0.750425219535827636, 0, 0, 0.3664703369140625, 0.930429697036743164, 120, 255, 1, "", 45572, NULL),
(23299, 180414, 530, 0, 0, 1, 1, -2626.611328125, 4458.65283203125, 36.0947418212890625, 5.044002056121826171, 0, 0, -0.58070278167724609, 0.814115643501281738, 120, 255, 1, "", 45942, NULL),
(23300, 180414, 530, 0, 0, 1, 1, -3907.744873046875, 2093.68603515625, 94.8126068115234375, 3.717553615570068359, 0, 0, -0.95881938934326171, 0.284016460180282592, 120, 255, 1, "", 46158, NULL),
(23301, 180414, 530, 0, 0, 1, 1, -3971.827392578125, 2234.385986328125, 101.9039535522460937, 2.426007747650146484, 0, 0, 0.936672210693359375, 0.350207358598709106, 120, 255, 1, "", 51943, NULL),
(23302, 180414, 530, 0, 0, 1, 1, -4056.014892578125, 2192.958251953125, 109.9213104248046875, 2.635444164276123046, 0, 0, 0.96814727783203125, 0.250381410121917724, 120, 255, 1, "", 51943, NULL),
(23303, 180414, 530, 0, 0, 1, 1, -602.4219970703125, 4110.81494140625, 89.87567901611328125, 1.047197580337524414, 0, 0, 0.5, 0.866025388240814208, 120, 255, 1, "", 45942, NULL),
(23304, 180414, 530, 0, 0, 1, 1, -604.7305908203125, 4180.52099609375, 64.1133270263671875, 5.270895957946777343, 0, 0, -0.48480892181396484, 0.87462007999420166, 120, 255, 1, "", 45942, NULL),
(23305, 180414, 530, 0, 0, 1, 1, 181.1303253173828125, 2611.92431640625, 87.28353118896484375, 6.213373661041259765, 0, 0, -0.03489875793457031, 0.999390840530395507, 120, 255, 1, "", 45942, NULL),
(23306, 180414, 530, 0, 0, 1, 1, 1947.9859619140625, 6887.91455078125, 161.843902587890625, 1.48352813720703125, 0, 0, 0.675589561462402343, 0.737277925014495849, 120, 255, 1, "", 51943, NULL),
(23307, 180414, 530, 0, 0, 1, 1, 2020.8543701171875, 6866.53369140625, 174.548431396484375, 4.328419685363769531, 0, 0, -0.82903671264648437, 0.559194147586822509, 120, 255, 1, "", 51943, NULL),
(23308, 180414, 530, 0, 0, 1, 1, 2051.811767578125, 4684.263671875, 150.06573486328125, 0.977383077144622802, 0, 0, 0.469470977783203125, 0.882947921752929687, 120, 255, 1, "", 45942, NULL),
(23309, 180414, 530, 0, 0, 1, 1, 2115.855712890625, 6760.3642578125, 166.03997802734375, 0.349065244197845458, 0, 0, 0.173647880554199218, 0.984807789325714111, 120, 255, 1, "", 51943, NULL),
(23310, 180414, 530, 0, 0, 1, 1, 212.0390625, 4357.51904296875, 120.3719635009765625, 5.201082706451416015, 0, 0, -0.51503753662109375, 0.857167601585388183, 120, 255, 1, "", 51943, NULL),
(23311, 180414, 530, 0, 0, 1, 1, 2266.48046875, 5996.30908203125, 142.7248382568359375, 5.742135047912597656, 0, 0, -0.26723766326904296, 0.96363067626953125, 120, 255, 1, "", 45942, NULL),
(23312, 180414, 530, 0, 0, 1, 1, 227.64898681640625, 2628.176025390625, 87.4365081787109375, 3.24634718894958496, 0, 0, -0.99862861633300781, 0.052353221923112869, 120, 255, 1, "", 45942, NULL),
(23313, 180414, 530, 0, 0, 1, 1, 2332.523681640625, 6017.34130859375, 142.4041748046875, 2.687806606292724609, 0, 0, 0.974370002746582031, 0.224951311945915222, 120, 255, 1, "", 45942, NULL),
(23314, 180414, 530, 0, 0, 1, 1, 2378.328857421875, 5941.94189453125, 151.9701690673828125, 2.321286916732788085, 0, 0, 0.917059898376464843, 0.398749500513076782, 120, 255, 1, "", 45942, NULL),
(23315, 180414, 530, 0, 0, 1, 1, 2436.930908203125, 5996.685546875, 153.7641448974609375, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 120, 255, 1, "", 45942, NULL),
(23316, 180414, 530, 0, 0, 1, 1, 273.5987548828125, 2719.646484375, 86.63010406494140625, 1.448621988296508789, 0, 0, 0.662619590759277343, 0.748956084251403808, 120, 255, 1, "", 45942, NULL),
(23317, 186174, 530, 0, 0, 1, 1, -1374.55908203125, 9706.9833984375, 205.30621337890625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(23318, 186175, 530, 0, 0, 1, 1, -1456.9722900390625, 9855.896484375, 200.6370849609375, 3.150327444076538085, 0, 0, -0.99999046325683593, 0.004367320332676172, 120, 255, 1, "", 45854, NULL),
(23319, 186176, 530, 0, 0, 1, 1, -1547.623291015625, 9744.4033203125, 202.4515228271484375, 0.069811686873435974, 0, 0, 0.034898757934570312, 0.999390840530395507, 120, 255, 1, "", 45854, NULL),
(23320, 186178, 530, 0, 0, 1, 1, -1374.6441650390625, 9581.0634765625, 205.552154541015625, 0.881391823291778564, 0, 0, 0.426568984985351562, 0.904455006122589111, 120, 255, 1, "", 45854, NULL);
