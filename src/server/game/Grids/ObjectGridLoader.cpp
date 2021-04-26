/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "CellImpl.h"
#include "Corpse.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "ObjectAccessor.h"
#include "ObjectGridLoader.h"
#include "ObjectMgr.h"
#include "Transport.h"
#include "Vehicle.h"
#include "World.h"

// for loading world object at grid loading (Corpses)
//TODO: to implement npc on transport, also need to load npcs at grid loading
class ObjectWorldLoader
{
public:
    explicit ObjectWorldLoader(ObjectGridLoader& gloader)
        : i_cell(gloader.i_cell), i_map(gloader.i_map), i_grid(gloader.i_grid), i_corpses(gloader.i_corpses)
    {}

    void Visit(CorpseMapType& m);

    template<class T> void Visit(GridRefManager<T>&) { }

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
void AddObjectHelper(CellCoord& cell, GridRefManager<T>& m, uint32& count, Map* /*map*/, T* obj)
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
void LoadHelper(CellGuidSet const& guid_set, CellCoord& cell, GridRefManager<T>& m, uint32& count, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        T* obj = new T;
        ObjectGuid::LowType guid = *i_guid;
        //LOG_INFO("server", "DEBUG: LoadHelper from table: %s for (guid: %u) Loading", table, guid);
        if (!obj->LoadFromDB(guid, map))
        {
            delete obj;
            continue;
        }

        AddObjectHelper(cell, m, count, map, obj);
    }
}

template <>
void LoadHelper(CellGuidSet const& guid_set, CellCoord& cell, GridRefManager<GameObject>& m, uint32& count, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        ObjectGuid::LowType guid = *i_guid;
        GameObjectData const* data = sObjectMgr->GetGOData(guid);
        GameObject* obj = data && sObjectMgr->IsGameObjectStaticTransport(data->id) ? new StaticTransport() : new GameObject();
        //LOG_INFO("server", "DEBUG: LoadHelper from table: %s for (guid: %u) Loading", table, guid);
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("maps", "%u GameObjects, %u Creatures, and %u Corpses/Bones loaded for grid %u on map %u", i_gameObjects, i_creatures, i_corpses, i_grid.GetGridId(), i_map->GetId());
#endif
}

template<class T>
void ObjectGridUnloader::Visit(GridRefManager<T>& m)
{
    while (!m.isEmpty())
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
void ObjectGridCleaner::Visit(GridRefManager<T>& m)
{
    for (typename GridRefManager<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
        iter->GetSource()->CleanupsBeforeDelete();
}

template void ObjectGridUnloader::Visit(CreatureMapType&);
template void ObjectGridUnloader::Visit(GameObjectMapType&);
template void ObjectGridUnloader::Visit(DynamicObjectMapType&);

template void ObjectGridCleaner::Visit(CreatureMapType&);
template void ObjectGridCleaner::Visit<GameObject>(GameObjectMapType&);
template void ObjectGridCleaner::Visit<DynamicObject>(DynamicObjectMapType&);
template void ObjectGridCleaner::Visit<Corpse>(CorpseMapType&);
