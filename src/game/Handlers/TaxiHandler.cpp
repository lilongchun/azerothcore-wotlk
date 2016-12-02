/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "UpdateMask.h"
#include "WaypointMovementGenerator.h"

void WorldSession::HandleTaxiNodeStatusQueryOpcode(WorldPacket & recvData)
{
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_TAXINODE_STATUS_QUERY");

    uint64 guid;

    recvData >> guid;
    SendTaxiStatus(guid);
}

void WorldSession::SendTaxiStatus(uint64 guid)
{
    // cheating checks
    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
    {
        ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WorldSession::SendTaxiStatus - Unit (GUID: %u) not found.", uint32(GUID_LOPART(guid)));
        return;
    }

    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId(), 0);

    // not found nearest
    if (curloc == 0)
        return;

    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: current location %u ", curloc);

    WorldPacket data(SMSG_TAXINODE_STATUS, 9);
    data << guid;
    data << uint8(GetPlayer()->m_taxi.IsTaximaskNodeKnown(curloc) ? 1 : 0);
    SendPacket(&data);
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_TAXINODE_STATUS");
}

void WorldSession::HandleTaxiQueryAvailableNodes(WorldPacket & recvData)
{
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_TAXIQUERYAVAILABLENODES");

    uint64 guid;
    recvData >> guid;

    // cheating checks
    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!unit)
    {
        ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: HandleTaxiQueryAvailableNodes - Unit (GUID: %u) not found or you can't interact with him.", uint32(GUID_LOPART(guid)));
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // unknown taxi node case
    if (SendLearnNewTaxiNode(unit))
        return;

    // known taxi node case
    SendTaxiMenu(unit);
}

void WorldSession::SendTaxiMenu(Creature* unit)
{
    // find current node
    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId(), 0);

    if (curloc == 0)
        return;

    bool lastTaxiCheaterState = GetPlayer()->isTaxiCheater();
    if (unit->GetEntry() == 29480) GetPlayer()->SetTaxiCheater(true); // Grimwing in Ebon Hold, special case. NOTE: Not perfect, Zul'Aman should not be included according to WoWhead, and I think taxicheat includes it.

    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_TAXINODE_STATUS_QUERY %u ", curloc);

    WorldPacket data(SMSG_SHOWTAXINODES, (4 + 8 + 4 + 8 * 4));
    data << uint32(1);
    data << uint64(unit->GetGUID());
    data << uint32(curloc);
    GetPlayer()->m_taxi.AppendTaximaskTo(data, GetPlayer()->isTaxiCheater());
    SendPacket(&data);

    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_SHOWTAXINODES");

    GetPlayer()->SetTaxiCheater(lastTaxiCheaterState);
}

void WorldSession::SendDoFlight(uint32 mountDisplayId, uint32 path, uint32 pathNode)
{
    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    while (GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
        GetPlayer()->GetMotionMaster()->MovementExpired(false);

    if (mountDisplayId)
        GetPlayer()->Mount(mountDisplayId);

    GetPlayer()->GetMotionMaster()->MoveTaxiFlight(path, pathNode);
}

bool WorldSession::SendLearnNewTaxiNode(Creature* unit)
{
    // find current node
    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId(), 0);

    if (curloc == 0)
        return true;                                        // `true` send to avoid WorldSession::SendTaxiMenu call with one more curlock seartch with same false result.

    if (GetPlayer()->m_taxi.SetTaximaskNode(curloc))
    {
        WorldPacket msg(SMSG_NEW_TAXI_PATH, 0);
        SendPacket(&msg);

        WorldPacket update(SMSG_TAXINODE_STATUS, 9);
        update << uint64(unit->GetGUID());
        update << uint8(1);
        SendPacket(&update);

        return true;
    }
    else
        return false;
}

void WorldSession::SendDiscoverNewTaxiNode(uint32 nodeid)
{
    if (GetPlayer()->m_taxi.SetTaximaskNode(nodeid))
    {
        WorldPacket msg(SMSG_NEW_TAXI_PATH, 0);
        SendPacket(&msg);
    }
}

void WorldSession::HandleActivateTaxiExpressOpcode (WorldPacket & recvData)
{
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_ACTIVATETAXIEXPRESS");

    uint64 guid;
    uint32 node_count;

    recvData >> guid >> node_count;

    Creature* npc = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!npc)
    {
        ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: HandleActivateTaxiExpressOpcode - Unit (GUID: %u) not found or you can't interact with it.", uint32(GUID_LOPART(guid)));
        return;
    }
    std::vector<uint32> nodes;

    for (uint32 i = 0; i < node_count; ++i)
    {
        uint32 node;
        recvData >> node;

        if (!GetPlayer()->m_taxi.IsTaximaskNodeKnown(node) && !GetPlayer()->isTaxiCheater())
        {
            SendActivateTaxiReply(ERR_TAXINOTVISITED);
            recvData.rfinish();
            return;
        }

        nodes.push_back(node);
    }

    if (nodes.empty())
        return;

    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_ACTIVATETAXIEXPRESS from %d to %d", nodes.front(), nodes.back());

    GetPlayer()->ActivateTaxiPathTo(nodes, npc, 0);
}

void WorldSession::HandleMoveSplineDoneOpcode(WorldPacket& recvData)
{
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_MOVE_SPLINE_DONE");

    uint64 guid; // used only for proper packet read
    recvData.readPackGUID(guid);

    // movement anticheat code
    const Unit *mover = _player->m_mover;
    const Player *plMover = mover->GetTypeId() == TYPEID_PLAYER ? (Player*)mover : NULL;
    if (!plMover)
        return;
    // end movement anticheat

    MovementInfo movementInfo;                              // used only for proper packet read
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData.read_skip<uint32>();                          // spline id
                                                           // in taxi flight packet received in 2 case:
                                                           // 1) end taxi path in far (multi-node) flight
                                                           // 2) switch from one map to other in case multim-map taxi path
                                                           // we need process only (1)

    uint32 curDest = GetPlayer()->m_taxi.GetTaxiDestination();
    if (curDest)
    {
        const uint64 cServerTime = getMSTime();
        uint32 cServerTimeDelta = 0;
        if (GetPlayer()->m_anti_LastServerTime != 0)
        {
            cServerTimeDelta = cServerTime - GetPlayer()->m_anti_LastServerTime;
            GetPlayer()->m_anti_DeltaServerTime += cServerTimeDelta;
            GetPlayer()->m_anti_LastServerTime = cServerTime;
        }
        else
            GetPlayer()->m_anti_LastServerTime = cServerTime;

        const uint32 curloc =
        sObjectMgr->GetNearestTaxiNode(movementInfo.pos.GetPositionX(),movementInfo.pos.GetPositionY(),movementInfo.pos.GetPositionZ(),GetPlayer()->GetMapId(),GetPlayer()->GetTeamId(), curDest);
        // end movement anticheat

        // sLog.outBasic("AC2-%s > | xyzo: %f,%f,%fo(%f) flags[%X] | curloc: %d | destloc: %d ",
        // GetPlayer()->GetName(), movementInfo.x, movementInfo.y, movementInfo.z, movementInfo.o,
        // movementInfo.flags, curloc, curDest);
         TaxiNodesEntry const* curDestNode = sTaxiNodesStore.LookupEntry(curDest);
        if (curDestNode && curDestNode->map_id == GetPlayer()->GetMapId())
            while (GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
                GetPlayer()->GetMotionMaster()->MovementExpired(false);

        // movement anticheat code
        GetPlayer()->UpdatePosition(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY(), movementInfo.pos.GetPositionZ(), movementInfo.pos.GetOrientation());
        GetPlayer()->m_movementInfo = movementInfo;
        GetPlayer()->SetUnitMovementFlags(movementInfo.flags);
        // calc time deltas
        int32 cClientTimeDelta = 0;
        if (GetPlayer()->m_anti_LastClientTime != 0)
        {
            cClientTimeDelta = movementInfo.time - GetPlayer()->m_anti_LastClientTime;
            GetPlayer()->m_anti_DeltaClientTime += cClientTimeDelta;
            GetPlayer()->m_anti_LastClientTime = movementInfo.time;
        }
        else
            GetPlayer()->m_anti_LastClientTime = movementInfo.time;
 
        // end movement anticheat
        // movement anticheat fix - disallow unmount from taxi
        if (curloc != curDest)
        {
             // current source node for next destination
            uint32 sourcenode = GetPlayer()->m_taxi.GetTaxiSource();
            uint16 MountId = sObjectMgr->GetTaxiMountDisplayId(sourcenode, GetPlayer()->GetTeamId());
            uint32 path, cost;
            sObjectMgr->GetTaxiPath(sourcenode, curDest, path, cost);

            if (path && MountId)
                SendDoFlight(MountId, path, 1);                 // skip start fly node
            else
                GetPlayer()->m_taxi.ClearTaxiDestinations();    // clear problematic path and next
            return;
        }
        // end movement anticheat

        // far teleport case
        if (curDestNode && curDestNode->map_id != GetPlayer()->GetMapId())
        {
            if (GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
            {
                // short preparations to continue flight
                FlightPathMovementGenerator* flight = (FlightPathMovementGenerator*)(GetPlayer()->GetMotionMaster()->top());

                flight->SetCurrentNodeAfterTeleport();
                TaxiPathNodeEntry const* node = flight->GetPath()[flight->GetCurrentNode()];
                flight->SkipCurrentNode();

                GetPlayer()->TeleportTo(curDestNode->map_id, node->x, node->y, node->z, GetPlayer()->GetOrientation());
            }
        }

        return;
    }

    // at this point only 1 node is expected (final destination)
    if (GetPlayer()->m_taxi.GetPath().size() != 1)
        return;

    GetPlayer()->CleanupAfterTaxiFlight();
    GetPlayer()->SetFallInformation(0, GetPlayer()->GetPositionZ());
    if (GetPlayer()->pvpInfo.IsHostile)
        GetPlayer()->CastSpell(GetPlayer(), 2479, true);
}

void WorldSession::HandleActivateTaxiOpcode(WorldPacket & recvData)
{
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_ACTIVATETAXI");

    uint64 guid;
    std::vector<uint32> nodes;
    nodes.resize(2);

    recvData >> guid >> nodes[0] >> nodes[1];
    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_ACTIVATETAXI from %d to %d", nodes[0], nodes[1]);
    Creature* npc = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!npc)
    {
        ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: HandleActivateTaxiOpcode - Unit (GUID: %u) not found or you can't interact with it.", uint32(GUID_LOPART(guid)));
        return;
    }

    if (!GetPlayer()->isTaxiCheater())
    {
        if (!GetPlayer()->m_taxi.IsTaximaskNodeKnown(nodes[0]) || !GetPlayer()->m_taxi.IsTaximaskNodeKnown(nodes[1]))
        {
            SendActivateTaxiReply(ERR_TAXINOTVISITED);
            return;
        }
    }

    GetPlayer()->ActivateTaxiPathTo(nodes, npc, 0);
}

void WorldSession::SendActivateTaxiReply(ActivateTaxiReply reply)
{
    WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
    data << uint32(reply);
    SendPacket(&data);

    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_ACTIVATETAXIREPLY");
}
