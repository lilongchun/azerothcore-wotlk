-- Update creature 38030 'Crown Underling' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 38030) AND (`guid` IN (244601, 244602, 244603, 244604, 244605));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(244601, 38030, 530, 1, 1, 0, -1781.329833984375, 4851.0380859375, 2.513961315155029296, 2.835983514785766601, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244602, 38030, 530, 1, 1, 0, -1779.32470703125, 4863.93212890625, 3.006150245666503906, 4.906230449676513671, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244603, 38030, 530, 1, 1, 0, -1779.8524169921875, 4824.77587890625, 6.007839679718017578, 5.427973747253417968, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244604, 38030, 530, 1, 1, 0, -1787.748291015625, 4837.8662109375, 5.470133304595947265, 6.230825424194335937, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244605, 38030, 530, 1, 1, 0, -1802.82470703125, 4813.43994140625, 8.524339675903320312, 3.665004253387451171, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 38030) AND (`guid` IN (12505, 12506, 12507, 12508, 12509, 12510, 12511));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12505, 38030, 530, 1, 1, 0, -1806.8663330078125, 4872.65966796875, 0.008199334144592285, 0.405036032199859619, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12506, 38030, 530, 1, 1, 0, -1808.2603759765625, 4850.1484375, 2.301921367645263671, 4.293509960174560546, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12507, 38030, 530, 1, 1, 0, -1822.0850830078125, 4860.3056640625, 2.916187286376953125, 5.428323268890380859, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12508, 38030, 530, 1, 1, 0, -1827.6875, 4816.27880859375, 5.800868511199951171, 0.752617359161376953, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12509, 38030, 530, 1, 1, 0, -1830.6788330078125, 4829.2802734375, 4.210715293884277343, 3.769911050796508789, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12510, 38030, 530, 1, 1, 0, -1835.234375, 4874.81103515625, 2.685863256454467773, 0.068494811654090881, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12511, 38030, 530, 1, 1, 0, -1837.5382080078125, 4845.34619140625, 3.129755258560180664, 2.373647689819335937, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- enable all spawns for eventEntry 8
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 38030));
INSERT INTO `game_event_creature` (SELECT 8, `guid` FROM `creature` WHERE `id1` = 38030);
