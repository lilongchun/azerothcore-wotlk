/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AZEROTHCORE_BANNER_H
#define AZEROTHCORE_BANNER_H

#include "Define.h"

namespace acore
{
    namespace Banner
    {
        void Show(char const* applicationName, void(char const* text), void(*logExtraInfo)());
    }
}

#endif // AZEROTHCORE_BANNER_H
