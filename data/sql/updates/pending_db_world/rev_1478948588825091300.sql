INSERT INTO version_db_world(`sql_rev`) VALUES ('1478948588825091300');

-- Mute for player
DELETE FROM trinity_string WHERE entry = 11017;
INSERT INTO trinity_string(`entry`,`content_default`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES 
(11017, 'Speaking is allowed after playing for at least 2 hours. You may use party and guild chat.','Podrás hablar cuando hayas jugado durante al menos 2 horas. Puedes usar el chat de grupo y de hermandad.','Podrás hablar cuando hayas jugado durante al menos 2 horas. Puedes usar el chat de grupo y de hermandad','Вы сможете говорить после двух проведенных часов в игре, но можете использовать чат гильдии и группы.');
