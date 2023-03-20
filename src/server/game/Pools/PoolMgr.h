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

#ifndef ACORE_POOLHANDLER_H
#define ACORE_POOLHANDLER_H

#include "Creature.h"
#include "Define.h"
#include "GameObject.h"
#include "QuestDef.h"
#include "SpawnData.h"

struct PoolTemplateData
{
    uint32  MaxLimit;
};

struct PoolObject
{
    uint32  guid;
    float   chance;
    PoolObject(uint32 _guid, float _chance): guid(_guid), chance(std::fabs(_chance)) {}
};

class Pool                                                  // for Pool of Pool case
{
};

typedef std::unordered_set<uint32> ActivePoolObjects;
typedef std::map<uint32, uint32> ActivePoolPools;

class ActivePoolData
{
public:
    template<typename T>
    bool IsActiveObject(uint32 db_guid_or_pool_id) const;

    uint32 GetActiveObjectCount(uint32 pool_id) const;

    template<typename T>
    void ActivateObject(uint32 db_guid_or_pool_id, uint32 pool_id);

    template<typename T>
    void RemoveObject(uint32 db_guid_or_pool_id, uint32 pool_id);

    ActivePoolObjects GetActiveQuests() const { return mActiveQuests; } // a copy of the set
private:
    ActivePoolObjects mSpawnedCreatures;
    ActivePoolObjects mSpawnedGameobjects;
    ActivePoolObjects mActiveQuests;
    ActivePoolPools   mSpawnedPools;
};

template <class T>
class PoolGroup
{
    typedef std::vector<PoolObject> PoolObjectList;
public:
    explicit PoolGroup() : poolId(0) { }
    void SetPoolId(uint32 pool_id) { poolId = pool_id; }
    ~PoolGroup() {};
    bool IsEmpty() const { return ExplicitlyChanced.empty() && EqualChanced.empty(); }
    void AddEntry(PoolObject& poolitem, uint32 maxentries);
    bool CheckPool() const;
    void DespawnObject(ActivePoolData& spawns, ObjectGuid::LowType guid = 0);
    void Despawn1Object(ObjectGuid::LowType guid);
    void SpawnObject(ActivePoolData& spawns, uint32 limit, uint32 triggerFrom);

    void Spawn1Object(PoolObject* obj);
    void ReSpawn1Object(PoolObject* obj);
    void RemoveOneRelation(uint32 child_pool_id);
    uint32 GetFirstEqualChancedObjectId()
    {
        if (EqualChanced.empty())
            return 0;
        return EqualChanced.front().guid;
    }
    uint32 GetPoolId() const { return poolId; }
private:
    uint32 poolId;
    PoolObjectList ExplicitlyChanced;
    PoolObjectList EqualChanced;
};

typedef std::multimap<uint32, uint32> PooledQuestRelation;
typedef std::pair<PooledQuestRelation::const_iterator, PooledQuestRelation::const_iterator> PooledQuestRelationBounds;
typedef std::pair<PooledQuestRelation::iterator, PooledQuestRelation::iterator> PooledQuestRelationBoundsNC;

class PoolMgr
{
private:
    PoolMgr();
    ~PoolMgr() {};

public:
    static PoolMgr* instance();

    void LoadFromDB();
    void LoadQuestPools();
    void SaveQuestsToDB(bool daily, bool weekly, bool other);

    void Initialize();

    template<typename T>
    uint32 IsPartOfAPool(uint32 db_guid_or_pool_id) const;
    uint32 IsPartOfAPool(SpawnObjectType type, ObjectGuid::LowType spawnId) const;

    template<typename T>
    bool IsSpawnedObject(uint32 db_guid_or_pool_id) const { return mSpawnedData.IsActiveObject<T>(db_guid_or_pool_id); }

    bool CheckPool(uint32 pool_id) const;

    void SpawnPool(uint32 pool_id);
    void DespawnPool(uint32 pool_id);

    template<typename T>
    void UpdatePool(uint32 pool_id, uint32 db_guid_or_pool_id);

    void ChangeDailyQuests();
    void ChangeWeeklyQuests();

    PooledQuestRelation mQuestCreatureRelation;
    PooledQuestRelation mQuestGORelation;

private:
    template<typename T>
    void SpawnPool(uint32 pool_id, uint32 db_guid_or_pool_id);

    typedef std::unordered_map<uint32, PoolTemplateData>      PoolTemplateDataMap;
    typedef std::unordered_map<uint32, PoolGroup<Creature>>   PoolGroupCreatureMap;
    typedef std::unordered_map<uint32, PoolGroup<GameObject>> PoolGroupGameObjectMap;
    typedef std::unordered_map<uint32, PoolGroup<Pool>>       PoolGroupPoolMap;
    typedef std::unordered_map<uint32, PoolGroup<Quest>>      PoolGroupQuestMap;
    typedef std::pair<uint32, uint32>           SearchPair;
    typedef std::map<uint32, uint32>            SearchMap;

    PoolTemplateDataMap    mPoolTemplate;
    PoolGroupCreatureMap   mPoolCreatureGroups;
    PoolGroupGameObjectMap mPoolGameobjectGroups;
    PoolGroupPoolMap       mPoolPoolGroups;
    PoolGroupQuestMap      mPoolQuestGroups;
    SearchMap mCreatureSearchMap;
    SearchMap mGameobjectSearchMap;
    SearchMap mPoolSearchMap;
    SearchMap mQuestSearchMap;

    // dynamic data
    ActivePoolData mSpawnedData;
};

#define sPoolMgr PoolMgr::instance()

// Method that tell if the creature is part of a pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Creature>(uint32 db_guid) const
{
    SearchMap::const_iterator itr = mCreatureSearchMap.find(db_guid);
    if (itr != mCreatureSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the gameobject is part of a pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<GameObject>(uint32 db_guid) const
{
    SearchMap::const_iterator itr = mGameobjectSearchMap.find(db_guid);
    if (itr != mGameobjectSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the quest is part of another pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Quest>(uint32 questId) const
{
    SearchMap::const_iterator itr = mQuestSearchMap.find(questId);
    if (itr != mQuestSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the pool is part of another pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Pool>(uint32 pool_id) const
{
    SearchMap::const_iterator itr = mPoolSearchMap.find(pool_id);
    if (itr != mPoolSearchMap.end())
        return itr->second;

    return 0;
}

#endif
