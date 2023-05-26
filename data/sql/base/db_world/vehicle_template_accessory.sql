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

-- Dumping structure for table acore_world.vehicle_template_accessory
DROP TABLE IF EXISTS `vehicle_template_accessory`;
CREATE TABLE IF NOT EXISTS `vehicle_template_accessory` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `accessory_entry` int unsigned NOT NULL DEFAULT '0',
  `seat_id` tinyint NOT NULL DEFAULT '0',
  `minion` tinyint unsigned NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `summontype` tinyint unsigned NOT NULL DEFAULT '6' COMMENT 'see enum TempSummonType',
  `summontimer` int unsigned NOT NULL DEFAULT '30000' COMMENT 'timer, only relevant for certain summontypes',
  PRIMARY KEY (`entry`,`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.vehicle_template_accessory: ~193 rows (approximately)
DELETE FROM `vehicle_template_accessory`;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
	(24083, 24082, 0, 0, 'Proto-Drake Handler', 6, 120000),
	(24750, 24751, 0, 1, 'Excelsior rides Hidalgo the Master Falconer', 6, 30000),
	(25762, 25760, 0, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 1, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 2, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 3, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 4, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 5, 1, 'Kvaldir Raider', 8, 0),
	(25762, 25760, 6, 1, 'Kvaldir Raider', 8, 0),
	(25968, 25801, 0, 0, 'Nedar, Lord of Rhinos', 6, 30000),
	(27213, 27206, 0, 0, 'Onslaught Warhorse - Onslaught Knight', 8, 30000),
	(27241, 27268, 0, 0, 'Risen Gryphon', 6, 30000),
	(27587, 27163, 1, 1, '7th Legion Siege Engineer Rides Alliance Steam Tank', 5, 0),
	(27587, 27588, 2, 1, '7th Legion Elite Rides Alliance Steam Tank', 5, 0),
	(27587, 27588, 3, 1, '7th Legion Elite Rides Alliance Steam Tank', 5, 0),
	(27626, 27627, 0, 0, 'Tatjana\'s Horse', 8, 30000),
	(27661, 27662, 0, 0, 'Wintergarde Gryphon', 6, 30000),
	(27939, 32576, 0, 0, 'Orabus the Helmsman', 8, 0),
	(27939, 32577, 1, 0, 'Kvaldir Crewman', 8, 0),
	(27939, 32578, 2, 0, 'Kvaldir Crewman', 8, 0),
	(27939, 32579, 3, 0, 'Kvaldir Crewman', 8, 0),
	(27939, 32580, 4, 0, 'Kvaldir Crewman', 8, 0),
	(28018, 28006, 0, 0, 'Thiassi the Light Bringer', 8, 0),
	(28054, 28053, -1, 0, 'Lucky Wilhelm - Apple', 6, 10000),
	(28312, 28319, 7, 1, 'Wintergrasp Siege Engine', 6, 30000),
	(28468, 28451, 1, 1, 'Stampy', 8, 0),
	(28614, 28616, 0, 1, 'Scarlet Gryphon Rider', 6, 30000),
	(28669, 28717, 1, 1, 'Flying Fiend', 8, 0),
	(28710, 28646, 0, 1, 'Pilot Vic', 7, 0),
	(28782, 28768, 0, 0, 'Acherus Deathcharger', 6, 30000),
	(29351, 29558, 0, 1, 'Niffelem Frost Giant', 8, 30000),
	(29351, 29558, 1, 1, 'Niffelem Frost Giant', 8, 30000),
	(29351, 29558, 2, 1, 'Niffelem Frost Giant', 8, 30000),
	(29351, 29558, 3, 1, 'Niffelem Frost Giant', 8, 30000),
	(29358, 29558, 0, 1, 'Frostworg', 8, 30000),
	(29358, 29558, 1, 1, 'Frostworg', 8, 30000),
	(29433, 29440, 0, 0, 'Goblin Sapper in K3', 6, 30000),
	(29500, 29498, 0, 1, 'Brunnhildar Warbear', 8, 0),
	(29555, 29556, 0, 0, 'Goblin Sapper', 6, 30000),
	(29579, 29599, 0, 1, 'Brann Snow Target', 7, 0),
	(29625, 29694, 1, 1, 'Hyldsmeet Proto-Drake', 6, 30000),
	(29698, 29699, 0, 0, 'Drakuru Raptor', 6, 30000),
	(29708, 29805, 0, 1, 'Captive Proto-Drake', 8, 0),
	(29838, 29836, 0, 0, 'Drakkari Battle Rider on Drakkari Rhino, not minion', 6, 30000),
	(29863, 28518, 0, 1, 'Persistence', 8, 0),
	(29931, 29982, 0, 0, 'Drakkari Rider on Drakkari Rhino', 6, 300),
	(29931, 29982, 1, 0, 'Drakkari Rider on Drakkari Rhino', 6, 300),
	(29931, 29982, 2, 0, 'Drakkari Rider on Drakkari Rhino', 6, 300),
	(30013, 29730, 0, 0, 'Frostborn Stormrider', 6, 30000),
	(30134, 30107, 0, 1, 'Brann Bronzebeard', 8, 0),
	(30174, 30175, 0, 1, 'Hyldsmeet Bear Rider', 8, 0),
	(30234, 30245, 0, 1, 'Hover Disk - Nexus Lord', 6, 1000),
	(30330, 30332, 0, 1, 'Jotunheim Proto-Drake', 6, 30000),
	(30393, 30390, 0, 0, 'Thorim', 4, 180000),
	(31262, 31263, 0, 0, 'Carrion Hunter rides Blight Falconer', 6, 300),
	(31269, 27559, 0, 0, 'Kor\'kron Battle Wyvern', 6, 300),
	(31406, 31408, 0, 1, 'Alliance Bomber Seat on Alliance Infra-green Bomber', 8, 0),
	(31406, 31407, 1, 1, 'Alliance Turret Seat on Alliance Infra-green Bomber', 8, 0),
	(31406, 31409, 2, 1, 'Alliance Engineering Seat on rides Alliance Infra-green Bomber', 8, 0),
	(31406, 32217, 3, 1, 'Banner Bunny, Hanging, Alliance on Alliance Infra-green Bomber', 8, 0),
	(31406, 32221, 4, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0),
	(31406, 32221, 5, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0),
	(31406, 32256, 6, 1, 'Shield Visual Loc Bunny on Alliance Infra-green Bomber', 8, 0),
	(31406, 32274, 7, 1, 'Alliance Bomber Pilot rides Alliance Infra-green Bomber', 8, 0),
	(31583, 31630, 0, 1, 'Frostbrood Skytalon Explosion Bunny', 6, 30000),
	(31838, 31856, 0, 1, 'Horde Bomber Seat on Horde Infra-green Bomber', 8, 0),
	(31838, 31840, 1, 1, 'Horde Turret Seat on Horde Infra-green Bomber', 8, 0),
	(31838, 32152, 2, 1, 'Horde Engineering Seat on rides Horde Infra-green Bomber', 8, 0),
	(31838, 32214, 3, 1, 'Banner Bunny, Hanging, Horde on Horde Infra-green Bomber', 8, 0),
	(31838, 32215, 4, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0),
	(31838, 32215, 5, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0),
	(31838, 32256, 6, 1, 'Shield Visual Loc Bunny on Horde Infra-green Bomber', 8, 0),
	(31838, 32317, 7, 1, 'Horde Bomber Pilot rides Horde Infra-green Bomber', 8, 0),
	(31881, 31891, 0, 1, 'Kor\'kron Transport Pilot rides Kor\'kron Troop Transport', 6, 300),
	(31881, 31884, 1, 1, 'Kor\'kron Suppression Turret on Kor\'kron Troop Transport', 8, 0),
	(31881, 31882, 2, 0, 'Kor\'kron Infiltrator on Kor\'kron Troop Transport', 6, 300),
	(31881, 31882, 3, 0, 'Kor\'kron Infiltrator on Kor\'kron Troop Transport', 6, 300),
	(31881, 31882, 4, 0, 'Kor\'kron Infiltrator on Kor\'kron Troop Transport', 6, 300),
	(31881, 31882, 5, 0, 'Kor\'kron Infiltrator on Kor\'kron Troop Transport', 6, 300),
	(32189, 32190, 0, 1, 'Skybreaker Recon Fighter', 6, 30000),
	(32225, 32223, 0, 1, 'Skybreaker Transport Pilot rides Skybreaker Troop Transport', 6, 300),
	(32225, 32227, 1, 1, 'Skybreaker Suppression Turret on Skybreaker Troop Transport', 8, 0),
	(32225, 32222, 2, 0, 'Skybreaker Infiltrator on Skybreaker Troop Transport', 6, 300),
	(32225, 32222, 3, 0, 'Skybreaker Infiltrator on Skybreaker Troop Transport', 6, 300),
	(32225, 32222, 4, 0, 'Skybreaker Infiltrator on Skybreaker Troop Transport', 6, 300),
	(32225, 32222, 5, 0, 'Skybreaker Infiltrator on Skybreaker Troop Transport', 6, 300),
	(32344, 32274, 0, 0, 'Alliance Bomber Pilot rides Alliance Rescue Craft', 6, 300),
	(32344, 32531, 2, 1, 'Banner Bunny, Side, Alliance, Small rides Alliance Rescue Craft', 8, 0),
	(32490, 32486, 0, 0, 'Scourge Death Knight rides Scourge Deathcharger', 6, 300),
	(32512, 31408, 0, 1, 'Alliance Bomber Seat on Alliance Infra-green Bomber', 8, 0),
	(32512, 31407, 1, 1, 'Alliance Turret Seat on Alliance Infra-green Bomber', 8, 0),
	(32512, 31409, 2, 1, 'Alliance Engineering Seat on rides Alliance Infra-green Bomber', 8, 0),
	(32512, 32217, 3, 1, 'Banner Bunny, Hanging, Alliance on Alliance Infra-green Bomber', 8, 0),
	(32512, 32221, 4, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0),
	(32512, 32221, 5, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0),
	(32512, 32256, 6, 1, 'Shield Visual Loc Bunny on Alliance Infra-green Bomber', 8, 0),
	(32512, 32274, 7, 1, 'Alliance Bomber Pilot rides Alliance Infra-green Bomber', 8, 0),
	(32513, 31856, 0, 1, 'Horde Bomber Seat on Horde Infra-green Bomber', 8, 0),
	(32513, 31840, 1, 1, 'Horde Turret Seat on Horde Infra-green Bomber', 8, 0),
	(32513, 32152, 2, 1, 'Horde Engineering Seat on rides Horde Infra-green Bomber', 8, 0),
	(32513, 32214, 3, 1, 'Banner Bunny, Hanging, Horde on Horde Infra-green Bomber', 8, 0),
	(32513, 32215, 4, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0),
	(32513, 32215, 5, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0),
	(32513, 32256, 6, 1, 'Shield Visual Loc Bunny on Horde Infra-green Bomber', 8, 0),
	(32513, 32317, 7, 1, 'Horde Bomber Pilot rides Horde Infra-green Bomber', 8, 0),
	(32627, 32629, 7, 1, 'Wintergrasp Siege Engine', 6, 30000),
	(32633, 32638, 1, 1, 'Traveler Mammoth (A) - Vendor', 6, 30000),
	(32633, 32639, 2, 1, 'Traveler Mammoth (A) - Vendor & Repairer', 6, 30000),
	(32640, 32642, 1, 1, 'Traveler Mammoth (H) - Vendor', 6, 30000),
	(32640, 32641, 2, 1, 'Traveler Mammoth (H) - Vendor & Repairer', 6, 30000),
	(32823, 34812, 0, 1, 'Bountiful Table - The Turkey Chair', 8, 0),
	(32823, 34823, 1, 1, 'Bountiful Table - The Cranberry Chair', 8, 0),
	(32823, 34819, 2, 1, 'Bountiful Table - The Stuffing Chair', 8, 0),
	(32823, 34824, 3, 1, 'Bountiful Table - The Sweet Potato Chair', 8, 0),
	(32823, 34822, 4, 1, 'Bountiful Table - The Pie Chair', 8, 0),
	(32823, 32830, 5, 1, 'Bountiful Table - Food Holder', 8, 0),
	(32823, 32840, 6, 1, 'Bountiful Table - Plate Holder', 8, 0),
	(32830, 32824, 0, 1, 'Food Holder - [PH] Pilgrim\'s Bounty Table - Turkey', 8, 0),
	(32830, 32827, 1, 1, 'Food Holder - [PH] Pilgrim\'s Bounty Table - Cranberry Sauce', 8, 0),
	(32830, 32831, 2, 1, 'Food Holder - [PH] Pilgrim\'s Bounty Table - Stuffing', 8, 0),
	(32830, 32825, 3, 1, 'Food Holder - [PH] Pilgrim\'s Bounty Table - Yams', 8, 0),
	(32830, 32829, 4, 1, 'Food Holder - [PH] Pilgrim\'s Bounty Table - Pie', 8, 0),
	(33060, 33067, 7, 1, 'Salvaged Siege Engine', 6, 30000),
	(33109, 33167, 1, 1, 'Salvaged Demolisher', 6, 30000),
	(33109, 33620, 2, 1, 'Earthen Stoneshaper', 6, 30000),
	(33113, 33114, 0, 1, 'Flame Leviathan Seat', 6, 30000),
	(33113, 33114, 1, 1, 'Flame Leviathan Seat', 6, 30000),
	(33113, 33114, 2, 1, 'Flame Leviathan Seat', 6, 30000),
	(33113, 33114, 3, 1, 'Flame Leviathan Seat', 6, 30000),
	(33113, 33139, 7, 1, 'Flame Leviathan Cannon', 6, 30000),
	(33114, 33142, 1, 1, 'leviathan seat defense turret', 6, 30000),
	(33114, 33143, 2, 1, 'leviathan seat overload device', 6, 30000),
	(33214, 33218, 1, 0, 'Mechanolift 304-A', 6, 30000),
	(33432, 34071, 3, 0, 'Mimiron Leviathan Mk II', 8, 0),
	(33669, 33666, 0, 0, 'Demolisher Engineer Blastwrench', 6, 30000),
	(33687, 33695, 0, 1, 'Chillmaw', 6, 30000),
	(33687, 33695, 1, 1, 'Chillmaw', 6, 30000),
	(33687, 33695, 2, 1, 'Chillmaw', 6, 30000),
	(33778, 33780, 0, 0, 'Tournament Hippogryph', 6, 30000),
	(34106, 34071, 3, 0, 'Mimiron Leviathan Mk II', 8, 0),
	(34146, 34137, 0, 0, 'Snow Mound', 8, 0),
	(34146, 34137, 1, 0, 'Snow Mound', 8, 0),
	(34146, 34137, 2, 0, 'Snow Mound', 8, 0),
	(34146, 34137, 3, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 0, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 1, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 2, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 3, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 4, 0, 'Snow Mound', 8, 0),
	(34150, 34137, 5, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 0, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 1, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 2, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 3, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 4, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 5, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 6, 0, 'Snow Mound', 8, 0),
	(34151, 34137, 7, 0, 'Snow Mound', 8, 0),
	(34776, 34778, 1, 1, 'Isle of Conquest Siege Engine  - flame turret 1 (ally)', 6, 30000),
	(34776, 34778, 2, 1, 'Isle of Conquest Siege Engine  - flame turret 2 (ally)', 6, 30000),
	(34776, 34777, 7, 1, 'Isle of Conquest Siege Engine  - main turret (ally)', 6, 30000),
	(34796, 34800, 0, 0, 'Gormok Snobold', 6, 30000),
	(34796, 34800, 1, 0, 'Gormok Snobold', 6, 30000),
	(34796, 34800, 2, 0, 'Gormok Snobold', 6, 30000),
	(34796, 34800, 3, 0, 'Gormok Snobold', 6, 30000),
	(35069, 36356, 1, 1, 'Isle of Conquest Siege Engine - flame turret 1 (horde)', 6, 30000),
	(35069, 36356, 2, 1, 'Isle of Conquest Siege Engine - flame turret 2 (horde)', 6, 30000),
	(35069, 36355, 7, 1, 'Isle of Conquest Siege Engine  - main turret (horde)', 6, 30000),
	(35491, 35451, 0, 0, 'Black Knight on his Gryphon', 8, 0),
	(36476, 36477, 0, 0, 'Krick and Ick', 6, 30000),
	(36661, 36658, 0, 0, 'Scourgelord Tyrannus and Rimefang', 6, 30000),
	(36678, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000),
	(36678, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000),
	(36891, 31260, 0, 0, 'Ymirjar Skycaller on Drake', 6, 30000),
	(36896, 28717, 1, 0, 'Overlord Drakuru on Stonespine Gargoyle', 6, 30000),
	(38431, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000),
	(38431, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000),
	(38585, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000),
	(38585, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000),
	(38586, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000),
	(38586, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000),
	(40081, 40083, 0, 1, 'Orb Carrier', 6, 30000),
	(40081, 40100, 1, 1, 'Orb Carrier', 6, 30000),
	(40470, 40083, 0, 1, 'Orb Carrier', 6, 30000),
	(40470, 40100, 1, 1, 'Orb Carrier', 6, 30000),
	(40471, 40083, 0, 1, 'Orb Carrier', 6, 30000),
	(40471, 40100, 1, 1, 'Orb Carrier', 6, 30000),
	(40471, 40468, 2, 1, 'Orb Carrier', 6, 30000),
	(40471, 40469, 3, 1, 'Orb Carrier', 6, 30000),
	(40472, 40083, 0, 1, 'Orb Carrier', 6, 30000),
	(40472, 40100, 1, 1, 'Orb Carrier', 6, 30000),
	(40472, 40468, 2, 1, 'Orb Carrier', 6, 30000),
	(40472, 40469, 3, 1, 'Orb Carrier', 6, 30000);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
