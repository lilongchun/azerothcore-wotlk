-- DB update 2023_09_17_09 -> 2023_09_17_10
DELETE FROM `game_event_creature` WHERE `guid` IN (245648,245645,245649); 
DELETE FROM `creature` WHERE `guid` IN (245648,245645,245649);
