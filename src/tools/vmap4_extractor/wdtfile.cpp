/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "vmapexport.h"
#include "wdtfile.h"
#include "adtfile.h"

#include <cstdio>

char* wdtGetPlainName(char* FileName)
{
    char* szTemp;

    if ((szTemp = strrchr(FileName, '\\')) != nullptr)
    {
        FileName = szTemp + 1;
    }
    return FileName;
}

WDTFile::WDTFile(char* file_name, char* file_name1) : _file(file_name)
{
    filename.append(file_name1, strlen(file_name1));
}

bool WDTFile::init(uint32 mapId)
{
    if (_file.isEof())
    {
        //printf("Can't find WDT file.\n");
        return false;
    }

    char fourcc[5];
    uint32 size;

    std::string dirname = std::string(szWorkDirWmo) + "/dir_bin";
    FILE* dirfile;
    dirfile = fopen(dirname.c_str(), "ab");
    if (!dirfile)
    {
        printf("Can't open dirfile!'%s'\n", dirname.c_str());
        return false;
    }

    while (!_file.isEof())
    {
        _file.read(fourcc, 4);
        _file.read(&size, 4);

        flipcc(fourcc);
        fourcc[4] = 0;

        size_t nextpos = _file.getPos() + size;

        if (!strcmp(fourcc, "MAIN"))
        {
        }
        if (!strcmp(fourcc, "MWMO"))
        {
            // global map objects
            if (size)
            {
                char* buf = new char[size];
                _file.read(buf, size);
                char* p = buf;
                while (p < buf + size)
                {
                    std::string path(p);

                    char* s = wdtGetPlainName(p);
                    fixnamen(s, strlen(s));
                    fixname2(s, strlen(s));
                    p = p + strlen(p) + 1;
                    _wmoNames.push_back(s);

                    ExtractSingleWmo(path);
                }
                delete[] buf;
            }
        }
        else if (!strcmp(fourcc, "MODF"))
        {
            // global wmo instance data
            if (size)
            {
                uint32 mapObjectCount = size / sizeof(ADT::MODF);
                for (uint32 i = 0; i < mapObjectCount; ++i)
                {
                    ADT::MODF mapObjDef;
                    _file.read(&mapObjDef, sizeof(ADT::MODF));
                    MapObject::Extract(mapObjDef, _wmoNames[mapObjDef.Id].c_str(), mapId, 65, 65, dirfile);
                    Doodad::ExtractSet(WmoDoodads[_wmoNames[mapObjDef.Id]], mapObjDef, mapId, 65, 65, dirfile);
                }
            }
        }
        _file.seek((int)nextpos);
    }

    _file.close();
    fclose(dirfile);
    return true;
}

WDTFile::~WDTFile()
{
    _file.close();
}

ADTFile* WDTFile::GetMap(int x, int z)
{
    if (!(x >= 0 && z >= 0 && x < 64 && z < 64))
    {
        return nullptr;
    }

    char name[512];

    snprintf(name, sizeof(name), R"(World\Maps\%s\%s_%d_%d.adt)", filename.c_str(), filename.c_str(), x, z);
    return new ADTFile(name);
}
