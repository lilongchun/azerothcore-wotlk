--
SET @EVENT := 9;

DELETE FROM `game_event_creature` WHERE `eventEntry` = @EVENT AND `guid` IN
(146602,
 146609,
 146618,
 146619,
 146621);

INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@EVENT, 146602),
(@EVENT, 146609),
(@EVENT, 146618),
(@EVENT, 146619),
(@EVENT, 146621);

DELETE FROM `game_event_gameobject` WHERE `eventEntry` = @EVENT AND `guid` IN
(9780,
 9754,
 9782,
 9751,
 9766,
 9756,
 9747,
 9749,
 9809,
 9774,
 9746,
 9748,
 9802,
 9808,
 9752,
 9760,
 9792,
 9762,
 9778,
 9757,
 9770,
 9793,
 9758,
 9769,
 9830,
 9828,
 9761,
 9779,
 9791,
 9773,
 9768,
 9833,
 9759,
 9800,
 9804,
 9801,
 9787,
 9783,
 9798,
 9772,
 9794,
 9781,
 9790,
 9795,
 9813,
 9753,
 9811,
 9805,
 9785,
 9807,
 9797,
 9799,
 9810,
 9784,
 9771,
 9796,
 9743,
 9803,
 9786,
 9777,
 9767,
 9765,
 9789,
 9763,
 242252,
 242257,
 242259,
 242267,
 242253,
 242254,
 242275,
 242274,
 242273,
 242271,
 242263,
 242272,
 242276,
 242270,
 242265,
 242255,
 242306,
 242307,
 242302,
 242301,
 242304,
 242303,
 242300,
 242299,
 242305,
 242266,
 242264,
 242282,
 242258,
 242261,
 242284,
 242283,
 242256,
 242260,
 242278,
 242277,
 242279,
 242280,
 242281);

INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@EVENT, 9780),
(@EVENT, 9754),
(@EVENT, 9782),
(@EVENT, 9751),
(@EVENT, 9766),
(@EVENT, 9756),
(@EVENT, 9747),
(@EVENT, 9749),
(@EVENT, 9809),
(@EVENT, 9774),
(@EVENT, 9746),
(@EVENT, 9748),
(@EVENT, 9802),
(@EVENT, 9808),
(@EVENT, 9752),
(@EVENT, 9760),
(@EVENT, 9792),
(@EVENT, 9762),
(@EVENT, 9778),
(@EVENT, 9757),
(@EVENT, 9770),
(@EVENT, 9793),
(@EVENT, 9758),
(@EVENT, 9769),
(@EVENT, 9830),
(@EVENT, 9828),
(@EVENT, 9761),
(@EVENT, 9779),
(@EVENT, 9791),
(@EVENT, 9773),
(@EVENT, 9768),
(@EVENT, 9833),
(@EVENT, 9759),
(@EVENT, 9800),
(@EVENT, 9804),
(@EVENT, 9801),
(@EVENT, 9787),
(@EVENT, 9783),
(@EVENT, 9798),
(@EVENT, 9772),
(@EVENT, 9794),
(@EVENT, 9781),
(@EVENT, 9790),
(@EVENT, 9795),
(@EVENT, 9813),
(@EVENT, 9753),
(@EVENT, 9811),
(@EVENT, 9805),
(@EVENT, 9785),
(@EVENT, 9807),
(@EVENT, 9797),
(@EVENT, 9799),
(@EVENT, 9810),
(@EVENT, 9784),
(@EVENT, 9771),
(@EVENT, 9796),
(@EVENT, 9743),
(@EVENT, 9803),
(@EVENT, 9786),
(@EVENT, 9777),
(@EVENT, 9767),
(@EVENT, 9765),
(@EVENT, 9789),
(@EVENT, 9763),
(@EVENT, 242252),
(@EVENT, 242257),
(@EVENT, 242259),
(@EVENT, 242267),
(@EVENT, 242253),
(@EVENT, 242254),
(@EVENT, 242275),
(@EVENT, 242274),
(@EVENT, 242273),
(@EVENT, 242271),
(@EVENT, 242263),
(@EVENT, 242272),
(@EVENT, 242276),
(@EVENT, 242270),
(@EVENT, 242265),
(@EVENT, 242255),
(@EVENT, 242306),
(@EVENT, 242307),
(@EVENT, 242302),
(@EVENT, 242301),
(@EVENT, 242304),
(@EVENT, 242303),
(@EVENT, 242300),
(@EVENT, 242299),
(@EVENT, 242305),
(@EVENT, 242266),
(@EVENT, 242264),
(@EVENT, 242282),
(@EVENT, 242258),
(@EVENT, 242261),
(@EVENT, 242284),
(@EVENT, 242283),
(@EVENT, 242256),
(@EVENT, 242260),
(@EVENT, 242278),
(@EVENT, 242277),
(@EVENT, 242279),
(@EVENT, 242280),
(@EVENT, 242281);