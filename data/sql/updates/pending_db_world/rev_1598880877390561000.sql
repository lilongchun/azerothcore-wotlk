INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598880877390561000');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.0 */ 
SET @Build := 11159;

UPDATE `item_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (49623, 50730, 50731, 50732, 50733, 50734, 50735, 50736, 50737, 50738, 50348, 50349, 50363, 50364, 50365, 50366, 50398, 50400, 50402, 50404, 50603, 50604, 50605, 50606, 50607, 50608, 50609, 50610, 50611, 50612, 50613, 50614, 50615, 50616, 50617, 50618, 50619, 50620, 50621, 50622, 50623, 50624, 50625, 50626, 50627, 50628, 50629, 50630, 50631, 50632, 50633, 50635, 50636, 50638, 50639, 50640, 50641, 50642, 50643, 50644, 50645, 50646, 50647, 50648, 50649, 50650, 50651, 50652, 50653, 50654, 50655, 50656, 50657, 50658, 50659, 50660, 50661, 50663, 50664, 50665, 50667, 50668, 50670, 50671, 50672, 50673, 50674, 50675, 50676, 50677, 50678, 50679, 50680, 50681, 50682, 50684, 50685, 50686, 50687, 50688, 50689, 50690, 50691, 50692, 50693, 50694, 50695, 50696, 50697, 50698, 50699, 50700, 50701, 50702, 50703, 50704, 50705, 50706, 50707, 50708, 50709, 50710, 50711, 50712, 50713, 50714, 50715, 50716, 50717, 50718, 50719, 50720, 50721, 50722, 50723, 50724, 50725, 50726, 50727, 50728, 50729, 49981, 49997, 50012, 50070, 50425, 50426, 50427, 50428, 50429, 50397, 50399, 50401, 50403, 49888, 49890, 49891, 49892, 49893, 49894, 49895, 49896, 49897, 49898, 49899, 49900, 49901, 49902, 49903, 49904, 49905, 49906, 49907, 49919, 49949, 49950, 49951, 49952, 49960, 49964, 49967, 49968, 49975, 49976, 49977, 49978, 49979, 49980, 49982, 49983, 49985, 49986, 49987, 49988, 49989, 49990, 49991, 49992, 49993, 49994, 49995, 49996, 49998, 49999, 50000, 50001, 50002, 50003, 50005, 50006, 50008, 50009, 50010, 50011, 50014, 50015, 50016, 50019, 50020, 50021, 50022, 50023, 50024, 50025, 50026, 50027, 50028, 50030, 50032, 50033, 50034, 50035, 50036, 50037, 50038, 50040, 50041, 50042, 50056, 50059, 50060, 50061, 50062, 50063, 50064, 50065, 50067, 50068, 50069, 50071, 50072, 50073, 50074, 50075, 50170, 50171, 50172, 50173, 50174, 50175, 50176, 50177, 50178, 50179, 50180, 50181, 50182, 50183, 50184, 50185, 50186, 50187, 50188, 50190, 50192, 50195, 50199, 50202, 50205, 50333, 50343, 50344, 50345, 50346, 50351, 50352, 50353, 50354, 50355, 50356, 50357, 50358, 50359, 50360, 50361, 50362, 50411, 50412, 50413, 50414, 50415, 50416, 50417, 50418, 50421, 50423, 50424, 50444, 50447, 50449, 50450, 50451, 50452, 50453, 50466, 50467, 50468, 50469, 50470, 50472, 50965, 50968, 50969, 50970, 50971, 50972, 50973, 50974, 50975, 50976, 50977, 50978, 50979, 50980, 50981, 50982, 50983, 50984, 50987, 50989, 50991, 50992, 50993, 50994, 50995, 50996, 50997, 50454, 50455, 50456, 50457, 50458, 50459, 50460, 50461, 50462, 50463, 50464, 50474, 50384, 50386, 50387, 50388, 50046, 50047, 50048, 50049, 50050, 50051, 50052, 50078, 50079, 50080, 50081, 50082, 50087, 50088, 50089, 50090, 50094, 50095, 50096, 50097, 50098, 50105, 50106, 50107, 50108, 50109, 50113, 50114, 50115, 50116, 50117, 50118, 50240, 50241, 50242, 50243, 50244, 50275, 50276, 50277, 50278, 50279, 50324, 50325, 50326, 50327, 50328, 50339, 50340, 50341, 50342, 50375, 50376, 50377, 50378, 50391, 50392, 50393, 50394, 50396, 50759, 50760, 50761, 50762, 50763, 50764, 50765, 50766, 50767, 50768, 50769, 50771, 50772, 50773, 50774, 50775, 50776, 50777, 50778, 50779, 50780, 50781, 50782, 50783, 50784, 50785, 50786, 50787, 50788, 50789, 50790, 50791, 50792, 50793, 50794, 50795, 50796, 50797, 50798, 50799, 50800, 50801, 50802, 50803, 50804, 50805, 50806, 50807, 50808, 50809, 50810, 50811, 50812, 50819, 50820, 50821, 50822, 50823, 50824, 50825, 50826, 50827, 50828, 50830, 50831, 50832, 50833, 50834, 50835, 50836, 50837, 50838, 50839, 50841, 50842, 50843, 50844, 50845, 50846, 50847, 50848, 50849, 50850, 50852, 50853, 50854, 50855, 50856, 50857, 50858, 50859, 50860, 50861, 50862, 50863, 50864, 50865, 50866, 50867, 50868, 50869, 50966, 50967, 50985, 50986, 50988, 50990, 50998, 51000, 50999, 49313, 50191, 50193, 50194, 50196, 50197, 50198, 50203, 50206, 50207, 50208, 50209, 50210, 50211, 50212, 50213, 50214, 50215, 50227, 50228, 50229, 50230, 50233, 50234, 50235, 50259, 50260, 50262, 50263, 50264, 50265, 50266, 50267, 50268, 50269, 50270, 50271, 50272, 50273, 50283, 50284, 50285, 50286, 50290, 50291, 50292, 50293, 50294, 50295, 50296, 50297, 50298, 50299, 50300, 50302, 50303, 50304, 50305, 50306, 50308, 50309, 50310, 50311, 50312, 50313, 50314, 50315, 50318, 50319, 50169, 49783, 49784, 49785, 49786, 49787, 49788, 49789, 49790, 49791, 49792, 49793, 49794, 49795, 49796, 49797, 49798, 49799, 49800, 49801, 49802, 49803, 49804, 49805, 49806, 49807, 49808, 49809, 49810, 49811, 49812, 49813, 49816, 49817, 49818, 49819, 49820, 49821, 49822, 49823, 49824, 49825, 49826, 49827, 49828, 49829, 49830, 49831, 49832, 49833, 49834, 49835, 49836, 49837, 49838, 49839, 49840, 49841, 49842, 49843, 49844, 49845, 49846, 49847, 49848, 49849, 49851, 49852, 49853, 49854, 49855, 48945, 50741, 50255, 36519, 36589, 28045, 49953, 49954, 49955, 49956, 49957, 49958, 49959, 49961, 49962, 49963, 49965, 49966, 49969, 49970, 49971, 49972, 49973, 49974, 37343, 37346, 50335, 50336, 50337, 50338, 49426, 50316, 50317, 49908, 37329, 50406, 50851, 50367, 50368, 50369, 50370, 50372, 50373, 47840, 50168, 50166, 49205, 50045, 50077, 50250, 50818, 37898, 37899, 37900, 37901, 50274, 49869, 49926, 50226, 50231, 50379, 50380, 34518, 34519, 37298, 49646, 49662, 49663, 49715, 49912, 50287, 50446, 50471, 46725, 49278, 22781, 29205, 29206, 45568, 46398, 46740, 49351, 49352, 49536, 49631, 49635, 49641, 49648, 49655, 49661, 49668, 49669, 49670, 49698, 49718, 49723, 49739, 49740, 49750, 49766, 49778, 49856, 49857, 49858, 49859, 49860, 49861, 49867, 49870, 49871, 49872, 49879, 49889, 49909, 49915, 49916, 49918, 49920, 49922, 49923, 49924, 49925, 49927, 49936, 49937, 49938, 49939, 49940, 49941, 49942, 49943, 50055, 50057, 50130, 50131, 50160, 50161, 50163, 50164, 50254, 50289, 50301, 50307, 50320, 50432, 50816, 36794, 50125, 50167, 49868, 51220, 51221, 51222, 51223, 51224, 51225, 51226, 51227, 51228, 51229, 51230, 51231, 51232, 51233, 51234, 51235, 51236, 51237, 51238, 51239, 51240, 51241, 51242, 51243, 51244, 51245, 51246, 51247, 51248, 51249, 51250, 51251, 51252, 51253, 51254, 51255, 51256, 51257, 51258, 51259, 51260, 51261, 51262, 51263, 51264, 51265, 51266, 51267, 51268, 51269, 51270, 51271, 51272, 51273, 51274, 51275, 51276, 51277, 51278, 51279, 51280, 51281, 51282, 51283, 51284, 51285, 51286, 51287, 51288, 51289, 51290, 51291, 51292, 51293, 51294, 51295, 51296, 51297, 51298, 51299, 51300, 51301, 51302, 51303, 51304, 51305, 51306, 51307, 51308, 51309, 51310, 51311, 51312, 51313, 51314, 52572, 51939, 51940, 51941, 51942, 51943, 51944, 51945, 51946, 51947, 51396, 51407, 51408, 51409, 51413, 51414, 51415, 51416, 51418, 51419, 51420, 51421, 51422, 51424, 51425, 51426, 51427, 51428, 51430, 51433, 51434, 51435, 51436, 51438, 51452, 51455, 51458, 51459, 51460, 51461, 51462, 51463, 51464, 51465, 51466, 51467, 51468, 51469, 51470, 51471, 51473, 51474, 51475, 51476, 51477, 51479, 51482, 51483, 51484, 51485, 51486, 51487, 51488, 51489, 51490, 51491, 51492, 51493, 51494, 51495, 51496, 51497, 51498, 51499, 51500, 51502, 51503, 51504, 51505, 51506, 51508, 51509, 51510, 51511, 51512, 51514, 51533, 51536, 51537, 51538, 51539, 51540, 51541, 51542, 51543, 51544, 51545, 51417, 51423, 51429, 51437, 51472, 51478, 51501, 51507, 51513, 52571, 51125, 51126, 51127, 51128, 51129, 51130, 51131, 51132, 51133, 51134, 51135, 51136, 51137, 51138, 51139, 51140, 51141, 51142, 51143, 51144, 51145, 51146, 51147, 51148, 51149, 51150, 51151, 51152, 51153, 51154, 51155, 51156, 51157, 51158, 51159, 51160, 51161, 51162, 51163, 51164, 51165, 51166, 51167, 51168, 51169, 51170, 51171, 51172, 51173, 51174, 51175, 51176, 51177, 51178, 51179, 51180, 51181, 51182, 51183, 51184, 51185, 51186, 51187, 51188, 51189, 51190, 51191, 51192, 51193, 51194, 51195, 51196, 51197, 51198, 51199, 51200, 51201, 51202, 51203, 51204, 51205, 51206, 51207, 51208, 51209, 51210, 51211, 51212, 51213, 51214, 51215, 51216, 51217, 51218, 51219, 51327, 51328, 51329, 51330, 51331, 51332, 51333, 51334, 51335, 51336, 51337, 51338, 51339, 51340, 51341, 51342, 51343, 51344, 51345, 51346, 51347, 51348, 51349, 51350, 51351, 51352, 51353, 51354, 51355, 51356, 51357, 51358, 51359, 51360, 51361, 51362, 51363, 51364, 51365, 51366, 51367, 51368, 51369, 51370, 51371, 51372, 51373, 51374, 51375, 51376, 51377, 51378, 51388, 51390, 51392, 51394, 51397, 51400, 51402, 51404, 51406, 51410, 51411, 51431, 51439, 51441, 51443, 51445, 51447, 51449, 51451, 51453, 51456, 51480, 51515, 51517, 51519, 51521, 51523, 51525, 51527, 51530, 51531, 51532, 51811, 51812, 51813, 51814, 51815, 51816, 51817, 51818, 51819, 51820, 51821, 51822, 51823, 51824, 51825, 51826, 51827, 51828, 51829, 51830, 51831, 51832, 51833, 51834, 51835, 51836, 51837, 51838, 51839, 51840, 51841, 51842, 51843, 51844, 51845, 51846, 51847, 51848, 51849, 51850, 51851, 51852, 51853, 51854, 51855, 51856, 51857, 51858, 51859, 51860, 51861, 51862, 51863, 51864, 51865, 51866, 51867, 51868, 51869, 51870, 51871, 51872, 51873, 51874, 51875, 51876, 51877, 51878, 51879, 51881, 51882, 51883, 51884, 51885, 51886, 51887, 51888, 51889, 51890, 51891, 51892, 51893, 51894, 51895, 51896, 51897, 51898, 51899, 51900, 51901, 51902, 51903, 51904, 51905, 51906, 51907, 51908, 51909, 51910, 51911, 51912, 51913, 51914, 51915, 51916, 51917, 51918, 51919, 51920, 51921, 51922, 51923, 51924, 51925, 51926, 51927, 51928, 51929, 51930, 51931, 51932, 51933, 51934, 51935, 51936, 51937, 51938, 51535, 51880, 52570, 51795, 51796, 51797, 51798, 51799, 51800, 51801, 51802, 51803, 51001, 51002, 51003, 51004, 51005, 51006, 51007, 51008, 51009, 51010, 51011, 51012, 51013, 51014, 51015, 51016, 51017, 51018, 51019, 51020, 51021, 51022, 51023, 51024, 51025, 51325, 51326, 51379, 51380, 51381, 51382, 51383, 51384, 51385, 51386, 51387, 51548, 51550, 51551, 51552, 51553, 51554, 51555, 51556, 51557, 51558, 51559, 51560, 51561, 51562, 51563, 51564, 51565, 51566, 51572, 51573, 51574, 51575, 51576, 51577, 51578, 51579, 51580, 51581, 51582, 51583, 51584, 51585, 51586, 51777, 51779, 51782, 51783, 51784, 51785, 51786, 51787, 51788, 51789, 51790, 51791, 51792, 52569, 51568, 51569, 51570, 51571, 54801, 54802, 54803, 54804, 54805, 54806, 51804, 51805, 51806, 51807, 51808, 51958, 54537, 51809, 52025, 52026, 52027, 52028, 52029, 52030, 52201, 52251, 52252, 52253, 54535, 54536, 51026, 51027, 51954, 51955, 54797, 51961, 51969, 51975, 51983, 51991, 54798, 52005, 51960, 51970, 51979, 51987, 51995, 52004, 54069, 54860, 51959, 51971, 51977, 51985, 51993, 52003, 51962, 51963, 51967, 51972, 51981, 51982, 51989, 51990, 54343, 52002, 51966, 51974, 51976, 51984, 51992, 52001, 51965, 51973, 51980, 51996, 52000, 51964, 51968, 51978, 51994, 52200, 54811, 53641, 51315, 51316, 51317, 51318, 51319, 51320, 51321, 52006, 54637, 51999, 54212, 54436, 54847, 52019, 52676, 54437, 54438, 54218, 52020, 52021, 52022, 52023, 54291, 54469, 54470);
