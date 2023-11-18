-- Update remaining gameobjects 'Horde Bonfire' with sniffed values
DELETE FROM `gameobject` WHERE ((`id` IN (187951, 187969, 187956, 187954, 187947, 187972, 187964, 187974, 187952, 187950, 187973, 187961, 187959, 187965, 187957, 187971, 187958, 187968, 187948, 187953, 187967, 187970, 187966, 187963, 187975, 187955, 187949, 187962, 187960, 194039, 194042, 194037, 194033, 194048, 194034, 194046, 194043)) AND (`guid` IN (76300, 76305, 76309, 76310, 76315, 76317, 76318, 76322, 76324, 76325, 76327, 76328, 76331, 76332, 76333, 76334, 76336, 76337, 76338, 76341, 76346, 76348, 76351, 76353, 76355, 76357, 76358, 76360, 76361, 76363, 76364, 76366, 76369, 76371, 76373, 76374, 76377)));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76300, 187951, 0, 0, 0, 1, 1, -14376.740234375, 115.921417236328125, 1.453197002410888671, 2.111847877502441406, 0, 0, 0.870355606079101562, 0.492423713207244873, 120, 255, 1, "", 50063, NULL),
(76305, 187969, 0, 0, 0, 1, 1, -10331.40234375, -3297.7294921875, 21.99922561645507812, 3.385940074920654296, 0, 0, -0.99254608154296875, 0.121869951486587524, 120, 255, 1, "", 50063, NULL),
(76309, 187956, 0, 0, 0, 1, 1, -7596.423828125, -2086.59716796875, 125.1703872680664062, 5.340708732604980468, 0, 0, -0.45398998260498046, 0.891006767749786376, 120, 255, 1, "", 50063, NULL),
(76310, 187954, 0, 0, 0, 1, 1, -6704.47900390625, -2200.9052734375, 248.60888671875, 0.017452461645007133, 0, 0, 0.008726119995117187, 0.999961912631988525, 120, 255, 1, "", 50063, NULL),
(76315, 187947, 0, 0, 0, 1, 1, -1134.839599609375, -3531.813720703125, 51.07191848754882812, 5.462882041931152343, 0, 0, -0.39874839782714843, 0.917060375213623046, 120, 255, 1, "", 50063, NULL),
(76317, 187972, 0, 0, 0, 1, 1, -447.94964599609375, -4527.65478515625, 8.595952987670898437, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50063, NULL),
(76318, 187964, 0, 0, 0, 1, 1, -134.6875, -802.76739501953125, 55.01473236083984375, 4.660029888153076171, 0, 0, -0.72537422180175781, 0.688354730606079101, 120, 255, 1, "", 50063, NULL),
(76322, 187974, 0, 0, 0, 1, 1, 2279.24853515625, 456.009124755859375, 33.86705398559570312, 0.366517573595046997, 0, 0, 0.182234764099121093, 0.98325502872467041, 120, 255, 1, "", 50063, NULL),
(76324, 187952, 1, 0, 0, 1, 1, -7122.50830078125, -3657.107177734375, 8.822018623352050781, 4.537858963012695312, 0, 0, -0.76604366302490234, 0.642788589000701904, 120, 255, 1, "", 50063, NULL),
(76325, 187950, 1, 0, 0, 1, 1, -7000.74658203125, 918.8507080078125, 9.174420356750488281, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 120, 255, 1, "", 50063, NULL),
(76327, 187973, 1, 0, 0, 1, 1, -5513.92919921875, -2299.72509765625, -58.0752029418945312, 2.44346022605895996, 0, 0, 0.939692497253417968, 0.34202045202255249, 120, 255, 1, "", 50063, NULL),
(76328, 187961, 1, 0, 0, 1, 1, -4573.216796875, 407.3878173828125, 41.54607009887695312, 2.460912704467773437, 0, 0, 0.942641258239746093, 0.333807557821273803, 120, 255, 1, "", 50063, NULL),
(76331, 187959, 1, 0, 0, 1, 1, -3110.585205078125, -2722.407958984375, 33.4626312255859375, 0.226892471313476562, 0, 0, 0.113203048706054687, 0.993571877479553222, 120, 255, 1, "", 50063, NULL),
(76332, 187965, 1, 0, 0, 1, 1, -2329.29345703125, -626.0457763671875, -8.81014633178710937, 2.984498262405395507, 0, 0, 0.996916770935058593, 0.078466430306434631, 120, 255, 1, "", 50063, NULL),
(76333, 187957, 1, 0, 0, 1, 1, -1862.357666015625, 3055.705810546875, 0.744157016277313232, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 120, 255, 1, "", 50063, NULL),
(76334, 187971, 1, 0, 0, 1, 1, -273.241912841796875, -2662.815673828125, 91.69503021240234375, 4.415683269500732421, 0, 0, -0.80385684967041015, 0.594822824001312255, 120, 255, 1, "", 50063, NULL),
(76336, 187958, 1, 0, 0, 1, 1, 145.5219268798828125, -4713.822265625, 18.12941932678222656, 3.752462387084960937, 0, 0, -0.95371627807617187, 0.300707906484603881, 120, 255, 1, "", 50172, NULL),
(76337, 187968, 1, 0, 0, 1, 1, 952.99151611328125, 776.96844482421875, 104.473663330078125, 4.729844093322753906, 0, 0, -0.70090866088867187, 0.713251054286956787, 120, 255, 1, "", 50063, NULL),
(76338, 187948, 1, 0, 0, 1, 1, 2014.6531982421875, -2337.838623046875, 89.5210723876953125, 2.373644113540649414, 0, 0, 0.927183151245117187, 0.37460830807685852, 120, 255, 1, "", 50063, NULL),
(76341, 187953, 1, 0, 0, 1, 1, 6855.98876953125, -4564.39501953125, 708.51025390625, 0.855210542678833007, 0, 0, 0.414692878723144531, 0.909961462020874023, 120, 255, 1, "", 50063, NULL),
(76346, 187967, 530, 0, 0, 1, 1, -3059.8564453125, 2382.93212890625, 62.57671356201171875, 3.595378875732421875, 0, 0, -0.97437000274658203, 0.224951311945915222, 120, 255, 1, "", 50063, NULL),
(76348, 187970, 530, 0, 0, 1, 1, -2554.093017578125, 4278.37939453125, 21.14415359497070312, 4.9218292236328125, 0, 0, -0.62932014465332031, 0.77714616060256958, 120, 255, 1, "", 50063, NULL),
(76351, 187966, 530, 0, 0, 1, 1, -1211.01220703125, 7474.44091796875, 21.99527359008789062, 4.258606910705566406, 0, 0, -0.84804725646972656, 0.529920578002929687, 120, 255, 1, "", 50063, NULL),
(76353, 187963, 530, 0, 0, 1, 1, 41.24479293823242187, 2587.4375, 68.3453369140625, 3.996806621551513671, 0, 0, -0.90996074676513671, 0.414694398641586303, 120, 255, 1, "", 50063, NULL),
(76355, 187975, 530, 0, 0, 1, 1, 200.899688720703125, 7686.9609375, 22.50795745849609375, 5.777040958404541015, 0, 0, -0.25037956237792968, 0.968147754669189453, 120, 255, 1, "", 50063, NULL),
(76357, 187955, 530, 0, 0, 1, 1, 2274.4208984375, 6133.03125, 136.958587646484375, 3.036838293075561523, 0, 0, 0.998628616333007812, 0.052353221923112869, 120, 255, 1, "", 50063, NULL),
(76358, 187949, 530, 0, 0, 1, 1, 2919.217041015625, 3683.2236328125, 143.6513519287109375, 2.984498262405395507, 0, 0, 0.996916770935058593, 0.078466430306434631, 120, 255, 1, "", 50063, NULL),
(76360, 187962, 530, 0, 0, 1, 1, 7693.533203125, -6836.5068359375, 77.787750244140625, 2.70525527000427246, 0, 0, 0.97629547119140625, 0.216442063450813293, 120, 255, 1, "", 50063, NULL),
(76361, 187960, 530, 0, 0, 1, 1, 9386.8642578125, -6772.23974609375, 14.41254901885986328, 3.368495941162109375, 0, 0, -0.99357128143310546, 0.113208353519439697, 120, 255, 1, "", 50063, NULL),
(76363, 194039, 571, 0, 0, 1, 1, 2578.66748046875, -4324.5068359375, 277.2557373046875, 2.234017848968505859, 0, 0, 0.898793220520019531, 0.438372820615768432, 120, 255, 1, "", 50172, NULL),
(76364, 194042, 571, 0, 0, 1, 1, 3365.578125, -2114.482666015625, 124.8540191650390625, 2.251473426818847656, 0, 0, 0.902585029602050781, 0.430511653423309326, 120, 255, 1, "", 50172, NULL),
(76366, 194037, 571, 0, 0, 1, 1, 3772.52734375, 1469.3385009765625, 92.500030517578125, 0.191985160112380981, 0, 0, 0.095845222473144531, 0.995396256446838378, 120, 255, 1, "", 50172, NULL),
(76369, 194033, 571, 0, 0, 1, 1, 4444.654296875, 5628.33544921875, 56.85396194458007812, 4.747295856475830078, 0, 0, -0.69465827941894531, 0.719339847564697265, 120, 255, 1, "", 50172, NULL),
(76371, 194048, 571, 0, 0, 1, 1, 5293.36328125, -2763.1416015625, 292.392852783203125, 1.343901276588439941, 0, 0, 0.622513771057128906, 0.78260880708694458, 120, 255, 1, "", 50172, NULL),
(76373, 194034, 571, 0, 0, 1, 1, 5501.63916015625, 4868.5537109375, -197.299774169921875, 1.710421562194824218, 0, 0, 0.754709243774414062, 0.656059443950653076, 120, 255, 1, "", 50172, NULL),
(76374, 194046, 571, 0, 0, 1, 1, 5545.45751953125, -743.87872314453125, 151.5795440673828125, 0.820303261280059814, 0, 0, 0.398748397827148437, 0.917060375213623046, 120, 255, 1, "", 50172, NULL),
(76377, 194043, 571, 0, 0, 1, 1, 6139.48779296875, -1029.7535400390625, 409.824493408203125, 2.216565132141113281, 0, 0, 0.894933700561523437, 0.44619917869567871, 120, 255, 1, "", 50172, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76300, 76305, 76309, 76310, 76315, 76317, 76318, 76322, 76324, 76325, 76327, 76328, 76331, 76332, 76333, 76334, 76336, 76337, 76338, 76341, 76346, 76348, 76351, 76353, 76355, 76357, 76358, 76360, 76361, 76363, 76364, 76366, 76369, 76371, 76373, 76374, 76377));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76300),
(1, 76305),
(1, 76309),
(1, 76310),
(1, 76315),
(1, 76317),
(1, 76318),
(1, 76322),
(1, 76324),
(1, 76325),
(1, 76327),
(1, 76328),
(1, 76331),
(1, 76332),
(1, 76333),
(1, 76334),
(1, 76336),
(1, 76337),
(1, 76338),
(1, 76341),
(1, 76346),
(1, 76348),
(1, 76351),
(1, 76353),
(1, 76355),
(1, 76357),
(1, 76358),
(1, 76360),
(1, 76361),
(1, 76363),
(1, 76364),
(1, 76366),
(1, 76369),
(1, 76371),
(1, 76373),
(1, 76374),
(1, 76377);
