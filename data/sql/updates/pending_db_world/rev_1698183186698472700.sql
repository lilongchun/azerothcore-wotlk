-- Darkmoon Card: Vengeance
DELETE FROM `spell_proc_event` WHERE `entry`=39444;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(39444, 0, 0, 0, 0, 0, 0, 9283, 0, 0, 0, 0);
