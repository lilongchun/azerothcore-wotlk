INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619295401445296600');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|
1| -- MECHANIC_CHARM
16| -- MECHANIC_FEAR
64| -- MECHANIC_ROOT
512| -- MECHANIC_SLEEP
4096| -- MECHANIC_FREEZE
65536| -- MECHANIC_POLYMORPH
536870912 -- MECHANIC_SAPPED
WHERE `entry` IN (34701, 34705, 34657);
