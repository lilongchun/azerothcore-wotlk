/*
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef DEF_KARAZHAN_H
#define DEF_KARAZHAN_H

#define DataHeader "KZ"

uint32 const EncounterCount = 12;

enum KZDataTypes
{
    DATA_ATTUMEN = 0,
    DATA_MOROES = 1,
    DATA_MAIDEN = 2,
    DATA_OPTIONAL_BOSS = 3,
    DATA_OPERA_PERFORMANCE = 4,
    DATA_CURATOR = 5,
    DATA_ARAN = 6,
    DATA_TERESTIAN = 7,
    DATA_NETHERSPITE = 8,
    DATA_CHESS = 9,
    DATA_MALCHEZZAR = 10,
    DATA_NIGHTBANE = 11,
    DATA_SERVANT_QUARTERS = 12,
    DATA_SELECTED_RARE = 13,

    DATA_OPERA_OZ_DEATHCOUNT = 14,

    DATA_KILREK = 15,
    MAX_ENCOUNTERS = 16,
    DATA_GO_CURTAINS = 18,
    DATA_GO_STAGEDOORLEFT = 19,
    DATA_GO_STAGEDOORRIGHT = 20,
    DATA_GO_LIBRARY_DOOR = 21,
    DATA_GO_MASSIVE_DOOR = 22,
    DATA_GO_NETHER_DOOR = 23,
    DATA_GO_GAME_DOOR = 24,
    DATA_GO_GAME_EXIT_DOOR = 25,

    DATA_IMAGE_OF_MEDIVH = 26,
    DATA_MASTERS_TERRACE_DOOR_1 = 27,
    DATA_MASTERS_TERRACE_DOOR_2 = 28,
    DATA_GO_SIDE_ENTRANCE_DOOR = 29,
    DATA_PRINCE = 30
};

enum KZOperaEvents
{
    EVENT_OZ = 1,
    EVENT_HOOD = 2,
    EVENT_RAJ = 3
};

enum KZMiscCreatures
{
    NPC_HYAKISS_THE_LURKER = 16179,
    NPC_ROKAD_THE_RAVAGER = 16181,
    NPC_SHADIKITH_THE_GLIDER = 16180,
    NPC_TERESTIAN_ILLHOOF = 15688,
    NPC_MOROES = 15687,
    NPC_ATTUMEN_THE_HUNTSMAN = 15550,
    NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED = 16152,
    NPC_NIGHTBANE = 17225,

    // Trash
    NPC_COLDMIST_WIDOW = 16171,
    NPC_COLDMIST_STALKER = 16170,
    NPC_SHADOWBAT = 16173,
    NPC_VAMPIRIC_SHADOWBAT = 16175,
    NPC_GREATER_SHADOWBAT = 16174,
    NPC_PHASE_HOUND = 16178,
    NPC_DREADBEAST = 16177,
    NPC_SHADOWBEAST = 16176,
    NPC_KILREK = 17229,
    NPC_RELAY = 17645,

    // Chess Event
    NPC_ECHO_MEDIVH = 16816,
    NPC_INVISIBLE_STALKER = 22519,                // placeholder for dead chess npcs
    NPC_CHESS_STATUS_BAR = 22520,                 // npc that controlls the transformation of dead pieces
    NPC_CHESS_VICTORY_CONTROLLER = 22524,
    // NPC_CHESS_SOUND_BUNNY        = 21921,      // npc that handles the encounter sounds
    // NPC_WAITING_ROOM_STALKER     = 17459,      // trigger which marks the teleport location of the players; also used to cast some control spells during the game
    NPC_SQUARE_WHITE = 17208,                     // chess white square
    NPC_SQUARE_BLACK = 17305,                     // chess black square
    // NPC_SQUARE_OUTSIDE_BLACK     = 17316,      // outside chess black square
    // NPC_SQUARE_OUTSIDE_WHITE     = 17317,      // outside chess white square

    NPC_ORC_GRUNT = 17469,                    // pawn
    NPC_ORC_WOLF = 21748,                     // knight
    NPC_ORC_WARLOCK = 21750,                  // queen
    NPC_ORC_NECROLYTE = 21747,                // bishop
    NPC_SUMMONED_DAEMON = 21726,              // rook
    NPC_WARCHIEF_BLACKHAND = 21752,           // king
    NPC_HUMAN_FOOTMAN = 17211,                // pawn
    NPC_HUMAN_CHARGER = 21664,                // knight
    NPC_HUMAN_CONJURER = 21683,               // queen
    NPC_HUMAN_CLERIC = 21682,                 // bishop
    NPC_CONJURED_WATER_ELEMENTAL = 21160,     // rook
    NPC_KING_LLANE = 21684,                   // king
};

enum KZGameObjectIds
{
    GO_STAGE_CURTAIN = 183932,
    GO_STAGE_DOOR_LEFT = 184278,
    GO_STAGE_DOOR_RIGHT = 184279,
    GO_PRIVATE_LIBRARY_DOOR = 184517,
    GO_MASSIVE_DOOR = 185521,
    GO_GAMESMAN_HALL_DOOR = 184276,
    GO_GAMESMAN_HALL_EXIT_DOOR = 184277,
    GO_NETHERSPACE_DOOR = 185134,
    GO_MASTERS_TERRACE_DOOR = 184274,
    GO_MASTERS_TERRACE_DOOR2 = 184280,
    GO_SIDE_ENTRANCE_DOOR = 184275,
    GO_DUST_COVERED_CHEST = 185119
};

enum KZMisc
{
    OPTIONAL_BOSS_REQUIRED_DEATH_COUNT = 50,
    AI_EVENT_CUSTOM_A = 1,
    AI_EVENT_CUSTOM_B = 2
};

enum KarazhanSpells
{
    SPELL_RATTLED = 32437,
    SPELL_OVERLOAD = 29766,
    SPELL_BLINK = 29884,

    // Chess event spells
    SPELL_CLEAR_BOARD = 37366,                    // spell cast to clear the board at the end of the event
    SPELL_GAME_IN_SESSION = 39331,                // debuff on players received while the game is in session
    SPELL_FORCE_KILL_BUNNY = 45260,               // triggers 45259
    SPELL_GAME_OVER = 39401,                      // cast by Medivh on game end
    SPELL_VICTORY_VISUAL = 39395,                 // cast by the Victory controller on game end
    
    FACTION_ID_CHESS_HORDE = 1689,
    FACTION_ID_CHESS_ALLIANCE = 1690,
};

#endif
