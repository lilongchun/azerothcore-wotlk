-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.spell_area
DROP TABLE IF EXISTS `spell_area`;
CREATE TABLE IF NOT EXISTS `spell_area` (
  `spell` mediumint unsigned NOT NULL DEFAULT '0',
  `area` mediumint unsigned NOT NULL DEFAULT '0',
  `quest_start` mediumint unsigned NOT NULL DEFAULT '0',
  `quest_end` mediumint unsigned NOT NULL DEFAULT '0',
  `aura_spell` mediumint NOT NULL DEFAULT '0',
  `racemask` mediumint unsigned NOT NULL DEFAULT '0',
  `gender` tinyint unsigned NOT NULL DEFAULT '2',
  `autocast` tinyint unsigned NOT NULL DEFAULT '0',
  `quest_start_status` int NOT NULL DEFAULT '64',
  `quest_end_status` int NOT NULL DEFAULT '11',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`aura_spell`,`racemask`,`gender`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumpar data för tabell acore_world.spell_area: 697 rows
DELETE FROM `spell_area`;
/*!40000 ALTER TABLE `spell_area` DISABLE KEYS */;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
	(27105, 4492, 0, 12951, 0, 0, 2, 1, 64, 11),
	(27769, 4071, 0, 0, 0, 0, 2, 1, 64, 11),
	(30181, 4477, 0, 12897, 0, 690, 2, 1, 64, 11),
	(30181, 4477, 0, 12896, 0, 1101, 2, 1, 64, 11),
	(30550, 3457, 0, 0, 0, 0, 2, 0, 64, 11),
	(30557, 3457, 0, 0, 0, 0, 2, 0, 64, 11),
	(30562, 3457, 0, 0, 0, 0, 2, 0, 64, 11),
	(30567, 3457, 0, 0, 0, 0, 2, 0, 64, 11),
	(32096, 3483, 0, 0, 0, 0, 2, 0, 64, 11),
	(32096, 3562, 0, 0, 0, 0, 2, 0, 64, 11),
	(32096, 3713, 0, 0, 0, 0, 2, 0, 64, 11),
	(32096, 3714, 0, 0, 0, 0, 2, 0, 64, 11),
	(32096, 3836, 0, 0, 0, 0, 2, 0, 64, 11),
	(32098, 3483, 0, 0, 0, 0, 2, 0, 64, 11),
	(32098, 3562, 0, 0, 0, 0, 2, 0, 64, 11),
	(32098, 3713, 0, 0, 0, 0, 2, 0, 64, 11),
	(32098, 3714, 0, 0, 0, 0, 2, 0, 64, 11),
	(32098, 3836, 0, 0, 0, 0, 2, 0, 64, 11),
	(32407, 3674, 0, 0, 0, 0, 2, 1, 64, 11),
	(33836, 3803, 0, 0, 0, 0, 2, 0, 64, 11),
	(34102, 3733, 0, 0, 0, 0, 2, 1, 64, 11),
	(35480, 2367, 0, 0, 0, 690, 0, 1, 64, 11),
	(35480, 4100, 0, 0, 0, 690, 0, 1, 64, 11),
	(35481, 2367, 0, 0, 0, 690, 1, 1, 64, 11),
	(35481, 4100, 0, 0, 0, 690, 1, 1, 64, 11),
	(35482, 2367, 0, 0, 0, 1032, 0, 1, 64, 11),
	(35482, 4100, 0, 0, 0, 1032, 0, 1, 64, 11),
	(35483, 2367, 0, 0, 0, 1032, 1, 1, 64, 11),
	(35483, 4100, 0, 0, 0, 1032, 1, 1, 64, 11),
	(40200, 3522, 0, 0, 40195, 0, 2, 1, 64, 11),
	(40214, 3759, 11013, 0, 0, 0, 2, 1, 74, 11),
	(40214, 3939, 11013, 0, 0, 0, 2, 1, 74, 11),
	(40214, 3965, 11013, 0, 0, 0, 2, 1, 74, 11),
	(40214, 3966, 11013, 0, 0, 0, 2, 1, 74, 11),
	(40567, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40567, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40568, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40568, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40572, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40572, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40573, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40573, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40575, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40575, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40576, 3522, 0, 0, 0, 0, 2, 0, 64, 11),
	(40576, 3923, 0, 0, 0, 0, 2, 0, 64, 11),
	(40623, 3522, 0, 0, 0, 0, 2, 0, 0, 0),
	(40624, 3767, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3768, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3769, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3770, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3771, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3772, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3773, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3774, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3775, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3776, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3777, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3778, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3779, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3780, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3781, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3782, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3783, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3784, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3785, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3786, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3787, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3824, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3825, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3826, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3827, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3828, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3829, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3830, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3831, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3832, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3833, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3834, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3844, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3855, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3862, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3863, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3864, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3865, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3866, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3867, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3903, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3904, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3918, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3919, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3922, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3924, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3925, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3931, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3942, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3951, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3952, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3953, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3954, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3960, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3962, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3963, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3964, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3969, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3970, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3971, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 3972, 0, 0, 0, 0, 2, 1, 0, 0),
	(40624, 4008, 0, 0, 0, 0, 2, 1, 0, 0),
	(40625, 3522, 0, 0, 0, 0, 2, 0, 0, 0),
	(40626, 3522, 0, 0, 0, 0, 2, 0, 0, 0),
	(40627, 3767, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3768, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3769, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3770, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3771, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3772, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3773, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3774, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3775, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3776, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3777, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3778, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3779, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3780, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3781, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3782, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3783, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3784, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3785, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3786, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3787, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3824, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3825, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3826, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3827, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3828, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3829, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3830, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3831, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3832, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3833, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3834, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3844, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3855, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3862, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3863, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3864, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3865, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3866, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3867, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3903, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3904, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3918, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3919, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3922, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3924, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3925, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3931, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3942, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3951, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3952, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3953, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3954, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3960, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3962, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3963, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3964, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3969, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3970, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3971, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 3972, 0, 0, 0, 0, 2, 1, 0, 0),
	(40627, 4008, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3767, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3768, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3769, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3770, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3771, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3772, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3773, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3774, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3775, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3776, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3777, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3778, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3779, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3780, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3781, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3782, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3783, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3784, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3785, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3786, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3787, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3824, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3825, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3826, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3827, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3828, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3829, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3830, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3831, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3832, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3833, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3834, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3844, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3855, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3862, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3863, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3864, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3865, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3866, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3867, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3903, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3904, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3918, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3919, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3922, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3924, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3925, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3931, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3942, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3951, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3952, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3953, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3954, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3960, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3962, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3963, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3964, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3969, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3970, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3971, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 3972, 0, 0, 0, 0, 2, 1, 0, 0),
	(40628, 4008, 0, 0, 0, 0, 2, 1, 0, 0),
	(41304, 3522, 0, 0, 0, 0, 2, 0, 0, 0),
	(41306, 3522, 0, 0, 0, 0, 2, 0, 0, 0),
	(41608, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(41608, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(41609, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(41610, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(41611, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(41617, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41617, 3715, 0, 0, 0, 0, 2, 0, 64, 11),
	(41617, 3716, 0, 0, 0, 0, 2, 0, 64, 11),
	(41617, 3717, 0, 0, 0, 0, 2, 0, 64, 11),
	(41618, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41618, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41618, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41618, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(41619, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(41619, 3715, 0, 0, 0, 0, 2, 0, 64, 11),
	(41619, 3716, 0, 0, 0, 0, 2, 0, 64, 11),
	(41619, 3717, 0, 0, 0, 0, 2, 0, 64, 11),
	(41620, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(41620, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(41620, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(41620, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(42316, 2079, 11142, 0, 0, 1101, 2, 1, 74, 11),
	(43816, 3805, 0, 0, 0, 0, 0, 0, 0, 0),
	(43818, 3805, 0, 0, 0, 0, 0, 0, 0, 0),
	(43820, 3805, 0, 0, 0, 0, 0, 0, 0, 0),
	(43822, 3805, 0, 0, 0, 0, 0, 0, 0, 0),
	(43889, 3999, 11390, 0, 0, 0, 2, 1, 8, 0),
	(44017, 3990, 11504, 0, 0, 0, 2, 1, 64, 11),
	(45373, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(45614, 4125, 11633, 0, 0, 0, 2, 0, 74, 11),
	(45614, 4135, 11633, 0, 0, 0, 2, 0, 74, 11),
	(45614, 4136, 11633, 0, 0, 0, 2, 0, 74, 11),
	(45614, 4137, 11633, 0, 0, 0, 2, 0, 74, 11),
	(46234, 3537, 11879, 0, 0, 0, 2, 1, 8, 0),
	(46424, 4035, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46424, 4037, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46424, 4116, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46424, 4117, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46424, 4119, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46424, 4146, 11896, 0, 0, 0, 2, 1, 10, 0),
	(46837, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(46837, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3606, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3607, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3845, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3847, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3848, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3849, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 3959, 0, 0, 0, 0, 2, 0, 64, 11),
	(46839, 4075, 0, 0, 0, 0, 2, 0, 64, 11),
	(46999, 4169, 12473, 0, 0, 0, 2, 1, 64, 11),
	(47917, 4027, 11652, 11652, 0, 0, 2, 0, 64, 11),
	(47917, 4130, 11652, 11652, 0, 0, 2, 0, 64, 11),
	(48761, 4180, 0, 0, 0, 0, 1, 0, 0, 0),
	(48763, 4180, 0, 0, 0, 0, 0, 0, 0, 0),
	(49416, 4206, 0, 12431, 0, 0, 2, 1, 64, 11),
	(49416, 4519, 13360, 13362, 0, 690, 2, 1, 74, 11),
	(49416, 4519, 13399, 13401, 0, 1101, 2, 1, 74, 11),
	(49416, 4521, 13364, 13364, 0, 0, 2, 1, 74, 11),
	(49416, 4521, 13403, 13403, 0, 0, 2, 1, 74, 11),
	(49416, 4533, 13348, 13360, 0, 690, 2, 1, 64, 11),
	(49416, 4533, 13396, 13399, 0, 1101, 2, 1, 64, 11),
	(49416, 4537, 13304, 13305, 0, 690, 2, 1, 64, 11),
	(49416, 4537, 13393, 13394, 0, 1101, 2, 1, 64, 11),
	(49416, 4615, 13271, 13282, 0, 690, 2, 1, 74, 11),
	(49416, 4615, 13390, 13282, 0, 1101, 2, 1, 74, 11),
	(49416, 4622, 13305, 13348, 0, 690, 2, 1, 66, 11),
	(49416, 4622, 13394, 13396, 0, 1101, 2, 1, 66, 11),
	(49417, 4206, 12431, 0, 0, 0, 2, 1, 64, 11),
	(49417, 4446, 13010, 13047, 0, 0, 2, 1, 64, 11),
	(49417, 4537, 13304, 13304, 0, 690, 2, 1, 11, 11),
	(49417, 4537, 13393, 13393, 0, 1101, 2, 1, 11, 11),
	(49417, 4543, 13047, 0, 0, 0, 2, 1, 10, 0),
	(50012, 4175, 12470, 0, 0, 0, 2, 1, 2, 11),
	(50426, 4161, 0, 0, 0, 0, 2, 0, 64, 11),
	(50426, 4173, 0, 0, 0, 0, 2, 0, 64, 11),
	(50426, 4254, 0, 0, 0, 0, 2, 0, 64, 11),
	(50735, 3711, 12532, 12532, 0, 0, 2, 1, 74, 11),
	(50735, 3711, 12702, 12702, 0, 0, 2, 1, 74, 11),
	(50735, 4292, 12532, 12532, 0, 0, 2, 1, 74, 11),
	(50735, 4292, 12702, 12702, 0, 0, 2, 1, 74, 11),
	(51116, 4284, 12523, 0, 0, 0, 2, 1, 64, 11),
	(51671, 4325, 12667, 12675, 0, 0, 2, 1, 66, 11),
	(51721, 4281, 12657, 0, 0, 0, 2, 1, 64, 11),
	(51721, 4342, 12657, 0, 0, 0, 2, 1, 64, 11),
	(51852, 4298, 0, 0, 0, 0, 2, 0, 64, 11),
	(51915, 4298, 0, 0, 0, 0, 2, 1, 64, 11),
	(52217, 4287, 12692, 0, 0, 0, 2, 1, 64, 11),
	(52217, 4288, 12695, 0, 0, 0, 2, 1, 64, 11),
	(52217, 4306, 12574, 12577, 0, 0, 2, 1, 74, 11),
	(52217, 4308, 12574, 0, 0, 0, 2, 1, 74, 64),
	(52351, 4325, 12675, 0, 0, 0, 2, 1, 64, 11),
	(52484, 4323, 12685, 0, 0, 0, 2, 1, 64, 11),
	(52485, 4322, 0, 12685, 0, 0, 2, 1, 64, 11),
	(52597, 4298, 12706, 12757, 0, 0, 2, 1, 64, 11),
	(52598, 4298, 12706, 0, 0, 0, 2, 1, 64, 11),
	(52693, 4298, 12687, 12687, 0, 0, 2, 1, 74, 9),
	(52707, 4298, 12716, 0, 0, 0, 2, 1, 64, 11),
	(52950, 4298, 12727, 0, 0, 0, 2, 1, 64, 11),
	(53081, 4298, 12755, 12756, 0, 0, 2, 1, 74, 11),
	(53107, 4298, 12757, 12779, 0, 0, 2, 1, 64, 11),
	(53405, 4298, 12779, 0, 0, 0, 2, 1, 64, 11),
	(54057, 4297, 12578, 0, 0, 0, 2, 1, 8, 0),
	(54119, 4028, 0, 0, 0, 0, 2, 1, 64, 11),
	(54119, 4029, 0, 0, 0, 0, 2, 1, 64, 11),
	(54119, 4031, 0, 0, 0, 0, 2, 1, 64, 11),
	(54119, 4106, 0, 0, 0, 0, 2, 1, 64, 11),
	(54119, 4269, 0, 0, 0, 0, 2, 1, 64, 11),
	(54502, 4446, 13057, 0, 0, 0, 2, 1, 74, 11),
	(54504, 4422, 12921, 0, 0, 0, 2, 1, 74, 11),
	(54504, 4445, 13047, 13047, 0, 0, 2, 1, 8, 11),
	(54504, 4543, 13047, 13047, 0, 0, 2, 1, 8, 11),
	(54635, 4421, 12822, 0, 0, 0, 2, 1, 74, 0),
	(54635, 4461, 12822, 0, 0, 0, 2, 1, 74, 1),
	(55012, 4422, 12905, 0, 0, 0, 2, 1, 74, 11),
	(55012, 4425, 12905, 0, 0, 0, 2, 1, 74, 11),
	(55012, 4437, 12921, 13063, 0, 0, 2, 1, 74, 11),
	(55012, 4438, 12856, 12856, 0, 0, 2, 1, 74, 11),
	(55012, 4535, 12905, 0, 0, 0, 2, 1, 74, 11),
	(55164, 67, 0, 0, 8326, 65527, 2, 1, 64, 11),
	(55164, 210, 0, 0, 8326, 65527, 2, 1, 64, 11),
	(55164, 4161, 0, 0, 8326, 65527, 2, 1, 64, 11),
	(55164, 4197, 0, 0, 8326, 65527, 2, 1, 64, 11),
	(55173, 67, 0, 0, 8326, 8, 2, 1, 64, 11),
	(55173, 210, 0, 0, 8326, 8, 2, 1, 64, 11),
	(55173, 4161, 0, 0, 8326, 8, 2, 1, 64, 11),
	(55173, 4197, 0, 0, 8326, 8, 2, 1, 64, 11),
	(55773, 4197, 0, 0, 0, 0, 2, 0, 0, 0),
	(55774, 4197, 0, 0, 0, 0, 2, 0, 0, 0),
	(55782, 4431, 12879, 12973, 0, 0, 2, 1, 74, 1),
	(55782, 4432, 12879, 12973, 0, 0, 2, 1, 74, 1),
	(55782, 4473, 12879, 12973, 0, 0, 2, 1, 74, 1),
	(55783, 4428, 12973, 0, 0, 0, 2, 1, 8, 0),
	(55783, 4431, 12973, 0, 0, 0, 2, 1, 8, 0),
	(55783, 4432, 12973, 0, 0, 0, 2, 1, 8, 0),
	(55858, 4437, 12956, 0, 0, 0, 2, 1, 64, 11),
	(55858, 4438, 12956, 0, 0, 0, 2, 1, 64, 11),
	(55858, 4439, 12956, 0, 0, 0, 2, 1, 64, 11),
	(55858, 4440, 12956, 0, 0, 0, 2, 1, 64, 11),
	(55858, 4455, 12956, 0, 0, 0, 2, 1, 64, 11),
	(55858, 4495, 12956, 12967, 0, 0, 2, 1, 64, 11),
	(55952, 4438, 12967, 0, 0, 0, 2, 1, 64, 11),
	(55952, 4495, 12967, 0, 0, 0, 2, 1, 64, 11),
	(56057, 4497, 0, 12949, 0, 0, 2, 1, 64, 11),
	(56305, 4438, 12987, 12987, 0, 0, 2, 1, 74, 11),
	(56526, 4435, 13007, 13007, 0, 0, 2, 1, 74, 11),
	(56526, 4436, 13007, 13007, 0, 0, 2, 1, 74, 11),
	(56617, 4538, 0, 0, 0, 0, 2, 1, 64, 11),
	(56617, 4539, 0, 0, 0, 0, 2, 1, 64, 11),
	(56617, 4589, 0, 0, 0, 0, 2, 1, 64, 11),
	(56617, 4611, 0, 0, 0, 0, 2, 1, 64, 11),
	(56617, 4612, 0, 0, 0, 0, 2, 1, 64, 11),
	(56618, 4538, 0, 0, 0, 0, 2, 1, 64, 11),
	(56618, 4539, 0, 0, 0, 0, 2, 1, 64, 11),
	(56618, 4589, 0, 0, 0, 0, 2, 1, 64, 11),
	(56618, 4611, 0, 0, 0, 0, 2, 1, 64, 11),
	(56618, 4612, 0, 0, 0, 0, 2, 1, 64, 11),
	(56771, 4438, 12967, 0, 0, 0, 2, 1, 64, 11),
	(56772, 4438, 13001, 0, 0, 0, 2, 1, 64, 0),
	(56773, 4438, 12987, 0, 0, 0, 2, 1, 66, 0),
	(56774, 4438, 12976, 0, 0, 0, 2, 1, 64, 0),
	(56780, 4439, 12956, 12987, 0, 0, 2, 1, 64, 11),
	(57569, 4501, 13070, 13086, 0, 0, 2, 1, 64, 11),
	(57569, 4504, 13070, 13086, 0, 0, 2, 1, 64, 11),
	(57673, 4501, 0, 13070, 0, 0, 2, 1, 64, 11),
	(57673, 4504, 0, 13070, 0, 0, 2, 1, 64, 11),
	(57673, 4505, 0, 13086, 0, 0, 2, 1, 64, 11),
	(57673, 4506, 0, 13086, 0, 0, 2, 1, 64, 11),
	(57673, 4580, 0, 13086, 0, 0, 2, 1, 64, 11),
	(57673, 4593, 0, 13086, 0, 0, 2, 1, 64, 11),
	(57674, 4501, 13086, 13157, 0, 0, 2, 1, 64, 11),
	(57674, 4504, 13086, 13157, 0, 0, 2, 1, 64, 11),
	(57674, 4505, 13086, 13157, 0, 0, 2, 1, 64, 11),
	(57674, 4506, 13086, 13157, 0, 0, 2, 1, 64, 11),
	(57674, 4580, 13086, 13141, 0, 0, 2, 1, 64, 11),
	(57674, 4593, 13086, 13157, 0, 0, 2, 1, 64, 11),
	(57745, 4591, 13068, 13082, 0, 0, 2, 1, 74, 11),
	(57940, 65, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 66, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 67, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 206, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 210, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 394, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 395, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 1196, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 2817, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 3456, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 3477, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 3537, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 3711, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4100, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4196, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4228, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4264, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4265, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4272, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4273, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4277, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4395, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4415, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4416, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4436, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4493, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4494, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4603, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4723, 0, 0, 0, 0, 2, 1, 64, 11),
	(57940, 4813, 0, 0, 0, 0, 2, 1, 64, 11),
	(58045, 4197, 0, 0, 0, 0, 2, 1, 64, 11),
	(58354, 4281, 13165, 13189, 0, 690, 2, 1, 74, 11),
	(58354, 4281, 13165, 13188, 0, 1101, 2, 1, 74, 11),
	(58361, 4281, 13166, 13166, 0, 0, 2, 1, 74, 11),
	(58530, 0, 13165, 13188, -58354, 1101, 2, 1, 64, 11),
	(58551, 0, 13165, 13189, -58354, 690, 2, 1, 64, 11),
	(58600, 4395, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4560, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4567, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4568, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4570, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4598, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4613, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4614, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4616, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4618, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4619, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4620, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4637, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4739, 0, 0, 0, 0, 2, 1, 64, 11),
	(58600, 4740, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4197, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4538, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4539, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4575, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4577, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4581, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4582, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4583, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4585, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4589, 0, 0, 0, 0, 2, 1, 64, 11),
	(58730, 4612, 0, 0, 0, 0, 2, 1, 64, 11),
	(58932, 4169, 12499, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4169, 12500, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4170, 12499, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4170, 12500, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4171, 12499, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4171, 12500, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4172, 12499, 0, 0, 0, 2, 1, 64, 0),
	(58932, 4172, 12500, 0, 0, 0, 2, 1, 64, 0),
	(59062, 14, 13257, 13267, 0, 690, 2, 1, 74, 11),
	(59062, 85, 13266, 13267, 0, 690, 2, 1, 74, 11),
	(59062, 1497, 13266, 13267, 0, 690, 2, 1, 74, 11),
	(59062, 1637, 13257, 13267, 0, 690, 2, 1, 74, 11),
	(59073, 4522, 13386, 13392, 0, 1101, 2, 1, 66, 43),
	(59087, 4522, 13258, 13282, 0, 690, 2, 1, 66, 43),
	(60194, 3752, 0, 10528, 0, 0, 2, 1, 0, 11),
	(60197, 3752, 10528, 0, 0, 0, 2, 1, 64, 0),
	(60778, 4171, 12499, 0, 0, 0, 2, 1, 64, 11),
	(60778, 4171, 12500, 0, 0, 0, 2, 1, 64, 11),
	(60778, 4172, 12499, 0, 0, 0, 2, 1, 64, 11),
	(60778, 4172, 12500, 0, 0, 0, 2, 1, 64, 11),
	(60815, 14, 13369, 13377, 0, 1101, 2, 1, 74, 11),
	(60815, 85, 13371, 13377, 0, 1101, 2, 1, 74, 11),
	(60815, 1497, 13371, 13377, 0, 1101, 2, 1, 74, 11),
	(60815, 1637, 13369, 13377, 0, 1101, 2, 1, 74, 11),
	(60877, 1519, 13347, 13377, 0, 1101, 2, 1, 74, 11),
	(60943, 1519, 13371, 0, 0, 1101, 2, 1, 2, 0),
	(60943, 1637, 13266, 0, 0, 690, 2, 1, 2, 0),
	(60943, 4129, 13257, 0, 0, 690, 2, 1, 2, 0),
	(60963, 4466, 13285, 0, 0, 0, 2, 1, 74, 11),
	(61209, 4495, 12966, 12924, 0, 0, 2, 1, 74, 11),
	(64373, 4658, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4666, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4667, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4669, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4670, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4671, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4672, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4673, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4674, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4676, 0, 0, 0, 0, 2, 1, 64, 11),
	(64373, 4677, 0, 0, 0, 0, 2, 1, 64, 11),
	(64576, 4519, 13847, 13847, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13851, 13851, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13852, 13852, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13854, 13854, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13855, 13855, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13856, 13856, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13857, 13857, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13858, 13858, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13859, 13859, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13860, 13860, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13861, 13861, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13862, 13862, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13863, 13863, 0, 0, 2, 1, 74, 11),
	(64576, 4519, 13864, 13864, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13847, 13847, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13851, 13851, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13852, 13852, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13854, 13854, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13855, 13855, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13856, 13856, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13857, 13857, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13858, 13858, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13859, 13859, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13860, 13860, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13861, 13861, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13862, 13862, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13863, 13863, 0, 0, 2, 1, 74, 11),
	(64576, 4522, 13864, 13864, 0, 0, 2, 1, 74, 11),
	(67471, 4658, 13663, 13663, 0, 0, 2, 1, 74, 11),
	(68085, 4742, 0, 0, 0, 0, 2, 1, 64, 11),
	(68085, 4760, 0, 0, 0, 0, 2, 1, 64, 11),
	(68132, 4741, 0, 0, 0, 0, 2, 1, 64, 11),
	(68719, 4710, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4741, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4747, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4748, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4749, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4750, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4751, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4752, 0, 0, 0, 0, 2, 0, 64, 11),
	(68719, 4753, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4710, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4741, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4747, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4748, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4749, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4750, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4751, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4752, 0, 0, 0, 0, 2, 0, 64, 11),
	(68720, 4753, 0, 0, 0, 0, 2, 0, 64, 11),
	(69127, 4812, 0, 0, 0, 0, 2, 1, 64, 11),
	(70056, 4904, 0, 0, 0, 690, 2, 1, 64, 11),
	(70057, 4904, 0, 0, 0, 1101, 2, 1, 64, 11),
	(70193, 4075, 24553, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4075, 24564, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4075, 24594, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4075, 24595, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4075, 24596, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4075, 24598, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4092, 24535, 0, 0, 0, 2, 1, 10, 0),
	(70193, 4092, 24563, 0, 0, 0, 2, 1, 10, 0),
	(70889, 4192, 24545, 0, 0, 0, 2, 1, 10, 0),
	(71313, 4862, 24461, 24522, 0, 0, 2, 1, 74, 11),
	(71314, 4862, 24559, 24562, 0, 0, 2, 1, 74, 11),
	(72293, 4812, 0, 0, 0, 0, 2, 0, 64, 11),
	(72914, 4422, 12905, 0, 0, 0, 2, 1, 74, 11),
	(72914, 4425, 12905, 0, 0, 0, 2, 1, 74, 11),
	(72914, 4437, 12921, 13063, 0, 0, 2, 1, 74, 11),
	(72914, 4438, 12856, 12856, 0, 0, 2, 1, 74, 11),
	(72914, 4535, 12905, 0, 0, 0, 2, 1, 74, 11),
	(73001, 4892, 0, 0, 0, 0, 2, 0, 64, 11),
	(74276, 4910, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 3638, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 3698, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 3702, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 3968, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 4378, 0, 0, 0, 0, 2, 1, 64, 11),
	(74410, 4406, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2597, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2957, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2958, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2959, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2960, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2961, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2962, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2963, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2964, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2977, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 2978, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3017, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3057, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3058, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3277, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3297, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3298, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3299, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3300, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3301, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3302, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3303, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3304, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3305, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3306, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3317, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3318, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3320, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3321, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3337, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3338, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3358, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3418, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3420, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3421, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3422, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3423, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3424, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3820, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3869, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3870, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3871, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 3872, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4197, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4384, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4407, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4408, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4571, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4572, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4604, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4605, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4606, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4607, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4608, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4609, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4610, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4710, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4741, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4747, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4748, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4749, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4750, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4751, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4752, 0, 0, 0, 0, 2, 1, 64, 11),
	(74411, 4753, 0, 0, 0, 0, 2, 1, 64, 11),
	(74982, 368, 25446, 25446, 0, 0, 2, 1, 74, 11),
	(75434, 14, 25444, 25444, 0, 0, 2, 1, 74, 11),
	(75434, 367, 25444, 25444, 0, 0, 2, 1, 74, 11),
	(75434, 393, 25444, 25444, 0, 0, 2, 1, 74, 11);
/*!40000 ALTER TABLE `spell_area` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
