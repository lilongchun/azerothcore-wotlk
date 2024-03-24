-- DB update 2024_02_20_00 -> 2024_02_20_01
--
DELETE FROM `waypoints` WHERE `entry` = 774400;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES 
(774400, 1, 399.62225, -2118.7478, 131.91774, NULL, 0),
(774400, 2, 398.37225, -2113.7478, 131.91774, NULL, 0),
(774400, 3, 398.12225, -2112.4978, 131.91774, NULL, 0),
(774400, 4, 396.62225, -2104.7478, 131.91774, NULL, 0),
(774400, 5, 396.1905, -2103.1377, 131.79202, NULL, 0),
(774400, 6, 395.4405, -2100.6377, 131.79202, NULL, 0),
(774400, 7, 394.1905, -2094.1377, 131.79202, NULL, 0),
(774400, 8, 393.6905, -2092.3877, 131.79202, NULL, 0),
(774400, 9, 393.22336, -2090.4102, 131.73431, NULL, 0),
(774400, 10, 392.72336, -2089.1602, 131.73431, NULL, 0),
(774400, 11, 392.47336, -2087.9102, 131.73431, NULL, 0),
(774400, 12, 392.22336, -2086.9102, 131.73431, NULL, 0),
(774400, 13, 390.91733, -2081.4263, 131.80086, NULL, 0),
(774400, 14, 391.84827, -2085.3342, 131.70673, NULL, 0),
(774400, 15, 392.43378, -2087.0466, 131.93723, NULL, 0),
(774400, 16, 393.18378, -2089.5466, 131.93723, NULL, 0),
(774400, 17, 393.43378, -2090.7966, 131.93723, NULL, 0),
(774400, 18, 393.68378, -2092.2966, 131.93723, NULL, 0),
(774400, 19, 393.93378, -2093.7966, 131.93723, NULL, 0),
(774400, 20, 394.68378, -2097.0466, 131.93723, NULL, 0),
(774400, 21, 395.69, -2100.9307, 131.91774, NULL, 0),
(774400, 22, 396.44, -2103.4307, 131.91774, NULL, 0),
(774400, 23, 396.69, -2104.4307, 131.91774, NULL, 0),
(774400, 24, 398.19, -2112.4307, 131.91774, NULL, 0),
(774400, 25, 398.19, -2113.1807, 131.91774, NULL, 0),
(774400, 26, 398.44, -2113.9307, 131.91774, NULL, 0),
(774400, 27, 399.44, -2118.6807, 131.91774, NULL, 0),
(774400, 28, 399.72522, -2119.7366, 131.66774, NULL, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7744 AND `id` = 2 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7744, 0, 2, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 774400, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Innkeeper Thulfram - On Respawn - Start waypoint');
