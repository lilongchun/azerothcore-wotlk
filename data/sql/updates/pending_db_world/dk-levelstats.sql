DELETE FROM `player_levelstats` WHERE `race` IN (1, 2, 3, 4, 5, 6, 7, 8, 10, 11) AND `class` = 6;
INSERT INTO `player_levelstats` (`race`, `class`, `level`, `str`, `agi`, `sta`, `inte`, `spi`) VALUES
(1, 6, 1, 23, 20, 22, 20, 20), -- Levels 1-54 are duplicated warrior stats.
(1, 6, 2, 24, 21, 23, 20, 20), -- They're close enough and not really able to be blizzlike.
(1, 6, 3, 25, 21, 24, 20, 21),
(1, 6, 4, 26, 22, 25, 20, 21),
(1, 6, 5, 28, 23, 26, 20, 21),
(1, 6, 6, 29, 24, 27, 21, 21),
(1, 6, 7, 30, 24, 28, 21, 22),
(1, 6, 8, 31, 25, 29, 21, 22),
(1, 6, 9, 32, 26, 30, 21, 22),
(1, 6, 10, 33, 26, 31, 21, 23),
(1, 6, 11, 35, 27, 33, 21, 23),
(1, 6, 12, 36, 28, 34, 21, 23),
(1, 6, 13, 37, 29, 35, 21, 24),
(1, 6, 14, 39, 30, 36, 22, 24),
(1, 6, 15, 40, 30, 37, 22, 24),
(1, 6, 16, 41, 31, 38, 22, 25),
(1, 6, 17, 42, 32, 40, 22, 25),
(1, 6, 18, 44, 33, 41, 22, 25),
(1, 6, 19, 45, 34, 42, 22, 26),
(1, 6, 20, 47, 35, 43, 22, 26),
(1, 6, 21, 48, 35, 45, 23, 26),
(1, 6, 22, 49, 36, 46, 23, 27),
(1, 6, 23, 51, 37, 47, 23, 27),
(1, 6, 24, 52, 38, 49, 23, 28),
(1, 6, 25, 54, 39, 50, 23, 28),
(1, 6, 26, 55, 40, 51, 23, 28),
(1, 6, 27, 57, 41, 53, 23, 29),
(1, 6, 28, 58, 42, 54, 24, 29),
(1, 6, 29, 60, 43, 56, 24, 30),
(1, 6, 30, 62, 44, 57, 24, 30),
(1, 6, 31, 63, 45, 58, 24, 30),
(1, 6, 32, 65, 46, 60, 24, 31),
(1, 6, 33, 66, 47, 61, 24, 31),
(1, 6, 34, 68, 48, 63, 25, 32),
(1, 6, 35, 70, 49, 64, 25, 32),
(1, 6, 36, 72, 50, 66, 25, 33),
(1, 6, 37, 73, 51, 68, 25, 33),
(1, 6, 38, 75, 52, 69, 25, 33),
(1, 6, 39, 77, 53, 71, 26, 34),
(1, 6, 40, 79, 54, 72, 26, 34),
(1, 6, 41, 80, 56, 74, 26, 35),
(1, 6, 42, 82, 57, 76, 26, 35),
(1, 6, 43, 84, 58, 77, 26, 36),
(1, 6, 44, 86, 59, 79, 26, 36),
(1, 6, 45, 88, 60, 81, 27, 37),
(1, 6, 46, 90, 61, 83, 27, 37),
(1, 6, 47, 92, 63, 84, 27, 38),
(1, 6, 48, 94, 64, 86, 27, 38),
(1, 6, 49, 96, 65, 88, 28, 39),
(1, 6, 50, 98, 66, 90, 28, 39),
(1, 6, 51, 100, 68, 92, 28, 40),
(1, 6, 52, 102, 69, 94, 28, 40),
(1, 6, 53, 104, 70, 96, 28, 41),
(1, 6, 54, 106, 72, 98, 29, 42),
(2, 6, 1, 26, 17, 23, 17, 22),
(2, 6, 2, 27, 18, 24, 17, 22),
(2, 6, 3, 28, 18, 25, 17, 23),
(2, 6, 4, 29, 19, 26, 17, 23),
(2, 6, 5, 31, 20, 27, 17, 23),
(2, 6, 6, 32, 21, 28, 18, 23),
(2, 6, 7, 33, 21, 29, 18, 24),
(2, 6, 8, 34, 22, 30, 18, 24),
(2, 6, 9, 35, 23, 31, 18, 24),
(2, 6, 10, 36, 23, 32, 18, 25),
(2, 6, 11, 38, 24, 34, 18, 25),
(2, 6, 12, 39, 25, 35, 18, 25),
(2, 6, 13, 40, 26, 36, 18, 26),
(2, 6, 14, 42, 27, 37, 19, 26),
(2, 6, 15, 43, 27, 38, 19, 26),
(2, 6, 16, 44, 28, 39, 19, 27),
(2, 6, 17, 45, 29, 41, 19, 27),
(2, 6, 18, 47, 30, 42, 19, 27),
(2, 6, 19, 48, 31, 43, 19, 28),
(2, 6, 20, 50, 32, 44, 19, 28),
(2, 6, 21, 51, 32, 46, 20, 28),
(2, 6, 22, 52, 33, 47, 20, 29),
(2, 6, 23, 54, 34, 48, 20, 29),
(2, 6, 24, 55, 35, 50, 20, 30),
(2, 6, 25, 57, 36, 51, 20, 30),
(2, 6, 26, 58, 37, 52, 20, 30),
(2, 6, 27, 60, 38, 54, 20, 31),
(2, 6, 28, 61, 39, 55, 21, 31),
(2, 6, 29, 63, 40, 57, 21, 32),
(2, 6, 30, 65, 41, 58, 21, 32),
(2, 6, 31, 66, 42, 59, 21, 32),
(2, 6, 32, 68, 43, 61, 21, 33),
(2, 6, 33, 69, 44, 62, 21, 33),
(2, 6, 34, 71, 45, 64, 22, 34),
(2, 6, 35, 73, 46, 65, 22, 34),
(2, 6, 36, 75, 47, 67, 22, 35),
(2, 6, 37, 76, 48, 69, 22, 35),
(2, 6, 38, 78, 49, 70, 22, 35),
(2, 6, 39, 80, 50, 72, 23, 36),
(2, 6, 40, 82, 51, 73, 23, 36),
(2, 6, 41, 83, 53, 75, 23, 37),
(2, 6, 42, 85, 54, 77, 23, 37),
(2, 6, 43, 87, 55, 78, 23, 38),
(2, 6, 44, 89, 56, 80, 23, 38),
(2, 6, 45, 91, 57, 82, 24, 39),
(2, 6, 46, 93, 58, 84, 24, 39),
(2, 6, 47, 95, 60, 85, 24, 40),
(2, 6, 48, 97, 61, 87, 24, 40),
(2, 6, 49, 99, 62, 89, 25, 41),
(2, 6, 50, 101, 63, 91, 25, 41),
(2, 6, 51, 103, 65, 93, 25, 42),
(2, 6, 52, 105, 66, 95, 25, 42),
(2, 6, 53, 107, 67, 97, 25, 43),
(2, 6, 54, 109, 69, 99, 26, 44),
(3, 6, 1, 28, 16, 23, 19, 19),
(3, 6, 2, 29, 17, 24, 19, 19),
(3, 6, 3, 30, 17, 25, 19, 20),
(3, 6, 4, 31, 18, 26, 19, 20),
(3, 6, 5, 33, 19, 27, 19, 20),
(3, 6, 6, 34, 20, 28, 20, 20),
(3, 6, 7, 35, 20, 29, 20, 21),
(3, 6, 8, 36, 21, 30, 20, 21),
(3, 6, 9, 37, 22, 31, 20, 21),
(3, 6, 10, 38, 22, 32, 20, 22),
(3, 6, 11, 40, 23, 34, 20, 22),
(3, 6, 12, 41, 24, 35, 20, 22),
(3, 6, 13, 42, 25, 36, 20, 23),
(3, 6, 14, 44, 26, 37, 21, 23),
(3, 6, 15, 45, 26, 38, 21, 23),
(3, 6, 16, 46, 27, 39, 21, 24),
(3, 6, 17, 47, 28, 41, 21, 24),
(3, 6, 18, 49, 29, 42, 21, 24),
(3, 6, 19, 50, 30, 43, 21, 25),
(3, 6, 20, 52, 31, 44, 21, 25),
(3, 6, 21, 53, 31, 46, 22, 25),
(3, 6, 22, 54, 32, 47, 22, 26),
(3, 6, 23, 56, 33, 48, 22, 26),
(3, 6, 24, 57, 34, 50, 22, 27),
(3, 6, 25, 59, 35, 51, 22, 27),
(3, 6, 26, 60, 36, 52, 22, 27),
(3, 6, 27, 62, 37, 54, 22, 28),
(3, 6, 28, 63, 38, 55, 23, 28),
(3, 6, 29, 65, 39, 57, 23, 29),
(3, 6, 30, 67, 40, 58, 23, 29),
(3, 6, 31, 68, 41, 59, 23, 29),
(3, 6, 32, 70, 42, 61, 23, 30),
(3, 6, 33, 71, 43, 62, 23, 30),
(3, 6, 34, 73, 44, 64, 24, 31),
(3, 6, 35, 75, 45, 65, 24, 31),
(3, 6, 36, 77, 46, 67, 24, 32),
(3, 6, 37, 78, 47, 69, 24, 32),
(3, 6, 38, 80, 48, 70, 24, 32),
(3, 6, 39, 82, 49, 72, 25, 33),
(3, 6, 40, 84, 50, 73, 25, 33),
(3, 6, 41, 85, 52, 75, 25, 34),
(3, 6, 42, 87, 53, 77, 25, 34),
(3, 6, 43, 89, 54, 78, 25, 35),
(3, 6, 44, 91, 55, 80, 25, 35),
(3, 6, 45, 93, 56, 82, 26, 36),
(3, 6, 46, 95, 57, 84, 26, 36),
(3, 6, 47, 97, 59, 85, 26, 37),
(3, 6, 48, 99, 60, 87, 26, 37),
(3, 6, 49, 101, 61, 89, 27, 38),
(3, 6, 50, 103, 62, 91, 27, 38),
(3, 6, 51, 105, 64, 93, 27, 39),
(3, 6, 52, 107, 65, 95, 27, 39),
(3, 6, 53, 109, 66, 97, 27, 40),
(3, 6, 54, 111, 68, 99, 28, 41),
(4, 6, 1, 19, 24, 22, 20, 20),
(4, 6, 2, 20, 25, 23, 20, 20),
(4, 6, 3, 21, 25, 24, 20, 21),
(4, 6, 4, 22, 26, 25, 20, 21),
(4, 6, 5, 24, 27, 26, 20, 21),
(4, 6, 6, 25, 28, 27, 21, 21),
(4, 6, 7, 26, 28, 28, 21, 22),
(4, 6, 8, 27, 29, 29, 21, 22),
(4, 6, 9, 28, 30, 30, 21, 22),
(4, 6, 10, 29, 30, 31, 21, 23),
(4, 6, 11, 31, 31, 33, 21, 23),
(4, 6, 12, 32, 32, 34, 21, 23),
(4, 6, 13, 33, 33, 35, 21, 24),
(4, 6, 14, 35, 34, 36, 22, 24),
(4, 6, 15, 36, 34, 37, 22, 24),
(4, 6, 16, 37, 35, 38, 22, 25),
(4, 6, 17, 38, 36, 40, 22, 25),
(4, 6, 18, 40, 37, 41, 22, 25),
(4, 6, 19, 41, 38, 42, 22, 26),
(4, 6, 20, 43, 39, 43, 22, 26),
(4, 6, 21, 44, 39, 45, 23, 26),
(4, 6, 22, 45, 40, 46, 23, 27),
(4, 6, 23, 47, 41, 47, 23, 27),
(4, 6, 24, 48, 42, 49, 23, 28),
(4, 6, 25, 50, 43, 50, 23, 28),
(4, 6, 26, 51, 44, 51, 23, 28),
(4, 6, 27, 53, 45, 53, 23, 29),
(4, 6, 28, 54, 46, 54, 24, 29),
(4, 6, 29, 56, 47, 56, 24, 30),
(4, 6, 30, 58, 48, 57, 24, 30),
(4, 6, 31, 59, 49, 58, 24, 30),
(4, 6, 32, 61, 50, 60, 24, 31),
(4, 6, 33, 62, 51, 61, 24, 31),
(4, 6, 34, 64, 52, 63, 25, 32),
(4, 6, 35, 66, 53, 64, 25, 32),
(4, 6, 36, 68, 54, 66, 25, 33),
(4, 6, 37, 69, 55, 68, 25, 33),
(4, 6, 38, 71, 56, 69, 25, 33),
(4, 6, 39, 73, 57, 71, 26, 34),
(4, 6, 40, 75, 58, 72, 26, 34),
(4, 6, 41, 76, 60, 74, 26, 35),
(4, 6, 42, 78, 61, 76, 26, 35),
(4, 6, 43, 80, 62, 77, 26, 36),
(4, 6, 44, 82, 63, 79, 26, 36),
(4, 6, 45, 84, 64, 81, 27, 37),
(4, 6, 46, 86, 65, 83, 27, 37),
(4, 6, 47, 88, 67, 84, 27, 38),
(4, 6, 48, 90, 68, 86, 27, 38),
(4, 6, 49, 92, 69, 88, 28, 39),
(4, 6, 50, 94, 70, 90, 28, 39),
(4, 6, 51, 96, 72, 92, 28, 40),
(4, 6, 52, 98, 73, 94, 28, 40),
(4, 6, 53, 100, 74, 96, 28, 41),
(4, 6, 54, 102, 76, 98, 29, 42),
(5, 6, 1, 22, 18, 22, 18, 25),
(5, 6, 2, 23, 19, 23, 18, 25),
(5, 6, 3, 24, 19, 24, 18, 26),
(5, 6, 4, 25, 20, 25, 18, 26),
(5, 6, 5, 27, 21, 26, 18, 26),
(5, 6, 6, 28, 22, 27, 19, 26),
(5, 6, 7, 29, 22, 28, 19, 27),
(5, 6, 8, 30, 23, 29, 19, 27),
(5, 6, 9, 31, 24, 30, 19, 27),
(5, 6, 10, 32, 24, 31, 19, 28),
(5, 6, 11, 34, 25, 33, 19, 28),
(5, 6, 12, 35, 26, 34, 19, 28),
(5, 6, 13, 36, 27, 35, 19, 29),
(5, 6, 14, 38, 28, 36, 20, 29),
(5, 6, 15, 39, 28, 37, 20, 29),
(5, 6, 16, 40, 29, 38, 20, 30),
(5, 6, 17, 41, 30, 40, 20, 30),
(5, 6, 18, 43, 31, 41, 20, 30),
(5, 6, 19, 44, 32, 42, 20, 31),
(5, 6, 20, 46, 33, 43, 20, 31),
(5, 6, 21, 47, 33, 45, 21, 31),
(5, 6, 22, 48, 34, 46, 21, 32),
(5, 6, 23, 50, 35, 47, 21, 32),
(5, 6, 24, 51, 36, 49, 21, 33),
(5, 6, 25, 53, 37, 50, 21, 33),
(5, 6, 26, 54, 38, 51, 21, 33),
(5, 6, 27, 56, 39, 53, 21, 34),
(5, 6, 28, 57, 40, 54, 22, 34),
(5, 6, 29, 59, 41, 56, 22, 35),
(5, 6, 30, 61, 42, 57, 22, 35),
(5, 6, 31, 62, 43, 58, 22, 35),
(5, 6, 32, 64, 44, 60, 22, 36),
(5, 6, 33, 65, 45, 61, 22, 36),
(5, 6, 34, 67, 46, 63, 23, 37),
(5, 6, 35, 69, 47, 64, 23, 37),
(5, 6, 36, 71, 48, 66, 23, 38),
(5, 6, 37, 72, 49, 68, 23, 38),
(5, 6, 38, 74, 50, 69, 23, 38),
(5, 6, 39, 76, 51, 71, 24, 39),
(5, 6, 40, 78, 52, 72, 24, 39),
(5, 6, 41, 79, 54, 74, 24, 40),
(5, 6, 42, 81, 55, 76, 24, 40),
(5, 6, 43, 83, 56, 77, 24, 41),
(5, 6, 44, 85, 57, 79, 24, 41),
(5, 6, 45, 87, 58, 81, 25, 42),
(5, 6, 46, 89, 59, 83, 25, 42),
(5, 6, 47, 91, 61, 84, 25, 43),
(5, 6, 48, 93, 62, 86, 25, 43),
(5, 6, 49, 95, 63, 88, 26, 44),
(5, 6, 50, 97, 64, 90, 26, 44),
(5, 6, 51, 99, 66, 92, 26, 45),
(5, 6, 52, 101, 67, 94, 26, 45),
(5, 6, 53, 103, 68, 96, 26, 46),
(5, 6, 54, 105, 70, 98, 27, 47),
(6, 6, 1, 28, 16, 23, 16, 22),
(6, 6, 2, 29, 17, 24, 16, 22),
(6, 6, 3, 30, 17, 25, 16, 23),
(6, 6, 4, 31, 18, 26, 16, 23),
(6, 6, 5, 33, 19, 27, 16, 23),
(6, 6, 6, 34, 20, 28, 17, 23),
(6, 6, 7, 35, 20, 29, 17, 24),
(6, 6, 8, 36, 21, 30, 17, 24),
(6, 6, 9, 37, 22, 31, 17, 24),
(6, 6, 10, 38, 22, 32, 17, 25),
(6, 6, 11, 40, 23, 34, 17, 25),
(6, 6, 12, 41, 24, 35, 17, 25),
(6, 6, 13, 42, 25, 36, 17, 26),
(6, 6, 14, 44, 26, 37, 18, 26),
(6, 6, 15, 45, 26, 38, 18, 26),
(6, 6, 16, 46, 27, 39, 18, 27),
(6, 6, 17, 47, 28, 41, 18, 27),
(6, 6, 18, 49, 29, 42, 18, 27),
(6, 6, 19, 50, 30, 43, 18, 28),
(6, 6, 20, 52, 31, 44, 18, 28),
(6, 6, 21, 53, 31, 46, 19, 28),
(6, 6, 22, 54, 32, 47, 19, 29),
(6, 6, 23, 56, 33, 48, 19, 29),
(6, 6, 24, 57, 34, 50, 19, 30),
(6, 6, 25, 59, 35, 51, 19, 30),
(6, 6, 26, 60, 36, 52, 19, 30),
(6, 6, 27, 62, 37, 54, 19, 31),
(6, 6, 28, 63, 38, 55, 20, 31),
(6, 6, 29, 65, 39, 57, 20, 32),
(6, 6, 30, 67, 40, 58, 20, 32),
(6, 6, 31, 68, 41, 59, 20, 32),
(6, 6, 32, 70, 42, 61, 20, 33),
(6, 6, 33, 71, 43, 62, 20, 33),
(6, 6, 34, 73, 44, 64, 21, 34),
(6, 6, 35, 75, 45, 65, 21, 34),
(6, 6, 36, 77, 46, 67, 21, 35),
(6, 6, 37, 78, 47, 69, 21, 35),
(6, 6, 38, 80, 48, 70, 21, 35),
(6, 6, 39, 82, 49, 72, 22, 36),
(6, 6, 40, 84, 50, 73, 22, 36),
(6, 6, 41, 85, 52, 75, 22, 37),
(6, 6, 42, 87, 53, 77, 22, 37),
(6, 6, 43, 89, 54, 78, 22, 38),
(6, 6, 44, 91, 55, 80, 22, 38),
(6, 6, 45, 93, 56, 82, 23, 39),
(6, 6, 46, 95, 57, 84, 23, 39),
(6, 6, 47, 97, 59, 85, 23, 40),
(6, 6, 48, 99, 60, 87, 23, 40),
(6, 6, 49, 101, 61, 89, 24, 41),
(6, 6, 50, 103, 62, 91, 24, 41),
(6, 6, 51, 105, 64, 93, 24, 42),
(6, 6, 52, 107, 65, 95, 24, 42),
(6, 6, 53, 109, 66, 97, 24, 43),
(6, 6, 54, 111, 68, 99, 25, 44),
(7, 6, 1, 18, 22, 22, 23, 20),
(7, 6, 2, 19, 23, 23, 23, 20),
(7, 6, 3, 20, 23, 24, 23, 21),
(7, 6, 4, 21, 24, 25, 23, 21),
(7, 6, 5, 23, 25, 26, 23, 21),
(7, 6, 6, 24, 26, 27, 24, 21),
(7, 6, 7, 25, 26, 28, 24, 22),
(7, 6, 8, 26, 27, 29, 24, 22),
(7, 6, 9, 27, 28, 30, 24, 22),
(7, 6, 10, 28, 28, 31, 24, 23),
(7, 6, 11, 30, 29, 33, 24, 23),
(7, 6, 12, 31, 30, 34, 24, 23),
(7, 6, 13, 32, 31, 35, 24, 24),
(7, 6, 14, 34, 32, 36, 25, 24),
(7, 6, 15, 35, 32, 37, 25, 24),
(7, 6, 16, 36, 33, 38, 25, 25),
(7, 6, 17, 37, 34, 40, 25, 25),
(7, 6, 18, 39, 35, 41, 25, 25),
(7, 6, 19, 40, 36, 42, 25, 26),
(7, 6, 20, 42, 37, 43, 25, 26),
(7, 6, 21, 43, 37, 45, 26, 26),
(7, 6, 22, 44, 38, 46, 26, 27),
(7, 6, 23, 46, 39, 47, 26, 27),
(7, 6, 24, 47, 40, 49, 26, 28),
(7, 6, 25, 49, 41, 50, 26, 28),
(7, 6, 26, 50, 42, 51, 26, 28),
(7, 6, 27, 52, 43, 53, 26, 29),
(7, 6, 28, 53, 44, 54, 27, 29),
(7, 6, 29, 55, 45, 56, 27, 30),
(7, 6, 30, 57, 46, 57, 27, 30),
(7, 6, 31, 58, 47, 58, 27, 30),
(7, 6, 32, 60, 48, 60, 27, 31),
(7, 6, 33, 61, 49, 61, 27, 31),
(7, 6, 34, 63, 50, 63, 28, 32),
(7, 6, 35, 65, 51, 64, 28, 32),
(7, 6, 36, 67, 52, 66, 28, 33),
(7, 6, 37, 68, 53, 68, 28, 33),
(7, 6, 38, 70, 54, 69, 28, 33),
(7, 6, 39, 72, 55, 71, 29, 34),
(7, 6, 40, 74, 56, 72, 29, 34),
(7, 6, 41, 75, 58, 74, 29, 35),
(7, 6, 42, 77, 59, 76, 29, 35),
(7, 6, 43, 79, 60, 77, 29, 36),
(7, 6, 44, 81, 61, 79, 29, 36),
(7, 6, 45, 83, 62, 81, 30, 37),
(7, 6, 46, 85, 63, 83, 30, 37),
(7, 6, 47, 87, 65, 84, 30, 38),
(7, 6, 48, 89, 66, 86, 30, 38),
(7, 6, 49, 91, 67, 88, 31, 39),
(7, 6, 50, 93, 68, 90, 31, 39),
(7, 6, 51, 95, 70, 92, 31, 40),
(7, 6, 52, 97, 71, 94, 31, 40),
(7, 6, 53, 99, 72, 96, 31, 41),
(7, 6, 54, 101, 74, 98, 32, 42),
(8, 6, 1, 24, 22, 22, 16, 21),
(8, 6, 2, 25, 23, 23, 16, 21),
(8, 6, 3, 26, 23, 24, 16, 22),
(8, 6, 4, 27, 24, 25, 16, 22),
(8, 6, 5, 29, 25, 26, 16, 22),
(8, 6, 6, 30, 26, 27, 17, 22),
(8, 6, 7, 31, 26, 28, 17, 23),
(8, 6, 8, 32, 27, 29, 17, 23),
(8, 6, 9, 33, 28, 30, 17, 23),
(8, 6, 10, 34, 28, 31, 17, 24),
(8, 6, 11, 36, 29, 33, 17, 24),
(8, 6, 12, 37, 30, 34, 17, 24),
(8, 6, 13, 38, 31, 35, 17, 25),
(8, 6, 14, 40, 32, 36, 18, 25),
(8, 6, 15, 41, 32, 37, 18, 25),
(8, 6, 16, 42, 33, 38, 18, 26),
(8, 6, 17, 43, 34, 40, 18, 26),
(8, 6, 18, 45, 35, 41, 18, 26),
(8, 6, 19, 46, 36, 42, 18, 27),
(8, 6, 20, 48, 37, 43, 18, 27),
(8, 6, 21, 49, 37, 45, 19, 27),
(8, 6, 22, 50, 38, 46, 19, 28),
(8, 6, 23, 52, 39, 47, 19, 28),
(8, 6, 24, 53, 40, 49, 19, 29),
(8, 6, 25, 55, 41, 50, 19, 29),
(8, 6, 26, 56, 42, 51, 19, 29),
(8, 6, 27, 58, 43, 53, 19, 30),
(8, 6, 28, 59, 44, 54, 20, 30),
(8, 6, 29, 61, 45, 56, 20, 31),
(8, 6, 30, 63, 46, 57, 20, 31),
(8, 6, 31, 64, 47, 58, 20, 31),
(8, 6, 32, 66, 48, 60, 20, 32),
(8, 6, 33, 67, 49, 61, 20, 32),
(8, 6, 34, 69, 50, 63, 21, 33),
(8, 6, 35, 71, 51, 64, 21, 33),
(8, 6, 36, 73, 52, 66, 21, 34),
(8, 6, 37, 74, 53, 68, 21, 34),
(8, 6, 38, 76, 54, 69, 21, 34),
(8, 6, 39, 78, 55, 71, 22, 35),
(8, 6, 40, 80, 56, 72, 22, 35),
(8, 6, 41, 81, 58, 74, 22, 36),
(8, 6, 42, 83, 59, 76, 22, 36),
(8, 6, 43, 85, 60, 77, 22, 37),
(8, 6, 44, 87, 61, 79, 22, 37),
(8, 6, 45, 89, 62, 81, 23, 38),
(8, 6, 46, 91, 63, 83, 23, 38),
(8, 6, 47, 93, 65, 84, 23, 39),
(8, 6, 48, 95, 66, 86, 23, 39),
(8, 6, 49, 97, 67, 88, 24, 40),
(8, 6, 50, 99, 68, 90, 24, 40),
(8, 6, 51, 101, 70, 92, 24, 41),
(8, 6, 52, 103, 71, 94, 24, 41),
(8, 6, 53, 105, 72, 96, 24, 42),
(8, 6, 54, 107, 74, 98, 25, 43),
(10, 6, 1, 20, 22, 22, 23, 18),
(10, 6, 2, 21, 23, 23, 23, 18),
(10, 6, 3, 22, 23, 24, 23, 19),
(10, 6, 4, 23, 24, 25, 23, 19),
(10, 6, 5, 25, 25, 26, 23, 19),
(10, 6, 6, 26, 26, 27, 24, 19),
(10, 6, 7, 27, 26, 28, 24, 20),
(10, 6, 8, 28, 27, 29, 24, 20),
(10, 6, 9, 29, 28, 30, 24, 20),
(10, 6, 10, 30, 28, 31, 24, 21),
(10, 6, 11, 32, 29, 33, 24, 21),
(10, 6, 12, 33, 30, 34, 24, 21),
(10, 6, 13, 34, 31, 35, 24, 22),
(10, 6, 14, 36, 32, 36, 25, 22),
(10, 6, 15, 37, 32, 37, 25, 22),
(10, 6, 16, 38, 33, 38, 25, 23),
(10, 6, 17, 39, 34, 40, 25, 23),
(10, 6, 18, 41, 35, 41, 25, 23),
(10, 6, 19, 42, 36, 42, 25, 24),
(10, 6, 20, 44, 37, 43, 25, 24),
(10, 6, 21, 45, 37, 45, 26, 24),
(10, 6, 22, 46, 38, 46, 26, 25),
(10, 6, 23, 48, 39, 47, 26, 25),
(10, 6, 24, 49, 40, 49, 26, 26),
(10, 6, 25, 51, 41, 50, 26, 26),
(10, 6, 26, 52, 42, 51, 26, 26),
(10, 6, 27, 54, 43, 53, 26, 27),
(10, 6, 28, 55, 44, 54, 27, 27),
(10, 6, 29, 57, 45, 56, 27, 28),
(10, 6, 30, 59, 46, 57, 27, 28),
(10, 6, 31, 60, 47, 58, 27, 28),
(10, 6, 32, 62, 48, 60, 27, 29),
(10, 6, 33, 63, 49, 61, 27, 29),
(10, 6, 34, 65, 50, 63, 28, 30),
(10, 6, 35, 67, 51, 64, 28, 30),
(10, 6, 36, 69, 52, 66, 28, 31),
(10, 6, 37, 70, 53, 68, 28, 31),
(10, 6, 38, 72, 54, 69, 28, 31),
(10, 6, 39, 74, 55, 71, 29, 32),
(10, 6, 40, 76, 56, 72, 29, 32),
(10, 6, 41, 77, 58, 74, 29, 33),
(10, 6, 42, 79, 59, 76, 29, 33),
(10, 6, 43, 81, 60, 77, 29, 34),
(10, 6, 44, 83, 61, 79, 29, 34),
(10, 6, 45, 85, 62, 81, 30, 35),
(10, 6, 46, 87, 63, 83, 30, 35),
(10, 6, 47, 89, 65, 84, 30, 36),
(10, 6, 48, 91, 66, 86, 30, 36),
(10, 6, 49, 93, 67, 88, 31, 37),
(10, 6, 50, 95, 68, 90, 31, 37),
(10, 6, 51, 97, 70, 92, 31, 38),
(10, 6, 52, 99, 71, 94, 31, 38),
(10, 6, 53, 101, 72, 96, 31, 39),
(10, 6, 54, 103, 74, 98, 32, 40),
(11, 6, 1, 24, 17, 22, 20, 22),
(11, 6, 2, 25, 18, 23, 20, 22),
(11, 6, 3, 26, 18, 24, 20, 23),
(11, 6, 4, 27, 19, 25, 20, 23),
(11, 6, 5, 29, 20, 26, 20, 23),
(11, 6, 6, 30, 21, 27, 21, 23),
(11, 6, 7, 31, 21, 28, 21, 24),
(11, 6, 8, 32, 22, 29, 21, 24),
(11, 6, 9, 33, 23, 30, 21, 24),
(11, 6, 10, 34, 23, 31, 21, 25),
(11, 6, 11, 36, 24, 33, 21, 25),
(11, 6, 12, 37, 25, 34, 21, 25),
(11, 6, 13, 38, 26, 35, 21, 26),
(11, 6, 14, 40, 27, 36, 22, 26),
(11, 6, 15, 41, 27, 37, 22, 26),
(11, 6, 16, 42, 28, 38, 22, 27),
(11, 6, 17, 43, 29, 40, 22, 27),
(11, 6, 18, 45, 30, 41, 22, 27),
(11, 6, 19, 46, 31, 42, 22, 28),
(11, 6, 20, 48, 32, 43, 22, 28),
(11, 6, 21, 49, 32, 45, 23, 28),
(11, 6, 22, 50, 33, 46, 23, 29),
(11, 6, 23, 52, 34, 47, 23, 29),
(11, 6, 24, 53, 35, 49, 23, 30),
(11, 6, 25, 55, 36, 50, 23, 30),
(11, 6, 26, 56, 37, 51, 23, 30),
(11, 6, 27, 58, 38, 53, 23, 31),
(11, 6, 28, 59, 39, 54, 24, 31),
(11, 6, 29, 61, 40, 56, 24, 32),
(11, 6, 30, 63, 41, 57, 24, 32),
(11, 6, 31, 64, 42, 58, 24, 32),
(11, 6, 32, 66, 43, 60, 24, 33),
(11, 6, 33, 67, 44, 61, 24, 33),
(11, 6, 34, 69, 45, 63, 25, 34),
(11, 6, 35, 71, 46, 64, 25, 34),
(11, 6, 36, 73, 47, 66, 25, 35),
(11, 6, 37, 74, 48, 68, 25, 35),
(11, 6, 38, 76, 49, 69, 25, 35),
(11, 6, 39, 78, 50, 71, 26, 36),
(11, 6, 40, 80, 51, 72, 26, 36),
(11, 6, 41, 81, 53, 74, 26, 37),
(11, 6, 42, 83, 54, 76, 26, 37),
(11, 6, 43, 85, 55, 77, 26, 38),
(11, 6, 44, 87, 56, 79, 26, 38),
(11, 6, 45, 89, 57, 81, 27, 39),
(11, 6, 46, 91, 58, 83, 27, 39),
(11, 6, 47, 93, 60, 84, 27, 40),
(11, 6, 48, 95, 61, 86, 27, 40),
(11, 6, 49, 97, 62, 88, 28, 41),
(11, 6, 50, 99, 63, 90, 28, 41),
(11, 6, 51, 101, 65, 92, 28, 42),
(11, 6, 52, 103, 66, 94, 28, 42),
(11, 6, 53, 105, 67, 96, 28, 43),
(11, 6, 54, 107, 69, 98, 29, 44),
(1, 6, 55, 108, 73, 99, 29, 42),
(1, 6, 56, 111, 75, 102, 29, 43),
(1, 6, 57, 113, 76, 104, 29, 43),
(1, 6, 58, 115, 77, 106, 30, 44),
(1, 6, 59, 118, 79, 108, 30, 44),
(1, 6, 60, 120, 80, 110, 30, 45),
(1, 6, 61, 122, 81, 112, 30, 46),
(1, 6, 62, 125, 83, 114, 30, 46),
(1, 6, 63, 127, 84, 117, 31, 47),
(1, 6, 64, 130, 86, 119, 31, 47),
(1, 6, 65, 133, 87, 121, 31, 48),
(1, 6, 66, 135, 89, 124, 31, 49),
(1, 6, 67, 138, 90, 126, 32, 49),
(1, 6, 68, 140, 92, 128, 32, 50),
(1, 6, 69, 143, 93, 131, 32, 51),
(1, 6, 70, 146, 95, 133, 32, 51),
(1, 6, 71, 149, 97, 136, 33, 52),
(1, 6, 72, 151, 98, 138, 33, 53),
(1, 6, 73, 154, 100, 141, 33, 54),
(1, 6, 74, 157, 102, 143, 33, 54),
(1, 6, 75, 160, 103, 146, 34, 55),
(1, 6, 76, 163, 105, 149, 34, 56),
(1, 6, 77, 166, 107, 151, 34, 57),
(1, 6, 78, 169, 108, 154, 34, 57),
(1, 6, 79, 172, 110, 157, 35, 58),
(1, 6, 80, 175, 112, 160, 35, 59),
(2, 6, 55, 111, 70, 100, 26, 44),
(2, 6, 56, 114, 72, 103, 26, 45),
(2, 6, 57, 116, 73, 105, 26, 45),
(2, 6, 58, 118, 74, 107, 27, 46),
(2, 6, 59, 121, 76, 109, 27, 46),
(2, 6, 60, 123, 77, 111, 27, 47),
(2, 6, 61, 125, 78, 113, 27, 48),
(2, 6, 62, 128, 80, 115, 27, 48),
(2, 6, 63, 130, 81, 118, 28, 49),
(2, 6, 64, 133, 83, 120, 28, 49),
(2, 6, 65, 136, 84, 122, 28, 50),
(2, 6, 66, 138, 86, 125, 28, 51),
(2, 6, 67, 141, 87, 127, 29, 51),
(2, 6, 68, 143, 89, 129, 29, 52),
(2, 6, 69, 146, 90, 132, 29, 53),
(2, 6, 70, 149, 92, 134, 29, 53),
(2, 6, 71, 152, 94, 137, 30, 54),
(2, 6, 72, 154, 95, 139, 30, 55),
(2, 6, 73, 157, 97, 142, 30, 56),
(2, 6, 74, 160, 99, 144, 30, 56),
(2, 6, 75, 163, 100, 147, 31, 57),
(2, 6, 76, 166, 102, 150, 31, 58),
(2, 6, 77, 169, 104, 152, 31, 59),
(2, 6, 78, 172, 105, 155, 31, 59),
(2, 6, 79, 175, 107, 158, 32, 60),
(2, 6, 80, 178, 109, 161, 32, 61),
(3, 6, 55, 113, 69, 100, 28, 41),
(3, 6, 56, 116, 71, 103, 28, 42),
(3, 6, 57, 118, 72, 105, 28, 42),
(3, 6, 58, 120, 73, 107, 29, 43),
(3, 6, 59, 123, 75, 109, 29, 43),
(3, 6, 60, 125, 76, 111, 29, 44),
(3, 6, 61, 127, 77, 113, 29, 45),
(3, 6, 62, 130, 79, 115, 29, 45),
(3, 6, 63, 132, 80, 118, 30, 46),
(3, 6, 64, 135, 82, 120, 30, 46),
(3, 6, 65, 138, 83, 122, 30, 47),
(3, 6, 66, 140, 85, 125, 30, 48),
(3, 6, 67, 143, 86, 127, 31, 48),
(3, 6, 68, 145, 88, 129, 31, 49),
(3, 6, 69, 148, 89, 132, 31, 50),
(3, 6, 70, 151, 91, 134, 31, 50),
(3, 6, 71, 154, 93, 137, 32, 51),
(3, 6, 72, 156, 94, 139, 32, 52),
(3, 6, 73, 159, 96, 142, 32, 53),
(3, 6, 74, 162, 98, 144, 32, 53),
(3, 6, 75, 165, 99, 147, 33, 54),
(3, 6, 76, 168, 101, 150, 33, 55),
(3, 6, 77, 171, 103, 152, 33, 56),
(3, 6, 78, 174, 104, 155, 33, 56),
(3, 6, 79, 177, 106, 158, 34, 57),
(3, 6, 80, 180, 108, 161, 34, 58),
(4, 6, 55, 104, 77, 99, 29, 42),
(4, 6, 56, 107, 79, 102, 29, 43),
(4, 6, 57, 109, 80, 104, 29, 43),
(4, 6, 58, 111, 81, 106, 30, 44),
(4, 6, 59, 114, 83, 108, 30, 44),
(4, 6, 60, 116, 84, 110, 30, 45),
(4, 6, 61, 118, 85, 112, 30, 46),
(4, 6, 62, 121, 87, 114, 30, 46),
(4, 6, 63, 123, 88, 117, 31, 47),
(4, 6, 64, 126, 90, 119, 31, 47),
(4, 6, 65, 129, 91, 121, 31, 48),
(4, 6, 66, 131, 93, 124, 31, 49),
(4, 6, 67, 134, 94, 126, 32, 49),
(4, 6, 68, 136, 96, 128, 32, 50),
(4, 6, 69, 139, 97, 131, 32, 51),
(4, 6, 70, 142, 99, 133, 32, 51),
(4, 6, 71, 145, 101, 136, 33, 52),
(4, 6, 72, 147, 102, 138, 33, 53),
(4, 6, 73, 150, 104, 141, 33, 54),
(4, 6, 74, 153, 106, 143, 33, 54),
(4, 6, 75, 156, 107, 146, 34, 55),
(4, 6, 76, 159, 109, 149, 34, 56),
(4, 6, 77, 162, 111, 151, 34, 57),
(4, 6, 78, 165, 112, 154, 34, 57),
(4, 6, 79, 168, 114, 157, 35, 58),
(4, 6, 80, 171, 116, 160, 35, 59),
(5, 6, 55, 107, 71, 99, 27, 47),
(5, 6, 56, 110, 73, 102, 27, 48),
(5, 6, 57, 112, 74, 104, 27, 48),
(5, 6, 58, 114, 75, 106, 28, 49),
(5, 6, 59, 117, 77, 108, 28, 49),
(5, 6, 60, 119, 78, 110, 28, 50),
(5, 6, 61, 121, 79, 112, 28, 51),
(5, 6, 62, 124, 81, 114, 28, 51),
(5, 6, 63, 126, 82, 117, 29, 52),
(5, 6, 64, 129, 84, 119, 29, 52),
(5, 6, 65, 132, 85, 121, 29, 53),
(5, 6, 66, 134, 87, 124, 29, 54),
(5, 6, 67, 137, 88, 126, 30, 54),
(5, 6, 68, 139, 90, 128, 30, 55),
(5, 6, 69, 142, 91, 131, 30, 56),
(5, 6, 70, 145, 93, 133, 30, 56),
(5, 6, 71, 148, 95, 136, 31, 57),
(5, 6, 72, 150, 96, 138, 31, 58),
(5, 6, 73, 153, 98, 141, 31, 59),
(5, 6, 74, 156, 100, 143, 31, 59),
(5, 6, 75, 159, 101, 146, 32, 60),
(5, 6, 76, 162, 103, 149, 32, 61),
(5, 6, 77, 165, 105, 151, 32, 62),
(5, 6, 78, 168, 106, 154, 32, 62),
(5, 6, 79, 171, 108, 157, 33, 63),
(5, 6, 80, 174, 110, 160, 33, 64),
(6, 6, 55, 113, 69, 100, 25, 44),
(6, 6, 56, 116, 71, 103, 25, 45),
(6, 6, 57, 118, 72, 105, 25, 45),
(6, 6, 58, 120, 73, 107, 26, 46),
(6, 6, 59, 123, 75, 109, 26, 46),
(6, 6, 60, 125, 76, 111, 26, 47),
(6, 6, 61, 127, 77, 113, 26, 48),
(6, 6, 62, 130, 79, 115, 26, 48),
(6, 6, 63, 132, 80, 118, 27, 49),
(6, 6, 64, 135, 82, 120, 27, 49),
(6, 6, 65, 138, 83, 122, 27, 50),
(6, 6, 66, 140, 85, 125, 27, 51),
(6, 6, 67, 143, 86, 127, 28, 51),
(6, 6, 68, 145, 88, 129, 28, 52),
(6, 6, 69, 148, 89, 132, 28, 53),
(6, 6, 70, 151, 91, 134, 28, 53),
(6, 6, 71, 154, 93, 137, 29, 54),
(6, 6, 72, 156, 94, 139, 29, 55),
(6, 6, 73, 159, 96, 142, 29, 56),
(6, 6, 74, 162, 98, 144, 29, 56),
(6, 6, 75, 165, 99, 147, 30, 57),
(6, 6, 76, 168, 101, 150, 30, 58),
(6, 6, 77, 171, 103, 152, 30, 59),
(6, 6, 78, 174, 104, 155, 30, 59),
(6, 6, 79, 177, 106, 158, 31, 60),
(6, 6, 80, 180, 108, 161, 31, 61),
(7, 6, 55, 103, 75, 99, 32, 42),
(7, 6, 56, 106, 77, 102, 32, 43),
(7, 6, 57, 108, 78, 104, 32, 43),
(7, 6, 58, 110, 79, 106, 33, 44),
(7, 6, 59, 113, 81, 108, 33, 44),
(7, 6, 60, 115, 82, 110, 33, 45),
(7, 6, 61, 117, 83, 112, 33, 46),
(7, 6, 62, 120, 85, 114, 33, 46),
(7, 6, 63, 122, 86, 117, 34, 47),
(7, 6, 64, 125, 88, 119, 34, 47),
(7, 6, 65, 128, 89, 121, 34, 48),
(7, 6, 66, 130, 91, 124, 34, 49),
(7, 6, 67, 133, 92, 126, 35, 49),
(7, 6, 68, 135, 94, 128, 35, 50),
(7, 6, 69, 138, 95, 131, 35, 51),
(7, 6, 70, 141, 97, 133, 35, 51),
(7, 6, 71, 144, 99, 136, 36, 52),
(7, 6, 72, 146, 100, 138, 36, 53),
(7, 6, 73, 149, 102, 141, 36, 54),
(7, 6, 74, 152, 104, 143, 36, 54),
(7, 6, 75, 155, 105, 146, 37, 55),
(7, 6, 76, 158, 107, 149, 37, 56),
(7, 6, 77, 161, 109, 151, 37, 57),
(7, 6, 78, 164, 110, 154, 37, 57),
(7, 6, 79, 167, 112, 157, 38, 58),
(7, 6, 80, 170, 114, 160, 38, 59),
(8, 6, 55, 109, 75, 99, 25, 43),
(8, 6, 56, 112, 77, 102, 25, 44),
(8, 6, 57, 114, 78, 104, 25, 44),
(8, 6, 58, 116, 79, 106, 26, 45),
(8, 6, 59, 119, 81, 108, 26, 45),
(8, 6, 60, 121, 82, 110, 26, 46),
(8, 6, 61, 123, 83, 112, 26, 47),
(8, 6, 62, 126, 85, 114, 26, 47),
(8, 6, 63, 128, 86, 117, 27, 48),
(8, 6, 64, 131, 88, 119, 27, 48),
(8, 6, 65, 134, 89, 121, 27, 49),
(8, 6, 66, 136, 91, 124, 27, 50),
(8, 6, 67, 139, 92, 126, 28, 50),
(8, 6, 68, 141, 94, 128, 28, 51),
(8, 6, 69, 144, 95, 131, 28, 52),
(8, 6, 70, 147, 97, 133, 28, 52),
(8, 6, 71, 150, 99, 136, 29, 53),
(8, 6, 72, 152, 100, 138, 29, 54),
(8, 6, 73, 155, 102, 141, 29, 55),
(8, 6, 74, 158, 104, 143, 29, 55),
(8, 6, 75, 161, 105, 146, 30, 56),
(8, 6, 76, 164, 107, 149, 30, 57),
(8, 6, 77, 167, 109, 151, 30, 58),
(8, 6, 78, 170, 110, 154, 30, 58),
(8, 6, 79, 173, 112, 157, 31, 59),
(8, 6, 80, 176, 114, 160, 31, 60),
(10, 6, 55, 105, 75, 99, 32, 40),
(10, 6, 56, 108, 77, 102, 32, 41),
(10, 6, 57, 110, 78, 104, 32, 41),
(10, 6, 58, 112, 79, 106, 33, 42),
(10, 6, 59, 115, 81, 108, 33, 42),
(10, 6, 60, 117, 82, 110, 33, 43),
(10, 6, 61, 119, 83, 112, 33, 44),
(10, 6, 62, 122, 85, 114, 33, 44),
(10, 6, 63, 124, 86, 117, 34, 45),
(10, 6, 64, 127, 88, 119, 34, 45),
(10, 6, 65, 130, 89, 121, 34, 46),
(10, 6, 66, 132, 91, 124, 34, 47),
(10, 6, 67, 135, 92, 126, 35, 47),
(10, 6, 68, 137, 94, 128, 35, 48),
(10, 6, 69, 140, 95, 131, 35, 49),
(10, 6, 70, 143, 97, 133, 35, 49),
(10, 6, 71, 146, 99, 136, 36, 50),
(10, 6, 72, 148, 100, 138, 36, 51),
(10, 6, 73, 151, 102, 141, 36, 52),
(10, 6, 74, 154, 104, 143, 36, 52),
(10, 6, 75, 157, 105, 146, 37, 53),
(10, 6, 76, 160, 107, 149, 37, 54),
(10, 6, 77, 163, 109, 151, 37, 55),
(10, 6, 78, 166, 110, 154, 37, 55),
(10, 6, 79, 169, 112, 157, 38, 56),
(10, 6, 80, 172, 114, 160, 38, 57),
(11, 6, 55, 109, 70, 99, 29, 44),
(11, 6, 56, 112, 72, 102, 29, 45),
(11, 6, 57, 114, 73, 104, 29, 45),
(11, 6, 58, 116, 74, 106, 30, 46),
(11, 6, 59, 119, 76, 108, 30, 46),
(11, 6, 60, 121, 77, 110, 30, 47),
(11, 6, 61, 123, 78, 112, 30, 48),
(11, 6, 62, 126, 80, 114, 30, 48),
(11, 6, 63, 128, 81, 117, 31, 49),
(11, 6, 64, 131, 83, 119, 31, 49),
(11, 6, 65, 134, 84, 121, 31, 50),
(11, 6, 66, 136, 86, 124, 31, 51),
(11, 6, 67, 139, 87, 126, 32, 51),
(11, 6, 68, 141, 89, 128, 32, 52),
(11, 6, 69, 144, 90, 131, 32, 53),
(11, 6, 70, 147, 92, 133, 32, 53),
(11, 6, 71, 150, 94, 136, 33, 54),
(11, 6, 72, 152, 95, 138, 33, 55),
(11, 6, 73, 155, 97, 141, 33, 56),
(11, 6, 74, 158, 99, 143, 33, 56),
(11, 6, 75, 161, 100, 146, 34, 57),
(11, 6, 76, 164, 102, 149, 34, 58),
(11, 6, 77, 167, 104, 151, 34, 59),
(11, 6, 78, 170, 105, 154, 34, 59),
(11, 6, 79, 173, 107, 157, 35, 60),
(11, 6, 80, 176, 109, 160, 35, 61);
