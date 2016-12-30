/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#ifndef DEF_KARAZHAN_H
#define DEF_KARAZHAN_H

#include "ScriptPCH.h"

enum DataTypes
{
    DATA_SERVANT_QUARTERS           = 0,
    DATA_ATTUMEN                    = 1,
    DATA_MOROES                     = 2,
    DATA_MAIDEN                     = 3,
    DATA_OPTIONAL_BOSS              = 4,
    DATA_OPERA                      = 5,
    DATA_CURATOR                    = 6,
    DATA_ARAN                       = 7,
    DATA_TERESTIAN                  = 8,
    DATA_NETHERSPITE                = 9,
    DATA_CHESS                      = 10,
    DATA_MALCHEZZAR                 = 11,
    DATA_NIGHTBANE                  = 12,
    MAX_ENCOUNTERS                  = 13,

    DATA_OPERA_PERFORMANCE          = 13,
    DATA_OPERA_OZ_DEATHCOUNT        = 14,

    DATA_KILREK                     = 15,
    DATA_GO_CURTAINS                = 18,
    DATA_GO_STAGEDOORLEFT           = 19,
    DATA_GO_STAGEDOORRIGHT          = 20,
    DATA_GO_LIBRARY_DOOR            = 21,
    DATA_GO_MASSIVE_DOOR            = 22,
    DATA_GO_NETHER_DOOR             = 23,
    DATA_GO_GAME_DOOR               = 24,
    DATA_GO_GAME_EXIT_DOOR          = 25,

    DATA_IMAGE_OF_MEDIVH            = 26,
    DATA_MASTERS_TERRACE_DOOR_1     = 27,
    DATA_MASTERS_TERRACE_DOOR_2     = 28,
    DATA_GO_SIDE_ENTRANCE_DOOR      = 29,

    DATA_COUNT_SERVANT_QUARTERS_KILLS   = 100,
    DATA_SELECTED_RARE                  = 101,
};

enum OperaEvents
{
    EVENT_OZ                        = 1,
    EVENT_HOOD                      = 2,
    EVENT_RAJ                       = 3
};

enum KarazhanNPCs
{
    NPC_HYAKISS_THE_LURKER              = 16179,
    NPC_SHADIKITH_THE_GLIDER            = 16180,
    NPC_ROKAD_THE_RAVAGER               = 16181,

    NPC_ATTUMEN_THE_HUNTSMAN            = 15550,
    NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED    = 16152
};

enum KarazhanSpells
{
    SPELL_RATTLED                   = 32437,
    SPELL_OVERLOAD                  = 29766,
    SPELL_BLINK                     = 29884
};


#endif

