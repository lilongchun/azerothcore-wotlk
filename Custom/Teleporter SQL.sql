-- ----------------------------
-- Table structure for `eluna_teleporter`
-- ----------------------------
DROP TABLE IF EXISTS `eluna_teleporter`;
CREATE TABLE `eluna_teleporter` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `parent` int(5) NOT NULL DEFAULT '0',
  `type` int(1) NOT NULL DEFAULT '1',
  `faction` int(2) NOT NULL DEFAULT '-1',
  `icon` int(2) NOT NULL DEFAULT '0',
  `name` char(255) NOT NULL DEFAULT '',
  `map` int(5) DEFAULT NULL,
  `x` decimal(10,3) DEFAULT NULL,
  `y` decimal(10,3) DEFAULT NULL,
  `z` decimal(10,3) DEFAULT NULL,
  `o` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of eluna_teleporter
-- ----------------------------
INSERT INTO `eluna_teleporter` (id, parent, type, faction, icon, name, map, x, y, z, o) VALUES 
('1', '0', '1', '1', '0', 'Horde Cities', null, null, null, null, null),
('2', '0', '1', '0', '0', 'Alliance Cities', null, null, null, null, null),
('3', '0', '1', '-1', '0', 'Outlands Locations', null, null, null, null, null),
('4', '0', '1', '-1', '0', 'Northrend Locations', null, null, null, null, null),
('5', '0', '1', '-1', '0', 'PvP Locations', null, null, null, null, null),
('6', '1', '2', '1', '2', 'Orgrimmar', '1', '1503.000', '-4415.500', '22.000', '0.000'),
('7', '1', '2', '1', '2', 'Undercity', '0', '1831.000', '238.500', '61.600', '0.000'),
('8', '1', '2', '1', '2', 'Thunderbluff', '1', '-1278.000', '122.000', '132.000', '0.000'),
('9', '1', '2', '1', '2', 'Silvermoon', '530', '9484.000', '-7294.000', '15.000', '0.000'),
('10', '2', '2', '0', '2', 'Stormwind', '0', '-8905.000', '560.000', '94.000', '0.660'),
('11', '2', '2', '0', '2', 'Ironforge', '0', '-4795.000', '-1117.000', '499.000', '0.000'),
('12', '2', '2', '0', '2', 'Darnassus', '1', '9952.000', '2280.500', '1342.000', '1.600'),
('13', '2', '2', '0', '2', 'The Exodar', '530', '-3863.000', '-11736.000', '-106.000', '2.000'),
('14', '3', '2', '-1', '2', 'Blade\'s Edge Mountains', '530', '1481.000', '6829.000', '107.000', '6.000'),
('15', '3', '2', '-1', '2', 'Hellfire Peninsula', '530', '-249.000', '947.000', '85.000', '2.000'),
('16', '3', '2', '-1', '2', 'Nagrand', '530', '-1769.000', '7150.000', '-9.000', '2.000'),
('17', '3', '2', '-1', '2', 'Netherstorm', '530', '3043.000', '3645.000', '143.000', '2.000'),
('18', '3', '2', '-1', '2', 'Shadowmoon Valley', '530', '-3034.000', '2937.000', '87.000', '5.000'),
('19', '3', '2', '-1', '2', 'Terokkar Forest', '530', '-1942.000', '4689.000', '-2.000', '5.000'),
('20', '3', '2', '-1', '2', 'Zangarmarsh', '530', '-217.000', '5488.000', '23.000', '2.000'),
('21', '3', '2', '-1', '2', 'Shattrath', '530', '-1822.000', '5417.000', '1.000', '3.000'),
('22', '4', '2', '-1', '2', 'Borean Tundra', '571', '3230.000', '5279.000', '47.000', '3.000'),
('23', '4', '2', '-1', '2', 'Crystalsong Forest', '571', '5732.000', '1016.000', '175.000', '3.600'),
('24', '4', '2', '-1', '2', 'Dragonblight', '571', '3547.000', '274.000', '46.000', '1.600'),
('25', '4', '2', '-1', '2', 'Grizzly Hills', '571', '3759.000', '-2672.000', '177.000', '3.000'),
('26', '4', '2', '-1', '2', 'Howling Fjord', '571', '772.000', '-2905.000', '7.000', '5.000'),
('27', '4', '2', '-1', '2', 'Icecrown Glaicer', '571', '8517.000', '676.000', '559.000', '4.700'),
('28', '4', '2', '-1', '2', 'Sholazar Basin', '571', '5571.000', '5739.000', '-75.000', '2.000'),
('29', '4', '2', '-1', '2', 'Storm Peaks', '571', '6121.000', '-1025.000', '409.000', '4.700'),
('30', '4', '2', '-1', '2', 'Wintergrasp', '571', '5135.000', '2840.000', '408.000', '3.000'),
('31', '4', '2', '-1', '2', 'Zul\'Drak', '571', '5761.000', '-3547.000', '387.000', '5.000'),
('32', '4', '2', '-1', '2', 'Dalaran', '571', '5826.000', '470.000', '659.000', '1.400'),
('33', '5', '2', '-1', '2', 'Gurubashi Arena', '0', '-13229.000', '226.000', '33.000', '1.000'),
('34', '5', '2', '-1', '2', 'Dire Maul Arena', '1', '-3669.000', '1094.000', '160.000', '3.000'),
('35', '5', '2', '-1', '2', 'Nagrand Arena', '530', '-1983.000', '6562.000', '12.000', '2.000'),
('36', '5', '2', '-1', '2', 'Blade\'s Edge Arena', '530', '2910.000', '5976.000', '2.000', '4.000');

-- Custom additions
-- Starter locations
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (47, 0, 1, -1, 2, 'Ashzara Crater', 37, 131.000, 1012.000, 295.000, 5.000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (48, 47, 2, -1, 2, 'Startcamp', 37, 131.000, 1012.000, 295.000, 5.000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (49, 47, 2, -1, 2, 'Start2', 37, -117.003, 850.815, 294.579, 5.58488);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (50, 47, 2, -1, 2, 'Start3', 37, 147.987, 269.417, 273.524, 1.22673);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (51, 47, 2, -1, 2, 'Start4', 37, 902.614, 154.535, 285.419, 3.56091);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (52, 47, 2, -1, 2, 'Start5', 37, 865.102, 438.741, 281.501, 3.79633);

-- Custom Menu
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('63', '0', '1', '-1', '0', 'Custom Stuff', null, null, null, null, null);

-- Dungeons
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('80', '0', '1', '-1', '0', 'Dungeons', null, null, null, null, null);

INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (81, 80, 2, -1, 2, 'Baradin', 732, -1260.481812, 1049.593872, 106.995003, 3.159191);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (82, 80, 2, -1, 2, 'Stone Core', 646, 1028.265381, 626.221436, 156.673004, 4.986439);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (83, 80, 2, -1, 2, 'Zul Gurub', 0, -11916.7, -1212.82, 92.2868, 4.6095);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (84, 80, 2, -1, 2, 'Hellfirecitadell', 530, -305.816223, 3056.401611, -2.473183, 2.01);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (85, 80, 2, -1, 2, 'Coilfang Reservoir', 530, 517.288025, 6976.279785, 32.007198, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (86, 80, 2, -1, 2, 'Caverns of Time', 1, -8173.66, -4746.36, 33.8423, 4.93989);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (87, 80, 2, -1, 2, 'Auchidoun', 530, -3332.999512, 4923.144531, -101.360608, 2.326011);


-- Raids
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('150', '0', '1', '-1', '0', 'Raids', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('151', '150', '2', '-1', '2', 'Onyxia', 1, -4707.44, -3726.82, 54.6723, 3.8);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('152', '150', '2', '-1', '2', 'Molten Core', 230, 1121.451172, -454.316772, -101.329536, 3.5);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('153', '150', '2', '-1', '2', 'Blackwing Lair', 469, -7665.55, -1102.49, 400.679, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (154, 150, 2, -1, 2, 'RuinsAhn Qiraj', 1, -8409.032227, 1498.830933, 27.361542, 2.497567);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (155, 150, 2, -1, 2, 'Temple of Ahn Qiraj', 1, -8245.837891, 1983.736206, 129.071686, 0.936195);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (156, 150, 2, -1, 2, 'Naxxramas', 571, 3668.711182, -1262.581665, 243.519424, 4.785000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (157, 150, 2, -1, 2, 'Karazhan', 0, -11118.8, -2010.84, 47.0807, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (158, 150, 2, -1, 2, 'Gruul', 530, 3539.007568, 5082.357910, 1.691071, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (159, 150, 2, -1, 2, 'The Eye', 530, 3089.579346, 1399.046509, 187.653458, 4.794070);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (160, 150, 2, -1, 2, 'Zul Aman', 530, 6846.95, -7954.5, 170.028, 4.61501);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (161, 150, 2, -1, 2, 'Black Temple', 530, -3610.719482, 324.987579, 37.400028, 3.282981);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (162, 150, 2, -1, 2, 'Sun Well', 580, -1790.650024, 925.669983, 15.150000, 3.10000);
