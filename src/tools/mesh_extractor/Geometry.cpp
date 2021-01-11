/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Geometry.h"
#include "Constants.h"
#include "ADT.h"
#include "WorldModelHandler.h"
#include "DoodadHandler.h"
#include <limits.h>

Geometry::Geometry() : Transform(false)
{
    Vertices.reserve(10000);
    Triangles.reserve(10000);
}

void Geometry::CalculateBoundingBox( float*& min, float*& max )
{
    min = new float[3];
    max = new float[3];
    for (int i = 0; i < 3; ++i)
    {
        max[i] = std::numeric_limits<float>::min();
        min[i] = std::numeric_limits<float>::max();
    }

    for (std::vector<Vector3>::iterator itr = Vertices.begin(); itr != Vertices.end(); ++itr)
    {
        if (itr->x > max[0])
            max[0] = itr->x;
        if (itr->x < min[0])
            min[0] = itr->x;

        if (itr->y > max[1])
            max[1] = itr->y;
        if (itr->y < min[1])
            min[1] = itr->y;

        if (itr->z > max[2])
            max[2] = itr->z;
        if (itr->z < min[2])
            min[2] = itr->z;
    }
}

void Geometry::CalculateMinMaxHeight( float& min, float& max )
{
    min = std::numeric_limits<float>::max();
    max = std::numeric_limits<float>::min();

    for (std::vector<Vector3>::iterator itr = Vertices.begin(); itr != Vertices.end(); ++itr)
    {
        if (Transform)
        {
            if (itr->y < min)
                min = itr->y;
            if (itr->y > max)
                max = itr->y;
        }
        else
        {
            if (itr->z < min)
                min = itr->z;
            if (itr->z > max)
                max = itr->z;
        }
    }
}

void Geometry::AddData( std::vector<Vector3>& verts, std::vector<Triangle<uint32>>& tris )
{
    uint32 vertOffset = Vertices.size();
    for (std::vector<Vector3>::iterator itr = verts.begin(); itr != verts.end(); ++itr)
        Vertices.push_back(Transform ? Utils::ToRecast(*itr) : *itr);

    for (std::vector<Triangle<uint32>>::iterator itr = tris.begin(); itr != tris.end(); ++itr)
        Triangles.push_back(Triangle<uint32>(itr->Type, itr->V0 + vertOffset, itr->V1 + vertOffset, itr->V2 + vertOffset));
}

void Geometry::GetRawData( float*& verts, int*& tris, uint8*& areas )
{
    verts = new float[Vertices.size() * 3];
    for (uint32 i = 0; i < Vertices.size(); ++i)
    {
        Vector3& vert = Vertices[i];
        verts[(i * 3) + 0] = vert.x;
        verts[(i * 3) + 1] = vert.y;
        verts[(i * 3) + 2] = vert.z;
    }

    tris = new int[Triangles.size() * 3];
    for (uint32 i = 0; i < Triangles.size(); ++i)
    {
        Triangle<uint32>& tri = Triangles[i];
        tris[(i * 3) + 0] = (int)tri.V0;
        tris[(i * 3) + 1] = (int)tri.V1;
        tris[(i * 3) + 2] = (int)tri.V2;
    }

    areas = new uint8[Triangles.size()];
    for (uint32 i = 0; i < Triangles.size(); i++)
    {
        switch (Triangles[i].Type)
        {
            case Constants::TRIANGLE_TYPE_WATER:
                areas[i] = Constants::POLY_AREA_WATER;
                break;
            default:
                areas[i] = Constants::POLY_AREA_TERRAIN;
                break;
        }
    }
}

void Geometry::AddAdt( ADT* adt )
{
    for (std::vector<MapChunk*>::iterator itr = adt->MapChunks.begin(); itr != adt->MapChunks.end(); ++itr)
    {
        std::vector<Triangle<uint32>> tmp;
        tmp.reserve((*itr)->Triangles.size());
        for (std::vector<Triangle<uint8>>::iterator itr2 = (*itr)->Triangles.begin(); itr2 != (*itr)->Triangles.end(); ++itr2)
            tmp.push_back(Triangle<uint32>(itr2->Type, itr2->V0, itr2->V1, itr2->V2));
        AddData((*itr)->Vertices, tmp);
    }

    if (!adt->_DoodadHandler->Triangles.empty())
        AddData(adt->_DoodadHandler->Vertices, adt->_DoodadHandler->Triangles);

    if (!adt->_WorldModelHandler->Triangles.empty())
        AddData(adt->_WorldModelHandler->Vertices, adt->_WorldModelHandler->Triangles);
}
