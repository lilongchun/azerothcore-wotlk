DROP TABLE IF EXISTS `forge_spell_scaling`; 
CREATE TABLE `forge_spell_scaling` ( `ID` INT NOT NULL DEFAULT '0', `CastTimeMin` INT NOT NULL DEFAULT '0', `CastTimeMax` INT NOT NULL DEFAULT '0', `CastTimeMaxLevel` INT NOT NULL DEFAULT '0', `Class` INT NOT NULL DEFAULT '0', `Coefficient_1` FLOAT NOT NULL DEFAULT '0', `Coefficient_2` FLOAT NOT NULL DEFAULT '0', `Coefficient_3` FLOAT NOT NULL DEFAULT '0', `Variance_1` FLOAT NOT NULL DEFAULT '0', `Variance_2` FLOAT NOT NULL DEFAULT '0', `Variance_3` FLOAT NOT NULL DEFAULT '0', `ComboPointsCoefficient_1` FLOAT NOT NULL DEFAULT '0', `ComboPointsCoefficient_2` FLOAT NOT NULL DEFAULT '0', `ComboPointsCoefficient_3` FLOAT NOT NULL DEFAULT '0', `CoefBase` FLOAT NOT NULL DEFAULT '0', `CoefBaseLevel` INT NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=MyISAM DEFAULT CHARSET=utf8; 
INSERT INTO `forge_spell_scaling` VALUES (1,1500,3500,20,8,1.004,0.035,0.221,0.242,0,0,0,0,0,0.45,20); 
INSERT INTO `forge_spell_scaling` VALUES (2,1500,3000,20,8,0,1,0,0,0.077,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (8,0,0,20,8,1.413,0,0,0.2,0,0,0,0,0,0.83,80); 
INSERT INTO `forge_spell_scaling` VALUES (9,2000,2000,20,8,1.933,0,0,0.15,0,0,0,0,0,0.485,80); 
INSERT INTO `forge_spell_scaling` VALUES (10,0,0,20,8,0.368,0,0,0.08,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (12,0,0,20,8,0.432,0,0,0,0,0,0,0,0,1,80); 
INSERT INTO `forge_spell_scaling` VALUES (13,0,0,20,8,0.989,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (14,0,0,20,8,0.542,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (15,0,0,20,8,0,0.84,0,0,0.09,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (16,0,0,20,8,1.378,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (17,0,0,20,8,1.113,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (18,1500,2500,20,8,1.2,0,0,0.242,0,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (19,2000,2000,20,8,0.662,0.103,0,0.202,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (20,0,0,20,8,0.424,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (21,1500,2000,20,8,0,0.884,0,0,0.242,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (22,1500,2500,20,8,0,0.949,0.00712,0,0.242,0,0,0,0,0.8,80); 
INSERT INTO `forge_spell_scaling` VALUES (23,0,0,20,8,0.432,0,0,0.242,0,0,0,0,0,0.8,80); 
INSERT INTO `forge_spell_scaling` VALUES (24,0,0,20,8,0.25,0,0,0,0,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (25,0,0,20,8,0.5,0,0,0,0,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (26,2100,3500,20,8,1.5,0.175,0,0.238,0,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (27,1500,1500,20,8,0.781,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (34,0,0,20,8,2.324,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (36,0,0,20,8,8.6088,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (37,0,0,20,8,1.585,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (38,0,0,20,8,0.203,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (41,0,0,20,8,0.048,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (42,0,0,20,11,0.72,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (50,0,0,20,11,0.095,0.221,0,0,0.2,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (51,1500,3000,20,11,7.97,0,0,0.166,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (52,0,0,20,11,0.327,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (53,0,0,20,11,0.138,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (54,0,0,20,11,0.07,3.657,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (55,0,0,20,11,0.2314,1.87292,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (56,0,0,20,11,0.057,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (57,0,0,20,11,1.764,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (58,0,0,20,11,0.396,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (59,0,0,20,11,0.057,0.057,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (60,0,0,20,11,0.057,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (61,1500,1500,20,11,3.628,0.366,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (62,0,0,20,11,1.325,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (63,0,0,20,11,0.057,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (64,0,0,20,11,0.404,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (66,3500,3200,20,11,1.383,0,0,0.22,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (67,0,0,20,11,0.942,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (68,0,0,20,11,0.181,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (69,0,0,20,11,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (70,0,0,20,11,3.935,0.348,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (71,0,0,20,11,0,1.316,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (72,0,0,20,11,0.431,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (73,1500,2500,20,11,0.896,0,0,0.12,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (75,-1000000,-1000000,20,3,0.2576,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (76,2900,2900,0,3,0.73,0,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (78,0,0,20,-1,6.09525,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (80,-1000000,-1000000,20,3,0.2535,0.934,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (81,0,0,20,3,0.285,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (82,-1000000,-1000000,20,3,0.365,0,0,0.187,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (83,0,0,20,3,0.198,0.026,0,0.25,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (84,0,0,20,-1,0,4,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (85,0,0,20,3,0.512,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (86,0,0,1,4,0.251,0,0,1,0,0,0.366,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (87,-1000000,-1000000,20,3,0.483,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (88,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (91,0,0,20,3,0.332,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (92,-1000000,-1000000,20,3,0.409,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (93,2000,2000,20,3,0.249,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (94,0,0,20,3,0.177,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (95,0,0,20,3,0.811,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (96,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (97,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (98,0,0,20,3,0.142,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (99,0,0,20,3,0.142,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (100,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (101,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (102,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (103,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (104,0,0,20,3,1.221,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (105,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (106,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (107,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (108,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (109,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (110,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (111,0,0,20,3,0.056,0.022,0,0.352,0.292,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (112,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (113,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (114,0,0,20,3,0,0.023,0,0,0.3,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (115,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (116,0,0,20,3,0.142,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (117,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (118,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (119,0,0,20,3,0.056,0.056,0,0.3,0.3,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (120,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (121,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (122,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (123,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (124,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (125,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (126,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (127,0,0,20,11,0.0576,0,0,0,0,0,0.163,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (128,0,0,20,11,0.383,0,0,0.74,0,0,0.584,0,0,0.439,80); 
INSERT INTO `forge_spell_scaling` VALUES (130,0,0,20,11,0.075,0,0,0,0,0,0.179,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (131,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (133,0,0,20,-1,1.32,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (135,0,0,20,1,0,0.759,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (139,0,0,20,1,0,0.376,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (140,0,0,20,1,0.075,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (141,0,0,20,1,1.598,0,0,0.2,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (142,0,0,20,1,0,1.706,0,0,0.05,0,0,0,0,0.3,80); 
INSERT INTO `forge_spell_scaling` VALUES (143,1500,1500,20,1,0.383,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (144,0,0,20,1,0.269,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (145,0,0,20,6,0.317,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (146,0,0,20,6,0.756,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (147,0,0,20,6,0.378,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (149,0,0,20,6,0.041,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (150,0,0,20,6,0.876,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (151,0,0,20,6,0.294,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (152,0,0,20,6,0.147,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (153,0,0,20,6,0.247,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (154,0,0,20,6,0.124,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (155,0,0,20,6,0.728,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (156,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (157,0,0,20,6,0,1.175,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (158,0,0,20,6,0.468,0,0,0.083,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (159,0,0,20,6,0.578,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (160,0,0,20,6,0.289,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (161,0,0,20,6,0.374,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (162,0,0,20,6,0.187,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (163,0,0,20,6,0.555,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (164,0,0,20,2,3.024,0,0,0.2,0,0,0,0,0,0.33,80); 
INSERT INTO `forge_spell_scaling` VALUES (168,0,0,20,-1,9.2,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (169,1500,1500,20,2,2.663,0.179,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (170,0,0,20,-1,1.04,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (171,1500,1500,20,2,7.119,0,0,0.115,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (175,0,0,20,2,3.9,0,0,0.1,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (176,1500,3000,20,2,4.274,0,0,0.108,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (178,0,0,20,2,2.66,0,0,0.08,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (179,0,0,20,2,1.416,0,0,0.08,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (180,0,0,20,2,2.333,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (181,0,0,20,2,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (182,0,0,20,2,0.118,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (184,0,0,20,2,0.593,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (185,1500,1500,20,5,5.746,5.746,0,0.25,0.25,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (186,0,0,20,5,2.571,0,0,0.1,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (187,0,0,20,5,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (188,0,0,20,5,0.144,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (189,1500,1500,20,5,7.174,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (190,1500,3000,20,5,3.587,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (191,2000,2000,20,5,1.083,0.054,0,0.238,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (192,0,0,20,5,0.316,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (193,0,0,20,5,1.94,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (194,0,0,20,-1,0,1.2,1.2,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (195,0,0,20,5,3.045,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (196,1500,1500,20,5,1.557,0,0,0.055,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (197,0,0,20,5,0.198,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (198,0,0,20,5,0.23,0,0,0.08,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (199,0,0,20,5,0.788,0,0,0.122,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (200,0,0,20,5,3.18,0,0,0.122,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (202,0,0,20,5,8.6088,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (204,2500,2500,20,5,3.359,0,0,0.055,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (205,0,0,20,5,3.144,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (207,0,0,20,5,1.295,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (209,0,0,20,5,0.357,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (210,0,0,20,5,0.206,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (211,1500,2500,20,5,0.733,0,0,0.115,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (212,1500,1500,20,5,0,0.101,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (213,0,0,20,4,0.327,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (214,0,0,20,4,0.307,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (215,-1000000,-1000000,20,4,0.143,0,0,0.25,0,0,0.222,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (216,0,0,20,4,0.214,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (217,0,0,20,4,0.326,0,0,1,0,0,0.476,0,0,0.414,80); 
INSERT INTO `forge_spell_scaling` VALUES (219,0,0,20,4,0.118,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (220,0,0,20,4,0.104,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (222,0,0,20,4,0.179,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (223,0,0,20,4,0.179,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (224,0,0,20,4,0.126,0,0,0,0,0,0.018,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (225,0,0,20,4,0.178,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (226,0,0,20,4,0.246,0,0,0.25,0,0,0,0,0,0,80); 
INSERT INTO `forge_spell_scaling` VALUES (227,0,0,20,4,0.12,0,0,0,0,0,0,0,0,0,80); 
INSERT INTO `forge_spell_scaling` VALUES (228,0,0,20,4,0.313,0,0,0.28,0,0,0,0,0,0,80); 
INSERT INTO `forge_spell_scaling` VALUES (229,0,0,20,4,0,0.245,0,0,0,0,0,0,0,0,80); 
INSERT INTO `forge_spell_scaling` VALUES (230,2500,2500,20,7,3.5,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (231,2000,2000,20,7,1.088,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (232,0,0,20,7,0.816,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (233,0,0,20,7,1.40976,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (234,0,0,20,7,0,0.927,0,0,0.053,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (236,0,0,20,7,0.574,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (237,0,0,20,7,0,0.785,0,0,0.112,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (239,0,0,20,7,0.529,0.142,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (243,0,0,20,7,0,0.869,0,0,0.056,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (244,0,0,20,7,0,0.609,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (245,0,0,20,7,0.028,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (247,1500,3000,20,7,2.989,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (248,2000,2000,20,7,1.579,0,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (249,1500,1500,20,7,4.782,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (250,1500,2500,20,7,0.767,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (251,1500,2500,20,7,0.575,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (252,0,0,20,7,0.389,0,0,0,0,0,0,0,0,0.35,80); 
INSERT INTO `forge_spell_scaling` VALUES (253,0,0,20,7,0.267,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (254,0,0,20,-1,0.736,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (255,0,0,20,7,2.353,1.113,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (256,1500,1500,20,7,0.096,0,0,0.3,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (257,0,0,20,-1,9.353,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (258,0,0,20,7,0.683,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (259,0,0,20,-1,9.2,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (260,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (261,0,0,20,7,1.63,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (263,0,0,20,-1,0,0.8,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (264,0,0,20,-1,1.712,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (265,0,0,20,-1,0,10,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (266,0,0,20,9,1.368,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (267,0,0,20,-1,1.32,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (268,0,2500,20,9,1.547,0,0,0.238,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (269,0,0,20,9,0,0.144,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (270,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (271,0,0,20,9,0.153,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (272,0,0,20,9,0,0,0.057,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (273,0,0,20,9,0.133,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (274,0,0,20,9,2.024,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (275,0,0,20,9,-0.191,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (277,0,0,20,9,1.227,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (278,0,0,20,9,0.784,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (279,0,0,20,9,2.437,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (280,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (281,0,0,20,9,0.0855,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (282,0,0,20,9,0.08,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (283,0,0,20,-1,1.44,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (285,2000,2500,20,9,0.123,0,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (286,1500,1500,20,9,0.9581,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (288,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (289,0,0,20,9,0,0.332,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (290,0,0,20,9,0.332,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (291,2000,2000,20,9,0,0.692,0.439,0,0,0,0,0,0,0.55,80); 
INSERT INTO `forge_spell_scaling` VALUES (292,2500,2500,20,9,0.573,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (293,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (297,0,0,20,9,0.201,0,0,0.16,0,0,0,0,0,-1,80); 
INSERT INTO `forge_spell_scaling` VALUES (298,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (299,0,0,20,9,0.797,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (300,0,0,20,9,9.706,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (301,1500,1500,20,9,0.322,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (302,2000,2000,20,9,0.3024,2.113,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (303,0,0,20,9,0.7656,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (304,0,0,20,9,1.5996,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (305,0,0,20,9,0.126,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (306,1700,3000,20,9,0.62,0,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (307,0,0,20,9,3.69,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (308,0,0,20,9,0,0.714,0,0,0.11,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (309,0,0,20,9,0.727,0,0,0.09,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (310,0,0,20,9,0.169,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (311,0,0,20,9,0.783,0,0,0.175,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (312,0,0,20,9,0.46,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (313,4000,4000,20,9,2.543,0,0,0.225,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (314,0,0,20,9,1.943,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (315,0,0,20,9,0.758,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (316,1500,1500,20,9,0,0.232,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (318,2000,2000,20,7,1.435,0,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (319,0,0,20,9,0,0,0.07,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (321,3000,3000,20,11,2.633,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (322,0,0,20,5,4.242,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (323,0,0,20,2,2.067,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (324,0,0,20,9,0.03,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (325,0,0,20,9,0.03,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (329,0,0,20,7,0.178,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (330,0,0,20,7,1.987,0,0,0.08,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (331,0,0,20,7,1.113,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (332,0,0,20,7,0.752,0,0,0.173,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (350,0,0,20,7,1.186,0,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (353,1500,3500,20,9,1.004,0.035,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (355,3000,3000,20,7,9.564,0,0,0.133,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (358,0,0,20,7,0.324,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (367,3000,3000,20,5,9.564,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (368,0,0,20,7,0.0192,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (370,0,0,20,11,1.056,0.589,0,0.21,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (372,2000,2000,20,1,0.246,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (373,0,0,20,9,0.248,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (376,0,0,20,11,5.3,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (377,3500,3500,20,11,1.124,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (378,1500,2000,20,11,0.582,0,0,0.12,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (380,0,0,20,7,0.869,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (381,0,0,20,-1,0,1.2,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (383,2000,2000,25,11,1.228,0,0,0.32,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (385,0,0,20,11,0.9464,0,0,0.19,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (386,0,0,20,-1,4.8,0.736,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (390,0,0,20,-1,4.8,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (391,0,0,20,-1,4.8,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (392,0,0,20,-1,4.8,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (393,0,0,20,-1,4.8,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (394,0,0,20,-1,0,0,0.736,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (395,0,0,20,-1,0,0,0.736,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (396,0,0,20,-1,1.32,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (397,0,0,20,-1,1.32,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (398,0,0,20,5,0.154,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (399,0,0,20,5,0.154,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (400,0,0,20,4,0.6,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (401,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (402,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (403,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (404,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (405,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (406,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (407,0,0,20,-1,27.32,0,0,0.05,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (408,0,0,20,8,1.392,0,0,0.225,0,0,0,0,0,0.8,80); 
INSERT INTO `forge_spell_scaling` VALUES (409,0,0,20,-1,4.8,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (410,2000,2000,20,9,0.148,0.499,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (411,0,0,20,9,0.151,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (418,1500,1500,20,5,1.178,0,0,0.055,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (462,0,0,20,-1,0,0.608,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (464,0,0,20,-1,0,0.608,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (465,0,0,20,-1,0,0.608,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (493,0,0,20,11,0.057,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (494,0,0,20,11,0,0,2.743,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (498,1500,1500,20,5,0.168,0,0,0.055,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (499,0,0,20,2,0.079,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (500,2000,2000,20,7,1.435,0,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (538,3000,3000,20,2,11.397,0,0,0.108,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (569,0,0,0,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (572,0,0,20,8,0.278,0,0,0.25,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (578,2400,2400,0,3,0.73,0,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (579,0,0,20,-1,13.965,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (581,0,0,20,3,0.82,0,0,0.16,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (583,0,0,20,8,1.318,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (584,0,0,20,8,1.054,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (585,0,0,20,8,0.791,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (586,0,0,20,8,0.527,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (587,0,0,20,8,0.264,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (588,0,0,20,-1,0,0.63333,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (593,0,0,20,1,0.075,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (594,0,0,20,1,0.075,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (595,0,0,20,1,0.149,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (596,1500,1500,20,1,0.383,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (597,0,0,20,1,0.383,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (598,0,0,20,1,0.383,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (600,0,0,20,2,0,0.19,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (601,0,0,20,2,0,0.285,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (603,0,0,20,8,0,0.278,0,0,0.25,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (606,0,0,20,1,0.075,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (620,0,0,20,9,0,0.501,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (621,1500,1500,0,9,0,0.174,0,0,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (622,2000,2000,20,9,1.593,0,0,0.166,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (624,0,0,20,9,-0.191,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (625,0,0,20,2,0.622,0.622,0,0.108,0.108,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (626,0,0,20,1,0.005,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (627,0,0,20,2,2.072,0.346,0,0.108,0,0,0,0,0,0.25,80); 
INSERT INTO `forge_spell_scaling` VALUES (629,1700,3000,20,9,1.056,0,0,0.11,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (634,0,0,20,6,0.498,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (637,0,0,20,9,0,0.059,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (638,0,0,20,6,0.249,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (639,0,0,20,9,0,-0.191,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (640,0,0,20,9,0.174,0,0,0,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (642,0,0,20,9,0.174,0,0,0,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (643,0,0,20,9,0.201,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (646,0,0,20,2,0.479,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (649,0,0,20,8,0.278,0,0,0.25,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (650,1500,2500,20,8,0.405,0,0,0.25,0,0,0,0,0,0,50); 
INSERT INTO `forge_spell_scaling` VALUES (651,0,0,20,8,0.41,0,0,0.15,0,0,0,0,0,0,50); 
INSERT INTO `forge_spell_scaling` VALUES (652,1500,2500,20,8,0.405,0,0,0.25,0,0,0,0,0,0,50); 
INSERT INTO `forge_spell_scaling` VALUES (654,0,0,20,7,2.79,0,0,0.12,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (656,0,0,20,7,1.395,0,0,0.12,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (658,0,0,20,2,1.296,0,0,0.14,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (659,0,0,20,2,2.591,0,0,0.14,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (660,0,0,20,2,0,0.095,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (661,0,0,20,9,1.333,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (662,0,0,20,9,0.153,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (663,0,0,20,5,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (664,0,0,20,5,0.646,0,0,0.165,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (666,0,0,20,5,0.514,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (668,0,0,20,7,0.028,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (672,2000,2000,20,8,0.235,0,0,0.1,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (673,2500,2500,20,8,0.328,0,0,0.242,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (674,2500,2500,20,8,0.259,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (675,2000,2000,20,8,0.662,0.103,0,0.202,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (678,0,0,20,2,0.708,0,0,0.4,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (679,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (681,0,0,20,-1,0,0,9.2,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (682,0,0,20,-1,0,0.736,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (684,-1000000,-1000000,20,3,0.409,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (685,-1000000,-1000000,20,3,0.409,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (686,0,0,20,5,0.633,0,0,0.115,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (690,0,0,20,5,2.353,0.742,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (691,0,0,20,5,5.977,0,0,0.16,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (692,0,0,20,5,0.346,0,0,0.173,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (693,0,0,20,-1,0,4,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (697,0,0,20,9,0.0855,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (699,-1000,-1000,20,3,0,1.44,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (700,1500,3000,20,9,0,0.147,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (701,0,0,20,-1,11.328,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (702,0,0,20,9,0.1155,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (703,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (705,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (706,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (707,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (708,500,500,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (709,0,0,20,3,1.1,0.423,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (711,0,0,20,-1,1.32,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (715,0,0,20,11,0.178,1.798,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (716,0,0,20,11,0.9275,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (720,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (721,0,0,20,9,3.69,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (723,0,0,20,5,22.456,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (724,0,0,0,9,0,0.174,0,0,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (725,1500,3000,20,9,0,0.0735,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (726,0,0,20,8,0,1.113,0,0,0.17,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (729,2100,3500,20,8,1.352,0.202,0,0.238,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (730,0,0,20,8,1.5,0.175,0,0.238,0,0,0,0,0,0.88,80); 
INSERT INTO `forge_spell_scaling` VALUES (737,0,0,20,11,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (738,0,0,20,5,3.144,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (739,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (740,0,0,20,11,0.095,0.221,0,0,0.2,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (741,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (746,0,0,20,-1,0,0,0.5888,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (747,0,0,20,5,0.177,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (749,0,0,20,3,0.184,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (753,0,0,20,1,0.094,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (754,0,0,20,-1,2.64,1.32,1.32,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (755,0,0,20,7,0,7.61,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (756,-10000,-10000,20,3,0,0,0,0,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (757,0,0,20,9,1.334,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (758,0,0,20,9,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (763,0,0,20,2,0.907,0,0,0.14,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (764,0,0,20,2,1.814,0,0,0.14,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (765,0,0,20,2,2.721,0,0,0.14,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (766,2000,2000,20,11,0,0.038,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (778,0,0,20,11,0.2314,2.3374,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (779,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (794,0,0,20,9,0,2.514,0,0,0.17,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (839,0,0,20,2,0.2366,0,0,0.3,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (840,0,0,20,9,0.485,0,0,0.12,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (841,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (842,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (843,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (844,0,0,20,3,0.221,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (845,0,0,20,3,0.221,0,0,0.35,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (847,0,0,20,-1,1.32,1.32,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (848,0,0,20,-1,2.64,2.64,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (849,1500,3500,20,8,1.004,0.035,0,0.242,0,0,0,0,0,0.45,20); 
INSERT INTO `forge_spell_scaling` VALUES (850,-1000000,-1000000,20,3,0.667,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (857,0,0,20,8,0,0.278,0,0,0.25,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (858,0,0,20,-1,0.508,0.678,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (863,0,0,20,-1,0.508,0.678,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (864,0,0,20,-1,0,1.08,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (865,0,0,20,-1,0,1.08,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (868,0,0,20,9,0.589,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (869,1500,3000,20,2,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (887,0,0,20,6,0.041,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (888,2000,2000,20,8,0.662,0.103,0,0.202,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (889,0,0,20,8,0.989,0,0,0.164,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (890,0,0,20,8,0.41,0,0,0.15,0,0,0,0,0,0,50); 
INSERT INTO `forge_spell_scaling` VALUES (891,0,0,20,8,1.113,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (895,0,0,20,11,0.095,0.221,0,0,0.2,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (896,0,0,20,3,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (928,0,0,20,11,0.095,0.221,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (938,0,0,20,1,0.383,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (939,0,0,20,6,0.041,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (952,0,0,20,8,8.6088,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (957,0,0,20,5,22.456,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (959,2500,2500,20,8,0,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (963,0,0,20,9,1.333,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (964,0,0,20,8,0.015,0,0,0.2,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (966,0,0,20,8,1.2,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (967,0,0,20,8,1.2,0,0,0.17,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (975,0,0,20,11,0.404,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (977,0,0,20,-1,5.175,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (978,0,0,20,5,7.174,0,0,0.15,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (979,1000,1000,85,-1,20,0,0,0.4,0,0,0,0,0,0,0); 
INSERT INTO `forge_spell_scaling` VALUES (980,500,500,1,-1,11.3,0,0,0.5,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1000,0,0,20,-1,0,0,9.2,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1006,0,0,20,11,2.99,0,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1012,0,0,20,-1,1.24,1.24,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1081,0,0,20,8,0,0.84,0,0,0.09,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1240,3000,3000,0,4,0,2.59,0,0,0.2,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1244,0,0,20,9,0,0.144,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1265,0,0,0,-1,1.015,1.015,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1274,0,0,20,-1,3.084,0.771,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1275,0,0,20,-1,3.93,0.983,0,0,0,0,0,0,0,1,0); 
INSERT INTO `forge_spell_scaling` VALUES (1276,0,0,20,-1,3.481,0.872,0,0,0,0,0,0,0,1,0); 


-- acore_world.forge_spell_scaling definition
drop table if exists `forge_spell_scaling_spells`;
CREATE TABLE `forge_spell_scaling_spells` (
  `SpellId` int NOT NULL,
  `ScalingId` int NOT NULL,
  PRIMARY KEY (`SpellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (17,202),
	 (53,214),
	 (116,21),
	 (120,15),
	 (122,20),
	 (133,18),
	 (136,88),
	 (139,207),
	 (172,271),
	 (331,247);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (348,291),
	 (403,250),
	 (421,231),
	 (465,168),
	 (467,68),
	 (469,133),
	 (543,34),
	 (585,211),
	 (588,194),
	 (589,210);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (596,204),
	 (603,274),
	 (633,181),
	 (635,176),
	 (686,306),
	 (687,279),
	 (689,281),
	 (703,219),
	 (755,288),
	 (772,140);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (774,62),
	 (779,67),
	 (879,169),
	 (974,233),
	 (980,273),
	 (1064,230),
	 (1079,127),
	 (1082,42),
	 (1120,282),
	 (1130,84);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (1449,10),
	 (1454,298),
	 (1463,37),
	 (1464,143),
	 (1490,275),
	 (1752,225),
	 (1776,220),
	 (1822,59),
	 (1943,224),
	 (1949,289);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (1978,92),
	 (2050,190),
	 (2060,367),
	 (2061,189),
	 (2098,217),
	 (2120,19),
	 (2136,17),
	 (2649,104),
	 (2812,180),
	 (2818,227);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (2912,66),
	 (2944,188),
	 (2948,27),
	 (2973,91),
	 (3044,75),
	 (3110,285),
	 (3606,256),
	 (3674,80),
	 (3716,315),
	 (5176,73);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (5185,51),
	 (5217,69),
	 (5221,63),
	 (5374,222),
	 (5405,407),
	 (5570,53),
	 (5672,245),
	 (5676,301),
	 (5677,254),
	 (5729,258);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (5730,579),
	 (5857,290),
	 (6117,41),
	 (6229,307),
	 (6307,267),
	 (6343,144),
	 (6353,313),
	 (6360,312),
	 (6572,141),
	 (6673,131);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (6785,60),
	 (6789,278),
	 (7001,195),
	 (7268,12),
	 (7294,182),
	 (7812,300),
	 (7814,297),
	 (7870,758),
	 (8004,249),
	 (8024,755);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (8034,244),
	 (8042,234),
	 (8050,239),
	 (8056,243),
	 (8072,259),
	 (8076,260),
	 (8092,196),
	 (8187,253),
	 (8232,265),
	 (8349,237);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (8676,213),
	 (8680,228),
	 (8921,50),
	 (8936,61),
	 (9007,58),
	 (10052,406),
	 (10057,405),
	 (10058,404),
	 (11113,13),
	 (11129,726);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (11366,26),
	 (11426,36),
	 (12294,139),
	 (13165,78),
	 (13218,229),
	 (13797,85),
	 (13812,83),
	 (14914,191),
	 (15237,192),
	 (15407,197);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (16827,99),
	 (17253,98),
	 (17735,314),
	 (17767,270),
	 (17877,308),
	 (18562,376),
	 (19236,187),
	 (19306,81),
	 (19434,76),
	 (19505,280);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (19658,757),
	 (19750,171),
	 (19891,170),
	 (20243,135),
	 (20572,848),
	 (22568,128),
	 (22570,130),
	 (22699,324),
	 (22703,840),
	 (23455,193);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (23922,142),
	 (24131,95),
	 (24275,175),
	 (24423,100),
	 (24604,103),
	 (24640,114),
	 (24844,106),
	 (25912,179),
	 (25914,178),
	 (26364,252);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (26679,215),
	 (27103,403),
	 (27243,302),
	 (27285,303),
	 (27576,223),
	 (28176,283),
	 (29722,292),
	 (30108,316),
	 (30153,293),
	 (30213,269);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (30283,311),
	 (30451,9),
	 (30455,23),
	 (31661,16),
	 (31707,650),
	 (31935,164),
	 (32120,679),
	 (32379,209),
	 (32546,185),
	 (32645,216);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (33076,205),
	 (33395,651),
	 (33697,754),
	 (33698,266),
	 (33702,847),
	 (33745,54),
	 (33763,55),
	 (33876,56),
	 (33878,57),
	 (34026,756);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (34861,186),
	 (34889,101),
	 (34913,38),
	 (34914,212),
	 (35290,126),
	 (35387,110),
	 (42208,14),
	 (42223,299),
	 (42231,52),
	 (42987,402);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (42988,401),
	 (43265,149),
	 (43991,304),
	 (44203,70),
	 (44425,8),
	 (44457,24),
	 (44461,25),
	 (44614,22),
	 (45284,251),
	 (45297,232);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (45462,161),
	 (45477,158),
	 (45902,146),
	 (47541,150),
	 (47666,199),
	 (47750,200),
	 (47897,309),
	 (47960,310),
	 (48181,286),
	 (48438,72);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (48721,145),
	 (49020,159),
	 (49143,153),
	 (49184,157),
	 (49821,198),
	 (49966,116),
	 (49998,151),
	 (50245,109),
	 (50256,123),
	 (50271,124);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (50274,120),
	 (50288,64),
	 (50318,115),
	 (50433,97),
	 (50464,321),
	 (50479,108),
	 (50498,113),
	 (50518,112),
	 (50519,118),
	 (50541,117);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (50590,868),
	 (50782,596),
	 (50783,598),
	 (50796,268),
	 (51490,261),
	 (51505,248),
	 (51945,236),
	 (52007,381),
	 (52127,263),
	 (52128,264);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (52212,939),
	 (53209,699),
	 (53301,82),
	 (53351,87),
	 (53600,184),
	 (54049,305),
	 (54424,386),
	 (54644,102),
	 (54680,107),
	 (54706,125);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (54786,794),
	 (55050,155),
	 (55090,163),
	 (55328,257),
	 (55749,96),
	 (56626,122),
	 (56641,93),
	 (57330,156),
	 (57386,121),
	 (58604,105);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (59638,672),
	 (59881,111),
	 (60089,1006),
	 (61193,119),
	 (61295,255),
	 (61391,71),
	 (61782,682),
	 (62618,723),
	 (64844,322),
	 (66188,152);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (66196,154),
	 (66198,160),
	 (66215,147),
	 (66216,162),
	 (71521,622),
	 (71757,408),
	 (72898,652),
	 (73510,418),
	 (73682,380),
	 (73683,331);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (73685,330),
	 (73899,329),
	 (73910,1),
	 (73921,332),
	 (74063,2),
	 (74860,86),
	 (76110,318),
	 (77451,350),
	 (77467,353),
	 (77472,355);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (77478,358),
	 (77661,368),
	 (77758,370),
	 (77767,372),
	 (77799,373),
	 (77960,377),
	 (77961,378),
	 (78674,383),
	 (78777,385),
	 (79038,390);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (79039,391),
	 (79057,392),
	 (79058,393),
	 (79061,462),
	 (79062,465),
	 (79063,464),
	 (79101,394),
	 (79102,395),
	 (79104,396),
	 (79105,397);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (79106,398),
	 (79107,399),
	 (79136,400),
	 (79579,409),
	 (79621,410),
	 (80313,494),
	 (80964,737),
	 (81101,597),
	 (81170,493),
	 (81297,499);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (81561,500),
	 (82207,979),
	 (82326,538),
	 (82327,1240),
	 (82661,569),
	 (82739,572),
	 (82928,578),
	 (83381,581),
	 (83619,583),
	 (83872,588);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (84137,593),
	 (84154,594),
	 (84721,603),
	 (84939,606),
	 (85112,700),
	 (85222,625),
	 (85285,869),
	 (85403,620),
	 (85547,624),
	 (85673,627);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (85692,629),
	 (85948,634),
	 (86061,638),
	 (86105,639),
	 (86121,640),
	 (86213,642),
	 (86230,643),
	 (86452,646),
	 (86704,839),
	 (86719,649);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (86958,654),
	 (86961,656),
	 (87188,658),
	 (87189,659),
	 (87385,661),
	 (87389,662),
	 (87427,663),
	 (87441,664),
	 (87532,666),
	 (87735,668);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (88082,673),
	 (88084,674),
	 (88148,675),
	 (88263,678),
	 (88325,681),
	 (88453,684),
	 (88466,685),
	 (88625,686),
	 (88684,691),
	 (88686,692);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (88691,693),
	 (89420,697),
	 (89637,980),
	 (89753,702),
	 (89792,703),
	 (89808,705),
	 (90309,706),
	 (90327,707),
	 (90337,708),
	 (90361,709);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (90364,711),
	 (90801,716),
	 (91644,720),
	 (91711,721),
	 (91986,725),
	 (92315,730),
	 (92380,749),
	 (93093,738),
	 (93282,739),
	 (93402,740);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (93433,779),
	 (93435,741),
	 (93744,746),
	 (94009,753),
	 (94286,763),
	 (94288,764),
	 (94289,765),
	 (94358,766),
	 (94447,778),
	 (95466,841);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (95467,842),
	 (95711,843),
	 (95714,844),
	 (95725,845),
	 (95917,849),
	 (95933,850),
	 (95969,857),
	 (96092,858),
	 (96161,863),
	 (96165,864);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (96168,865),
	 (97068,887),
	 (97070,888),
	 (97071,889),
	 (97078,890),
	 (97114,891),
	 (97224,895),
	 (97229,896),
	 (97547,928),
	 (97992,938);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (98864,952),
	 (98888,957),
	 (99062,959),
	 (99509,963),
	 (100037,964),
	 (100138,966),
	 (100287,967),
	 (100806,975),
	 (101033,977),
	 (101062,978);
INSERT INTO acore_world.forge_spell_scaling_spells (SpellId,ScalingId) VALUES
	 (102357,1000),
	 (102927,1012),
	 (104783,1081),
	 (107804,1276),
	 (109388,1244),
	 (109842,1274),
	 (109844,1275),
	 (109933,1265);

drop table if exists `forge_spell_scaling_value`;
CREATE TABLE `forge_spell_scaling_value` (
  `ScalingId` int NOT NULL,
  `value` int NOT NULL,
  PRIMARY KEY (`SpellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (0,23),
	 (1,24),
	 (2,25),
	 (3,25),
	 (4,25),
	 (5,26),
	 (6,27),
	 (7,28),
	 (8,30),
	 (9,31);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (10,32),
	 (11,34),
	 (12,35),
	 (13,37),
	 (14,40),
	 (15,42),
	 (16,45),
	 (17,48),
	 (18,51),
	 (19,54);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (20,59),
	 (21,64),
	 (22,70),
	 (23,76),
	 (24,82),
	 (25,89),
	 (26,96),
	 (27,103),
	 (28,111),
	 (29,120);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (30,128),
	 (31,138),
	 (32,147),
	 (33,157),
	 (34,168),
	 (35,179),
	 (36,190),
	 (37,203),
	 (38,215),
	 (39,228);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (40,238),
	 (41,247),
	 (42,257),
	 (43,266),
	 (44,277),
	 (45,287),
	 (46,297),
	 (47,308),
	 (48,319),
	 (49,330);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (50,341),
	 (51,352),
	 (52,364),
	 (53,376),
	 (54,388),
	 (55,400),
	 (56,413),
	 (57,426),
	 (58,478),
	 (59,492);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (60,512),
	 (61,533),
	 (62,554),
	 (63,576),
	 (64,599),
	 (65,622),
	 (66,645),
	 (67,670),
	 (68,695),
	 (69,720);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (70,746),
	 (71,773),
	 (72,800),
	 (73,828),
	 (74,857),
	 (75,886),
	 (76,916),
	 (77,947),
	 (78,978),
	 (79,1010);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (80,1033),
	 (81,1056),
	 (82,1079),
	 (83,1102),
	 (84,1125),
	 (85,1149),
	 (86,1173),
	 (87,1197),
	 (88,1222),
	 (89,1246);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (90,1271),
	 (91,1297),
	 (92,1322),
	 (93,1348),
	 (94,1374),
	 (95,1400),
	 (96,1426),
	 (97,1453),
	 (98,1480),
	 (99,1507);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (100,35),
	 (101,35),
	 (102,36),
	 (103,36),
	 (104,36),
	 (105,36),
	 (106,36),
	 (107,36),
	 (108,38),
	 (109,39);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (110,39),
	 (111,40),
	 (112,41),
	 (113,42),
	 (114,44),
	 (115,46),
	 (116,48),
	 (117,49),
	 (118,51),
	 (119,53);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (120,54),
	 (121,56),
	 (122,58),
	 (123,60),
	 (124,61),
	 (125,63),
	 (126,64),
	 (127,65),
	 (128,67),
	 (129,68);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (130,70),
	 (131,73),
	 (132,75),
	 (133,78),
	 (134,80),
	 (135,82),
	 (136,85),
	 (137,87),
	 (138,89),
	 (139,91);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (140,95),
	 (141,98),
	 (142,101),
	 (143,104),
	 (144,107),
	 (145,110),
	 (146,113),
	 (147,116),
	 (148,119),
	 (149,122);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (150,125),
	 (151,128),
	 (152,131),
	 (153,134),
	 (154,138),
	 (155,141),
	 (156,144),
	 (157,293),
	 (158,327),
	 (159,333);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (160,354),
	 (161,376),
	 (162,399),
	 (163,422),
	 (164,447),
	 (165,472),
	 (166,498),
	 (167,525),
	 (168,553),
	 (169,582);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (170,611),
	 (171,642),
	 (172,674),
	 (173,706),
	 (174,740),
	 (175,774),
	 (176,810),
	 (177,847),
	 (178,884),
	 (179,923);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (180,944),
	 (181,965),
	 (182,986),
	 (183,1008),
	 (184,1029),
	 (185,1052),
	 (186,1074),
	 (187,1096),
	 (188,1119),
	 (189,1142);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (190,1165),
	 (191,1189),
	 (192,1212),
	 (193,1236),
	 (194,1260),
	 (195,1284),
	 (196,1309),
	 (197,1334),
	 (198,1359),
	 (199,1384);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (200,5),
	 (201,6),
	 (202,6),
	 (203,7),
	 (204,7),
	 (205,8),
	 (206,9),
	 (207,9),
	 (208,10),
	 (209,11);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (210,12),
	 (211,13),
	 (212,14),
	 (213,16),
	 (214,17),
	 (215,19),
	 (216,21),
	 (217,23),
	 (218,25),
	 (219,27);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (220,30),
	 (221,32),
	 (222,35),
	 (223,38),
	 (224,41),
	 (225,44),
	 (226,48),
	 (227,51),
	 (228,55),
	 (229,59);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (230,63),
	 (231,67),
	 (232,72),
	 (233,77),
	 (234,81),
	 (235,87),
	 (236,92),
	 (237,98),
	 (238,103),
	 (239,109);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (240,116),
	 (241,124),
	 (242,132),
	 (243,140),
	 (244,148),
	 (245,157),
	 (246,166),
	 (247,176),
	 (248,186),
	 (249,197);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (250,207),
	 (251,219),
	 (252,230),
	 (253,243),
	 (254,255),
	 (255,268),
	 (256,282),
	 (257,296),
	 (258,339),
	 (259,355);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (260,377),
	 (261,399),
	 (262,423),
	 (263,448),
	 (264,474),
	 (265,500),
	 (266,528),
	 (267,558),
	 (268,588),
	 (269,620);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (270,653),
	 (271,687),
	 (272,722),
	 (273,759),
	 (274,797),
	 (275,837),
	 (276,878),
	 (277,921),
	 (278,965),
	 (279,1010);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (280,1033),
	 (281,1056),
	 (282,1079),
	 (283,1102),
	 (284,1125),
	 (285,1149),
	 (286,1173),
	 (287,1197),
	 (288,1222),
	 (289,1246);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (290,1271),
	 (291,1297),
	 (292,1322),
	 (293,1348),
	 (294,1374),
	 (295,1400),
	 (296,1426),
	 (297,1453),
	 (298,1480),
	 (299,1507);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (300,37),
	 (301,39),
	 (302,40),
	 (303,40),
	 (304,41),
	 (305,41),
	 (306,43),
	 (307,45),
	 (308,48),
	 (309,50);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (310,52),
	 (311,54),
	 (312,56),
	 (313,60),
	 (314,63),
	 (315,68),
	 (316,72),
	 (317,77),
	 (318,81),
	 (319,86);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (320,90),
	 (321,94),
	 (322,99),
	 (323,103),
	 (324,107),
	 (325,111),
	 (326,116),
	 (327,120),
	 (328,124),
	 (329,129);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (330,133),
	 (331,138),
	 (332,142),
	 (333,146),
	 (334,150),
	 (335,155),
	 (336,159),
	 (337,163),
	 (338,167),
	 (339,171);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (340,182),
	 (341,193),
	 (342,205),
	 (343,218),
	 (344,230),
	 (345,244),
	 (346,258),
	 (347,272),
	 (348,287),
	 (349,302);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (350,318),
	 (351,335),
	 (352,352),
	 (353,370),
	 (354,388),
	 (355,407),
	 (356,427),
	 (357,447),
	 (358,510),
	 (359,533);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (360,552),
	 (361,572),
	 (362,592),
	 (363,613),
	 (364,634),
	 (365,655),
	 (366,678),
	 (367,700),
	 (368,723),
	 (369,747);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (370,771),
	 (371,795),
	 (372,820),
	 (373,846),
	 (374,872),
	 (375,899),
	 (376,926),
	 (377,953),
	 (378,982),
	 (379,1010);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (380,1033),
	 (381,1056),
	 (382,1079),
	 (383,1102),
	 (384,1125),
	 (385,1149),
	 (386,1173),
	 (387,1197),
	 (388,1222),
	 (389,1246);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (390,1271),
	 (391,1297),
	 (392,1322),
	 (393,1348),
	 (394,1374),
	 (395,1400),
	 (396,1426),
	 (397,1453),
	 (398,1480),
	 (399,1507);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (400,23),
	 (401,23),
	 (402,23),
	 (403,23),
	 (404,23),
	 (405,23),
	 (406,23),
	 (407,23),
	 (408,24),
	 (409,24);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (410,24),
	 (411,24),
	 (412,25),
	 (413,26),
	 (414,27),
	 (415,28),
	 (416,29),
	 (417,30),
	 (418,31),
	 (419,32);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (420,34),
	 (421,35),
	 (422,37),
	 (423,39),
	 (424,41),
	 (425,42),
	 (426,44),
	 (427,46),
	 (428,48),
	 (429,49);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (430,52),
	 (431,55),
	 (432,58),
	 (433,61),
	 (434,64),
	 (435,68),
	 (436,71),
	 (437,74),
	 (438,78),
	 (439,82);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (440,85),
	 (441,88),
	 (442,91),
	 (443,95),
	 (444,98),
	 (445,102),
	 (446,105),
	 (447,109),
	 (448,112),
	 (449,116);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (450,119),
	 (451,123),
	 (452,127),
	 (453,131),
	 (454,134),
	 (455,138),
	 (456,142),
	 (457,292),
	 (458,328),
	 (459,337);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (460,355),
	 (461,375),
	 (462,395),
	 (463,415),
	 (464,437),
	 (465,459),
	 (466,481),
	 (467,505),
	 (468,529),
	 (469,554);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (470,580),
	 (471,606),
	 (472,633),
	 (473,661),
	 (474,690),
	 (475,720),
	 (476,750),
	 (477,781),
	 (478,813),
	 (479,846);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (480,866),
	 (481,885),
	 (482,905),
	 (483,925),
	 (484,945),
	 (485,966),
	 (486,986),
	 (487,1007),
	 (488,1028),
	 (489,1049);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (490,1071),
	 (491,1092),
	 (492,1114),
	 (493,1136),
	 (494,1159),
	 (495,1181),
	 (496,1204),
	 (497,1227),
	 (498,1250),
	 (499,1273);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (500,23),
	 (501,24),
	 (502,25),
	 (503,25),
	 (504,25),
	 (505,26),
	 (506,27),
	 (507,28),
	 (508,30),
	 (509,31);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (510,32),
	 (511,34),
	 (512,35),
	 (513,37),
	 (514,40),
	 (515,42),
	 (516,45),
	 (517,48),
	 (518,51),
	 (519,54);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (520,59),
	 (521,64),
	 (522,70),
	 (523,76),
	 (524,82),
	 (525,89),
	 (526,96),
	 (527,103),
	 (528,111),
	 (529,120);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (530,128),
	 (531,138),
	 (532,147),
	 (533,157),
	 (534,168),
	 (535,179),
	 (536,190),
	 (537,203),
	 (538,215),
	 (539,228);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (540,236),
	 (541,243),
	 (542,250),
	 (543,258),
	 (544,265),
	 (545,272),
	 (546,280),
	 (547,287),
	 (548,295),
	 (549,302);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (550,310),
	 (551,317),
	 (552,325),
	 (553,332),
	 (554,340),
	 (555,347),
	 (556,354),
	 (557,362),
	 (558,403),
	 (559,410);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (560,432),
	 (561,455),
	 (562,479),
	 (563,503),
	 (564,528),
	 (565,554),
	 (566,581),
	 (567,609),
	 (568,637),
	 (569,667);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (570,697),
	 (571,728),
	 (572,760),
	 (573,793),
	 (574,827),
	 (575,862),
	 (576,897),
	 (577,934),
	 (578,972),
	 (579,1010);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (580,1033),
	 (581,1056),
	 (582,1079),
	 (583,1102),
	 (584,1125),
	 (585,1149),
	 (586,1173),
	 (587,1197),
	 (588,1222),
	 (589,1246);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (590,1271),
	 (591,1297),
	 (592,1322),
	 (593,1348),
	 (594,1374),
	 (595,1400),
	 (596,1426),
	 (597,1453),
	 (598,1480),
	 (599,1507);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (600,30),
	 (601,31),
	 (602,31),
	 (603,31),
	 (604,31),
	 (605,31),
	 (606,31),
	 (607,32),
	 (608,33),
	 (609,33);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (610,34),
	 (611,34),
	 (612,35),
	 (613,36),
	 (614,38),
	 (615,39),
	 (616,41),
	 (617,43),
	 (618,44),
	 (619,45);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (620,47),
	 (621,48),
	 (622,49),
	 (623,50),
	 (624,51),
	 (625,52),
	 (626,52),
	 (627,53),
	 (628,54),
	 (629,54);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (630,55),
	 (631,57),
	 (632,58),
	 (633,59),
	 (634,60),
	 (635,61),
	 (636,62),
	 (637,63),
	 (638,64),
	 (639,64);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (640,67),
	 (641,69),
	 (642,71),
	 (643,74),
	 (644,76),
	 (645,79),
	 (646,81),
	 (647,84),
	 (648,86),
	 (649,89);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (650,92),
	 (651,94),
	 (652,97),
	 (653,99),
	 (654,102),
	 (655,105),
	 (656,107),
	 (657,220),
	 (658,246),
	 (659,252);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (660,274),
	 (661,297),
	 (662,321),
	 (663,347),
	 (664,373),
	 (665,400),
	 (666,428),
	 (667,458),
	 (668,488),
	 (669,520);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (670,552),
	 (671,586),
	 (672,621),
	 (673,657),
	 (674,695),
	 (675,733),
	 (676,773),
	 (677,814),
	 (678,856),
	 (679,900);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (680,921),
	 (681,941),
	 (682,962),
	 (683,983),
	 (684,1004),
	 (685,1026),
	 (686,1048),
	 (687,1070),
	 (688,1092),
	 (689,1115);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (690,1137),
	 (691,1160),
	 (692,1183),
	 (693,1207),
	 (694,1230),
	 (695,1254),
	 (696,1278),
	 (697,1302),
	 (698,1327),
	 (699,1351);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (700,31),
	 (701,31),
	 (702,32),
	 (703,32),
	 (704,32),
	 (705,32),
	 (706,32),
	 (707,32),
	 (708,33),
	 (709,33);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (710,33),
	 (711,34),
	 (712,34),
	 (713,36),
	 (714,37),
	 (715,39),
	 (716,40),
	 (717,42),
	 (718,43),
	 (719,45);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (720,47),
	 (721,49),
	 (722,51),
	 (723,54),
	 (724,56),
	 (725,58),
	 (726,61),
	 (727,63),
	 (728,65),
	 (729,68);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (730,71),
	 (731,75),
	 (732,79),
	 (733,83),
	 (734,87),
	 (735,92),
	 (736,96),
	 (737,100),
	 (738,105),
	 (739,110);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (740,113),
	 (741,116),
	 (742,120),
	 (743,123),
	 (744,126),
	 (745,129),
	 (746,132),
	 (747,136),
	 (748,139),
	 (749,142);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (750,145),
	 (751,147),
	 (752,150),
	 (753,153),
	 (754,156),
	 (755,158),
	 (756,161),
	 (757,326),
	 (758,362),
	 (759,367);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (760,384),
	 (761,403),
	 (762,422),
	 (763,441),
	 (764,461),
	 (765,482),
	 (766,503),
	 (767,525),
	 (768,548),
	 (769,571);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (770,595),
	 (771,619),
	 (772,644),
	 (773,670),
	 (774,696),
	 (775,724),
	 (776,751),
	 (777,780),
	 (778,809),
	 (779,839);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (780,858),
	 (781,878),
	 (782,897),
	 (783,917),
	 (784,937),
	 (785,958),
	 (786,978),
	 (787,999),
	 (788,1020),
	 (789,1041);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (790,1062),
	 (791,1084),
	 (792,1105),
	 (793,1127),
	 (794,1149),
	 (795,1172),
	 (796,1194),
	 (797,1217),
	 (798,1240),
	 (799,1263);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (800,32),
	 (801,33),
	 (802,33),
	 (803,33),
	 (804,33),
	 (805,33),
	 (806,33),
	 (807,33),
	 (808,34),
	 (809,35);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (810,35),
	 (811,36),
	 (812,36),
	 (813,38),
	 (814,39),
	 (815,41),
	 (816,42),
	 (817,44),
	 (818,45),
	 (819,47);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (820,49),
	 (821,51),
	 (822,53),
	 (823,55),
	 (824,57),
	 (825,59),
	 (826,61),
	 (827,62),
	 (828,64),
	 (829,66);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (830,69),
	 (831,72),
	 (832,75),
	 (833,78),
	 (834,82),
	 (835,85),
	 (836,88),
	 (837,92),
	 (838,95),
	 (839,99);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (840,101),
	 (841,104),
	 (842,107),
	 (843,109),
	 (844,112),
	 (845,114),
	 (846,117),
	 (847,119),
	 (848,122),
	 (849,124);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (850,126),
	 (851,128),
	 (852,130),
	 (853,132),
	 (854,134),
	 (855,135),
	 (856,137),
	 (857,277),
	 (858,307),
	 (859,309);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (860,329),
	 (861,349),
	 (862,370),
	 (863,392),
	 (864,415),
	 (865,439),
	 (866,463),
	 (867,489),
	 (868,515),
	 (869,542);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (870,570),
	 (871,598),
	 (872,628),
	 (873,659),
	 (874,690),
	 (875,723),
	 (876,756),
	 (877,790),
	 (878,826),
	 (879,862);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (880,882),
	 (881,901),
	 (882,921),
	 (883,942),
	 (884,962),
	 (885,983),
	 (886,1004),
	 (887,1025),
	 (888,1047),
	 (889,1068);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (890,1090),
	 (891,1112),
	 (892,1134),
	 (893,1157),
	 (894,1179),
	 (895,1202),
	 (896,1225),
	 (897,1249),
	 (898,1272),
	 (899,1296);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (900,0),
	 (901,0),
	 (902,0),
	 (903,0),
	 (904,0),
	 (905,0),
	 (906,0),
	 (907,0),
	 (908,0),
	 (909,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (910,0),
	 (911,0),
	 (912,0),
	 (913,0),
	 (914,0),
	 (915,0),
	 (916,0),
	 (917,0),
	 (918,0),
	 (919,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (920,0),
	 (921,0),
	 (922,0),
	 (923,0),
	 (924,0),
	 (925,0),
	 (926,0),
	 (927,0),
	 (928,0),
	 (929,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (930,0),
	 (931,0),
	 (932,0),
	 (933,0),
	 (934,0),
	 (935,0),
	 (936,0),
	 (937,0),
	 (938,0),
	 (939,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (940,0),
	 (941,0),
	 (942,0),
	 (943,0),
	 (944,0),
	 (945,0),
	 (946,0),
	 (947,0),
	 (948,0),
	 (949,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (950,0),
	 (951,0),
	 (952,0),
	 (953,0),
	 (954,0),
	 (955,0),
	 (956,0),
	 (957,0),
	 (958,0),
	 (959,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (960,0),
	 (961,0),
	 (962,0),
	 (963,0),
	 (964,0),
	 (965,0),
	 (966,0),
	 (967,0),
	 (968,0),
	 (969,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (970,0),
	 (971,0),
	 (972,0),
	 (973,0),
	 (974,0),
	 (975,0),
	 (976,0),
	 (977,0),
	 (978,0),
	 (979,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (980,0),
	 (981,0),
	 (982,0),
	 (983,0),
	 (984,0),
	 (985,0),
	 (986,0),
	 (987,0),
	 (988,0),
	 (989,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (990,0),
	 (991,0),
	 (992,0),
	 (993,0),
	 (994,0),
	 (995,0),
	 (996,0),
	 (997,0),
	 (998,0),
	 (999,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1000,26),
	 (1001,26),
	 (1002,27),
	 (1003,27),
	 (1004,27),
	 (1005,27),
	 (1006,27),
	 (1007,27),
	 (1008,29),
	 (1009,29);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1010,30),
	 (1011,30),
	 (1012,31),
	 (1013,32),
	 (1014,33),
	 (1015,35),
	 (1016,36),
	 (1017,37),
	 (1018,39),
	 (1019,40);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1020,41),
	 (1021,43),
	 (1022,44),
	 (1023,46),
	 (1024,47),
	 (1025,49),
	 (1026,50),
	 (1027,52),
	 (1028,53),
	 (1029,54);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1030,57),
	 (1031,59),
	 (1032,61),
	 (1033,64),
	 (1034,66),
	 (1035,69),
	 (1036,71),
	 (1037,74),
	 (1038,76),
	 (1039,79);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1040,81),
	 (1041,84),
	 (1042,87),
	 (1043,89),
	 (1044,92),
	 (1045,94),
	 (1046,97),
	 (1047,100),
	 (1048,102),
	 (1049,105);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1050,107),
	 (1051,110),
	 (1052,112),
	 (1053,115),
	 (1054,117),
	 (1055,120),
	 (1056,122),
	 (1057,249),
	 (1058,278),
	 (1059,283);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1060,304),
	 (1061,326),
	 (1062,348),
	 (1063,372),
	 (1064,396),
	 (1065,422),
	 (1066,448),
	 (1067,476),
	 (1068,504),
	 (1069,533);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1070,564),
	 (1071,595),
	 (1072,627),
	 (1073,661),
	 (1074,695),
	 (1075,731),
	 (1076,767),
	 (1077,805),
	 (1078,844),
	 (1079,884);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1080,904),
	 (1081,924),
	 (1082,945),
	 (1083,966),
	 (1084,987),
	 (1085,1008),
	 (1086,1029),
	 (1087,1051),
	 (1088,1073),
	 (1089,1095);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1090,1117),
	 (1091,1140),
	 (1092,1162),
	 (1093,1185),
	 (1094,1208),
	 (1095,1232),
	 (1096,1255),
	 (1097,1279),
	 (1098,1303),
	 (1099,1327);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1100,3),
	 (1101,3),
	 (1102,4),
	 (1103,4),
	 (1104,5),
	 (1105,5),
	 (1106,6),
	 (1107,7),
	 (1108,7),
	 (1109,8);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1110,8),
	 (1111,9),
	 (1112,9),
	 (1113,10),
	 (1114,11),
	 (1115,11),
	 (1116,12),
	 (1117,12),
	 (1118,13),
	 (1119,14);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1120,14),
	 (1121,15),
	 (1122,15),
	 (1123,16),
	 (1124,17),
	 (1125,17),
	 (1126,18),
	 (1127,18),
	 (1128,19),
	 (1129,20);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1130,20),
	 (1131,21),
	 (1132,21),
	 (1133,22),
	 (1134,23),
	 (1135,23),
	 (1136,24),
	 (1137,24),
	 (1138,25),
	 (1139,26);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1140,26),
	 (1141,27),
	 (1142,27),
	 (1143,28),
	 (1144,28),
	 (1145,29),
	 (1146,30),
	 (1147,30),
	 (1148,31),
	 (1149,31);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1150,32),
	 (1151,33),
	 (1152,33),
	 (1153,34),
	 (1154,34),
	 (1155,35),
	 (1156,36),
	 (1157,36),
	 (1158,37),
	 (1159,37);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1160,54),
	 (1161,55),
	 (1162,56),
	 (1163,57),
	 (1164,59),
	 (1165,60),
	 (1166,61),
	 (1167,63),
	 (1168,68),
	 (1169,70);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1170,89),
	 (1171,93),
	 (1172,96),
	 (1173,100),
	 (1174,104),
	 (1175,107),
	 (1176,112),
	 (1177,116),
	 (1178,120),
	 (1179,125);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1180,305),
	 (1181,338),
	 (1182,375),
	 (1183,407),
	 (1184,443),
	 (1185,1083),
	 (1186,1200),
	 (1187,1330),
	 (1188,1446),
	 (1189,1573);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1190,3847),
	 (1191,4262),
	 (1192,4722),
	 (1193,5135),
	 (1194,5584),
	 (1195,13659),
	 (1196,15134),
	 (1197,16767),
	 (1198,18234),
	 (1199,19829);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1200,3),
	 (1201,4),
	 (1202,0),
	 (1203,0),
	 (1204,0),
	 (1205,0),
	 (1206,0),
	 (1207,0),
	 (1208,0),
	 (1209,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1210,0),
	 (1211,0),
	 (1212,0),
	 (1213,0),
	 (1214,0),
	 (1215,0),
	 (1216,0),
	 (1217,0),
	 (1218,0),
	 (1219,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1220,0),
	 (1221,0),
	 (1222,0),
	 (1223,0),
	 (1224,0),
	 (1225,0),
	 (1226,0),
	 (1227,0),
	 (1228,0),
	 (1229,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1230,0),
	 (1231,0),
	 (1232,0),
	 (1233,0),
	 (1234,0),
	 (1235,0),
	 (1236,0),
	 (1237,0),
	 (1238,0),
	 (1239,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1240,0),
	 (1241,0),
	 (1242,0),
	 (1243,0),
	 (1244,0),
	 (1245,0),
	 (1246,0),
	 (1247,0),
	 (1248,0),
	 (1249,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1250,0),
	 (1251,0),
	 (1252,0),
	 (1253,0),
	 (1254,0),
	 (1255,0),
	 (1256,0),
	 (1257,0),
	 (1258,0),
	 (1259,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1260,0),
	 (1261,0),
	 (1262,0),
	 (1263,0),
	 (1264,0),
	 (1265,0),
	 (1266,0),
	 (1267,0),
	 (1268,0),
	 (1269,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1270,0),
	 (1271,0),
	 (1272,0),
	 (1273,0),
	 (1274,0),
	 (1275,0),
	 (1276,0),
	 (1277,0),
	 (1278,0),
	 (1279,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1280,0),
	 (1281,0),
	 (1282,0),
	 (1283,0),
	 (1284,0),
	 (1285,0),
	 (1286,0),
	 (1287,0),
	 (1288,0),
	 (1289,0);
INSERT INTO acore_world.forge_spell_scaling_value (ScalingId,value) VALUES
	 (1290,0),
	 (1291,0),
	 (1292,0),
	 (1293,0),
	 (1294,0),
	 (1295,0),
	 (1296,0),
	 (1297,0),
	 (1298,0),
	 (1299,0);
