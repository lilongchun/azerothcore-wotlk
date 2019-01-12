/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 */

#ifndef SC_SYSTEM_H
#define SC_SYSTEM_H

#include "ScriptMgr.h"

#define TEXT_SOURCE_RANGE -1000000                          //the amount of entries each text source has available

//TODO: find better namings and definitions.
//N=Neutral, A=Alliance, H=Horde.
//NEUTRAL or FRIEND = Hostility to player surroundings (not a good definition)
//ACTIVE or PASSIVE = Hostility to environment surroundings.
enum eEscortFaction
{
    FACTION_ESCORT_A_NEUTRAL_PASSIVE    = 10,
    FACTION_ESCORT_H_NEUTRAL_PASSIVE    = 33,
    FACTION_ESCORT_N_NEUTRAL_PASSIVE    = 113,

    FACTION_ESCORT_A_NEUTRAL_ACTIVE     = 231,
    FACTION_ESCORT_H_NEUTRAL_ACTIVE     = 232,
    FACTION_ESCORT_N_NEUTRAL_ACTIVE     = 250,

    FACTION_ESCORT_N_FRIEND_PASSIVE     = 290,
    FACTION_ESCORT_N_FRIEND_ACTIVE      = 495,

    FACTION_ESCORT_A_PASSIVE            = 774,
    FACTION_ESCORT_H_PASSIVE            = 775,

    FACTION_ESCORT_N_ACTIVE             = 1986,
    FACTION_ESCORT_H_ACTIVE             = 2046
};

struct ScriptPointMove
{
    uint32 uiCreatureEntry;
    uint32 uiPointId;
    float  fX;
    float  fY;
    float  fZ;
    uint32 uiWaitTime;
};

typedef std::vector<ScriptPointMove> ScriptPointVector;

class SystemMgr
{
        SystemMgr() {}
        ~SystemMgr() {}

    public:
        static SystemMgr* instance();

        typedef UNORDERED_MAP<uint32, ScriptPointVector> PointMoveMap;

        //Database
        void LoadScriptWaypoints();

        ScriptPointVector const& GetPointMoveList(uint32 creatureEntry) const
        {
            PointMoveMap::const_iterator itr = m_mPointMoveMap.find(creatureEntry);

            if (itr == m_mPointMoveMap.end())
                return _empty;

            return itr->second;
        }

    protected:
        PointMoveMap    m_mPointMoveMap;                    //coordinates for waypoints

    private:
        static ScriptPointVector const _empty;
};

#define sScriptSystemMgr SystemMgr::instance()

#endif
