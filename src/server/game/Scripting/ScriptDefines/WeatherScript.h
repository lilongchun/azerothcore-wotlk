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

#ifndef SCRIPT_OBJECT_WEATHER_SCRIPT_H_
#define SCRIPT_OBJECT_WEATHER_SCRIPT_H_

#include "ScriptObject.h"

class WeatherScript : public ScriptObject, public UpdatableScript<Weather>
{
protected:
    WeatherScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when the weather changes in the zone, this script is associated with.
    virtual void OnChange(Weather* /*weather*/, WeatherState /*state*/, float /*grade*/) { }
};

#endif
