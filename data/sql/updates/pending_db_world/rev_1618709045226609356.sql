INSERT INTO `version_db_world` (`sql_rev`)
VALUES ('1618709045226609356');

# Delete current loot reference loot templates for Broken Tooth
DELETE
FROM `creature_loot_template`
WHERE Comment LIKE '%Broken Tooth - (ReferenceTable%';

DELETE
FROM `reference_loot_template`
WHERE reference_loot_template.Entry IN
      (24016,
       24036,
       24037,
       24038,
       24039,
       24040,
       24041,
       24042,
       24047,
       24048,
       24049,
       24050,
       24051,
       24052,
       24053,
       24054,
       24055,
       24056,
       24057,
       24058,
       24059,
       24060,
       24061,
       24062,
       24063,
       24064,
       24065,
       24066,
       24067,
       24068,
       24069,
       24078);

# Delete the junk Broken Tooth currently drops like Melon Juice
DELETE
FROM `creature_loot_template`
WHERE ENTRY = 2850
  AND Item NOT IN (1688, 4580, 8146);


# Update chance for Long Soft Tail
UPDATE `creature_loot_template` SET Chance = 19 WHERE Entry = 2850 AND Item = 1688;

# Update chance for Sabertooth Fang
UPDATE `creature_loot_template` SET Chance = 11 WHERE Entry = 2850 AND Item = 4580;

# Add Thick Leather to Broken Tooth loot table
INSERT INTO `creature_loot_template`
VALUES (2850, 4304, 0, 3, 0, 1, 0, 1, 1, 'Broken Tooth - Thick Leather');

# Add a guaranteed green to drop
INSERT INTO creature_loot_template
VALUES (2850, 7493, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Captain''s Bracers'),
       (2850, 7492, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Captain''s Cloak'),
       (2850, 9885, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Boots'),
       (2850, 7461, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Bracers'),
       (2850, 7483, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Ranger Cloak'),
       (2850, 7474, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Regal Cloak'),
       (2850, 7476, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Regal Sash'),
       (2850, 7441, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Cap'),
       (2850, 7448, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Girdle'),
       (2850, 9879, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Bracelets'),
       (2850, 9876, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Slippers'),
       (2850, 7435, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Mantle'),
       (2850, 7430, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Robe'),
       (2850, 9848, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Gloves'),
       (2850, 9850, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Mantle'),
       (2850, 9890, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Cape'),
       (2850, 7459, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Pauldrons'),
       (2850, 9864, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Boots'),
       (2850, 9871, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Leggings'),
       (2850, 9875, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Sash'),
       (2850, 9856, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Boots'),
       (2850, 9852, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Robe'),
       (2850, 7447, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Bracers'),
       (2850, 9877, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Cloak'),
       (2850, 7434, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Boots'),
       (2850, 9849, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Hood'),
       (2850, 9844, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Vest'),
       (2850, 9886, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Bands'),
       (2850, 7454, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Breastplate'),
       (2850, 9870, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Circlet'),
       (2850, 7438, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Belt'),
       (2850, 7433, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Gloves'),
       (2850, 7431, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Pants'),
       (2850, 7455, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Legguards'),
       (2850, 7443, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Gloves'),
       (2850, 9862, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Trousers'),
       (2850, 7462, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Girdle'),
       (2850, 9872, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Pauldrons'),
       (2850, 9880, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Gloves'),
       (2850, 7437, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Cuffs'),
       (2850, 9851, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Breeches'),
       (2850, 7458, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Boots'),
       (2850, 7444, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Boots'),
       (2850, 7432, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Cowl'),
       (2850, 9863, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Shoulderpads'),
       (2850, 7457, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Gauntlets'),
       (2850, 9866, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Chestguard'),
       (2850, 9896, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Jazeraint Bracers'),
       (2850, 7446, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Cloak'),
       (2850, 7445, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Shoulders');
