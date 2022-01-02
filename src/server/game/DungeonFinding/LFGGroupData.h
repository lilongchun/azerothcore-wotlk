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

#ifndef _LFGGROUPDATA_H
#define _LFGGROUPDATA_H

#include "LFG.h"

namespace lfg
{
    /**
        Stores all lfg data needed about a group.
    */
    class LfgGroupData
    {
    public:
        LfgGroupData();
        ~LfgGroupData();

        auto IsLfgGroup() -> bool;

        // General
        void SetState(LfgState state);
        void RestoreState();
        void AddPlayer(ObjectGuid guid);
        auto RemovePlayer(ObjectGuid guid) -> uint8;
        void RemoveAllPlayers();
        void SetLeader(ObjectGuid guid);

        // Dungeon
        void SetDungeon(uint32 dungeon);

        // VoteKick
        void DecreaseKicksLeft();

        // General
        [[nodiscard]] auto GetState() const -> LfgState;
        [[nodiscard]] auto GetOldState() const -> LfgState;
        [[nodiscard]] auto GetPlayers() const -> LfgGuidSet const&;
        [[nodiscard]] auto GetPlayerCount() const -> uint8;
        [[nodiscard]] auto GetLeader() const -> ObjectGuid;

        // Dungeon
        [[nodiscard]] auto GetDungeon(bool asId = true) const -> uint32;

        // VoteKick
        [[nodiscard]] auto GetKicksLeft() const -> uint8;

    private:
        // General
        LfgState m_State;                                  ///< State if group in LFG
        LfgState m_OldState;                               ///< Old State
        ObjectGuid m_Leader;                               ///< Leader GUID
        LfgGuidSet m_Players;                              ///< Players in group
        // Dungeon
        uint32 m_Dungeon;                                  ///< Dungeon entry
        // Vote Kick
        uint8 m_KicksLeft;                                 ///< Number of kicks left
    };

} // namespace lfg

#endif
