INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619550059726252710');

SET
@POOL            = 50003,
@POOLSIZE        = 40,
@POOLDESC1        = 'Dreamfoil zone 46 Burning Steppes',
@POOLDESC2        = 'Sungrass zone 46 Burning Steppes',
@POOLDESC3        = 'Golden Sansam zone 46 Burning Steppes',
@POOLDESC4        = 'Mountain Silversage zone 46 Burning Steppes',
@RESPAWN         = 60,
@GUID = '4527,6810,6829,6830,19259,19285,19286,19296,19299,19315,19316,19321,19324,19339,19340,19346,19361,19362,19366,19367,19387,19388,19395,19407,19408,19426,19430,19433,19470,19475,19484,19493,19494,19510,19516,19520,19554,19566,19577,19596,19597,19624,19625,19634,19640,19641,19642,19643,19652,19653,29585,33419,39952,39954,63632,86416,87305,
16028,16042,16052,16054,16058,16059,16068,16069,16082,16106,16131,16155,16192,16225,16226,16227,39957,39958,87177,
4525,6823,6857,6873,18944,18954,18955,18958,18961,18962,18963,18970,18979,19018,19020,19024,19025,19034,19039,19042,19049,19051,19096,19109,19114,19150,19180,19194,19217,19226,
4600,6832,19666,19668,19688,19714,19723,19737,19742,19757,19760,19774,19779,19803,19806,19814,19818,19819,19820,19821,19832,19865,29584,35301,39955,65277';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,'MASTER Herbs Burning Steppes zone 46');

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(4527,@POOL,0,@POOLDESC1),
(6810,@POOL,0,@POOLDESC1),
(6829,@POOL,0,@POOLDESC1),
(6830,@POOL,0,@POOLDESC1),
(19259,@POOL,0,@POOLDESC1),
(19285,@POOL,0,@POOLDESC1),
(19286,@POOL,0,@POOLDESC1),
(19296,@POOL,0,@POOLDESC1),
(19299,@POOL,0,@POOLDESC1),
(19315,@POOL,0,@POOLDESC1),
(19316,@POOL,0,@POOLDESC1),
(19321,@POOL,0,@POOLDESC1),
(19324,@POOL,0,@POOLDESC1),
(19339,@POOL,0,@POOLDESC1),
(19340,@POOL,0,@POOLDESC1),
(19346,@POOL,0,@POOLDESC1),
(19361,@POOL,0,@POOLDESC1),
(19362,@POOL,0,@POOLDESC1),
(19366,@POOL,0,@POOLDESC1),
(19367,@POOL,0,@POOLDESC1),
(19387,@POOL,0,@POOLDESC1),
(19388,@POOL,0,@POOLDESC1),
(19395,@POOL,0,@POOLDESC1),
(19407,@POOL,0,@POOLDESC1),
(19408,@POOL,0,@POOLDESC1),
(19426,@POOL,0,@POOLDESC1),
(19430,@POOL,0,@POOLDESC1),
(19433,@POOL,0,@POOLDESC1),
(19470,@POOL,0,@POOLDESC1),
(19475,@POOL,0,@POOLDESC1),
(19484,@POOL,0,@POOLDESC1),
(19493,@POOL,0,@POOLDESC1),
(19494,@POOL,0,@POOLDESC1),
(19510,@POOL,0,@POOLDESC1),
(19516,@POOL,0,@POOLDESC1),
(19520,@POOL,0,@POOLDESC1),
(19554,@POOL,0,@POOLDESC1),
(19566,@POOL,0,@POOLDESC1),
(19577,@POOL,0,@POOLDESC1),
(19596,@POOL,0,@POOLDESC1),
(19597,@POOL,0,@POOLDESC1),
(19624,@POOL,0,@POOLDESC1),
(19625,@POOL,0,@POOLDESC1),
(19634,@POOL,0,@POOLDESC1),
(19640,@POOL,0,@POOLDESC1),
(19641,@POOL,0,@POOLDESC1),
(19642,@POOL,0,@POOLDESC1),
(19643,@POOL,0,@POOLDESC1),
(19652,@POOL,0,@POOLDESC1),
(19653,@POOL,0,@POOLDESC1),
(29585,@POOL,0,@POOLDESC1),
(33419,@POOL,0,@POOLDESC1),
(39952,@POOL,0,@POOLDESC1),
(39954,@POOL,0,@POOLDESC1),
(63632,@POOL,0,@POOLDESC1),
(86416,@POOL,0,@POOLDESC1),
(87305,@POOL,0,@POOLDESC1),
(16028,@POOL,0,@POOLDESC2),
(16042,@POOL,0,@POOLDESC2),
(16052,@POOL,0,@POOLDESC2),
(16054,@POOL,0,@POOLDESC2),
(16058,@POOL,0,@POOLDESC2),
(16059,@POOL,0,@POOLDESC2),
(16068,@POOL,0,@POOLDESC2),
(16069,@POOL,0,@POOLDESC2),
(16082,@POOL,0,@POOLDESC2),
(16106,@POOL,0,@POOLDESC2),
(16131,@POOL,0,@POOLDESC2),
(16155,@POOL,0,@POOLDESC2),
(16192,@POOL,0,@POOLDESC2),
(16225,@POOL,0,@POOLDESC2),
(16226,@POOL,0,@POOLDESC2),
(16227,@POOL,0,@POOLDESC2),
(39957,@POOL,0,@POOLDESC2),
(39958,@POOL,0,@POOLDESC2),
(87177,@POOL,0,@POOLDESC2),
(4525,@POOL,0,@POOLDESC3),
(6823,@POOL,0,@POOLDESC3),
(6857,@POOL,0,@POOLDESC3),
(6873,@POOL,0,@POOLDESC3),
(18944,@POOL,0,@POOLDESC3),
(18954,@POOL,0,@POOLDESC3),
(18955,@POOL,0,@POOLDESC3),
(18958,@POOL,0,@POOLDESC3),
(18961,@POOL,0,@POOLDESC3),
(18962,@POOL,0,@POOLDESC3),
(18963,@POOL,0,@POOLDESC3),
(18970,@POOL,0,@POOLDESC3),
(18979,@POOL,0,@POOLDESC3),
(19018,@POOL,0,@POOLDESC3),
(19020,@POOL,0,@POOLDESC3),
(19024,@POOL,0,@POOLDESC3),
(19025,@POOL,0,@POOLDESC3),
(19034,@POOL,0,@POOLDESC3),
(19039,@POOL,0,@POOLDESC3),
(19042,@POOL,0,@POOLDESC3),
(19049,@POOL,0,@POOLDESC3),
(19051,@POOL,0,@POOLDESC3),
(19096,@POOL,0,@POOLDESC3),
(19109,@POOL,0,@POOLDESC3),
(19114,@POOL,0,@POOLDESC3),
(19150,@POOL,0,@POOLDESC3),
(19180,@POOL,0,@POOLDESC3),
(19194,@POOL,0,@POOLDESC3),
(19217,@POOL,0,@POOLDESC3),
(19226,@POOL,0,@POOLDESC3),
(4600,@POOL,0,@POOLDESC4),
(6832,@POOL,0,@POOLDESC4),
(19666,@POOL,0,@POOLDESC4),
(19668,@POOL,0,@POOLDESC4),
(19688,@POOL,0,@POOLDESC4),
(19714,@POOL,0,@POOLDESC4),
(19723,@POOL,0,@POOLDESC4),
(19737,@POOL,0,@POOLDESC4),
(19742,@POOL,0,@POOLDESC4),
(19757,@POOL,0,@POOLDESC4),
(19760,@POOL,0,@POOLDESC4),
(19774,@POOL,0,@POOLDESC4),
(19779,@POOL,0,@POOLDESC4),
(19803,@POOL,0,@POOLDESC4),
(19806,@POOL,0,@POOLDESC4),
(19814,@POOL,0,@POOLDESC4),
(19818,@POOL,0,@POOLDESC4),
(19819,@POOL,0,@POOLDESC4),
(19820,@POOL,0,@POOLDESC4),
(19821,@POOL,0,@POOLDESC4),
(19832,@POOL,0,@POOLDESC4),
(19865,@POOL,0,@POOLDESC4),
(29584,@POOL,0,@POOLDESC4),
(35301,@POOL,0,@POOLDESC4),
(39955,@POOL,0,@POOLDESC4),
(65277,@POOL,0,@POOLDESC4);

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '46' WHERE FIND_IN_SET (`guid`,@GUID);

