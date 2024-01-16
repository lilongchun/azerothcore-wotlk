--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (19551, 20031, 20032, 20033, 20034, 20035, 20036, 20037, 20038, 20039, 20040, 20041, 20042, 20043, 20044, 20046, 20047, 20048, 20049, 20050, 20052, 20060, 20062, 20063, 20064, 21268, 21269, 21270, 21272, 21274, 21362);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19551, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 35177, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - Just Summoned - Cast Birth Dummy Cast'),
(19551, 0, 1, 0, 37, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On AI Init - Set React Passive'),
(19551, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 34133, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Death - Cast Ember Blast'),
(19551, 0, 3, 4, 60, 0, 100, 512, 3000, 3000, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Update - Set React Aggressive'),
(19551, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Update - Set In Combat With Zone'),
(20031, 0, 0, 0, 0, 0, 100, 0, 9650, 25150, 19350, 27150, 0, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast \'Bloodthirst\''),
(20031, 0, 1, 0, 0, 0, 100, 0, 7200, 21000, 1200, 32300, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast \'Cleave\''),
(20031, 0, 2, 0, 0, 0, 100, 0, 5850, 13950, 16950, 25450, 0, 0, 11, 33500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast \'Whirlwind\''),
(20031, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2003500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - On Data Set 1 1 - Run Script'),
(20032, 0, 0, 0, 15, 0, 100, 0, 30, 5000, 10000, 0, 0, 0, 11, 39078, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - On Friendly Crowd Controlled - Cast \'Cleanse\''),
(20032, 0, 1, 0, 0, 0, 100, 0, 7250, 9650, 8450, 21450, 0, 0, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - In Combat - Cast \'Hammer of Justice\''),
(20032, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 0, 0, 11, 37251, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - Target Between 0-20% Health - Cast \'Hammer of Wrath\''),
(20032, 0, 3, 0, 74, 0, 100, 0, 7250, 7250, 8450, 21450, 20, 40, 11, 37249, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - On Friendly Below 20% Health - Cast \'Flash of Light\''),
(20032, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2003500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - On Data Set 1 1 - Run Script'),
(20033, 0, 0, 0, 23, 0, 100, 0, 35915, 0, 3600, 3600, 0, 0, 11, 35915, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - On Aura \'Molten Armor\' - Cast \'Molten Armor\''),
(20033, 0, 1, 0, 0, 0, 100, 0, 6050, 15750, 13350, 26150, 0, 0, 11, 37109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - In Combat - Cast \'Fireball Volley\''),
(20033, 0, 2, 0, 0, 0, 100, 0, 12100, 24800, 13300, 27300, 0, 0, 11, 37110, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - In Combat - Cast \'Fire Blast\''),
(20033, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2003500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - On Data Set 1 1 - Run Script'),
(20034, 0, 0, 0, 0, 0, 100, 0, 10900, 20600, 10900, 23800, 0, 0, 11, 37126, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Star Scryer - In Combat - Cast \'Arcane Blast\''),
(20034, 0, 1, 0, 0, 0, 100, 0, 7250, 13350, 23000, 33100, 0, 0, 11, 37124, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Star Scryer - In Combat - Cast \'Starfall\''),
(20034, 0, 2, 0, 0, 0, 100, 0, 9700, 19800, 10900, 23800, 0, 0, 11, 37122, 32, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 0, 'Star Scryer - In Combat - Cast \'Domination\''),
(20034, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2003500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Star Scryer - On Data Set 1 1 - Run Script'),
(20035, 0, 0, 0, 0, 0, 100, 0, 9650, 19750, 16950, 36350, 0, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast \'Bloodthirst\''),
(20035, 0, 1, 0, 0, 0, 100, 0, 22750, 33950, 19400, 32300, 0, 0, 11, 34996, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast \'Uppercut\''),
(20035, 0, 2, 0, 0, 0, 100, 0, 8300, 17500, 18200, 25400, 0, 0, 11, 36132, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast \'Whirlwind\''),
(20036, 0, 0, 0, 15, 0, 100, 0, 30, 5000, 10000, 0, 0, 0, 11, 39078, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - In Combat - Cast Cleanse'),
(20036, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 15000, 20000, 0, 0, 11, 39077, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - In Combat - Cast Hammer of Justice'),
(20036, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 0, 0, 11, 37255, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - Target Health Pct 0-20% - Cast Hammer of Wrath'),
(20036, 0, 3, 0, 74, 0, 100, 0, 8450, 19350, 13300, 19200, 20, 40, 11, 37254, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - On Friendly Below 20% Health - Cast Flash of Light'),
(20037, 0, 0, 0, 23, 0, 100, 0, 37318, 0, 3600, 3600, 0, 0, 11, 37318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - On Aura \'Fire Shield\' - Cast \'Fire Shield\''),
(20037, 0, 1, 0, 9, 0, 100, 0, 950, 4250, 3600, 6500, 0, 45, 11, 39079, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - Within 0-45 Range - Cast \'Shoot\''),
(20037, 0, 2, 0, 0, 0, 100, 0, 7000, 24800, 14550, 24250, 0, 0, 11, 37154, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - In Combat - Cast \'Immolation Arrow\''),
(20037, 0, 3, 0, 9, 0, 100, 0, 6000, 11000, 15000, 19000, 0, 8, 11, 37317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - Within 0-8 Range - Cast \'Knockback\''),
(20038, 0, 0, 0, 0, 0, 100, 0, 8200, 14400, 20650, 30250, 0, 0, 11, 37160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk Hatchling - In Combat - Cast Silence'),
(20038, 0, 1, 0, 0, 0, 100, 0, 6050, 11650, 18200, 25500, 0, 0, 11, 37319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk Hatchling - In Combat - Cast Wing Buffet'),
(20039, 0, 0, 0, 9, 0, 100, 0, 0, 0, 10000, 10000, 5, 40, 11, 37156, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk - Within Range 5-40yd - Cast Dive'),
(20039, 0, 1, 0, 0, 0, 100, 0, 6450, 9150, 16950, 29050, 0, 0, 11, 37159, 256, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk - In Combat - Cast Mana Burn'),
(20040, 0, 0, 0, 0, 0, 100, 0, 20950, 42450, 17000, 29900, 0, 0, 11, 37102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast Knock Away'),
(20040, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 15000, 18000, 0, 0, 11, 35035, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast Countercharge'),
(20040, 0, 2, 0, 105, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 50, 11, 35039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Victim Casting - Cast Countercharge'),
(20040, 0, 3, 4, 8, 0, 100, 512, 34946, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spell Hit - Store Target'),
(20040, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2004000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spell Hit - Start Script'),
(20041, 0, 0, 0, 0, 0, 100, 0, 23850, 29650, 25500, 34500, 0, 0, 11, 37106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - In Combat - Cast Charged Arcane Explosion'),
(20041, 0, 1, 0, 0, 0, 100, 0, 15700, 23800, 15700, 25400, 0, 0, 11, 37104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - In Combat - Cast Overcharge'),
(20041, 0, 2, 3, 8, 0, 100, 512, 34946, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - On Spell Hit - Store Target'),
(20041, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2004100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - On Spell Hit - Start Script'),
(20042, 0, 0, 0, 0, 0, 100, 0, 2000, 21400, 2400, 15300, 0, 0, 11, 37120, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Fragmentation Bomb'),
(20042, 0, 1, 0, 0, 0, 100, 0, 9250, 11750, 8450, 17950, 0, 0, 11, 37118, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Shell Shock'),
(20042, 0, 2, 0, 0, 0, 100, 0, 27500, 57400, 15750, 48950, 0, 0, 11, 37112, 0, 0, 0, 0, 0, 19, 20041, 40, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Power Up'),
(20042, 0, 3, 0, 0, 0, 100, 0, 11000, 11000, 24000, 24000, 0, 0, 11, 37112, 0, 0, 0, 0, 0, 19, 20040, 40, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Power Up'),
(20043, 0, 0, 0, 0, 0, 100, 0, 13350, 24350, 18150, 20650, 0, 0, 11, 37133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Buffet'),
(20043, 0, 1, 0, 0, 0, 100, 0, 12100, 15900, 15750, 19850, 0, 0, 11, 37132, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Shock'),
(20043, 0, 2, 0, 0, 0, 100, 0, 5650, 12850, 10900, 25500, 0, 0, 11, 38725, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Explosion'),
(20043, 0, 3, 0, 0, 0, 100, 0, 5650, 11350, 13300, 23000, 0, 0, 11, 37129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Volley'),
(20044, 0, 0, 0, 0, 0, 100, 0, 4850, 13950, 7250, 16350, 0, 0, 11, 37111, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fireball'),
(20044, 0, 1, 0, 0, 0, 100, 0, 8050, 9050, 10900, 20600, 0, 0, 11, 37279, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Rain of Fire'),
(20044, 0, 2, 0, 0, 0, 100, 0, 10450, 33150, 14500, 27500, 0, 0, 11, 38728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fire Nova'),
(20044, 0, 3, 0, 0, 0, 100, 1, 1200, 3800, 0, 0, 0, 0, 11, 37282, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fire Shield'),
(20046, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5500, 7500, 0, 0, 11, 37110, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Blast'),
(20046, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 17000, 0, 0, 11, 37289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Dragons Breath'),
(20046, 0, 2, 0, 0, 0, 100, 0, 15000, 16000, 15000, 24000, 0, 0, 11, 37109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Volley'),
(20046, 0, 3, 0, 0, 0, 100, 1, 0, 1000, 0, 0, 0, 0, 11, 38732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Shield'),
(20047, 0, 0, 0, 0, 0, 100, 0, 8500, 27900, 13350, 25950, 0, 0, 11, 37263, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Battle Mage - In Combat - Cast \'Blizzard\''),
(20047, 0, 1, 0, 0, 0, 60, 0, 7250, 11750, 8450, 28750, 0, 0, 11, 37265, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Battle Mage - In Combat - Cast \'Cone of Cold\''),
(20047, 0, 2, 0, 0, 0, 100, 0, 9650, 35950, 10900, 28800, 0, 0, 11, 37262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Battle Mage - In Combat - Cast \'Frostbolt Volley\''),
(20048, 0, 0, 0, 0, 0, 100, 0, 9650, 18750, 10900, 19500, 0, 0, 11, 37268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Centurion - In Combat - Cast \'Arcane Flurry\''),
(20049, 0, 0, 0, 0, 0, 100, 0, 6050, 13250, 7300, 18200, 0, 0, 11, 39077, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - In Combat - Cast \'Hammer of Justice\''),
(20049, 0, 1, 0, 12, 0, 100, 0, 20, 20, 15000, 15000, 0, 0, 11, 37259, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - Target Between 20-20% Health - Cast \'Hammer of Wrath\''),
(20049, 0, 2, 0, 14, 0, 100, 0, 100, 30, 1200, 15200, 0, 0, 11, 37257, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - Friendly At 100 Health - Cast \'Flash of Light\''),
(20049, 0, 3, 0, 0, 0, 100, 0, 60000, 60000, 120000, 160000, 0, 0, 11, 37257, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - In Combat - Cast \'Flash of Light\''),
(20049, 0, 4, 0, 74, 0, 100, 0, 0, 0, 40000, 40000, 50, 0, 11, 37260, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - On Friendly Between 0-50% Health - Cast \'Renew\''),
(20049, 0, 5, 0, 15, 0, 100, 0, 0, 0, 15, 0, 0, 0, 11, 39078, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Blood Knight - Friendly Crowd Controlled - Cast \'Cleanse\''),
(20050, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 37274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Inquisitor - On Aggro - Cast \'Power Infusion\''),
(20050, 0, 0, 0, 0, 0, 100, 0, 20650, 36750, 24250, 44150, 0, 0, 11, 37274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Inquisitor - In Combat - Cast \'Power Infusion\''),
(20050, 0, 2, 0, 0, 0, 100, 0, 2200, 4900, 1200, 14400, 0, 0, 11, 37276, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Inquisitor - In Combat - Cast \'Mind Flay\''),
(20050, 0, 3, 0, 0, 0, 100, 0, 3650, 8350, 3650, 19950, 0, 0, 11, 37275, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Hand Inquisitor - In Combat - Cast \'Shadow Word: Pain\''),
(20052, 0, 0, 0, 0, 0, 100, 0, 800, 6200, 1200, 7200, 0, 0, 11, 37123, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - In Combat - Cast \'Saw Blade\''),
(20052, 0, 1, 0, 74, 0, 100, 0, 7000, 8000, 20000, 30000, 50, 100, 11, 37121, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - On Friendly Below 50% Health - Cast \'Recharge\''),
(20052, 0, 2, 0, 1, 0, 100, 0, 20000, 90000, 20000, 90000, 0, 0, 80, 2005200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - Out of Combat - Run Script'),
(20060, 0, 0, 0, 0, 0, 100, 0, 0, 0, 15000, 15000, 0, 0, 11, 44863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - In Combat - Cast Bellowing Roar'),
(20060, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - On Death - Talk'),
(20060, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - On Death - Cast Spell'),
(20062, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 0, 0, 11, 36971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Fireball'),
(20062, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 18500, 20500, 0, 0, 11, 37018, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Conflagration'),
(20062, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 0, 0, 11, 36970, 0, 0, 0, 0, 0, 5, 8, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Arcane Burst'),
(20062, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - On Death - Talk'),
(20062, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - On Death - Cast Spell'),
(20063, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3600, 7100, 0, 0, 11, 37036, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - In Combat - Cast Bomb'),
(20063, 0, 1, 0, 0, 0, 100, 0, 13250, 13250, 15750, 15750, 0, 0, 11, 37027, 0, 0, 0, 0, 0, 5, 100, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - In Combat - Cast Remote Toy'),
(20063, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - On Death - Talk'),
(20063, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - On Death - Cast Spell'),
(20064, 0, 0, 1, 0, 0, 100, 512, 100, 100, 10000, 10000, 0, 0, 64, 1, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Store Target'),
(20064, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Modify Threat PCT All'),
(20064, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Attack Start'),
(20064, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Talk'),
(20064, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 123, 10000000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Modify Threat'),
(20064, 0, 5, 0, 0, 0, 100, 0, 4000, 19350, 15700, 48900, 0, 0, 11, 36966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Cast Psychic Blow'),
(20064, 0, 6, 0, 0, 0, 100, 0, 3000, 6050, 3600, 15200, 0, 0, 11, 36965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Cast Rend'),
(20064, 0, 7, 0, 13, 0, 100, 0, 14500, 14500, 0, 0, 0, 0, 11, 30225, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - Victim Casting - Cast Silence'),
(20064, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Death - Talk'),
(20064, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Death - Cast Spell'),
(20064, 0, 10, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Reset - Set Run false'),
(21268, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 0, 0, 11, 36980, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Shot'),
(21268, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 0, 0, 11, 36979, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Multi-Shot'),
(21269, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 0, 0, 11, 36981, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Devastation - In Combat - Cast Whirlwind'),
(21270, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 9000, 0, 0, 11, 36985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - In Combat - Cast Holy Nova'),
(21270, 0, 1, 0, 14, 0, 100, 0, 30000, 40, 10000, 10000, 0, 0, 11, 36983, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - Friendly Missing HP - Cast Heal'),
(21272, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 6000, 8000, 0, 0, 11, 36991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warp Slicer - In Combat - Cast Rend'),
(21274, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2200, 2200, 0, 0, 11, 36990, 64, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Bolt'),
(21274, 0, 1, 0, 106, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 10, 11, 36989, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Nova'),
(21362, 0, 1, 0, 37, 0, 100, 769, 0, 0, 0, 0, 0, 0, 80, 2136200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - AI Init - Script9'),
(21362, 0, 2, 3, 2, 0, 100, 0, 0, 0, 18000, 18000, 0, 0, 11, 34341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Cast Ember Blast'),
(21362, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 21364, 6, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Summon Creature'),
(21362, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Set React State'),
(21362, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Move To Point'),
(21362, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 33685510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Set Unit Flags'),
(21362, 0, 7, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 80, 2136201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Data Set - Script9');
