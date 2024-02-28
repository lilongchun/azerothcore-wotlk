/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEF_HYJAL_H
#define DEF_HYJAL_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define DataHeader "HY"

#define HyjalScriptName "instance_hyjal"

uint32 const EncounterCount     = 5;

enum HyjalBosses
{
    BOSS_ARCHIMONDE = 0,
};

enum DataTypes
{
    DATA_WINTERCHILL            = 1,
    DATA_ANETHERON              = 2,
    DATA_KAZROGAL               = 3,
    DATA_AZGALOR                = 4,
    DATA_ARCHIMONDE             = 5,

    DATA_ALLIANCE_RETREAT       = 11,
    DATA_HORDE_RETREAT          = 12,

    DATA_JAINA                  = 13,
    DATA_THRALL                 = 14,
    DATA_TYRANDE                = 15,

    DATA_SPAWN_WAVES            = 20,
    DATA_SPAWN_INFERNALS        = 21,
    DATA_RESET_ALLIANCE         = 22,
    DATA_RESET_HORDE            = 23,
    DATA_RESET_NIGHT_ELF        = 24
};

enum WorldStateIds
{
    WORLD_STATE_WAVES           = 2842,
    WORLD_STATE_ENEMY           = 2453,
    WORLD_STATE_ENEMYCOUNT      = 2454
};

enum CreaturesIds
{
    // Trash Mobs summoned in waves
    NPC_NECRO                   = 17899,
    NPC_ABOMI                   = 17898,
    NPC_GHOUL                   = 17895,
    NPC_BANSH                   = 17905,
    NPC_CRYPT                   = 17897,
    NPC_GARGO                   = 17906,
    NPC_FROST                   = 17907,
    NPC_INFER                   = 17908,
    NPC_STALK                   = 17916,
    NPC_BUILD                   = 18304,    // Serverside creature? Not found in CreateObject packets, but seen as targets

    // Alliance Base
    NPC_JAINA                   = 17772,
    NPC_ALLIANCE_PEASANT        = 17931,
    NPC_ALLIANCE_KNIGHT         = 17920,
    NPC_ALLIANCE_FOOTMAN        = 17919,
    NPC_ALLIANCE_RIFLEMAN       = 17921,
    NPC_ALLIANCE_PRIEST         = 17928,
    NPC_ALLIANCE_SORCERESS      = 17922,

    // Horde Base
    NPC_THRALL                  = 17852,
    NPC_HORDE_HEADHUNTER        = 17934,
    NPC_HORDE_SHAMAN            = 17936,
    NPC_HORDE_GRUNT             = 17932,
    NPC_HORDE_HEALING_WARD      = 18036,
    NPC_TAUREN_WARRIOR          = 17933,
    NPC_HORDE_WITCH_DOCTOR      = 17935,
    NPC_HORDE_PEON              = 17937,
    NPC_INFERNAL_RELAY          = 18242,
    NPC_INFERNAL_TARGET         = 21075,

    // Night Elf Base
    NPC_TYRANDE                 = 17948,
    NPC_DRUID_OF_THE_TALON      = 3794,
    NPC_DRUID_OF_THE_CLAW       = 3795,
    NPC_NELF_ANCIENT_PROT       = 18487,
    NPC_NELF_ANCIENT_OF_LORE    = 18486,
    NPC_NELF_ANCIENT_OF_WAR     = 18485,
    NPC_NELF_ARCHER             = 17943,
    NPC_NELF_HUNTRESS           = 17945,
    NPC_DRYAD                   = 17944,

    // Bosses
    NPC_WINTERCHILL             = 17767,
    NPC_ANETHERON               = 17808,
    NPC_KAZROGAL                = 17888,
    NPC_AZGALOR                 = 17842,
    NPC_ARCHIMONDE              = 17968,
    NPC_WORLD_TRIGGER_TINY      = 21987
};

enum GameobjectIds
{
    GO_HORDE_ENCAMPMENT_PORTAL  = 182060,
    GO_NIGHT_ELF_VILLAGE_PORTAL = 182061,
    GO_ANCIENT_GEM              = 185557,
    GO_FLAME                    = 182260
};

enum Spells
{
    SPELL_INFERNAL              = 32148
};

enum Misc
{
    MAX_WAVES_STANDARD          = 9,
    MAX_WAVES_RETREAT           = 3,
    MAX_WAVES_NIGHT_ELF         = 1,
    START_WAVE_WINTERCHILL      = 0,
    START_WAVE_ANETHERON        = 9,
    START_WAVE_KAZROGAL         = 18,
    START_WAVE_AZGALOR          = 27,
    START_WAVE_ALLIANCE_RETREAT = 36,
    START_WAVE_HORDE_RETREAT    = 39,
    START_WAVE_NIGHT_ELF        = 42,

    CONTEXT_GROUP_WAVES         = 1
};

Milliseconds hyjalWaveTimers[4][MAX_WAVES_STANDARD]
{
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Winterchill
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Anetheron
    { 130000ms, 155000ms, 130000ms, 155000ms, 130000ms, 130000ms, 155000ms, 225000ms, 0ms },    // Kaz'rogal
    { 130000ms, 190000ms, 190000ms, 190000ms, 130000ms, 155000ms, 190000ms, 225000ms, 0ms }     // Azgalor
};

Milliseconds hyjalRetreatTimers[2][MAX_WAVES_RETREAT]
{
    { 10000ms, 6000ms , 0ms },   // Alliance
    { 10000ms, 40000ms, 0ms }    // Horde
};

Milliseconds hyjalNightElfWaveTimers[1][MAX_WAVES_NIGHT_ELF]
{
    { 0ms }
};

template <class AI, class T>
inline AI* GetHyjalAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HyjalScriptName);
}

#endif
