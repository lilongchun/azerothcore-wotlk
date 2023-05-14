-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.npc_spellclick_spells
DROP TABLE IF EXISTS `npc_spellclick_spells`;
CREATE TABLE IF NOT EXISTS `npc_spellclick_spells` (
  `npc_entry` int unsigned NOT NULL COMMENT 'reference to creature_template',
  `spell_id` int unsigned NOT NULL COMMENT 'spell which should be casted ',
  `cast_flags` tinyint unsigned NOT NULL COMMENT 'first bit defines caster: 1=player, 0=creature; second bit defines target, same mapping as caster bit',
  `user_type` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'relation with summoner: 0-no 1-friendly 2-raid 3-party player can click',
  PRIMARY KEY (`npc_entry`,`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.npc_spellclick_spells: ~330 rows (approximately)
DELETE FROM `npc_spellclick_spells`;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
	(24083, 46598, 1, 0),
	(24418, 43768, 3, 0),
	(24750, 46598, 1, 0),
	(24992, 45008, 0, 0),
	(25334, 46598, 1, 0),
	(25334, 47917, 1, 0),
	(25460, 46598, 1, 0),
	(25596, 45875, 0, 0),
	(25743, 46260, 1, 0),
	(25762, 43671, 1, 0),
	(25765, 43671, 1, 0),
	(25968, 46598, 1, 0),
	(25968, 67830, 1, 0),
	(26048, 46407, 0, 0),
	(26191, 46978, 2, 0),
	(26200, 39996, 1, 0),
	(26200, 61286, 2, 0),
	(26421, 47575, 1, 0),
	(26477, 61832, 1, 0),
	(26503, 47121, 0, 0),
	(26523, 48296, 1, 0),
	(26809, 47416, 0, 0),
	(26813, 47424, 1, 0),
	(27061, 47920, 1, 0),
	(27131, 48754, 1, 0),
	(27213, 43671, 0, 0),
	(27241, 46598, 1, 0),
	(27258, 48365, 1, 0),
	(27354, 43671, 1, 0),
	(27409, 48678, 1, 0),
	(27496, 48881, 1, 0),
	(27587, 46598, 1, 1),
	(27587, 49078, 1, 0),
	(27593, 49177, 1, 0),
	(27626, 49138, 1, 0),
	(27661, 48365, 1, 0),
	(27714, 49584, 1, 0),
	(27761, 43671, 1, 0),
	(27881, 60968, 1, 0),
	(27894, 60682, 1, 0),
	(27923, 46598, 1, 1),
	(27924, 50007, 1, 0),
	(27939, 67830, 1, 0),
	(27996, 50343, 1, 0),
	(28018, 46598, 1, 0),
	(28054, 50556, 1, 0),
	(28061, 50557, 1, 0),
	(28094, 60968, 1, 0),
	(28115, 46598, 1, 0),
	(28161, 51037, 0, 0),
	(28162, 51026, 1, 0),
	(28192, 46598, 1, 0),
	(28202, 50926, 1, 0),
	(28202, 50927, 2, 0),
	(28203, 50918, 1, 0),
	(28203, 50919, 2, 0),
	(28222, 52082, 1, 0),
	(28312, 60968, 1, 0),
	(28319, 60968, 1, 0),
	(28366, 60962, 1, 0),
	(28379, 51658, 0, 0),
	(28389, 51592, 1, 0),
	(28389, 51593, 3, 0),
	(28468, 46598, 1, 0),
	(28605, 52263, 1, 0),
	(28606, 52263, 1, 0),
	(28607, 52263, 1, 0),
	(28614, 46598, 1, 0),
	(28669, 46598, 0, 1),
	(28670, 53173, 1, 0),
	(28710, 46598, 1, 1),
	(28781, 60683, 1, 0),
	(28782, 52349, 1, 0),
	(28782, 67830, 1, 0),
	(28817, 52462, 1, 0),
	(28833, 52447, 1, 0),
	(28851, 52600, 1, 0),
	(28864, 52589, 1, 0),
	(29005, 60944, 1, 0),
	(29351, 46598, 0, 0),
	(29358, 46598, 0, 0),
	(29433, 47020, 1, 0),
	(29460, 54513, 1, 0),
	(29488, 54568, 3, 0),
	(29500, 46598, 1, 0),
	(29501, 54575, 3, 0),
	(29555, 47020, 1, 0),
	(29563, 56795, 2, 0),
	(29579, 46598, 1, 1),
	(29598, 54768, 1, 0),
	(29602, 54908, 1, 0),
	(29625, 46598, 1, 0),
	(29679, 54952, 1, 0),
	(29698, 46598, 1, 0),
	(29708, 46598, 1, 0),
	(29708, 55028, 1, 0),
	(29709, 55029, 1, 0),
	(29736, 67830, 1, 0),
	(29838, 46598, 1, 0),
	(29856, 55364, 1, 0),
	(29857, 55460, 1, 0),
	(29863, 46598, 0, 1),
	(29884, 55430, 1, 0),
	(29912, 55479, 3, 0),
	(29918, 54301, 1, 0),
	(29929, 58961, 1, 0),
	(29931, 46598, 1, 0),
	(30013, 43671, 1, 0),
	(30021, 46598, 1, 0),
	(30021, 55785, 3, 0),
	(30066, 57053, 1, 0),
	(30123, 55957, 1, 0),
	(30134, 52391, 1, 0),
	(30134, 55089, 1, 0),
	(30134, 56603, 1, 0),
	(30174, 46598, 1, 0),
	(30204, 46598, 1, 0),
	(30234, 61421, 0, 0),
	(30236, 57573, 1, 0),
	(30248, 61421, 0, 0),
	(30272, 57401, 1, 0),
	(30330, 46598, 1, 0),
	(30337, 43671, 1, 0),
	(30388, 46598, 1, 0),
	(30393, 46598, 1, 0),
	(30403, 56699, 1, 0),
	(30468, 56795, 1, 0),
	(30470, 46598, 1, 0),
	(30500, 56922, 2, 0),
	(30560, 57347, 1, 1),
	(30564, 57401, 1, 0),
	(30585, 46598, 1, 0),
	(30645, 57612, 1, 0),
	(30841, 57897, 2, 1),
	(30850, 57897, 2, 1),
	(30852, 57897, 2, 1),
	(30895, 46598, 1, 0),
	(30935, 46598, 1, 0),
	(31110, 46598, 1, 0),
	(31137, 46598, 1, 0),
	(31157, 46598, 1, 0),
	(31262, 46598, 1, 0),
	(31269, 46598, 1, 0),
	(31406, 46598, 1, 0),
	(31407, 59060, 1, 0),
	(31408, 59060, 1, 0),
	(31409, 59060, 1, 0),
	(31583, 59319, 1, 0),
	(31736, 59592, 1, 0),
	(31748, 56378, 1, 0),
	(31770, 59654, 1, 0),
	(31784, 59593, 1, 0),
	(31785, 59656, 1, 0),
	(31830, 46598, 1, 0),
	(31838, 46598, 1, 0),
	(31840, 59060, 1, 0),
	(31856, 59060, 1, 0),
	(31861, 61466, 1, 0),
	(31862, 61466, 1, 0),
	(31881, 46598, 1, 0),
	(31883, 60123, 2, 2),
	(31884, 46598, 1, 0),
	(31893, 60123, 2, 2),
	(31894, 60123, 2, 2),
	(31895, 60123, 2, 2),
	(31896, 60123, 2, 2),
	(31897, 60123, 2, 2),
	(32152, 59060, 1, 0),
	(32189, 46598, 1, 0),
	(32225, 46598, 1, 0),
	(32227, 46598, 1, 0),
	(32286, 61666, 1, 0),
	(32292, 46598, 1, 0),
	(32344, 46598, 1, 0),
	(32370, 59724, 1, 0),
	(32490, 46598, 1, 0),
	(32512, 46598, 1, 0),
	(32513, 46598, 1, 0),
	(32535, 61245, 1, 0),
	(32627, 60968, 1, 0),
	(32629, 60968, 1, 0),
	(32633, 61424, 1, 0),
	(32640, 61424, 1, 0),
	(32788, 57539, 1, 0),
	(32790, 57654, 1, 0),
	(32795, 60682, 1, 0),
	(32796, 60683, 1, 0),
	(32823, 46598, 1, 0),
	(32830, 46598, 1, 0),
	(32840, 46598, 1, 0),
	(32930, 65343, 1, 0),
	(33060, 65031, 1, 0),
	(33062, 65030, 1, 0),
	(33067, 65031, 1, 0),
	(33109, 62309, 1, 0),
	(33113, 46598, 1, 0),
	(33114, 46598, 1, 0),
	(33139, 46598, 1, 0),
	(33143, 62399, 0, 0),
	(33167, 46598, 1, 0),
	(33167, 65031, 1, 0),
	(33214, 46598, 1, 0),
	(33217, 63151, 1, 0),
	(33293, 63852, 1, 0),
	(33316, 63151, 1, 0),
	(33317, 63151, 1, 0),
	(33318, 63151, 1, 0),
	(33319, 63151, 1, 0),
	(33320, 63151, 1, 0),
	(33321, 63151, 1, 0),
	(33322, 63151, 1, 0),
	(33323, 63151, 1, 0),
	(33324, 63151, 1, 0),
	(33357, 75648, 1, 0),
	(33432, 67830, 1, 1),
	(33498, 63126, 3, 0),
	(33519, 63163, 1, 0),
	(33651, 67830, 1, 1),
	(33669, 46598, 1, 0),
	(33670, 67830, 1, 1),
	(33687, 46598, 1, 0),
	(33778, 43671, 1, 0),
	(33782, 63151, 1, 0),
	(33790, 62781, 1, 0),
	(33791, 62786, 1, 0),
	(33792, 62785, 1, 0),
	(33793, 62780, 1, 0),
	(33794, 62782, 1, 0),
	(33795, 62779, 1, 0),
	(33796, 62784, 1, 0),
	(33798, 62787, 1, 0),
	(33799, 62783, 1, 0),
	(33800, 62774, 1, 0),
	(33842, 63791, 1, 0),
	(33843, 63792, 1, 0),
	(33844, 63151, 1, 0),
	(33845, 63151, 1, 0),
	(33870, 63663, 1, 0),
	(34045, 65030, 1, 0),
	(34072, 51347, 3, 0),
	(34106, 67830, 1, 1),
	(34108, 67830, 1, 1),
	(34109, 67830, 1, 1),
	(34111, 46598, 1, 0),
	(34120, 55089, 1, 0),
	(34125, 63215, 1, 0),
	(34146, 43671, 1, 0),
	(34150, 43671, 1, 0),
	(34151, 43671, 1, 0),
	(34161, 46598, 1, 0),
	(34162, 46598, 1, 0),
	(34183, 46598, 1, 0),
	(34214, 46598, 1, 0),
	(34658, 46598, 1, 0),
	(34775, 66245, 1, 0),
	(34776, 46598, 1, 0),
	(34776, 66245, 1, 0),
	(34777, 67830, 1, 0),
	(34778, 67830, 1, 0),
	(34793, 66245, 1, 0),
	(34796, 67830, 1, 0),
	(34802, 68503, 1, 0),
	(34812, 65403, 1, 0),
	(34819, 65403, 1, 0),
	(34822, 65403, 1, 0),
	(34823, 65403, 1, 0),
	(34824, 65403, 1, 0),
	(34929, 43671, 1, 0),
	(34935, 43671, 1, 0),
	(34944, 68458, 1, 0),
	(35069, 46598, 1, 0),
	(35069, 66245, 1, 0),
	(35273, 68503, 1, 0),
	(35299, 46598, 1, 0),
	(35410, 43671, 1, 0),
	(35413, 66245, 1, 0),
	(35415, 66245, 1, 0),
	(35417, 67830, 1, 0),
	(35419, 68503, 1, 0),
	(35421, 68503, 1, 0),
	(35427, 43671, 1, 0),
	(35429, 68458, 1, 0),
	(35431, 46598, 1, 0),
	(35431, 66245, 1, 0),
	(35433, 46598, 1, 0),
	(35433, 66245, 1, 0),
	(35436, 67830, 1, 0),
	(35491, 46598, 1, 0),
	(35633, 46598, 1, 0),
	(35634, 46598, 1, 0),
	(35635, 46598, 1, 0),
	(35636, 46598, 1, 0),
	(35637, 46598, 1, 0),
	(35638, 46598, 1, 0),
	(35640, 46598, 1, 0),
	(35641, 46598, 1, 0),
	(35644, 67830, 1, 0),
	(35768, 46598, 1, 0),
	(35819, 68077, 1, 1),
	(36355, 67830, 1, 0),
	(36356, 67830, 1, 0),
	(36357, 67830, 1, 0),
	(36358, 67830, 1, 0),
	(36476, 46598, 1, 0),
	(36558, 67830, 1, 0),
	(36661, 46598, 1, 0),
	(36678, 46598, 1, 0),
	(36794, 46598, 1, 0),
	(36838, 70510, 1, 0),
	(36839, 70510, 1, 0),
	(36891, 46598, 1, 0),
	(36896, 46598, 1, 0),
	(37227, 70104, 3, 0),
	(37945, 70766, 3, 0),
	(37968, 46598, 1, 0),
	(38248, 71462, 1, 2),
	(38430, 70766, 3, 0),
	(38431, 46598, 1, 0),
	(38500, 46598, 1, 0),
	(38585, 46598, 1, 0),
	(38586, 46598, 1, 0),
	(39714, 74205, 1, 0),
	(40081, 46598, 0, 1),
	(40176, 74904, 1, 0),
	(40176, 74905, 3, 0),
	(40305, 46598, 1, 0),
	(40470, 46598, 0, 1),
	(40471, 46598, 0, 1),
	(40472, 46598, 0, 1),
	(40725, 75953, 1, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
