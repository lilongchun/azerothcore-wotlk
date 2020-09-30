/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef CONT_BUILDER_H
#define CONT_BUILDER_H
#include <string>
#include "WDT.h"
#include "Define.h"

class ContinentBuilder
{
public:
    ContinentBuilder(std::string continent, uint32 mapId, WDT* wdt, uint32 tn) :
        Continent(continent), TileMap(wdt), MapId(mapId),
        NumberOfThreads(tn), tileXMin(64), tileYMin(64), tileXMax(0), tileYMax(0)
        {}

    void Build();
    void getTileBounds(uint32 tileX, uint32 tileY, float* verts, int vertCount, float* bmin, float* bmax)const;
    void CalculateTileBounds();
    float bmin[3];
    float bmax[3];
private:
    std::string Continent;
    WDT* TileMap;
    uint32 MapId;
    uint32 NumberOfThreads;
    int tileXMin;
    int tileYMin;
    int tileXMax;
    int tileYMax;
};
#endif
