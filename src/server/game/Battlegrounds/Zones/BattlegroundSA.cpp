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

#include "BattlegroundSA.h"
#include "GameGraveyard.h"
#include "GameObject.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

BattlegroundSA::BattlegroundSA()
{
    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_SA_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_SA_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_SA_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_SA_HAS_BEGUN;
    BgObjects.resize(BG_SA_MAXOBJ);
    BgCreatures.resize(static_cast<uint16>(BG_SA_MAXNPC) + BG_SA_MAX_GY);
    TimerEnabled = false;
    UpdateWaitTimer = 0;
    SignaledRoundTwo = false;
    SignaledRoundTwoHalfMin = false;
    InitSecondRound = false;
    Attackers = TEAM_ALLIANCE;
    TotalTime = 0s;
    EndRoundTimer = 0s;
    ShipsStarted = false;
    Status = BG_SA_NOTSTARTED;

    for (uint8 i = 0; i < 6; i++)
        GateStatus[i] = BG_SA_GATE_OK;

    for (uint8 i = 0; i < 2; i++)
    {
        RoundScores[i].winner = TEAM_ALLIANCE;
        RoundScores[i].time = 0s;
    }

    //! This is here to prevent an uninitialised variable warning
    //! The warning only occurs when SetUpBattleGround fails though.
    //! In the future this function should be called BEFORE sending initial worldstates.
    memset(&GraveyardStatus, 0, sizeof(GraveyardStatus));
}

BattlegroundSA::~BattlegroundSA()
{
}

void BattlegroundSA::Init()
{
    Battleground::Init();

    TotalTime = 0s;
    Attackers = ((urand(0, 1)) ? TEAM_ALLIANCE : TEAM_HORDE);
    for (uint8 i = 0; i <= 5; i++)
        GateStatus[i] = BG_SA_GATE_OK;
    ShipsStarted = false;
    _notEvenAScratch[TEAM_ALLIANCE] = true;
    _notEvenAScratch[TEAM_HORDE] = true;
    Status = BG_SA_WARMUP;
    _relicClicked = false;
}

bool BattlegroundSA::SetupBattleground()
{
    return ResetObjs();
}

bool BattlegroundSA::ResetObjs()
{
    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        SendTransportsRemove(itr->second);

    uint32 atF = BG_SA_Factions[Attackers];
    uint32 defF = BG_SA_Factions[Attackers ? TEAM_ALLIANCE : TEAM_HORDE];

    for (uint8 i = 0; i < BG_SA_MAXOBJ; i++)
        DelObject(i);

    for (uint8 i = 0; i < BG_SA_MAXNPC; i++)
        DelCreature(i);

    for (uint8 i = BG_SA_MAXNPC; i < static_cast<uint16>(BG_SA_MAXNPC) + BG_SA_MAX_GY; i++)
        DelCreature(i);

    for (uint8 i = 0; i < 6; ++i)
        GateStatus[i] = BG_SA_GATE_OK;

    for (uint8 i = 0; i < BG_SA_BOAT_ONE; i++)
    {
        if (!AddObject(i, BG_SA_ObjEntries[i], BG_SA_ObjSpawnlocs[i][0], BG_SA_ObjSpawnlocs[i][1], BG_SA_ObjSpawnlocs[i][2], BG_SA_ObjSpawnlocs[i][3], 0, 0, 0, 0, RESPAWN_ONE_DAY))
            return false;
    }

    for (uint8 i = BG_SA_BOAT_ONE; i < BG_SA_SIGIL_1; i++)
    {
        uint32 boatid = 0;
        switch (i)
        {
            case BG_SA_BOAT_ONE:
                boatid = Attackers ? BG_SA_BOAT_ONE_H : BG_SA_BOAT_ONE_A;
                break;
            case BG_SA_BOAT_TWO:
                boatid = Attackers ? BG_SA_BOAT_TWO_H : BG_SA_BOAT_TWO_A;
                break;
        }
        if (!AddObject(i, boatid, BG_SA_ObjSpawnlocs[i][0],
                       BG_SA_ObjSpawnlocs[i][1],
                       BG_SA_ObjSpawnlocs[i][2] + (Attackers ? -3.750f : 0),
                       BG_SA_ObjSpawnlocs[i][3], 0, 0, 0, 0, RESPAWN_ONE_DAY))
            return false;
    }

    for (uint8 i = BG_SA_SIGIL_1; i < BG_SA_CENTRAL_FLAG; i++)
    {
        if (!AddObject(i, BG_SA_ObjEntries[i],
                       BG_SA_ObjSpawnlocs[i][0], BG_SA_ObjSpawnlocs[i][1],
                       BG_SA_ObjSpawnlocs[i][2], BG_SA_ObjSpawnlocs[i][3],
                       0, 0, 0, 0, RESPAWN_ONE_DAY))
            return false;
    }

    // MAD props for Kiper for discovering those values - 4 hours of his work.
    GetBGObject(BG_SA_BOAT_ONE)->SetTransportPathRotation(0.0f, 0.0f, 1.0f, 0.0002f);
    GetBGObject(BG_SA_BOAT_TWO)->SetTransportPathRotation(0.0f, 0.0f, 1.0f, 0.00001f);
    SpawnBGObject(BG_SA_BOAT_ONE, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_SA_BOAT_TWO, RESPAWN_IMMEDIATELY);

    //Cannons and demolishers - NPCs are spawned
    //By capturing GYs.
    for (uint8 i = 0; i < BG_SA_DEMOLISHER_5; i++)
    {
        if (!AddCreature(BG_SA_NpcEntries[i], i,
                         BG_SA_NpcSpawnlocs[i][0], BG_SA_NpcSpawnlocs[i][1],
                         BG_SA_NpcSpawnlocs[i][2], BG_SA_NpcSpawnlocs[i][3], 600))
            return false;
    }

    OverrideGunFaction();
    DemolisherStartState(true);

    for (uint8 i = BG_SA_GREEN_GATE; i <= BG_SA_TITAN_RELIC; i++)
    {
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
        if (GameObject* go = GetBGObject(i))
        {
            go->setActive(true);
            go->SetUInt32Value(GAMEOBJECT_FACTION, defF);
            go->SetDestructibleBuildingModifyState(false);
        }
    }

    GetBGObject(BG_SA_TITAN_RELIC)->SetUInt32Value(GAMEOBJECT_FACTION, atF);
    GetBGObject(BG_SA_TITAN_RELIC)->Refresh();

    TotalTime = 0s;
    ShipsStarted = false;

    //Graveyards!
    for (uint8 i = 0; i < BG_SA_MAX_GY; i++)
    {
        GraveyardStruct const* sg = nullptr;
        sg = sGraveyard->GetGraveyard(BG_SA_GYEntries[i]);

        if (!sg)
        {
            LOG_ERROR("bg.battleground", "SOTA: Can't find GY entry %u", BG_SA_GYEntries[i]);
            return false;
        }

        if (i == BG_SA_BEACH_GY)
        {
            GraveyardStatus[i] = Attackers;
            AddSpiritGuide(i + BG_SA_MAXNPC, sg->x, sg->y, sg->z, BG_SA_GYOrientation[i], Attackers);
        }
        else
        {
            GraveyardStatus[i] = GetOtherTeamId(Attackers);
            if (!AddSpiritGuide(i + BG_SA_MAXNPC, sg->x, sg->y, sg->z, BG_SA_GYOrientation[i], GetOtherTeamId(Attackers)))
                LOG_ERROR("bg.battleground", "SOTA: couldn't spawn GY: %u", i);
        }
    }

    //GY capture points
    for (uint8 i = BG_SA_CENTRAL_FLAG; i < BG_SA_PORTAL_DEFFENDER_BLUE; i++)
    {
        AddObject(i, (BG_SA_ObjEntries[i] - (Attackers == TEAM_ALLIANCE ? 1 : 0)),
                  BG_SA_ObjSpawnlocs[i][0], BG_SA_ObjSpawnlocs[i][1],
                  BG_SA_ObjSpawnlocs[i][2], BG_SA_ObjSpawnlocs[i][3],
                  0, 0, 0, 0, RESPAWN_ONE_DAY);
        GetBGObject(i)->SetUInt32Value(GAMEOBJECT_FACTION, atF);
    }

    for (uint8 i = BG_SA_PORTAL_DEFFENDER_BLUE; i < BG_SA_BOMB; i++)
    {
        AddObject(i, BG_SA_ObjEntries[i],
                  BG_SA_ObjSpawnlocs[i][0], BG_SA_ObjSpawnlocs[i][1],
                  BG_SA_ObjSpawnlocs[i][2], BG_SA_ObjSpawnlocs[i][3],
                  0, 0, 0, 0, RESPAWN_ONE_DAY);
        GetBGObject(i)->SetUInt32Value(GAMEOBJECT_FACTION, defF);
    }

    UpdateObjectInteractionFlags();

    for (uint8 i = BG_SA_BOMB; i < BG_SA_MAXOBJ; i++)
    {
        AddObject(i, BG_SA_ObjEntries[BG_SA_BOMB],
                  BG_SA_ObjSpawnlocs[i][0], BG_SA_ObjSpawnlocs[i][1],
                  BG_SA_ObjSpawnlocs[i][2], BG_SA_ObjSpawnlocs[i][3],
                  0, 0, 0, 0, RESPAWN_ONE_DAY);
        GetBGObject(i)->SetUInt32Value(GAMEOBJECT_FACTION, atF);
    }

    //Player may enter BEFORE we set up bG - lets update his worldstates anyway...
    UpdateWorldState(BG_SA_RIGHT_GY_HORDE, GraveyardStatus[BG_SA_RIGHT_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);
    UpdateWorldState(BG_SA_LEFT_GY_HORDE, GraveyardStatus[BG_SA_LEFT_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);
    UpdateWorldState(BG_SA_CENTER_GY_HORDE, GraveyardStatus[BG_SA_CENTRAL_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);

    UpdateWorldState(BG_SA_RIGHT_GY_ALLIANCE, GraveyardStatus[BG_SA_RIGHT_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);
    UpdateWorldState(BG_SA_LEFT_GY_ALLIANCE, GraveyardStatus[BG_SA_LEFT_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);
    UpdateWorldState(BG_SA_CENTER_GY_ALLIANCE, GraveyardStatus[BG_SA_CENTRAL_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);

    if (Attackers == TEAM_ALLIANCE)
    {
        UpdateWorldState(BG_SA_ALLY_ATTACKS, 1);
        UpdateWorldState(BG_SA_HORDE_ATTACKS, 0);

        UpdateWorldState(BG_SA_RIGHT_ATT_TOKEN_ALL, 1);
        UpdateWorldState(BG_SA_LEFT_ATT_TOKEN_ALL, 1);
        UpdateWorldState(BG_SA_RIGHT_ATT_TOKEN_HRD, 0);
        UpdateWorldState(BG_SA_LEFT_ATT_TOKEN_HRD, 0);

        UpdateWorldState(BG_SA_HORDE_DEFENCE_TOKEN, 1);
        UpdateWorldState(BG_SA_ALLIANCE_DEFENCE_TOKEN, 0);
    }
    else
    {
        UpdateWorldState(BG_SA_HORDE_ATTACKS, 1);
        UpdateWorldState(BG_SA_ALLY_ATTACKS, 0);

        UpdateWorldState(BG_SA_RIGHT_ATT_TOKEN_ALL, 0);
        UpdateWorldState(BG_SA_LEFT_ATT_TOKEN_ALL, 0);
        UpdateWorldState(BG_SA_RIGHT_ATT_TOKEN_HRD, 1);
        UpdateWorldState(BG_SA_LEFT_ATT_TOKEN_HRD, 1);

        UpdateWorldState(BG_SA_HORDE_DEFENCE_TOKEN, 0);
        UpdateWorldState(BG_SA_ALLIANCE_DEFENCE_TOKEN, 1);
    }

    UpdateWorldState(BG_SA_PURPLE_GATEWS, 1);
    UpdateWorldState(BG_SA_RED_GATEWS, 1);
    UpdateWorldState(BG_SA_BLUE_GATEWS, 1);
    UpdateWorldState(BG_SA_GREEN_GATEWS, 1);
    UpdateWorldState(BG_SA_YELLOW_GATEWS, 1);
    UpdateWorldState(BG_SA_ANCIENT_GATEWS, 1);

    for (int i = BG_SA_BOAT_ONE; i <= BG_SA_BOAT_TWO; i++)
        for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
            SendTransportInit(itr->second);

    // set status manually so preparation is cast correctly in 2nd round too
    SetStatus(STATUS_WAIT_JOIN);

    TeleportPlayers();
    return true;
}

void BattlegroundSA::StartShips()
{
    if (ShipsStarted)
        return;

    DoorOpen(BG_SA_BOAT_ONE);
    DoorOpen(BG_SA_BOAT_TWO);

    for (int i = BG_SA_BOAT_ONE; i <= BG_SA_BOAT_TWO; i++)
    {
        for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        {
            UpdateData data;
            WorldPacket pkt;
            GetBGObject(i)->BuildValuesUpdateBlockForPlayer(&data, itr->second);
            data.BuildPacket(&pkt);
            itr->second->GetSession()->SendPacket(&pkt);
        }
    }
    ShipsStarted = true;
}

void BattlegroundSA::PostUpdateImpl(uint32 diff)
{
    if (InitSecondRound)
    {
        if (UpdateWaitTimer < diff)
        {
            if (!SignaledRoundTwo)
            {
                SignaledRoundTwo = true;
                InitSecondRound = false;
                SendMessageToAll(LANG_BG_SA_ROUND_TWO_ONE_MINUTE, CHAT_MSG_BG_SYSTEM_NEUTRAL);
            }
        }
        else
        {
            UpdateWaitTimer -= diff;
            return;
        }
    }
    TotalTime += Milliseconds(diff);

    if (Status == BG_SA_WARMUP)
    {
        EndRoundTimer = BG_SA_ROUNDLENGTH;
        if (TotalTime >= BG_SA_WARMUPLENGTH)
        {
            TotalTime = 0s;
            ToggleTimer();
            DemolisherStartState(false);
            Status = BG_SA_ROUND_ONE;
            StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, (Attackers == TEAM_ALLIANCE) ? 23748 : 21702);
        }
        if (TotalTime >= BG_SA_BOAT_START)
            StartShips();
        return;
    }
    else if (Status == BG_SA_SECOND_WARMUP)
    {
        if (RoundScores[0].time < BG_SA_ROUNDLENGTH)
            EndRoundTimer = RoundScores[0].time;
        else
            EndRoundTimer = BG_SA_ROUNDLENGTH;

        if (TotalTime >= 1min)
        {
            SendWarningToAll(LANG_BG_SA_HAS_BEGUN);
            TotalTime = 0s;
            ToggleTimer();
            DemolisherStartState(false);
            Status = BG_SA_ROUND_TWO;
            StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, (Attackers == TEAM_ALLIANCE) ? 23748 : 21702);

            // status was set to STATUS_WAIT_JOIN manually for Preparation, set it back now
            SetStatus(STATUS_IN_PROGRESS);
            for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                itr->second->RemoveAurasDueToSpell(SPELL_PREPARATION);
        }
        if (TotalTime >= 30s)
        {
            if (!SignaledRoundTwoHalfMin)
            {
                SignaledRoundTwoHalfMin = true;
                SendMessageToAll(LANG_BG_SA_ROUND_TWO_START_HALF_MINUTE, CHAT_MSG_BG_SYSTEM_NEUTRAL);
            }
        }
        StartShips();
        return;
    }
    else if (GetStatus() == STATUS_IN_PROGRESS)
    {
        if (Status == BG_SA_ROUND_ONE)
        {
            if (TotalTime >= BG_SA_ROUNDLENGTH || _relicClicked)
            {
                if (_relicClicked)
                {
                    RoundScores[0].winner = Attackers;
                    RoundScores[0].time = TotalTime;
                    //Achievement Storm the Beach (1310)
                    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                        if (itr->second->GetTeamId() == Attackers)
                            itr->second->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 65246);
                }
                else
                {
                    // cast this before Attackers variable is switched
                    // cast this spell only upon timer end, no other ability for defenders to win :)
                    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                        itr->second->CastSpell(itr->second, SPELL_SA_END_OF_ROUND, true);

                    RoundScores[0].winner = Attackers;
                    RoundScores[0].time = BG_SA_ROUNDLENGTH;
                }

                _relicClicked = false;
                Attackers = (Attackers == TEAM_ALLIANCE) ? TEAM_HORDE : TEAM_ALLIANCE;
                Status = BG_SA_SECOND_WARMUP;
                TotalTime = 0s;
                ToggleTimer();
                SendWarningToAll(LANG_BG_SA_ROUND_ONE_END);
                UpdateWaitTimer = 5000;
                SignaledRoundTwo = false;
                SignaledRoundTwoHalfMin = false;
                InitSecondRound = true;
                ResetObjs();

                return;
            }
        }
        else if (Status == BG_SA_ROUND_TWO)
        {
            if (TotalTime >= EndRoundTimer)
            {
                // cast this spell only upon timer end, no other ability for defenders to win :)
                for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                    itr->second->CastSpell(itr->second, SPELL_SA_END_OF_ROUND, true);

                RoundScores[1].time = BG_SA_ROUNDLENGTH;
                RoundScores[1].winner = GetOtherTeamId(Attackers);

                if (RoundScores[0].time == RoundScores[1].time)
                    EndBattleground(TEAM_NEUTRAL);
                else if (RoundScores[0].time < RoundScores[1].time)
                    EndBattleground(RoundScores[0].winner);
                else
                    EndBattleground(RoundScores[1].winner);
                return;
            }
        }
        if (Status == BG_SA_ROUND_ONE || Status == BG_SA_ROUND_TWO)
        {
            SendTime();
            UpdateDemolisherSpawns();
        }
    }
}

void BattlegroundSA::StartingEventCloseDoors()
{
}

void BattlegroundSA::StartingEventOpenDoors()
{
}

void BattlegroundSA::FillInitialWorldStates(WorldPacket& data)
{
    uint32 ally_attacks = uint32(Attackers == TEAM_ALLIANCE ? 1 : 0);
    uint32 horde_attacks = uint32(Attackers == TEAM_HORDE ? 1 : 0);

    data << uint32(BG_SA_ANCIENT_GATEWS) << uint32(GateStatus[BG_SA_ANCIENT_GATE]);
    data << uint32(BG_SA_YELLOW_GATEWS) << uint32(GateStatus[BG_SA_YELLOW_GATE]);
    data << uint32(BG_SA_GREEN_GATEWS) << uint32(GateStatus[BG_SA_GREEN_GATE]);
    data << uint32(BG_SA_BLUE_GATEWS) << uint32(GateStatus[BG_SA_BLUE_GATE]);
    data << uint32(BG_SA_RED_GATEWS) << uint32(GateStatus[BG_SA_RED_GATE]);
    data << uint32(BG_SA_PURPLE_GATEWS) << uint32(GateStatus[BG_SA_PURPLE_GATE]);

    data << uint32(BG_SA_BONUS_TIMER) << uint32(0);

    data << uint32(BG_SA_HORDE_ATTACKS) << horde_attacks;
    data << uint32(BG_SA_ALLY_ATTACKS) << ally_attacks;

    //Time will be sent on first update...
    data << uint32(BG_SA_ENABLE_TIMER) << ((TimerEnabled) ? uint32(1) : uint32(0));
    data << uint32(BG_SA_TIMER_MINS) << uint32(0);
    data << uint32(BG_SA_TIMER_SEC_TENS) << uint32(0);
    data << uint32(BG_SA_TIMER_SEC_DECS) << uint32(0);

    data << uint32(BG_SA_RIGHT_GY_HORDE) << uint32(GraveyardStatus[BG_SA_RIGHT_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);
    data << uint32(BG_SA_LEFT_GY_HORDE) << uint32(GraveyardStatus[BG_SA_LEFT_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);
    data << uint32(BG_SA_CENTER_GY_HORDE) << uint32(GraveyardStatus[BG_SA_CENTRAL_CAPTURABLE_GY] == TEAM_HORDE ? 1 : 0);

    data << uint32(BG_SA_RIGHT_GY_ALLIANCE) << uint32(GraveyardStatus[BG_SA_RIGHT_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);
    data << uint32(BG_SA_LEFT_GY_ALLIANCE) << uint32(GraveyardStatus[BG_SA_LEFT_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);
    data << uint32(BG_SA_CENTER_GY_ALLIANCE) << uint32(GraveyardStatus[BG_SA_CENTRAL_CAPTURABLE_GY] == TEAM_ALLIANCE ? 1 : 0);

    data << uint32(BG_SA_HORDE_DEFENCE_TOKEN) << ally_attacks;
    data << uint32(BG_SA_ALLIANCE_DEFENCE_TOKEN) << horde_attacks;

    data << uint32(BG_SA_LEFT_ATT_TOKEN_HRD) << horde_attacks;
    data << uint32(BG_SA_RIGHT_ATT_TOKEN_HRD) << horde_attacks;
    data << uint32(BG_SA_RIGHT_ATT_TOKEN_ALL) <<  ally_attacks;
    data << uint32(BG_SA_LEFT_ATT_TOKEN_ALL) <<  ally_attacks;
}

void BattlegroundSA::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    //create score and add it to map, default values are set in constructor
    BattlegroundSAScore* sc = new BattlegroundSAScore(player);

    SendTransportInit(player);
    PlayerScores[player->GetGUID()] = sc;
    TeleportToEntrancePosition(player);
}

void BattlegroundSA::RemovePlayer(Player* /*player*/)
{
}

void BattlegroundSA::HandleAreaTrigger(Player* /*Source*/, uint32 /*Trigger*/)
{
    // this is wrong way to implement these things. On official it done by gameobject spell cast.
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
}

void BattlegroundSA::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    BattlegroundScoreMap::iterator itr = PlayerScores.find(player->GetGUID());
    if (itr == PlayerScores.end())
        return;

    if (type == SCORE_DESTROYED_DEMOLISHER)
        ((BattlegroundSAScore*)itr->second)->demolishers_destroyed += value;
    else if (type == SCORE_DESTROYED_WALL)
        ((BattlegroundSAScore*)itr->second)->gates_destroyed += value;
    else
        Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
}

void BattlegroundSA::TeleportPlayers()
{
    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
    {
        if (Player* player = itr->second)
        {
            // should remove spirit of redemption
            if (player->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
                player->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

            if (!player->IsAlive())
            {
                player->ResurrectPlayer(1.0f);
                player->SpawnCorpseBones();
            }

            if (Status == BG_SA_SECOND_WARMUP)
            {
                player->CastSpell(player, SPELL_PREPARATION, true);
                player->GetMotionMaster()->MovementExpired();
            }

            player->ResetAllPowers();
            player->CombatStopWithPets(true);

            TeleportToEntrancePosition(player);

            // xinef: one more time, just to be sure
            if (Status == BG_SA_SECOND_WARMUP)
                player->GetMotionMaster()->Clear(false);
        }
    }
}

void BattlegroundSA::TeleportToEntrancePosition(Player* player)
{
    if (player->GetTeamId() != Attackers)
    {
        player->TeleportTo(607, 1209.7f, -65.16f, 70.1f, 0.0f, 0);
    }
    else
    {
        if (!ShipsStarted)
        {
            player->CastSpell(player, 12438, true);//Without this player falls before boat loads...
            if (urand(0, 1))
                player->TeleportTo(607, 2682.936f, -830.368f, 15.0f, 2.895f, 0);
            else
                player->TeleportTo(607, 2577.003f, 980.261f, 15.0f, 0.807f, 0);
        }
        else
            player->TeleportTo(607, 1600.381f, -106.263f, 8.8745f, 3.78f, 0);
    }
}

void BattlegroundSA::DefendersPortalTeleport(GameObject* portal, Player* plr)
{
    if (plr->GetTeamId() == Attackers)
        return;

    uint32 portal_num = 0;
    //get it via X
    switch( (uint32)portal->GetPositionX() )
    {
        case 1394:
            portal_num = 0;
            break;
        case 1065:
            portal_num = 1;
            break;
        case 1468:
            portal_num = 2;
            break;
        case 1255:
            portal_num = 3;
            break;
        case 1216:
            portal_num = 4;
            break;
    }

    plr->TeleportTo( plr->GetMapId(), SOTADefPortalDest[portal_num][0], SOTADefPortalDest[portal_num][1], SOTADefPortalDest[portal_num][2], SOTADefPortalDest[portal_num][3], TELE_TO_SPELL );
}

void BattlegroundSA::EventPlayerDamagedGO(Player* /*player*/, GameObject* go, uint32 eventType)
{
    if (!go || !go->GetGOInfo())
        return;

    if (eventType == go->GetGOInfo()->building.damagedEvent)
    {
        uint32 i = GetGateIDFromEntry(go->GetEntry());
        GateStatus[i] = BG_SA_GATE_DAMAGED;
        uint32 uws = GetWorldStateFromGateID(i);
        if (uws)
            UpdateWorldState(uws, GateStatus[i]);
    }

    if (eventType == go->GetGOInfo()->building.destroyedEvent)
    {
        if (go->GetGOInfo()->building.destroyedEvent == 19837)
            SendWarningToAll(LANG_BG_SA_CHAMBER_BREACHED);
        else
            SendWarningToAll(LANG_BG_SA_WAS_DESTROYED, go->GetGOInfo()->name.c_str());

        uint32 i = GetGateIDFromEntry(go->GetEntry());
        switch (i)
        {
            case BG_SA_BLUE_GATE:
            case BG_SA_GREEN_GATE:
                {
                    if (auto redGate = GetBGObject(BG_SA_RED_GATE))
                    {
                        redGate->SetDestructibleBuildingModifyState(true);
                    }
                    if (auto purpleGate = GetBGObject(BG_SA_PURPLE_GATE))
                    {
                        purpleGate->SetDestructibleBuildingModifyState(true);
                    }
                    break;
                }
            case BG_SA_RED_GATE:
            case BG_SA_PURPLE_GATE:
                if (auto yellowGate = GetBGObject(BG_SA_YELLOW_GATE))
                {
                    yellowGate->SetDestructibleBuildingModifyState(true);
                }
                break;
            case BG_SA_YELLOW_GATE:
                if (auto ancientGate = GetBGObject(BG_SA_ANCIENT_GATE))
                {
                    ancientGate->SetDestructibleBuildingModifyState(true);
                }
                break;
        }
    }

    if (eventType == go->GetGOInfo()->building.damageEvent)
        SendWarningToAll(LANG_BG_SA_IS_UNDER_ATTACK, go->GetGOInfo()->name.c_str());
}

void BattlegroundSA::HandleKillUnit(Creature* creature, Player* killer)
{
    if (creature->GetEntry() == NPC_DEMOLISHER_SA)
    {
        UpdatePlayerScore(killer, SCORE_DESTROYED_DEMOLISHER, 1);
        _notEvenAScratch[Attackers] = false;
        creature->SetVisible(false);
    }
}

/*
  You may ask what the fuck does it do?
  Prevents owner overwriting guns faction with own.
 */
void BattlegroundSA::OverrideGunFaction()
{
    if (!BgCreatures[0])
        return;

    for (uint8 i = BG_SA_GUN_1; i <= BG_SA_GUN_10; i++)
    {
        if (Creature* gun = GetBGCreature(i))
            gun->setFaction(BG_SA_Factions[Attackers ? TEAM_ALLIANCE : TEAM_HORDE]);
    }

    for (uint8 i = BG_SA_DEMOLISHER_1; i <= BG_SA_DEMOLISHER_4; i++)
    {
        if (Creature* dem = GetBGCreature(i))
            dem->setFaction(BG_SA_Factions[Attackers]);
    }
}

void BattlegroundSA::DemolisherStartState(bool start)
{
    if (!BgCreatures[0])
        return;

    for (uint8 i = BG_SA_DEMOLISHER_1; i <= BG_SA_DEMOLISHER_4; i++)
        if (Creature* dem = GetBGCreature(i))
        {
            if (start)
                dem->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            else
                dem->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

    for (uint8 i = BG_SA_GUN_1; i <= BG_SA_GUN_10; i++)
        if (Creature* gun = GetBGCreature(i))
        {
            if (start)
                gun->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            else
                gun->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

    // xinef: enable first gates damaging at start
    if (!start)
    {
        if (GameObject* go = GetBGObject(BG_SA_GREEN_GATE))
            go->SetDestructibleBuildingModifyState(true);
        if (GameObject* go = GetBGObject(BG_SA_BLUE_GATE))
            go->SetDestructibleBuildingModifyState(true);
    }
}

void BattlegroundSA::DestroyGate(Player* player, GameObject* go)
{
    uint32 i = GetGateIDFromEntry(go->GetEntry());
    if (!GateStatus[i])
        return;

    if (GameObject* g = GetBGObject(i))
    {
        if (g->GetGOValue()->Building.Health == 0)
        {
            GateStatus[i] = BG_SA_GATE_DESTROYED;
            if (uint32 uws = GetWorldStateFromGateID(i))
                UpdateWorldState(uws, GateStatus[i]);

            bool rewardHonor = true;
            switch (i)
            {
                case BG_SA_GREEN_GATE:
                    if (GateStatus[BG_SA_BLUE_GATE] == BG_SA_GATE_DESTROYED)
                        rewardHonor = false;
                    break;
                case BG_SA_BLUE_GATE:
                    if (GateStatus[BG_SA_GREEN_GATE] == BG_SA_GATE_DESTROYED)
                        rewardHonor = false;
                    break;
                case BG_SA_RED_GATE:
                    if (GateStatus[BG_SA_PURPLE_GATE] == BG_SA_GATE_DESTROYED)
                        rewardHonor = false;
                    break;
                case BG_SA_PURPLE_GATE:
                    if (GateStatus[BG_SA_RED_GATE] == BG_SA_GATE_DESTROYED)
                        rewardHonor = false;
                    break;
            }

            UpdateObjectInteractionFlags();

            if (i < 5)
                DelObject(i + 9);

            if (player)
            {
                UpdatePlayerScore(player, SCORE_DESTROYED_WALL, 1);
                if (rewardHonor)
                    UpdatePlayerScore(player, SCORE_BONUS_HONOR, GetBonusHonorFromKill(1));
            }
        }
    }
}

GraveyardStruct const* BattlegroundSA::GetClosestGraveyard(Player* player)
{
    GraveyardStruct const* closest = nullptr;
    float mindist = 999999.0f;
    float x, y;

    player->GetPosition(x, y);

    for (uint8 i = BG_SA_BEACH_GY; i < BG_SA_MAX_GY; i++)
    {
        if (GraveyardStatus[i] != player->GetTeamId())
            continue;

        GraveyardStruct const* ret = sGraveyard->GetGraveyard(BG_SA_GYEntries[i]);

        // if on beach
        if (i == BG_SA_BEACH_GY)
        {
            if (x > 1400)
                return ret;
            continue;
        }

        float dist = sqrt(pow(ret->x - x, 2) * pow(ret->y - y, 2));
        if (dist < mindist)
        {
            mindist = dist;
            closest = ret;
        }
    }
    if (!closest && GraveyardStatus[BG_SA_BEACH_GY] == player->GetTeamId())
        return sGraveyard->GetGraveyard(BG_SA_GYEntries[BG_SA_BEACH_GY]);

    return closest;
}

void BattlegroundSA::SendTime()
{
    Milliseconds end_of_round = (EndRoundTimer - TotalTime);
    UpdateWorldState(BG_SA_TIMER_MINS, end_of_round / 1min);
    UpdateWorldState(BG_SA_TIMER_SEC_TENS, (end_of_round % 1min) / 10s);
    UpdateWorldState(BG_SA_TIMER_SEC_DECS, ((end_of_round % 1min) % 10s) / 1s);
}

bool BattlegroundSA::CanInteractWithObject(uint32 objectId)
{
    switch (objectId)
    {
        case BG_SA_TITAN_RELIC:
            if (GateStatus[BG_SA_ANCIENT_GATE] != BG_SA_GATE_DESTROYED || GateStatus[BG_SA_YELLOW_GATE] != BG_SA_GATE_DESTROYED)
            {
                return false;
            }
            [[fallthrough]];
        case BG_SA_CENTRAL_FLAG:
            if (GateStatus[BG_SA_RED_GATE] != BG_SA_GATE_DESTROYED && GateStatus[BG_SA_PURPLE_GATE] != BG_SA_GATE_DESTROYED)
            {
                return false;
            }
            [[fallthrough]];
        case BG_SA_LEFT_FLAG:
        case BG_SA_RIGHT_FLAG:
            if (GateStatus[BG_SA_GREEN_GATE] != BG_SA_GATE_DESTROYED && GateStatus[BG_SA_BLUE_GATE] != BG_SA_GATE_DESTROYED)
            {
                return false;
            }
            break;
        default:
            ABORT();
            break;
    }

    return true;
}

void BattlegroundSA::UpdateObjectInteractionFlags(uint32 objectId)
{
    if (GameObject* go = GetBGObject(objectId))
    {
        if (CanInteractWithObject(objectId))
            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE | GO_FLAG_INTERACT_COND | GO_FLAG_IN_USE);
        else
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    }
}

void BattlegroundSA::UpdateObjectInteractionFlags()
{
    for (uint8 i = BG_SA_CENTRAL_FLAG; i <= BG_SA_LEFT_FLAG; ++i)
        UpdateObjectInteractionFlags(i);
    UpdateObjectInteractionFlags(BG_SA_TITAN_RELIC);
}

void BattlegroundSA::EventPlayerClickedOnFlag(Player* Source, GameObject* gameObject)
{
    switch (gameObject->GetEntry())
    {
        case 191307:
        case 191308:
            if (CanInteractWithObject(BG_SA_LEFT_FLAG))
                CaptureGraveyard(BG_SA_LEFT_CAPTURABLE_GY, Source);
            break;
        case 191305:
        case 191306:
            if (CanInteractWithObject(BG_SA_RIGHT_FLAG))
                CaptureGraveyard(BG_SA_RIGHT_CAPTURABLE_GY, Source);
            break;
        case 191310:
        case 191309:
            if (CanInteractWithObject(BG_SA_CENTRAL_FLAG))
                CaptureGraveyard(BG_SA_CENTRAL_CAPTURABLE_GY, Source);
            break;
        default:
            return;
    }
}

void BattlegroundSA::CaptureGraveyard(BG_SA_Graveyards i, Player* Source)
{
    if (GraveyardStatus[i] == Attackers || Source->GetTeamId() != Attackers)
        return;

    GraveyardStatus[i] = Source->GetTeamId();
    // Those who are waiting to resurrect at this node are taken to the closest own node's graveyard
    GuidVector& ghost_list = m_ReviveQueue[BgCreatures[static_cast<uint16>(BG_SA_MAXNPC) + i]];
    if (!ghost_list.empty())
    {
        GraveyardStruct const* ClosestGrave = nullptr;
        for (ObjectGuid const& guid : ghost_list)
        {
            Player* player = ObjectAccessor::FindPlayer(guid);
            if (!player)
                continue;

            if (!ClosestGrave)                              // cache
                ClosestGrave = GetClosestGraveyard(player);

            if (ClosestGrave)
                player->TeleportTo(GetMapId(), ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, player->GetOrientation());
        }

        // xinef: clear resurrect queue for this creature
        ghost_list.clear();
    }

    DelCreature(static_cast<uint16>(BG_SA_MAXNPC) + i);

    GraveyardStruct const* sg = sGraveyard->GetGraveyard(BG_SA_GYEntries[i]);
    if (!sg)
    {
        LOG_ERROR("bg.battleground", "BattlegroundSA::CaptureGraveyard: non-existant GY entry: %u", BG_SA_GYEntries[i]);
        return;
    }

    AddSpiritGuide(i + static_cast<uint16>(BG_SA_MAXNPC), sg->x, sg->y, sg->z, BG_SA_GYOrientation[i], GraveyardStatus[i]);
    uint32 npc = 0;
    uint32 flag = 0;

    switch(i)
    {
        case BG_SA_LEFT_CAPTURABLE_GY:
            flag = BG_SA_LEFT_FLAG;
            DelObject(flag);
            AddObject(flag, (BG_SA_ObjEntries[flag] - (Source->GetTeamId() == TEAM_ALLIANCE ? 0 : 1)),
                      BG_SA_ObjSpawnlocs[flag][0], BG_SA_ObjSpawnlocs[flag][1],
                      BG_SA_ObjSpawnlocs[flag][2], BG_SA_ObjSpawnlocs[flag][3], 0, 0, 0, 0, RESPAWN_ONE_DAY);

            npc = BG_SA_NPC_RIGSPARK;
            AddCreature(BG_SA_NpcEntries[npc], npc, Attackers,
                        BG_SA_NpcSpawnlocs[npc][0], BG_SA_NpcSpawnlocs[npc][1],
                        BG_SA_NpcSpawnlocs[npc][2], BG_SA_NpcSpawnlocs[npc][3]);

            for (uint8 j = BG_SA_DEMOLISHER_7; j <= BG_SA_DEMOLISHER_8; j++)
            {
                AddCreature(BG_SA_NpcEntries[j], j,
                            BG_SA_NpcSpawnlocs[j][0], BG_SA_NpcSpawnlocs[j][1],
                            BG_SA_NpcSpawnlocs[j][2], BG_SA_NpcSpawnlocs[j][3], 600);

                if (Creature* dem = GetBGCreature(j))
                    dem->setFaction(BG_SA_Factions[Attackers]);
            }

            UpdateWorldState(BG_SA_LEFT_GY_ALLIANCE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 1 : 0));
            UpdateWorldState(BG_SA_LEFT_GY_HORDE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 0 : 1));
            if (Source->GetTeamId() == TEAM_ALLIANCE)
                SendWarningToAll(LANG_BG_SA_A_GY_WEST);
            else
                SendWarningToAll(LANG_BG_SA_H_GY_WEST);
            break;
        case BG_SA_RIGHT_CAPTURABLE_GY:
            flag = BG_SA_RIGHT_FLAG;
            DelObject(flag);
            AddObject(flag, (BG_SA_ObjEntries[flag] - (Source->GetTeamId() == TEAM_ALLIANCE ? 0 : 1)),
                      BG_SA_ObjSpawnlocs[flag][0], BG_SA_ObjSpawnlocs[flag][1],
                      BG_SA_ObjSpawnlocs[flag][2], BG_SA_ObjSpawnlocs[flag][3], 0, 0, 0, 0, RESPAWN_ONE_DAY);

            npc = BG_SA_NPC_SPARKLIGHT;
            AddCreature(BG_SA_NpcEntries[npc], npc,
                        BG_SA_NpcSpawnlocs[npc][0], BG_SA_NpcSpawnlocs[npc][1],
                        BG_SA_NpcSpawnlocs[npc][2], BG_SA_NpcSpawnlocs[npc][3]);

            for (uint8 j = BG_SA_DEMOLISHER_5; j <= BG_SA_DEMOLISHER_6; j++)
            {
                AddCreature(BG_SA_NpcEntries[j], j, BG_SA_NpcSpawnlocs[j][0], BG_SA_NpcSpawnlocs[j][1],
                            BG_SA_NpcSpawnlocs[j][2], BG_SA_NpcSpawnlocs[j][3], 600);

                if (Creature* dem = GetBGCreature(j))
                    dem->setFaction(BG_SA_Factions[Attackers]);
            }

            UpdateWorldState(BG_SA_RIGHT_GY_ALLIANCE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 1 : 0));
            UpdateWorldState(BG_SA_RIGHT_GY_HORDE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 0 : 1));
            if (Source->GetTeamId() == TEAM_ALLIANCE)
                SendWarningToAll(LANG_BG_SA_A_GY_EAST);
            else
                SendWarningToAll(LANG_BG_SA_H_GY_EAST);
            break;
        case BG_SA_CENTRAL_CAPTURABLE_GY:
            flag = BG_SA_CENTRAL_FLAG;
            DelObject(flag);
            AddObject(flag, (BG_SA_ObjEntries[flag] - (Source->GetTeamId() == TEAM_ALLIANCE ? 0 : 1)),
                      BG_SA_ObjSpawnlocs[flag][0], BG_SA_ObjSpawnlocs[flag][1],
                      BG_SA_ObjSpawnlocs[flag][2], BG_SA_ObjSpawnlocs[flag][3], 0, 0, 0, 0, RESPAWN_ONE_DAY);

            UpdateWorldState(BG_SA_CENTER_GY_ALLIANCE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 1 : 0));
            UpdateWorldState(BG_SA_CENTER_GY_HORDE, (GraveyardStatus[i] == TEAM_ALLIANCE ? 0 : 1));
            if (Source->GetTeamId() == TEAM_ALLIANCE)
                SendWarningToAll(LANG_BG_SA_A_GY_SOUTH);
            else
                SendWarningToAll(LANG_BG_SA_H_GY_SOUTH);
            break;
        default:
            ABORT();
            break;
    }
}

void BattlegroundSA::EventPlayerUsedGO(Player* Source, GameObject* object)
{
    if (object->GetEntry() == BG_SA_ObjEntries[BG_SA_TITAN_RELIC] && CanInteractWithObject(BG_SA_TITAN_RELIC))
    {
        if (Source->GetTeamId() == Attackers)
        {
            if (Source->GetTeamId() == TEAM_ALLIANCE)
                SendMessageToAll(LANG_BG_SA_ALLIANCE_CAPTURED_RELIC, CHAT_MSG_BG_SYSTEM_NEUTRAL);
            else SendMessageToAll(LANG_BG_SA_HORDE_CAPTURED_RELIC, CHAT_MSG_BG_SYSTEM_NEUTRAL);

            if (Status == BG_SA_ROUND_ONE)
            {
                _relicClicked = true;
            }
            else if (Status == BG_SA_ROUND_TWO)
            {
                RoundScores[1].winner = Attackers;
                RoundScores[1].time = TotalTime;
                ToggleTimer();
                //Achievement Storm the Beach (1310)
                for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                    if (itr->second->GetTeamId() == Attackers && RoundScores[1].winner == Attackers)
                        itr->second->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 65246);

                if (RoundScores[0].time == RoundScores[1].time)
                    EndBattleground(TEAM_NEUTRAL);
                else if (RoundScores[0].time < RoundScores[1].time)
                    EndBattleground(RoundScores[0].winner);
                else
                    EndBattleground(RoundScores[1].winner);
            }
        }
    }
}

void BattlegroundSA::ToggleTimer()
{
    TimerEnabled = !TimerEnabled;
    UpdateWorldState(BG_SA_ENABLE_TIMER, (TimerEnabled) ? 1 : 0);
}

void BattlegroundSA::EndBattleground(TeamId winnerTeamId)
{
    //honor reward for winning
    RewardHonorToTeam(GetBonusHonorFromKill(1), winnerTeamId);

    //complete map_end rewards (even if no team wins)
    RewardHonorToTeam(GetBonusHonorFromKill(2), TEAM_ALLIANCE);
    RewardHonorToTeam(GetBonusHonorFromKill(2), TEAM_HORDE);

    Battleground::EndBattleground(winnerTeamId);
}

void BattlegroundSA::UpdateDemolisherSpawns()
{
    for (uint8 i = BG_SA_DEMOLISHER_1; i <= BG_SA_DEMOLISHER_8; i++)
    {
        if (BgCreatures[i])
        {
            if (Creature* Demolisher = GetBGCreature(i))
            {
                if (Demolisher->isDead())
                {
                    // Demolisher is not in list
                    if (DemoliserRespawnList.find(i) == DemoliserRespawnList.end())
                    {
                        DemoliserRespawnList[i] = World::GetGameTimeMS() + 30000;
                    }
                    else
                    {
                        if (DemoliserRespawnList[i] < World::GetGameTimeMS())
                        {
                            Demolisher->Relocate(BG_SA_NpcSpawnlocs[i][0], BG_SA_NpcSpawnlocs[i][1],
                                                 BG_SA_NpcSpawnlocs[i][2], BG_SA_NpcSpawnlocs[i][3]);

                            Demolisher->SetVisible(true);
                            Demolisher->Respawn();
                            DemoliserRespawnList.erase(i);
                        }
                    }
                }
            }
        }
    }
}

void BattlegroundSA::SendTransportInit(Player* player)
{
    if (BgObjects[BG_SA_BOAT_ONE] ||  BgObjects[BG_SA_BOAT_TWO])
    {
        UpdateData transData;
        if (BgObjects[BG_SA_BOAT_ONE])
            GetBGObject(BG_SA_BOAT_ONE)->BuildCreateUpdateBlockForPlayer(&transData, player);
        if (BgObjects[BG_SA_BOAT_TWO])
            GetBGObject(BG_SA_BOAT_TWO)->BuildCreateUpdateBlockForPlayer(&transData, player);
        WorldPacket packet;
        transData.BuildPacket(&packet);
        player->GetSession()->SendPacket(&packet);
    }
}

void BattlegroundSA::SendTransportsRemove(Player* player)
{
    if (BgObjects[BG_SA_BOAT_ONE] ||  BgObjects[BG_SA_BOAT_TWO])
    {
        UpdateData transData;
        if (BgObjects[BG_SA_BOAT_ONE])
            GetBGObject(BG_SA_BOAT_ONE)->BuildOutOfRangeUpdateBlock(&transData);
        if (BgObjects[BG_SA_BOAT_TWO])
            GetBGObject(BG_SA_BOAT_TWO)->BuildOutOfRangeUpdateBlock(&transData);
        WorldPacket packet;
        transData.BuildPacket(&packet);
        player->GetSession()->SendPacket(&packet);
    }
}

bool BattlegroundSA::AllowDefenseOfTheAncients(Player* source)
{
    if (source->GetTeamId() == Attackers)
        return false;

    for (uint8 i = 0; i <= 5; i++)
    {
        if (GateStatus[i] == BG_SA_GATE_DESTROYED)
            return false;
    }

    return true;
}
