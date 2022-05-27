/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
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

#define _CRT_SECURE_NO_DEPRECATE

#include "wdt.h"

u_map_fcc MPHDMagic = { {'D', 'H', 'P', 'M'} };
u_map_fcc MAINMagic = { {'N', 'I', 'A', 'M'} };

bool wdt_MPHD::prepareLoadedData()
{
    if (fcc != MPHDMagic.fcc)
        return false;
    return true;
}

bool wdt_MAIN::prepareLoadedData()
{
    if (fcc != MAINMagic.fcc)
        return false;
    return true;
}

WDT_file::WDT_file()
{
    mphd = nullptr;
    main = nullptr;
}

WDT_file::~WDT_file()
{
    free();
}

void WDT_file::free()
{
    mphd = nullptr;
    main = nullptr;
    FileLoader::free();
}

bool WDT_file::prepareLoadedData()
{
    // Check parent
    if (!FileLoader::prepareLoadedData())
        return false;

    mphd = (wdt_MPHD*)((uint8*)version + version->size + 8);
    if (!mphd->prepareLoadedData())
        return false;
    main = (wdt_MAIN*)((uint8*)mphd + mphd->size + 8);
    if (!main->prepareLoadedData())
        return false;
    return true;
}
