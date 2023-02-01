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

-- Dumping structure for table acore_characters.updates
DROP TABLE IF EXISTS `updates`;
CREATE TABLE IF NOT EXISTS `updates` (
  `name` varchar(200) NOT NULL COMMENT 'filename with extension of the update.',
  `hash` char(40) DEFAULT '' COMMENT 'sha1 hash of the sql file.',
  `state` enum('RELEASED','CUSTOM','MODULE','ARCHIVED') NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp when the query was applied.',
  `speed` int unsigned NOT NULL DEFAULT '0' COMMENT 'time the query takes to apply in ms.',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='List of all applied updates in this database.';

-- Dumping data for table acore_characters.updates: 57 rows
DELETE FROM `updates`;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
INSERT INTO `updates` (`name`, `hash`, `state`, `timestamp`, `speed`) VALUES
	('2021_01_25_00.sql', '64733EF8381E24919D2B80E2E8524EA29651706F', 'ARCHIVED', '2021-10-15 01:01:27', 55),
	('2021_03_28_00.sql', '7CCFD84E6866D3CCD6ED08818C6D2D375C1B4F2F', 'ARCHIVED', '2021-10-15 01:01:27', 46),
	('2021_04_25_00.sql', '10264658F0C3BC460AAE00871DE316D5EB3CE29C', 'ARCHIVED', '2021-10-15 01:01:28', 302),
	('2021_04_27_00.sql', 'A4F55A0714C7A205A3431CD85486AF3DA0EB386D', 'ARCHIVED', '2021-10-15 01:01:28', 68),
	('2021_04_29_00.sql', '2D91E2B5E2930FFFD97686CF164EFBACC4E15D75', 'ARCHIVED', '2021-10-15 01:01:28', 64),
	('2021_05_28_00.sql', '4B2B5E140376765534BBEB646E12C9B0BE21124F', 'ARCHIVED', '2021-10-15 01:01:28', 48),
	('2021_05_30_00.sql', '485DD24DC4BB64E488C9E57EED6AE5599080B9D4', 'ARCHIVED', '2021-10-15 01:01:28', 63),
	('2021_06_08_00.sql', '5F098821777262235B41F8F987D5075290C10B25', 'ARCHIVED', '2021-10-15 01:01:28', 55),
	('2021_06_18_00.sql', 'DDBD76B308AF2913A84F444BE46DBF4D74C7AB7A', 'ARCHIVED', '2021-10-15 01:01:28', 59),
	('2021_06_22_00.sql', 'BDCD91F558FC53DCED73762F2A21383E6727699A', 'ARCHIVED', '2021-10-15 01:01:28', 65),
	('2021_06_23_00.sql', '92354482E2319AC5BC85F186DEEFA856AF20DFA9', 'ARCHIVED', '2021-10-15 01:01:28', 70),
	('2021_06_30_00.sql', '8F7D9659DEBF99A79341ED980434A901E87F6BEE', 'ARCHIVED', '2021-10-15 01:01:28', 71),
	('2021_07_06_00.sql', 'E2B95774C0CD17EE221D575D206B367D7B74D3FE', 'ARCHIVED', '2021-10-15 01:01:28', 45),
	('2021_07_08_00.sql', '524B15817531D3A6220DA7D88FF71C990EAD5EE7', 'ARCHIVED', '2021-10-15 01:01:28', 48),
	('2021_07_21_00.sql', 'F3FAE7AA245D9A98484CF6A010608BD0D3A5CEF8', 'ARCHIVED', '2021-10-15 01:01:28', 63),
	('2021_09_13_00.sql', 'BE22F6D5DACCF11F27B353AAE3A66056A0BC541A', 'ARCHIVED', '2021-10-15 01:01:28', 62),
	('2021_09_25_00.sql', '4A2003C9983E1F775032755E2BF7062CCE99FBB5', 'ARCHIVED', '2021-10-15 01:01:28', 62),
	('2016_07_09_00.sql', '6CB4253FF700E83A3FCB121714F32E4FFA70F0F4', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_08_14_00.sql', '38462AB366B96C1979F049A5FAF33A1C2DE25E65', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_07_09_01.sql', '5A20018FCAEC914DB359E807682F9B826865C2AB', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_07_10_00.sql', 'CA163905843EFB726CA838F463448E3833175F70', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_08_08_00.sql', '909B26A005C244E715027F8FF31D721D236403AF', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_07_30_00.sql', '7CEA690831DD7B6509FB165BD3C5BFF2138AB867', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_08_12_00.sql', '9902E3CD09738DA232C168AA374551C1DB2B902E', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_08_15_00.sql', '0490565BD304DC7CB73B5A1F4B2348BFD53B9C31', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_08_25_00.sql', '2318A3863066AD26B28F80C6ABC9DCCB86A136BA', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_11_18_00.sql', '0D4DB0CCC7D7ABF467B1B614E7A5FFCDD5E2A5A3', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2016_11_19_00.sql', '4981B8C9F2368AFB5EDB3160FF9CC63AFD9DB3D9', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_12_09_00.sql', '04D33DE31942314C86AC20EA39D74C44228E9819', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2017_09_18_00.sql', '393373BB3CB5525ECF5A69661170AE0B49677AC3', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2018_12_23_00.sql', '0135EE4A7AA472A4BB6F9B76BABE84F8A45645D2', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2018_04_19_00.sql', '1DFB571DEDBACAC579229C7365A2F52330BB84B4', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_05_15_00.sql', 'E2D51033471C04D47DA3C091B2FB7D2BBB816E8B', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_01_06_00.sql', '043ADFE28ABFBEA7304FCE95183C385646CF78D8', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2018_08_08_00.sql', '8623083F006C05A08D5B1322FF3EFE7304AEB6FC', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_02_17_00.sql', 'FF8DE7049A60865CBE70B9736A9B63296A3969DF', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_05_12_00.sql', '75DB225858A4D21DA92D21AC292A9DD9A5551BA5', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2019_11_22_00.sql', 'CA433BC426072EF7DDC555B086F65B17BB83CAF5', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2020_01_04_00.sql', '7DA0D914F60BE3827068447FE4EA6AA85266E328', 'ARCHIVED', '2021-10-14 07:13:44', 1),
	('2021_10_14_00.sql', 'FD481BA8924F107B9B5B2359999820D57A016907', 'ARCHIVED', '2021-10-15 01:01:28', 46),
	('2021_10_14_01_characters.sql', 'D34A3947055382A390A134D91DD68903CA5FA7C4', 'ARCHIVED', '2022-01-22 02:39:14', 21),
	('2021_11_06_00.sql', 'B36ED498D42A54BC818B6027AB1F92A7ACD0DA25', 'ARCHIVED', '2022-01-22 02:39:14', 70),
	('2021_12_26_00.sql', '089B77AAA7C676D7850070C1C05644CC50EC7F36', 'ARCHIVED', '2022-01-22 02:39:14', 46),
	('2021_12_26_01.sql', '22C450827DB8E89AF4B0F6B23B3D829B96F69B6A', 'ARCHIVED', '2022-01-22 02:39:14', 54),
	('2022_01_25_00.sql', '784BA8C193B91B471A6E6B8C4D5BCA5850AB883A', 'ARCHIVED', '2022-04-24 18:20:00', 51),
	('2022_01_29_00.sql', '1EADA7852AC70F49E8EA0030CC5FA087075F9DD4', 'ARCHIVED', '2022-04-24 18:20:00', 40),
	('2022_02_16_00.sql', '60440F15D2DD99B7327FD5BB77E03B44B29768EE', 'ARCHIVED', '2022-04-24 18:20:00', 33),
	('2022_03_01_00.sql', 'CB1DF259CAF17989F36DC7E24DFA7B08F86AE6FD', 'ARCHIVED', '2022-04-24 18:20:00', 61),
	('2022_04_19_00.sql', '5D7010FF56BC3BDFF19BEEDCE394471F768763FE', 'ARCHIVED', '2022-04-24 18:20:00', 62),
	('2022_04_24_00.sql', 'A2533CA2289827F447D37EDD003F84D44FCB3B98', 'ARCHIVED', '2022-08-21 12:57:27', 48),
	('2022_04_28_00.sql', 'C311595439669E38C754C975DDD0FD0ECCDD446B', 'ARCHIVED', '2022-08-21 12:57:27', 35),
	('2022_05_24_00.sql', '4E4A70F946ECB111D9C2197BB87A3930E5AC5B5C', 'ARCHIVED', '2022-08-21 12:57:27', 38),
	('2022_08_02_00.sql', '91C7A066B1885F9AE59CF74FFF327D9A1875ED8B', 'ARCHIVED', '2022-08-21 12:57:27', 30),
	('2022_08_07_00.sql', 'AC270742E652BFD6AF1A5C7F0DEC943C95CC3880', 'ARCHIVED', '2022-08-21 12:57:27', 46),
	('2022_08_21_00.sql', 'E333B1A3FD1A25298D29B8FCAA0EE8AE5985202F', 'RELEASED', '2023-01-31 23:21:23', 30),
	('2022_10_13_00.sql', '7121BF9B0A15DA47B60438C82F6A8CA382F35D50', 'RELEASED', '2023-01-31 23:21:23', 54),
	('2022_10_20_00.sql', 'BD0C6FF81228F0D56448EBB0648819214835C595', 'RELEASED', '2023-01-31 23:21:23', 33);
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
