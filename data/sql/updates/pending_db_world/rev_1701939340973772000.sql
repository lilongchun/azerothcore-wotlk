-- Update creature 16592 'Midsummer Bonfire' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 16592) AND (`guid` BETWEEN 245516 AND 245593);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(245516, 16592, 1, 1, 1, 0, 145.916778564453125, -4714.69775390625, 18.38191413879394531, 2.391098499298095703, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245517, 16592, 530, 1, 1, 0, 9386.7177734375, -6773.44091796875, 14.22725200653076171, 3.24634718894958496, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245518, 16592, 530, 1, 1, 0, -3060.775390625, 2381.893798828125, 63.15919876098632812, 4.48549652099609375, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245519, 16592, 530, 1, 1, 0, 2274.157470703125, 6134.12158203125, 136.9272308349609375, 0.174532130360603332, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245520, 16592, 0, 1, 1, 0, -10656.5439453125, 1054.6041259765625, 32.79294967651367187, 0.034906249493360519, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245521, 16592, 0, 1, 1, 0, 586.98175048828125, 1365.7059326171875, 90.92203521728515625, 0.069811686873435974, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245522, 16592, 530, 1, 1, 0, 199.9662017822265625, 7687.50341796875, 22.49229240417480468, 0.837757468223571777, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245523, 16592, 1, 1, 1, 0, -5514.533203125, -2299.75732421875, -57.9711036682128906, 3.996806621551513671, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245524, 16592, 0, 1, 1, 0, -448.11773681640625, -4527.07763671875, 8.961462020874023437, 0.017452461645007133, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245525, 16592, 1, 1, 1, 0, -272.763092041015625, -2662.675048828125, 91.773773193359375, 0.575957298278808593, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245526, 16592, 530, 1, 1, 0, -2551.4462890625, 4278.5283203125, 21.15038681030273437, 2.914689540863037109, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245527, 16592, 0, 1, 1, 0, -10331.623046875, -3296.45361328125, 22.14905929565429687, 2.70525527000427246, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245528, 16592, 1, 1, 1, 0, 952.05145263671875, 777.0345458984375, 104.647308349609375, 0.680676698684692382, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245529, 16592, 530, 1, 1, 0, -1212.4935302734375, 7474.21875, 22.28429985046386718, 0.907570242881774902, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245530, 16592, 0, 1, 1, 0, -136.823837280273437, -802.02899169921875, 55.32352447509765625, 3.106652259826660156, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245531, 16592, 530, 1, 1, 0, 40.89176559448242187, 2587.139892578125, 68.74556732177734375, 3.473210096359252929, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245532, 16592, 1, 1, 1, 0, -4573.11083984375, 406.873443603515625, 41.78923797607421875, 4.607671737670898437, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245533, 16592, 1, 1, 1, 0, -3111.786376953125, -2722.33203125, 33.75668716430664062, 2.059488296508789062, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245534, 16592, 1, 1, 1, 0, -1862.60791015625, 3057.559326171875, 1.111593365669250488, 1.745326757431030273, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245535, 16592, 0, 1, 1, 0, -7597.26904296875, -2086.233154296875, 125.6711883544921875, 0.087265998125076293, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245536, 16592, 0, 1, 1, 0, -6705.1865234375, -2200.865478515625, 249.07415771484375, 5.340708732604980468, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245537, 16592, 1, 1, 1, 0, 6855.74658203125, -4564.0400390625, 708.31890869140625, 1.762782454490661621, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245538, 16592, 1, 1, 1, 0, -7122.5107421875, -3656.338623046875, 9.051293373107910156, 5.585053920745849609, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245539, 16592, 1, 1, 1, 0, -4399.86865234375, 3484.504150390625, 12.15812969207763671, 2.827429771423339843, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245540, 16592, 0, 1, 1, 0, -14375.48046875, 115.6075820922851562, 1.52611541748046875, 1.012289404869079589, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245541, 16592, 1, 1, 1, 0, 2013.0853271484375, -2337.64453125, 89.61811065673828125, 1.815141916275024414, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245542, 16592, 0, 1, 1, 0, -1135.5833740234375, -3533.072265625, 51.23150253295898437, 5.567600727081298828, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245543, 16592, 1, 1, 1, 0, 6859.69384765625, -4767.05126953125, 696.77679443359375, 6.14356088638305664, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245544, 16592, 0, 1, 1, 0, 2278.525390625, 455.55572509765625, 33.95226287841796875, 3.857182979583740234, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245545, 16592, 1, 1, 1, 0, -7216.5380859375, -3859.864501953125, 12.02181816101074218, 2.495818138122558593, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245546, 16592, 0, 1, 1, 0, -8249.6357421875, -2625.521728515625, 133.23797607421875, 1.535889506340026855, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245547, 16592, 0, 1, 1, 0, -14287.6923828125, 61.64371871948242187, 0.738448321819305419, 1.448621988296508789, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245548, 16592, 0, 1, 1, 0, -3447.870849609375, -938.64874267578125, 11.2162017822265625, 5.35816192626953125, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245549, 16592, 0, 1, 1, 0, 187.5908203125, -2133.545654296875, 102.6650924682617187, 2.059488296508789062, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245550, 16592, 1, 1, 1, 0, 9779.0751953125, 1019.38067626953125, 1299.84765625, 2.094393253326416015, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245551, 16592, 0, 1, 1, 0, -9434.6865234375, -2112.268798828125, 66.20378875732421875, 2.530723094940185546, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245552, 16592, 0, 1, 1, 0, -5232.7216796875, -2892.514892578125, 337.428863525390625, 1.169368624687194824, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245553, 16592, 0, 1, 1, 0, -604.142333984375, -546.3038330078125, 36.96920013427734375, 3.45575571060180664, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245554, 16592, 530, 1, 1, 0, -528.31243896484375, 2338.848876953125, 38.3249969482421875, 2.495818138122558593, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245555, 16592, 0, 1, 1, 0, -9395.203125, 36.63313674926757812, 60.35406494140625, 1.797688722610473632, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245556, 16592, 1, 1, 1, 0, -3447.779541015625, -4231.98779296875, 10.87920570373535156, 3.106652259826660156, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245557, 16592, 0, 1, 1, 0, -10704.921875, -1147.2996826171875, 25.34437179565429687, 3.473210096359252929, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245558, 16592, 0, 1, 1, 0, -5405.1416015625, -494.3575439453125, 395.710693359375, 5.95157480239868164, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245559, 16592, 1, 1, 1, 0, -56.1942291259765625, 1270.76416015625, 92.0386962890625, 1.431168079376220703, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245560, 16592, 1, 1, 1, 0, 6327.6171875, 512.52862548828125, 17.92884635925292968, 5.637413978576660156, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245561, 16592, 0, 1, 1, 0, -10952.7216796875, -3217.3857421875, 41.4308319091796875, 0.767943859100341796, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245562, 16592, 1, 1, 1, 0, 2558.200439453125, -481.0625, 109.9471282958984375, 3.159062385559082031, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245563, 16592, 0, 1, 1, 0, -1210.7864990234375, -2676.7001953125, 45.41153335571289062, 2.583080768585205078, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245564, 16592, 1, 1, 1, 0, -7001.24169921875, 919.96160888671875, 9.546342849731445312, 3.804818391799926757, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245565, 16592, 1, 1, 1, 0, -6770.11083984375, 525.7042236328125, -1.3172006607055664, 1.989672422409057617, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245566, 16592, 530, 1, 1, 0, -3943.61376953125, 2048.630859375, 95.148040771484375, 0.349065244197845458, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245567, 16592, 1, 1, 1, 0, -2328.41162109375, -626.94317626953125, -8.34361457824707031, 1.623155713081359863, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245568, 16592, 530, 1, 1, 0, 7693.4853515625, -6835.501953125, 78.22252655029296875, 1.884953022003173828, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245569, 16592, 530, 1, 1, 0, -2526.055908203125, 7551.6875, -2.03577876091003417, 3.560472726821899414, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245570, 16592, 530, 1, 1, 0, 189.0967864990234375, 6025.34521484375, 21.67785453796386718, 4.904376029968261718, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245571, 16592, 530, 1, 1, 0, 2918.384521484375, 3684.14794921875, 144.219390869140625, 1.204277276992797851, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245572, 16592, 571, 1, 1, 0, 2481.064208984375, -4891.0986328125, 265.14501953125, 1.256635904312133789, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245573, 16592, 571, 1, 1, 0, 2579.251220703125, -4324.40478515625, 277.12158203125, 5.462882041931152343, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245574, 16592, 571, 1, 1, 0, 3365.452392578125, -2114.502685546875, 124.7376861572265625, 4.258606910705566406, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245575, 16592, 571, 1, 1, 0, 3395.3291015625, -2904.51904296875, 202.5421905517578125, 0.663223206996917724, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245576, 16592, 571, 1, 1, 0, 5293.3359375, -2763.234375, 292.47247314453125, 4.014260292053222656, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245577, 16592, 571, 1, 1, 0, 5637.01611328125, -2623.542236328125, 292.501861572265625, 3.839725255966186523, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245578, 16592, 571, 1, 1, 0, 6073.76806640625, -1106.42138671875, 419.860595703125, 5.393068790435791015, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245579, 16592, 571, 1, 1, 0, 6139.87158203125, -1030.05712890625, 409.601409912109375, 1.867502212524414062, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245580, 16592, 571, 1, 1, 0, 5501.9072265625, 4868.2822265625, -197.2171630859375, 2.460912704467773437, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245581, 16592, 571, 1, 1, 0, 5363.4150390625, 4843.72802734375, -196.66015625, 1.780233979225158691, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245582, 16592, 571, 1, 1, 0, 4445.5615234375, 5629.24853515625, 56.83461380004882812, 6.248279094696044921, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245583, 16592, 571, 1, 1, 0, 4122.58837890625, 5386.77587890625, 28.15221214294433593, 4.625123500823974609, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245584, 16592, 571, 1, 1, 0, 3773.42578125, 1469.0816650390625, 92.29988861083984375, 4.834563255310058593, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245585, 16592, 571, 1, 1, 0, 3935.1484375, -583.552978515625, 240.5520782470703125, 1.151916384696960449, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245586, 16592, 571, 1, 1, 0, 5137.04541015625, -669.70587158203125, 170.7673492431640625, 5.183629035949707031, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245587, 16592, 571, 1, 1, 0, 5546.423828125, -743.42510986328125, 151.27398681640625, 5.619962215423583984, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245588, 16592, 530, 1, 1, 0, 3121.425048828125, 3750.2109375, 142.035186767578125, 5.340708732604980468, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245589, 16592, 530, 1, 1, 0, 2020.990478515625, 6580.7685546875, 134.45458984375, 0.733038187026977539, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(245590, 16592, 530, 1, 1, 0, -2246.841064453125, -11898.7138671875, 26.91518402099609375, 6.073746204376220703, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245591, 16592, 530, 1, 1, 0, -2999.180908203125, 4154.74462890625, 4.692128658294677734, 2.094393253326416015, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245592, 16592, 0, 1, 1, 0, 999.03448486328125, -1453.9659423828125, 61.13034820556640625, 5.044002056121826171, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(245593, 16592, 530, 1, 1, 0, -4223.341796875, -12318.29296875, 2.654066324234008789, 3.24634718894958496, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL);

DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` BETWEEN 245516 AND 245593);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(1, 245516),
(1, 245517),
(1, 245518),
(1, 245519),
(1, 245520),
(1, 245521),
(1, 245522),
(1, 245523),
(1, 245524),
(1, 245525),
(1, 245526),
(1, 245527),
(1, 245528),
(1, 245529),
(1, 245530),
(1, 245531),
(1, 245532),
(1, 245533),
(1, 245534),
(1, 245535),
(1, 245536),
(1, 245537),
(1, 245538),
(1, 245539),
(1, 245540),
(1, 245541),
(1, 245542),
(1, 245543),
(1, 245544),
(1, 245545),
(1, 245546),
(1, 245547),
(1, 245548),
(1, 245549),
(1, 245550),
(1, 245551),
(1, 245552),
(1, 245553),
(1, 245554),
(1, 245555),
(1, 245556),
(1, 245557),
(1, 245558),
(1, 245559),
(1, 245560),
(1, 245561),
(1, 245562),
(1, 245563),
(1, 245564),
(1, 245565),
(1, 245566),
(1, 245567),
(1, 245568),
(1, 245569),
(1, 245570),
(1, 245571),
(1, 245572),
(1, 245573),
(1, 245574),
(1, 245575),
(1, 245576),
(1, 245577),
(1, 245578),
(1, 245579),
(1, 245580),
(1, 245581),
(1, 245582),
(1, 245583),
(1, 245584),
(1, 245585),
(1, 245586),
(1, 245587),
(1, 245588),
(1, 245589),
(1, 245590),
(1, 245591),
(1, 245592),
(1, 245593);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 16592) AND (`guid` BETWEEN 12584 AND 12594);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12584, 16592, 0, 1, 1, 0, -4700.27587890625, -1224.3353271484375, 501.74267578125, 4.136432647705078125, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12585, 16592, 0, 1, 1, 0, -8837.037109375, 857.65673828125, 98.859619140625, 4.206246376037597656, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12586, 16592, 0, 1, 1, 0, 1822.271240234375, 218.638946533203125, 59.97574615478515625, 6.248279094696044921, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12587, 16592, 1, 1, 1, 0, -1037.529541015625, 292.720489501953125, 135.828277587890625, 2.827429771423339843, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(12588, 16592, 1, 1, 1, 0, 1911.6729736328125, -4338.283203125, 21.15378761291503906, 6.073746204376220703, 120, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(12589, 16592, 1, 1, 1, 0, 8700.212890625, 931.42156982421875, 14.90633296966552734, 1.675513744354248046, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12590, 16592, 530, 1, 1, 0, -1747.8482666015625, 5326.28515625, -12.3448028564453125, 3.263772249221801757, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12591, 16592, 530, 1, 1, 0, -3793.8955078125, -11503.70703125, -134.6624755859375, 4.101525306701660156, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12592, 16592, 530, 1, 1, 0, 9805.880859375, -7239.91015625, 26.134552001953125, 3.176533222198486328, 120, 0,  0, 0, 0, 0, "", 50063, 1, NULL),
(12593, 16592, 547, 3, 1, 0, -114.745880126953125, -117.226593017578125, -2.44469881057739257, 1.169368624687194824, 7200, 0,  0, 0, 0, 0, "", 50172, 1, NULL),
(12594, 16592, 547, 3, 1, 0, -89.8604965209960937, -113.449333190917968, -2.3303837776184082, 2.617989301681518554, 7200, 0,  0, 0, 0, 0, "", 50172, 1, NULL);

DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` BETWEEN 12584 AND 12594);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(1, 12584),
(1, 12585),
(1, 12586),
(1, 12587),
(1, 12588),
(1, 12589),
(1, 12590),
(1, 12591),
(1, 12592),
(1, 12593),
(1, 12594);
