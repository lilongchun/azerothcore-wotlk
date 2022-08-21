/*
    ----
    ---- OUTDOOR PVP - AUTOINVITE v1
    
  
*/

#include "OutdoorPvPAI.h"
#include "OutdoorPvPMgr.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"

OutdoorPvPAI::OutdoorPvPAI()
{
    m_TypeId = OUTDOOR_PVP_AI;
}

bool OutdoorPvPAI::SetupOutdoorPvP()
{
    for (int i = 0; i < OutdoorPvPHPBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPHPBuffZones[i]);

    return true;
}

Group* Battlefield::GetFreeBfRaid(TeamId TeamId)
{
    for (GuidUnorderedSet::const_iterator itr = m_Groups[TeamId].begin(); itr != m_Groups[TeamId].end(); ++itr)
        if (Group* group = sGroupMgr->GetGroupByGUID(itr->GetCounter()))
            if (!group->IsFull())
                return group;

    return nullptr;
}

bool Battlefield::AddOrSetPlayerToCorrectBfGroup(Player* player)
{
    if (!player->IsInWorld())
        return false;

    if (player->GetGroup() && (player->GetGroup()->isBGGroup() || player->GetGroup()->isBFGroup()))
    {
        LOG_INFO("misc", "Battlefield::AddOrSetPlayerToCorrectBfGroup - player is already in {} group!", (player->GetGroup()->isBGGroup() ? "BG" : "BF"));
        return false;
    }

    Group* group = GetFreeBfRaid(player->GetTeamId());
    if (!group)
    {
        group = new Group;
        group->SetBattlefieldGroup(this);
        group->Create(player);
        sGroupMgr->AddGroup(group);
        m_Groups[player->GetTeamId()].insert(group->GetGUID());
    }
    else if (group->IsMember(player->GetGUID()))
    {
        uint8 subgroup = group->GetMemberGroup(player->GetGUID());
        player->SetBattlegroundOrBattlefieldRaid(group, subgroup);
    }
    else
        group->AddMember(player);

    return true;
}

void OutdoorPvPAI::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    if(AddOrSetPlayerToCorrectBfGroup(player))
    {

    }
	OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

Group* Battlefield::GetGroupPlayer(ObjectGuid guid, TeamId TeamId)
{
    for (GuidUnorderedSet::const_iterator itr = m_Groups[TeamId].begin(); itr != m_Groups[TeamId].end(); ++itr)
        if (Group* group = sGroupMgr->GetGroupByGUID(itr->GetCounter()))
            if (group->IsMember(guid))
                return group;

    return nullptr;
}

void OutdoorPvPAI::HandlePlayerLeaveZone(Player* plr, uint32 zone)
{
    if(Group* group = GetGroupPlayer(plr->GetGUID(), plr->GetTeamId()))
    {
        if (!group->RemoveMember(plr->GetGUID()))       
        {
            m_Groups[plr->GetTeamId()].erase(group->GetGUID());
            group->SetBattlegroundGroup(NULL);
        }
    }

    OutdoorPvP::HandlePlayerLeaveZone(plr, zone);
}

class OutdoorPvP_autogroup : public OutdoorPvPScript
{
    public:

        OutdoorPvP_autogroup()
            : OutdoorPvPScript("outdoorpvp_ai")
        {
        }

        OutdoorPvP* GetOutdoorPvP() const
        {
            return new OutdoorPvPAI();
        }
};

void AddSC_outdoorpvp_autogroup()
{
    new OutdoorPvP_autogroup();
}
