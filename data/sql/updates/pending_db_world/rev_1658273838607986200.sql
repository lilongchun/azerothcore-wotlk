--
/* Movetype and wander distance corrections for Entranceway */
UPDATE `creature` SET `wander_distance`='2', `MovementType`='1' WHERE  `guid` IN (49739, 49740);
