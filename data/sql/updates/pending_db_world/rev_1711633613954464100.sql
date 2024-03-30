-- Update gameobject 'Forge' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (194468, 173063, 2575, 19902, 179924, 1749, 21679, 34571, 173095, 173064, 144133, 153459, 20738, 147285, 4090, 56897, 138317, 20986, 23304, 23305, 24745, 24746, 34572, 38491, 202392, 202393, 202391, 202394, 186556, 2728, 2727, 51949, 169969, 2573, 1797, 1896, 141838, 141841, 184617, 182056, 3223, 183818, 181716, 181990, 182117, 182278, 182860, 183121, 183148, 183345, 183347, 183408, 183484, 183757, 183758, 183759, 183760, 183782, 184286, 184922, 184923, 181884, 184146, 187112, 186139, 184687, 17190, 175144, 182270, 186138, 130668, 175851, 186141, 1685, 1743, 52175, 52176, 113754, 148960, 181130, 179886, 176509, 50831, 92490, 179863, 180913, 171716, 171717, 192020, 186654, 190495, 188452, 190765, 190524, 192831, 186433, 192583, 188250, 188257, 191346, 186486, 187256, 194487, 188607, 188354, 188356, 188624, 188651, 188396, 190457, 187388, 192062, 191287, 191288, 192572, 192573, 191508, 186653, 191237, 191505, 179844, 152034, 152042, 152045, 193126, 186231, 186630, 194128, 176895, 142078))
AND (`guid` IN (100431, 10054, 10118, 10826, 10828, 1091, 11000, 1126, 11324, 11598, 11819, 12642, 12687, 12799, 13139, 13261, 13306, 13360, 13766, 13813, 13814, 13968, 13970, 14273, 14352, 14796, 150251, 150275, 150281, 150283, 151208, 15217, 15396, 15728, 15733, 16626, 17011, 17014, 17141, 17240, 17252, 17426, 18568, 20494, 20562, 20709, 22227, 22401, 22525, 22762, 23671, 24009, 24036, 24217, 24219, 24317, 24377, 24587, 24588, 24589, 24590, 24647, 25118, 25827, 25828, 26791, 27148, 27638, 27811, 28273, 29723, 30166, 30172, 30402, 30816, 32298, 32655, 32779, 34300, 387, 44762, 44871, 44916, 44917, 44949, 45334, 45606, 45689, 46082, 46161, 4623, 467, 47586, 47603, 48632, 49092, 49393, 49803, 5258, 5430, 55964, 56459, 56480, 56654, 56955, 57486, 57539, 57574, 57733, 58133, 58300, 59043, 59092, 59113, 59403, 59623, 59624, 60255, 60307, 60317, 60512, 61116, 61125, 61538, 61660, 62356, 63130, 63131, 63132, 63133, 63185, 65329, 65868, 65884, 66110, 66396, 66401, 6880, 6881, 6927, 6935, 71405, 7561, 7591, 77189, 82, 8821, 95, 9937));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(100431, 194468, 530, 0, 0, 1, 1, -2133.075927734375, 5371.8505859375, 53.80774307250976562, 2.286378860473632812, 0, 0, 0.909960746765136718, 0.414694398641586303, 120, 255, 1, "", 45942, NULL),
(10054, 173063, 1, 0, 0, 1, 1, 2021.614990234375, -4688.12939453125, 25.40483283996582031, 2.426007747650146484, 0, 0, 0.936672210693359375, 0.350207358598709106, 120, 255, 1, "", 45435, NULL),
(10118, 2575, 0, 0, 0, 1, 1, -14378.8134765625, 379.263885498046875, 23.31351470947265625, 4.145159721374511718, 0, 0, -0.87672615051269531, 0.48098987340927124, 120, 255, 1, "", 45572, NULL),
(10826, 19902, 0, 0, 0, 1, 1, -6763.6630859375, -3125.5087890625, 242.098419189453125, 1.343902826309204101, 0.042108535766601562, -0.03894233703613281, 0.621876716613769531, 0.781011998653411865, 120, 255, 1, "", 45613, NULL),
(10828, 179924, 0, 0, 0, 1, 1, -6670.96337890625, -2155.569580078125, 243.8922576904296875, 4.886921405792236328, 0, 0, -0.64278793334960937, 0.766044199466705322, 120, 255, 1, "", 45613, NULL),
(1091, 1749, 0, 0, 0, 1, 1, -5579.0400390625, -428.92535400390625, 397.214263916015625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45613, NULL),
(11000, 21679, 0, 0, 0, 1, 1, -14380.5419921875, 371.746826171875, 23.94536018371582031, 1.893682122230529785, 0, 0, 0.811573982238769531, 0.584249675273895263, 120, 255, 1, "", 45572, NULL),
(1126, 34571, 0, 0, 0, 1, 1, -5579.162109375, -435.338470458984375, 397.60888671875, 4.712389945983886718, 0, 0, -0.70710659027099609, 0.707106947898864746, 120, 255, 1, "", 45613, NULL),
(11324, 173095, 1, 0, 0, 1, 1, 2051.62890625, -4838.9736328125, 24.58019256591796875, 3.735006093978881835, 0, 0, -0.95630455017089843, 0.292372345924377441, 120, 255, 1, "", 45435, NULL),
(11598, 173064, 1, 0, 0, 1, 1, 2048.722412109375, -4812.20654296875, 22.65833473205566406, 3.735006093978881835, 0, 0, -0.95630455017089843, 0.292372345924377441, 120, 255, 1, "", 45435, NULL),
(11819, 144133, 0, 0, 0, 1, 1, -5340.11083984375, -2940.55078125, 323.762451171875, 1.823866248130798339, -0.05446863174438476, -0.08452987670898437, 0.786145210266113281, 0.609806180000305175, 120, 255, 1, "", 45613, NULL),
(12642, 153459, 0, 0, 0, 1, 1, -10894.9189453125, -3185.491455078125, 49.57025527954101562, 1.856318235397338867, 0, 0, 0.800518035888671875, 0.599308669567108154, 120, 255, 1, "", 45772, NULL),
(12687, 20738, 1, 0, 0, 1, 1, 787.8443603515625, -1821.4989013671875, 91.5555572509765625, 0.095991745591163635, 0, 0, 0.047977447509765625, 0.998848438262939453, 120, 255, 1, "", 45435, NULL),
(12799, 147285, 0, 0, 0, 1, 1, -10950.888671875, -3456.81640625, 64.95444488525390625, 2.570527553558349609, 0, 0, 0.959511756896972656, 0.28166857361793518, 120, 255, 1, "", 48632, NULL),
(13139, 4090, 530, 0, 0, 1, 1, -2976.90234375, 4027.7607421875, 1.764023303985595703, 5.619962215423583984, 0, 0, -0.32556724548339843, 0.945518851280212402, 120, 255, 1, "", 45704, NULL),
(13261, 56897, 1, 0, 0, 1, 1, -1068.0462646484375, -3534.879638671875, 64.31089019775390625, 1.247910022735595703, 0, 0, 0.584249496459960937, 0.811574101448059082, 120, 255, 1, "", 45435, NULL),
(13306, 138317, 1, 0, 0, 1, 1, -2287.17529296875, -1943.8035888671875, 95.7456817626953125, 6.073746204376220703, 0, 0, -0.10452842712402343, 0.994521915912628173, 120, 255, 1, "", 45435, NULL),
(13360, 147285, 1, 0, 0, 1, 1, -1996.5625, -3608.458984375, 21.75933074951171875, 3.630291461944580078, 0, 0, -0.97029495239257812, 0.241925001144409179, 120, 255, 1, "", 45435, NULL),
(13766, 20986, 0, 0, 0, 1, 1, -3794.984375, -862.1007080078125, 11.59808254241943359, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46902, NULL),
(13813, 23304, 0, 0, 0, 1, 1, -8421.3154296875, 613.4404296875, 95.18099212646484375, 3.81354522705078125, 0, 0, -0.94408893585205078, 0.329690933227539062, 120, 255, 1, "", 45613, NULL),
(13814, 23305, 0, 0, 0, 1, 1, -8425.16015625, 618.067138671875, 95.38744354248046875, 3.81354522705078125, 0, 0, -0.94408893585205078, 0.329690933227539062, 120, 255, 1, "", 45613, NULL),
(13968, 24745, 0, 0, 0, 1, 1, -8420.0986328125, 633.51885986328125, 95.6527099609375, 3.81354522705078125, 0, 0, -0.94408893585205078, 0.329690933227539062, 120, 255, 1, "", 45613, NULL),
(13970, 24746, 0, 0, 0, 1, 1, -8427.1025390625, 631.1102294921875, 95.631072998046875, 2.234022140502929687, 0, 0, 0.898794174194335937, 0.438370853662490844, 120, 255, 1, "", 45613, NULL),
(14273, 34572, 0, 0, 0, 1, 1, -2603.527099609375, -2284.218017578125, 86.29964447021484375, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 120, 255, 1, "", 49822, NULL),
(14352, 4090, 0, 0, 0, 1, 1, -3792.044921875, -865.609375, 9.787861824035644531, 0.741763234138488769, 0, 0, 0.362437248229980468, 0.932008147239685058, 120, 255, 1, "", 46902, NULL),
(14796, 38491, 0, 0, 0, 1, 1, -10594.263671875, -1159.22265625, 28.24942779541015625, 5.724681377410888671, 0, 0, -0.27563667297363281, 0.961261868476867675, 120, 255, 1, "", 45613, NULL),
(150251, 202392, 658, 0, 0, 3, 1, 878.23956298828125, 24.69965362548828125, 498.51959228515625, 1.553341388702392578, 0, 0, 0.700908660888671875, 0.713251054286956787, 7200, 255, 1, "", 51666, NULL),
(150275, 202393, 658, 0, 0, 3, 1, 728, -122.15625, 491.925933837890625, 1.535886883735656738, 0, 0, 0.694657325744628906, 0.719340801239013671, 7200, 255, 1, "", 51666, NULL),
(150281, 202391, 658, 0, 0, 3, 1, 855.27777099609375, 68.93402862548828125, 498.538848876953125, 1.300268411636352539, 0, 0, 0.60529327392578125, 0.796002507209777832, 7200, 255, 1, "", 51666, NULL),
(150283, 202394, 658, 0, 0, 3, 1, 661.19964599609375, -121.932289123535156, 491.615386962890625, 1.535886883735656738, 0, 0, 0.694657325744628906, 0.719340801239013671, 7200, 255, 1, "", 51666, NULL),
(151208, 186556, 571, 0, 0, 1, 1, 2426.829833984375, -5083.95849609375, 272.943023681640625, 0.270525157451629638, 0, 0, 0.134850502014160156, 0.990865945816040039, 120, 255, 1, "", 46158, NULL),
(15217, 2728, 0, 0, 0, 1, 1, -1252.359375, -2548.46875, 21.37276458740234375, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46902, NULL),
(15396, 2727, 0, 0, 0, 1, 1, -936.98773193359375, -3482.45458984375, 51.4742889404296875, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45572, NULL),
(15728, 51949, 1, 0, 0, 1, 1, -426.52789306640625, -3162.13427734375, 212.420684814453125, 2.923411369323730468, -0.03230953216552734, 0.025470733642578125, 0.993130683898925781, 0.109538912773132324, 120, 255, 1, "", 45435, NULL),
(15733, 169969, 1, 0, 0, 1, 1, -923.12451171875, -3686.859375, 8.161623954772949218, 4.075345039367675781, 0, 0, -0.89297866821289062, 0.450098991394042968, 120, 255, 1, "", 45435, NULL),
(16626, 147285, 530, 0, 0, 1, 1, -714.12109375, 2603.4951171875, 89.20101165771484375, 1.300268411636352539, 0, 0, 0.60529327392578125, 0.796002507209777832, 120, 255, 1, "", 45854, NULL),
(17011, 2573, 0, 0, 0, 1, 1, -574.515625, 45.43229293823242187, 49.8842926025390625, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 46368, NULL),
(17014, 1797, 0, 0, 0, 1, 1, -550.33856201171875, -1437.0208740234375, 52.44382858276367187, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45854, NULL),
(17141, 1896, 0, 0, 0, 1, 1, -819.25152587890625, -571.79296875, 15.31679153442382812, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45942, NULL),
(17240, 141838, 1, 0, 0, 1, 1, -7199.05419921875, -3766.189208984375, 8.659154891967773437, 2.696528911590576171, 0, 0, 0.975341796875, 0.220699742436408996, 120, 255, 1, "", 45572, NULL),
(17252, 141841, 1, 0, 0, 1, 1, -7390.02978515625, -4724.98876953125, 8.988080024719238281, 4.040439605712890625, 0, 0, -0.90069770812988281, 0.434446364641189575, 120, 255, 1, "", 45772, NULL),
(17426, 184617, 0, 0, 0, 1, 1, -160.125, -866.33380126953125, 56.50273513793945312, 2.792520999908447265, -0.03234386444091796, -0.00758171081542968, 0.984333038330078125, 0.173161461949348449, 120, 255, 1, "", 45572, NULL),
(18568, 4090, 0, 0, 0, 1, 1, -571.947265625, 39.94140625, 48.07407760620117187, 5.654868602752685546, 0, 0, -0.30901622772216796, 0.95105677843093872, 120, 255, 1, "", 46368, NULL),
(20494, 182056, 530, 0, 0, 1, 1, -1935.828125, -11912.1845703125, 48.0586395263671875, 5.907940864562988281, 0, 0, -0.1865234375, 0.982450485229492187, 120, 255, 1, "", 46158, NULL),
(20562, 3223, 1, 0, 0, 1, 1, -1886.951416015625, -1093.63720703125, 90.000457763671875, 2.740160465240478515, -0.03085994720458984, -0.02042579650878906, 0.979389190673828125, 0.198563039302825927, 120, 255, 1, "", 46368, NULL),
(20709, 183818, 530, 0, 0, 1, 1, 249.648651123046875, 6030.2138671875, 131.5974884033203125, 2.827429771423339843, 0, 0, 0.987688064575195312, 0.156436234712600708, 120, 255, 1, "", 45704, NULL),
(22227, 181716, 530, 0, 0, 1, 1, -4727.85791015625, -12387.09375, 11.0831146240234375, 3.262326002120971679, 0, 0, -0.99817848205566406, 0.060329910367727279, 120, 255, 1, "", 45942, NULL),
(22401, 181990, 530, 0, 0, 1, 1, 8677.5595703125, -6606.2431640625, 70.25475311279296875, 3.534291028976440429, 0, 0, -0.98078536987304687, 0.195089906454086303, 120, 255, 1, "", 45854, NULL),
(22525, 182117, 530, 0, 0, 1, 1, -2649.286376953125, 4441.5537109375, 36.73196029663085937, 3.351046562194824218, 0, 0, -0.99452114105224609, 0.104535527527332305, 120, 255, 1, "", 45704, NULL),
(22762, 182278, 530, 0, 0, 1, 1, -4186.52099609375, -12440.0107421875, 43.38792800903320312, 3.063024282455444335, 0, 0, 0.999228477478027343, 0.039274025708436965, 120, 255, 1, "", 45435, NULL),
(23671, 182860, 530, 0, 0, 1, 1, 173.7569427490234375, 4296.73193359375, 117.1742477416992187, 4.773476600646972656, 0, 0, -0.68518257141113281, 0.728371381759643554, 120, 255, 1, "", 48632, NULL),
(24009, 183121, 530, 0, 0, 1, 1, 216.3246612548828125, 7859.2802734375, 23.9654388427734375, 1.745326757431030273, 0, 0, 0.766043663024902343, 0.642788589000701904, 120, 255, 1, "", 45942, NULL),
(24036, 183148, 530, 0, 0, 1, 1, -1329.3367919921875, 7198.845703125, 34.24901962280273437, 3.141592741012573242, 0, 0, -1, 0, 120, 255, 1, "", 45704, NULL),
(24217, 183345, 530, 0, 0, 1, 1, 323.560760498046875, 7838.1708984375, 21.79891395568847656, 4.022988319396972656, 0, 0, -0.90445423126220703, 0.426570683717727661, 120, 255, 1, "", 45942, NULL),
(24219, 183347, 530, 0, 0, 1, 1, 189.00347900390625, 2671.132080078125, 88.7217864990234375, 2.474651098251342773, 0, 0, 0.944911956787109375, 0.327324569225311279, 120, 255, 1, "", 45704, NULL),
(24317, 183408, 530, 0, 0, 1, 1, 2544.48095703125, 6512.921875, 3.469935894012451171, 1.173768043518066406, 0, 0, 0.553769111633300781, 0.832670271396636962, 120, 255, 1, "", 45704, NULL),
(24377, 183484, 530, 0, 0, 1, 1, 2330.126708984375, 6059.69091796875, 142.1997222900390625, 1.308995485305786132, 0, 0, 0.608760833740234375, 0.793353796005249023, 120, 255, 1, "", 45704, NULL),
(24587, 183757, 530, 0, 0, 1, 1, 9846.5849609375, -7361.634765625, 19.392669677734375, 4.450565338134765625, 0, 0, -0.79336071014404296, 0.608751833438873291, 120, 255, 1, "", 45572, NULL),
(24588, 183758, 530, 0, 0, 1, 1, 9840.0341796875, -7358.28759765625, 19.392669677734375, 4.09075021743774414, 0, 0, -0.88948535919189453, 0.456963688135147094, 120, 255, 1, "", 45572, NULL),
(24589, 183759, 530, 0, 0, 1, 1, 9853.9775390625, -7361.6435546875, 19.392669677734375, 4.897896289825439453, 0, 0, -0.63857460021972656, 0.769559919834136962, 120, 255, 1, "", 45572, NULL),
(24590, 183760, 530, 0, 0, 1, 1, 9860.2431640625, -7358.53271484375, 19.392669677734375, 5.33464813232421875, 0, 0, -0.45668792724609375, 0.889626979827880859, 120, 255, 1, "", 45572, NULL),
(24647, 183782, 530, 0, 0, 1, 1, -2248.666748046875, 6225.14306640625, 43.85218429565429687, 3.62458205223083496, 0, 0, -0.97098159790039062, 0.239154160022735595, 120, 255, 1, "", 45704, NULL),
(25118, 184286, 530, 0, 0, 1, 1, -3963.257080078125, 2201.802001953125, 101.7742996215820312, 2.836158275604248046, 0, 0, 0.988361358642578125, 0.152124300599098205, 120, 255, 1, "", 45854, NULL),
(25827, 184922, 530, 0, 0, 1, 1, -4236.08984375, -11717.1201171875, -143.95550537109375, 1.744720935821533203, -0.0032806396484375, -0.00522518157958984, 0.76583099365234375, 0.643012285232543945, 120, 255, 1, "", 45942, NULL),
(25828, 184923, 530, 0, 0, 1, 1, -4242.69384765625, -11713.734375, -144.075897216796875, 0.650804519653320312, -0.00008392333984375, -0.00616931915283203, 0.319672584533691406, 0.947507977485656738, 120, 255, 1, "", 45942, NULL),
(26791, 4090, 0, 0, 0, 1, 1, -9460.033203125, 94.203125, 56.53351593017578125, 4.738570213317871093, 0, 0, -0.69779014587402343, 0.716302275657653808, 120, 255, 1, "", 45435, NULL),
(27148, 181884, 530, 0, 0, 1, 1, 7599.20751953125, -6910.67041015625, 93.76873779296875, 4.555310726165771484, 0, 0, -0.76040554046630859, 0.649448513984680175, 120, 255, 1, "", 45942, NULL),
(27638, 184146, 530, 0, 0, 1, 1, 2318.157958984375, 7256.900390625, 365.553924560546875, 0.488691210746765136, 0, 0, 0.241921424865722656, 0.970295846462249755, 120, 255, 1, "", 45942, NULL),
(27811, 187112, 530, 0, 0, 1, 1, 12667.82421875, -6982.90478515625, 14.57323360443115234, 3.124123096466064453, 0, 0, 0.99996185302734375, 0.008734640665352344, 120, 255, 1, "", 45942, NULL),
(28273, 186139, 530, 0, 0, 1, 1, 4142.79931640625, 3064.890625, 336.458526611328125, 5.742135047912597656, 0, 0, -0.26723766326904296, 0.96363067626953125, 120, 255, 1, "", 45704, NULL),
(29723, 184687, 530, 0, 0, 1, 1, -2395.927001953125, 2890.4228515625, -55.8926277160644531, 4.327290058135986328, -0.00849390029907226, 0.004799842834472656, -0.82933425903320312, 0.558667600154876708, 120, 255, 1, "", 49936, NULL),
(30166, 17190, 1, 0, 0, 1, 1, -1981.136962890625, 442.016998291015625, 133.5895843505859375, 3.150327444076538085, 0, 0, -0.99999046325683593, 0.004367320332676172, 120, 255, 1, "", 46368, NULL),
(30172, 175144, 1, 0, 0, 1, 1, 196.7274017333984375, 1173.1475830078125, 167.8319549560546875, 0.593411982059478759, 0, 0, 0.292371749877929687, 0.956304728984832763, 120, 255, 1, "", 46902, NULL),
(30402, 182270, 530, 0, 0, 1, 1, -198.95660400390625, 5483.064453125, 21.8449859619140625, 5.523968696594238281, 0, 0, -0.37055683135986328, 0.928809821605682373, 120, 255, 1, "", 45704, NULL),
(30816, 186138, 530, 0, 0, 1, 1, 2960.78125, 1799.53125, 139.0110931396484375, 0.654497027397155761, 0, 0, 0.321438789367675781, 0.946930348873138427, 120, 255, 1, "", 45704, NULL),
(32298, 130668, 0, 0, 0, 1, 1, -10651.626953125, 1106.9129638671875, 33.60646820068359375, 2.347463846206665039, 0, 0, 0.922200202941894531, 0.386712819337844848, 120, 255, 1, "", 47966, NULL),
(32655, 175851, 1, 0, 0, 1, 1, -1689.623291015625, 3082.467041015625, 32.05278396606445312, 1.562069892883300781, 0, 0, 0.704014778137207031, 0.71018528938293457, 120, 255, 1, "", 45572, NULL),
(32779, 186141, 530, 0, 0, 1, 1, 3065.7578125, 3677.720458984375, 142.3012237548828125, 4.598945140838623046, 0, 0, -0.74605655670166015, 0.665882587432861328, 120, 255, 1, "", 45704, NULL),
(34300, 38491, 0, 0, 0, 1, 1, -344.818359375, 1502.005859375, 16.99886703491210937, 3.551750659942626953, 0, 0, -0.97904491424560546, 0.203644454479217529, 120, 255, 1, "", 46248, NULL),
(387, 1685, 1, 0, 0, 1, 1, 1523.77783203125, -4368.2412109375, 18.21411514282226562, 0, 0, 0, 0, 1, 120, 255, 1, "", 45327, NULL),
(44762, 1743, 0, 0, 0, 1, 1, 2039.029541015625, 150.2760467529296875, 34.25516128540039062, 3.141669034957885742, 0.00436258316040039, -0.00872516632080078, 0.999952316284179687, 0, 120, 255, 1, "", 45572, NULL),
(44871, 38491, 0, 0, 0, 1, 1, 2230.72265625, 313.740234375, 34.91133499145507812, 5.585053920745849609, 0, 0, -0.34202003479003906, 0.939692676067352294, 120, 255, 1, "", 45435, NULL),
(44916, 52175, 0, 0, 0, 1, 1, 1392.591796875, 147.989959716796875, -62.4183311462402343, 1.928588032722473144, 0, 0, 0.821646690368652343, 0.569997072219848632, 120, 255, 1, "", 45572, NULL),
(44917, 52176, 0, 0, 0, 1, 1, 1684.68798828125, 276.8250732421875, -62.1811408996582031, 1.265363454818725585, 0, 0, 0.591309547424316406, 0.806444704532623291, 120, 255, 1, "", 45435, NULL),
(44949, 113754, 0, 0, 0, 1, 1, 1694.1341552734375, 293.993408203125, -62.1811408996582031, 2.975770950317382812, 0, 0, 0.996564865112304687, 0.082815870642662048, 120, 255, 1, "", 45435, NULL),
(45334, 148960, 0, 0, 0, 1, 1, 2979.0419921875, -1491.28125, 145.2322998046875, 4.747295856475830078, 0, 0, -0.69465827941894531, 0.719339847564697265, 120, 255, 1, "", 50664, NULL),
(45606, 181130, 0, 0, 0, 1, 1, 2261.361083984375, -5322.44970703125, 81.84270477294921875, 5.091957569122314453, 0, 0, -0.56101703643798828, 0.827804267406463623, 120, 255, 1, "", 45942, NULL),
(45689, 148960, 0, 0, 0, 1, 1, 1548.6962890625, -5387.109375, 78.22446441650390625, 5.558874130249023437, 0, 0, -0.35429096221923828, 0.935135245323181152, 120, 255, 1, "", 50664, NULL),
(46082, 179886, 0, 0, 0, 1, 1, -593.06597900390625, -4546.814453125, 8.975338935852050781, 2.111847877502441406, 0, 0, 0.870355606079101562, 0.492423713207244873, 120, 255, 1, "", 45772, NULL),
(46161, 34572, 0, 0, 0, 1, 1, 212.6529541015625, -1966.4642333984375, 140.4819793701171875, 4.703663349151611328, 0, 0, -0.71018505096435546, 0.704015016555786132, 120, 255, 1, "", 46902, NULL),
(4623, 1685, 530, 0, 0, 1, 1, 9479.353515625, -6800.869140625, 16.49356460571289062, 5.70722818374633789, 0, 0, -0.28401470184326171, 0.958819925785064697, 120, 255, 1, "", 45854, NULL),
(467, 194468, 530, 0, 0, 1, 1, -1747.6688232421875, 5648.66162109375, 128.023193359375, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 120, 255, 1, "", 45942, NULL),
(47586, 176509, 1, 0, 0, 1, 1, 988.24676513671875, 1005.29302978515625, 104.6084671020507812, 2.748894453048706054, 0, 0, 0.980785369873046875, 0.195089906454086303, 120, 255, 1, "", 45435, NULL),
(47603, 50831, 1, 0, 0, 1, 1, 112.123046875, -591.829345703125, -1.67420196533203125, 4.694936752319335937, 0, 0, -0.71325016021728515, 0.700909554958343505, 120, 255, 1, "", 51943, NULL),
(48632, 92490, 1, 0, 0, 1, 1, 6542.94384765625, 434.2857666015625, 7.549087047576904296, 2.172934770584106445, 0.000201702117919921, 0.009753227233886718, 0.884927749633789062, 0.465626090764999389, 120, 255, 1, "", 46248, NULL),
(49092, 179863, 1, 0, 0, 1, 1, 6696.50341796875, -4645.01416015625, 720.94970703125, 3.359769821166992187, 0, 0, -0.99405574798583984, 0.108872212469577789, 120, 255, 1, "", 45854, NULL),
(49393, 180913, 1, 0, 0, 1, 1, -6865.65576171875, 754.037353515625, 42.65666580200195312, 3.394674062728881835, 0, 0, -0.99200439453125, 0.126203224062919616, 120, 255, 1, "", 45704, NULL),
(49803, 1685, 1, 0, 0, 1, 1, 9916.1142578125, 2308.030517578125, 1330.786376953125, 5.986480236053466796, 0, 0, -0.14780902862548828, 0.989015936851501464, 120, 255, 1, "", 46248, NULL),
(5258, 171716, 0, 0, 0, 1, 1, -4762.9716796875, -1117.1053466796875, 499.334869384765625, 2.260197162628173828, 0, 0, 0.904454231262207031, 0.426570683717727661, 120, 255, 1, "", 45435, NULL),
(5430, 171717, 0, 0, 0, 1, 1, -4807.8603515625, -1130.1844482421875, 499.49908447265625, 2.260197162628173828, 0, 0, 0.904454231262207031, 0.426570683717727661, 120, 255, 1, "", 45435, NULL),
(55964, 192020, 571, 0, 0, 1, 1, 1954.1180419921875, -6190.4912109375, 24.12676429748535156, 1.527163028717041015, 0, 0, 0.6915130615234375, 0.722363948822021484, 120, 255, 1, "", 45772, NULL),
(56459, 186654, 571, 0, 0, 1, 1, 421.713531494140625, -4648.42724609375, 246.7728118896484375, 4.799657344818115234, 0, 0, -0.67558956146240234, 0.737277925014495849, 120, 255, 1, "", 45772, NULL),
(56480, 190495, 571, 0, 0, 1, 1, 7793.19091796875, -2950.447998046875, 1257.730712890625, 0.550021290779113769, -0.00670766830444335, 0.016690254211425781, 0.271546363830566406, 0.962257266044616699, 120, 255, 1, "", 46158, NULL),
(56654, 188452, 571, 0, 0, 1, 1, 3309.210205078125, -2341.568115234375, 110.914093017578125, 4.948008537292480468, 0, 0, -0.61909389495849609, 0.785317003726959228, 120, 255, 1, "", 46158, NULL),
(56955, 190765, 571, 0, 0, 1, 1, 5246.63623046875, 4490.5849609375, -84.3280258178710937, 1.851126790046691894, -0.00239181518554687, 0.026426315307617187, 0.798467636108398437, 0.60145270824432373, 120, 255, 1, "", 45942, NULL),
(57486, 190524, 571, 0, 0, 1, 1, 6642.57666015625, -209.402786254882812, 951.870361328125, 2.932138919830322265, 0, 0, 0.994521141052246093, 0.104535527527332305, 120, 255, 1, "", 46368, NULL),
(57539, 192831, 571, 0, 0, 1, 1, 5622.48291015625, 4572.2587890625, -137.663543701171875, 2.391098499298095703, 0, 0, 0.930417060852050781, 0.366502493619918823, 120, 255, 1, "", 45942, NULL),
(57574, 186433, 571, 0, 0, 1, 1, 1401.9322509765625, -3199.857666015625, 160.9440460205078125, 4.694936752319335937, 0.012232780456542968, -0.01244735717773437, -0.71314144134521484, 0.700802862644195556, 120, 255, 1, "", 46158, NULL),
(57733, 192583, 571, 0, 0, 1, 1, 7985.84716796875, 4.990450859069824218, 961.5565185546875, 2.407231092453002929, -0.00676393508911132, 0.00738525390625, 0.933281898498535156, 0.359004944562911987, 120, 255, 1, "", 47720, NULL),
(58133, 188250, 571, 0, 0, 1, 1, 4542.96728515625, -4246.021484375, 170.49212646484375, 5.75086069107055664, 0, 0, -0.263031005859375, 0.96478736400604248, 120, 255, 1, "", 47720, NULL),
(58300, 188257, 571, 0, 0, 1, 1, 3832.708251953125, -4541.69287109375, 209.2318115234375, 3.612833499908447265, 0.01158761978149414, 0.014916419982910156, -0.97215557098388671, 0.233573809266090393, 120, 255, 1, "", 45942, NULL),
(59043, 191346, 571, 0, 0, 1, 1, 2481.087646484375, -1951.9427490234375, 10.88319873809814453, 5.410521507263183593, 0, 0, -0.42261791229248046, 0.906307935714721679, 120, 255, 1, "", 46779, NULL),
(59092, 186486, 571, 0, 0, 1, 1, 544.4949951171875, -4997.93017578125, 10.47229957580566406, 3.001969099044799804, 0.021456718444824218, -0.00587368011474609, 0.997310638427734375, 0.069832757115364074, 120, 255, 1, "", 48632, NULL),
(59113, 187256, 571, 0, 0, 1, 1, 2334.302001953125, 5269.29931640625, 7.547565937042236328, 1.954769015312194824, 0, 0, 0.829037666320800781, 0.559192776679992675, 120, 255, 1, "", 47720, NULL),
(59403, 194487, 571, 0, 0, 1, 1, 8545.7783203125, 934.6180419921875, 547.29266357421875, 3.115387916564941406, 0, 0, 0.999914169311523437, 0.013101960532367229, 120, 255, 1, "", 50129, NULL),
(59623, 1685, 571, 0, 0, 1, 1, 5924.43994140625, 715.0439453125, 642.43829345703125, 4.660029888153076171, 0, 0, -0.72537422180175781, 0.688354730606079101, 120, 255, 1, "", 45327, NULL),
(59624, 1685, 571, 0, 0, 1, 1, 2478.989990234375, -1954.662353515625, 10.88320159912109375, 4.764749526977539062, 0, 0, -0.6883544921875, 0.725374460220336914, 120, 255, 1, "", 46368, NULL),
(60255, 188607, 571, 0, 0, 1, 1, 2760.4541015625, 853.0382080078125, 6.700050830841064453, 1.649336218833923339, 0, 0, 0.734322547912597656, 0.678800702095031738, 120, 255, 1, "", 45854, NULL),
(60307, 188354, 571, 0, 0, 1, 1, 3813.7353515625, 1571.326416015625, 86.64066314697265625, 3.263772249221801757, 0, 0, -0.99813461303710937, 0.061051756143569946, 120, 255, 1, "", 45854, NULL),
(60317, 188356, 571, 0, 0, 1, 1, 3819.686767578125, 1561.798583984375, 86.58795928955078125, 4.756025314331054687, 0, 0, -0.69151210784912109, 0.722364842891693115, 120, 255, 1, "", 45854, NULL),
(60512, 188624, 571, 0, 0, 1, 1, 3417.529541015625, -2759.072998046875, 199.2813720703125, 0.968657433986663818, 0.002991676330566406, 0.003175735473632812, 0.465604782104492187, 0.884981989860534667, 120, 255, 1, "", 46158, NULL),
(61116, 188651, 571, 0, 0, 1, 1, 4131.76416015625, 5282.38818359375, 25.10947418212890625, 5.724681377410888671, 0, 0, -0.27563667297363281, 0.961261868476867675, 120, 255, 1, "", 45854, NULL),
(61125, 188396, 571, 0, 0, 1, 1, 3210.1171875, -635.60418701171875, 160.1486663818359375, 4.180065631866455078, 0, 0, -0.86819839477539062, 0.496217250823974609, 120, 255, 1, "", 45942, NULL),
(61538, 190457, 571, 0, 0, 1, 1, 5409.99462890625, -2662.455078125, 303.933135986328125, 6.025707721710205078, 0, 0, -0.12838363647460937, 0.991724610328674316, 120, 255, 1, "", 45942, NULL),
(61660, 187388, 571, 0, 0, 1, 1, 3071.33935546875, 4826.24755859375, 1.220486998558044433, 5.279621601104736328, 0, 0, -0.4809885025024414, 0.876726925373077392, 120, 255, 1, "", 45854, NULL),
(62356, 192062, 571, 0, 0, 1, 195, 6204.640625, -3.63715291023254394, 410.169921875, 2.164208889007568359, 0.002507686614990234, -0.01356697082519531, 0.88282012939453125, 0.469508498907089233, 120, 255, 1, "", 45942, NULL),
(63130, 191287, 571, 0, 0, 1, 1, 2760.498291015625, 6177.1982421875, 83.32198333740234375, 3.883358240127563476, 0, 0, -0.9320077896118164, 0.36243826150894165, 120, 255, 1, "", 45772, NULL),
(63131, 191288, 571, 0, 0, 1, 1, 2826.31787109375, 6108.43017578125, 83.32198333740234375, 4.694071292877197265, 0, 0, -0.71355342864990234, 0.700600802898406982, 120, 255, 1, "", 45772, NULL),
(63132, 192572, 571, 0, 0, 1, 1, 2757.91162109375, 6203.10693359375, 83.32198333740234375, 3.883358240127563476, 0, 0, -0.9320077896118164, 0.36243826150894165, 120, 255, 1, "", 45772, NULL),
(63133, 192573, 571, 0, 0, 1, 1, 2851.6044921875, 6105.693359375, 83.32198333740234375, 5.082666873931884765, 0, 0, -0.56485652923583984, 0.825189113616943359, 120, 255, 1, "", 45772, NULL),
(63185, 191508, 0, 0, 0, 1, 449, 2438.341064453125, -5655.60595703125, 420.542938232421875, 4.609313011169433593, 0, 0, -0.74259471893310546, 0.669741034507751464, 120, 255, 1, "", 45942, NULL),
(65329, 186653, 571, 0, 0, 1, 1, 413.211822509765625, -4655.423828125, 246.5844268798828125, 2.574358940124511718, 0, 0, 0.960049629211425781, 0.279829770326614379, 120, 255, 1, "", 45772, NULL),
(65868, 191237, 609, 0, 0, 1, 1, 2261.635498046875, -5322.5556640625, 81.92261505126953125, 5.131268978118896484, 0, 0, -0.54463863372802734, 0.838670849800109863, 120, 255, 1, "", 48632, NULL),
(65884, 191505, 609, 0, 0, 1, 231, 2453.395751953125, -5659.1181640625, 420.566162109375, 4.609313011169433593, 0, 0, -0.74259471893310546, 0.669741034507751464, 120, 255, 1, "", 48632, NULL),
(66110, 148960, 609, 0, 0, 1, 1, 1811.8017578125, -6001.63671875, 115.8481292724609375, 4.738570213317871093, 0, 0, -0.69779014587402343, 0.716302275657653808, 120, 255, 1, "", 48632, NULL),
(66396, 191505, 0, 0, 0, 1, 449, 2453.395751953125, -5659.1181640625, 420.56658935546875, 4.609313011169433593, 0, 0, -0.74259471893310546, 0.669741034507751464, 120, 255, 1, "", 45942, NULL),
(66401, 191508, 609, 0, 0, 1, 231, 2438.341064453125, -5655.60595703125, 420.54248046875, 4.609313011169433593, 0, 0, -0.74259471893310546, 0.669741034507751464, 120, 255, 1, "", 48632, NULL),
(6880, 179844, 0, 0, 0, 1, 1, -6525.9970703125, -1188.3726806640625, 309.2177734375, 2.312241077423095703, 0, 0, 0.915246963500976562, 0.402893275022506713, 120, 255, 1, "", 45772, NULL),
(6881, 152034, 0, 0, 0, 1, 1, -6831.6884765625, -1222.37109375, 240.0138702392578125, 1.780233979225158691, 0, 0, 0.7771453857421875, 0.629321098327636718, 120, 255, 1, "", 45772, NULL),
(6927, 152042, 0, 0, 0, 1, 1, -6745.45703125, -1248.993896484375, 246.7498931884765625, 1.780233979225158691, 0, 0, 0.7771453857421875, 0.629321098327636718, 120, 255, 1, "", 45772, NULL),
(6935, 152045, 0, 0, 0, 1, 1, -6686.6318359375, -1428.4888916015625, 241.3292694091796875, 0.47996494174003601, 0.030863761901855468, 0.038967132568359375, 0.236227035522460937, 0.970425546169281005, 120, 255, 1, "", 45772, NULL),
(71405, 193126, 571, 0, 0, 1, 1, 5292.3046875, 2930.510498046875, 409.157135009765625, 3.220161199569702148, 0, 0, -0.99922847747802734, 0.039274025708436965, 120, 255, 1, "", 46248, NULL),
(7561, 186231, 1, 0, 0, 1, 1, -4606.11474609375, -3212.513916015625, 34.81392288208007812, 4.022988319396972656, 0, 0, -0.90445423126220703, 0.426570683717727661, 120, 255, 1, "", 45613, NULL),
(7591, 186630, 1, 0, 0, 1, 1, -3150.38916015625, -2857.26904296875, 34.00139236450195312, 2.085667610168457031, 0, 0, 0.863835334777832031, 0.503774285316467285, 120, 255, 1, "", 45572, NULL),
(77189, 194128, 571, 0, 0, 1, 1, 6096.16845703125, -1074.0052490234375, 404.558258056640625, 0.514872133731842041, -0.0191049575805664, 0.084914207458496093, 0.253370285034179687, 0.963445961475372314, 120, 255, 1, "", 46158, NULL),
(82, 176895, 0, 0, 0, 1, 1, -8100.392578125, -1507.236083984375, 132.9344024658203125, 4.188792228698730468, 0, 0, -0.86602497100830078, 0.50000077486038208, 120, 255, 1, "", 45772, NULL),
(8821, 4090, 1, 0, 0, 1, 1, -3792.841796875, -4369.90234375, 14.97791671752929687, 6.178466320037841796, 0, 0, -0.05233573913574218, 0.998629570007324218, 120, 255, 1, "", 46902, NULL),
(95, 1685, 0, 0, 0, 1, 1, -4816.33935546875, -1250.142333984375, 501.904693603515625, 1.954769015312194824, 0, 0, 0.829037666320800781, 0.559192776679992675, 120, 255, 1, "", 45435, NULL),
(9937, 142078, 0, 0, 0, 1, 1, -12040.26953125, -1005.96307373046875, 49.4103546142578125, 2.417279243469238281, 0, 0, 0.9351348876953125, 0.354291886091232299, 120, 255, 1, "", 45572, NULL);

-- remaining spawns (no sniffed values available)
-- (`guid` IN (66383, 66616, 31085, 42510, 76879, 44720))

-- two remaining spawns actually show in sniffs but with non-existend gameobject IDs (?)
-- guid 31085, id 1745:
-- (, 405870, 0, 40, 20, 1, 1, -11042.3994140625, 1452.140625, 45.19609832763671875, 4.860743999481201171, 0.002847671508789062, 0.003304481506347656, -0.65275287628173828, 0.757558345794677734, 120, 255, 1, 53622), -- 405870 (Area: 20 - Difficulty: 0) CreateObject1
-- guid 42510, id 2015:
-- (, 405880, 0, 44, 68, 1, 1, -9261.330078125, -2228.619873046875, 63.7667999267578125, 3.141592741012573242, 0, 0.008726119995117187, 0.99996185302734375, 0, 120, 255, 1, 53622), -- 405880 (Area: 68 - Difficulty: 0) CreateObject1

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (161487, 1685, 178684, 194468, 34571, 38491))
AND (`guid` BETWEEN 12362 AND 12368);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(12362, 161487, 30, 0, 0, 3, 1, 361.09722900390625, -531.69268798828125, 71.1897735595703125, 4.127707481384277343, 0, 0, -0.880889892578125, 0.473321229219436645, 7200, 255, 1, "", 46248, NULL),
(12363, 1685, 631, 0, 0, 3, 1, -514.44793701171875, 2245.038330078125, 539.29119873046875, 0, 0, 0, 0, 1, 7200, 255, 1, "", 51666, NULL),
(12364, 178684, 30, 0, 0, 3, 1, 649.263916015625, -59.1111106872558593, 41.54756927490234375, 3.595378875732421875, 0, 0, -0.97437000274658203, 0.224951311945915222, 7200, 255, 1, "", 46248, NULL),
(12365, 194468, 530, 0, 0, 1, 1, -1892.86328125, 5669.203125, 127.458251953125, 0.785396754741668701, 0, 0, 0.38268280029296875, 0.923879802227020263, 120, 255, 1, "", 45942, NULL),
(12366, 194468, 530, 0, 0, 1, 1, -2045.0133056640625, 5568.71826171875, 53.38373565673828125, 5.096362113952636718, 0, 0, -0.55919265747070312, 0.829037725925445556, 120, 255, 1, "", 45942, NULL),
(12367, 34571, 30, 0, 0, 3, 1, -105.423355102539062, -584.35174560546875, 42.01491928100585937, 2.364918231964111328, 0, 0, 0.925539970397949218, 0.378649920225143432, 7200, 255, 1, "", 46248, NULL),
(12368, 38491, 33, 0, 0, 1, 1, -344.818359375, 2035.33984375, 16.99887275695800781, 3.551750659942626953, 0, 0, -0.97904491424560546, 0.203644454479217529, 7200, 255, 1, "", 52237, NULL);
