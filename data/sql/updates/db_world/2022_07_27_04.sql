-- DB update 2022_07_27_03 -> 2022_07_27_04
DELETE FROM `creature_formations` WHERE `leaderguid` IN (49609, 49059, 51584, 49309, 51350, 51974, 51570, 49793, 49274, 51979, 49290);
DELETE FROM `creature_formations` WHERE `leaderguid` = 49065 AND `memberGUID` = 49051;
DELETE FROM `creature_formations` WHERE `leaderguid` = 49062 AND `memberGUID` = 49052;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(51584, 51584, 0, 0, 3, 0, 0),
(51584, 49801, 0, 0, 3, 0, 0),
(51584, 49802, 0, 0, 3, 0, 0),
(51584, 49803, 0, 0, 3, 0, 0),
(51584, 49804, 0, 0, 3, 0, 0),
(51584, 51583, 0, 0, 3, 0, 0),
(51584, 49805, 0, 0, 3, 0, 0),
(51584, 51582, 0, 0, 3, 0, 0),
(49309, 49309, 0, 0, 3, 0, 0),
(49309, 49296, 0, 0, 3, 0, 0),
(49309, 49297, 0, 0, 3, 0, 0),
(49309, 49308, 0, 0, 3, 0, 0),
(49309, 49300, 0, 0, 3, 0, 0),
(49309, 49307, 0, 0, 3, 0, 0),
(49309, 49299, 0, 0, 3, 0, 0),
(49309, 49298, 0, 0, 3, 0, 0),
(51350, 51350, 0, 0, 3, 0, 0),
(51350, 51351, 0, 0, 3, 0, 0),
(51350, 49813, 0, 0, 3, 0, 0),
(51350, 51352, 0, 0, 3, 0, 0),
(51350, 49812, 0, 0, 3, 0, 0),
(51350, 49811, 0, 0, 3, 0, 0),
(51350, 51349, 0, 0, 3, 0, 0),
(51974, 51974, 0, 0, 3, 0, 0),
(51974, 51460, 0, 0, 3, 0, 0),
(51974, 51983, 0, 0, 3, 0, 0),
(51974, 51461, 0, 0, 3, 0, 0),
(51570, 51570, 0, 0, 3, 0, 0),
(51570, 51967, 0, 0, 3, 0, 0),
(51570, 51571, 0, 0, 3, 0, 0),
(51570, 51572, 0, 0, 3, 0, 0),
(51570, 51968, 0, 0, 3, 0, 0),
(51570, 51969, 0, 0, 3, 0, 0),
(49793, 49793, 0, 0, 3, 0, 0),
(49793, 49796, 0, 0, 3, 0, 0),
(49793, 49795, 0, 0, 3, 0, 0),
(49793, 49794, 0, 0, 3, 0, 0),
(49274, 49274, 0, 0, 3, 0, 0),
(49274, 49276, 0, 0, 3, 0, 0),
(49274, 51565, 0, 0, 3, 0, 0),
(49274, 51564, 0, 0, 3, 0, 0),
(49274, 49275, 0, 0, 3, 0, 0),
(49274, 51462, 0, 0, 3, 0, 0),
(51979, 51979, 0, 0, 3, 0, 0),
(51979, 51455, 0, 0, 3, 0, 0),
(51979, 51453, 0, 0, 3, 0, 0),
(51979, 51454, 0, 0, 3, 0, 0),
(51979, 51980, 0, 0, 3, 0, 0),
(51979, 51978, 0, 0, 3, 0, 0),
(49290, 49290, 0, 0, 3, 0, 0),
(49290, 51580, 0, 0, 3, 0, 0),
(49290, 49304, 0, 0, 3, 0, 0),
(49290, 51581, 0, 0, 3, 0, 0),
(49290, 49810, 0, 0, 3, 0, 0),
(49290, 49800, 0, 0, 3, 0, 0),
(49290, 49291, 0, 0, 3, 0, 0),
(49290, 49306, 0, 0, 3, 0, 0),
(49290, 49289, 0, 0, 3, 0, 0),
(49059, 49059, 0, 0, 3, 0, 0),
(49059, 49060, 0, 0, 3, 0, 0),
(49059, 49061, 0, 0, 3, 0, 0),
(49065, 49051, 0, 0, 3, 0, 0),
(49062, 49052, 0, 0, 3, 0, 0),
(49609, 49609, 0, 0, 3, 0, 0),
(49609, 49574, 0, 0, 3, 0, 0),
(49609, 49421, 0, 0, 3, 0, 0),
(49609, 49576, 0, 0, 3, 0, 0),
(49609, 49402, 0, 0, 3, 0, 0),
(49609, 49650, 0, 0, 3, 0, 0),
(49609, 49575, 0, 0, 3, 0, 0),
(49609, 49573, 0, 0, 3, 0, 0),
(49609, 49403, 0, 0, 3, 0, 0),
(49609, 49577, 0, 0, 3, 0, 0);
