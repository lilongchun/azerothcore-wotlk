/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _IVMAPMANAGER_H
#define _IVMAPMANAGER_H

#include "Define.h"
#include <string>

//===========================================================

/**
This is the minimum interface to the VMapMamager.
*/

namespace VMAP
{
    enum VMAP_LOAD_RESULT
    {
        VMAP_LOAD_RESULT_ERROR,
        VMAP_LOAD_RESULT_OK,
        VMAP_LOAD_RESULT_IGNORED
    };

#define VMAP_INVALID_HEIGHT       -100000.0f            // for check
#define VMAP_INVALID_HEIGHT_VALUE -200000.0f            // real assigned value in unknown height case

    //===========================================================
    class IVMapManager
    {
    private:
        bool iEnableLineOfSightCalc{true};
        bool iEnableHeightCalc{true};

    public:
        IVMapManager()  { }

        virtual ~IVMapManager() = default;

        virtual int loadMap(const char* pBasePath, unsigned int pMapId, int x, int y) = 0;

        virtual bool existsMap(const char* pBasePath, unsigned int pMapId, int x, int y) = 0;

        virtual void unloadMap(unsigned int pMapId, int x, int y) = 0;
        virtual void unloadMap(unsigned int pMapId) = 0;

        virtual bool isInLineOfSight(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2) = 0;
        virtual float getHeight(unsigned int pMapId, float x, float y, float z, float maxSearchDist) = 0;
        /**
        test if we hit an object. return true if we hit one. rx, ry, rz will hold the hit position or the dest position, if no intersection was found
        return a position, that is pReduceDist closer to the origin
        */
        virtual bool getObjectHitPos(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float pModifyDist) = 0;
        /**
        send debug commands
        */
        virtual bool processCommand(char* pCommand) = 0;

        /**
        Enable/disable LOS calculation
        It is enabled by default. If it is enabled in mid game the maps have to loaded manualy
        */
        void setEnableLineOfSightCalc(bool pVal) { iEnableLineOfSightCalc = pVal; }
        /**
        Enable/disable model height calculation
        It is enabled by default. If it is enabled in mid game the maps have to loaded manualy
        */
        void setEnableHeightCalc(bool pVal) { iEnableHeightCalc = pVal; }

        [[nodiscard]] bool isLineOfSightCalcEnabled() const { return (iEnableLineOfSightCalc); }
        [[nodiscard]] bool isHeightCalcEnabled() const { return (iEnableHeightCalc); }
        [[nodiscard]] bool isMapLoadingEnabled() const { return (iEnableLineOfSightCalc || iEnableHeightCalc  ); }

        [[nodiscard]] virtual std::string getDirFileName(unsigned int pMapId, int x, int y) const = 0;
        /**
        Query world model area info.
        \param z gets adjusted to the ground height for which this are info is valid
        */
        virtual bool getAreaInfo(unsigned int pMapId, float x, float y, float& z, uint32& flags, int32& adtId, int32& rootId, int32& groupId) const = 0;
        virtual bool GetLiquidLevel(uint32 pMapId, float x, float y, float z, uint8 ReqLiquidType, float& level, float& floor, uint32& type) const = 0;
    };
}

#endif
