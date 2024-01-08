-- DB update 2023_11_26_01 -> 2023_11_26_02
-- Update gameobject 187653 'Standing, Post - MFF' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187653) AND (`guid` IN (1, 3, 50485, 50486, 50488, 50489, 50491, 50492, 50493, 50505, 50506, 50507, 50508, 50509, 50510, 50511, 50522, 50523, 50524, 50525, 50526, 50529, 50530, 50531, 50532, 50533, 50534, 50535, 50536, 50537, 50538, 50539, 50540, 50544, 50547, 50551));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(1, 187653, 1, 0, 0, 1, 1, -959.702392578125, -3739.05859375, 5.662161827087402343, 3.647741317749023437, 0, 0, -0.96814727783203125, 0.250381410121917724, 120, 255, 1, "", 50250, NULL),
(3, 187653, 1, 0, 0, 1, 1, -974.5880126953125, -3647.974853515625, 17.49559974670410156, 1.448621988296508789, 0, 0, 0.662619590759277343, 0.748956084251403808, 120, 255, 1, "", 50250, NULL),
(50485, 187653, 1, 0, 0, 1, 1, -2342.563720703125, -1953.900146484375, 95.79764556884765625, 5.183629035949707031, 0, 0, -0.52249813079833984, 0.852640450000762939, 120, 255, 1, "", 50172, NULL),
(50486, 187653, 1, 0, 0, 1, 1, -5414.06494140625, -2451.41357421875, 88.73992919921875, 5.637413978576660156, 0, 0, -0.31730461120605468, 0.948323667049407958, 120, 255, 1, "", 50063, NULL),
(50488, 187653, 0, 0, 0, 1, 1, 2312.06201171875, -5308.84619140625, 81.9962615966796875, 5.567600727081298828, 0, 0, -0.35020732879638671, 0.936672210693359375, 120, 255, 1, "", 50063, NULL),
(50489, 187653, 0, 0, 0, 1, 1, -7495.18408203125, -2186.27490234375, 167.179901123046875, 5.550147056579589843, 0, 0, -0.358367919921875, 0.933580458164215087, 120, 255, 1, "", 50172, NULL),
(50491, 187653, 1, 0, 0, 1, 1, -955.35992431640625, -3602.349853515625, 22.27142333984375, 2.565631866455078125, 0, 0, 0.958819389343261718, 0.284016460180282592, 120, 255, 1, "", 50250, NULL),
(50492, 187653, 0, 0, 0, 1, 1, -5441.4912109375, -464.607757568359375, 397.611236572265625, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50063, NULL),
(50493, 187653, 0, 0, 0, 1, 1, -9547.0673828125, -1245.0733642578125, 44.22743988037109375, 1.32644820213317871, 0, 0, 0.615660667419433593, 0.788011372089385986, 120, 255, 1, "", 50063, NULL),
(50505, 187653, 0, 0, 0, 1, 1, -15.3968639373779296, -947.0750732421875, 56.37468719482421875, 3.665196180343627929, 0, 0, -0.96592521667480468, 0.258821308612823486, 120, 255, 1, "", 50063, NULL),
(50506, 187653, 0, 0, 0, 1, 1, -44.5442161560058593, -864.40185546875, 56.17826461791992187, 1.762782454490661621, 0, 0, 0.771624565124511718, 0.636078238487243652, 120, 255, 1, "", 50063, NULL),
(50507, 187653, 0, 0, 0, 1, 1, 6.729709148406982421, -848.09906005859375, 59.30852127075195312, 4.764749526977539062, 0, 0, -0.6883544921875, 0.725374460220336914, 120, 255, 1, "", 50063, NULL),
(50508, 187653, 1, 0, 0, 1, 1, -2335.37109375, -1943.8331298828125, 95.80144500732421875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, "", 50172, NULL),
(50509, 187653, 1, 0, 0, 1, 1, -2343.39208984375, -1933.1588134765625, 95.83963775634765625, 4.48549652099609375, 0, 0, -0.7826080322265625, 0.622514784336090087, 120, 255, 1, "", 50172, NULL),
(50510, 187653, 1, 0, 0, 1, 1, -2363.708251953125, -1906.34228515625, 95.78253936767578125, 0.034906249493360519, 0, 0, 0.017452239990234375, 0.999847710132598876, 120, 255, 1, "", 50063, NULL),
(50511, 187653, 1, 0, 0, 1, 1, -2370.55859375, -1953.1300048828125, 96.0865631103515625, 3.543023586273193359, 0, 0, -0.97992420196533203, 0.199370384216308593, 120, 255, 1, "", 50172, NULL),
(50522, 187653, 1, 0, 0, 1, 1, -2361.51953125, -1919.0145263671875, 95.784210205078125, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50172, NULL),
(50523, 187653, 1, 0, 0, 1, 1, -5400.4931640625, -2421.969970703125, 89.2760162353515625, 5.6897735595703125, 0, 0, -0.29237174987792968, 0.956304728984832763, 120, 255, 1, "", 50063, NULL),
(50524, 187653, 1, 0, 0, 1, 1, -5438.33837890625, -2387.734375, 87.78409576416015625, 1.151916384696960449, 0, 0, 0.544638633728027343, 0.838670849800109863, 120, 255, 1, "", 50063, NULL),
(50525, 187653, 1, 0, 0, 1, 1, -5424.3349609375, -2388.798095703125, 87.90140533447265625, 1.85004889965057373, 0, 0, 0.798635482788085937, 0.60181504487991333, 120, 255, 1, "", 50063, NULL),
(50526, 187653, 0, 0, 0, 1, 1, -5628.18798828125, -494.926422119140625, 396.999908447265625, 5.969027042388916015, 0, 0, -0.1564340591430664, 0.987688362598419189, 120, 255, 1, "", 50063, NULL),
(50529, 187653, 0, 0, 0, 1, 1, -9580.220703125, -1312.986572265625, 47.11867904663085937, 4.764749526977539062, 0, 0, -0.6883544921875, 0.725374460220336914, 120, 255, 1, "", 50172, NULL),
(50530, 187653, 0, 0, 0, 1, 1, -543.734375, -4552.03759765625, 10.56383037567138671, 5.375615119934082031, 0, 0, -0.4383707046508789, 0.898794233798980712, 120, 255, 1, "", 50063, NULL),
(50531, 187653, 0, 0, 0, 1, 1, -565.24822998046875, -4576.36767578125, 9.694963455200195312, 2.565631866455078125, 0, 0, 0.958819389343261718, 0.284016460180282592, 120, 255, 1, "", 50063, NULL),
(50532, 187653, 0, 0, 0, 1, 1, -551.60235595703125, -4544.2392578125, 10.22031974792480468, 3.665196180343627929, 0, 0, -0.96592521667480468, 0.258821308612823486, 120, 255, 1, "", 50063, NULL),
(50533, 187653, 0, 0, 0, 1, 1, -11310.5048828125, -209.076385498046875, 75.40088653564453125, 1.937312245368957519, 0, 0, 0.824125289916992187, 0.566407561302185058, 120, 255, 1, "", 50063, NULL),
(50534, 187653, 0, 0, 0, 1, 1, -11319.4287109375, -207.591033935546875, 75.26616668701171875, 4.293513298034667968, 0, 0, -0.8386697769165039, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50535, 187653, 0, 0, 0, 1, 1, -23.6156139373779296, -888.441162109375, 56.471771240234375, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(50536, 187653, 1, 0, 0, 1, 1, -5422.2041015625, -2460.352294921875, 88.4918212890625, 1.588248729705810546, 0, 0, 0.713250160217285156, 0.700909554958343505, 120, 255, 1, "", 50063, NULL),
(50537, 187653, 1, 0, 0, 1, 1, -5431.72509765625, -2467.69091796875, 88.6624908447265625, 2.059488296508789062, 0, 0, 0.857167243957519531, 0.515038192272186279, 120, 255, 1, "", 50063, NULL),
(50538, 187653, 1, 0, 0, 1, 1, -940.1961669921875, -3596.919189453125, 22.46337699890136718, 0.27925160527229309, 0, 0, 0.139172554016113281, 0.990268170833587646, 120, 255, 1, "", 50250, NULL),
(50539, 187653, 1, 0, 0, 1, 1, -949.35882568359375, -3738.2265625, 5.853586196899414062, 5.393068790435791015, 0, 0, -0.43051052093505859, 0.902585566043853759, 120, 255, 1, "", 50250, NULL),
(50540, 187653, 1, 0, 0, 1, 1, -916.86590576171875, -3754.3134765625, 10.26247406005859375, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(50544, 187653, 0, 0, 0, 1, 1, 2265.62158203125, -5318.97314453125, 82.087982177734375, 2.513273954391479492, 0, 0, 0.951056480407714843, 0.309017121791839599, 120, 255, 1, "", 50063, NULL),
(50547, 187653, 0, 0, 0, 1, 1, -33.89501953125, -891.283203125, 56.11468505859375, 4.398232460021972656, 0, 0, -0.80901622772216796, 0.587786316871643066, 120, 255, 1, "", 50063, NULL),
(50551, 187653, 0, 0, 0, 1, 1, -5468.9755859375, -462.444183349609375, 397.643218994140625, 1.274088263511657714, 0, 0, 0.594821929931640625, 0.80385744571685791, 120, 255, 1, "", 50063, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` = 187653) AND (`guid` BETWEEN 23186 AND 23216);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(23186, 187653, 0, 0, 0, 1, 1, -5494.3232421875, -679.50799560546875, 394.053955078125, 0.069811686873435974, 0, 0, 0.034898757934570312, 0.999390840530395507, 120, 255, 1, "", 50063, NULL),
(23187, 187653, 0, 0, 0, 1, 1, -5509.95751953125, -658.24102783203125, 397.32122802734375, 0.750490784645080566, 0, 0, 0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 50063, NULL),
(23188, 187653, 0, 0, 0, 1, 1, -8379.232421875, -2770.628173828125, 194.5870208740234375, 0.471238493919372558, 0, 0, 0.233445167541503906, 0.972369968891143798, 120, 255, 1, "", 50063, NULL),
(23189, 187653, 0, 0, 0, 1, 1, -8401.8212890625, -2750.986083984375, 193.9829864501953125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(23190, 187653, 0, 0, 0, 1, 1, -9506.74609375, -1266.20751953125, 42.30399322509765625, 5.532694816589355468, 0, 0, -0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 50063, NULL),
(23191, 187653, 0, 0, 0, 1, 1, -9556.5283203125, -1396.1536865234375, 54.19618606567382812, 0.558503925800323486, 0, 0, 0.275636672973632812, 0.961261868476867675, 120, 255, 1, "", 50172, NULL),
(23192, 187653, 530, 0, 0, 1, 1, -3943.5859375, 2116.150634765625, 96.86255645751953125, 1.954769015312194824, 0, 0, 0.829037666320800781, 0.559192776679992675, 120, 255, 1, "", 50063, NULL),
(23193, 187653, 530, 0, 0, 1, 1, -3947.44091796875, 2195.889892578125, 101.9546432495117187, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 120, 255, 1, "", 50063, NULL),
(23194, 187653, 530, 0, 0, 1, 1, -3947.631103515625, 2139.38671875, 98.95597076416015625, 0.261798173189163208, 0, 0, 0.130525588989257812, 0.991444945335388183, 120, 255, 1, "", 50063, NULL),
(23195, 187653, 530, 0, 0, 1, 1, -3952.103271484375, 2178.580322265625, 101.6064529418945312, 4.502951622009277343, 0, 0, -0.7771453857421875, 0.629321098327636718, 120, 255, 1, "", 50063, NULL),
(23196, 187653, 530, 0, 0, 1, 1, -3955.338623046875, 2215.828125, 102.0366363525390625, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 120, 255, 1, "", 50063, NULL),
(23197, 187653, 530, 0, 0, 1, 1, -3958.839111328125, 2204.562744140625, 101.8769073486328125, 5.585053920745849609, 0, 0, -0.34202003479003906, 0.939692676067352294, 120, 255, 1, "", 50063, NULL),
(23198, 187653, 530, 0, 0, 1, 1, -3962.6689453125, 2179.875244140625, 101.4113235473632812, 5.742135047912597656, 0, 0, -0.26723766326904296, 0.96363067626953125, 120, 255, 1, "", 50063, NULL),
(23199, 187653, 530, 0, 0, 1, 1, -3975.665771484375, 2183.826171875, 102.0339126586914062, 0.488691210746765136, 0, 0, 0.241921424865722656, 0.970295846462249755, 120, 255, 1, "", 50063, NULL),
(23200, 187653, 530, 0, 0, 1, 1, -3975.990478515625, 2200.106201171875, 101.8627471923828125, 2.67034769058227539, 0, 0, 0.972369194030761718, 0.233448356389999389, 120, 255, 1, "", 50063, NULL),
(23201, 187653, 530, 0, 0, 1, 1, -3976.474365234375, 2192.468017578125, 101.8899917602539062, 4.101525306701660156, 0, 0, -0.88701057434082031, 0.461749136447906494, 120, 255, 1, "", 50063, NULL),
(23202, 187653, 530, 0, 0, 1, 1, -3999.655517578125, 2223.364013671875, 105.7338027954101562, 4.852017402648925781, 0, 0, -0.65605831146240234, 0.754710197448730468, 120, 255, 1, "", 50063, NULL),
(23203, 187653, 530, 0, 0, 1, 1, -4036.585205078125, 2201.17236328125, 110.5763168334960937, 3.839725255966186523, 0, 0, -0.93969249725341796, 0.34202045202255249, 120, 255, 1, "", 50063, NULL),
(23204, 187653, 530, 0, 0, 1, 1, -4039.185791015625, 2197.356689453125, 110.4058074951171875, 0.261798173189163208, 0, 0, 0.130525588989257812, 0.991444945335388183, 120, 255, 1, "", 50063, NULL),
(23205, 187653, 530, 0, 0, 1, 1, -4040.05859375, 2204.321044921875, 110.7290496826171875, 6.178466320037841796, 0, 0, -0.05233573913574218, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(23206, 187653, 530, 0, 0, 1, 1, -4043.81591796875, 2202.357421875, 110.7310562133789062, 1.32644820213317871, 0, 0, 0.615660667419433593, 0.788011372089385986, 120, 255, 1, "", 50063, NULL),
(23207, 187653, 530, 0, 0, 1, 1, -4043.825927734375, 2199.0810546875, 110.6510696411132812, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 120, 255, 1, "", 50063, NULL),
(23208, 187653, 530, 0, 0, 1, 1, -4054.807373046875, 2175.5166015625, 110.4941024780273437, 5.602506637573242187, 0, 0, -0.33380699157714843, 0.942641437053680419, 120, 255, 1, "", 50063, NULL),
(23209, 187653, 571, 0, 0, 1, 1, 5046.61181640625, -520.1336669921875, 220.6881561279296875, 4.188792228698730468, 0, 0, -0.86602497100830078, 0.50000077486038208, 120, 255, 1, "", 50172, NULL),
(23210, 187653, 571, 0, 0, 1, 1, 5052.197265625, -513.4913330078125, 220.63067626953125, 2.391098499298095703, 0, 0, 0.930417060852050781, 0.366502493619918823, 120, 255, 1, "", 50172, NULL),
(23211, 187653, 571, 0, 0, 1, 1, 5075.03564453125, -564.87677001953125, 220.1215362548828125, 0.453785061836242675, 0, 0, 0.224950790405273437, 0.974370121955871582, 120, 255, 1, "", 50172, NULL),
(23212, 187653, 571, 0, 0, 1, 1, 5592.357421875, -656.36834716796875, 204.997467041015625, 3.874631166458129882, 0, 0, -0.93358039855957031, 0.358368009328842163, 120, 255, 1, "", 50172, NULL),
(23213, 187653, 571, 0, 0, 1, 1, 5593.48974609375, -638.1298828125, 201.8386993408203125, 1.012289404869079589, 0, 0, 0.484808921813964843, 0.87462007999420166, 120, 255, 1, "", 50172, NULL),
(23214, 187653, 571, 0, 0, 1, 1, 5604.041015625, -742.26007080078125, 201.026214599609375, 0.872663915157318115, 0, 0, 0.422617912292480468, 0.906307935714721679, 120, 255, 1, "", 50172, NULL),
(23215, 187653, 571, 0, 0, 1, 1, 5609.00390625, -716.60791015625, 206.0215301513671875, 3.647741317749023437, 0, 0, -0.96814727783203125, 0.250381410121917724, 120, 255, 1, "", 50172, NULL),
(23216, 187653, 571, 0, 0, 1, 1, 5614.90380859375, -750.47662353515625, 202.3785247802734375, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50172, NULL);

-- remove duplicate spawns
DELETE FROM `gameobject` WHERE (`id` = 187653) AND (`guid` IN (50518, 50521, 50512, 50515, 50519, 50520, 50503, 50483, 50517, 50502, 50542, 50546, 50543, 50545, 50490, 50541));
DELETE FROM `game_event_gameobject` WHERE (`guid` IN (50518, 50521, 50512, 50515, 50519, 50520, 50503, 50483, 50517, 50502, 50542, 50546, 50543, 50545, 50490, 50541));

-- remaining spawns (no sniffed values available)
-- (`guid` IN (50498, 50496, 50528, 50495, 50549, 50494, 50548, 50527, 50550, 50487, 50516, 50501, 50504, 50480, 50482, 50513, 50514, 50497, 50481, 50499, 50500, 50484))

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 187653));
INSERT INTO `game_event_gameobject` (SELECT 1, `guid` FROM `gameobject` WHERE `id` = 187653);
