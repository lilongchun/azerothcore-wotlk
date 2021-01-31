/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `spell_linked_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_linked_spell` 
(
  `spell_trigger` mediumint(8) NOT NULL,
  `spell_effect` mediumint(8) NOT NULL DEFAULT 0,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  UNIQUE KEY `trigger_effect_type` (`spell_trigger`,`spell_effect`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `spell_linked_spell` WRITE;
/*!40000 ALTER TABLE `spell_linked_spell` DISABLE KEYS */;
INSERT INTO `spell_linked_spell` VALUES 
(-75731,-75055,0,'Instant Statue Pedestal'),
(-73077,-69188,0,'Rocket Pack - linked aura'),
(-71563,-71564,0,'Nevermelting Ice Crystal - Remove working trigger'),
(-71533,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71532,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71531,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71530,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71525,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71474,-72650,0,'Blood-Queen: Frenzied Bloodthirst 25man'),
(-71474,-72648,0,'Blood-Queen: Frenzied Bloodthirst 25man'),
(-71473,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-71450,-71459,0,'Remove Crown Chemical Co. Contraband when Crown Parcel Service Uniform is removed'),
(-71289,-73261,0,'Remove Scale Aura'),
(-71074,24870,0,'Buttermilk Delight'),
(-71073,24870,0,'Dark Desire'),
(-71071,24870,0,'Very Berry Cream'),
(-71068,24870,0,'Sweet Surprise'),
(-70923,-73015,0,'Blood-Queen: Uncontrollable Frenzy remove 25man'),
(-70923,-70924,0,'Blood-Queen: Uncontrollable Frenzy remove 10man'),
(-70879,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-70877,-72649,0,'Blood-Queen: Frenzied Bloodthirst 10man'),
(-70877,-72151,0,'Blood-Queen: Frenzied Bloodthirst 10man'),
(-70867,-70871,0,'Blood-Queen: Essence of the Blood Queen'),
(-69051,-69023,0,'Mirrored Soul'),
(-68875,-68899,0,'Wailing Souls'),
(-68839,68846,0,'Draw Corrupted Soul at the end of Corrupt Soul'),
(-68347,-43369,0,'Worg Disguise'),
(-68054,68052,0,'Jeeves - Say Goodbye'),
(-66623,-66624,0,'Bountiful Basket Bonus Remove'),
(-66083,66085,0,''),
(-65877,65878,0,''),
(-63320,-63321,0,'Glyph of Life Tap - Remove working trigger'),
(-63277,-65269,0,'General Vezax - Shadow Crash'),
(-62475,-62399,0,'System Shutdown - Overload Circuit'),
(-62475,-62375,0,'System Shutdown - Gathering Speed'),
(-62475,62472,0,'System Shutdown'),
(-61874,24870,0,'Noblegarden Chocolate'),
(-61291,-63311,0,'Glyph of Shadowflame Rank 2'),
(-59907,7,0,'Lightwell Charges - Suicide'),
(-59743,54343,0,''),
(-57620,-57874,0,'Twilight Phase Shift trigger remove'),
(-57620,61885,0,'Twilight Phase Shift immunity add'),
(-57350,60242,0,'Darkmoon Card: Illusion'),
(-55053,55601,0,'Deathbloom (H)'),
(-54361,54343,0,''),
(-53601,-58597,0,'Sacred Shield remove'),
(-53017,48330,0,'On Indisposed Expiring - Cast Create Amberseeds'),
(-52839,52775,0,'Disclosure quest, summon malmortis'),
(-52610,-62071,0,'Savage Roar'),
(-52278,52279,0,'Hell Hath a Fury: High Priestess Tua-Tua on Burn'),
(-52249,41909,0,'Hell Hath a Fury: Hex of Air Knockback'),
(-52098,52092,0,'Charge Up - Temporary Electrical Charge'),
(-52010,-51966,0,'Remove Scourge Disguise'),
(-51221,44280,0,'On spellfade Taxi to Explorers\' League Outpost - Spellcast Taxi to Explorers\' League'),
(-50493,-50314,0,'Disco Ball(Listening to Music)'),
(-50314,-50493,0,'Disco Ball'),
(-50098,50099,0,'The Beast Within - trigger Unleash the Beast!'),
(-50093,49886,0,'Chilled - trigger Breath Freeze!'),
(-49869,24919,0,'Nauseous - trigger Stun'),
(-49864,49860,0,'Gassy - trigger BOTM Belch Visual'),
(-49822,49823,0,'Bloated - trigger BOTM - Bubble Brew - Summon Bubble'),
(-49738,49737,0,'BOTM - Fire Brew - Belch Fire Visual'),
(-49097,49098,0,'When Out of Body Experience expires cast Arugal Teleport Back'),
(-48809,-48143,0,'Removing Binding Life removes Forgotten Aura'),
(-48417,-47406,0,'On Strip Detect Drakuru 04 fade - Remove Envision Drakuru'),
(-48263,-57340,0,'Frost Presence - Tank Class Passive Threat Remove'),
(-47960,-63311,0,'Glyph of Shadowflame Rank 1'),
(-47744,61611,0,'Cast other side when curse expires'),
(-47403,-47317,0,'On Strip Detect Drakuru 03 fade - Remove Envision Drakuru'),
(-47308,-47150,0,'On Strip Detect Drakuru 02 fade - Remove Envision Drakuru'),
(-47241,-50589,0,'Metamorphosis - Remove Immolation Aura'),
(-47122,-47118,0,'On Strip Detect Drakuru fade - Remove Envision Drakuru'),
(-46637,46638,0,'Break Ice (Madrigosa barrier'),
(-46637,47030,0,'Break Ice (Madrigosa barrier'),
(-45717,-45726,0,'Fog of Corruption - Charm'),
(-43883,-43332,0,'Rental racing ram removed removes Exhausted'),
(-43883,-43310,0,'Remove Ram level Neutral when Rental racing ram removed'),
(-43883,-42994,0,'Rental racing ram removed removes Gallop'),
(-43883,-42993,0,'Rental racing ram removed removes Canter'),
(-43883,-42992,0,'Rental racing ram removed removes Trot'),
(-43883,-42146,0,'Remove Brewfest Ram DND when Rental racing ram removed'),
(-43369,-68347,0,'Worg Disguise'),
(-43351,50167,0,''),
(-43351,61720,0,''),
(-42846,-36032,0,'Arcane Missiles Rank 13'),
(-42843,-36032,0,'Arcane Missiles Rank 12'),
(-42825,42868,0,'Cannon Prep Remove - Link Cannon Fire'),
(-40626,-40628,0,'Apexis Enlightenment speed remove'),
(-40625,-40627,0,'Apexis Emanations speed remove'),
(-40623,-40624,0,'Apexis Vibrations speed remove'),
(-39091,-39092,0,'Negative Charge'),
(-39088,-29659,0,'Positive Charge'),
(-38794,33686,0,'Murmur\'s Shockwave (Heroic)'),
(-38708,38991,0,'Upon Demoniac Visitation expiring cast Summon Demonaic Visitation'),
(-38704,-36032,0,'Arcane Missiles Rank 11'),
(-38699,-36032,0,'Arcane Missiles Rank 10'),
(-37968,37108,0,'Zephyrium Charged'),
(-37962,37108,0,'Zephyrium Charged'),
(-37940,37108,0,'Zephyrium Charged'),
(-37910,37108,0,'Zephyrium Charged'),
(-36812,37108,0,'Zephyrium Charged'),
(-33711,33686,0,'Murmur\'s Shockwave (Normal)'),
(-32756,-38081,0,'Shadowy Disguise: Remove model aura'),
(-32756,-38080,0,'Shadowy Disguise: Remove model aura'),
(-30423,38639,0,'Netherspite\'s Dominance'),
(-30422,38638,0,'Netherspite\'s Serenity'),
(-30421,38637,0,'Netherspite\'s Perseverence'),
(-30410,44032,0,'Manticron Cube Mind Exhaustion'),
(-29865,55594,0,'Deathbloom'),
(-29612,29650,0,'Incite Rage - Trigger Exhausted'),
(-28273,28274,0,'Bloodthistle'),
(-28169,28206,0,'Mutating Injection - Mutagen Explosion'),
(-28169,28240,0,'Mutating Injection - Poison Cloud'),
(-28084,-29660,0,'Negative Charge'),
(-28059,-29659,0,'Positive Charge'),
(-27075,-36032,0,'Arcane Missiles Rank 9'),
(-26023,-61418,0,'Pursuit of Justice remove'),
(-26022,-61417,0,'Pursuit of Justice remove'),
(-25780,-57340,0,'Righteous Fury - Tank Class Passive Threat Remove'),
(-25345,-36032,0,'Arcane Missiles Rank 8'),
(-24924,25023,0,'Hallow\'s End Candy'),
(-24919,49867,0,'Nauseous Stun - trigger vomit'),
(-24869,24870,0,'Bobbing Apple, Bread of the Dead, Winter Veil Cookie'),
(-24832,24731,0,'Cannon Prep Remove - Link Cannon Fire'),
(-24743,24731,0,'Cannon Prep Remove - Link Cannon Fire'),
(-21178,-57339,0,'Bear Form (Passive2) - Tank Class Passive Threat Remove'),
(-13927,-59917,0,'Enchant Gloves - Riding Skill Speed remove'),
(-12480,-12483,0,'Hex of Jammal\'an - Remove Charm'),
(-11826,11828,0,'Electromagnetic Gigaflux Reactivator - Cast Forked Lightning'),
(-11129,-28682,0,'Combustion'),
(-10212,-36032,0,'Arcane Missiles Rank 7'),
(-10211,-36032,0,'Arcane Missiles Rank 6'),
(-8417,-36032,0,'Arcane Missiles Rank 5'),
(-8416,-36032,0,'Arcane Missiles Rank 4'),
(-7376,-57339,0,'Defensive Stance Passive - Tank Class Passive Threat Remove'),
(-5229,-51185,0,'King of the Jungle - remove with enrage'),
(-5145,-36032,0,'Arcane Missiles Rank 3'),
(-5144,-36032,0,'Arcane Missiles Rank 2'),
(-5143,-36032,0,'Arcane Missiles Rank 1'),
(781,56446,0,'Disengage'),
(5784,31725,0,'Summon felsteed'),
(7376,57339,2,'Defensive Stance Passive - Tank Class Passive Threat'),
(7744,72757,0,'Will of the Forsaken Cooldown Trigger (WOTF)'),
(7943,-7946,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Black'),
(7943,-7945,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Green'),
(7943,-7944,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Blue'),
(7943,7942,2,'Evolving Ectoplasm (Red) - trigger Fire Immunity'),
(7944,-7946,1,'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Black'),
(7944,-7945,1,'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Green'),
(7944,-7943,1,'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Red'),
(7944,7940,2,'Evolving Ectoplasm (Blue) - trigger Frost Immunity'),
(7945,-7946,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Black'),
(7945,-7944,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Blue'),
(7945,-7943,1,'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Red'),
(7945,7941,2,'Evolving Ectoplasm (Green) - trigger Nature Immunity'),
(7946,-7945,1,'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Green'),
(7946,-7944,1,'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Blue'),
(7946,-7943,1,'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Red'),
(7946,7743,2,'Evolving Ectoplasm (Black) - trigger Shadow Immunity'),
(11511,11518,0,'Activate Bomb trigger'),
(13819,31726,0,'Summon Warhorse'),
(13927,59917,1,'Enchant Gloves - Riding Skill Speed add'),
(15237,23455,0,'Holy Nova (rank1)'),
(15430,23458,0,'Holy Nova (rank2)'),
(15431,23459,0,'Holy Nova (rank3)'),
(17767,54501,2,'Consume Shadows - Rank 1'),
(17850,54501,2,'Consume Shadows - Rank 2'),
(17851,54501,2,'Consume Shadows - Rank 3'),
(17852,54501,2,'Consume Shadows - Rank 4'),
(17853,54501,2,'Consume Shadows - Rank 5'),
(17854,54501,2,'Consume Shadows - Rank 6'),
(19263,67801,2,'Deterrence'),
(20066,-61840,1,'Repentance'),
(20594,65116,0,'Stoneform'),
(21178,57339,2,'Bear Form (Passive2) - Tank Class Passive Threat'),
(22352,-22520,1,'Phase Lasher (Fire) - Remove Phase Lasher (Frost)'),
(22352,-22354,1,'Phase Lasher (Fire) - Remove Phase Lasher (Arcane)'),
(22352,-22353,1,'Phase Lasher (Fire) - Remove Phase Lasher (Nature)'),
(22353,-22520,1,'Phase Lasher (Nature) - Remove Phase Lasher (Frost)'),
(22353,-22354,1,'Phase Lasher (Nature) - Remove Phase Lasher (Arcane)'),
(22353,-22352,1,'Phase Lasher (Nature) - Remove Phase Lasher (Fire)'),
(22354,-22520,1,'Phase Lasher (Arcane) - Remove Phase Lasher (Frost)'),
(22354,-22353,1,'Phase Lasher (Arcane) - Remove Phase Lasher (Nature)'),
(22354,-22352,1,'Phase Lasher (Arcane) - Remove Phase Lasher (Fire)'),
(22520,-22354,1,'Phase Lasher (Frost) - Remove Phase Lasher (Arcane)'),
(22520,-22353,1,'Phase Lasher (Frost) - Remove Phase Lasher (Nature)'),
(22520,-22352,1,'Phase Lasher (Frost) - Remove Phase Lasher (Fire)'),
(23161,31725,0,'Summon Nightmare'),
(23214,31726,0,'Summon Charger'),
(24023,12021,1,'Charge (24023) will now trigger Fixate'),
(24071,24020,1,'Axe Flurry will now throw axes at nearby players, stunning them'),
(24707,24870,2,'Bobbing Apple'),
(24714,24750,1,'Trick cast Trick'),
(24743,24730,1,'Cannon Prep - Link Teleport'),
(24743,24754,1,'Cannon Prep - Link Stun'),
(24832,24754,1,'Cannon Prep - Link Stun'),
(24832,24831,1,'Cannon Prep - Link Teleport'),
(25331,25329,0,'Holy Nova (rank7)'),
(25780,57340,2,'Righteous Fury - Tank Class Passive Threat'),
(26022,61417,2,'Pursuit of Justice add'),
(26023,61418,2,'Pursuit of Justice add'),
(26286,44430,0,'Small Red Rocket - questcredit'),
(26291,44430,0,'Small Blue Rocket - questcredit'),
(26292,44430,0,'Small Green Rocket - questcredit'),
(26304,44429,0,'Blue Firework Cluster - questcredit'),
(26325,44429,0,'Green Firework Cluster - questcredit'),
(26327,44429,0,'Red Firework Cluster - questcredit'),
(26373,26448,0,'Lunar Festival Invitation - Teleport Moonglade'),
(26393,26394,1,'Elune\'s Blessing'),
(27272,54501,2,'Consume Shadows - Rank 7'),
(27799,27803,0,'Holy Nova (rank4)'),
(27800,27804,0,'Holy Nova (rank5)'),
(27801,27805,0,'Holy Nova (rank6)'),
(28059,-28084,1,'Positive Charge - Negative Charge'),
(28084,-28059,1,'Negative Charge - Positive Charge'),
(28273,-28274,0,'Bloodthistle'),
(28732,-28798,1,'Widow\'s Embrace - Frenzy'),
(29126,29099,1,'Flame of Darnassus'),
(29135,29102,1,'Flame of Ironforge'),
(29136,29130,1,'Flame of Orgrimmar'),
(29137,29101,1,'Flame of Stormwind'),
(29138,29132,1,'Flame of Thunder Bluff'),
(29139,29133,1,'Flame of Undercity'),
(30658,30571,1,'Magtheridon - Quake Trigger'),
(30843,41624,0,'Prince Enfeelble'),
(31286,6608,1,'Lash: Cast \'Dropped Weapon\' (6608) on hit on the same target'),
(31606,38776,1,'As the Crow Flies quest'),
(32096,32172,2,'Thrallmar\'s Favor'),
(32098,32172,2,'Honor Hold\'s Favor'),
(32386,60448,2,'Shadow Embrace Rank1'),
(32388,60465,2,'Shadow Embrace Rank2'),
(32389,60466,2,'Shadow Embrace Rank3'),
(32390,60467,2,'Shadow Embrace Rank4'),
(32391,60468,2,'Shadow Embrace Rank5'),
(33206,44416,2,'Pain Suppression (threat)'),
(33337,-33336,1,'Memory Wipe'),
(33686,31705,0,'Murmur\'s Shockwave Jump'),
(34767,31726,0,'Summon Charger - Blood Elf'),
(34769,31726,0,'Summon Warhorse - Blood Elf'),
(36574,36650,0,'Apply Phase Slip Vulnerability'),
(36587,36573,1,'Vision Guide quest'),
(37493,31261,2,'Feign Death'),
(37896,37897,1,'X-52 Rocket Helmet - Trigger Parachute'),
(37908,24831,0,'Aura Visual Teleport - teleport'),
(38002,38003,0,'Charm Deathforged Infernal'),
(38120,38003,0,'Charm Deathforged Infernal'),
(38122,38003,0,'Charm Deathforged Infernal'),
(38125,38003,0,'Charm Deathforged Infernal'),
(38127,38003,0,'Charm Deathforged Infernal'),
(38129,38003,0,'Charm Deathforged Infernal'),
(38358,38353,1,'Tidal Surge - Karathress - Serpentshrine Cavern'),
(38650,38651,1,'Rancid Mushroom (Serpentshrine Cavern)'),
(39088,-39091,1,'Positive Charge - Negative Charge'),
(39091,-39088,1,'Negative Charge - Positive Charge'),
(39835,39968,1,'Needle Spine'),
(39908,40017,2,'Illidan Stormrage - Eye blast'),
(39977,-39837,1,'Remove Impaling Spine'),
(40214,40216,2,'Dragonmaw Illusion'),
(40214,42016,2,'Dragonmaw Illusion'),
(40527,40528,0,'Imp In a Bottle'),
(40604,40616,1,'Fel Rage Aura'),
(40616,41625,1,'Fel Rage Aura'),
(41099,-41107,2,'Battle Stance - Remove Berserker Stance'),
(41099,-41100,2,'Battle Stance - Remove Berserker Stance'),
(41100,-41105,2,'Berserker Stance - Remove Defensive Stance'),
(41100,-41101,2,'Berserker Stance - Remove Defensive Stance'),
(41101,-41106,2,'Defensive Stance - Remove Battle Stance'),
(41101,-41099,2,'Defensive Stance - Remove Battle Stance'),
(41621,52656,2,'Stun if Wolpertinger net aura'),
(41621,63726,2,'Pacify if Wolpertinger net aura'),
(41999,-40251,2,'Remove Shadow of Death'),
(42013,45537,0,'Visual Channel'),
(42166,43401,1,'Mindless abomination explosion, trigger blood'),
(42254,51655,0,'BOTM - Create Empty Brew Bottle'),
(42255,51655,0,'BOTM - Create Empty Brew Bottle'),
(42256,51655,0,'BOTM - Create Empty Brew Bottle'),
(42257,51655,0,'BOTM - Create Empty Brew Bottle'),
(42258,51655,0,'BOTM - Create Empty Brew Bottle'),
(42259,51655,0,'BOTM - Create Empty Brew Bottle'),
(42260,51655,0,'BOTM - Create Empty Brew Bottle'),
(42261,51655,0,'BOTM - Create Empty Brew Bottle'),
(42263,51655,0,'BOTM - Create Empty Brew Bottle'),
(42264,51655,0,'BOTM - Create Empty Brew Bottle'),
(42292,72752,0,'Will of the Forsaken Cooldown Trigger'),
(42578,42576,0,'Theramore Cannon blast'),
(42674,42299,1,'Dark Iron knockback aura'),
(42825,24754,1,'Cannon Prep - Link Stun'),
(42825,42826,1,'Cannon Prep - Link Teleport'),
(42965,42919,0,'Hallows End - Tricky Treat'),
(42966,-42965,0,'Hallows End - Upset Tummy removes Tricky Treat'),
(42966,-42919,0,'Hallows End - Upset Tummy removes Tricky Treat'),
(42992,-42994,0,'Trot removes Gallop'),
(42992,-42993,0,'Trot removes Canter'),
(42993,-42994,0,'Canter removes Gallop'),
(42993,-42992,0,'Canter removes Trot'),
(42994,-42993,0,'Gallop removes Canter'),
(42994,-42992,0,'Gallop removes Trot'),
(43315,46348,2,'On aura Vrykul Insult apply Slow Creature'),
(43332,-42994,0,'Exhausted removes Gallop'),
(43332,-42993,0,'Exhausted removes Canter'),
(43332,-42992,0,'Exhausted removes Trot'),
(43369,68347,0,'Worg Disguise'),
(43392,42168,0,'Mindless abomination control'),
(43648,44007,1,'Storm Eye Safe Zone'),
(43658,43653,0,'Electrical Arc Visual'),
(43658,43654,0,'Electrical Arc Visual'),
(43658,43655,0,'Electrical Arc Visual'),
(43658,43656,0,'Electrical Arc Visual'),
(43658,43659,0,'Electrical Arc Visual'),
(43770,43789,1,'Trigger grip beam'),
(43959,51655,0,'BOTM - Create Empty Brew Bottle'),
(43961,51655,0,'BOTM - Create Empty Brew Bottle'),
(44007,-43657,2,'Storm Eye Safe Zone Immune'),
(44008,45265,1,'Static Disruption Visual'),
(44608,44626,0,'Rocket Jump'),
(44948,57931,1,'Blast the Gateway quest'),
(45458,45437,1,'Holiday - Midsummer, Stamp Out Bonfire, Quest Complete triggers Stamp Out Bonfire'),
(45661,45665,1,'Encapsulate'),
(45717,45726,1,'Fog of Corruption - Charm'),
(45750,45749,0,'Land Mine Barrier'),
(45750,45751,0,'Land Mine Barrier'),
(45750,45752,0,'Land Mine Barrier'),
(45750,45753,0,'Land Mine Barrier'),
(45750,45754,0,'Land Mine Barrier'),
(45750,45755,0,'Land Mine Barrier'),
(45750,45756,0,'Land Mine Barrier'),
(45750,47839,0,'Land Mine Barrier'),
(45923,45922,1,'Shadow Prison Add'),
(45950,-45922,1,'Shadow Prison Remove'),
(45958,45956,1,'Signal Alliance'),
(45980,46022,0,'Re-Cursive quest'),
(46019,46021,1,'Trigger Spectral Realm'),
(46228,-46247,0,'Black Hole Visual (Grown)'),
(46228,46235,0,'Black Hole Visual (Grown)'),
(46242,46247,0,'Black Hole Visual (Birth)'),
(46262,46265,0,'Void Zone Visual'),
(46609,46610,1,'Freeze (Madrigosa barrier'),
(46671,46690,1,'Flame of Exodar'),
(46672,46689,1,'Flame of Silvermoon'),
(46770,47972,1,'Liquid Fire of Elune'),
(47190,47189,1,'Toalu\'u\'s Spiritual Incense'),
(47311,47309,0,'Quest - Jormungar Explosion Spell Spawner triggers Quest - Jormungar Explosion Summon Object'),
(47311,47924,0,'Quest - Jormungar Explosion Spell Spawner triggers Quest - Jormungar Explosion Summon Object'),
(47311,47925,0,'Quest - Jormungar Explosion Spell Spawner triggers Quest - Jormungar Explosion Summon Object'),
(47435,-47447,1,'Messy Business - Remove Spit'),
(47585,60069,2,'Dispersion (transform/regen)'),
(47585,63230,2,'Dispersion (immunity)'),
(47962,47967,0,'Rescue Soldier Credit'),
(47987,54501,2,'Consume Shadows - Rank 8'),
(47988,54501,2,'Consume Shadows - Rank 9'),
(48077,48075,0,'Holy Nova (rank8)'),
(48078,48076,0,'Holy Nova (rank9)'),
(48143,48814,2,'Forgottens aura'),
(48263,57340,2,'Frost Presence - Tank Class Passive Threat'),
(48268,48272,0,'Let Them Not Rise!: Summon Rat'),
(48384,50170,2,'Improved Moonkin Form'),
(48395,50171,2,'Improved Moonkin Form'),
(48396,50172,2,'Improved Moonkin Form'),
(48397,-43671,0,'remove npc'),
(48750,48770,2,'Serinar\'s Vision is applied while aura Burning Depths Necrolyte Image is active'),
(48778,50772,0,'Acherus Deathcharger - Summon Unholy Mount Visual'),
(48810,48809,0,'Cast Binding Life when cast Death\'s Door'),
(49039,50397,2,'Lichborne - shapeshift'),
(49266,49282,1,'Ride Highland Mustang'),
(49870,49869,1,'Slimed! - trigger Nauseous'),
(49962,50010,0,'BOTM - Jungle Brew - Jungle Madness Vision Effect'),
(50141,50001,0,'Blood Oath to Blood Oath Aura'),
(50317,50314,0,'Disco Ball'),
(50317,50487,0,'Disco Ball'),
(50334,58923,2,'Berserk - modify target number aura'),
(50440,50446,1,'On Envision Drakuru - Spellcast Summon Drakuru'),
(50493,50314,0,'Disco Ball(Listening to Music)'),
(50499,50493,1,'D.I.S.C.O.'),
(50517,-51926,0,'Corsair Costume - Remover'),
(50709,-50665,1,'Strip Aura Jonathan 01 remove aura Bleeding Out'),
(50710,-50666,1,'Strip Aura Jonathan remove aura Jonathan Dying from player'),
(50711,-50695,1,'Strip Aura Josephine 01 remove aura Bleeding Out'),
(50712,-50693,1,'Strip Aura Josephine remove aura Josephine Dying from player'),
(50722,-50679,1,'Strip Aura Lamoof remove aura Lamoof Dying from player'),
(50723,-50681,1,'Strip Aura Lamoof 01 remove aura Bleeding Out'),
(51010,-5268,0,'Dire Brew'),
(51010,5268,2,'Dire Brew'),
(51060,51226,1,'On spellhit Have Withered Batwing - Spellcast Withered Batwing Kill Credit'),
(51068,51227,1,'On spellhit Have Muddy Mire Maggot - Spellcast Muddy Mire Maggot Kill Credit'),
(51088,51228,1,'On spellhit Have Amberseed - Spellcast Amberseed Kill Credit'),
(51094,51229,1,'On spellhit Have Chilled Serpent Mucus - Spellcast Chilled Serpent Mucus Kill Credit'),
(51209,55095,1,'Hungering cold - frost fever'),
(51515,51506,1,'Clear patrol quests - trigger clear spell'),
(51515,51509,1,'Clear patrol quests - trigger clear spell'),
(51573,53712,1,'On patrol - trigger clear spell'),
(51573,53713,1,'On patrol - trigger clear spell'),
(51573,53715,1,'On patrol - trigger clear spell'),
(51573,53716,1,'On patrol - trigger clear spell'),
(51671,51717,1,'On Ghostly - Spellcast Altar of Quetz\'lun: Summon Material You'),
(51690,61851,2,'Rogue - Killing Spree'),
(51723,52874,0,'Fan Of Knives'),
(52089,52091,1,'Teleport'),
(52214,51407,2,'Looking for treasure aura triggered by Rainspeaker Treasures: See Invisibility'),
(52279,45254,1,'On spellhit Tua-Tua on Burn - Spellcast Suicide'),
(52303,45254,1,'On spellhit Hawinni on Frozen - Spellcast Suicide'),
(52322,52325,1,'Explode Scourgewagon'),
(52322,52329,1,'Explode Scourgewagon'),
(52322,52330,1,'Explode Scourgewagon'),
(52322,52332,1,'Explode Scourgewagon'),
(52410,-52418,0,'Carrying Seaforium - Remove'),
(52415,52418,0,'Carrying Seaforium - Add'),
(52565,52575,1,'Trigger Troll Explosion with FFTF explosion'),
(52578,52580,1,'Trigger Meat Explosion with Bloody Meat Explosion'),
(52610,62071,0,'Savage Roar'),
(52676,52677,1,'Teleport'),
(52860,45254,1,'On spellhit Rampage: Drain Power Effect - Spellcast Suicide'),
(52989,-53504,1,'On spellhit Akali\'s Stun - Remove aura Flickering Flames'),
(53095,-53094,2,'Infected Worgen Bite - Worgen\'s Call Immunity'),
(53288,53289,1,'Flight - Onequah to Light\'s Breach trigger Flight - Onequah to Light\'s Breach'),
(53311,53310,1,'Flight - Westfall to Light\'s Breach trigger Flight - Westfall to Light\'s Breach'),
(53355,-53371,1,'Freeze fix'),
(53371,-53355,1,'Freeze fix'),
(53563,53651,2,'Beacon of Light'),
(54097,-54100,1,'Widow\'s Embrace - Frenzy (H)'),
(54581,54623,0,'Mammoth Explosion Spell Spawner link to Quest - Mammoth Explosion Summon Object'),
(54581,54627,0,'Mammoth Explosion Spell Spawner link to Quest - Mammoth Explosion Summon Object'),
(54581,54628,0,'Mammoth Explosion Spell Spawner link to Quest - Mammoth Explosion Summon Object'),
(54581,57444,0,'Mammoth Explosion Spell Spawner link to Summon Main Mammoth Meat'),
(54640,54643,0,'WG teleporter'),
(54643,-54643,2,'Wintergrasp Defender Teleport'),
(54861,-34976,0,'Drop Flag on Nitro Boost EOS'),
(54861,-23335,0,'Drop Flag on Nitro Boost WSG'),
(54861,-23333,0,'Drop Flag on Nitro Boost WSG'),
(55004,-34976,0,'Drop Flag on Nitro Boost EOS'),
(55004,-23335,0,'Drop Flag on Nitro Boost WSG'),
(55004,-23333,0,'Drop Flag on Nitro Boost WSG'),
(55428,55475,0,'Lifeblood (Rank 1)'),
(55480,55475,0,'Lifeblood (Rank 2)'),
(55500,55475,0,'Lifeblood (Rank 3)'),
(55501,55475,0,'Lifeblood (Rank 4)'),
(55502,55475,0,'Lifeblood (Rank 5)'),
(55503,55475,0,'Lifeblood (Rank 6)'),
(55814,55817,1,'Trigger Eck Residue for achievement'),
(56397,63934,1,'Arcane Barrage - Arcane Barrage'),
(56418,-56422,0,'remove submerge on cast'),
(56453,67544,0,'Lock and Load Marker'),
(56648,-57055,1,'Remove Mini with Potent Fungus'),
(56683,-56726,1,'remove web on rescue spell hit'),
(56684,-56687,0,'remove passenger on spell cast'),
(56752,-32951,1,'Wake Snorri removes Sleeping Sleep'),
(56753,-56750,0,'remove snowball aura on cast'),
(57294,59690,2,'Well Fed - Well Fed (DND)'),
(57387,57608,0,'Argent Cannon - Powering Up The Core'),
(57399,59699,2,'Well Fed - Well Fed (DND)'),
(57469,7448,1,'Spread Fire triggers Fire'),
(57620,-57935,0,'Twilight Shift aura removes Twilight Torment'),
(57635,57636,0,'Disengage'),
(57787,-57745,1,'Remove See Quest Invisibility 1 When hit by quest chain end spell'),
(57852,57931,1,'link fire on hit'),
(57889,57885,0,'On spellcast Using the Eye of the Lich King cast Through the Eye: Summon Image of a Shadow Cultist'),
(57889,57891,0,'On spellcast Using the Eye of the Lich King cast Through the Eye: Summon Image of Vardmadra'),
(57908,57915,0,'q13129 - Give quest item'),
(58509,58511,0,'Rotten Apple - Rotten Apple'),
(58513,58514,0,'Rotten Banana - Rotten Banana'),
(58520,58519,0,'Spit - Spit'),
(58666,58672,1,'Impale (Archavon)'),
(58875,58876,1,'Spirit Walk'),
(58984,59646,0,'Shadowmeld: Sanctuary'),
(58984,62196,0,'Shadowmeld: Force deselect'),
(59628,-57934,0,'Tricks of Trade - remove at trigger'),
(59752,72752,0,'Will of the Forsaken Cooldown Trigger'),
(60882,58672,1,'Impale (Archavon)'),
(60932,60934,0,'Disengage'),
(61031,61551,0,'Toy Train Set'),
(61187,-57620,1,'Twilight Phase Shift normal remove'),
(61263,61267,0,'Intravenous Healing Effect'),
(61263,61268,0,'Intravenous Mana Regeneration Effect'),
(61507,61508,0,'Disengage'),
(61611,61612,1,'Summon body when going to other side'),
(61613,-61611,1,'Ganjo\'s Resurrection removes On The Other Side'),
(61716,61719,2,'Rabbit Costume: Lay Egg periodic'),
(61734,61719,2,'Noblegarden Bunny: Lay Egg periodic'),
(61846,61848,2,'Aspect of the dragonhawk'),
(61847,61848,2,'Aspect of the dragonhawk'),
(61968,62148,0,'Hodir - Flash Freeze'),
(62042,62470,1,'Thorim - Stormhammer'),
(62061,25860,0,'Festive Holiday Mount'),
(62068,43307,1,''),
(62168,62169,1,'Black Hole (Algalon)'),
(62217,-62243,1,'Remove unstable sun beam'),
(62427,62340,2,'Load into Catapult - Passenger Loaded'),
(62490,62474,0,'Remove pyrite'),
(62922,-62243,1,'Remove unstable sun beam'),
(63277,65269,2,'General Vezax - Shadow Crash'),
(63993,-63988,1,'Cancel Illusion Room Aura - remove aura'),
(63993,63992,1,'Cancel Illusion Room Aura - teleport back'),
(64382,64380,0,'Shattering Throw'),
(64417,62169,1,'Phase Punch (Algalon)'),
(65044,-62297,1,'Flames remove ice'),
(65045,-62297,1,'Flames remove ice'),
(65250,62169,1,'Worm Hole (Algalon)'),
(65684,-65686,2,'Remove Light Essence 10M'),
(65686,-65684,2,'Remove Dark Essence 10M'),
(65940,65941,0,'Trial of the Crusader: Shattering Throw'),
(66010,25771,0,'Divine Shield - Forbearance'),
(66235,66233,0,'Ardent Defender Visuals'),
(66512,66510,0,'Summon Deep Jormungar on Pound Drum'),
(66623,66624,2,'Bountiful Basket Bonus Aura'),
(66680,66547,0,'Confess - Confess'),
(66870,-66823,1,'Burning Bile remove Paralytic Toxin'),
(66899,-66656,0,'On cast 66899 (Gunship Portal Click (to Hangar)) - Remove 66656 (Parachute)'),
(66901,66823,1,'Paralytic Spray apply Paralytic Toxin'),
(66902,66869,1,'Burning Spray apply Burning Bile'),
(66905,-66904,0,''),
(67176,-67222,2,'Remove Light essence 10M H'),
(67177,-67223,2,'Remove Light essence 25M'),
(67178,-67224,2,'Remove Light essence 25M H'),
(67222,-67176,2,'Remove Dark essence 10M H'),
(67223,-67177,2,'Remove Dark essence 25M'),
(67224,-67178,2,'Remove Dark essence 25M H'),
(67615,67618,1,'Paralytic Spray apply Paralytic Toxin'),
(67616,67619,1,'Paralytic Spray apply Paralytic Toxin'),
(67617,67620,1,'Paralytic Spray apply Paralytic Toxin'),
(67621,-67618,1,'Burning Bile remove Paralytic Toxin'),
(67622,-67619,1,'Burning Bile remove Paralytic Toxin'),
(67623,-67620,1,'Burning Bile remove Paralytic Toxin'),
(67627,66869,1,'Burning Spray apply Burning Bile'),
(67628,66869,1,'Burning Spray apply Burning Bile'),
(67629,66869,1,'Burning Spray apply Burning Bile'),
(68529,-68530,0,'Perfume Immune - Cologne remove'),
(68530,-68529,0,'Cologne Immune - Perfume remove'),
(68645,68721,1,'Rocket Pack - additional aura'),
(69172,69173,0,'Overlord\'s Brand'),
(69378,72586,1,'Drums of the Forgotten Kings'),
(69381,72588,1,'Drums of the Wild'),
(70192,-71507,1,'Remove Heavily Perfumed on Fragrant Air Analysis hit'),
(70192,71508,1,'Add Recently Analyzed on Fragrant Air Analysis hit'),
(70227,70232,1,'Empowered Blood Second Aura'),
(70590,70595,1,'The Sacred and the Corrupt'),
(70653,-70583,1,'The Sacred and the Corrupt'),
(70867,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(70877,72151,2,'Blood-Queen: Frenzied Bloodthirst 10man'),
(70877,72649,2,'Blood-Queen: Frenzied Bloodthirst 10man'),
(70879,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(70923,70924,1,'Blood-Queen: Uncontrollable Frenzy damage buff'),
(71265,71277,2,'Blood Queen Lana\'thel - Swarming Shadows'),
(71446,71447,1,'Blood-Queen: Bloodbolt Splash'),
(71473,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71474,72648,2,'Blood-Queen: Frenzied Bloodthirst 25man'),
(71474,72650,2,'Blood-Queen: Frenzied Bloodthirst 25man'),
(71478,71481,1,'Blood-Queen: Bloodbolt Splash'),
(71479,71482,1,'Blood-Queen: Bloodbolt Splash'),
(71480,71483,1,'Blood-Queen: Bloodbolt Splash'),
(71522,-71450,1,'Remove Crown Parcel Service Uniform on Crown Chemical Co. Supplies hit'),
(71525,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71530,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71531,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71532,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71533,70871,2,'Blood-Queen: Essence of the Blood Queen'),
(71539,-71450,1,'Remove Crown Parcel Service Uniform on Crown Chemical Co. Supplies hit'),
(71620,-71618,1,'Putricide - Tear Gas Cancel'),
(71620,-71615,1,'Putricide - Tear Gas Cancel'),
(71818,71447,1,'Blood-Queen: Bloodbolt Splash'),
(71819,71481,1,'Blood-Queen: Bloodbolt Splash'),
(71820,71482,1,'Blood-Queen: Bloodbolt Splash'),
(71821,71483,1,'Blood-Queen: Bloodbolt Splash'),
(71847,71874,0,'Toxic Wasteling Devour'),
(73077,69188,2,'Rocket Pack - linked aura'),
(73313,50772,0,'Crimson Deathcharger - Summon Unholy Mount Visual'),
(74890,75055,1,'Instant Statue Pedestal');
/*!40000 ALTER TABLE `spell_linked_spell` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

