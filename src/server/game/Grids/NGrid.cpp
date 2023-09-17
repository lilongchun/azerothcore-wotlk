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

#include "NGrid.h"
#include "Random.h"

GridInfo::GridInfo() : i_timer(0), vis_Update(0, irand(0, DEFAULT_VISIBILITY_NOTIFY_PERIOD)),
i_unloadActiveLockCount(0), i_unloadExplicitLock(false), i_unloadReferenceLock(false)
{
}

GridInfo::GridInfo(time_t expiry, bool unload /*= true */) : i_timer(expiry), vis_Update(0, irand(0, DEFAULT_VISIBILITY_NOTIFY_PERIOD)),
i_unloadActiveLockCount(0), i_unloadExplicitLock(!unload), i_unloadReferenceLock(false)
{
}
