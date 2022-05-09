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

#include "ObjectGridLoader.h"
#include "CellImpl.h"
#include "Corpse.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Transport.h"
#include "Vehicle.h"
#include "ScriptMgr.h"

// for loading world object at grid loading (Corpses)
//TODO: to implement npc on transport, also need to load npcs at grid loading
class ObjectWorldLoader
{
public:
    explicit ObjectWorldLoader(ObjectGridLoader& gloader)
        : i_cell(gloader.i_cell), i_map(gloader.i_map), i_grid(gloader.i_grid), i_corpses(gloader.i_corpses)
    {}

    void Visit(CorpseMapType& m);

    template<class T> void Visit(GridRefMgr<T>&) { }

private:
    Cell i_cell;
    Map* i_map;
    NGridType& i_grid;
public:
    uint32& i_corpses;
};

template<class T> void ObjectGridLoader::SetObjectCell(T* /*obj*/, CellCoord const& /*cellCoord*/)
{
}

template<> void ObjectGridLoader::SetObjectCell(Creature* obj, CellCoord const& cellCoord)
{
    Cell cell(cellCoord);
    obj->SetCurrentCell(cell);
}

template<> void ObjectGridLoader::SetObjectCell(GameObject* obj, CellCoord const& cellCoord)
{
    Cell cell(cellCoord);
    obj->SetCurrentCell(cell);
}

template <class T>
void AddObjectHelper(CellCoord& cell, GridRefMgr<T>& m, uint32& count, Map* /*map*/, T* obj)
{
    obj->AddToGrid(m);
    ObjectGridLoader::SetObjectCell(obj, cell);
    obj->AddToWorld();
    ++count;
}

template <>
void AddObjectHelper(CellCoord& cell, CreatureMapType& m, uint32& count, Map* map, Creature* obj)
{
    obj->AddToGrid(m);
    ObjectGridLoader::SetObjectCell(obj, cell);
    obj->AddToWorld();
    if (obj->isActiveObject())
        map->AddToActive(obj);

    ++count;
}

template <>
void AddObjectHelper(CellCoord& cell, GameObjectMapType& m, uint32& count, Map* map, GameObject* obj)
{
    obj->AddToGrid(m);
    ObjectGridLoader::SetObjectCell(obj, cell);
    obj->AddToWorld();
    if (obj->isActiveObject())
        map->AddToActive(obj);

    ++count;
}

template <class T>
void LoadHelper(CellGuidSet const& guid_set, CellCoord &cell, GridRefMgr<T> &m, uint32 &count, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        T* obj = new T;

        // Don't spawn at all if there's a respawn time
        if ((obj->GetTypeId() == TYPEID_UNIT && !map->GetCreatureRespawnTime(*i_guid)) || (obj->GetTypeId() == TYPEID_GAMEOBJECT && !map->GetGORespawnTime(*i_guid)))
        {
            ObjectGuid::LowType guid = *i_guid;

            if (obj->GetTypeId() == TYPEID_UNIT)
            {
                CreatureData const* cdata = sObjectMgr->GetCreatureData(guid);
                        ASSERT(cdata, "Tried to load creature with spawnId %u, but no such creature exists.", guid);
                SpawnGroupTemplateData const* const group = cdata->spawnGroupData;
                // If creature in manual spawn group, don't spawn here, unless group is already active.
                if ((group->flags & SPAWNGROUP_FLAG_MANUAL_SPAWN) && !group->isActive)
                    continue;

                // If script is blocking spawn, don't spawn but queue for a re-check in a little bit
                if (!(group->flags & SPAWNGROUP_FLAG_COMPATIBILITY_MODE) && !sScriptMgr->CanSpawn(guid, cdata->id, cdata, map))
                {
                    map->SaveRespawnTime(SPAWN_TYPE_CREATURE, guid, cdata->id, time(NULL) + urand(4,7), map->GetZoneId(cdata->spawnPoint), Trinity::ComputeGridCoord(cdata->spawnPoint.GetPositionX(), cdata->spawnPoint.GetPositionY()).GetId(), false);
                    continue;
                }
            }
            else if (obj->GetTypeId() == TYPEID_GAMEOBJECT)
            {
                // If gameobject in manual spawn group, don't spawn here, unless group is already active.
                GameObjectData const* godata = sObjectMgr->GetGameObjectData(guid);
                        ASSERT(godata, "Tried to load gameobject with spawnId %u, but no such object exists.", guid);
                if ((godata->spawnGroupData->flags & SPAWNGROUP_FLAG_MANUAL_SPAWN) && !godata->spawnGroupData->isActive)
                    continue;
            }

            if (!obj->LoadFromDB(guid, map, false, false))
                delete obj;
                continue;
            }
            AddObjectHelper(cell, m, count, map, obj);
        }
        else
            delete obj;
    }
}


template <>
void LoadHelper(CellGuidSet const& guid_set, CellCoord& cell, GridRefMgr<GameObject>& m, uint32& count, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        ObjectGuid::LowType guid = *i_guid;
        GameObjectData const* data = sObjectMgr->GetGOData(guid);
        GameObject* obj = data && sObjectMgr->IsGameObjectStaticTransport(data->id) ? new StaticTransport() : new GameObject();

        if (!obj->LoadFromDB(guid, map))
        {
            delete obj;
            continue;
        }

        AddObjectHelper(cell, m, count, map, obj);
    }
}

void ObjectGridLoader::Visit(GameObjectMapType& m)
{
    CellCoord cellCoord = i_cell.GetCellCoord();
    CellObjectGuids const& cell_guids = sObjectMgr->GetCellObjectGuids(i_map->GetId(), i_map->GetSpawnMode(), cellCoord.GetId());
    LoadHelper(cell_guids.gameobjects, cellCoord, m, i_gameObjects, i_map);
}

void ObjectGridLoader::Visit(CreatureMapType& m)
{
    CellCoord cellCoord = i_cell.GetCellCoord();
    CellObjectGuids const& cell_guids = sObjectMgr->GetCellObjectGuids(i_map->GetId(), i_map->GetSpawnMode(), cellCoord.GetId());
    LoadHelper(cell_guids.creatures, cellCoord, m, i_creatures, i_map);
}

void ObjectWorldLoader::Visit(CorpseMapType& /*m*/)
{
    CellCoord cellCoord = i_cell.GetCellCoord();
    if (std::unordered_set<Corpse*> const* corpses = i_map->GetCorpsesInCell(cellCoord.GetId()))
    {
        for (Corpse* corpse : *corpses)
        {
            corpse->AddToWorld();
            GridType& cell = i_grid.GetGridType(i_cell.CellX(), i_cell.CellY());
            if (corpse->IsWorldObject())
                cell.AddWorldObject(corpse);
            else
                cell.AddGridObject(corpse);

            ++i_corpses;
        }
    }
}

void ObjectGridLoader::LoadN(void)
{
    i_gameObjects = 0;
    i_creatures = 0;
    i_corpses = 0;
    i_cell.data.Part.cell_y = 0;
    for (uint32 x = 0; x < MAX_NUMBER_OF_CELLS; ++x)
    {
        i_cell.data.Part.cell_x = x;
        for (uint32 y = 0; y < MAX_NUMBER_OF_CELLS; ++y)
        {
            i_cell.data.Part.cell_y = y;

            //Load creatures and game objects
            {
                TypeContainerVisitor<ObjectGridLoader, GridTypeMapContainer> visitor(*this);
                i_grid.VisitGrid(x, y, visitor);
            }

            //Load corpses (not bones)
            {
                ObjectWorldLoader worker(*this);
                TypeContainerVisitor<ObjectWorldLoader, WorldTypeMapContainer> visitor(worker);
                i_grid.VisitGrid(x, y, visitor);
            }
        }
    }
    LOG_DEBUG("maps", "{} GameObjects, {} Creatures, and {} Corpses/Bones loaded for grid {} on map {}", i_gameObjects, i_creatures, i_corpses, i_grid.GetGridId(), i_map->GetId());
}

template<class T>
void ObjectGridUnloader::Visit(GridRefMgr<T>& m)
{
    while (!m.IsEmpty())
    {
        T* obj = m.getFirst()->GetSource();
        // if option set then object already saved at this moment
        //if (!sWorld->getBoolConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
        //    obj->SaveRespawnTime();
        //Some creatures may summon other temp summons in CleanupsBeforeDelete()
        //So we need this even after cleaner (maybe we can remove cleaner)
        //Example: Flame Leviathan Turret 33139 is summoned when a creature is deleted
        //TODO: Check if that script has the correct logic. Do we really need to summons something before deleting?
        obj->CleanupsBeforeDelete();
        ///- object will get delinked from the manager when deleted
        delete obj;
    }
}

template<class T>
void ObjectGridCleaner::Visit(GridRefMgr<T>& m)
{
    for (typename GridRefMgr<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
        iter->GetSource()->CleanupsBeforeDelete();
}

template void ObjectGridUnloader::Visit(CreatureMapType&);
template void ObjectGridUnloader::Visit(GameObjectMapType&);
template void ObjectGridUnloader::Visit(DynamicObjectMapType&);

template void ObjectGridCleaner::Visit(CreatureMapType&);
template void ObjectGridCleaner::Visit<GameObject>(GameObjectMapType&);
template void ObjectGridCleaner::Visit<DynamicObject>(DynamicObjectMapType&);
template void ObjectGridCleaner::Visit<Corpse>(CorpseMapType&);
