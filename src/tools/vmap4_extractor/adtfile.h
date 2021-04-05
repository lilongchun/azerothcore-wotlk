/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ADT_H
#define ADT_H

#include "mpq_libmpq04.h"
#include "wmo.h"
#include "model.h"

#define TILESIZE (533.33333f)
#define CHUNKSIZE ((TILESIZE) / 16.0f)
#define UNITSIZE (CHUNKSIZE / 8.0f)

class Liquid;

typedef struct
{
    float x;
    float y;
    float z;
} svec;

struct vec
{
    double x;
    double y;
    double z;
};

struct triangle
{
    vec v[3];
};

typedef struct
{
    float v9[16 * 8 + 1][16 * 8 + 1];
    float v8[16 * 8][16 * 8];
} Cell;

typedef struct
{
    double v9[9][9];
    double v8[8][8];
    uint16 area_id;
    //Liquid *lq;
    float waterlevel[9][9];
    uint8 flag;
} chunk;

typedef struct
{
    chunk ch[16][16];
} mcell;

struct MapChunkHeader
{
    uint32 flags;
    uint32 ix;
    uint32 iy;
    uint32 nLayers;
    uint32 nDoodadRefs;
    uint32 ofsHeight;
    uint32 ofsNormal;
    uint32 ofsLayer;
    uint32 ofsRefs;
    uint32 ofsAlpha;
    uint32 sizeAlpha;
    uint32 ofsShadow;
    uint32 sizeShadow;
    uint32 areaid;
    uint32 nMapObjRefs;
    uint32 holes;
    uint16 s1;
    uint16 s2;
    uint32 d1;
    uint32 d2;
    uint32 d3;
    uint32 predTex;
    uint32 nEffectDoodad;
    uint32 ofsSndEmitters;
    uint32 nSndEmitters;
    uint32 ofsLiquid;
    uint32 sizeLiquid;
    float  zpos;
    float  xpos;
    float  ypos;
    uint32 textureId;
    uint32 props;
    uint32 effectId;
};

#pragma pack(push, 1)

namespace ADT
{
    struct MDDF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        uint16 Scale;
        uint16 Flags;
    };

    struct MODF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        AaBox3D Bounds;
        uint16 Flags;
        uint16 DoodadSet;   // can be larger than number of doodad sets in WMO
        uint16 NameSet;
        uint16 Scale;
    };
}
#pragma pack(pop)

class ADTFile
{
private:
    MPQFile _file;
    std::string Adtfilename;
public:
    ADTFile(char* filename);
    ~ADTFile();
    std::vector<std::string> WmoInstanceNames;
    std::vector<std::string> ModelInstanceNames;
    bool init(uint32 map_num, uint32 tileX, uint32 tileY);
    //void LoadMapChunks();

    //uint32 wmo_count;
    /*
        const mcell& Getmcell() const
        {
            return Mcell;
        }
    */
};

const char* GetPlainName(const char* FileName);
char* GetPlainName(char* FileName);
char* GetExtension(char* FileName);
void fixnamen(char* name, size_t len);
void fixname2(char* name, size_t len);
//void fixMapNamen(char *name, size_t len);

#endif
