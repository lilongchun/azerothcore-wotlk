ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_00 2016_08_14_02 bit;

UPDATE gameobject_template
SET data10='29519' WHERE entry='181597' AND '181598'
