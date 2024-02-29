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

#include "Chat.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "hyjal.h"

/* Battle of Mount Hyjal encounters:
0 - Rage Winterchill event
1 - Anetheron event
2 - Kaz'rogal event
3 - Azgalor event
4 - Archimonde event
*/

DoorData const doorData[] =
{
    { GO_HORDE_ENCAMPMENT_PORTAL,  DATA_ALLIANCE_RETREAT, DOOR_TYPE_PASSAGE },
    { GO_NIGHT_ELF_VILLAGE_PORTAL, DATA_HORDE_RETREAT,    DOOR_TYPE_PASSAGE }
};

ObjectData const creatureData[] =
{
    { NPC_WINTERCHILL, DATA_WINTERCHILL },
    { NPC_ANETHERON,   DATA_ANETHERON   },
    { NPC_KAZROGAL,    DATA_KAZROGAL    },
    { NPC_AZGALOR,     DATA_AZGALOR     },
    { NPC_ARCHIMONDE,  DATA_ARCHIMONDE  },
    { NPC_THRALL,      DATA_THRALL      },
    { NPC_JAINA,       DATA_JAINA       },
    { NPC_TYRANDE,     DATA_TYRANDE     },
    { 0,               0                }
};

ObjectData const objectData[] =
{
    { 0, 0 }
};

Milliseconds hyjalWaveTimers[4][MAX_WAVES_STANDARD]
{
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Winterchill
    { 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 130000ms, 190000ms, 0ms },    // Anetheron
    { 130000ms, 155000ms, 130000ms, 155000ms, 130000ms, 130000ms, 155000ms, 225000ms, 0ms },    // Kaz'rogal
    { 130000ms, 190000ms, 190000ms, 190000ms, 130000ms, 155000ms, 190000ms, 225000ms, 0ms }     // Azgalor
};

Milliseconds hyjalRetreatTimers[2][MAX_WAVES_RETREAT]
{
    { 10000ms, 6000ms , 0ms },   // Alliance
    { 10000ms, 40000ms, 0ms }    // Horde
};

Milliseconds hyjalNightElfWaveTimers[1][MAX_WAVES_NIGHT_ELF]
{
    { 0ms }
};

class instance_hyjal : public InstanceMapScript
{
public:
    instance_hyjal() : InstanceMapScript("instance_hyjal", 534) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mount_hyjal_InstanceMapScript(map);
    }

    struct instance_mount_hyjal_InstanceMapScript : public InstanceScript
    {
        instance_mount_hyjal_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, objectData);
        }

        void Initialize() override
        {
            SetHeaders(DataHeader);

            _bossWave = false;
            trash = 0;
            _currentWave = 0;
            _encounterNPCs.clear();
            _baseAlliance.clear();
            _baseHorde.clear();
            _infernalTargets.clear();
            _baseNightElf.clear();
            _roaringFlameAlliance.clear();
            _roaringFlameHorde.clear();
            _ancientGemAlliance.clear();
            _ancientGemHorde.clear();
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_ANCIENT_GEM:
                    if (go->GetPositionY() > -2500.f)
                        _ancientGemAlliance.insert(go->GetGUID());
                    else
                        _ancientGemHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
                case GO_FLAME:
                    if (go->GetPositionX() < 5360.f)
                        _roaringFlameAlliance.insert(go->GetGUID());
                    else
                        _roaringFlameHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
            }
            InstanceScript::OnGameObjectCreate(go);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                    // Alliance base
                case NPC_ALLIANCE_PEASANT:
                case NPC_ALLIANCE_KNIGHT:
                case NPC_ALLIANCE_FOOTMAN:
                case NPC_ALLIANCE_RIFLEMAN:
                case NPC_ALLIANCE_PRIEST:
                case NPC_ALLIANCE_SORCERESS:
                case NPC_JAINA:
                    _baseAlliance.insert(creature->GetGUID());
                    break;
                    // Horde base
                case NPC_HORDE_HEADHUNTER:
                case NPC_HORDE_SHAMAN:
                case NPC_HORDE_GRUNT:
                case NPC_HORDE_HEALING_WARD:
                case NPC_TAUREN_WARRIOR:
                case NPC_HORDE_WITCH_DOCTOR:
                case NPC_HORDE_PEON:
                case NPC_THRALL:
                    _baseHorde.insert(creature->GetGUID());
                    break;
                    // Elf base
                case NPC_DRUID_OF_THE_TALON:
                case NPC_DRUID_OF_THE_CLAW:
                case NPC_NELF_ANCIENT_PROT:
                case NPC_NELF_ANCIENT_OF_LORE:
                case NPC_NELF_ANCIENT_OF_WAR:
                case NPC_NELF_ARCHER:
                case NPC_NELF_HUNTRESS:
                case NPC_DRYAD:
                case NPC_TYRANDE:
                    _baseNightElf.insert(creature->GetGUID());
                    break;

                case NPC_INFERNAL_TARGET:
                    _infernalTargets.insert(creature->GetGUID());
                    break;

                case NPC_WINTERCHILL:
                case NPC_ANETHERON:
                case NPC_KAZROGAL:
                case NPC_AZGALOR:
                /*
                {
                    switch (creature->GetEntry())
                    {
                    case NPC_WINTERCHILL: SetData(DATA_WINTERCHILL, IN_PROGRESS); break;
                    case NPC_ANETHERON: SetData(DATA_ANETHERON, IN_PROGRESS); break;
                    case NPC_KAZROGAL: SetData(DATA_KAZROGAL, IN_PROGRESS); break;
                    case NPC_AZGALOR: SetData(DATA_AZGALOR, IN_PROGRESS); break;
                    }
                    // no break
                }
                */
                case NPC_NECRO:
                case NPC_ABOMI:
                case NPC_GHOUL:
                case NPC_BANSH:
                case NPC_CRYPT:
                case NPC_GARGO:
                case NPC_FROST:
                case NPC_INFER:
                case NPC_STALK:
                    if (creature->IsSummon())
                    {
                        if (_bossWave)
                        {
                            DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, ++trash);    // Update the instance wave count on new trash spawn
                            DoUpdateWorldState(WORLD_STATE_ENEMY, trash);
                            _encounterNPCs.insert(creature->GetGUID());             // Used for despawning on wipe
                        }
                    }
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            InstanceScript::OnUnitDeath(unit);

            switch (unit->ToCreature()->GetEntry())
            {
            case NPC_NECRO:
            case NPC_ABOMI:
            case NPC_GHOUL:
            case NPC_BANSH:
            case NPC_CRYPT:
            case NPC_GARGO:
            case NPC_FROST:
            case NPC_INFER:
            case NPC_STALK:
                if (unit->ToCreature()->IsSummon())
                {
                    if (_bossWave)
                    {
                        DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, --trash);    // Update the instance wave count on new trash death
                        DoUpdateWorldState(WORLD_STATE_ENEMY, trash);
                        _encounterNPCs.erase(unit->ToCreature()->GetGUID());    // Used for despawning on wipe

                        if (trash == 0) // It can reach negatives if Overrun trash are killed, it shouldn't affect anything
                            SetData(DATA_SPAWN_WAVES, 1);
                    }
                }
                break;
            case NPC_WINTERCHILL:
            case NPC_ANETHERON:
            case NPC_KAZROGAL:
            case NPC_AZGALOR:
                if (Creature* jaina = GetCreature(DATA_JAINA))
                    jaina->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                if (Creature* thrall = GetCreature(DATA_THRALL))
                    thrall->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                SetData(DATA_RESET_WAVES, 1);
                break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_ALLIANCE_RETREAT:
                    _bossWave = false;
                    // Spawn Ancient Gems
                    for (ObjectGuid const& guid : _ancientGemAlliance)
                        instance->GetGameObject(guid)->Respawn();

                    // Move all alliance NPCs near Jaina (only happens in this base, not Horde's)
                    if (Creature* jaina = GetCreature(DATA_JAINA))
                    {
                        for (ObjectGuid const& guid : _baseAlliance)
                        {
                            if (instance->GetCreature(guid));
                            {
                                float x, y, z;
                                jaina->GetNearPoint(instance->GetCreature(guid), x, y, z, 10.f, 0, instance->GetCreature(guid)->GetAngle(jaina));
                                instance->GetCreature(guid)->SetWalk(true);
                                instance->GetCreature(guid)->GetMotionMaster()->MovePoint(1, x, y, z);
                            }
                        }
                    }

                    // Despawn all alliance NPCs
                    _scheduler.Schedule(11000ms, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : _baseAlliance)
                                instance->GetCreature(guid)->DespawnOrUnsummon();

                            // Spawn Roaring Flame after a delay
                            _scheduler.Schedule(30s, [this](TaskContext)
                                {
                                    for (ObjectGuid const& guid : _roaringFlameAlliance)
                                        instance->GetGameObject(guid)->Respawn();
                                });
                        });

                    // Spawn Overrun waves
                    ScheduleWaves(1ms, START_WAVE_ALLIANCE_RETREAT, MAX_WAVES_RETREAT, hyjalRetreatTimers[0]);

                    SaveToDB();
                    break;
                case DATA_HORDE_RETREAT:
                    _bossWave = false;
                    for (ObjectGuid const& guid : _ancientGemHorde)
                        instance->GetGameObject(guid)->Respawn();

                    _scheduler.Schedule(11000ms, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : _baseHorde)
                                instance->GetCreature(guid)->DespawnOrUnsummon();

                            _scheduler.Schedule(30s, [this](TaskContext)
                                {
                                    for (ObjectGuid const& guid : _roaringFlameHorde)
                                        instance->GetGameObject(guid)->Respawn();
                                });
                        });

                    ScheduleWaves(1ms, START_WAVE_HORDE_RETREAT, MAX_WAVES_RETREAT, hyjalRetreatTimers[1]);

                    SaveToDB();
                    break;
                case DATA_SPAWN_WAVES:
                    _bossWave = true;
                    if (GetBossState(DATA_WINTERCHILL) != DONE)
                        ScheduleWaves(1ms, START_WAVE_WINTERCHILL, MAX_WAVES_STANDARD, hyjalWaveTimers[DATA_WINTERCHILL - 1]);
                    else if (GetBossState(DATA_ANETHERON) != DONE)
                        ScheduleWaves(1ms, START_WAVE_ANETHERON, MAX_WAVES_STANDARD, hyjalWaveTimers[DATA_ANETHERON - 1]);
                    else if (GetBossState(DATA_KAZROGAL) != DONE)
                        ScheduleWaves(1ms, START_WAVE_KAZROGAL, MAX_WAVES_STANDARD, hyjalWaveTimers[DATA_KAZROGAL - 1]);
                    else if (GetBossState(DATA_AZGALOR) != DONE)
                        ScheduleWaves(1ms, START_WAVE_AZGALOR, MAX_WAVES_STANDARD, hyjalWaveTimers[DATA_AZGALOR - 1]);
                    break;
                case DATA_SPAWN_INFERNALS:
                    for (ObjectGuid const& guid : _infernalTargets)
                        if (Creature* infernal = instance->GetCreature(guid))
                            infernal->GetAI()->DoCastSelf(SPELL_INFERNAL);

                    break;
                case DATA_RESET_ALLIANCE:
                    for (ObjectGuid const& guid : _baseAlliance)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    for (ObjectGuid const& guid : _encounterNPCs)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    _scheduler.Schedule(300s, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : _baseAlliance)
                                instance->GetCreature(guid)->Respawn();
                        });

                    SetData(DATA_RESET_WAVES, 0);
                    break;
                case DATA_RESET_HORDE:
                    for (ObjectGuid const& guid : _baseHorde)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    for (ObjectGuid const& guid : _encounterNPCs)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    _scheduler.Schedule(300s, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : _baseHorde)
                                instance->GetCreature(guid)->Respawn();
                        });

                    SetData(DATA_RESET_WAVES, 0);
                    break;
                case DATA_RESET_NIGHT_ELF:
                    for (ObjectGuid const& guid : _baseNightElf)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    for (ObjectGuid const& guid : _encounterNPCs)
                        instance->GetCreature(guid)->DespawnOrUnsummon();

                    GetCreature(DATA_ARCHIMONDE)->DespawnOrUnsummon();

                    _scheduler.Schedule(300s, [this](TaskContext)
                        {
                            for (ObjectGuid const& guid : _baseNightElf)
                                instance->GetCreature(guid)->Respawn();

                            GetCreature(DATA_ARCHIMONDE)->Respawn();
                        });

                    SetData(DATA_RESET_WAVES, 0);
                    break;
                case DATA_RESET_WAVES:
                    _encounterNPCs.clear();
                    _currentWave = 0;
                    trash = 0;
                    _bossWave = false;
                    DoUpdateWorldState(WORLD_STATE_WAVES, _currentWave);
                    DoUpdateWorldState(WORLD_STATE_ENEMY, trash);
                    DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, trash);
                    break;
                case DATA_BOSS_WAVE:
                    data ? _bossWave = true : _bossWave = false;    // Used to check if WorldState will be updated. Set by Jaina and Thrall
                    break;
            }

            // LOG_DEBUG("scripts", "Instance Hyjal: Instance data updated for event {} (Data={})", type, data);

            if (data == DONE)
            {
                SaveToDB();
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
            case DATA_WAVE_STATUS:
                return _currentWave;
                break;
            case DATA_BOSS_WAVE:
                return _bossWave;
            }
            return 0;
        }

        void ScheduleWaves(Milliseconds time, uint8 startWaves, uint8 maxWaves, Milliseconds timerptr[])
        {
            // No overlapping!
            _scheduler.CancelGroup(CONTEXT_GROUP_WAVES);

            _scheduler.Schedule(1ms, [this, time, startWaves, maxWaves, timerptr](TaskContext context)
                {
                    // If all waves reached, cancel scheduling new ones
                    if (_currentWave >= maxWaves)
                        return;

                    trash = 0;    // Overrun event trash can modify the counter, so we set it to 0 at the start of every wave. World Update is sent in the first spawn
                    instance->SummonCreatureGroup(startWaves + _currentWave);   // _currentWave should be 0 when this function is first called

                    // Check if it's time to summon Infernals
                    if (GetBossState(DATA_KAZROGAL) == DONE && GetBossState(DATA_AZGALOR) != DONE)
                    {
                        switch (_currentWave + 1)
                        {
                        case 3:
                        case 4:
                        case 7:
                            SetData(DATA_SPAWN_INFERNALS, 1);
                            break;
                        default:
                            break;
                        }
                    }

                    context.Repeat(timerptr[_currentWave]);
                    if (++_currentWave < maxWaves && _bossWave)
                        DoUpdateWorldState(WORLD_STATE_WAVES, _currentWave);

                    context.SetGroup(CONTEXT_GROUP_WAVES);
                });
        }

        void Update(uint32 diff) override
        {
            _scheduler.Update(diff);
        }

    protected:
        bool _bossWave;
        uint32 trash;
        uint8 _currentWave;
        TaskScheduler _scheduler;
        GuidSet _encounterNPCs;
        GuidSet _baseAlliance;
        GuidSet _baseHorde;
        GuidSet _infernalTargets;
        GuidSet _baseNightElf;
        GuidSet _ancientGemAlliance;
        GuidSet _ancientGemHorde;
        GuidSet _roaringFlameAlliance;
        GuidSet _roaringFlameHorde;
    };
};

void AddSC_instance_mount_hyjal()
{
    new instance_hyjal();
}
