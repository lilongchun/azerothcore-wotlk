-- DB update 2024_01_14_04 -> 2024_01_14_05
-- Update gameobject 181302 'Camp Crate' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 181302) AND (`guid` IN (150734, 150735, 150865, 150866, 150991, 150992, 150993, 151008, 151009, 151024, 151025, 17820, 17821, 17846, 17847, 21478, 21479, 50697, 50698, 50699, 50700, 50701, 50702, 50703, 50704, 50706, 50707, 50708, 50711, 50712, 50713, 50714, 50715, 50716, 50717, 50718, 50719, 50720, 50721, 50722, 50723, 50724, 50725, 50726, 50727, 50728, 50729, 50730, 50731, 50732, 50733, 50734, 50735, 50736, 50737, 50738, 50739, 50742, 50744, 50745, 50746, 50748, 50749, 50751, 50752, 50753, 50754, 50755, 50756, 50757, 50758, 50759, 50760, 50761, 50762, 50763, 50764, 50765, 50766, 50767, 50768, 50769, 50770, 50771, 50772, 50773, 50774, 50775, 50776, 50777, 50778, 50779, 50780, 50781, 50782, 50783, 50786, 50787, 50788, 50789, 50790, 50791, 50792, 50793, 50794, 50795, 50796, 50797, 50798, 50799, 50800, 50801, 50804, 50805, 50806, 50807, 50808, 50809, 70541, 70542, 70574, 70575));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(150734, 181302, 1, 0, 0, 1, 1, 134.8065338134765625, -4713.8759765625, 18.52238273620605468, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(150735, 181302, 1, 0, 0, 1, 1, 135.466583251953125, -4715.68603515625, 18.40978431701660156, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(150865, 181302, 530, 0, 0, 1, 1, 9375.37109375, -6767.38037109375, 15.07124805450439453, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(150866, 181302, 530, 0, 0, 1, 1, 9376.7236328125, -6766.86767578125, 15.200714111328125, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(150991, 181302, 530, 0, 0, 1, 1, 9788.2744140625, -7253.78173828125, 26.12618255615234375, 4.869470596313476562, 0, 0, -0.64944744110107421, 0.760406434535980224, 120, 255, 1, "", 50063, NULL),
(150992, 181302, 530, 0, 0, 1, 1, 9794.4833984375, -7248.72314453125, 26.09469223022460937, 5.480334281921386718, 0, 0, -0.39073085784912109, 0.920504987239837646, 120, 255, 1, "", 50063, NULL),
(150993, 181302, 530, 0, 0, 1, 1, 9794.4892578125, -7248.68017578125, 27.33173561096191406, 5.218535900115966796, 0, 0, -0.507537841796875, 0.861629426479339599, 120, 255, 1, "", 50063, NULL),
(151008, 181302, 530, 0, 0, 1, 1, 7682.017578125, -6838.89453125, 79.09078216552734375, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(151009, 181302, 530, 0, 0, 1, 1, 7684.65478515625, -6840.8251953125, 79.14206695556640625, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(151024, 181302, 0, 0, 0, 1, 1, 2279.25390625, 443.731353759765625, 34.12160110473632812, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(151025, 181302, 0, 0, 0, 1, 1, 2279.26318359375, 442.134979248046875, 34.12934112548828125, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, "", 50063, NULL),
(17820, 181302, 0, 0, 0, 1, 1, -8265.0703125, -2627.1435546875, 135.0536041259765625, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(17821, 181302, 0, 0, 0, 1, 1, -8263.3046875, -2627.121826171875, 134.5683135986328125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(17846, 181302, 0, 0, 0, 1, 1, 1004.42657470703125, -1443.6673583984375, 62.28302764892578125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(17847, 181302, 0, 0, 0, 1, 1, 1004.09698486328125, -1446.2684326171875, 61.95485305786132812, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(21478, 181302, 530, 0, 0, 1, 1, 2286.953125, 6131.72314453125, 135.8838043212890625, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(21479, 181302, 530, 0, 0, 1, 1, 2286.060791015625, 6134.22998046875, 136.069580078125, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50697, 181302, 1, 0, 0, 1, 1, 8706.96484375, 968.04229736328125, 12.4523477554321289, 5.532694816589355468, 0, 0, -0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 50063, NULL),
(50698, 181302, 1, 0, 0, 1, 1, -1007.5889892578125, 302.357086181640625, 135.745941162109375, 3.94444584846496582, 0, 0, -0.92050457000732421, 0.3907318115234375, 120, 255, 1, "", 50063, NULL),
(50699, 181302, 1, 0, 0, 1, 1, -3108.4140625, -2731.14111328125, 34.3019256591796875, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50700, 181302, 0, 0, 0, 1, 1, 1805.097900390625, 217.7008514404296875, 61.69276809692382812, 5.35816192626953125, 0, 0, -0.446197509765625, 0.894934535026550292, 120, 255, 1, "", 50063, NULL),
(50701, 181302, 1, 0, 0, 1, 1, 952.9249267578125, 783.8201904296875, 104.8732681274414062, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50702, 181302, 1, 0, 0, 1, 1, -6773.392578125, 541.70050048828125, -0.47682300209999084, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50703, 181302, 1, 0, 0, 1, 1, 9775.4326171875, 1011.67608642578125, 1299.2979736328125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50704, 181302, 1, 0, 0, 1, 1, -6771.6142578125, 542.0146484375, -0.17543399333953857, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50706, 181302, 1, 0, 0, 1, 1, -6991.87646484375, 911.72491455078125, 9.325331687927246093, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50707, 181302, 1, 0, 0, 1, 1, -7224.587890625, -3852.66845703125, 12.27015590667724609, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50708, 181302, 1, 0, 0, 1, 1, -7226.125, -3853.4423828125, 12.11434745788574218, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50711, 181302, 1, 0, 0, 1, 1, 6843.33837890625, -4562.46728515625, 709.45257568359375, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50712, 181302, 1, 0, 0, 1, 1, -7113.57275390625, -3664.44091796875, 9.499933242797851562, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50713, 181302, 1, 0, 0, 1, 1, -7114.2919921875, -3666.123779296875, 9.4143218994140625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50714, 181302, 1, 0, 0, 1, 1, 6844.60888671875, -4560.16796875, 709.4390869140625, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50715, 181302, 530, 0, 0, 1, 1, -2549.407958984375, 4270.67529296875, 20.42644882202148437, 6.021387100219726562, 0, 0, -0.13052558898925781, 0.991444945335388183, 120, 255, 1, "", 50063, NULL),
(50716, 181302, 1, 0, 0, 1, 1, 2574.597900390625, -482.55181884765625, 108.261383056640625, 5.009094715118408203, 0, 0, -0.59482288360595703, 0.80385679006576538, 120, 255, 1, "", 50063, NULL),
(50717, 181302, 1, 0, 0, 1, 1, 2575.6455078125, -484.4332275390625, 108.4585723876953125, 0.488691210746765136, 0, 0, 0.241921424865722656, 0.970295846462249755, 120, 255, 1, "", 50063, NULL),
(50718, 181302, 1, 0, 0, 1, 1, 2009.9051513671875, -2349.7607421875, 89.556732177734375, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50063, NULL),
(50719, 181302, 1, 0, 0, 1, 1, 2011.9859619140625, -2349.964111328125, 89.51378631591796875, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, "", 50063, NULL),
(50720, 181302, 1, 0, 0, 1, 1, 6315.9658203125, 513.4490966796875, 18.26840972900390625, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50721, 181302, 1, 0, 0, 1, 1, 6314.71337890625, 514.80938720703125, 18.350616455078125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50722, 181302, 1, 0, 0, 1, 1, -3441.65576171875, -4220.21728515625, 11.95842933654785156, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50723, 181302, 1, 0, 0, 1, 1, -1856.740478515625, 3050.81689453125, 1.226374983787536621, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50724, 181302, 1, 0, 0, 1, 1, -4577.140625, 419.06500244140625, 41.25206375122070312, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50725, 181302, 1, 0, 0, 1, 1, -5514.40087890625, -2289.927734375, -58.2692451477050781, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50726, 181302, 1, 0, 0, 1, 1, -284.4747314453125, -2659.440185546875, 93.31475067138671875, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50727, 181302, 1, 0, 0, 1, 1, -283.011566162109375, -2660.805419921875, 93.06735992431640625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50728, 181302, 1, 0, 0, 1, 1, 8707.9658203125, 969.35333251953125, 12.15101337432861328, 0.052358884364366531, 0, 0, 0.02617645263671875, 0.999657332897186279, 120, 255, 1, "", 50063, NULL),
(50729, 181302, 1, 0, 0, 1, 1, -3108.08056640625, -2729.659423828125, 34.179656982421875, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50730, 181302, 530, 0, 0, 1, 1, -518.07708740234375, 2333.610595703125, 38.07186508178710937, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50731, 181302, 530, 0, 0, 1, 1, -517.5279541015625, 2331.8837890625, 38.16144561767578125, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(50732, 181302, 0, 0, 0, 1, 1, -10343.7080078125, -3298.151123046875, 23.36631202697753906, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50733, 181302, 530, 0, 0, 1, 1, 39.07834243774414062, 2595.230224609375, 69.64998626708984375, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50734, 181302, 530, 0, 0, 1, 1, 211.9942169189453125, 7693.47216796875, 22.71973800659179687, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50735, 181302, 1, 0, 0, 1, 1, 951.623046875, 783.52728271484375, 104.5780792236328125, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50736, 181302, 0, 0, 0, 1, 1, 189.4441680908203125, -2123.916259765625, 103.5483169555664062, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50737, 181302, 0, 0, 0, 1, 1, -14372.9287109375, 126.7716522216796875, 2.307420015335083007, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50738, 181302, 0, 0, 0, 1, 1, -14373.0712890625, 126.9593124389648437, 1.083945035934448242, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50739, 181302, 0, 0, 0, 1, 1, -10651.2509765625, 1063.857666015625, 32.68108749389648437, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50742, 181302, 1, 0, 0, 1, 1, 9773.6064453125, 1010.7708740234375, 1299.1497802734375, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50744, 181302, 1, 0, 0, 1, 1, -6992.92822265625, 913.68304443359375, 9.485790252685546875, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50745, 181302, 0, 0, 0, 1, 1, -10941.7548828125, -3230.195556640625, 41.34749984741210937, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50746, 181302, 0, 0, 0, 1, 1, -6693.71923828125, -2205.78955078125, 249.2071990966796875, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50748, 181302, 0, 0, 0, 1, 1, -5424.63720703125, -494.8369140625, 397.65234375, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50749, 181302, 0, 0, 0, 1, 1, -5424.203125, -492.660552978515625, 397.424468994140625, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50751, 181302, 0, 0, 0, 1, 1, -5243.02197265625, -2899.205078125, 338.71588134765625, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50752, 181302, 0, 0, 0, 1, 1, -138.08544921875, -813.29840087890625, 55.23870468139648437, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50753, 181302, 0, 0, 0, 1, 1, -138.146163940429687, -811.3638916015625, 55.20621490478515625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50754, 181302, 1, 0, 0, 1, 1, 6851.73779296875, -4763.34130859375, 697.16241455078125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50755, 181302, 1, 0, 0, 1, 1, 6853.29541015625, -4762.12890625, 696.99151611328125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50756, 181302, 0, 0, 0, 1, 1, 592.0902099609375, 1354.6768798828125, 90.62839508056640625, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50757, 181302, 0, 0, 0, 1, 1, 590.7008056640625, 1354.4923095703125, 90.69004058837890625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50758, 181302, 0, 0, 0, 1, 1, -453.822662353515625, -4532.423828125, 8.681563377380371093, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50759, 181302, 0, 0, 0, 1, 1, -455.476959228515625, -4531.3603515625, 8.907967567443847656, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50760, 181302, 1, 0, 0, 1, 1, -53.1268997192382812, 1255.6981201171875, 90.29813385009765625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50761, 181302, 1, 0, 0, 1, 1, -3441.845947265625, -4218.458984375, 11.89546775817871093, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50762, 181302, 1, 0, 0, 1, 1, -1854.8939208984375, 3050.457763671875, 1.144623994827270507, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50763, 181302, 1, 0, 0, 1, 1, -4577.38671875, 420.683746337890625, 41.36140823364257812, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50764, 181302, 1, 0, 0, 1, 1, -5515.53125, -2287.79345703125, -58.4584426879882812, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50765, 181302, 1, 0, 0, 1, 1, 1900.6597900390625, -4349.32666015625, 22.39489173889160156, 3.316144466400146484, 0, 0, -0.99619388580322265, 0.087165042757987976, 120, 255, 1, "", 50063, NULL),
(50766, 181302, 1, 0, 0, 1, 1, -1010.711669921875, 303.13995361328125, 135.745941162109375, 2.792518377304077148, 0, 0, 0.984807014465332031, 0.173652306199073791, 120, 255, 1, "", 50063, NULL),
(50767, 181302, 0, 0, 0, 1, 1, -4695.07666015625, -1220.364990234375, 501.659393310546875, 2.809975385665893554, 0, 0, 0.986285209655761718, 0.165049895644187927, 120, 255, 1, "", 50063, NULL),
(50768, 181302, 0, 0, 0, 1, 1, -4696.18994140625, -1218.7703857421875, 501.659393310546875, 0, 0, 0, 0, 1, 120, 255, 1, "", 50063, NULL),
(50769, 181302, 530, 0, 0, 1, 1, -1737.1087646484375, 5338.857421875, -12.4281368255615234, 3.804818391799926757, 0, 0, -0.94551849365234375, 0.325568377971649169, 120, 255, 1, "", 50063, NULL),
(50770, 181302, 530, 0, 0, 1, 1, -1735.5203857421875, 5338.37890625, -12.4281396865844726, 5.654868602752685546, 0, 0, -0.30901622772216796, 0.95105677843093872, 120, 255, 1, "", 50063, NULL),
(50771, 181302, 530, 0, 0, 1, 1, -2548.390869140625, 4271.9326171875, 20.2852325439453125, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50772, 181302, 1, 0, 0, 1, 1, -52.3747291564941406, 1257.6920166015625, 90.33332061767578125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50773, 181302, 1, 0, 0, 1, 1, 1900.5989990234375, -4349.31103515625, 21.15878105163574218, 2.094393253326416015, 0, 0, 0.866024971008300781, 0.50000077486038208, 120, 255, 1, "", 50063, NULL),
(50774, 181302, 1, 0, 0, 1, 1, -1009.272216796875, 301.921783447265625, 135.745941162109375, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 120, 255, 1, "", 50063, NULL),
(50775, 181302, 0, 0, 0, 1, 1, -10344.0068359375, -3296.602783203125, 23.22263526916503906, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50776, 181302, 0, 0, 0, 1, 1, -611.89642333984375, -540.48101806640625, 36.48768997192382812, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50777, 181302, 0, 0, 0, 1, 1, -9422.9970703125, -2117.24609375, 66.69474029541015625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50778, 181302, 0, 0, 0, 1, 1, -14292.380859375, 49.81944656372070312, 0.975275993347167968, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50779, 181302, 0, 0, 0, 1, 1, -9423.2158203125, -2115.341064453125, 66.66082763671875, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50780, 181302, 0, 0, 0, 1, 1, 188.2904205322265625, -2122.624267578125, 103.8283233642578125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50781, 181302, 0, 0, 0, 1, 1, -14292.5947265625, 49.95388412475585937, 2.195329904556274414, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50782, 181302, 0, 0, 0, 1, 1, -3437.4853515625, -941.7491455078125, 10.39258861541748046, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50783, 181302, 0, 0, 0, 1, 1, -3439.7080078125, -941.54547119140625, 10.49172592163085937, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50786, 181302, 0, 0, 0, 1, 1, -1209.0203857421875, -2662.321533203125, 45.41328811645507812, 1.239183306694030761, 0, 0, 0.580702781677246093, 0.814115643501281738, 120, 255, 1, "", 50063, NULL),
(50787, 181302, 0, 0, 0, 1, 1, -1210.6712646484375, -2661.53173828125, 45.54581451416015625, 3.78736734390258789, 0, 0, -0.94832324981689453, 0.317305892705917358, 120, 255, 1, "", 50063, NULL),
(50788, 181302, 0, 0, 0, 1, 1, -10696.1767578125, -1158.826416015625, 24.94951629638671875, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50789, 181302, 0, 0, 0, 1, 1, -10693.701171875, -1157.4146728515625, 25.17403793334960937, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50790, 181302, 0, 0, 0, 1, 1, -1120.1900634765625, -3534.603271484375, 50.66500091552734375, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 120, 255, 1, "", 50063, NULL),
(50791, 181302, 0, 0, 0, 1, 1, -1119.7786865234375, -3536.68017578125, 50.57762908935546875, 1.815141916275024414, 0, 0, 0.788010597229003906, 0.615661680698394775, 120, 255, 1, "", 50063, NULL),
(50792, 181302, 0, 0, 0, 1, 1, -9385.02734375, 30.13802146911621093, 60.43758010864257812, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50793, 181302, 0, 0, 0, 1, 1, -7593.03125, -2078.29150390625, 126.080718994140625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50794, 181302, 0, 0, 0, 1, 1, 1805.8570556640625, 217.77886962890625, 60.44863510131835937, 0.24434557557106018, 0, 0, 0.121869087219238281, 0.9925462007522583, 120, 255, 1, "", 50063, NULL),
(50795, 181302, 530, 0, 0, 1, 1, 37.333984375, 2597.098388671875, 69.85308837890625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50796, 181302, 530, 0, 0, 1, 1, -1207.16796875, 7481.87158203125, 22.05276679992675781, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(50797, 181302, 530, 0, 0, 1, 1, -1206.1090087890625, 7480.60009765625, 21.97401237487792968, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(50798, 181302, 0, 0, 0, 1, 1, -4695.69384765625, -1219.4342041015625, 502.9093017578125, 0.750490784645080566, 0, 0, 0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 50063, NULL),
(50799, 181302, 530, 0, 0, 1, 1, 212.9035186767578125, 7691.8271484375, 22.55512809753417968, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, "", 50063, NULL),
(50800, 181302, 0, 0, 0, 1, 1, -611.0679931640625, -542.12774658203125, 36.56824874877929687, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50801, 181302, 0, 0, 0, 1, 1, -10652.57421875, 1062.9305419921875, 32.63768386840820312, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(50804, 181302, 0, 0, 0, 1, 1, -10939.88671875, -3228.94580078125, 41.34749984741210937, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50805, 181302, 0, 0, 0, 1, 1, -9382.9541015625, 29.57389259338378906, 60.63969039916992187, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50806, 181302, 0, 0, 0, 1, 1, -5242.26025390625, -2897.4521484375, 338.35699462890625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(50807, 181302, 530, 0, 0, 1, 1, -1740.585693359375, 5338.294921875, -12.4281377792358398, 2.199114561080932617, 0, 0, 0.8910064697265625, 0.453990638256072998, 120, 255, 1, "", 50063, NULL),
(50808, 181302, 530, 0, 0, 1, 1, -1736.650390625, 5338.845703125, -11.1850824356079101, 1.884953022003173828, 0, 0, 0.809016227722167968, 0.587786316871643066, 120, 255, 1, "", 50063, NULL),
(50809, 181302, 0, 0, 0, 1, 1, 1804.21484375, 217.8170623779296875, 60.42298126220703125, 1.588248729705810546, 0, 0, 0.713250160217285156, 0.700909554958343505, 120, 255, 1, "", 50063, NULL),
(70541, 181302, 530, 0, 0, 1, 1, -4224.0302734375, -12301.59765625, 4.066880226135253906, 6.248279094696044921, 0, 0, -0.01745223999023437, 0.999847710132598876, 120, 255, 1, "", 50063, NULL),
(70542, 181302, 530, 0, 0, 1, 1, -4225.60400390625, -12301.4873046875, 4.273456096649169921, 1.937312245368957519, 0, 0, 0.824125289916992187, 0.566407561302185058, 120, 255, 1, "", 50063, NULL),
(70574, 181302, 530, 0, 0, 1, 1, 2023.80078125, 6594.56591796875, 135.50128173828125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(70575, 181302, 530, 0, 0, 1, 1, 2021.78125, 6590.525390625, 135.2786865234375, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50172, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` = 181302) AND (`guid` BETWEEN 76183 AND 76243);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76183, 181302, 0, 0, 0, 1, 1, -6691.830078125, -2205.8203125, 249.2113189697265625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(76184, 181302, 0, 0, 0, 1, 1, -7593.26904296875, -2079.837158203125, 125.7967681884765625, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(76185, 181302, 0, 0, 0, 1, 1, -8833.4873046875, 878.150390625, 98.49544525146484375, 2.617989301681518554, 0, 0, 0.965925216674804687, 0.258821308612823486, 120, 255, 1, "", 50063, NULL),
(76186, 181302, 0, 0, 0, 1, 1, -8833.8818359375, 875.90313720703125, 98.54409027099609375, 5.532694816589355468, 0, 0, -0.3665008544921875, 0.93041771650314331, 120, 255, 1, "", 50063, NULL),
(76187, 181302, 0, 0, 0, 1, 1, -8836.9267578125, 866.6121826171875, 98.7047882080078125, 3.822272777557373046, 0, 0, -0.94264125823974609, 0.333807557821273803, 120, 255, 1, "", 50063, NULL),
(76188, 181302, 0, 0, 0, 1, 1, -8837.712890625, 865.33233642578125, 98.692413330078125, 0.453785061836242675, 0, 0, 0.224950790405273437, 0.974370121955871582, 120, 255, 1, "", 50063, NULL),
(76189, 181302, 1, 0, 0, 1, 1, -2324.091552734375, -613.20245361328125, -9.05979156494140625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(76190, 181302, 1, 0, 0, 1, 1, -2325.46240234375, -612.76788330078125, -8.91627311706542968, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(76191, 181302, 1, 0, 0, 1, 1, -4400.79150390625, 3469.044189453125, 11.76598072052001953, 4.694936752319335937, 0, 0, -0.71325016021728515, 0.700909554958343505, 120, 255, 1, "", 50063, NULL),
(76192, 181302, 1, 0, 0, 1, 1, -4405.50634765625, 3474.66015625, 12.44817543029785156, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76193, 181302, 530, 0, 0, 1, 1, -2237.229248046875, -11893.677734375, 27.14657020568847656, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76194, 181302, 530, 0, 0, 1, 1, -2238.056396484375, -11892.1162109375, 27.564239501953125, 1.989672422409057617, 0, 0, 0.838669776916503906, 0.544640243053436279, 120, 255, 1, "", 50063, NULL),
(76195, 181302, 530, 0, 0, 1, 1, -2516.2802734375, 7561.79345703125, -1.97192394733428955, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76196, 181302, 530, 0, 0, 1, 1, -2517.572509765625, 7560.88525390625, -1.99716496467590332, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76197, 181302, 530, 0, 0, 1, 1, -3007.27783203125, 4165.3095703125, 3.916898012161254882, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76198, 181302, 530, 0, 0, 1, 1, -3008.2734375, 4163.89501953125, 3.852447986602783203, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(76199, 181302, 530, 0, 0, 1, 1, -3060.705810546875, 2390.42138671875, 62.33280563354492187, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(76200, 181302, 530, 0, 0, 1, 1, -3062.057861328125, 2391.952392578125, 62.13649368286132812, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(76201, 181302, 530, 0, 0, 1, 1, -3798.819091796875, -11509.3642578125, -134.815994262695312, 2.862335443496704101, 0, 0, 0.990267753601074218, 0.139175355434417724, 120, 255, 1, "", 50063, NULL),
(76202, 181302, 530, 0, 0, 1, 1, -3799.016845703125, -11510.056640625, -133.567428588867187, 4.747295856475830078, 0, 0, -0.69465827941894531, 0.719339847564697265, 120, 255, 1, "", 50063, NULL),
(76203, 181302, 530, 0, 0, 1, 1, -3799.34716796875, -11510.98046875, -134.836044311523437, 5.410521507263183593, 0, 0, -0.42261791229248046, 0.906307935714721679, 120, 255, 1, "", 50063, NULL),
(76204, 181302, 530, 0, 0, 1, 1, -3951.089111328125, 2050.404296875, 95.06470489501953125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76205, 181302, 530, 0, 0, 1, 1, -3951.9375, 2052.20703125, 95.06470489501953125, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(76206, 181302, 530, 0, 0, 1, 1, 188.0206451416015625, 6012.25537109375, 23.58553695678710937, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(76207, 181302, 530, 0, 0, 1, 1, 188.9560546875, 6009.599609375, 23.90727615356445312, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76208, 181302, 530, 0, 0, 1, 1, 2924.20458984375, 3696.30419921875, 143.683746337890625, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50063, NULL),
(76209, 181302, 530, 0, 0, 1, 1, 2925.7958984375, 3695.99267578125, 143.7349853515625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50063, NULL),
(76210, 181302, 530, 0, 0, 1, 1, 3122.182861328125, 3736.185302734375, 142.1844635009765625, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50063, NULL),
(76211, 181302, 530, 0, 0, 1, 1, 3123.459228515625, 3737.779052734375, 141.9783172607421875, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50063, NULL),
(76212, 181302, 571, 0, 0, 1, 1, 2470.2919921875, -4902.30712890625, 264.212921142578125, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76213, 181302, 571, 0, 0, 1, 1, 2471.3037109375, -4900.357421875, 264.2857666015625, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76214, 181302, 571, 0, 0, 1, 1, 2589.153564453125, -4330.10205078125, 277.317535400390625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76215, 181302, 571, 0, 0, 1, 1, 2590.58984375, -4330.33251953125, 277.491729736328125, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76216, 181302, 571, 0, 0, 1, 1, 3365.486572265625, -2121.5673828125, 124.9821395874023437, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76217, 181302, 571, 0, 0, 1, 1, 3365.9140625, -2123.15673828125, 124.9776535034179687, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76218, 181302, 571, 0, 0, 1, 1, 3408.29052734375, -2894.600830078125, 201.691314697265625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76219, 181302, 571, 0, 0, 1, 1, 3409.72900390625, -2896.10205078125, 201.9228057861328125, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76220, 181302, 571, 0, 0, 1, 1, 3772.91796875, 1481.8626708984375, 92.1890411376953125, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76221, 181302, 571, 0, 0, 1, 1, 3774.033447265625, 1483.2371826171875, 92.03250885009765625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76222, 181302, 571, 0, 0, 1, 1, 3929.76611328125, -591.72247314453125, 241.3097686767578125, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76223, 181302, 571, 0, 0, 1, 1, 3931.06689453125, -589.9395751953125, 241.0223236083984375, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76224, 181302, 571, 0, 0, 1, 1, 4136.1474609375, 5388.24072265625, 26.362884521484375, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76225, 181302, 571, 0, 0, 1, 1, 4137.3837890625, 5390.54248046875, 26.72762298583984375, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76226, 181302, 571, 0, 0, 1, 1, 4462.52099609375, 5627.224609375, 57.96071243286132812, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76227, 181302, 571, 0, 0, 1, 1, 4462.57666015625, 5625.8603515625, 57.83119583129882812, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76228, 181302, 571, 0, 0, 1, 1, 5134.75634765625, -683.46221923828125, 170.7422637939453125, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76229, 181302, 571, 0, 0, 1, 1, 5136.64599609375, -684.31219482421875, 170.6110076904296875, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76230, 181302, 571, 0, 0, 1, 1, 5292.29150390625, -2768.984130859375, 292.3184814453125, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76231, 181302, 571, 0, 0, 1, 1, 5292.47509765625, -2770.343017578125, 292.301910400390625, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76232, 181302, 571, 0, 0, 1, 1, 5352.67041015625, 4832.91650390625, -195.247909545898437, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76233, 181302, 571, 0, 0, 1, 1, 5353.85009765625, 4834.48291015625, -195.45416259765625, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76234, 181302, 571, 0, 0, 1, 1, 5503.6865234375, 4878.72509765625, -198.073165893554687, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76235, 181302, 571, 0, 0, 1, 1, 5504.19091796875, 4877.22216796875, -197.989273071289062, 0.104719325900077819, 0, 0, 0.052335739135742187, 0.998629570007324218, 120, 255, 1, "", 50172, NULL),
(76236, 181302, 571, 0, 0, 1, 1, 5547.11865234375, -734.31097412109375, 150.57244873046875, 3.473210096359252929, 0, 0, -0.98628520965576171, 0.165049895644187927, 120, 255, 1, "", 50172, NULL),
(76237, 181302, 571, 0, 0, 1, 1, 5548.38525390625, -732.41241455078125, 150.8041839599609375, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL),
(76238, 181302, 571, 0, 0, 1, 1, 5627.58447265625, -2626.33447265625, 292.318511962890625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76239, 181302, 571, 0, 0, 1, 1, 5629.53173828125, -2624.82177734375, 292.085845947265625, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76240, 181302, 571, 0, 0, 1, 1, 6085.775390625, -1112.75537109375, 419.687652587890625, 0.610863447189331054, 0, 0, 0.3007049560546875, 0.953717231750488281, 120, 255, 1, "", 50172, NULL),
(76241, 181302, 571, 0, 0, 1, 1, 6087.263671875, -1111.9832763671875, 419.469146728515625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, "", 50172, NULL),
(76242, 181302, 571, 0, 0, 1, 1, 6147.53515625, -1034.9718017578125, 410.43841552734375, 3.473210096359252929, 0, 0, -0.98628520965576171, 0.165049895644187927, 120, 255, 1, "", 50172, NULL),
(76243, 181302, 571, 0, 0, 1, 1, 6147.54736328125, -1034.9752197265625, 409.2025146484375, 4.782202720642089843, 0, 0, -0.68199825286865234, 0.731353819370269775, 120, 255, 1, "", 50172, NULL);

-- remove duplicate spawns
DELETE FROM `gameobject` WHERE (`id` = 181302) AND (`guid` IN (50802, 50803, 50785, 50784, 50741, 50740, 50705, 50743, 50747, 50750, 50709, 50710));
DELETE FROM `gameobject_addon` WHERE (`guid` IN (50802, 50803, 50785, 50784, 50741, 50740, 50705, 50743, 50747, 50750, 50709, 50710));
DELETE FROM `game_event_gameobject` WHERE (`guid` IN (50802, 50803, 50785, 50784, 50741, 50740, 50705, 50743, 50747, 50750, 50709, 50710));

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 181302));
INSERT INTO `game_event_gameobject` (SELECT 1, `guid` FROM `gameobject` WHERE `id` = 181302);
