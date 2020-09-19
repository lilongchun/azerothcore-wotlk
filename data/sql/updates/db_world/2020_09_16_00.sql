-- DB update 2020_09_15_01 -> 2020_09_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_15_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_15_01 2020_09_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598879210251111300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598879210251111300');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.2.0 */ 
SET @Build := 10314;

UPDATE `creature_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (31239, 32944, 33529, 33530, 33532, 33533, 33840, 33841, 33848, 34070, 34156, 34158, 34225, 34655, 34694, 35477, 34989, 35599, 34988, 35395, 35168, 35399, 34793, 35646, 35189, 35100, 35101, 35002, 35597, 35001, 34999, 35596, 35000, 35497, 35507, 35496, 35494, 35790, 34952, 35500, 34924, 34330, 35498, 35594, 36021, 35461, 35826, 34953, 35471, 35495, 35508, 35398, 35476, 35473, 35469, 35483, 35290, 35292, 34772, 34788, 34914, 34771, 34794, 35470, 35475, 35573, 35580, 35578, 35576, 35579, 35574, 35577, 35575, 36119, 36120, 36124, 36122, 36121, 36069, 35293, 35291, 36114, 36116, 36108, 36118, 36109, 34880, 34912, 34881, 35808, 35482, 36223, 35117, 35344, 35094, 34882, 34885, 35472, 35501, 35984, 35499, 36101, 36102, 35467, 35462, 34735, 35361, 34970, 34868, 34995, 34996, 34994, 34974, 34975, 34966, 34977, 34871, 36557, 36559, 35005, 35635, 35326, 35640, 35325, 35634, 35327, 34856, 34870, 34992, 34990, 34869, 35569, 35571, 35617, 34979, 34859, 34861, 34860, 34857, 34858, 35309, 35305, 35307, 34928, 35030, 35491, 35451, 35564, 35547, 35590, 35557, 35368, 35372, 35638, 35314, 35572, 35119, 35320, 35321, 35570, 35046, 35028, 36173, 35029, 35039, 35299, 35641, 35323, 35322, 35604, 35587, 35589, 35642, 34724, 35373, 35460, 34986, 35601, 35396, 35073, 35089, 35106, 35444, 35097, 34728, 34734, 35113, 34956, 34716, 34810, 34808, 35255, 36066, 36065, 34925, 35092, 34907, 35098, 34947, 34852, 34838, 34839, 35047, 35281, 34704, 34720, 34816, 34796, 34800, 34854, 34799, 35144, 35176, 34797, 35035, 35458, 35651, 34780, 34784, 34825, 34826, 34813, 34815, 35766, 34445, 34459, 34447, 34455, 34453, 34458, 34454, 34448, 34441, 34450, 35610, 35465, 35770, 34567, 34568, 34497, 34496, 34755, 34630, 34628, 35133, 35131, 34789, 36024, 35045, 35365, 34997, 34998, 35598, 34915, 34920, 35394, 35143, 35013, 35387, 35068, 35400, 34983, 34985, 35611, 35048, 35474, 35049, 35093, 35099, 35038, 35600, 34991, 35007, 34320, 34944, 36171, 34929, 34935, 34775, 34776, 35273, 35336, 35339, 35069, 35819, 36356, 36355, 36165, 36166, 34984, 36152, 34960, 36151, 34950, 34948, 35023, 35169, 34765, 34723, 34717, 34721, 34715, 34730, 34719, 34718, 34766, 34949, 34951, 34802, 34919, 35377, 35379, 35335, 34778, 34777, 35024, 35026, 35022, 34918, 34922, 35380, 35346, 36162, 34365, 34526, 35012, 34965, 34980, 35135, 34451, 34449, 36070, 35771, 35877, 34564, 35763, 36099, 34862, 34606, 34607, 34660, 34605, 36097, 36095, 34444, 36208, 35909, 34528, 35132, 35319, 35324, 35083, 35080, 35084, 35079, 35070, 35090, 35104, 35105, 34879, 34888, 35102, 35318, 35602, 35008, 34955, 35364, 35017, 34520, 34519, 34703, 35607, 34531, 35397, 35040, 35042, 35025, 34987, 34456, 35003, 35061, 35071, 35072, 36349, 36350, 34310, 35031, 35060, 34976, 34978, 35603, 35345, 34460, 34461, 34463, 34465, 34466, 34467, 34468, 34469, 34470, 34471, 34472, 34473, 34474, 34475, 34657, 34658, 34701, 34702, 35004, 35330, 35331, 35332, 35545, 35633, 35644, 35768, 36558, 35147, 35445, 34705, 34972, 34973, 35020, 35127, 35328, 35329, 35612, 35636, 35637, 36164, 35037, 35044, 34337, 35041, 35809, 35036, 35033, 35052, 34942, 35019, 35148, 35179, 36085, 36090, 36084, 35517, 35490, 36089, 35518, 36091, 36087, 36086, 36083, 36082, 36088, 35519, 35527, 35521, 35522, 35520, 35523, 35524, 35534, 35717, 36067, 35529, 35525, 35427, 35421, 35415, 35407, 35401, 35310, 35032, 36301, 35559, 35543, 35537, 36358, 35720, 34437, 35533, 35540, 35419, 35413, 35405, 35308, 35910, 35546, 35542, 35536, 36357, 36303, 35719, 35568, 35532, 35539, 34425, 35417, 35410, 35403, 35306, 35051, 35895, 35544, 35541, 35535, 36302, 35718, 35560, 35538, 35438, 35441, 35514, 35511, 35447, 35216, 35278, 35270, 35265, 35262, 35705, 35686, 35683, 35680, 35692, 35711, 35724, 34442, 35695, 35774, 35436, 35350, 35347, 35671, 35689, 36473, 34566, 35429, 34649, 34648, 34650, 35740, 35708, 35702, 35743, 35734, 35746, 35665, 35662, 35721, 35714, 35728, 35668, 35699, 35674, 35731, 35737, 35439, 35442, 35515, 35512, 35448, 35268, 35279, 35271, 35266, 35263, 35706, 35687, 35684, 35681, 35693, 35712, 35725, 34443, 35696, 35775, 35433, 35351, 35348, 35672, 35690, 36474, 35615, 35425, 35655, 35658, 35741, 35709, 35703, 35744, 35735, 35747, 35666, 35663, 35722, 35715, 35729, 35669, 35700, 35675, 35732, 35738, 35440, 35443, 35516, 35513, 35449, 35269, 35280, 35272, 35267, 35264, 35707, 35688, 35685, 35682, 35694, 35713, 35726, 35749, 35697, 35776, 35431, 35352, 35349, 35673, 35691, 36475, 35616, 35656, 35659, 35742, 35710, 35704, 35745, 35736, 35748, 35667, 35664, 35723, 35716, 35730, 35670, 35701, 35676, 35733, 35739, 35116, 35050, 35043, 34386, 34387, 34489, 34532, 35360, 35359, 35531, 35530, 36064, 35027, 34490, 3460602, 3460603);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
