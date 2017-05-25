ALTER TABLE world_db_version CHANGE COLUMN 2016_08_19_00 2016_08_19_01 BIT;

/*
Issue: Not work quest id 11543 #93
Missing SAI for the correct execution of quest

Create SAI for ending quest
*/

UPDATE creature_template SET AIName="SmartAI" WHERE entry IN (25090,25091,25092); 
DELETE FROM smart_scripts WHERE entryorguid IN (25090,25091,25092) AND source_type=0; 
INSERT INTO smart_scripts VALUES 
(25090,0,0,0,8,0,100,0,45115,0,0,0,33,25090,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sin'Loren - On spellhit 45115 - Kill Credit"), 
(25091,0,0,0,8,0,100,0,45115,0,0,0,33,25091,0,0,0,0,0,7,0,0,0,0,0,0,0,"Bloodoath - On spellhit 45115 - Kill Credit"), 
(25092,0,0,0,8,0,100,0,45115,0,0,0,33,25092,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dawnchaser - On spellhit 45115 - Kill Credit"); 
