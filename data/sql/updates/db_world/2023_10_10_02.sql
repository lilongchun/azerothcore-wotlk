-- DB update 2023_10_10_01 -> 2023_10_10_02
-- Ores and Herbs should be visible in visible in all phases
UPDATE `gameobject` SET `phaseMask`='255' WHERE  `id` IN(1617,1618,1619,3724,3725,3726,1620,1621,3727,3729,1622,1623,1624,2045,3730,2041,2046,1628,2044,2041,2043,176636,176642,142140,142141,142142,142143,142144,180165,183046,180164,176641,176640,176639,176638,176637,142145,176583,176584,176586,176587,176588,176589,180166,180167, 180168,183043,183044,183045,181270,181271,181275,181276,181277,181278,183385,181279,181282,181281,189973,190169,190173,190175,190174,190170,190172,191019,190171,190176,1731,181248,103713,2055,3763,1732,3764,103711,181249,2054,1733,1735,105569,73939,1734,2040,123310,150079,150080,176645,181109,2047,123309,150081,150082,181108,176643,123848,175404,181555,181556,181557,181569,181570,189978,189979,189980,189981,191133) AND `map` IN(0,1,530,571);
