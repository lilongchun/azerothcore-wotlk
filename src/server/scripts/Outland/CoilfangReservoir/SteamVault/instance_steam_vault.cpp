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

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "steam_vault.h"

class go_main_chambers_access_panel : public GameObjectScript
{
public:
    go_main_chambers_access_panel() : GameObjectScript("go_main_chambers_access_panel") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (go->GetEntry() == GO_ACCESS_PANEL_HYDRO)
            {
                if (instance->GetBossState(DATA_HYDROMANCER_THESPIA) == DONE)
                {
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }
            else
            {
                if (instance->GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
                {
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }

            return true;
        }

        return false;
    }
};

ObjectData const creatureData[] =
{
    { NPC_MEKGINEER_STEAMRIGGER, DATA_MEKGINEER_STEAMRIGGER }
};

ObjectData const objectData[] =
{
    { GO_ACCESS_PANEL_HYDRO, DATA_ACCESS_PANEL_HYDROMANCER },
    { GO_ACCESS_PANEL_MEK,   DATA_ACCESS_PANEL_MEKGINEER   }
};

class instance_steam_vault : public InstanceMapScript
{
public:
    instance_steam_vault() : InstanceMapScript("instance_steam_vault", 545) { }

    struct instance_steam_vault_InstanceMapScript : public InstanceScript
    {
        instance_steam_vault_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeaders);
            SetBossNumber(EncounterCount);
            LoadObjectData(creatureData, objectData);
        }

        ObjectGuid MainChambersDoor;
        ObjectGuid AccessPanelHydro;
        ObjectGuid AccessPanelMek;

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_MAIN_CHAMBERS_DOOR:
                    MainChambersDoor = go->GetGUID();
                    if (GetBossState(DATA_HYDROMANCER_THESPIA) == SPECIAL && GetBossState(DATA_MEKGINEER_STEAMRIGGER) == SPECIAL)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_ACCESS_PANEL_HYDRO:
                    if (GetBossState(DATA_HYDROMANCER_THESPIA) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else if (GetBossState(DATA_HYDROMANCER_THESPIA) == SPECIAL)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_ACCESS_PANEL_MEK:
                    if (GetBossState(DATA_MEKGINEER_STEAMRIGGER) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else if (GetBossState(DATA_MEKGINEER_STEAMRIGGER) == SPECIAL)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
            }
        }

        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(bossId, state))
            {
                return false;
            }

            if (bossId == DATA_HYDROMANCER_THESPIA && state == DONE)
            {
                if (GameObject* panel = GetGameObject(DATA_ACCESS_PANEL_HYDROMANCER))
                {
                    panel->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }
            else if (bossId == DATA_MEKGINEER_STEAMRIGGER && state == DONE)
            {
                if (GameObject* panel = GetGameObject(DATA_ACCESS_PANEL_MEKGINEER))
                {
                    panel->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }
            }

            return true;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_steam_vault_InstanceMapScript(map);
    }
};

void AddSC_instance_steam_vault()
{
    new go_main_chambers_access_panel();
    new instance_steam_vault();
}
