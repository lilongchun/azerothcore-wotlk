/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Player.h"
#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "BattlefieldWG.h"
#include "Battleground.h"
#include "BattlegroundAV.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "CharacterDatabaseCleaner.h"
#include "Chat.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "CreatureAI.h"
#include "DatabaseEnv.h"
#include "DisableMgr.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"
#include "Language.h"
#include "LFGMgr.h"
#include "Log.h"
#include "LootItemStorage.h"
#include "MapInstanced.h"
#include "MapManager.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "PetitionMgr.h"
#include "QuestDef.h"
#include "ReputationMgr.h"
#include "SkillDiscovery.h"
#include "SocialMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "Transport.h"
#include "UpdateData.h"
#include "UpdateFieldFlags.h"
#include "UpdateMask.h"
#include "Util.h"
#include "Vehicle.h"
#include "Weather.h"
#include "WeatherMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "ArenaSpectator.h"
#include "GameObjectAI.h"
#include "PoolMgr.h"
#include "SavingSystem.h"
#include "TicketMgr.h"

#define ZONE_UPDATE_INTERVAL (2*IN_MILLISECONDS)

#define PLAYER_SKILL_INDEX(x)       (PLAYER_SKILL_INFO_1_1 + ((x)*3))
#define PLAYER_SKILL_VALUE_INDEX(x) (PLAYER_SKILL_INDEX(x)+1)
#define PLAYER_SKILL_BONUS_INDEX(x) (PLAYER_SKILL_INDEX(x)+2)

#define SKILL_VALUE(x)         PAIR32_LOPART(x)
#define SKILL_MAX(x)           PAIR32_HIPART(x)
#define MAKE_SKILL_VALUE(v, m) MAKE_PAIR32(v, m)

#define SKILL_TEMP_BONUS(x)    int16(PAIR32_LOPART(x))
#define SKILL_PERM_BONUS(x)    int16(PAIR32_HIPART(x))
#define MAKE_SKILL_BONUS(t, p) MAKE_PAIR32(t, p)

enum CharacterFlags
{
	CHARACTER_FLAG_NONE = 0x00000000,
	CHARACTER_FLAG_UNK1 = 0x00000001,
	CHARACTER_FLAG_UNK2 = 0x00000002,
	CHARACTER_LOCKED_FOR_TRANSFER = 0x00000004,
	CHARACTER_FLAG_UNK4 = 0x00000008,
	CHARACTER_FLAG_UNK5 = 0x00000010,
	CHARACTER_FLAG_UNK6 = 0x00000020,
	CHARACTER_FLAG_UNK7 = 0x00000040,
	CHARACTER_FLAG_UNK8 = 0x00000080,
	CHARACTER_FLAG_UNK9 = 0x00000100,
	CHARACTER_FLAG_UNK10 = 0x00000200,
	CHARACTER_FLAG_HIDE_HELM = 0x00000400,
	CHARACTER_FLAG_HIDE_CLOAK = 0x00000800,
	CHARACTER_FLAG_UNK13 = 0x00001000,
	CHARACTER_FLAG_GHOST = 0x00002000,
	CHARACTER_FLAG_RENAME = 0x00004000,
	CHARACTER_FLAG_UNK16 = 0x00008000,
	CHARACTER_FLAG_UNK17 = 0x00010000,
	CHARACTER_FLAG_UNK18 = 0x00020000,
	CHARACTER_FLAG_UNK19 = 0x00040000,
	CHARACTER_FLAG_UNK20 = 0x00080000,
	CHARACTER_FLAG_UNK21 = 0x00100000,
	CHARACTER_FLAG_UNK22 = 0x00200000,
	CHARACTER_FLAG_UNK23 = 0x00400000,
	CHARACTER_FLAG_UNK24 = 0x00800000,
	CHARACTER_FLAG_LOCKED_BY_BILLING = 0x01000000,
	CHARACTER_FLAG_DECLINED = 0x02000000,
	CHARACTER_FLAG_UNK27 = 0x04000000,
	CHARACTER_FLAG_UNK28 = 0x08000000,
	CHARACTER_FLAG_UNK29 = 0x10000000,
	CHARACTER_FLAG_UNK30 = 0x20000000,
	CHARACTER_FLAG_UNK31 = 0x40000000,
	CHARACTER_FLAG_UNK32 = 0x80000000
};

enum CharacterCustomizeFlags
{
	CHAR_CUSTOMIZE_FLAG_NONE = 0x00000000,
	CHAR_CUSTOMIZE_FLAG_CUSTOMIZE = 0x00000001,       // name, gender, etc...
	CHAR_CUSTOMIZE_FLAG_FACTION = 0x00010000,       // name, gender, faction, etc...
	CHAR_CUSTOMIZE_FLAG_RACE = 0x00100000        // name, gender, race, etc...
};

// corpse reclaim times
#define DEATH_EXPIRE_STEP (5*MINUTE)
#define MAX_DEATH_COUNT 3

static uint32 copseReclaimDelay[MAX_DEATH_COUNT] = { 30, 60, 120 };

// == PlayerTaxi ================================================

PlayerTaxi::PlayerTaxi() : _taxiSegment(0)
{
	memset(m_taximask, 0, sizeof(m_taximask));
}

void PlayerTaxi::InitTaxiNodesForLevel(uint32 race, uint32 chrClass, uint8 level)
{
	// class specific initial known nodes
	switch (chrClass)
	{
	case CLASS_DEATH_KNIGHT:
	{
		for (uint8 i = 0; i < TaxiMaskSize; ++i)
			m_taximask[i] |= sOldContinentsNodesMask[i];
		break;
	}
	}

	// race specific initial known nodes: capital and taxi hub masks
	switch (race)
	{
	case RACE_HUMAN:    SetTaximaskNode(2);  break;     // Human
	case RACE_ORC:      SetTaximaskNode(23); break;     // Orc
	case RACE_DWARF:    SetTaximaskNode(6);  break;     // Dwarf
	case RACE_NIGHTELF: SetTaximaskNode(26);
		SetTaximaskNode(27); break;     // Night Elf
	case RACE_UNDEAD_PLAYER: SetTaximaskNode(11); break;// Undead
	case RACE_TAUREN:   SetTaximaskNode(22); break;     // Tauren
	case RACE_GNOME:    SetTaximaskNode(6);  break;     // Gnome
	case RACE_TROLL:    SetTaximaskNode(23); break;     // Troll
	case RACE_BLOODELF: SetTaximaskNode(82); break;     // Blood Elf
	case RACE_DRAENEI:  SetTaximaskNode(94); break;     // Draenei
	}

	// new continent starting masks (It will be accessible only at new map)
	switch (Player::TeamIdForRace(race))
	{
	case TEAM_ALLIANCE: SetTaximaskNode(100); break;
	case TEAM_HORDE:    SetTaximaskNode(99);  break;
	}
	// level dependent taxi hubs
	if (level >= 68)
		SetTaximaskNode(213);                               //Shattered Sun Staging Area
}

void PlayerTaxi::LoadTaxiMask(std::string const& data)
{
	Tokenizer tokens(data, ' ');

	uint8 index;
	Tokenizer::const_iterator iter;
	for (iter = tokens.begin(), index = 0;
		(index < TaxiMaskSize) && (iter != tokens.end()); ++iter, ++index)
	{
		// load and set bits only for existed taxi nodes
		m_taximask[index] = sTaxiNodesMask[index] & uint32(atol(*iter));
	}
}

void PlayerTaxi::AppendTaximaskTo(ByteBuffer& data, bool all)
{
	if (all)
	{
		for (uint8 i = 0; i < TaxiMaskSize; i++)
			data << uint32(sTaxiNodesMask[i]);              // all existed nodes
	}
	else
	{
		for (uint8 i = 0; i < TaxiMaskSize; i++)
			data << uint32(m_taximask[i]);                  // known nodes
	}
}

bool PlayerTaxi::LoadTaxiDestinationsFromString(const std::string& values, TeamId teamId)
{
	ClearTaxiDestinations();

	Tokenizer tokens(values, ' ');

	for (Tokenizer::const_iterator iter = tokens.begin(); iter != tokens.end(); ++iter)
	{
		uint32 node = uint32(atol(*iter));
		AddTaxiDestination(node);
	}

	// Check integrity
	if (m_TaxiDestinations.size() < 3)
		return false;

	// xinef: current segment is saved as last destination in db
	_taxiSegment = m_TaxiDestinations[m_TaxiDestinations.size() - 1];
	m_TaxiDestinations.pop_back();

	for (size_t i = 0; i < m_TaxiDestinations.size() - 1; ++i)
	{
		uint32 cost;
		uint32 path;
		sObjectMgr->GetTaxiPath(m_TaxiDestinations[i], m_TaxiDestinations[i + 1], path, cost);
		if (!path)
			return false;
	}

	// can't load taxi path without mount set (quest taxi path?)
	if (!sObjectMgr->GetTaxiMountDisplayId(GetTaxiSource(), teamId, true))
		return false;

	return true;
}

std::string PlayerTaxi::SaveTaxiDestinationsToString()
{
	if (m_TaxiDestinations.empty())
		return "";

	std::ostringstream ss;

	for (size_t i = 0; i < m_TaxiDestinations.size(); ++i)
		ss << m_TaxiDestinations[i] << ' ';

	ss << _taxiSegment << ' ';
	return ss.str();
}

uint32 PlayerTaxi::GetCurrentTaxiPath() const
{
	if (m_TaxiDestinations.size() < 2 || m_TaxiDestinations.size() <= _taxiSegment + 1)
		return 0;

	uint32 path;
	uint32 cost;

	sObjectMgr->GetTaxiPath(m_TaxiDestinations[_taxiSegment], m_TaxiDestinations[_taxiSegment + 1], path, cost);

	return path;
}

std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi)
{
	for (uint8 i = 0; i < TaxiMaskSize; ++i)
		ss << taxi.m_taximask[i] << ' ';
	return ss;
}

//== TradeData =================================================

TradeData* TradeData::GetTraderData() const
{
	return m_trader->GetTradeData();
}

Item* TradeData::GetItem(TradeSlots slot) const
{
	return m_items[slot] ? m_player->GetItemByGuid(m_items[slot]) : NULL;
}

bool TradeData::HasItem(uint64 itemGuid) const
{
	for (uint8 i = 0; i < TRADE_SLOT_COUNT; ++i)
		if (m_items[i] == itemGuid)
			return true;

	return false;
}

TradeSlots TradeData::GetTradeSlotForItem(uint64 itemGuid) const
{
	for (uint8 i = 0; i < TRADE_SLOT_COUNT; ++i)
		if (m_items[i] == itemGuid)
			return TradeSlots(i);

	return TRADE_SLOT_INVALID;
}

Item* TradeData::GetSpellCastItem() const
{
	return m_spellCastItem ? m_player->GetItemByGuid(m_spellCastItem) : NULL;
}

void TradeData::SetItem(TradeSlots slot, Item* item)
{
	uint64 itemGuid = item ? item->GetGUID() : 0;

	if (m_items[slot] == itemGuid)
		return;

	m_items[slot] = itemGuid;

	SetAccepted(false);
	GetTraderData()->SetAccepted(false);

	Update();

	// need remove possible trader spell applied to changed item
	if (slot == TRADE_SLOT_NONTRADED)
		GetTraderData()->SetSpell(0);

	// need remove possible player spell applied (possible move reagent)
	SetSpell(0);
}

void TradeData::SetSpell(uint32 spell_id, Item* castItem /*= NULL*/)
{
	uint64 itemGuid = castItem ? castItem->GetGUID() : 0;

	if (m_spell == spell_id && m_spellCastItem == itemGuid)
		return;

	m_spell = spell_id;
	m_spellCastItem = itemGuid;

	SetAccepted(false);
	GetTraderData()->SetAccepted(false);

	Update(true);                                           // send spell info to item owner
	Update(false);                                          // send spell info to caster self
}

void TradeData::SetMoney(uint32 money)
{
	if (m_money == money)
		return;

	if (!m_player->HasEnoughMoney(money))
	{
		m_player->GetSession()->SendTradeStatus(TRADE_STATUS_BUSY);
		return;
	}

	m_money = money;

	SetAccepted(false);
	GetTraderData()->SetAccepted(false);

	Update(true);
}

void TradeData::Update(bool forTarget /*= true*/)
{
	if (forTarget)
		m_trader->GetSession()->SendUpdateTrade(true);      // player state for trader
	else
		m_player->GetSession()->SendUpdateTrade(false);     // player state for player
}

void TradeData::SetAccepted(bool state, bool crosssend /*= false*/)
{
	m_accepted = state;

	if (!state)
	{
		if (crosssend)
			m_trader->GetSession()->SendTradeStatus(TRADE_STATUS_BACK_TO_TRADE);
		else
			m_player->GetSession()->SendTradeStatus(TRADE_STATUS_BACK_TO_TRADE);
	}
}

// == KillRewarder ====================================================
// KillRewarder incapsulates logic of rewarding player upon kill with:
// * XP;
// * honor;
// * reputation;
// * kill credit (for quest objectives).
// Rewarding is initiated in two cases: when player kills unit in Unit::Kill()
// and on battlegrounds in Battleground::RewardXPAtKill().
//
// Rewarding algorithm is:
// 1. Initialize internal variables to default values.
// 2. In case when player is in group, initialize variables necessary for group calculations:
// 2.1. _count - number of alive group members within reward distance;
// 2.2. _sumLevel - sum of levels of alive group members within reward distance;
// 2.3. _maxLevel - maximum level of alive group member within reward distance;
// 2.4. _maxNotGrayMember - maximum level of alive group member within reward distance,
//      for whom victim is not gray;
// 2.5. _isFullXP - flag identifying that for all group members victim is not gray,
//      so 100% XP will be rewarded (50% otherwise).
// 3. Reward killer (and group, if necessary).
// 3.1. If killer is in group, reward group.
// 3.1.1. Initialize initial XP amount based on maximum level of group member,
//        for whom victim is not gray.
// 3.1.2. Alter group rate if group is in raid (not for battlegrounds).
// 3.1.3. Reward each group member (even dead) within reward distance (see 4. for more details).
// 3.2. Reward single killer (not group case).
// 3.2.1. Initialize initial XP amount based on killer's level.
// 3.2.2. Reward killer (see 4. for more details).
// 4. Reward player.
// 4.1. Give honor (player must be alive and not on BG).
// 4.2. Give XP.
// 4.2.1. If player is in group, adjust XP:
//        * set to 0 if player's level is more than maximum level of not gray member;
//        * cut XP in half if _isFullXP is false.
// 4.2.2. Apply auras modifying rewarded XP.
// 4.2.3. Give XP to player.
// 4.2.4. If player has pet, reward pet with XP (100% for single player, 50% for group case).
// 4.3. Give reputation (player must not be on BG).
// 4.4. Give kill credit (player must not be in group, or he must be alive or without corpse).
// 5. Credit instance encounter.
KillRewarder::KillRewarder(Player* killer, Unit* victim, bool isBattleGround) :
	// 1. Initialize internal variables to default values.
	_killer(killer), _victim(victim), _group(killer->GetGroup()),
	_groupRate(1.0f), _maxNotGrayMember(NULL), _count(0), _sumLevel(0), _xp(0),
	_isFullXP(false), _maxLevel(0), _isBattleGround(isBattleGround), _isPvP(false)
{
	// mark the credit as pvp if victim is player
	if (victim->GetTypeId() == TYPEID_PLAYER)
		_isPvP = true;
	// or if its owned by player and its not a vehicle
	else if (IS_PLAYER_GUID(victim->GetCharmerOrOwnerGUID()))
		_isPvP = !victim->IsVehicle();

	_InitGroupData();
}

inline void KillRewarder::_InitGroupData()
{
	if (_group)
	{
		// 2. In case when player is in group, initialize variables necessary for group calculations:
		for (GroupReference* itr = _group->GetFirstMember(); itr != NULL; itr = itr->next())
			if (Player* member = itr->GetSource())
				if ((_killer == member || member->IsAtGroupRewardDistance(_victim)) && member->IsAlive())
				{
					const uint8 lvl = member->getLevel();
					// 2.1. _count - number of alive group members within reward distance;
					++_count;
					// 2.2. _sumLevel - sum of levels of alive group members within reward distance;
					_sumLevel += lvl;
					// 2.3. _maxLevel - maximum level of alive group member within reward distance;
					if (_maxLevel < lvl)
						_maxLevel = lvl;
					// 2.4. _maxNotGrayMember - maximum level of alive group member within reward distance,
					//      for whom victim is not gray;
					uint32 grayLevel = Trinity::XP::GetGrayLevel(lvl);
					if (_victim->getLevel() > grayLevel && (!_maxNotGrayMember || _maxNotGrayMember->getLevel() < lvl))
						_maxNotGrayMember = member;
				}
		// 2.5. _isFullXP - flag identifying that for all group members victim is not gray,
		//      so 100% XP will be rewarded (50% otherwise).
		_isFullXP = _maxNotGrayMember && (_maxLevel == _maxNotGrayMember->getLevel());
	}
	else
		_count = 1;
}

inline void KillRewarder::_InitXP(Player* player)
{
	// Get initial value of XP for kill.
	// XP is given:
	// * on battlegrounds;
	// * otherwise, not in PvP;
	// * not if killer is on vehicle.
	if (_isBattleGround || (!_isPvP && !_killer->GetVehicle()))
		_xp = Trinity::XP::Gain(player, _victim, _isBattleGround);

	if (_xp && !_isBattleGround && _victim) // pussywizard: npcs with relatively low hp give lower exp
		if (_victim->GetTypeId() == TYPEID_UNIT)
			if (const CreatureTemplate* ct = _victim->ToCreature()->GetCreatureTemplate())
				if (ct->ModHealth <= 0.75f && ct->ModHealth >= 0.0f)
					_xp = uint32(_xp * ct->ModHealth);
}

inline void KillRewarder::_RewardHonor(Player* player)
{
	// Rewarded player must be alive.
	if (player->IsAlive())
		player->RewardHonor(_victim, _count, -1);
}

inline void KillRewarder::_RewardXP(Player* player, float rate)
{
	uint32 xp(_xp);
	if (_group)
	{
		// 4.2.1. If player is in group, adjust XP:
		//        * set to 0 if player's level is more than maximum level of not gray member;
		//        * cut XP in half if _isFullXP is false.
		if (_maxNotGrayMember && player->IsAlive() &&
			_maxNotGrayMember->getLevel() >= player->getLevel())
			xp = _isFullXP ?
			uint32(xp * rate) :             // Reward FULL XP if all group members are not gray.
			uint32(xp * rate / 2) + 1;      // Reward only HALF of XP if some of group members are gray.
		else
			xp = 0;
	}
	if (xp)
	{
		// 4.2.2. Apply auras modifying rewarded XP (SPELL_AURA_MOD_XP_PCT).
		Unit::AuraEffectList const& auras = player->GetAuraEffectsByType(SPELL_AURA_MOD_XP_PCT);
		for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
			AddPct(xp, (*i)->GetAmount());

		// 4.2.3. Give XP to player.
		player->GiveXP(xp, _victim, _groupRate);
		if (Pet* pet = player->GetPet())
			// 4.2.4. If player has pet, reward pet with XP (100% for single player, 50% for group case).
			pet->GivePetXP(_group ? xp / 2 : xp);
	}
}

inline void KillRewarder::_RewardReputation(Player* player, float rate)
{
	// 4.3. Give reputation (player must not be on BG).
	// Even dead players and corpses are rewarded.
	player->RewardReputation(_victim, rate);
}

inline void KillRewarder::_RewardKillCredit(Player* player)
{
	// 4.4. Give kill credit (player must not be in group, or he must be alive or without corpse).
	if (!_group || player->IsAlive() || !player->GetCorpse())
		if (Creature* target = _victim->ToCreature())
		{
			player->KilledMonster(target->GetCreatureTemplate(), target->GetGUID());
			player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE, target->GetCreatureType(), 1, target);
		}
}

void KillRewarder::_RewardPlayer(Player* player, bool isDungeon)
{
	// 4. Reward player.
	if (!_isBattleGround)
	{
		// 4.1. Give honor (player must be alive and not on BG).
		_RewardHonor(player);
		// 4.1.1 Send player killcredit for quests with PlayerSlain
		if (_victim->GetTypeId() == TYPEID_PLAYER)
			player->KilledPlayerCredit();
	}
	// Give XP only in PvE or in battlegrounds.
	// Give reputation and kill credit only in PvE.
	if (!_isPvP || _isBattleGround)
	{
		const float rate = _group ?
			_groupRate * float(player->getLevel()) / _sumLevel : // Group rate depends on summary level.
			1.0f;                                                // Personal rate is 100%.
		if (_xp)
			// 4.2. Give XP.
			_RewardXP(player, rate);
		if (!_isBattleGround)
		{
			// If killer is in dungeon then all members receive full reputation at kill.
			_RewardReputation(player, isDungeon ? 1.0f : rate);
			_RewardKillCredit(player);
		}
	}
}

void KillRewarder::_RewardGroup()
{
	if (_maxLevel)
	{
		if (_maxNotGrayMember)
			// 3.1.1. Initialize initial XP amount based on maximum level of group member,
			//        for whom victim is not gray.
			_InitXP(_maxNotGrayMember);
		// To avoid unnecessary calculations and calls,
		// proceed only if XP is not ZERO or player is not on battleground
		// (battleground rewards only XP, that's why).
		if (!_isBattleGround || _xp)
		{
			const bool isDungeon = !_isPvP && sMapStore.LookupEntry(_killer->GetMapId())->IsDungeon();
			if (!_isBattleGround)
			{
				// 3.1.2. Alter group rate if group is in raid (not for battlegrounds).
				const bool isRaid = !_isPvP && sMapStore.LookupEntry(_killer->GetMapId())->IsRaid() && _group->isRaidGroup();
				_groupRate = Trinity::XP::xp_in_group_rate(_count, isRaid);
			}

			// 3.1.3. Reward each group member (even dead or corpse) within reward distance.
			for (GroupReference* itr = _group->GetFirstMember(); itr != NULL; itr = itr->next())
			{
				if (Player* member = itr->GetSource())
				{
					if (_killer == member || member->IsAtGroupRewardDistance(_victim))
					{
						_RewardPlayer(member, isDungeon);
						// Xinef: only count players
						//if (_victim->GetTypeId() == TYPEID_PLAYER)
						//    member->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL, 1, 0, _victim);
					}
				}
			}
		}
	}
}

void KillRewarder::Reward()
{
	// 3. Reward killer (and group, if necessary).
	if (_group)
		// 3.1. If killer is in group, reward group.
		_RewardGroup();
	else
	{
		// 3.2. Reward single killer (not group case).
		// 3.2.1. Initialize initial XP amount based on killer's level.
		_InitXP(_killer);
		// To avoid unnecessary calculations and calls,
		// proceed only if XP is not ZERO or player is not on battleground
		// (battleground rewards only XP, that's why).
		if (!_isBattleGround || _xp)
			// 3.2.2. Reward killer.
			if (_killer->IsInMap(_victim)) // pussywizard: killer may be on other map (crashfix), when killing in a group same map is required, so its not a problem
				_RewardPlayer(_killer, false);
	}

	// 5. Credit instance encounter.
	if (Creature* victim = _victim->ToCreature())
		if (victim->IsDungeonBoss())
			if (Map* map = _victim->FindMap())
				map->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, _victim->GetEntry(), _victim);
}

// == Player ====================================================

// we can disable this warning for this since it only
// causes undefined behavior when passed to the base class constructor
#ifdef _MSC_VER
#pragma warning(disable:4355)
#endif
Player::Player(WorldSession* session) : Unit(true), m_mover(this)
{
#ifdef _MSC_VER
#pragma warning(default:4355)
#endif

	m_drwGUID = 0;
	m_speakTime = 0;
	m_speakCount = 0;

	m_objectType |= TYPEMASK_PLAYER;
	m_objectTypeId = TYPEID_PLAYER;

	m_valuesCount = PLAYER_END;

	m_session = session;

	m_divider = 0;
	m_ingametime = 0;

	m_ExtraFlags = 0;

	m_spellModTakingSpell = NULL;
	//m_pad = 0;

	// players always accept
	if (AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
		SetAcceptWhispers(true);

	m_lootGuid = 0;

	m_comboTarget = 0;
	m_comboPoints = 0;

	m_usedTalentCount = 0;
	m_questRewardTalentCount = 0;

	m_regenTimer = 0;
	m_regenTimerCount = 0;
	m_weaponChangeTimer = 0;

	m_zoneUpdateId = uint32(-1);
	m_zoneUpdateTimer = 0;

	m_areaUpdateId = 0;
	m_team = TEAM_NEUTRAL;

	m_nextSave = SavingSystemMgr::IncreaseSavingMaxValue(1);
	m_additionalSaveTimer = 0;
	m_additionalSaveMask = 0;
	m_hostileReferenceCheckTimer = 15000;

	clearResurrectRequestData();

	memset(m_items, 0, sizeof(Item*)*PLAYER_SLOTS_COUNT);

	m_social = NULL;

	// group is initialized in the reference constructor
	SetGroupInvite(NULL);
	m_groupUpdateMask = 0;
	m_auraRaidUpdateMask = 0;
	m_bPassOnGroupLoot = false;

	duel = NULL;

	m_GuildIdInvited = 0;
	m_ArenaTeamIdInvited = 0;

	m_atLoginFlags = AT_LOGIN_NONE;

	mSemaphoreTeleport_Near = 0;
	mSemaphoreTeleport_Far = 0;

	m_DelayedOperations = 0;
	m_bMustDelayTeleport = false;
	m_bHasDelayedTeleport = false;
	teleportStore_options = 0;

	m_trade = NULL;

	m_cinematic = 0;

	PlayerTalkClass = new PlayerMenu(GetSession());
	m_currentBuybackSlot = BUYBACK_SLOT_START;

	m_DailyQuestChanged = false;
	m_lastDailyQuestTime = 0;

	for (uint8 i = 0; i < MAX_TIMERS; i++)
		m_MirrorTimer[i] = DISABLED_MIRROR_TIMER;

	m_MirrorTimerFlags = UNDERWATER_NONE;
	m_MirrorTimerFlagsLast = UNDERWATER_NONE;
	m_isInWater = false;
	m_drunkTimer = 0;
	m_deathTimer = 0;
	m_deathExpireTime = 0;

	m_swingErrorMsg = 0;

	for (uint8 j = 0; j < PLAYER_MAX_BATTLEGROUND_QUEUES; ++j)
		m_bgBattlegroundQueueID[j] = BATTLEGROUND_QUEUE_NONE;

	m_logintime = time(NULL);
	m_Last_tick = m_logintime;
	m_Played_time[PLAYED_TIME_TOTAL] = 0;
	m_Played_time[PLAYED_TIME_LEVEL] = 0;
	m_WeaponProficiency = 0;
	m_ArmorProficiency = 0;
	m_canParry = false;
	m_canBlock = false;
	m_canTitanGrip = false;
	m_ammoDPS = 0.0f;

	m_temporaryUnsummonedPetNumber = 0;
	//cache for UNIT_CREATED_BY_SPELL to allow
	//returning reagents for temporarily removed pets
	//when dying/logging out
	m_oldpetspell = 0;
	m_lastpetnumber = 0;

	////////////////////Rest System/////////////////////
	_restTime = 0;
	_innTriggerId = 0;
	_restBonus = 0;
	////////////////////Rest System/////////////////////

	m_mailsLoaded = false;
	m_mailsUpdated = false;
	unReadMails = 0;
	m_nextMailDelivereTime = 0;

	m_resetTalentsCost = 0;
	m_resetTalentsTime = 0;
	m_itemUpdateQueueBlocked = false;

	for (uint8 i = 0; i < MAX_MOVE_TYPE; ++i)
		m_forced_speed_changes[i] = 0;

	m_stableSlots = 0;

	/////////////////// Instance System /////////////////////

	m_HomebindTimer = 0;
	m_InstanceValid = true;
	m_dungeonDifficulty = DUNGEON_DIFFICULTY_NORMAL;
	m_raidDifficulty = RAID_DIFFICULTY_10MAN_NORMAL;
	m_raidMapDifficulty = RAID_DIFFICULTY_10MAN_NORMAL;

	m_lastPotionId = 0;

	m_activeSpec = 0;
	m_specsCount = 1;

	for (uint8 i = 0; i < MAX_TALENT_SPECS; ++i)
	{
		for (uint8 g = 0; g < MAX_GLYPH_SLOT_INDEX; ++g)
			m_Glyphs[i][g] = 0;
	}

	for (uint8 i = 0; i < BASEMOD_END; ++i)
	{
		m_auraBaseMod[i][FLAT_MOD] = 0.0f;
		m_auraBaseMod[i][PCT_MOD] = 1.0f;
	}

	for (uint8 i = 0; i < MAX_COMBAT_RATING; i++)
		m_baseRatingValue[i] = 0;

	m_baseSpellPower = 0;
	m_baseFeralAP = 0;
	m_baseManaRegen = 0;
	m_baseHealthRegen = 0;
	m_spellPenetrationItemMod = 0;

	// Honor System
	m_lastHonorUpdateTime = time(NULL);

	m_IsBGRandomWinner = false;

	// Player summoning
	m_summon_expire = 0;
	m_summon_mapid = 0;
	m_summon_x = 0.0f;
	m_summon_y = 0.0f;
	m_summon_z = 0.0f;
	m_summon_asSpectator = false;

	//m_mover = this;
	m_movedByPlayer.Initialize(this);
	m_seer = this;

	m_recallMap = 0;
	m_recallX = 0;
	m_recallY = 0;
	m_recallZ = 0;
	m_recallO = 0;

	m_homebindMapId = 0;
	m_homebindAreaId = 0;
	m_homebindX = 0;
	m_homebindY = 0;
	m_homebindZ = 0;

	m_contestedPvPTimer = 0;

	m_declinedname = NULL;

	m_isActive = true;

	m_runes = NULL;

	m_lastFallTime = 0;
	m_lastFallZ = 0;

	m_grantableLevels = 0;

	m_ControlledByPlayer = true;

	sWorld->IncreasePlayerCount();

	m_ChampioningFaction = 0;

	m_timeSyncCounter = 0;
	m_timeSyncTimer = 0;
	m_timeSyncClient = 0;
	m_timeSyncServer = 0;

	for (uint8 i = 0; i < MAX_POWERS; ++i)
		m_powerFraction[i] = 0;

	isDebugAreaTriggers = false;

	m_WeeklyQuestChanged = false;

	m_MonthlyQuestChanged = false;

	m_SeasonalQuestChanged = false;

	SetPendingBind(0, 0);

	m_achievementMgr = new AchievementMgr(this);
	m_reputationMgr = new ReputationMgr(this);

	// Ours
	m_NeedToSaveGlyphs = false;
	m_comboPointGain = 0;
	m_MountBlockId = 0;
	m_realDodge = 0.0f;
	m_realParry = 0.0f;
	m_pendingSpectatorForBG = 0;
	m_pendingSpectatorInviteInstanceId = 0;

	m_charmUpdateTimer = 0;

	for (int i = 0; i < NUM_CAI_SPELLS; ++i)
		m_charmAISpells[i] = 0;

	m_applyResilience = true;
}

Player::~Player()
{
	// it must be unloaded already in PlayerLogout and accessed only for loggined player
	//m_social = NULL;

	// Note: buy back item already deleted from DB when player was saved
	for (uint8 i = 0; i < PLAYER_SLOTS_COUNT; ++i)
		delete m_items[i];

	for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
		delete itr->second;

	for (PlayerTalentMap::const_iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
		delete itr->second;

	//all mailed items should be deleted, also all mail should be deallocated
	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
		delete *itr;

	for (ItemMap::iterator iter = mMitems.begin(); iter != mMitems.end(); ++iter)
		delete iter->second;                                //if item is duplicated... then server may crash ... but that item should be deallocated

	delete PlayerTalkClass;

	for (size_t x = 0; x < ItemSetEff.size(); x++)
		delete ItemSetEff[x];

	delete m_declinedname;
	delete m_runes;
	delete m_achievementMgr;
	delete m_reputationMgr;

	sWorld->DecreasePlayerCount();

	if (!m_isInSharedVisionOf.empty())
	{
		sLog->outMisc("Player::~Player (A1)");
		do
		{
			sLog->outMisc("Player::~Player (A2)");
			Unit* u = *(m_isInSharedVisionOf.begin());
			u->RemovePlayerFromVision(this);
		} while (!m_isInSharedVisionOf.empty());
	}
}

void Player::CleanupsBeforeDelete(bool finalCleanup)
{
	TradeCancel(false);
	DuelComplete(DUEL_INTERRUPTED);

	Unit::CleanupsBeforeDelete(finalCleanup);
}

bool Player::Create(uint32 guidlow, CharacterCreateInfo* createInfo)
{
	//FIXME: outfitId not used in player creating
	// TODO: need more checks against packet modifications
	// should check that skin, face, hair* are valid via DBC per race/class
	// also do it in Player::BuildEnumData, Player::LoadFromDB

	Object::_Create(guidlow, 0, HIGHGUID_PLAYER);

	m_name = createInfo->Name;

	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(createInfo->Race, createInfo->Class);
	if (!info)
	{
		sLog->outError("Player::Create: Possible hacking-attempt: Account %u tried creating a character named '%s' with an invalid race/class pair (%u/%u) - refusing to do so.",
			GetSession()->GetAccountId(), m_name.c_str(), createInfo->Race, createInfo->Class);
		return false;
	}

	for (uint8 i = 0; i < PLAYER_SLOTS_COUNT; i++)
		m_items[i] = NULL;

	Relocate(info->positionX, info->positionY, info->positionZ, info->orientation);

	ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(createInfo->Class);
	if (!cEntry)
	{
		sLog->outError("Player::Create: Possible hacking-attempt: Account %u tried creating a character named '%s' with an invalid character class (%u) - refusing to do so (wrong DBC-files?)",
			GetSession()->GetAccountId(), m_name.c_str(), createInfo->Class);
		return false;
	}

	SetMap(sMapMgr->CreateMap(info->mapId, this));

	uint8 powertype = cEntry->powerType;

	SetObjectScale(1.0f);

	m_realRace = createInfo->Race; // set real race flag
	m_race = createInfo->Race; // set real race flag

	setFactionForRace(createInfo->Race);

	if (!IsValidGender(createInfo->Gender))
	{
		sLog->outError("Player::Create: Possible hacking-attempt: Account %u tried creating a character named '%s' with an invalid gender (%hu) - refusing to do so",
			GetSession()->GetAccountId(), m_name.c_str(), createInfo->Gender);
		return false;
	}

	uint32 RaceClassGender = (createInfo->Race) | (createInfo->Class << 8) | (createInfo->Gender << 16);

	SetUInt32Value(UNIT_FIELD_BYTES_0, (RaceClassGender | (powertype << 24)));
	InitDisplayIds();
	if (sWorld->getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_PVP || sWorld->getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_RPPVP)
	{
		SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_PVP);
		SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
	}
	SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_REGENERATE_POWER);
	SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);               // fix cast time showed in spell tooltip on client
	SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 1.0f);            // default for players in 3.0.3

															// -1 is default value
	SetInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, uint32(-1));

	SetUInt32Value(PLAYER_BYTES, (createInfo->Skin | (createInfo->Face << 8) | (createInfo->HairStyle << 16) | (createInfo->HairColor << 24)));
	SetUInt32Value(PLAYER_BYTES_2, (createInfo->FacialHair |
		(0x00 << 8) |
		(0x00 << 16) |
		(((GetSession()->IsARecruiter() || GetSession()->GetRecruiterId() != 0) ? REST_STATE_RAF_LINKED : REST_STATE_NOT_RAF_LINKED) << 24)));
	SetByteValue(PLAYER_BYTES_3, 0, createInfo->Gender);
	SetByteValue(PLAYER_BYTES_3, 3, 0);                     // BattlefieldArenaFaction (0 or 1)

	SetUInt32Value(PLAYER_GUILDID, 0);
	SetUInt32Value(PLAYER_GUILDRANK, 0);
	SetUInt32Value(PLAYER_GUILD_TIMESTAMP, 0);

	for (int i = 0; i < KNOWN_TITLES_SIZE; ++i)
		SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES + i, 0);  // 0=disabled
	SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);

	SetUInt32Value(PLAYER_FIELD_KILLS, 0);
	SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
	SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
	SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);

	// set starting level
	uint32 start_level = getClass() != CLASS_DEATH_KNIGHT
		? sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL)
		: sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL);

	if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
	{
		uint32 gm_level = sWorld->getIntConfig(CONFIG_START_GM_LEVEL);
		if (gm_level > start_level)
			start_level = gm_level;
	}

	SetUInt32Value(UNIT_FIELD_LEVEL, start_level);

	InitRunes();

	SetUInt32Value(PLAYER_FIELD_COINAGE, sWorld->getIntConfig(CONFIG_START_PLAYER_MONEY));
	SetHonorPoints(sWorld->getIntConfig(CONFIG_START_HONOR_POINTS));
	SetArenaPoints(sWorld->getIntConfig(CONFIG_START_ARENA_POINTS));

	// start with every map explored
	if (sWorld->getBoolConfig(CONFIG_START_ALL_EXPLORED))
	{
		for (uint8 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; i++)
			SetFlag(PLAYER_EXPLORED_ZONES_1 + i, 0xFFFFFFFF);
	}

	//Reputations if "StartAllReputation" is enabled, -- TODO: Fix this in a better way
	if (sWorld->getBoolConfig(CONFIG_START_ALL_REP))
	{
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(942), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(935), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(936), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(1011), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(970), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(967), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(989), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(932), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(934), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(1038), 42999);
		GetReputationMgr().SetReputation(sFactionStore.LookupEntry(1077), 42999);

		// Factions depending on team, like cities and some more stuff
		switch (GetTeamId(true))
		{
		case TEAM_ALLIANCE:
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(72), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(47), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(69), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(930), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(730), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(978), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(54), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(946), 42999);
			break;
		case TEAM_HORDE:
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(76), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(68), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(81), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(911), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(729), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(941), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(530), 42999);
			GetReputationMgr().SetReputation(sFactionStore.LookupEntry(947), 42999);
			break;
		default:
			break;
		}
	}

	// Played time
	m_Last_tick = time(NULL);
	m_Played_time[PLAYED_TIME_TOTAL] = 0;
	m_Played_time[PLAYED_TIME_LEVEL] = 0;

	// base stats and related field values
	InitStatsForLevel();
	InitTaxiNodesForLevel();
	InitGlyphsForLevel();
	InitTalentForLevel();
	InitPrimaryProfessions();                               // to max set before any spell added

	// apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()
	UpdateMaxHealth();                                      // Update max Health (for add bonus from stamina)
	SetFullHealth();
	if (getPowerType() == POWER_MANA)
	{
		UpdateMaxPower(POWER_MANA);                         // Update max Mana (for add bonus from intellect)
		SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
	}

	if (getPowerType() == POWER_RUNIC_POWER)
	{
		SetPower(POWER_RUNE, 8);
		SetMaxPower(POWER_RUNE, 8);
		SetPower(POWER_RUNIC_POWER, 0);
		SetMaxPower(POWER_RUNIC_POWER, 1000);
	}

	// original spells
	learnDefaultSpells();

	// original action bar
	for (PlayerCreateInfoActions::const_iterator action_itr = info->action.begin(); action_itr != info->action.end(); ++action_itr)
		addActionButton(action_itr->button, action_itr->action, action_itr->type);

	// original items
	if (CharStartOutfitEntry const* oEntry = GetCharStartOutfitEntry(createInfo->Race, createInfo->Class, createInfo->Gender))
	{
		for (int j = 0; j < MAX_OUTFIT_ITEMS; ++j)
		{
			if (oEntry->ItemId[j] <= 0)
				continue;

			uint32 itemId = oEntry->ItemId[j];

			// just skip, reported in ObjectMgr::LoadItemTemplates
			ItemTemplate const* iProto = sObjectMgr->GetItemTemplate(itemId);
			if (!iProto)
				continue;

			// BuyCount by default
			uint32 count = iProto->BuyCount;

			// special amount for food/drink
			if (iProto->Class == ITEM_CLASS_CONSUMABLE && iProto->SubClass == ITEM_SUBCLASS_FOOD)
			{
				switch (iProto->Spells[0].SpellCategory)
				{
				case SPELL_CATEGORY_FOOD:                                // food
					count = getClass() == CLASS_DEATH_KNIGHT ? 10 : 4;
					break;
				case SPELL_CATEGORY_DRINK:                                // drink
					count = 2;
					break;
				}
				if (iProto->GetMaxStackSize() < count)
					count = iProto->GetMaxStackSize();
			}
			StoreNewItemInBestSlots(itemId, count);
		}
	}

	for (PlayerCreateInfoItems::const_iterator item_id_itr = info->item.begin(); item_id_itr != info->item.end(); ++item_id_itr)
		StoreNewItemInBestSlots(item_id_itr->item_id, item_id_itr->item_amount);

	// bags and main-hand weapon must equipped at this moment
	// now second pass for not equipped (offhand weapon/shield if it attempt equipped before main-hand weapon)
	// or ammo not equipped in special bag
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
	{
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		{
			uint16 eDest;
			// equip offhand weapon/shield if it attempt equipped before main-hand weapon
			InventoryResult msg = CanEquipItem(NULL_SLOT, eDest, pItem, false);
			if (msg == EQUIP_ERR_OK)
			{
				RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
				EquipItem(eDest, pItem, true);
			}
			// move other items to more appropriate slots (ammo not equipped in special bag)
			else
			{
				ItemPosCountVec sDest;
				msg = CanStoreItem(NULL_BAG, NULL_SLOT, sDest, pItem, false);
				if (msg == EQUIP_ERR_OK)
				{
					RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
					pItem = StoreItem(sDest, pItem, true);
				}

				// if  this is ammo then use it
				msg = CanUseAmmo(pItem->GetEntry());
				if (msg == EQUIP_ERR_OK)
					SetAmmo(pItem->GetEntry());
			}
		}
	}
	// all item positions resolved

	return true;
}

bool Player::StoreNewItemInBestSlots(uint32 titem_id, uint32 titem_amount)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: Creating initial item, itemId = %u, count = %u", titem_id, titem_amount);

	// attempt equip by one
	while (titem_amount > 0)
	{
		uint16 eDest;
		InventoryResult msg = CanEquipNewItem(NULL_SLOT, eDest, titem_id, false);
		if (msg != EQUIP_ERR_OK)
			break;

		EquipNewItem(eDest, titem_id, true);
		AutoUnequipOffhandIfNeed();
		--titem_amount;
	}

	if (titem_amount == 0)
		return true;                                        // equipped

	// attempt store
	ItemPosCountVec sDest;
	// store in main bag to simplify second pass (special bags can be not equipped yet at this moment)
	InventoryResult msg = CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, titem_id, titem_amount);
	if (msg == EQUIP_ERR_OK)
	{
		StoreNewItem(sDest, titem_id, true, Item::GenerateItemRandomPropertyId(titem_id));
		return true;                                        // stored
	}

	// item can't be added
	sLog->outError("STORAGE: Can't equip or store initial item %u for race %u class %u, error msg = %u", titem_id, getRace(true), getClass(), msg);
	return false;
}

void Player::SendMirrorTimer(MirrorTimerType Type, uint32 MaxValue, uint32 CurrentValue, int32 Regen)
{
	if (int(MaxValue) == DISABLED_MIRROR_TIMER)
	{
		if (int(CurrentValue) != DISABLED_MIRROR_TIMER)
			StopMirrorTimer(Type);
		return;
	}
	WorldPacket data(SMSG_START_MIRROR_TIMER, (21));
	data << (uint32)Type;
	data << CurrentValue;
	data << MaxValue;
	data << Regen;
	data << (uint8)0;
	data << (uint32)0;                                      // spell id
	GetSession()->SendPacket(&data);
}

void Player::StopMirrorTimer(MirrorTimerType Type)
{
	m_MirrorTimer[Type] = DISABLED_MIRROR_TIMER;
	WorldPacket data(SMSG_STOP_MIRROR_TIMER, 4);
	data << (uint32)Type;
	GetSession()->SendPacket(&data);
}

bool Player::IsImmuneToEnvironmentalDamage()
{
	// check for GM and death state included in isAttackableByAOE
	return (!isTargetableForAttack(false, NULL));
}

uint32 Player::EnvironmentalDamage(EnviromentalDamage type, uint32 damage)
{
	if (IsImmuneToEnvironmentalDamage())
		return 0;

	// Absorb, resist some environmental damage type
	uint32 absorb = 0;
	uint32 resist = 0;
	if (type == DAMAGE_LAVA)
		Unit::CalcAbsorbResist(this, this, SPELL_SCHOOL_MASK_FIRE, DIRECT_DAMAGE, damage, &absorb, &resist);
	else if (type == DAMAGE_SLIME)
		Unit::CalcAbsorbResist(this, this, SPELL_SCHOOL_MASK_NATURE, DIRECT_DAMAGE, damage, &absorb, &resist);

	damage -= absorb + resist;

	Unit::DealDamageMods(this, damage, &absorb);

	WorldPacket data(SMSG_ENVIRONMENTALDAMAGELOG, (21));
	data << uint64(GetGUID());
	data << uint8(type != DAMAGE_FALL_TO_VOID ? type : DAMAGE_FALL);
	data << uint32(damage);
	data << uint32(absorb);
	data << uint32(resist);
	SendMessageToSet(&data, true);

	uint32 final_damage = Unit::DealDamage(this, this, damage, NULL, SELF_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

	if (!IsAlive())
	{
		if (type == DAMAGE_FALL)                               // DealDamage not apply item durability loss at self damage
		{
			;//sLog->outStaticDebug("We are fall to death, loosing 10 percents durability");
			DurabilityLossAll(0.10f, false);
			// durability lost message
			WorldPacket data2(SMSG_DURABILITY_DAMAGE_DEATH, 0);
			GetSession()->SendPacket(&data2);
		}

		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATHS_FROM, 1, type);
	}

	return final_damage;
}

int32 Player::getMaxTimer(MirrorTimerType timer)
{
	switch (timer)
	{
	case FATIGUE_TIMER:
		return MINUTE * IN_MILLISECONDS;
	case BREATH_TIMER:
	{
		if (!IsAlive() || HasAuraType(SPELL_AURA_WATER_BREATHING) || GetSession()->GetSecurity() >= AccountTypes(sWorld->getIntConfig(CONFIG_DISABLE_BREATHING)))
			return DISABLED_MIRROR_TIMER;
		int32 UnderWaterTime = 3 * MINUTE * IN_MILLISECONDS;
		AuraEffectList const& mModWaterBreathing = GetAuraEffectsByType(SPELL_AURA_MOD_WATER_BREATHING);
		for (AuraEffectList::const_iterator i = mModWaterBreathing.begin(); i != mModWaterBreathing.end(); ++i)
			AddPct(UnderWaterTime, (*i)->GetAmount());
		return UnderWaterTime;
	}
	case FIRE_TIMER:
	{
		if (!IsAlive())
			return DISABLED_MIRROR_TIMER;
		return 1 * IN_MILLISECONDS;
	}
	default:
		return 0;
	}
}

void Player::UpdateMirrorTimers()
{
	// Desync flags for update on next HandleDrowning
	if (m_MirrorTimerFlags)
		m_MirrorTimerFlagsLast = ~m_MirrorTimerFlags;
}

void Player::HandleDrowning(uint32 time_diff)
{
	if (!m_MirrorTimerFlags)
		return;

	// In water
	if (m_MirrorTimerFlags & UNDERWATER_INWATER)
	{
		// Breath timer not activated - activate it
		if (m_MirrorTimer[BREATH_TIMER] == DISABLED_MIRROR_TIMER)
		{
			m_MirrorTimer[BREATH_TIMER] = getMaxTimer(BREATH_TIMER);
			SendMirrorTimer(BREATH_TIMER, m_MirrorTimer[BREATH_TIMER], m_MirrorTimer[BREATH_TIMER], -1);
		}
		else                                                              // If activated - do tick
		{
			m_MirrorTimer[BREATH_TIMER] -= time_diff;
			// Timer limit - need deal damage
			if (m_MirrorTimer[BREATH_TIMER] < 0)
			{
				m_MirrorTimer[BREATH_TIMER] += 1 * IN_MILLISECONDS;
				// Calculate and deal damage
				// TODO: Check this formula
				uint32 damage = GetMaxHealth() / 5 + urand(0, getLevel() - 1);
				EnvironmentalDamage(DAMAGE_DROWNING, damage);
			}
			else if (!(m_MirrorTimerFlagsLast & UNDERWATER_INWATER))      // Update time in client if need
				SendMirrorTimer(BREATH_TIMER, getMaxTimer(BREATH_TIMER), m_MirrorTimer[BREATH_TIMER], -1);
		}
	}
	else if (m_MirrorTimer[BREATH_TIMER] != DISABLED_MIRROR_TIMER)        // Regen timer
	{
		int32 UnderWaterTime = getMaxTimer(BREATH_TIMER);
		// Need breath regen
		m_MirrorTimer[BREATH_TIMER] += 10 * time_diff;
		if (m_MirrorTimer[BREATH_TIMER] >= UnderWaterTime || !IsAlive())
			StopMirrorTimer(BREATH_TIMER);
		else if (m_MirrorTimerFlagsLast & UNDERWATER_INWATER)
			SendMirrorTimer(BREATH_TIMER, UnderWaterTime, m_MirrorTimer[BREATH_TIMER], 10);
	}

	// In dark water
	if (m_MirrorTimerFlags & UNDERWARER_INDARKWATER)
	{
		// Fatigue timer not activated - activate it
		if (m_MirrorTimer[FATIGUE_TIMER] == DISABLED_MIRROR_TIMER)
		{
			m_MirrorTimer[FATIGUE_TIMER] = getMaxTimer(FATIGUE_TIMER);
			SendMirrorTimer(FATIGUE_TIMER, m_MirrorTimer[FATIGUE_TIMER], m_MirrorTimer[FATIGUE_TIMER], -1);
		}
		else
		{
			m_MirrorTimer[FATIGUE_TIMER] -= time_diff;
			// Timer limit - need deal damage or teleport ghost to graveyard
			if (m_MirrorTimer[FATIGUE_TIMER] < 0)
			{
				m_MirrorTimer[FATIGUE_TIMER] += 1 * IN_MILLISECONDS;
				if (IsAlive())                                            // Calculate and deal damage
				{
					uint32 damage = GetMaxHealth() / 5 + urand(0, getLevel() - 1);
					EnvironmentalDamage(DAMAGE_EXHAUSTED, damage);
				}
				else if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST))       // Teleport ghost to graveyard
					RepopAtGraveyard();
			}
			else if (!(m_MirrorTimerFlagsLast & UNDERWARER_INDARKWATER))
				SendMirrorTimer(FATIGUE_TIMER, getMaxTimer(FATIGUE_TIMER), m_MirrorTimer[FATIGUE_TIMER], -1);
		}
	}
	else if (m_MirrorTimer[FATIGUE_TIMER] != DISABLED_MIRROR_TIMER)       // Regen timer
	{
		int32 DarkWaterTime = getMaxTimer(FATIGUE_TIMER);
		m_MirrorTimer[FATIGUE_TIMER] += 10 * time_diff;
		if (m_MirrorTimer[FATIGUE_TIMER] >= DarkWaterTime || !IsAlive())
			StopMirrorTimer(FATIGUE_TIMER);
		else if (m_MirrorTimerFlagsLast & UNDERWARER_INDARKWATER)
			SendMirrorTimer(FATIGUE_TIMER, DarkWaterTime, m_MirrorTimer[FATIGUE_TIMER], 10);
	}

	if (m_MirrorTimerFlags & (UNDERWATER_INLAVA /*| UNDERWATER_INSLIME*/) && !(_lastLiquid && _lastLiquid->SpellId))
	{
		// Breath timer not activated - activate it
		if (m_MirrorTimer[FIRE_TIMER] == DISABLED_MIRROR_TIMER)
			m_MirrorTimer[FIRE_TIMER] = getMaxTimer(FIRE_TIMER);
		else
		{
			m_MirrorTimer[FIRE_TIMER] -= time_diff;
			if (m_MirrorTimer[FIRE_TIMER] < 0)
			{
				m_MirrorTimer[FIRE_TIMER] += 1 * IN_MILLISECONDS;
				// Calculate and deal damage
				// TODO: Check this formula
				uint32 damage = urand(600, 700);
				if (m_MirrorTimerFlags & UNDERWATER_INLAVA)
					EnvironmentalDamage(DAMAGE_LAVA, damage);
				// need to skip Slime damage in Undercity,
				// maybe someone can find better way to handle environmental damage
				//else if (m_zoneUpdateId != 1497)
				//    EnvironmentalDamage(DAMAGE_SLIME, damage);
			}
		}
	}
	else
		m_MirrorTimer[FIRE_TIMER] = DISABLED_MIRROR_TIMER;

	// Recheck timers flag
	m_MirrorTimerFlags &= ~UNDERWATER_EXIST_TIMERS;
	for (uint8 i = 0; i < MAX_TIMERS; ++i)
		if (m_MirrorTimer[i] != DISABLED_MIRROR_TIMER)
		{
			m_MirrorTimerFlags |= UNDERWATER_EXIST_TIMERS;
			break;
		}
	m_MirrorTimerFlagsLast = m_MirrorTimerFlags;
}

///The player sobers by 1% every 9 seconds
void Player::HandleSobering()
{
	m_drunkTimer = 0;

	uint8 currentDrunkValue = GetDrunkValue();
	uint8 drunk = currentDrunkValue ? --currentDrunkValue : 0;
	SetDrunkValue(drunk);
}

DrunkenState Player::GetDrunkenstateByValue(uint8 value)
{
	if (value >= 90)
		return DRUNKEN_SMASHED;
	if (value >= 50)
		return DRUNKEN_DRUNK;
	if (value)
		return DRUNKEN_TIPSY;
	return DRUNKEN_SOBER;
}

void Player::SetDrunkValue(uint8 newDrunkValue, uint32 itemId /*= 0*/)
{
	bool isSobering = newDrunkValue < GetDrunkValue();
	uint32 oldDrunkenState = Player::GetDrunkenstateByValue(GetDrunkValue());
	if (newDrunkValue > 100)
		newDrunkValue = 100;

	// select drunk percent or total SPELL_AURA_MOD_FAKE_INEBRIATE amount, whichever is higher for visibility updates
	int32 drunkPercent = std::max<int32>(newDrunkValue, GetTotalAuraModifier(SPELL_AURA_MOD_FAKE_INEBRIATE));
	if (drunkPercent)
	{
		m_invisibilityDetect.AddFlag(INVISIBILITY_DRUNK);
		m_invisibilityDetect.SetValue(INVISIBILITY_DRUNK, drunkPercent);
	}
	else if (!HasAuraType(SPELL_AURA_MOD_FAKE_INEBRIATE) && !newDrunkValue)
		m_invisibilityDetect.DelFlag(INVISIBILITY_DRUNK);

	uint32 newDrunkenState = Player::GetDrunkenstateByValue(newDrunkValue);
	SetByteValue(PLAYER_BYTES_3, 1, newDrunkValue);
	UpdateObjectVisibility(false);

	if (!isSobering)
		m_drunkTimer = 0;   // reset sobering timer

	if (newDrunkenState == oldDrunkenState)
		return;

	WorldPacket data(SMSG_CROSSED_INEBRIATION_THRESHOLD, (8 + 4 + 4));
	data << uint64(GetGUID());
	data << uint32(newDrunkenState);
	data << uint32(itemId);
	SendMessageToSet(&data, true);
}

void Player::Update(uint32 p_time)
{
	if (!IsInWorld())
		return;

	// undelivered mail
	if (m_nextMailDelivereTime && m_nextMailDelivereTime <= time(NULL))
	{
		SendNewMail();
		++unReadMails;

		// It will be recalculate at mailbox open (for unReadMails important non-0 until mailbox open, it also will be recalculated)
		m_nextMailDelivereTime = 0;
	}

	//used to implement delayed far teleports
	SetMustDelayTeleport(true);
	Unit::Update(p_time);
	SetMustDelayTeleport(false);

	time_t now = time(NULL);

	UpdatePvPFlag(now);

	UpdateContestedPvP(p_time);

	UpdateDuelFlag(now);

	CheckDuelDistance(now);

	UpdateAfkReport(now);

	// Xinef: update charm AI only if we are controlled by creature or non-posses player charm
	if (IsCharmed() && !HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED))
	{
		m_charmUpdateTimer += p_time;
		if (m_charmUpdateTimer >= 1000)
		{
			m_charmUpdateTimer = 0;
			if (Unit* charmer = GetCharmer())
				if (charmer->IsAlive())
					UpdateCharmedAI();
		}
	}

	if (now > m_Last_tick)
	{
		// Update items that have just a limited lifetime
		UpdateItemDuration(uint32(now - m_Last_tick));

		// check every minute, less chance to crash and wont break anything.
		UpdateSoulboundTradeItems();

		// Played time
		uint32 elapsed = uint32(now - m_Last_tick);
		m_Played_time[PLAYED_TIME_TOTAL] += elapsed;        // Total played time
		m_Played_time[PLAYED_TIME_LEVEL] += elapsed;        // Level played time
		m_Last_tick = now;
	}

	// If mute expired, remove it from the DB
	if (GetSession()->m_muteTime && GetSession()->m_muteTime < now)
	{
		GetSession()->m_muteTime = 0;
		PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_MUTE_TIME);
		stmt->setInt64(0, 0); // Set the mute time to 0
		stmt->setString(1, "");
		stmt->setString(2, "");
		stmt->setUInt32(3, GetSession()->GetAccountId());
		LoginDatabase.Execute(stmt);
	}

	if (!m_timedquests.empty())
	{
		QuestSet::iterator iter = m_timedquests.begin();
		while (iter != m_timedquests.end())
		{
			QuestStatusData& q_status = m_QuestStatus[*iter];
			if (q_status.Timer <= p_time)
			{
				uint32 quest_id = *iter;
				++iter;                                     // current iter will be removed in FailQuest
				FailQuest(quest_id);
			}
			else
			{
				q_status.Timer -= p_time;
				m_QuestStatusSave[*iter] = true;
				++iter;
			}
		}
	}

	m_achievementMgr->UpdateTimedAchievements(p_time);

	if (HasUnitState(UNIT_STATE_MELEE_ATTACKING) && !HasUnitState(UNIT_STATE_CASTING))
	{
		if (Unit* victim = GetVictim())
		{
			// default combat reach 10
			// TODO add weapon, skill check

			if (isAttackReady(BASE_ATTACK))
			{
				if (!IsWithinMeleeRange(victim))
				{
					setAttackTimer(BASE_ATTACK, 100);
					if (m_swingErrorMsg != 1)               // send single time (client auto repeat)
					{
						SendAttackSwingNotInRange();
						m_swingErrorMsg = 1;
					}
				}
				//120 degrees of radiant range
				else if (!HasInArc(2 * M_PI / 3, victim))
				{
					setAttackTimer(BASE_ATTACK, 100);
					if (m_swingErrorMsg != 2)               // send single time (client auto repeat)
					{
						SendAttackSwingBadFacingAttack();
						m_swingErrorMsg = 2;
					}
				}
				else
				{
					m_swingErrorMsg = 0;                    // reset swing error state

					// prevent base and off attack in same time, delay attack at 0.2 sec
					if (haveOffhandWeapon())
						if (getAttackTimer(OFF_ATTACK) < ATTACK_DISPLAY_DELAY)
							setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);

					// do attack
					AttackerStateUpdate(victim, BASE_ATTACK);
					resetAttackTimer(BASE_ATTACK);
				}
			}

			if (haveOffhandWeapon() && isAttackReady(OFF_ATTACK))
			{
				if (!IsWithinMeleeRange(victim))
					setAttackTimer(OFF_ATTACK, 100);
				else if (!HasInArc(2 * M_PI / 3, victim))
					setAttackTimer(OFF_ATTACK, 100);
				else
				{
					// prevent base and off attack in same time, delay attack at 0.2 sec
					if (getAttackTimer(BASE_ATTACK) < ATTACK_DISPLAY_DELAY)
						setAttackTimer(BASE_ATTACK, ATTACK_DISPLAY_DELAY);

					// do attack
					AttackerStateUpdate(victim, OFF_ATTACK);
					resetAttackTimer(OFF_ATTACK);
				}
			}

			/*Unit* owner = victim->GetOwner();
			Unit* u = owner ? owner : victim;
			if (u->IsPvP() && (!duel || duel->opponent != u))
			{
				UpdatePvP(true);
				RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
			}*/
		}
	}

	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING))
	{
		if (now > m_Last_tick && _restTime > 0)      // freeze update
		{
			time_t currTime = time(NULL);
			time_t timeDiff = currTime - _restTime;
			if (timeDiff >= 10)                             // freeze update
			{
				_restTime = currTime;

				float bubble = 0.125f * sWorld->getRate(RATE_REST_INGAME);
				float extraPerSec = ((float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP) / 72000.0f) * bubble;

				// speed collect rest bonus (section/in hour)
				SetRestBonus(GetRestBonus() + timeDiff * extraPerSec);
			}
		}
	}

	if (m_weaponChangeTimer > 0)
	{
		if (p_time >= m_weaponChangeTimer)
			m_weaponChangeTimer = 0;
		else
			m_weaponChangeTimer -= p_time;
	}

	if (!IsPositionValid()) // pussywizard: will crash below at eg. GetZoneAndAreaId
	{
		sLog->outMisc("Player::Update - invalid position (%.1f, %.1f, %.1f)! Map: %u, MapId: %u, GUID: %u", GetPositionX(), GetPositionY(), GetPositionZ(), (FindMap() ? FindMap()->GetId() : 0), GetMapId(), GetGUIDLow());
		GetSession()->KickPlayer();
		return;
	}

	if (m_zoneUpdateTimer > 0)
	{
		if (p_time >= m_zoneUpdateTimer)
		{
			uint32 newzone, newarea;
			GetZoneAndAreaId(newzone, newarea, true);
			m_last_zone_id = newzone;
			m_last_area_id = newarea;

			if (m_zoneUpdateId != newzone)
				UpdateZone(newzone, newarea);                // also update area
			else
			{
				// use area updates as well
				// needed for free far all arenas for example
				if (m_areaUpdateId != newarea)
					UpdateArea(newarea);
			}

			m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;
		}
		else
			m_zoneUpdateTimer -= p_time;
	}

	if (m_timeSyncTimer > 0)
	{
		if (p_time >= m_timeSyncTimer)
			SendTimeSync();
		else
			m_timeSyncTimer -= p_time;
	}

	if (IsAlive())
	{
		m_regenTimer += p_time;
		RegenerateAll();
	}

	if (m_deathState == JUST_DIED)
		KillPlayer();

	if (m_nextSave <= SavingSystemMgr::GetSavingCurrentValue() && !GetSession()->isLogingOut())
		SaveToDB(false, false);
	else if (m_additionalSaveTimer && !GetSession()->isLogingOut()) // pussywizard:
	{
		if (m_additionalSaveTimer <= p_time)
		{
			SQLTransaction trans = CharacterDatabase.BeginTransaction();

			if (m_additionalSaveMask & ADDITIONAL_SAVING_INVENTORY_AND_GOLD)
				SaveInventoryAndGoldToDB(trans);
			if (m_additionalSaveMask & ADDITIONAL_SAVING_QUEST_STATUS)
			{
				_SaveQuestStatus(trans);

				// xinef: if nothing changed, nothing will happen
				_SaveDailyQuestStatus(trans);
				_SaveWeeklyQuestStatus(trans);
				_SaveSeasonalQuestStatus(trans);
				_SaveMonthlyQuestStatus(trans);
			}

			CharacterDatabase.CommitTransaction(trans);

			m_additionalSaveTimer = 0;
			m_additionalSaveMask = 0;
		}
		else
			m_additionalSaveTimer -= p_time;
	}

	//Handle Water/drowning
	HandleDrowning(p_time);

	if (GetDrunkValue())
	{
		m_drunkTimer += p_time;
		if (m_drunkTimer > 9 * IN_MILLISECONDS)
			HandleSobering();
	}

	if (HasPendingBind())
	{
		if (_pendingBindTimer <= p_time)
		{
			// Player left the instance
			if (_pendingBindId == GetInstanceId())
				BindToInstance();
			SetPendingBind(0, 0);
		}
		else
			_pendingBindTimer -= p_time;
	}

	// not auto-free ghost from body in instances
	if (m_deathTimer > 0 && !GetBaseMap()->Instanceable() && !HasAuraType(SPELL_AURA_PREVENT_RESURRECTION))
	{
		if (p_time >= m_deathTimer)
		{
			m_deathTimer = 0;
			BuildPlayerRepop();
			RepopAtGraveyard();
		}
		else
			m_deathTimer -= p_time;
	}

	UpdateEnchantTime(p_time);
	UpdateHomebindTime(p_time);

	if (!_instanceResetTimes.empty())
	{
		for (InstanceTimeMap::iterator itr = _instanceResetTimes.begin(); itr != _instanceResetTimes.end();)
		{
			if (itr->second < now)
				_instanceResetTimes.erase(itr++);
			else
				++itr;
		}
	}

	// group update
	SendUpdateToOutOfRangeGroupMembers();

	Pet* pet = GetPet();
	if (pet && !pet->IsWithinDistInMap(this, GetMap()->GetVisibilityRange()) && !pet->isPossessed())
		//if (pet && !pet->IsWithinDistInMap(this, GetMap()->GetVisibilityDistance()) && (GetCharmGUID() && (pet->GetGUID() != GetCharmGUID())))
		RemovePet(pet, PET_SAVE_NOT_IN_SLOT, true);

	// pussywizard:
	if (m_hostileReferenceCheckTimer <= p_time)
	{
		m_hostileReferenceCheckTimer = 15000;
		if (!GetMap()->IsDungeon())
			getHostileRefManager().deleteReferencesOutOfRange(GetVisibilityRange());
	}
	else
		m_hostileReferenceCheckTimer -= p_time;

	//we should execute delayed teleports only for alive(!) players
	//because we don't want player's ghost teleported from graveyard
	// xinef: so we store it to the end of the world and teleport out of the ass after resurrection?
	if (HasDelayedTeleport()/* && IsAlive()*/)
	{
		SetHasDelayedTeleport(false);
		TeleportTo(teleportStore_dest, teleportStore_options);
	}

	if (!IsBeingTeleported() && bRequestForcedVisibilityUpdate)
	{
		bRequestForcedVisibilityUpdate = false;
		UpdateObjectVisibility(true, true);
		m_delayed_unit_relocation_timer = 0;
		RemoveFromNotify(NOTIFY_VISIBILITY_CHANGED);
	}
}

void Player::setDeathState(DeathState s, bool /*despawn = false*/)
{
	uint32 ressSpellId = 0;

	bool cur = IsAlive();

	if (s == JUST_DIED)
	{
		if (!cur)
		{
			sLog->outError("setDeathState: attempt to kill a dead player %s(%d)", GetName().c_str(), GetGUIDLow());
			return;
		}

		// drunken state is cleared on death
		SetDrunkValue(0);
		// lost combo points at any target (targeted combo points clear in Unit::setDeathState)
		ClearComboPoints();

		clearResurrectRequestData();

		//FIXME: is pet dismissed at dying or releasing spirit? if second, add setDeathState(DEAD) to HandleRepopRequestOpcode and define pet unsummon here with (s == DEAD)
		RemovePet(NULL, PET_SAVE_NOT_IN_SLOT, true);

		// save value before aura remove in Unit::setDeathState
		ressSpellId = GetUInt32Value(PLAYER_SELF_RES_SPELL);

		// xinef: disable passive area auras!
		AddUnitState(UNIT_STATE_ISOLATED);

		// passive spell
		if (!ressSpellId)
			ressSpellId = GetResurrectionSpellId();
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH_AT_MAP, 1);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH, 1);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DEATH_IN_DUNGEON, 1);

		// Xinef: reset all death criterias
		ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_NO_DEATH, 0);
	}
	// xinef: enable passive area auras!
	else if (s == ALIVE)
		ClearUnitState(UNIT_STATE_ISOLATED);

	Unit::setDeathState(s);

	if (NeedSendSpectatorData())
		ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "STA", IsAlive() ? 1 : 0);

	// restore resurrection spell id for player after aura remove
	if (s == JUST_DIED && cur && ressSpellId)
		SetUInt32Value(PLAYER_SELF_RES_SPELL, ressSpellId);

	if (IsAlive() && !cur)
		//clear aura case after resurrection by another way (spells will be applied before next death)
		SetUInt32Value(PLAYER_SELF_RES_SPELL, 0);
}

void Player::SetRestState(uint32 triggerId)
{
	_innTriggerId = triggerId;
	_restTime = time(NULL);
	SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING);
}

void Player::RemoveRestState()
{
	_innTriggerId = 0;
	_restTime = 0;
	RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING);
}

bool Player::BuildEnumData(PreparedQueryResult result, WorldPacket* data)
{
	//             0               1                2                3                 4                  5                       6                        7
	//    "SELECT characters.guid, characters.name, characters.race, characters.class, characters.gender, characters.playerBytes, characters.playerBytes2, characters.level, "
	//     8                9               10                     11                     12                     13                    14
	//    "characters.zone, characters.map, characters.position_x, characters.position_y, characters.position_z, guild_member.guildid, characters.playerFlags, "
	//    15                    16                   17                     18                   19               20                     21                      22
	//    "characters.at_login, character_pet.entry, character_pet.modelid, character_pet.level, characters.data, character_banned.guid, characters.extra_flags, character_declinedname.genitive "

	Field* fields = result->Fetch();

	uint32 guid = fields[0].GetUInt32();
	uint8 plrRace = fields[2].GetUInt8();
	uint8 plrClass = fields[3].GetUInt8();
	uint8 gender = fields[4].GetUInt8();

	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(plrRace, plrClass);
	if (!info)
	{
		sLog->outError("Player %u has incorrect race/class pair. Don't build enum.", guid);
		return false;
	}
	else if (!IsValidGender(gender))
	{
		sLog->outError("Player (%u) has incorrect gender (%hu), don't build enum.", guid, gender);
		return false;
	}

	*data << uint64(MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));
	*data << fields[1].GetString();                         // name
	*data << uint8(plrRace);                                // race
	*data << uint8(plrClass);                               // class
	*data << uint8(gender);                                 // gender

	uint32 playerBytes = fields[5].GetUInt32();
	*data << uint8(playerBytes);                            // skin
	*data << uint8(playerBytes >> 8);                       // face
	*data << uint8(playerBytes >> 16);                      // hair style
	*data << uint8(playerBytes >> 24);                      // hair color

	uint32 playerBytes2 = fields[6].GetUInt32();
	*data << uint8(playerBytes2 & 0xFF);                    // facial hair

	*data << uint8(fields[7].GetUInt8());                   // level
	*data << uint32(fields[8].GetUInt16());                 // zone
	*data << uint32(fields[9].GetUInt16());                 // map

	*data << fields[10].GetFloat();                         // x
	*data << fields[11].GetFloat();                         // y
	*data << fields[12].GetFloat();                         // z

	*data << uint32(fields[13].GetUInt32());                // guild id

	uint32 charFlags = 0;
	uint32 playerFlags = fields[14].GetUInt32();
	uint16 atLoginFlags = fields[15].GetUInt16();
	if (playerFlags & PLAYER_FLAGS_HIDE_HELM)
		charFlags |= CHARACTER_FLAG_HIDE_HELM;
	if (playerFlags & PLAYER_FLAGS_HIDE_CLOAK)
		charFlags |= CHARACTER_FLAG_HIDE_CLOAK;
	if (playerFlags & PLAYER_FLAGS_GHOST)
		charFlags |= CHARACTER_FLAG_GHOST;
	if (atLoginFlags & AT_LOGIN_RENAME)
		charFlags |= CHARACTER_FLAG_RENAME;
	if (fields[20].GetUInt32())
		charFlags |= CHARACTER_FLAG_LOCKED_BY_BILLING;
	if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
	{
		if (!fields[22].GetString().empty())
			charFlags |= CHARACTER_FLAG_DECLINED;
	}
	else
		charFlags |= CHARACTER_FLAG_DECLINED;

	*data << uint32(charFlags);                             // character flags

	// character customize flags
	if (atLoginFlags & AT_LOGIN_CUSTOMIZE)
		*data << uint32(CHAR_CUSTOMIZE_FLAG_CUSTOMIZE);
	else if (atLoginFlags & AT_LOGIN_CHANGE_FACTION)
		*data << uint32(CHAR_CUSTOMIZE_FLAG_FACTION);
	else if (atLoginFlags & AT_LOGIN_CHANGE_RACE)
		*data << uint32(CHAR_CUSTOMIZE_FLAG_RACE);
	else
		*data << uint32(CHAR_CUSTOMIZE_FLAG_NONE);

	// First login
	*data << uint8(atLoginFlags & AT_LOGIN_FIRST ? 1 : 0);

	// Pets info
	uint32 petDisplayId = 0;
	uint32 petLevel = 0;
	uint32 petFamily = 0;

	// show pet at selection character in character list only for non-ghost character
	if (result && !(playerFlags & PLAYER_FLAGS_GHOST) && (plrClass == CLASS_WARLOCK || plrClass == CLASS_HUNTER || (plrClass == CLASS_DEATH_KNIGHT && (fields[21].GetUInt32()&PLAYER_EXTRA_SHOW_DK_PET))))
	{
		uint32 entry = fields[16].GetUInt32();
		CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(entry);
		if (creatureInfo)
		{
			petDisplayId = fields[17].GetUInt32();
			petLevel = fields[18].GetUInt16();
			petFamily = creatureInfo->family;
		}
	}

	*data << uint32(petDisplayId);
	*data << uint32(petLevel);
	*data << uint32(petFamily);

	Tokenizer equipment(fields[19].GetString(), ' ');
	for (uint8 slot = 0; slot < INVENTORY_SLOT_BAG_END; ++slot)
	{
		uint32 visualBase = slot * 2;
		uint32 itemId = GetUInt32ValueFromArray(equipment, visualBase);
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		if (!proto)
		{
			*data << uint32(0);
			*data << uint8(0);
			*data << uint32(0);
			continue;
		}

		SpellItemEnchantmentEntry const* enchant = NULL;

		uint32 enchants = GetUInt32ValueFromArray(equipment, visualBase + 1);
		for (uint8 enchantSlot = PERM_ENCHANTMENT_SLOT; enchantSlot <= TEMP_ENCHANTMENT_SLOT; ++enchantSlot)
		{
			// values stored in 2 uint16
			uint32 enchantId = 0x0000FFFF & (enchants >> enchantSlot * 16);
			if (!enchantId)
				continue;

			enchant = sSpellItemEnchantmentStore.LookupEntry(enchantId);
			if (enchant)
				break;
		}

		*data << uint32(proto->DisplayInfoID);
		*data << uint8(proto->InventoryType);
		*data << uint32(enchant ? enchant->aura_id : 0);
	}

	return true;
}

void Player::ToggleAFK()
{
	ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK);

	// afk player not allowed in battleground
	if (isAFK() && InBattleground() && !InArena())
		LeaveBattleground();
}

void Player::ToggleDND()
{
	ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_DND);
}

uint8 Player::GetChatTag() const
{
	uint8 tag = CHAT_TAG_NONE;

	if (isGMChat())
		tag |= CHAT_TAG_GM;
	if (isDND())
		tag |= CHAT_TAG_DND;
	if (isAFK())
		tag |= CHAT_TAG_AFK;
	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER))
		tag |= CHAT_TAG_DEV;

	return tag;
}

void Player::SendTeleportAckPacket()
{
	WorldPacket data(MSG_MOVE_TELEPORT_ACK, 41);
	data.append(GetPackGUID());
	data << uint32(0);                                     // this value increments every time
	BuildMovementPacket(&data);
	GetSession()->SendPacket(&data);
}

bool Player::TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options)
{
	if (!MapManager::IsValidMapCoord(mapid, x, y, z, orientation))
	{
		sLog->outError("TeleportTo: invalid map (%d) or invalid coordinates (X: %f, Y: %f, Z: %f, O: %f) given when teleporting player (GUID: %u, name: %s, map: %d, X: %f, Y: %f, Z: %f, O: %f).",
			mapid, x, y, z, orientation, GetGUIDLow(), GetName().c_str(), GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
		return false;
	}

	if (AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()) && DisableMgr::IsDisabledFor(DISABLE_TYPE_MAP, mapid, this))
	{
		sLog->outError("Player (GUID: %u, name: %s) tried to enter a forbidden map %u", GetGUIDLow(), GetName().c_str(), mapid);
		SendTransferAborted(mapid, TRANSFER_ABORT_MAP_NOT_ALLOWED);
		return false;
	}

	// preparing unsummon pet if lost (we must get pet before teleportation or will not find it later)
	Pet* pet = GetPet();

	MapEntry const* mEntry = sMapStore.LookupEntry(mapid);

	// don't let enter battlegrounds without assigned battleground id (for example through areatrigger)...
	if (!InBattleground() && mEntry->IsBattlegroundOrArena())
		return false;

	// pussywizard: arena spectator, prevent teleporting from arena to instance/etc
	if (GetMapId() != mapid && IsSpectator() && mEntry->Instanceable())
	{
		SendTransferAborted(mapid, TRANSFER_ABORT_MAP_NOT_ALLOWED);
		return false;
	}

	// client without expansion support
	if (GetSession()->Expansion() < mEntry->Expansion())
	{
		;//sLog->outDebug(LOG_FILTER_MAPS, "Player %s using client without required expansion tried teleport to non accessible map %u", GetName().c_str(), mapid);

		if (GetTransport())
		{
			m_transport->RemovePassenger(this);
			m_transport = NULL;
			m_movementInfo.transport.Reset();
			m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
			RepopAtGraveyard();                             // teleport to near graveyard if on transport, looks blizz like :)
		}

		SendTransferAborted(mapid, TRANSFER_ABORT_INSUF_EXPAN_LVL, mEntry->Expansion());

		return false;                                       // normal client can't teleport to this map...
	}
	else
		;//sLog->outDebug(LOG_FILTER_MAPS, "Player %s is being teleported to map %u", GetName().c_str(), mapid);

	// xinef: do this here in case teleport failed in above checks
	if (!(options & TELE_TO_NOT_LEAVE_TAXI) && IsInFlight())
	{
		GetMotionMaster()->MovementExpired();
		CleanupAfterTaxiFlight();
	}

	if (!(options & TELE_TO_NOT_LEAVE_VEHICLE) && m_vehicle)
		ExitVehicle();

	// reset movement flags at teleport, because player will continue move with these flags after teleport
	SetUnitMovementFlags(GetUnitMovementFlags() & MOVEMENTFLAG_MASK_HAS_PLAYER_STATUS_OPCODE);
	DisableSpline();

	// Xinef: Remove all movement imparing effects auras, skip small teleport like blink
	if (mapid != GetMapId() || GetDistance2d(x, y) > 100)
	{
		RemoveAurasByType(SPELL_AURA_MOD_STUN);
		RemoveAurasByType(SPELL_AURA_MOD_FEAR);
		RemoveAurasByType(SPELL_AURA_MOD_CONFUSE);
		RemoveAurasByType(SPELL_AURA_MOD_ROOT);
	}

	if (m_transport)
	{
		if (options & TELE_TO_NOT_LEAVE_TRANSPORT)
			AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
		else
		{
			m_transport->RemovePassenger(this);
			m_transport = NULL;
			m_movementInfo.transport.Reset();
			m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
		}
	}

	// The player was ported to another map and loses the duel immediately.
	// We have to perform this check before the teleport, otherwise the
	// ObjectAccessor won't find the flag.
	if (duel && GetMapId() != mapid && GetMap()->GetGameObject(GetUInt64Value(PLAYER_DUEL_ARBITER)))
		DuelComplete(DUEL_FLED);

	if (GetMapId() == mapid)
	{
		//lets reset far teleport flag if it wasn't reset during chained teleports
		SetSemaphoreTeleportFar(0);

		SetHasDelayedTeleport(false); // pussywizard: current teleport cancels stored one
		//if teleport spell is casted in Unit::Update() func
		//then we need to delay it until update process will be finished
		if (MustDelayTeleport())
		{
			SetHasDelayedTeleport(true);
			SetSemaphoreTeleportNear(time(NULL));
			//lets save teleport destination for player
			teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
			teleportStore_options = options;
			return true;
		}

		if (options & TELE_TO_WITH_PET)
			UnsummonPetTemporaryIfAny();

		if (!(options & TELE_TO_NOT_UNSUMMON_PET))
		{
			//same map, only remove pet if out of range for new position
			if (pet && !pet->IsWithinDist3d(x, y, z, GetMap()->GetVisibilityRange()))
				UnsummonPetTemporaryIfAny();
		}

		if (!(options & TELE_TO_NOT_LEAVE_COMBAT))
			CombatStop();

		// this will be used instead of the current location in SaveToDB
		teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
		SetFallInformation(time(NULL), z);

		// code for finish transfer called in WorldSession::HandleMovementOpcodes()
		// at client packet MSG_MOVE_TELEPORT_ACK
		SetSemaphoreTeleportNear(time(NULL));
		// near teleport, triggering send MSG_MOVE_TELEPORT_ACK from client at landing
		if (!GetSession()->PlayerLogout())
		{
			Position oldPos;
			GetPosition(&oldPos);
			Relocate(x, y, z, orientation);
			SendTeleportAckPacket();
			SendTeleportPacket(oldPos); // this automatically relocates to oldPos in order to broadcast the packet in the right place
		}
	}
	else
	{
		if (getClass() == CLASS_DEATH_KNIGHT && GetMapId() == 609 && !IsGameMaster() && !HasSpell(50977))
			return false;

		// far teleport to another map
		Map* oldmap = IsInWorld() ? GetMap() : NULL;
		// check if we can enter before stopping combat / removing pet / totems / interrupting spells

		// Check enter rights before map getting to avoid creating instance copy for player
		// this check not dependent from map instance copy and same for all instance copies of selected map
		if (!(options & TELE_TO_GM_MODE) && !sMapMgr->CanPlayerEnter(mapid, this, false))
			return false;

		// if CanPlayerEnter -> CanEnter: checked above
		{
			//lets reset near teleport flag if it wasn't reset during chained teleports
			SetSemaphoreTeleportNear(0);

			SetHasDelayedTeleport(false); // pussywizard: current teleport cancels stored one
			//if teleport spell is casted in Unit::Update() func
			//then we need to delay it until update process will be finished
			if (MustDelayTeleport())
			{
				SetHasDelayedTeleport(true);
				SetSemaphoreTeleportFar(time(NULL));
				//lets save teleport destination for player
				teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
				teleportStore_options = options;
				return true;
			}

			SetSelection(0);

			CombatStop();

			ResetContestedPvP();

			// remove arena spell coldowns/buffs now to also remove pet's cooldowns before it's temporarily unsummoned
			if (mEntry->IsBattleArena() && (HasPendingSpectatorForBG(0) || !HasPendingSpectatorForBG(GetBattlegroundId())))
			{
				// KEEP THIS ORDER!
				RemoveArenaAuras();
				if (pet)
					pet->RemoveArenaAuras();

				RemoveArenaSpellCooldowns(true);
			}

			// remove pet on map change
			if (pet)
				UnsummonPetTemporaryIfAny();

			// remove all dyn objects
			RemoveAllDynObjects();

			// stop spellcasting
			// not attempt interrupt teleportation spell at caster teleport
			if (!(options & TELE_TO_SPELL))
				if (IsNonMeleeSpellCast(true))
					InterruptNonMeleeSpells(true);

			//remove auras before removing from map...
			RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP | AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING);

			if (!GetSession()->PlayerLogout())
			{
				// send transfer packets
				WorldPacket data(SMSG_TRANSFER_PENDING, 4 + 4 + 4);
				data << uint32(mapid);
				if (m_transport)
					data << m_transport->GetEntry() << GetMapId();

				GetSession()->SendPacket(&data);
			}

			// remove from old map now
			if (oldmap)
				oldmap->RemovePlayerFromMap(this, false);

			// xinef: do this before setting fall information!
			if (IsMounted() && (!GetMap()->GetEntry()->IsDungeon() && !GetMap()->GetEntry()->IsBattlegroundOrArena()))
			{
				AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_MOUNTED);
				if (!auras.empty())
				{
					SetMountBlockId((*auras.begin())->GetId());
					RemoveAurasByType(SPELL_AURA_MOUNTED);
				}
			}

			teleportStore_dest = WorldLocation(mapid, x, y, z, orientation);
			SetFallInformation(time(NULL), z);
			// if the player is saved before worldportack (at logout for example)
			// this will be used instead of the current location in SaveToDB

			if (!GetSession()->PlayerLogout())
			{
				WorldPacket data(SMSG_NEW_WORLD, 4 + 4 + 4 + 4 + 4);
				data << uint32(mapid);
				if (m_transport)
					data << m_movementInfo.transport.pos.PositionXYZOStream();
				else
					data << teleportStore_dest.PositionXYZOStream();

				GetSession()->SendPacket(&data);
				SendSavedInstances();
			}

			// move packet sent by client always after far teleport
			// code for finish transfer to new map called in WorldSession::HandleMoveWorldportAckOpcode at client packet
			SetSemaphoreTeleportFar(time(NULL));
		}
	}
	return true;
}

bool Player::TeleportToEntryPoint()
{
	ScheduleDelayedOperation(DELAYED_BG_MOUNT_RESTORE);
	ScheduleDelayedOperation(DELAYED_BG_TAXI_RESTORE);
	ScheduleDelayedOperation(DELAYED_BG_GROUP_RESTORE);

	if (m_entryPointData.joinPos.m_mapId == MAPID_INVALID)
		return TeleportTo(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, GetOrientation());
	return TeleportTo(m_entryPointData.joinPos);
}

void Player::ProcessDelayedOperations()
{
	if (m_DelayedOperations == 0)
		return;

	if (m_DelayedOperations & DELAYED_RESURRECT_PLAYER)
	{
		ResurrectPlayer(0.0f, false);

		if (GetMaxHealth() > m_resurrectHealth)
			SetHealth(m_resurrectHealth);
		else
			SetFullHealth();

		if (GetMaxPower(POWER_MANA) > m_resurrectMana)
			SetPower(POWER_MANA, m_resurrectMana);
		else
			SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

		SetPower(POWER_RAGE, 0);
		SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));

		SpawnCorpseBones();
	}

	if (m_DelayedOperations & DELAYED_SAVE_PLAYER)
		SaveToDB(false, false);

	if (m_DelayedOperations & DELAYED_SPELL_CAST_DESERTER)
		CastSpell(this, 26013, true);               // Deserter

	if (m_DelayedOperations & DELAYED_BG_MOUNT_RESTORE)
	{
		if (m_entryPointData.mountSpell)
		{
			// xinef: remove shapeshift auras
			RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
			AddAura(m_entryPointData.mountSpell, this);
			m_entryPointData.mountSpell = 0;
		}
	}

	if (m_DelayedOperations & DELAYED_BG_TAXI_RESTORE)
	{
		if (m_entryPointData.HasTaxiPath())
		{
			for (size_t i = 0; i < m_entryPointData.taxiPath.size() - 1; ++i)
				m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[i]);
			m_taxi.SetTaxiSegment(m_entryPointData.taxiPath[m_entryPointData.taxiPath.size() - 1]);

			m_entryPointData.ClearTaxiPath();
			ContinueTaxiFlight();
		}
	}

	if (m_DelayedOperations & DELAYED_BG_GROUP_RESTORE)
	{
		if (Group *g = GetGroup())
			g->SendUpdateToPlayer(GetGUID());
	}

	if (m_DelayedOperations & DELAYED_VEHICLE_TELEPORT)
	{
		if (Vehicle* vehicle = GetVehicle())
		{
			SeatMap::iterator itr = vehicle->GetSeatIteratorForPassenger(this);
			if (itr != vehicle->Seats.end())
				if (Unit* base = vehicle->GetBase())
				{
					ExitVehicle();
					base->HandleSpellClick(this, itr->first);
				}
		}
	}

	//we have executed ALL delayed ops, so clear the flag
	m_DelayedOperations = 0;
}

void Player::AddToWorld()
{
	///- Do not add/remove the player from the object storage
	///- It will crash when updating the ObjectAccessor
	///- The player should only be added when logging in
	Unit::AddToWorld();

	for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
		if (m_items[i])
			m_items[i]->AddToWorld();
}

void Player::RemoveFromWorld()
{
	// cleanup
	if (IsInWorld())
	{
		///- Release charmed creatures, unsummon totems and remove pets/guardians
		StopCastingCharm();
		StopCastingBindSight();
		UnsummonPetTemporaryIfAny();
		ClearComboPoints(); // pussywizard: crashfix
		ClearComboPointHolders(); // pussywizard: crashfix
		if (uint64 lguid = GetLootGUID()) // pussywizard: crashfix
			m_session->DoLootRelease(lguid);
		sOutdoorPvPMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
		sBattlefieldMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
	}

	///- Do not add/remove the player from the object storage
	///- It will crash when updating the ObjectAccessor
	///- The player should only be removed when logging out
	Unit::RemoveFromWorld();

	for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
	{
		if (m_items[i])
			m_items[i]->RemoveFromWorld();
	}

	for (ItemMap::iterator iter = mMitems.begin(); iter != mMitems.end(); ++iter)
		iter->second->RemoveFromWorld();

	if (m_uint32Values)
	{
		if (WorldObject* viewpoint = GetViewpoint())
		{
			sLog->outCrash("Player %s has viewpoint %u %u when removed from world", GetName().c_str(), viewpoint->GetEntry(), viewpoint->GetTypeId());
			SetViewpoint(viewpoint, false);
		}
	}
}

void Player::RegenerateAll()
{
	//if (m_regenTimer <= 500)
	//    return;

	m_regenTimerCount += m_regenTimer;

	Regenerate(POWER_ENERGY);

	Regenerate(POWER_MANA);

	// Runes act as cooldowns, and they don't need to send any data
	if (getClass() == CLASS_DEATH_KNIGHT)
		for (uint8 i = 0; i < MAX_RUNES; ++i)
		{
			// xinef: implement grace
			if (int32 cd = GetRuneCooldown(i))
			{
				SetRuneCooldown(i, (cd > m_regenTimer) ? cd - m_regenTimer : 0);
				// start grace counter, player must be in combat and rune has to go off cooldown
				if (IsInCombat() && cd <= m_regenTimer)
					SetGracePeriod(i, m_regenTimer - cd + 1); // added 1 because m_regenTimer-cd can be equal 0
			}
			// xinef: if grace is started, increase it but no more than cap
			else if (uint32 grace = GetGracePeriod(i))
			{

				if (grace < RUNE_GRACE_PERIOD)
					SetGracePeriod(i, std::min<uint32>(grace + m_regenTimer, RUNE_GRACE_PERIOD));
			}
		}

	if (m_regenTimerCount >= 2000)
	{
		// Not in combat or they have regeneration
		if (!IsInCombat() || IsPolymorphed() || m_baseHealthRegen ||
			HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT) ||
			HasAuraType(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT))
		{
			RegenerateHealth();
		}

		Regenerate(POWER_RAGE);
		if (getClass() == CLASS_DEATH_KNIGHT)
			Regenerate(POWER_RUNIC_POWER);

		m_regenTimerCount -= 2000;
	}

	m_regenTimer = 0;
}

void Player::Regenerate(Powers power)
{
	uint32 maxValue = GetMaxPower(power);
	if (!maxValue)
		return;

	uint32 curValue = GetPower(power);

	// TODO: possible use of miscvalueb instead of amount
	if (HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, power + 1))
		return;

	float addvalue = 0.0f;

	switch (power)
	{
	case POWER_MANA:
	{
		bool recentCast = IsUnderLastManaUseEffect();
		float ManaIncreaseRate = sWorld->getRate(RATE_POWER_MANA);

		if (getLevel() < 15)
			ManaIncreaseRate = sWorld->getRate(RATE_POWER_MANA) * (2.066f - (getLevel() * 0.066f));

		if (recentCast) // Trinity Updates Mana in intervals of 2s, which is correct
			addvalue += GetFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER) *  ManaIncreaseRate * 0.001f * m_regenTimer;
		else
			addvalue += GetFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER) * ManaIncreaseRate * 0.001f * m_regenTimer;
	}   break;
	case POWER_RAGE:                                    // Regenerate rage
	{
		if (!IsInCombat() && !HasAuraType(SPELL_AURA_INTERRUPT_REGEN))
		{
			float RageDecreaseRate = sWorld->getRate(RATE_POWER_RAGE_LOSS);
			addvalue += -20 * RageDecreaseRate;               // 2 rage by tick (= 2 seconds => 1 rage/sec)
		}
	}   break;
	case POWER_ENERGY:                                  // Regenerate energy (rogue)
		addvalue += 0.01f * m_regenTimer * sWorld->getRate(RATE_POWER_ENERGY);
		break;
	case POWER_RUNIC_POWER:
	{
		if (!IsInCombat() && !HasAuraType(SPELL_AURA_INTERRUPT_REGEN))
		{
			float RunicPowerDecreaseRate = sWorld->getRate(RATE_POWER_RUNICPOWER_LOSS);
			addvalue += -30 * RunicPowerDecreaseRate;         // 3 RunicPower by tick
		}
	}   break;
	case POWER_RUNE:
	case POWER_FOCUS:
	case POWER_HAPPINESS:
		break;
	case POWER_HEALTH:
		return;
	default:
		break;
	}

	// Mana regen calculated in Player::UpdateManaRegen()
	if (power != POWER_MANA)
	{
		AuraEffectList const& ModPowerRegenPCTAuras = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
		for (AuraEffectList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
			if (Powers((*i)->GetMiscValue()) == power)
				AddPct(addvalue, (*i)->GetAmount());

		// Butchery requires combat for this effect
		if (power != POWER_RUNIC_POWER || IsInCombat())
			addvalue += float(GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_POWER_REGEN, power) * ((power != POWER_ENERGY) ? m_regenTimerCount : m_regenTimer)) / (5.0f * IN_MILLISECONDS);
	}

	if (addvalue < 0.0f)
	{
		if (curValue == 0)
			return;
	}
	else if (addvalue > 0.0f)
	{
		if (curValue == maxValue)
			return;
	}
	else
		return;

	addvalue += m_powerFraction[power];
	uint32 integerValue = uint32(fabs(addvalue));

	if (addvalue < 0.0f)
	{
		if (curValue > integerValue)
		{
			curValue -= integerValue;
			m_powerFraction[power] = addvalue + integerValue;
		}
		else
		{
			curValue = 0;
			m_powerFraction[power] = 0;
		}
	}
	else
	{
		curValue += integerValue;

		if (curValue > maxValue)
		{
			curValue = maxValue;
			m_powerFraction[power] = 0;
		}
		else
			m_powerFraction[power] = addvalue - integerValue;
	}
	if (m_regenTimerCount >= 2000)
		SetPower(power, curValue);
	else
		UpdateUInt32Value(UNIT_FIELD_POWER1 + power, curValue);
}

void Player::RegenerateHealth()
{
	uint32 curValue = GetHealth();
	uint32 maxValue = GetMaxHealth();

	if (curValue >= maxValue)
		return;

	float HealthIncreaseRate = sWorld->getRate(RATE_HEALTH);

	if (getLevel() < 15)
		HealthIncreaseRate = sWorld->getRate(RATE_HEALTH) * (2.066f - (getLevel() * 0.066f));

	float addvalue = 0.0f;

	// polymorphed case
	if (IsPolymorphed())
		addvalue = (float)GetMaxHealth() / 3;
	// normal regen case (maybe partly in combat case)
	else if (!IsInCombat() || HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
	{
		addvalue = OCTRegenHPPerSpirit() * HealthIncreaseRate;
		if (!IsInCombat())
		{
			AuraEffectList const& mModHealthRegenPct = GetAuraEffectsByType(SPELL_AURA_MOD_HEALTH_REGEN_PERCENT);
			for (AuraEffectList::const_iterator i = mModHealthRegenPct.begin(); i != mModHealthRegenPct.end(); ++i)
				AddPct(addvalue, (*i)->GetAmount());

			addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_REGEN) * 2 * IN_MILLISECONDS / (5 * IN_MILLISECONDS);
		}
		else if (HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
			ApplyPct(addvalue, GetTotalAuraModifier(SPELL_AURA_MOD_REGEN_DURING_COMBAT));

		if (!IsStandState())
			addvalue *= 1.5f;
	}

	// always regeneration bonus (including combat)
	addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT);
	addvalue += m_baseHealthRegen / 2.5f;

	if (addvalue < 0)
		addvalue = 0;

	ModifyHealth(int32(addvalue));
}

void Player::ResetAllPowers()
{
	SetHealth(GetMaxHealth());
	switch (getPowerType())
	{
	case POWER_MANA:
		SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
		break;
	case POWER_RAGE:
		SetPower(POWER_RAGE, 0);
		break;
	case POWER_ENERGY:
		SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
		break;
	case POWER_RUNIC_POWER:
		SetPower(POWER_RUNIC_POWER, 0);
		break;
	default:
		break;
	}
}

bool Player::CanInteractWithQuestGiver(Object* questGiver)
{
	switch (questGiver->GetTypeId())
	{
	case TYPEID_UNIT:
		return GetNPCIfCanInteractWith(questGiver->GetGUID(), UNIT_NPC_FLAG_QUESTGIVER) != NULL;
	case TYPEID_GAMEOBJECT:
		return GetGameObjectIfCanInteractWith(questGiver->GetGUID(), GAMEOBJECT_TYPE_QUESTGIVER) != NULL;
	case TYPEID_PLAYER:
		return IsAlive() && questGiver->ToPlayer()->IsAlive();
	case TYPEID_ITEM:
		return IsAlive();
	default:
		break;
	}
	return false;
}

Creature* Player::GetNPCIfCanInteractWith(uint64 guid, uint32 npcflagmask)
{
	// unit checks
	if (!guid)
		return NULL;

	if (!IsInWorld())
		return NULL;

	if (IsInFlight())
		return NULL;

	// exist (we need look pets also for some interaction (quest/etc)
	Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
	if (!creature)
		return NULL;

	// Deathstate checks
	if (!IsAlive() && !(creature->GetCreatureTemplate()->type_flags & CREATURE_TYPEFLAGS_GHOST))
		return NULL;

	// alive or spirit healer
	if (!creature->IsAlive() && !(creature->GetCreatureTemplate()->type_flags & CREATURE_TYPEFLAGS_DEAD_INTERACT))
		return NULL;

	// appropriate npc type
	if (npcflagmask && !creature->HasFlag(UNIT_NPC_FLAGS, npcflagmask))
		return NULL;

	// not allow interaction under control, but allow with own pets
	if (creature->GetCharmerGUID())
		return NULL;

	// xinef: perform better check
	if (creature->GetReactionTo(this) <= REP_UNFRIENDLY)
		return NULL;

	// xinef: not needed, CORRECTLY checked above including forced reputations etc
	// not unfriendly
	//if (FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(creature->getFaction()))
	//    if (factionTemplate->faction)
	//        if (FactionEntry const* faction = sFactionStore.LookupEntry(factionTemplate->faction))
	//            if (faction->reputationListID >= 0 && GetReputationMgr().GetRank(faction) <= REP_UNFRIENDLY)
	//                return NULL;

	// not too far
	if (!creature->IsWithinDistInMap(this, INTERACTION_DISTANCE))
		return NULL;

	// pussywizard: many npcs have missing conditions for class training and rogue trainer can for eg. train dual wield to a shaman :/ too many to change in sql and watch in the future
	// pussywizard: this function is not used when talking, but when already taking action (buy spell, reset talents, show spell list)
	if (npcflagmask & (UNIT_NPC_FLAG_TRAINER | UNIT_NPC_FLAG_TRAINER_CLASS) && creature->GetCreatureTemplate()->trainer_type == TRAINER_TYPE_CLASS && getClass() != creature->GetCreatureTemplate()->trainer_class)
		return NULL;

	return creature;
}

GameObject* Player::GetGameObjectIfCanInteractWith(uint64 guid, GameobjectTypes type) const
{
	if (GameObject* go = GetMap()->GetGameObject(guid))
	{
		if (go->GetGoType() == type)
		{
			if (go->IsWithinDistInMap(this, go->GetInteractionDistance()))
				return go;

			;//sLog->outDebug(LOG_FILTER_MAPS, "IsGameObjectOfTypeInRange: GameObject '%s' [GUID: %u] is too far away from player %s [GUID: %u] to be used by him (distance=%f, maximal 10 is allowed)", go->GetGOInfo()->name.c_str(),
			//    go->GetGUIDLow(), GetName().c_str(), GetGUIDLow(), go->GetDistance(this));
		}
	}
	return NULL;
}

bool Player::IsInWater(bool allowAbove) const
{
	if (m_isInWater || !allowAbove)
		return m_isInWater;

	float distsq = GetExactDistSq(&m_last_environment_position);
	if (distsq < 3.0f*3.0f)
		return m_last_islittleabovewater_status;
	else
	{
		LiquidData liqData; liqData.level = INVALID_HEIGHT;
		const_cast<Position*>(&m_last_environment_position)->Relocate(GetPositionX(), GetPositionY(), GetPositionZ());
		bool inWater = GetBaseMap()->IsInWater(GetPositionX(), GetPositionY(), GetPositionZ(), &liqData);
		*(const_cast<bool*>(&m_last_islittleabovewater_status)) = inWater || (liqData.level > INVALID_HEIGHT && liqData.level > liqData.depth_level && liqData.level <= GetPositionZ() + 3.0f && liqData.level > GetPositionZ() - 1.0f);
		return m_last_islittleabovewater_status;
	}
}

bool Player::IsUnderWater() const
{
	return IsInWater() &&
		GetPositionZ() < (GetBaseMap()->GetWaterLevel(GetPositionX(), GetPositionY()) - 2);
}

bool Player::IsFalling() const
{
	// Xinef: Added !IsInFlight check
	return GetPositionZ() < m_lastFallZ && !IsInFlight();
}

void Player::SetInWater(bool apply)
{
	if (m_isInWater == apply)
		return;

	//define player in water by opcodes
	//move player's guid into HateOfflineList of those mobs
	//which can't swim and move guid back into ThreatList when
	//on surface.
	//TODO: exist also swimming mobs, and function must be symmetric to enter/leave water
	m_isInWater = apply;

	// remove auras that need water/land
	RemoveAurasWithInterruptFlags(apply ? AURA_INTERRUPT_FLAG_NOT_ABOVEWATER : AURA_INTERRUPT_FLAG_NOT_UNDERWATER);

	getHostileRefManager().updateThreatTables();
}

bool Player::IsInAreaTriggerRadius(const AreaTriggerEntry* trigger) const
{
	if (!trigger || GetMapId() != trigger->mapid)
		return false;

	if (trigger->radius > 0.f)
	{
		// if we have radius check it
		float dist = GetDistance(trigger->x, trigger->y, trigger->z);
		if (dist > trigger->radius)
			return false;
	}
	else
	{
		Position center = { trigger->x, trigger->y, trigger->z, trigger->box_orientation };
		if (!IsWithinBox(center, trigger->box_x / 2.f, trigger->box_y / 2.f, trigger->box_z / 2.f))
			return false;
	}

	return true;
}

void Player::SetGameMaster(bool on)
{
	if (on)
	{
		m_ExtraFlags |= PLAYER_EXTRA_GM_ON;
		if (AccountMgr::IsGMAccount(GetSession()->GetSecurity()))
			setFaction(35);
		SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_GM);
		SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_ALLOW_CHEAT_SPELLS);

		if (Pet* pet = GetPet())
		{
			if (AccountMgr::IsGMAccount(GetSession()->GetSecurity()))
				pet->setFaction(35);
			pet->getHostileRefManager().setOnlineOfflineState(false);
		}

		RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
		ResetContestedPvP();

		getHostileRefManager().setOnlineOfflineState(false);
		CombatStopWithPets();

		SetPhaseMask(uint32(PHASEMASK_ANYWHERE), false);    // see and visible in all phases
		m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GM, GetSession()->GetSecurity());
	}
	else
	{
		// restore phase
		uint32 newPhase = 0;
		AuraEffectList const& phases = GetAuraEffectsByType(SPELL_AURA_PHASE);
		if (!phases.empty())
			for (AuraEffectList::const_iterator itr = phases.begin(); itr != phases.end(); ++itr)
				newPhase |= (*itr)->GetMiscValue();

		if (!newPhase)
			newPhase = PHASEMASK_NORMAL;

		SetPhaseMask(newPhase, false);

		m_ExtraFlags &= ~PLAYER_EXTRA_GM_ON;
		setFactionForRace(getRace(true));
		RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GM);
		RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_ALLOW_CHEAT_SPELLS);

		if (Pet* pet = GetPet())
		{
			pet->setFaction(getFaction());
			pet->getHostileRefManager().setOnlineOfflineState(true);
		}

		// restore FFA PvP Server state
		if (sWorld->IsFFAPvPRealm())
			SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);

		// restore FFA PvP area state, remove not allowed for GM mounts
		UpdateArea(m_areaUpdateId);

		getHostileRefManager().setOnlineOfflineState(true);
		m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_PLAYER);
	}

	UpdateObjectVisibility();
}

void Player::SetGMVisible(bool on)
{
	if (on)
	{
		m_ExtraFlags &= ~PLAYER_EXTRA_GM_INVISIBLE;         //remove flag
		m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_PLAYER);
	}
	else
	{
		m_ExtraFlags |= PLAYER_EXTRA_GM_INVISIBLE;          //add flag

		SetAcceptWhispers(false);
		SetGameMaster(true);

		m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, GetSession()->GetSecurity());
	}
}

bool Player::IsGroupVisibleFor(Player const* p) const
{
	switch (sWorld->getIntConfig(CONFIG_GROUP_VISIBILITY))
	{
	default: return IsInSameGroupWith(p);
	case 1:  return IsInSameRaidWith(p);
	case 2:  return GetTeamId() == p->GetTeamId();
	}
}

bool Player::IsInSameGroupWith(Player const* p) const
{
	return p == this || (GetGroup() != NULL &&
		GetGroup() == p->GetGroup() &&
		GetGroup()->SameSubGroup(this, p));
}

///- If the player is invited, remove him. If the group if then only 1 person, disband the group.
/// \todo Shouldn't we also check if there is no other invitees before disbanding the group?
void Player::UninviteFromGroup()
{
	Group* group = GetGroupInvite();
	if (!group)
		return;

	group->RemoveInvite(this);

	if (group->GetMembersCount() <= 1)                       // group has just 1 member => disband
	{
		if (group->IsCreated())
		{
			group->Disband(true);
			group = NULL; // gets deleted in disband
		}
		else
		{
			group->RemoveAllInvites();
			delete group;
			group = NULL;
		}
	}
}

void Player::RemoveFromGroup(Group* group, uint64 guid, RemoveMethod method /* = GROUP_REMOVEMETHOD_DEFAULT*/, uint64 kicker /* = 0 */, const char* reason /* = NULL */)
{
	if (group)
	{
		group->RemoveMember(guid, method, kicker, reason);
		group = NULL;
	}
}

void Player::SendLogXPGain(uint32 GivenXP, Unit* victim, uint32 BonusXP, bool recruitAFriend, float /*group_rate*/)
{
	WorldPacket data(SMSG_LOG_XPGAIN, 22); // guess size?
	data << uint64(victim ? victim->GetGUID() : 0);         // guid
	data << uint32(GivenXP + BonusXP);                      // given experience
	data << uint8(victim ? 0 : 1);                          // 00-kill_xp type, 01-non_kill_xp type

	if (victim)
	{
		data << uint32(GivenXP);                            // experience without bonus

		// should use group_rate here but can't figure out how
		data << float(1);                                   // 1 - none 0 - 100% group bonus output
	}

	data << uint8(recruitAFriend ? 1 : 0);                  // does the GivenXP include a RaF bonus?
	GetSession()->SendPacket(&data);
}

void Player::GiveXP(uint32 xp, Unit* victim, float group_rate)
{
	if (xp < 1)
		return;

	if (!IsAlive() && !GetBattlegroundId())
		return;

	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN))
		return;

	if (victim && victim->GetTypeId() == TYPEID_UNIT && !victim->ToCreature()->hasLootRecipient())
		return;

	uint8 level = getLevel();

	sScriptMgr->OnGivePlayerXP(this, xp, victim);

	// Favored experience increase START
	uint32 zone = GetZoneId();
	float favored_exp_mult = 0;
	if ((zone == 3483 || zone == 3562 || zone == 3836 || zone == 3713 || zone == 3714) && (HasAura(32096) || HasAura(32098)))
		favored_exp_mult = 0.05f; // Thrallmar's Favor and Honor Hold's Favor

	xp = uint32(xp * (1 + favored_exp_mult));
	// Favored experience increase END

	// XP to money conversion processed in Player::RewardQuest
	if (level >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
		return;

	uint32 bonus_xp = 0;
	bool recruitAFriend = GetsRecruitAFriendBonus(true);

	// RaF does NOT stack with rested experience
	if (recruitAFriend)
		bonus_xp = 2 * xp; // xp + bonus_xp must add up to 3 * xp for RaF; calculation for quests done client-side
	else
		bonus_xp = victim ? GetXPRestBonus(xp) : 0; // XP resting bonus

	SendLogXPGain(xp, victim, bonus_xp, recruitAFriend, group_rate);

	uint32 curXP = GetUInt32Value(PLAYER_XP);
	uint32 nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
	uint32 newXP = curXP + xp + bonus_xp;

	while (newXP >= nextLvlXP && level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
	{
		newXP -= nextLvlXP;

		if (level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
			GiveLevel(level + 1);

		level = getLevel();
		nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
	}

	SetUInt32Value(PLAYER_XP, newXP);
}

// Update player to next level
// Current player experience not update (must be update by caller)
void Player::GiveLevel(uint8 level)
{
	uint8 oldLevel = getLevel();
	if (level == oldLevel)
		return;

	if (Guild* guild = GetGuild())
		guild->UpdateMemberData(this, GUILD_MEMBER_DATA_LEVEL, level);

	PlayerLevelInfo info;
	sObjectMgr->GetPlayerLevelInfo(getRace(true), getClass(), level, &info);

	PlayerClassLevelInfo classInfo;
	sObjectMgr->GetPlayerClassLevelInfo(getClass(), level, &classInfo);

	// send levelup info to client
	WorldPacket data(SMSG_LEVELUP_INFO, (4 + 4 + MAX_POWERS * 4 + MAX_STATS * 4));
	data << uint32(level);
	data << uint32(int32(classInfo.basehealth) - int32(GetCreateHealth()));
	// for (int i = 0; i < MAX_POWERS; ++i)                  // Powers loop (0-6)
	data << uint32(int32(classInfo.basemana) - int32(GetCreateMana()));
	data << uint32(0);
	data << uint32(0);
	data << uint32(0);
	data << uint32(0);
	data << uint32(0);
	data << uint32(0);
	// end for
	for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)          // Stats loop (0-4)
		data << uint32(int32(info.stats[i]) - GetCreateStat(Stats(i)));

	GetSession()->SendPacket(&data);

	SetUInt32Value(PLAYER_NEXT_LEVEL_XP, sObjectMgr->GetXPForLevel(level));

	//update level, max level of skills
	m_Played_time[PLAYED_TIME_LEVEL] = 0;                   // Level Played Time reset

	_ApplyAllLevelScaleItemMods(false);

	SetLevel(level);

	UpdateSkillsForLevel();

	// save base values (bonuses already included in stored stats
	for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
		SetCreateStat(Stats(i), info.stats[i]);

	SetCreateHealth(classInfo.basehealth);
	SetCreateMana(classInfo.basemana);

	InitTalentForLevel();
	InitTaxiNodesForLevel();
	InitGlyphsForLevel();

	UpdateAllStats();

	if (sWorld->getBoolConfig(CONFIG_ALWAYS_MAXSKILL)) // Max weapon skill when leveling up
		UpdateSkillsToMaxSkillsForLevel();

	// set current level health and mana/energy to maximum after applying all mods.
	SetFullHealth();
	SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
	SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
	if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
		SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
	SetPower(POWER_FOCUS, 0);
	SetPower(POWER_HAPPINESS, 0);

	_ApplyAllLevelScaleItemMods(true);

	// update level to hunter/summon pet
	if (Pet* pet = GetPet())
		pet->SynchronizeLevelWithOwner();

	if (MailLevelReward const* mailReward = sObjectMgr->GetMailLevelReward(level, getRaceMask()))
	{
		//- TODO: Poor design of mail system
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		MailDraft(mailReward->mailTemplateId).SendMailTo(trans, this, MailSender(MAIL_CREATURE, mailReward->senderEntry));
		CharacterDatabase.CommitTransaction(trans);
	}

	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL);

	// Refer-A-Friend
	if (GetSession()->GetRecruiterId())
		if (level < sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
			if (level % 2 == 0)
			{
				++m_grantableLevels;

				if (!HasByteFlag(PLAYER_FIELD_BYTES, 1, 0x01))
					SetByteFlag(PLAYER_FIELD_BYTES, 1, 0x01);
			}

	sScriptMgr->OnPlayerLevelChanged(this, oldLevel);
}

void Player::InitTalentForLevel()
{
	uint8 level = getLevel();
	uint32 talentPointsForLevel = CalculateTalentsPoints();

	// xinef: more talent points that we have are used, reset
	if (m_usedTalentCount > talentPointsForLevel)
		resetTalents(true);
	// xinef: else, recalculate free talent points count
	else
		SetFreeTalentPoints(talentPointsForLevel - m_usedTalentCount);

	if (!GetSession()->PlayerLoading())
		SendTalentsInfoData(false);                         // update at client
}

void Player::InitStatsForLevel(bool reapplyMods)
{
	if (reapplyMods)                                        //reapply stats values only on .reset stats (level) command
		_RemoveAllStatBonuses();

	PlayerClassLevelInfo classInfo;
	sObjectMgr->GetPlayerClassLevelInfo(getClass(), getLevel(), &classInfo);

	PlayerLevelInfo info;
	sObjectMgr->GetPlayerLevelInfo(getRace(true), getClass(), getLevel(), &info);

	SetUInt32Value(PLAYER_FIELD_MAX_LEVEL, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
	SetUInt32Value(PLAYER_NEXT_LEVEL_XP, sObjectMgr->GetXPForLevel(getLevel()));

	// reset before any aura state sources (health set/aura apply)
	SetUInt32Value(UNIT_FIELD_AURASTATE, 0);

	UpdateSkillsForLevel();

	// set default cast time multiplier
	SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

	// reset size before reapply auras
	SetObjectScale(1.0f);

	// save base values (bonuses already included in stored stats
	for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
		SetCreateStat(Stats(i), info.stats[i]);

	for (uint8 i = STAT_STRENGTH; i < MAX_STATS; ++i)
		SetStat(Stats(i), info.stats[i]);

	SetCreateHealth(classInfo.basehealth);

	//set create powers
	SetCreateMana(classInfo.basemana);

	SetArmor(int32(m_createStats[STAT_AGILITY] * 2));

	InitStatBuffMods();

	//reset rating fields values
	for (uint16 index = PLAYER_FIELD_COMBAT_RATING_1; index < PLAYER_FIELD_COMBAT_RATING_1 + MAX_COMBAT_RATING; ++index)
		SetUInt32Value(index, 0);

	SetUInt32Value(PLAYER_FIELD_MOD_HEALING_DONE_POS, 0);
	for (uint8 i = 0; i < 7; ++i)
	{
		SetInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + i, 0);
		SetInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + i, 0);
		SetFloatValue(PLAYER_FIELD_MOD_DAMAGE_DONE_PCT + i, 1.00f);
	}

	//reset attack power, damage and attack speed fields
	SetFloatValue(UNIT_FIELD_BASEATTACKTIME, 2000.0f);
	SetFloatValue(UNIT_FIELD_BASEATTACKTIME + 1, 2000.0f); // offhand attack time
	SetFloatValue(UNIT_FIELD_RANGEDATTACKTIME, 2000.0f);

	SetFloatValue(UNIT_FIELD_MINDAMAGE, 0.0f);
	SetFloatValue(UNIT_FIELD_MAXDAMAGE, 0.0f);
	SetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE, 0.0f);
	SetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE, 0.0f);
	SetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE, 0.0f);
	SetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE, 0.0f);

	SetInt32Value(UNIT_FIELD_ATTACK_POWER, 0);
	SetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS, 0);
	SetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER, 0.0f);
	SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER, 0);
	SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER_MODS, 0);
	SetFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER, 0.0f);

	// Base crit values (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
	SetFloatValue(PLAYER_CRIT_PERCENTAGE, 0.0f);
	SetFloatValue(PLAYER_OFFHAND_CRIT_PERCENTAGE, 0.0f);
	SetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE, 0.0f);

	// Init spell schools (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
	for (uint8 i = 0; i < 7; ++i)
		SetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1 + i, 0.0f);

	SetFloatValue(PLAYER_PARRY_PERCENTAGE, 0.0f);
	SetFloatValue(PLAYER_BLOCK_PERCENTAGE, 0.0f);
	SetUInt32Value(PLAYER_SHIELD_BLOCK, 0);

	// Dodge percentage
	SetFloatValue(PLAYER_DODGE_PERCENTAGE, 0.0f);

	// set armor (resistance 0) to original value (create_agility*2)
	SetArmor(int32(m_createStats[STAT_AGILITY] * 2));
	SetResistanceBuffMods(SpellSchools(0), true, 0.0f);
	SetResistanceBuffMods(SpellSchools(0), false, 0.0f);
	// set other resistance to original value (0)
	for (uint8 i = 1; i < MAX_SPELL_SCHOOL; ++i)
	{
		SetResistance(SpellSchools(i), 0);
		SetResistanceBuffMods(SpellSchools(i), true, 0.0f);
		SetResistanceBuffMods(SpellSchools(i), false, 0.0f);
	}

	SetUInt32Value(PLAYER_FIELD_MOD_TARGET_RESISTANCE, 0);
	SetUInt32Value(PLAYER_FIELD_MOD_TARGET_PHYSICAL_RESISTANCE, 0);
	for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
	{
		SetUInt32Value(UNIT_FIELD_POWER_COST_MODIFIER + i, 0);
		SetFloatValue(UNIT_FIELD_POWER_COST_MULTIPLIER + i, 0.0f);
	}
	// Reset no reagent cost field
	for (uint8 i = 0; i < 3; ++i)
		SetUInt32Value(PLAYER_NO_REAGENT_COST_1 + i, 0);
	// Init data for form but skip reapply item mods for form
	InitDataForForm(reapplyMods);

	// save new stats
	for (uint8 i = POWER_MANA; i < MAX_POWERS; ++i)
		SetMaxPower(Powers(i), uint32(GetCreatePowers(Powers(i))));

	SetMaxHealth(classInfo.basehealth);                     // stamina bonus will applied later

	// cleanup mounted state (it will set correctly at aura loading if player saved at mount.
	SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);

	// cleanup unit flags (will be re-applied if need at aura load).
	RemoveFlag(UNIT_FIELD_FLAGS,
		UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NOT_ATTACKABLE_1 |
		UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_LOOTING |
		UNIT_FLAG_PET_IN_COMBAT | UNIT_FLAG_SILENCED | UNIT_FLAG_PACIFIED |
		UNIT_FLAG_STUNNED | UNIT_FLAG_IN_COMBAT | UNIT_FLAG_DISARMED |
		UNIT_FLAG_CONFUSED | UNIT_FLAG_FLEEING | UNIT_FLAG_NOT_SELECTABLE |
		UNIT_FLAG_SKINNABLE | UNIT_FLAG_MOUNT | UNIT_FLAG_TAXI_FLIGHT);
	SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);   // must be set

	SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_REGENERATE_POWER);// must be set

	// cleanup player flags (will be re-applied if need at aura load), to avoid have ghost flag without ghost aura, for example.
	RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK | PLAYER_FLAGS_DND | PLAYER_FLAGS_GM | PLAYER_FLAGS_GHOST | PLAYER_ALLOW_ONLY_ABILITY);

	RemoveStandFlags(UNIT_STAND_FLAGS_ALL);                 // one form stealth modified bytes
	RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP | UNIT_BYTE2_FLAG_SANCTUARY);

	// restore if need some important flags
	SetUInt32Value(PLAYER_FIELD_BYTES2, 0);                 // flags empty by default

	if (reapplyMods)                                        // reapply stats values only on .reset stats (level) command
		_ApplyAllStatBonuses();

	// set current level health and mana/energy to maximum after applying all mods.
	SetFullHealth();
	SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
	SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
	if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
		SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
	SetPower(POWER_FOCUS, 0);
	SetPower(POWER_HAPPINESS, 0);
	SetPower(POWER_RUNIC_POWER, 0);

	// update level to hunter/summon pet
	if (Pet* pet = GetPet())
		pet->SynchronizeLevelWithOwner();
}

void Player::SendInitialSpells()
{
	uint32 curTime = World::GetGameTimeMS();
	uint32 infTime = World::GetGameTimeMS() + infinityCooldownDelayCheck;

	uint16 spellCount = 0;

	WorldPacket data(SMSG_INITIAL_SPELLS, (1 + 2 + 4 * m_spells.size() + 2 + m_spellCooldowns.size()*(4 + 2 + 2 + 4 + 4)));
	data << uint8(0);

	size_t countPos = data.wpos();
	data << uint16(spellCount);                             // spell count placeholder

	for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		if (!itr->second->Active || !itr->second->IsInSpec(GetActiveSpec()))
			continue;

		data << uint32(itr->first);
		data << uint16(0);                                  // it's not slot id

		++spellCount;
	}

	// xinef: we have to send talents, but not those on m_spells list
	for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		// xinef: remove all active talent auras
		if (!(itr->second->specMask & GetActiveSpecMask()))
			continue;

		// xinef: already sent from m_spells
		if (itr->second->inSpellBook)
			continue;

		data << uint32(itr->first);
		data << uint16(0);                                  // it's not slot id

		++spellCount;
	}

	data.put<uint16>(countPos, spellCount);                  // write real count value

	uint16 spellCooldowns = m_spellCooldowns.size();
	data << uint16(spellCooldowns);
	for (SpellCooldowns::const_iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); ++itr)
	{
		if (!itr->second.needSendToClient)
			continue;

		SpellInfo const* sEntry = sSpellMgr->GetSpellInfo(itr->first);
		if (!sEntry)
			continue;

		data << uint32(itr->first);

		data << uint16(itr->second.itemid);                 // cast item id
		data << uint16(sEntry->GetCategory());              // spell category

		// send infinity cooldown in special format
		if (itr->second.end >= infTime)
		{
			data << uint32(1);                              // cooldown
			data << uint32(0x80000000);                     // category cooldown
			continue;
		}

		uint32 cooldown = itr->second.end > curTime ? itr->second.end - curTime : 0;

		if (!sEntry->GetCategory() || (sEntry->CategoryRecoveryTime != sEntry->RecoveryTime && sEntry->RecoveryTime && sEntry->CategoryRecoveryTime))                          // may be wrong, but anyway better than nothing...
		{
			data << cooldown;                               // cooldown
			data << uint32(0);                              // category cooldown
		}
		else
		{
			data << uint32(0);                              // cooldown
			data << cooldown;                               // category cooldown
		}
	}

	GetSession()->SendPacket(&data);
}

void Player::RemoveMail(uint32 id)
{
	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
	{
		if ((*itr)->messageID == id)
		{
			//do not delete item, because Player::removeMail() is called when returning mail to sender.
			m_mail.erase(itr);
			return;
		}
	}
}

void Player::SendMailResult(uint32 mailId, MailResponseType mailAction, MailResponseResult mailError, uint32 equipError, uint32 item_guid, uint32 item_count)
{
	WorldPacket data(SMSG_SEND_MAIL_RESULT, (4 + 4 + 4 + (mailError == MAIL_ERR_EQUIP_ERROR ? 4 : (mailAction == MAIL_ITEM_TAKEN ? 4 + 4 : 0))));
	data << (uint32)mailId;
	data << (uint32)mailAction;
	data << (uint32)mailError;
	if (mailError == MAIL_ERR_EQUIP_ERROR)
		data << (uint32)equipError;
	else if (mailAction == MAIL_ITEM_TAKEN)
	{
		data << (uint32)item_guid;                         // item guid low?
		data << (uint32)item_count;                        // item count?
	}
	GetSession()->SendPacket(&data);
}

void Player::SendNewMail()
{
	// deliver undelivered mail
	WorldPacket data(SMSG_RECEIVED_MAIL, 4);
	data << (uint32)0;
	GetSession()->SendPacket(&data);
}

void Player::UpdateNextMailTimeAndUnreads()
{
	// calculate next delivery time (min. from non-delivered mails
	// and recalculate unReadMail
	time_t cTime = time(NULL);
	m_nextMailDelivereTime = 0;
	unReadMails = 0;
	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
	{
		if ((*itr)->deliver_time > cTime)
		{
			if (!m_nextMailDelivereTime || m_nextMailDelivereTime > (*itr)->deliver_time)
				m_nextMailDelivereTime = (*itr)->deliver_time;
		}
		else if (((*itr)->checked & MAIL_CHECK_MASK_READ) == 0)
			++unReadMails;
	}
}

void Player::AddNewMailDeliverTime(time_t deliver_time)
{
	if (deliver_time <= time(NULL))                          // ready now
	{
		++unReadMails;
		SendNewMail();
	}
	else                                                    // not ready and no have ready mails
	{
		if (!m_nextMailDelivereTime || m_nextMailDelivereTime > deliver_time)
			m_nextMailDelivereTime = deliver_time;
	}
}

bool Player::addTalent(uint32 spellId, uint8 addSpecMask, uint8 oldTalentRank)
{
	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	if (!SpellMgr::CheckSpellValid(spellInfo, spellId, true))
		return false;

	TalentSpellPos const* talentPos = GetTalentSpellPos(spellId);
	if (!talentPos)
		return false;

	TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentPos->talent_id);
	if (!talentInfo)
		return false;

	// xinef: remove old talent rank if any
	if (oldTalentRank)
	{
		_removeTalent(talentInfo->RankID[oldTalentRank - 1], addSpecMask);
		_removeTalentAurasAndSpells(talentInfo->RankID[oldTalentRank - 1]);
		SendLearnPacket(talentInfo->RankID[oldTalentRank - 1], false);
	}

	// xinef: add talent auras and spells
	if (GetActiveSpecMask() & addSpecMask)
		_addTalentAurasAndSpells(spellId);

	// xinef: find the spell on our talent map
	PlayerTalentMap::iterator itr = m_talents.find(spellId);

	// xinef: we do not have such a spell on our talent map
	if (itr == m_talents.end())
	{
		PlayerSpellState state = isBeingLoaded() ? PLAYERSPELL_UNCHANGED : PLAYERSPELL_NEW;
		PlayerTalent* newTalent = new PlayerTalent();
		newTalent->State = state;
		newTalent->specMask = addSpecMask;
		newTalent->talentID = talentInfo->TalentID;
		newTalent->inSpellBook = talentInfo->addToSpellBook && !spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL);

		m_talents[spellId] = newTalent;
		return true;
	}
	// xinef: if current mask does not cover addMask, add it to iterator and save changes to DB
	else if (!(itr->second->specMask & addSpecMask))
	{
		itr->second->specMask |= addSpecMask;
		if (itr->second->State != PLAYERSPELL_NEW)
			itr->second->State = PLAYERSPELL_CHANGED;

		return true;
	}
	// xinef: error case, trying to add already present talent with present mask
	else
	{
		sLog->outError("Player (%u) tries to learn talent %u with covered specMask (curr: %u, add: %u)", GetGUIDLow(), spellId, itr->second->specMask, addSpecMask);
	}

	return false;
}

void Player::_removeTalent(uint32 spellId, uint8 specMask)
{
	PlayerTalentMap::iterator itr = m_talents.find(spellId);
	if (itr == m_talents.end() || itr->second->State == PLAYERSPELL_REMOVED)
		return;

	_removeTalent(itr, specMask);
}

void Player::_removeTalent(PlayerTalentMap::iterator& itr, uint8 specMask)
{
	// xinef: remove spec mask from iterator
	itr->second->specMask &= ~specMask;

	// xinef: if talent is not present in any spec - remove
	if (itr->second->specMask == 0)
	{
		if (itr->second->State == PLAYERSPELL_NEW)
		{
			delete itr->second;
			m_talents.erase(itr);
			return;
		}
		else
			itr->second->State = PLAYERSPELL_REMOVED;
	}
	// xinef: otherwise save changes to DB
	else if (itr->second->State != PLAYERSPELL_NEW)
		itr->second->State = PLAYERSPELL_CHANGED;
}

void Player::_removeTalentAurasAndSpells(uint32 spellId)
{
	RemoveOwnedAura(spellId);

	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
	{
		// pussywizard: remove pet auras
		if (PetAura const* petSpell = sSpellMgr->GetPetAura(spellId, i))
			RemovePetAura(petSpell);

		// pussywizard: remove all triggered auras
		if (spellInfo->Effects[i].TriggerSpell > 0)
			RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);

		// xinef: remove temporary spells added by talent
		// xinef: recursively remove all learnt spells
		if (spellInfo->Effects[i].TriggerSpell > 0 && spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
		{
			removeSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, true);
			_removeTalentAurasAndSpells(spellInfo->Effects[i].TriggerSpell);
		}
	}
}

void Player::_addTalentAurasAndSpells(uint32 spellId)
{
	// pussywizard: spells learnt from talents are added as TEMPORARY, so not saved to db (only the talent itself is saved)
	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
	{
		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
			if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL && !sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
				_addSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, true);
	}
	else if (spellInfo->IsPassive() || (spellInfo->HasAttribute(SPELL_ATTR0_HIDDEN_CLIENTSIDE) && spellInfo->Stances))
	{
		if (IsNeedCastPassiveSpellAtLearn(spellInfo))
			CastSpell(this, spellId, true);
	}
}

void Player::SendLearnPacket(uint32 spellId, bool learn)
{
	if (learn)
	{
		WorldPacket data(SMSG_LEARNED_SPELL, 6);
		data << uint32(spellId);
		data << uint16(0);
		GetSession()->SendPacket(&data);
	}
	else
	{
		WorldPacket data(SMSG_REMOVED_SPELL, 4);
		data << uint32(spellId);
		GetSession()->SendPacket(&data);
	}
}

bool Player::addSpell(uint32 spellId, uint8 addSpecMask, bool updateActive, bool temporary)
{
	if (!_addSpell(spellId, addSpecMask, temporary))
		return false;

	if (!updateActive)
		return true;

	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId); // must exist, checked in _addSpell

	// pussywizard: now update active state for all ranks of this spell! and send packet to swap on action bar
	// pussywizard: assumption - it's in all specs, can't be a talent
	if (!spellInfo->IsStackableWithRanks() && spellInfo->IsRanked())
	{
		SpellInfo const* nextSpellInfo = sSpellMgr->GetSpellInfo(sSpellMgr->GetFirstSpellInChain(spellInfo->Id));
		while (nextSpellInfo)
		{
			PlayerSpellMap::iterator itr = m_spells.find(nextSpellInfo->Id);
			if (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->Active)
			{
				if (nextSpellInfo->GetRank() < spellInfo->GetRank())
				{
					itr->second->Active = false;
					if (IsInWorld())
					{
						WorldPacket data(SMSG_SUPERCEDED_SPELL, 4 + 4);
						data << uint32(nextSpellInfo->Id);
						data << uint32(spellInfo->Id);
						GetSession()->SendPacket(&data);
					}
					return false;
				}
				else if (nextSpellInfo->GetRank() > spellInfo->GetRank())
				{
					PlayerSpellMap::iterator itr2 = m_spells.find(spellInfo->Id);
					if (itr2 != m_spells.end())
						itr2->second->Active = false;
					return false;
				}
			}
			nextSpellInfo = nextSpellInfo->GetNextRankSpell();
		}
	}

	return true;
}

bool Player::_addSpell(uint32 spellId, uint8 addSpecMask, bool temporary)
{
	// pussywizard: this can be called to OVERWRITE currently existing spell params! usually to set active = false for lower ranks of a spell

	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	if (!SpellMgr::CheckSpellValid(spellInfo, spellId, false))
		return false;

	// pussywizard: already found and temporary, nothing to do
	PlayerSpellMap::iterator itr = m_spells.find(spellId);
	if (itr != m_spells.end() && itr->second->State == PLAYERSPELL_TEMPORARY)
		return false;

	// xinef: send packet so client can properly recognize this new spell
	// xinef: ignore passive spells and spells with learn effect
	// xinef: send spells with no aura effects (ie dual wield)
	if (IsInWorld() && !isBeingLoaded() && temporary && (!spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_HIDDEN_CLIENTSIDE)) || !spellInfo->HasAnyAura()) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
		SendLearnPacket(spellInfo->Id, true);

	// xinef: DO NOT allow to learn spell with effect learn spell!
	// xinef: if spell possess spell learn effects only, learn those spells as temporary (eg. Metamorphosis, Tree of Life)
	if (temporary && spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
	{
		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
			if (spellInfo->Effects[i].IsEffect())
			{
				if (spellInfo->Effects[i].Effect != SPELL_EFFECT_LEARN_SPELL)
				{
					sLog->outString("TRYING TO LEARN SPELL WITH EFFECT LEARN: %u, PLAYER: %u", spellId, GetGUIDLow());
					return false;
					//ASSERT(false);
				}
				else if (const SpellInfo* learnSpell = sSpellMgr->GetSpellInfo(spellInfo->Effects[i].TriggerSpell))
					_addSpell(learnSpell->Id, SPEC_MASK_ALL, true);
			}

		return false;
	}

	if (itr != m_spells.end()) // pussywizard: already know this spell, so update information
	{
		// pussywizard: do nothing if already set as wanted
		if (itr->second->State != PLAYERSPELL_REMOVED && (itr->second->specMask & addSpecMask) == addSpecMask)
			return false;

		// pussywizard: need cast auras, learn linked spells, do professions stuff, etc.
		// pussywizard: but only for spells that are really added (inactive -> active OR added to current spec)
		bool spellIsNew = true;

		// pussywizard: present in m_spells, not removed, already in current spec, already active
		if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec))
			spellIsNew = false;

		// pussywizard: update info in m_spells
		if (itr->second->State != PLAYERSPELL_NEW && (itr->second->specMask & addSpecMask) != addSpecMask)
			itr->second->State = PLAYERSPELL_CHANGED;
		itr->second->Active = true;
		itr->second->specMask |= addSpecMask;

		if (!spellIsNew)
			return true;
	}
	else // pussywizard: not found in m_spells
	{
		PlayerSpell* newspell = new PlayerSpell;
		newspell->Active = true;
		newspell->State = temporary ? PLAYERSPELL_TEMPORARY : (isBeingLoaded() ? PLAYERSPELL_UNCHANGED : PLAYERSPELL_NEW);
		newspell->specMask = addSpecMask;

		m_spells[spellId] = newspell;
	}

	// pussywizard: return if spell not in current spec
	// pussywizard: return true to fix active for ranks, this condition is true only at loading, so no problems with learning packets
	if (!((1 << GetActiveSpec()) & addSpecMask))
		return true;

	// xinef: do not add spells with effect learn spell
	if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
	{
		sLog->outString("TRYING TO LEARN SPELL WITH EFFECT LEARN 2: %u, PLAYER: %u", spellId, GetGUIDLow());
		m_spells.erase(spellInfo->Id); // mem leak, but should never happen
		return false;
		//ASSERT(false);
	}
	// pussywizard: cast passive spells (including all talents without SPELL_EFFECT_LEARN_SPELL) with additional checks
	else if (spellInfo->IsPassive() || (spellInfo->HasAttribute(SPELL_ATTR0_HIDDEN_CLIENTSIDE) && spellInfo->Stances))
	{
		if (IsNeedCastPassiveSpellAtLearn(spellInfo))
			CastSpell(this, spellId, true);
	}
	// pussywizard: cast and return, learnt spells will update profession count, etc.
	else if (spellInfo->HasEffect(SPELL_EFFECT_SKILL_STEP))
	{
		CastSpell(this, spellId, true);
		return false;
	}

	// xinef: unapply aura stats if dont meet requirements
	// xinef: handle only if player is not loaded, loading is handled in loadfromdb
	if (!isBeingLoaded())
		if (Aura* aura = GetAura(spellId))
		{
			if (aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_35_PERCENT ||
				aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTH_ABOVE_75_PERCENT ||
				aura->GetSpellInfo()->CasterAuraState == AURA_STATE_HEALTHLESS_20_PERCENT)
				if (!HasAuraState((AuraStateType)aura->GetSpellInfo()->CasterAuraState))
					aura->HandleAllEffects(aura->GetApplicationOfTarget(GetGUID()), AURA_EFFECT_HANDLE_REAL, false);
		}

	// pussywizard: update free primary prof points
	if (uint32 freeProfs = GetFreePrimaryProfessionPoints())
	{
		if (spellInfo->IsPrimaryProfessionFirstRank())
			SetFreePrimaryProfessions(freeProfs - 1);
	}

	// pussywizard: update 310 flyer speed
	if (!Has310Flyer(false))
		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
			if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED && spellInfo->Effects[i].CalcValue() == 310)
				SetHas310Flyer(true);

	uint16 maxskill = GetMaxSkillValueForLevel();
	SpellLearnSkillNode const* spellLearnSkill = sSpellMgr->GetSpellLearnSkill(spellId);
	SkillLineAbilityMapBounds skill_bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellId);
	// xinef: set appropriate skill value
	if (spellLearnSkill)
	{
		uint32 skill_value = GetPureSkillValue(spellLearnSkill->skill);
		uint32 skill_max_value = GetPureMaxSkillValue(spellLearnSkill->skill);
		uint32 new_skill_max_value = spellLearnSkill->maxvalue == 0 ? maxskill : spellLearnSkill->maxvalue;

		if (skill_value < spellLearnSkill->value)
			skill_value = spellLearnSkill->value;
		if (skill_max_value < new_skill_max_value)
			skill_max_value = new_skill_max_value;

		SetSkill(spellLearnSkill->skill, spellLearnSkill->step, skill_value, skill_max_value);
	}
	else
	{
		// pussywizard: checked, ok
		for (SkillLineAbilityMap::const_iterator _spell_idx = skill_bounds.first; _spell_idx != skill_bounds.second; ++_spell_idx)
		{
			SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->skillId);
			if (!pSkill || HasSkill(pSkill->id))
				continue;

			if (_spell_idx->second->learnOnGetSkill == ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL || // pussywizard: learning autolearned spell from skill ensures having the skill
				((pSkill->id == SKILL_LOCKPICKING || pSkill->id == SKILL_RUNEFORGING) && _spell_idx->second->max_value == 0)) // pussywizard: learning any spell from lockpicking or runeforging ensures having the skill
			{
				switch (GetSkillRangeType(pSkill, _spell_idx->second->racemask != 0))
				{
				case SKILL_RANGE_LANGUAGE:
					SetSkill(pSkill->id, GetSkillStep(pSkill->id), 300, 300);
					break;
				case SKILL_RANGE_LEVEL:
					SetSkill(pSkill->id, GetSkillStep(pSkill->id), 1, GetMaxSkillValueForLevel());
					break;
				case SKILL_RANGE_MONO:
					SetSkill(pSkill->id, GetSkillStep(pSkill->id), 1, 1);
					break;
				default:
					break;
				}
			}
		}
	}

	// xinef: update achievement criteria
	if (!GetSession()->PlayerLoading())
	{
		for (SkillLineAbilityMap::const_iterator _spell_idx = skill_bounds.first; _spell_idx != skill_bounds.second; ++_spell_idx)
		{
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE, _spell_idx->second->skillId);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS, _spell_idx->second->skillId);
		}
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL, spellId);
	}

	return true;
}

bool Player::IsNeedCastPassiveSpellAtLearn(SpellInfo const* spellInfo) const
{
	// note: form passives activated with shapeshift spells be implemented by HandleShapeshiftBoosts instead of spell_learn_spell
	// talent dependent passives activated at form apply have proper stance data
	ShapeshiftForm form = GetShapeshiftForm();
	return (!spellInfo->Stances || (form && (spellInfo->Stances & (1 << (form - 1)))) ||
		(!form && spellInfo->HasAttribute(SPELL_ATTR2_NOT_NEED_SHAPESHIFT)));

}

void Player::learnSpell(uint32 spellId)
{
	// Xinef: don't allow to learn active spell once more
	if (HasActiveSpell(spellId))
	{
		sLog->outError("Player (%u) tries to learn already active spell: %u", GetGUIDLow(), spellId);
		return;
	}

	uint32 firstRankSpellId = sSpellMgr->GetFirstSpellInChain(spellId);
	bool thisSpec = GetTalentSpellCost(firstRankSpellId) > 0 || sSpellMgr->IsAdditionalTalentSpell(firstRankSpellId);
	bool added = addSpell(spellId, thisSpec ? GetActiveSpecMask() : SPEC_MASK_ALL, true);
	if (added && IsInWorld())
	{
		// pussywizard: a system message "you have learnt spell X (rank Y)"
		SendLearnPacket(spellId, true);
	}

	// pussywizard: rank stuff at the end!
	if (uint32 nextSpell = sSpellMgr->GetNextSpellInChain(spellId))
	{
		// pussywizard: lookup next rank in m_spells (the only talents on m_spella are for example pyroblast, that have all ranks restored upon learning rank 1)
		// pussywizard: next ranks must not be in current spec (otherwise no need to learn already learnt)
		PlayerSpellMap::iterator itr = m_spells.find(nextSpell);
		if (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && !itr->second->IsInSpec(m_activeSpec))
			learnSpell(nextSpell);
	}

	// xinef: if we learn new spell, check all spells requiring this spell, if we have such a spell, and it is not in current spec - learn it
	SpellsRequiringSpellMapBounds spellsRequiringSpell = sSpellMgr->GetSpellsRequiringSpellBounds(spellId);
	for (SpellsRequiringSpellMap::const_iterator itr = spellsRequiringSpell.first; itr != spellsRequiringSpell.second; ++itr)
	{
		PlayerSpellMap::iterator itr2 = m_spells.find(itr->second);
		if (itr2 != m_spells.end() && itr2->second->State != PLAYERSPELL_REMOVED && !itr2->second->IsInSpec(m_activeSpec))
			learnSpell(itr2->first);
	}
}

void Player::removeSpell(uint32 spellId, uint8 removeSpecMask, bool onlyTemporary)
{
	PlayerSpellMap::iterator itr = m_spells.find(spellId);
	if (itr == m_spells.end())
		return;

	// pussywizard: nothing to do if already removed or not in specs of removeSpecMask
	if (itr->second->State == PLAYERSPELL_REMOVED || (itr->second->specMask & removeSpecMask) == 0)
		return;

	// pussywizard: avoid any possible bugs
	if (onlyTemporary && itr->second->State != PLAYERSPELL_TEMPORARY)
		return;

	// pussywizard: remove non-talent higher ranks (recursive)
	// pussywizard: do this at the beginning, not in the middle of removing!
	if (uint32 nextSpell = sSpellMgr->GetNextSpellInChain(spellId))
		if (!GetTalentSpellPos(nextSpell))
			removeSpell(nextSpell, removeSpecMask, onlyTemporary);

	// xinef: if current spell has talentcost, remove spells requiring this spell
	uint32 firstRankSpellId = sSpellMgr->GetFirstSpellInChain(spellId);
	if (GetTalentSpellCost(firstRankSpellId))
	{
		SpellsRequiringSpellMapBounds spellsRequiringSpell = sSpellMgr->GetSpellsRequiringSpellBounds(spellId);
		for (SpellsRequiringSpellMap::const_iterator itr = spellsRequiringSpell.first; itr != spellsRequiringSpell.second; ++itr)
			removeSpell(itr->second, removeSpecMask, onlyTemporary);
	}

	// pussywizard: re-search, it can be corrupted in prev loop
	itr = m_spells.find(spellId);
	if (itr == m_spells.end())
		return;

	itr->second->specMask = (((uint8)itr->second->specMask) & ~removeSpecMask); // pussywizard: update specMask in map

	// pussywizard: some more conditions needed for spells like pyroblast (shouldn't be fully removed when not available in any spec, should stay in db with specMask = 0)
	if (GetTalentSpellCost(firstRankSpellId) == 0 && !sSpellMgr->IsAdditionalTalentSpell(firstRankSpellId) && itr->second->specMask == 0)
	{
		if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_TEMPORARY)
		{
			delete itr->second;
			m_spells.erase(itr);
		}
		else
			itr->second->State = PLAYERSPELL_REMOVED;
	}
	else if (itr->second->State != PLAYERSPELL_NEW && itr->second->State != PLAYERSPELL_TEMPORARY)
		itr->second->State = PLAYERSPELL_CHANGED;

	// xinef: this is used for talents and they are not removed in removeSpell function...
	// xinef: however ill leave this here just in case
	// pussywizard: remove owned aura obtained from currently removed spell
	RemoveOwnedAura(spellId);

	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
	{
		// pussywizard: remove pet auras
		if (PetAura const* petSpell = sSpellMgr->GetPetAura(spellId, i))
			RemovePetAura(petSpell);

		// pussywizard: remove all triggered auras
		if (spellInfo->Effects[i].TriggerSpell > 0)
			RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);
	}

	// pussywizard: update free primary prof points
	if (spellInfo->IsPrimaryProfessionFirstRank())
	{
		uint32 freeProfs = GetFreePrimaryProfessionPoints() + 1;
		if (freeProfs <= sWorld->getIntConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL))
			SetFreePrimaryProfessions(freeProfs);
	}

	// pussywizard: update 310 flyer
	if (Has310Flyer(false))
		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
			if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED && spellInfo->Effects[i].CalcValue() == 310)
				Has310Flyer(true, spellId);

	// pussywizard: remove dependent skill
	SpellLearnSkillNode const* spellLearnSkill = sSpellMgr->GetSpellLearnSkill(spellId);
	if (spellLearnSkill)
	{
		uint32 prev_spell = sSpellMgr->GetPrevSpellInChain(spellId);

		if (!prev_spell) // pussywizard: first rank, remove skill
			SetSkill(spellLearnSkill->skill, 0, 0, 0);
		else // pussywizard: search previous ranks
		{
			SpellLearnSkillNode const* prevSkill = sSpellMgr->GetSpellLearnSkill(prev_spell);
			while (!prevSkill && prev_spell)
			{
				prev_spell = sSpellMgr->GetPrevSpellInChain(prev_spell);
				prevSkill = sSpellMgr->GetSpellLearnSkill(sSpellMgr->GetFirstSpellInChain(prev_spell));
			}

			if (!prevSkill) // pussywizard: not found prev skill setting, remove skill
				SetSkill(spellLearnSkill->skill, 0, 0, 0);
			else // pussywizard: set to prev skill setting values
			{
				uint32 skill_value = GetPureSkillValue(prevSkill->skill);
				uint32 skill_max_value = GetPureMaxSkillValue(prevSkill->skill);
				uint32 new_skill_max_value = prevSkill->maxvalue == 0 ? GetMaxSkillValueForLevel() : prevSkill->maxvalue;

				if (skill_value > prevSkill->value)
					skill_value = prevSkill->value;
				if (skill_max_value > new_skill_max_value)
					skill_max_value = new_skill_max_value;

				SetSkill(prevSkill->skill, prevSkill->step, skill_value, skill_max_value);
			}
		}
	}
	else
	{
		// pussywizard: checked, ok
		SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellId);
		for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
		{
			SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->skillId);
			if (!pSkill)
				continue;

			// pussywizard: don't understand why whole skill is removed when just single spell from it is removed
			if (_spell_idx->second->learnOnGetSkill == ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL && pSkill->categoryId != SKILL_CATEGORY_CLASS || // pussywizard: don't unlearn class skills
				(pSkill->id == SKILL_LOCKPICKING || pSkill->id == SKILL_RUNEFORGING) && _spell_idx->second->max_value == 0)
			{
				// not reset skills for professions and racial abilities
				if ((pSkill->categoryId == SKILL_CATEGORY_SECONDARY || pSkill->categoryId == SKILL_CATEGORY_PROFESSION) && (IsProfessionSkill(pSkill->id) || _spell_idx->second->racemask != 0))
					continue;

				// pussywizard: this is needed for weapon/armor/language skills to remove them when loosing spell
				SetSkill(pSkill->id, GetSkillStep(pSkill->id), 0, 0);
			}
		}
	}

	// pussywizard: remove from spell book (can't be replaced by previous rank, because such spells can't be unlearnt)
	if (!onlyTemporary || ((!spellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_HIDDEN_CLIENTSIDE)) || !spellInfo->HasAnyAura()) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL)))
		SendLearnPacket(spellId, false);
}

bool Player::Has310Flyer(bool checkAllSpells, uint32 excludeSpellId)
{
	if (!checkAllSpells)
		return m_ExtraFlags & PLAYER_EXTRA_HAS_310_FLYER;
	else
	{
		SetHas310Flyer(false);
		SpellInfo const* spellInfo;
		for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
		{
			// pussywizard:
			if (itr->second->State == PLAYERSPELL_REMOVED)
				continue;

			if (itr->first == excludeSpellId)
				continue;

			SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(itr->first);
			for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
			{
				if (_spell_idx->second->skillId != SKILL_MOUNTS)
					break;  // We can break because mount spells belong only to one skillline (at least 310 flyers do)

				spellInfo = sSpellMgr->GetSpellInfo(itr->first);
				for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
					if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED &&
						spellInfo->Effects[i].CalcValue() == 310)
					{
						SetHas310Flyer(true);
						return true;
					}
			}
		}
	}

	return false;
}

void Player::RemoveSpellCooldown(uint32 spell_id, bool update /* = false */)
{
	m_spellCooldowns.erase(spell_id);

	if (update)
		SendClearCooldown(spell_id, this);
}

// I am not sure which one is more efficient
void Player::RemoveCategoryCooldown(uint32 cat)
{
	SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(cat);
	if (i_scstore != sSpellsByCategoryStore.end())
		for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
			RemoveSpellCooldown(*i_scset, true);
}

void Player::RemoveArenaSpellCooldowns(bool removeActivePetCooldowns)
{
	// remove cooldowns on spells that have < 10 min CD
	uint32 infTime = World::GetGameTimeMS() + infinityCooldownDelayCheck;
	SpellCooldowns::iterator itr, next;
	for (itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); itr = next)
	{
		next = itr;
		++next;
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
		if (!spellInfo) // xinef: impossibru...
			continue;

		if (spellInfo->HasAttribute(SPELL_ATTR4_USABLE_IN_ARENA))
			RemoveSpellCooldown(itr->first, true);
		else if (spellInfo->RecoveryTime < 10 * MINUTE * IN_MILLISECONDS && spellInfo->CategoryRecoveryTime < 10 * MINUTE * IN_MILLISECONDS && itr->second.end < infTime// xinef: dont remove active cooldowns - bugz
			&& itr->second.maxduration < 10 * MINUTE * IN_MILLISECONDS) // xinef: dont clear cooldowns that have maxduration > 10 minutes (eg item cooldowns with no spell.dbc cooldown info)
			RemoveSpellCooldown(itr->first, true);
	}

	// pet cooldowns
	if (removeActivePetCooldowns)
		if (Pet* pet = GetPet())
		{
			// notify player
			for (CreatureSpellCooldowns::const_iterator itr2 = pet->m_CreatureSpellCooldowns.begin(); itr2 != pet->m_CreatureSpellCooldowns.end(); ++itr2)
				SendClearCooldown(itr2->first, pet);

			// actually clear cooldowns
			pet->m_CreatureSpellCooldowns.clear();
		}
}

void Player::RemoveAllSpellCooldown()
{
	uint32 infTime = World::GetGameTimeMS() + infinityCooldownDelayCheck;
	if (!m_spellCooldowns.empty())
	{
		for (SpellCooldowns::const_iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end(); ++itr)
			if (itr->second.end < infTime)
				SendClearCooldown(itr->first, this);

		m_spellCooldowns.clear();
	}
}

void Player::_LoadSpellCooldowns(PreparedQueryResult result)
{
	// some cooldowns can be already set at aura loading...

	//QueryResult* result = CharacterDatabase.PQuery("SELECT spell, item, time FROM character_spell_cooldown WHERE guid = '%u'", GetGUIDLow());

	if (result)
	{
		time_t curTime = time(NULL);

		do
		{
			Field* fields = result->Fetch();
			uint32 spell_id = fields[0].GetUInt32();
			uint32 item_id = fields[1].GetUInt32();
			uint32 db_time = fields[2].GetUInt32();
			bool needSend = fields[3].GetBool();

			if (!sSpellMgr->GetSpellInfo(spell_id))
			{
				sLog->outError("Player %u has unknown spell %u in `character_spell_cooldown`, skipping.", GetGUIDLow(), spell_id);
				continue;
			}

			// skip outdated cooldown
			if (db_time <= curTime)
				continue;

			AddSpellCooldown(spell_id, item_id, (db_time - curTime)*IN_MILLISECONDS, needSend);

			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player (GUID: %u) spell %u, item %u cooldown loaded (%u secs).", GetGUIDLow(), spell_id, item_id, uint32(db_time-curTime));
		} while (result->NextRow());
	}
}

void Player::_SaveSpellCooldowns(SQLTransaction& trans, bool logout)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_COOLDOWN);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	time_t curTime = time(NULL);
	uint32 curMSTime = World::GetGameTimeMS();
	uint32 infTime = curMSTime + infinityCooldownDelayCheck;

	bool first_round = true;
	std::ostringstream ss;

	// remove outdated and save active
	for (SpellCooldowns::iterator itr = m_spellCooldowns.begin(); itr != m_spellCooldowns.end();)
	{
		// Xinef: dummy cooldown for procs
		if (itr->first == uint32(-1))
		{
			++itr;
			continue;
		}

		if (itr->second.end <= curMSTime + 1000)
			m_spellCooldowns.erase(itr++);
		else if (itr->second.end <= infTime && (logout || itr->second.end > (curMSTime + 5 * MINUTE*IN_MILLISECONDS)))                 // not save locked cooldowns, it will be reset or set at reload
		{
			if (first_round)
			{
				ss << "INSERT INTO character_spell_cooldown (guid, spell, item, time, needSend) VALUES ";
				first_round = false;
			}
			// next new/changed record prefix
			else
				ss << ',';

			uint64 cooldown = uint64(((itr->second.end - curMSTime) / IN_MILLISECONDS) + curTime);
			ss << '(' << GetGUIDLow() << ',' << itr->first << ',' << itr->second.itemid << ',' << cooldown << ',' << (itr->second.needSendToClient ? '1' : '0') << ')';
			++itr;
		}
		else
			++itr;
	}
	// if something changed execute
	if (!first_round)
		trans->Append(ss.str().c_str());
}

uint32 Player::resetTalentsCost() const
{
	// The first time reset costs 1 gold
	if (m_resetTalentsCost < 1 * GOLD)
		return 1 * GOLD;
	// then 5 gold
	else if (m_resetTalentsCost < 5 * GOLD)
		return 5 * GOLD;
	// After that it increases in increments of 5 gold
	else if (m_resetTalentsCost < 10 * GOLD)
		return 10 * GOLD;
	else
	{
		uint64 months = (sWorld->GetGameTime() - m_resetTalentsTime) / MONTH;
		if (months > 0)
		{
			// This cost will be reduced by a rate of 5 gold per month
			int32 new_cost = int32(m_resetTalentsCost - 5 * GOLD*months);
			// to a minimum of 10 gold.
			return (new_cost < 10 * GOLD ? 10 * GOLD : new_cost);
		}
		else
		{
			// After that it increases in increments of 5 gold
			int32 new_cost = m_resetTalentsCost + 5 * GOLD;
			// until it hits a cap of 50 gold.
			if (new_cost > 50 * GOLD)
				new_cost = 50 * GOLD;
			return new_cost;
		}
	}
}

bool Player::resetTalents(bool noResetCost)
{
	sScriptMgr->OnPlayerTalentsReset(this, noResetCost);

	// xinef: remove at login flag upon talents reset
	if (HasAtLoginFlag(AT_LOGIN_RESET_TALENTS))
		RemoveAtLoginFlag(AT_LOGIN_RESET_TALENTS, true);

	// xinef: get max available talent points amount
	uint32 talentPointsForLevel = CalculateTalentsPoints();

	// xinef: no talent points are used, return
	if (m_usedTalentCount == 0)
		return false;
	m_usedTalentCount = 0;

	// xinef: check if we have enough money
	uint32 resetCost = 0;
	if (!noResetCost && !sWorld->getBoolConfig(CONFIG_NO_RESET_TALENT_COST))
	{
		resetCost = resetTalentsCost();
		if (!HasEnoughMoney(resetCost))
		{
			SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
			return false;
		}
	}

	RemovePet(NULL, PET_SAVE_NOT_IN_SLOT, true);

	// xinef: reset talents
	for (PlayerTalentMap::iterator iter = m_talents.begin(); iter != m_talents.end(); )
	{
		PlayerTalentMap::iterator itr = iter++;

		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		// xinef: talent not in current spec
		if (!(itr->second->specMask & GetActiveSpecMask()))
			continue;

		// xinef: remove talent auras
		_removeTalentAurasAndSpells(itr->first);

		// xinef: check if talent learns spell to spell book
		TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID);
		const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(itr->first);

		bool removed = false;
		if (talentInfo->addToSpellBook)
			if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
			{
				removeSpell(itr->first, GetActiveSpecMask(), false);
				removed = true;
			}

		// Xinef: send unlearn spell packet at talent remove
		if (!removed)
			SendLearnPacket(itr->first, false);

		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
			if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
				if (sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
					removeSpell(spellInfo->Effects[i].TriggerSpell, GetActiveSpecMask(), false);

		// xinef: remove talent modifies m_talents, move itr to map begin
		_removeTalent(itr, GetActiveSpecMask());
	}

	// xinef: remove titan grip if player had it set
	if (m_canTitanGrip)
		SetCanTitanGrip(false);
	// xinef: remove dual wield if player does not have dual wield spell (shamans)
	if (!HasSpell(674) && m_canDualWield)
		SetCanDualWield(false);

	AutoUnequipOffhandIfNeed();

	// pussywizard: removed saving to db, nothing important happens and saving only spells and talents may cause data integrity problems (eg. with skills saved to db)
	SetFreeTalentPoints(talentPointsForLevel);

	if (!noResetCost)
	{
		ModifyMoney(-(int32)resetCost);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TALENTS, resetCost);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_NUMBER_OF_TALENT_RESETS, 1);

		m_resetTalentsCost = resetCost;
		m_resetTalentsTime = time(NULL);
	}

	return true;
}

void Player::SetFreeTalentPoints(uint32 points)
{
	//sScriptMgr->OnPlayerFreeTalentPointsChanged(this, points);
	SetUInt32Value(PLAYER_CHARACTER_POINTS1, points);
}

Mail* Player::GetMail(uint32 id)
{
	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
		if ((*itr)->messageID == id)
			return (*itr);

	return NULL;
}

void Player::BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) const
{
	if (target == this)
	{
		for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
		{
			if (m_items[i] == NULL)
				continue;

			m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
		}

		for (uint8 i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
		{
			if (m_items[i] == NULL)
				continue;

			m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
		}
		for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		{
			if (m_items[i] == NULL)
				continue;

			m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
		}
	}

	Unit::BuildCreateUpdateBlockForPlayer(data, target);
}

void Player::DestroyForPlayer(Player* target, bool onDeath) const
{
	Unit::DestroyForPlayer(target, onDeath);

	for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i) // xinef: previously INVENTORY_SLOT_BAG_END
	{
		if (m_items[i] == NULL)
			continue;

		m_items[i]->DestroyForPlayer(target);
	}

	if (target == this)
	{
		for (uint8 i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
		{
			if (m_items[i] == NULL)
				continue;

			m_items[i]->DestroyForPlayer(target);
		}
		for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		{
			if (m_items[i] == NULL)
				continue;

			m_items[i]->DestroyForPlayer(target);
		}
	}
}

bool Player::HasSpell(uint32 spell) const
{
	PlayerSpellMap::const_iterator itr = m_spells.find(spell);
	return (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec));
}

bool Player::HasTalent(uint32 spell, uint8 spec) const
{
	PlayerTalentMap::const_iterator itr = m_talents.find(spell);
	return (itr != m_talents.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(m_activeSpec));
}

bool Player::HasActiveSpell(uint32 spell) const
{
	PlayerSpellMap::const_iterator itr = m_spells.find(spell);
	return (itr != m_spells.end() && itr->second->State != PLAYERSPELL_REMOVED && itr->second->Active && itr->second->IsInSpec(m_activeSpec));
}

TrainerSpellState Player::GetTrainerSpellState(TrainerSpell const* trainer_spell) const
{
	if (!trainer_spell)
		return TRAINER_SPELL_RED;

	bool hasSpell = true;
	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
	{
		if (!trainer_spell->learnedSpell[i])
			continue;

		if (!HasSpell(trainer_spell->learnedSpell[i]))
		{
			hasSpell = false;
			break;
		}
	}
	// known spell
	if (hasSpell)
		return TRAINER_SPELL_GRAY;

	// check skill requirement
	if (trainer_spell->reqSkill && GetBaseSkillValue(trainer_spell->reqSkill) < trainer_spell->reqSkillValue)
		return TRAINER_SPELL_RED;

	// check level requirement
	if (getLevel() < trainer_spell->reqLevel)
		return TRAINER_SPELL_RED;

	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
	{
		if (!trainer_spell->learnedSpell[i])
			continue;

		// check race/class requirement
		if (!IsSpellFitByClassAndRace(trainer_spell->learnedSpell[i]))
			return TRAINER_SPELL_RED;

		if (uint32 prevSpell = sSpellMgr->GetPrevSpellInChain(trainer_spell->learnedSpell[i]))
		{
			// check prev.rank requirement
			if (prevSpell && !HasSpell(prevSpell))
				return TRAINER_SPELL_RED;
		}

		SpellsRequiringSpellMapBounds spellsRequired = sSpellMgr->GetSpellsRequiredForSpellBounds(trainer_spell->learnedSpell[i]);
		for (SpellsRequiringSpellMap::const_iterator itr = spellsRequired.first; itr != spellsRequired.second; ++itr)
		{
			// check additional spell requirement
			if (!HasSpell(itr->second))
				return TRAINER_SPELL_RED;
		}
	}

	// check primary prof. limit
	// first rank of primary profession spell when there are no proffesions avalible is disabled
	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
	{
		if (!trainer_spell->learnedSpell[i])
			continue;
		SpellInfo const* learnedSpellInfo = sSpellMgr->GetSpellInfo(trainer_spell->learnedSpell[i]);
		if (learnedSpellInfo && learnedSpellInfo->IsPrimaryProfessionFirstRank() && (GetFreePrimaryProfessionPoints() == 0))
			return TRAINER_SPELL_GREEN_DISABLED;
	}

	return TRAINER_SPELL_GREEN;
}

/**
 * Deletes a character from the database
 *
 * The way, how the characters will be deleted is decided based on the config option.
 *
 * @param playerguid       the low-GUID from the player which should be deleted
 * @param accountId        the account id from the player
 * @param updateRealmChars when this flag is set, the amount of characters on that realm will be updated in the realmlist
 * @param deleteFinally    if this flag is set, the config option will be ignored and the character will be permanently removed from the database
 */
void Player::DeleteFromDB(uint64 playerguid, uint32 accountId, bool updateRealmChars, bool deleteFinally)
{
	// for not existed account avoid update realm
	if (accountId == 0)
		updateRealmChars = false;

	uint32 charDelete_method = sWorld->getIntConfig(CONFIG_CHARDELETE_METHOD);
	uint32 charDelete_minLvl = sWorld->getIntConfig(CONFIG_CHARDELETE_MIN_LEVEL);

	// if we want to finally delete the character or the character does not meet the level requirement,
	// we set it to mode CHAR_DELETE_REMOVE
	if (deleteFinally || Player::GetLevelFromStorage(playerguid) < charDelete_minLvl)
		charDelete_method = CHAR_DELETE_REMOVE;

	uint32 guid = GUID_LOPART(playerguid);

	// convert corpse to bones if exist (to prevent exiting Corpse in World without DB entry)
	// bones will be deleted by corpse/bones deleting thread shortly
	sObjectAccessor->ConvertCorpseForPlayer(playerguid);

	if (uint32 guildId = GetGuildIdFromStorage(guid))
		if (Guild* guild = sGuildMgr->GetGuildById(guildId))
			guild->DeleteMember(guid, false, false, true);

	// remove from arena teams
	LeaveAllArenaTeams(playerguid);

	// close player ticket if any
	GmTicket* ticket = sTicketMgr->GetTicketByPlayer(playerguid);
	if (ticket)
		ticket->SetClosedBy(playerguid);

	// remove from group
	if (uint32 groupId = GetGroupIdFromStorage(guid))
		if (Group* group = sGroupMgr->GetGroupByGUID(groupId))
			RemoveFromGroup(group, playerguid);

	// Remove signs from petitions (also remove petitions if owner);
	RemovePetitionsAndSigns(playerguid, 10);

	PreparedStatement* stmt = NULL;

	switch (charDelete_method)
	{
		// Completely remove from the database
	case CHAR_DELETE_REMOVE:
	{
		SQLTransaction trans = CharacterDatabase.BeginTransaction();

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_COD_ITEM_MAIL);
		stmt->setUInt32(0, guid);
		PreparedQueryResult resultMail = CharacterDatabase.Query(stmt);

		if (resultMail)
		{
			do
			{
				Field* mailFields = resultMail->Fetch();

				uint32 mail_id = mailFields[0].GetUInt32();
				uint8 mailType = mailFields[1].GetUInt8();
				uint16 mailTemplateId = mailFields[2].GetUInt16();
				uint32 sender = mailFields[3].GetUInt32();
				std::string subject = mailFields[4].GetString();
				std::string body = mailFields[5].GetString();
				uint32 money = mailFields[6].GetUInt32();
				bool has_items = mailFields[7].GetBool();

				// We can return mail now
				// So firstly delete the old one
				stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
				stmt->setUInt32(0, mail_id);
				trans->Append(stmt);

				// Mail is not from player
				if (mailType != MAIL_NORMAL)
				{
					if (has_items)
					{
						stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
						stmt->setUInt32(0, mail_id);
						trans->Append(stmt);
					}
					continue;
				}

				MailDraft draft(subject, body);
				if (mailTemplateId)
					draft = MailDraft(mailTemplateId, false);    // items are already included

				if (has_items)
				{
					// Data needs to be at first place for Item::LoadFromDB
					stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS);
					stmt->setUInt32(0, mail_id);
					PreparedQueryResult resultItems = CharacterDatabase.Query(stmt);
					if (resultItems)
					{
						do
						{
							Field* itemFields = resultItems->Fetch();
							uint32 item_guidlow = itemFields[11].GetUInt32();
							uint32 item_template = itemFields[12].GetUInt32();

							ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(item_template);
							if (!itemProto)
							{
								stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
								stmt->setUInt32(0, item_guidlow);
								trans->Append(stmt);
								continue;
							}

							Item* pItem = NewItemOrBag(itemProto);
							if (!pItem->LoadFromDB(item_guidlow, MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER), itemFields, item_template))
							{
								pItem->FSetState(ITEM_REMOVED);
								pItem->SaveToDB(trans);              // it also deletes item object!
								continue;
							}

							draft.AddItem(pItem);
						} while (resultItems->NextRow());
					}
				}

				stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
				stmt->setUInt32(0, mail_id);
				trans->Append(stmt);

				uint32 pl_account = sObjectMgr->GetPlayerAccountIdByGUID(MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));

				draft.AddMoney(money).SendReturnToSender(pl_account, guid, sender, trans);
			} while (resultMail->NextRow());
		}

		// Unsummon and delete for pets in world is not required: player deleted from CLI or character list with not loaded pet.
		// NOW we can finally clear other DB data related to character
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PETS);
		stmt->setUInt32(0, guid);
		PreparedQueryResult resultPets = CharacterDatabase.Query(stmt);

		if (resultPets)
		{
			do
			{
				uint32 petguidlow = (*resultPets)[0].GetUInt32();
				Pet::DeleteFromDB(petguidlow);
			} while (resultPets->NextRow());
		}

		// Delete char from social list of online chars
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_SOCIAL);
		stmt->setUInt32(0, guid);
		PreparedQueryResult resultFriends = CharacterDatabase.Query(stmt);

		if (resultFriends)
		{
			do
			{
				if (Player* pFriend = ObjectAccessor::FindPlayerInOrOutOfWorld(MAKE_NEW_GUID((*resultFriends)[0].GetUInt32(), 0, HIGHGUID_PLAYER)))
				{
					pFriend->GetSocial()->RemoveFromSocialList(guid, false);
					sSocialMgr->SendFriendStatus(pFriend, FRIEND_REMOVED, guid, false);
				}
			} while (resultFriends->NextRow());
		}

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ACCOUNT_DATA);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_DECLINED_NAME);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACTION);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_AURA);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GIFT);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_REPUTATION);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_COOLDOWN);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		if (sWorld->getBoolConfig(CONFIG_DELETE_CHARACTER_TICKET_TRACE))
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_PLAYER_GM_TICKETS_ON_CHAR_DELETION);
			stmt->setUInt32(0, guid);
			trans->Append(stmt);
		}
		else
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_GM_TICKETS);
			stmt->setUInt32(0, guid);
			trans->Append(stmt);
		}

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE_BY_OWNER);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_FRIEND);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SOCIAL_BY_GUID);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEMS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_OWNER);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME_BY_OWNER);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENTS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_EQUIPMENTSETS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GUILD_EVENTLOG_BY_PLAYER);
		stmt->setUInt32(0, guid);
		stmt->setUInt32(1, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GUILD_BANK_EVENTLOG_BY_PLAYER);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ENTRY_POINT);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GLYPHS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_DAILY_CHAR);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_WEEKLY_CHAR);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_MONTHLY_CHAR);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_SEASONAL_CHAR);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_TALENT);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILLS);
		stmt->setUInt32(0, guid);
		trans->Append(stmt);

		CharacterDatabase.CommitTransaction(trans);
		break;
	}
	// The character gets unlinked from the account, the name gets freed up and appears as deleted ingame
	case CHAR_DELETE_UNLINK:
	{
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_DELETE_INFO);

		stmt->setUInt32(0, guid);

		CharacterDatabase.Execute(stmt);
		break;
	}
	default:
		sLog->outError("Player::DeleteFromDB: Unsupported delete method: %u.", charDelete_method);
		return;
	}

	if (updateRealmChars)
		sWorld->UpdateRealmCharCount(accountId);
}

/**
 * Characters which were kept back in the database after being deleted and are now too old (see config option "CharDelete.KeepDays"), will be completely deleted.
 */
void Player::DeleteOldCharacters()
{
	uint32 keepDays = sWorld->getIntConfig(CONFIG_CHARDELETE_KEEP_DAYS);
	if (!keepDays)
		return;

	Player::DeleteOldCharacters(keepDays);
}

/**
 * Characters which were kept back in the database after being deleted and are older than the specified amount of days, will be completely deleted.
 */
void Player::DeleteOldCharacters(uint32 keepDays)
{
	sLog->outString("Player::DeleteOldChars: Deleting all characters which have been deleted %u days before...", keepDays);

	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_OLD_CHARS);
	stmt->setUInt32(0, uint32(time(NULL) - time_t(keepDays * DAY)));
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (result)
	{
		sLog->outString("Player::DeleteOldChars: Found " UI64FMTD " character(s) to delete", result->GetRowCount());
		do
		{
			Field* fields = result->Fetch();
			Player::DeleteFromDB(fields[0].GetUInt32(), fields[1].GetUInt32(), true, true);
		} while (result->NextRow());
	}
}

void Player::SetMovement(PlayerMovementType pType)
{
	WorldPacket data;
	switch (pType)
	{
	case MOVE_ROOT:       data.Initialize(SMSG_FORCE_MOVE_ROOT, GetPackGUID().size() + 4); break;
	case MOVE_UNROOT:     data.Initialize(SMSG_FORCE_MOVE_UNROOT, GetPackGUID().size() + 4); break;
	case MOVE_WATER_WALK: data.Initialize(SMSG_MOVE_WATER_WALK, GetPackGUID().size() + 4); break;
	case MOVE_LAND_WALK:  data.Initialize(SMSG_MOVE_LAND_WALK, GetPackGUID().size() + 4); break;
	default:
		sLog->outError("Player::SetMovement: Unsupported move type (%d), data not sent to client.", pType);
		return;
	}
	data.append(GetPackGUID());
	data << uint32(0);
	GetSession()->SendPacket(&data);
}

/* Preconditions:
  - a resurrectable corpse must not be loaded for the player (only bones)
  - the player must be in world
*/
void Player::BuildPlayerRepop()
{
	WorldPacket data(SMSG_PRE_RESURRECT, GetPackGUID().size());
	data.append(GetPackGUID());
	GetSession()->SendPacket(&data);

	if (getRace(true) == RACE_NIGHTELF)
		CastSpell(this, 20584, true);
	CastSpell(this, 8326, true);

	// there must be SMSG.FORCE_RUN_SPEED_CHANGE, SMSG.FORCE_SWIM_SPEED_CHANGE, SMSG.MOVE_WATER_WALK
	// there must be SMSG.STOP_MIRROR_TIMER
	// there we must send 888 opcode

	// the player cannot have a corpse already, only bones which are not returned by GetCorpse
	if (GetCorpse())
	{
		sLog->outError("BuildPlayerRepop: player %s(%d) already has a corpse", GetName().c_str(), GetGUIDLow());
		return;
	}

	// create a corpse and place it at the player's location
	CreateCorpse();
	Corpse* corpse = GetCorpse();
	if (!corpse)
	{
		sLog->outError("Error creating corpse for Player %s [%u]", GetName().c_str(), GetGUIDLow());
		return;
	}
	GetMap()->AddToMap(corpse);

	// convert player body to ghost
	SetHealth(1);

	SetMovement(MOVE_WATER_WALK);
	if (!GetSession()->isLogingOut())
		SetMovement(MOVE_UNROOT);

	// BG - remove insignia related
	RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

	int32 corpseReclaimDelay = CalculateCorpseReclaimDelay();

	if (corpseReclaimDelay >= 0)
		SendCorpseReclaimDelay(corpseReclaimDelay);

	// to prevent cheating
	corpse->ResetGhostTime();

	StopMirrorTimers();                                     //disable timers(bars)

	// set and clear other
	SetByteValue(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_ALWAYS_STAND);
}

void Player::ResurrectPlayer(float restore_percent, bool applySickness)
{
	WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4 * 4);          // remove spirit healer position
	data << uint32(-1);
	data << float(0);
	data << float(0);
	data << float(0);
	GetSession()->SendPacket(&data);

	// speed change, land walk

	// remove death flag + set aura
	SetByteValue(UNIT_FIELD_BYTES_1, 3, 0x00);
	RemoveAurasDueToSpell(20584);                           // speed bonuses
	RemoveAurasDueToSpell(8326);                            // SPELL_AURA_GHOST

	if (GetSession()->IsARecruiter() || (GetSession()->GetRecruiterId() != 0))
		SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_REFER_A_FRIEND);

	setDeathState(ALIVE);

	SetMovement(MOVE_LAND_WALK);
	SetMovement(MOVE_UNROOT);

	m_deathTimer = 0;

	// set health/powers (0- will be set in caller)
	if (restore_percent > 0.0f)
	{
		SetHealth(uint32(GetMaxHealth()*restore_percent));
		SetPower(POWER_MANA, uint32(GetMaxPower(POWER_MANA)*restore_percent));
		SetPower(POWER_RAGE, 0);
		SetPower(POWER_ENERGY, uint32(GetMaxPower(POWER_ENERGY)*restore_percent));
	}

	// trigger update zone for alive state zone updates
	uint32 newzone, newarea;
	GetZoneAndAreaId(newzone, newarea, true);
	UpdateZone(newzone, newarea);
	sOutdoorPvPMgr->HandlePlayerResurrects(this, newzone);

	if (Battleground* bg = GetBattleground())
		bg->HandlePlayerResurrect(this);

	// update visibility
	UpdateObjectVisibility();

	if (!applySickness)
		return;

	//Characters from level 1-10 are not affected by resurrection sickness.
	//Characters from level 11-19 will suffer from one minute of sickness
	//for each level they are above 10.
	//Characters level 20 and up suffer from ten minutes of sickness.
	int32 startLevel = sWorld->getIntConfig(CONFIG_DEATH_SICKNESS_LEVEL);

	if (int32(getLevel()) >= startLevel)
	{
		// set resurrection sickness
		CastSpell(this, 15007, true);

		// not full duration
		if (int32(getLevel()) < startLevel + 9)
		{
			int32 delta = (int32(getLevel()) - startLevel + 1)*MINUTE;

			if (Aura* aur = GetAura(15007, GetGUID()))
			{
				aur->SetDuration(delta*IN_MILLISECONDS);
			}
		}
	}
}

void Player::KillPlayer()
{
	if (IsFlying() && !GetTransport())
		GetMotionMaster()->MoveFall();

	SetMovement(MOVE_ROOT);

	StopMirrorTimers();                                     //disable timers(bars)

	setDeathState(CORPSE);
	//SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_IN_PVP);

	SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_NONE);
	ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, !sMapStore.LookupEntry(GetMapId())->Instanceable() && !HasAuraType(SPELL_AURA_PREVENT_RESURRECTION));

	// 6 minutes until repop at graveyard
	m_deathTimer = 6 * MINUTE * IN_MILLISECONDS;

	UpdateCorpseReclaimDelay();                             // dependent at use SetDeathPvP() call before kill

	int32 corpseReclaimDelay = CalculateCorpseReclaimDelay();

	if (corpseReclaimDelay >= 0)
		SendCorpseReclaimDelay(corpseReclaimDelay);

	// don't create corpse at this moment, player might be falling

	// update visibility
	//UpdateObjectVisibility(); // pussywizard: not needed
}

void Player::CreateCorpse()
{
	// prevent existence 2 corpse for player
	SpawnCorpseBones();

	uint32 _uf, _pb, _pb2, _cfb1, _cfb2;

	Corpse* corpse = new Corpse((m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH) ? CORPSE_RESURRECTABLE_PVP : CORPSE_RESURRECTABLE_PVE);
	SetPvPDeath(false);

	if (!corpse->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_CORPSE), this))
	{
		delete corpse;
		return;
	}

	_uf = GetUInt32Value(UNIT_FIELD_BYTES_0);
	_pb = GetUInt32Value(PLAYER_BYTES);
	_pb2 = GetUInt32Value(PLAYER_BYTES_2);

	uint8 race = (uint8)(_uf);
	uint8 skin = (uint8)(_pb);
	uint8 face = (uint8)(_pb >> 8);
	uint8 hairstyle = (uint8)(_pb >> 16);
	uint8 haircolor = (uint8)(_pb >> 24);
	uint8 facialhair = (uint8)(_pb2);

	_cfb1 = ((0x00) | (race << 8) | (getGender() << 16) | (skin << 24));
	_cfb2 = ((face) | (hairstyle << 8) | (haircolor << 16) | (facialhair << 24));

	corpse->SetUInt32Value(CORPSE_FIELD_BYTES_1, _cfb1);
	corpse->SetUInt32Value(CORPSE_FIELD_BYTES_2, _cfb2);

	uint32 flags = CORPSE_FLAG_UNK2;
	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM))
		flags |= CORPSE_FLAG_HIDE_HELM;
	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_CLOAK))
		flags |= CORPSE_FLAG_HIDE_CLOAK;

	// Xinef: Player can loop corpses while in BG or in WG
	if (InBattleground() && !InArena())
		flags |= CORPSE_FLAG_LOOTABLE;
	Battlefield* Bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
	if (Bf && Bf->IsWarTime())
		flags |= CORPSE_FLAG_LOOTABLE;

	corpse->SetUInt32Value(CORPSE_FIELD_FLAGS, flags);

	corpse->SetUInt32Value(CORPSE_FIELD_DISPLAY_ID, GetNativeDisplayId());

	corpse->SetUInt32Value(CORPSE_FIELD_GUILD, GetGuildId());

	uint32 iDisplayID;
	uint32 iIventoryType;
	uint32 _cfi;
	for (uint8 i = 0; i < EQUIPMENT_SLOT_END; i++)
	{
		if (m_items[i])
		{
			iDisplayID = m_items[i]->GetTemplate()->DisplayInfoID;
			iIventoryType = m_items[i]->GetTemplate()->InventoryType;

			_cfi = iDisplayID | (iIventoryType << 24);
			corpse->SetUInt32Value(CORPSE_FIELD_ITEM + i, _cfi);
		}
	}

	// we do not need to save corpses for BG/arenas
	if (!GetMap()->IsBattlegroundOrArena())
		corpse->SaveToDB();

	// register for player, but not show
	sObjectAccessor->AddCorpse(corpse);
}

void Player::SpawnCorpseBones()
{
	if (sObjectAccessor->ConvertCorpseForPlayer(GetGUID()))
		if (!GetSession()->PlayerLogoutWithSave())          // at logout we will already store the player
		{
			// prevent loading as ghost without corpse
			SQLTransaction trans = CharacterDatabase.BeginTransaction();

			// pussywizard: update only ghost flag instead of whole character table entry! data integrity is crucial
			PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_REMOVE_GHOST);
			stmt->setUInt32(0, GetGUIDLow());
			trans->Append(stmt);

			_SaveAuras(trans, false);

			CharacterDatabase.CommitTransaction(trans);
		}
}

Corpse* Player::GetCorpse() const
{
	return sObjectAccessor->GetCorpseForPlayerGUID(GetGUID());
}

void Player::DurabilityLossAll(double percent, bool inventory)
{
	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			DurabilityLoss(pItem, percent);

	if (inventory)
	{
		// bags not have durability
		// for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

		for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
			if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				DurabilityLoss(pItem, percent);

		// keys not have durability
		//for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

		for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
			if (Bag* pBag = GetBagByPos(i))
				for (uint32 j = 0; j < pBag->GetBagSize(); j++)
					if (Item* pItem = GetItemByPos(i, j))
						DurabilityLoss(pItem, percent);
	}
}

void Player::DurabilityLoss(Item* item, double percent)
{
	if (!item)
		return;

	uint32 pMaxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);

	if (!pMaxDurability)
		return;

	uint32 pDurabilityLoss = uint32(pMaxDurability*percent);

	if (pDurabilityLoss < 1)
		pDurabilityLoss = 1;

	DurabilityPointsLoss(item, pDurabilityLoss);
}

void Player::DurabilityPointsLossAll(int32 points, bool inventory)
{
	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			DurabilityPointsLoss(pItem, points);

	if (inventory)
	{
		// bags not have durability
		// for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

		for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
			if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				DurabilityPointsLoss(pItem, points);

		// keys not have durability
		//for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

		for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
			if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				for (uint32 j = 0; j < pBag->GetBagSize(); j++)
					if (Item* pItem = GetItemByPos(i, j))
						DurabilityPointsLoss(pItem, points);
	}
}

void Player::DurabilityPointsLoss(Item* item, int32 points)
{
	int32 pMaxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
	int32 pOldDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);
	int32 pNewDurability = pOldDurability - points;

	if (pNewDurability < 0)
		pNewDurability = 0;
	else if (pNewDurability > pMaxDurability)
		pNewDurability = pMaxDurability;

	if (pOldDurability != pNewDurability)
	{
		// modify item stats _before_ Durability set to 0 to pass _ApplyItemMods internal check
		if (pNewDurability == 0 && pOldDurability > 0 && item->IsEquipped())
			_ApplyItemMods(item, item->GetSlot(), false);

		item->SetUInt32Value(ITEM_FIELD_DURABILITY, pNewDurability);

		// modify item stats _after_ restore durability to pass _ApplyItemMods internal check
		if (pNewDurability > 0 && pOldDurability == 0 && item->IsEquipped())
			_ApplyItemMods(item, item->GetSlot(), true);

		item->SetState(ITEM_CHANGED, this);
	}
}

void Player::DurabilityPointLossForEquipSlot(EquipmentSlots slot)
{
	if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
		DurabilityPointsLoss(pItem, 1);
}

uint32 Player::DurabilityRepairAll(bool cost, float discountMod, bool guildBank)
{
	uint32 TotalCost = 0;
	// equipped, backpack, bags itself
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
		TotalCost += DurabilityRepair(((INVENTORY_SLOT_BAG_0 << 8) | i), cost, discountMod, guildBank);

	// bank, buyback and keys not repaired

	// items in inventory bags
	for (uint8 j = INVENTORY_SLOT_BAG_START; j < INVENTORY_SLOT_BAG_END; j++)
		for (uint8 i = 0; i < MAX_BAG_SIZE; i++)
			TotalCost += DurabilityRepair(((j << 8) | i), cost, discountMod, guildBank);
	return TotalCost;
}

uint32 Player::DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank)
{
	Item* item = GetItemByPos(pos);

	uint32 TotalCost = 0;
	if (!item)
		return TotalCost;

	uint32 maxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
	if (!maxDurability)
		return TotalCost;

	uint32 curDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);

	if (cost)
	{
		uint32 LostDurability = maxDurability - curDurability;
		if (LostDurability > 0)
		{
			ItemTemplate const* ditemProto = item->GetTemplate();

			DurabilityCostsEntry const* dcost = sDurabilityCostsStore.LookupEntry(ditemProto->ItemLevel);
			if (!dcost)
			{
				sLog->outError("RepairDurability: Wrong item lvl %u", ditemProto->ItemLevel);
				return TotalCost;
			}

			uint32 dQualitymodEntryId = (ditemProto->Quality + 1) * 2;
			DurabilityQualityEntry const* dQualitymodEntry = sDurabilityQualityStore.LookupEntry(dQualitymodEntryId);
			if (!dQualitymodEntry)
			{
				sLog->outError("RepairDurability: Wrong dQualityModEntry %u", dQualitymodEntryId);
				return TotalCost;
			}

			uint32 dmultiplier = dcost->multiplier[ItemSubClassToDurabilityMultiplierId(ditemProto->Class, ditemProto->SubClass)];
			uint32 costs = uint32(LostDurability*dmultiplier*double(dQualitymodEntry->quality_mod));

			costs = uint32(costs * discountMod * sWorld->getRate(RATE_REPAIRCOST));

			if (costs == 0)                                   //fix for ITEM_QUALITY_ARTIFACT
				costs = 1;

			if (guildBank)
			{
				if (GetGuildId() == 0)
				{
					;//sLog->outStaticDebug("You are not member of a guild");
					return TotalCost;
				}

				Guild* guild = sGuildMgr->GetGuildById(GetGuildId());
				if (!guild)
					return TotalCost;

				if (!guild->HandleMemberWithdrawMoney(GetSession(), costs, true))
					return TotalCost;

				TotalCost = costs;
			}
			else if (!HasEnoughMoney(costs))
			{
				;//sLog->outStaticDebug("You do not have enough money");
				return TotalCost;
			}
			else
				ModifyMoney(-int32(costs));
		}
	}

	item->SetUInt32Value(ITEM_FIELD_DURABILITY, maxDurability);
	item->SetState(ITEM_CHANGED, this);

	// reapply mods for total broken and repaired item if equipped
	if (IsEquipmentPos(pos) && !curDurability)
		_ApplyItemMods(item, pos & 255, true);
	return TotalCost;
}

void Player::RepopAtGraveyard()
{
	// note: this can be called also when the player is alive
	// for example from WorldSession::HandleMovementOpcodes

	AreaTableEntry const* zone = GetAreaEntryByAreaID(GetAreaId());

	// Such zones are considered unreachable as a ghost and the player must be automatically revived
	// Xinef: Get Transport Check is not needed
	if ((!IsAlive() && zone && zone->flags & AREA_FLAG_NEED_FLY) /*|| GetTransport()*/ || GetPositionZ() < -500.0f)
	{
		ResurrectPlayer(0.5f);
		SpawnCorpseBones();
	}

	WorldSafeLocsEntry const* ClosestGrave = NULL;

	// Special handle for battleground maps
	if (Battleground* bg = GetBattleground())
		ClosestGrave = bg->GetClosestGraveyard(this);
	else
	{
		if (sBattlefieldMgr->GetBattlefieldToZoneId(GetZoneId()))
			ClosestGrave = sBattlefieldMgr->GetBattlefieldToZoneId(GetZoneId())->GetClosestGraveyard(this);
		else
			ClosestGrave = sObjectMgr->GetClosestGraveyard(GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId(), GetTeamId());
	}

	// stop countdown until repop
	m_deathTimer = 0;

	// if no grave found, stay at the current location
	// and don't show spirit healer location
	if (ClosestGrave)
	{
		TeleportTo(ClosestGrave->map_id, ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, GetOrientation());
		if (isDead())                                        // not send if alive, because it used in TeleportTo()
		{
			WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4 * 4);  // show spirit healer position on minimap
			data << ClosestGrave->map_id;
			data << ClosestGrave->x;
			data << ClosestGrave->y;
			data << ClosestGrave->z;
			GetSession()->SendPacket(&data);
		}
	}
	else if (GetPositionZ() < -500.0f)
		TeleportTo(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, GetOrientation());
}

bool Player::CanJoinConstantChannelInZone(ChatChannelsEntry const* channel, AreaTableEntry const* zone)
{
	if (channel->flags & CHANNEL_DBC_FLAG_ZONE_DEP && zone->flags & AREA_FLAG_ARENA_INSTANCE)
		return false;

	if ((channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY) && (!(zone->flags & AREA_FLAG_SLAVE_CAPITAL)))
		return false;

	if ((channel->flags & CHANNEL_DBC_FLAG_GUILD_REQ) && GetGuildId())
		return false;

	return true;
}

void Player::JoinedChannel(Channel* c)
{
	m_channels.push_back(c);
}

void Player::LeftChannel(Channel* c)
{
	m_channels.remove(c);
}

void Player::CleanupChannels()
{
	while (!m_channels.empty())
	{
		Channel* ch = *m_channels.begin();
		m_channels.erase(m_channels.begin());               // remove from player's channel list
		ch->LeaveChannel(this, false);                     // not send to client, not remove from player's channel list
	}
}

void Player::ClearChannelWatch()
{
	for (JoinedChannelsList::iterator itr = m_channels.begin(); itr != m_channels.end(); ++itr)
		(*itr)->RemoveWatching(this);
}

void Player::UpdateLocalChannels(uint32 newZone)
{
	// pussywizard: mutex needed (tc changed opcode to THREAD UNSAFE)
	static ACE_Thread_Mutex channelsLock;
	TRINITY_GUARD(ACE_Thread_Mutex, channelsLock);

	if (GetSession()->PlayerLoading() && !IsBeingTeleportedFar())
		return;                                              // The client handles it automatically after loading, but not after teleporting

	AreaTableEntry const* current_zone = GetAreaEntryByAreaID(newZone);
	if (!current_zone)
		return;

	ChannelMgr* cMgr = ChannelMgr::forTeam(GetTeamId());
	if (!cMgr)
		return;

	std::string current_zone_name = current_zone->area_name[GetSession()->GetSessionDbcLocale()];

	for (uint32 i = 0; i < sChatChannelsStore.GetNumRows(); ++i)
	{
		if (ChatChannelsEntry const* channel = sChatChannelsStore.LookupEntry(i))
		{
			Channel* usedChannel = NULL;

			for (JoinedChannelsList::iterator itr = m_channels.begin(); itr != m_channels.end(); ++itr)
			{
				if ((*itr)->GetChannelId() == i)
				{
					usedChannel = *itr;
					break;
				}
			}

			Channel* removeChannel = NULL;
			Channel* joinChannel = NULL;
			bool sendRemove = true;

			if (CanJoinConstantChannelInZone(channel, current_zone))
			{
				if (!(channel->flags & CHANNEL_DBC_FLAG_GLOBAL))
				{
					if (channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY && usedChannel)
						continue;                            // Already on the channel, as city channel names are not changing

					char new_channel_name_buf[100];
					char const* currentNameExt;

					if (channel->flags & CHANNEL_DBC_FLAG_CITY_ONLY)
						currentNameExt = sObjectMgr->GetTrinityStringForDBCLocale(LANG_CHANNEL_CITY);
					else
						currentNameExt = current_zone_name.c_str();

					snprintf(new_channel_name_buf, 100, channel->pattern[m_session->GetSessionDbcLocale()], currentNameExt);

					joinChannel = cMgr->GetJoinChannel(new_channel_name_buf, channel->ChannelID);
					if (usedChannel)
					{
						if (joinChannel != usedChannel)
						{
							removeChannel = usedChannel;
							sendRemove = false;              // Do not send leave channel, it already replaced at client
						}
						else
							joinChannel = NULL;
					}
				}
				else
					joinChannel = cMgr->GetJoinChannel(channel->pattern[m_session->GetSessionDbcLocale()], channel->ChannelID);
			}
			else
				removeChannel = usedChannel;

			if (joinChannel)
				joinChannel->JoinChannel(this, "");          // Changed Channel: ... or Joined Channel: ...

			if (removeChannel)
			{
				removeChannel->LeaveChannel(this, sendRemove); // Leave old channel
				std::string name = removeChannel->GetName(); // Store name, (*i)erase in LeftChannel
				LeftChannel(removeChannel);                  // Remove from player's channel list
			}
		}
	}
}

void Player::UpdateDefense()
{
	if (UpdateSkill(SKILL_DEFENSE, sWorld->getIntConfig(CONFIG_SKILL_GAIN_DEFENSE)))
		UpdateDefenseBonusesMod(); // update dependent from defense skill part
}

void Player::HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply)
{
	if (modGroup >= BASEMOD_END || modType >= MOD_END)
	{
		sLog->outError("ERROR in HandleBaseModValue(): non existed BaseModGroup of wrong BaseModType!");
		return;
	}

	switch (modType)
	{
	case FLAT_MOD:
		m_auraBaseMod[modGroup][modType] += apply ? amount : -amount;
		break;
	case PCT_MOD:
		ApplyPercentModFloatVar(m_auraBaseMod[modGroup][modType], amount, apply);
		break;
	}

	if (!CanModifyStats())
		return;

	switch (modGroup)
	{
	case CRIT_PERCENTAGE:              UpdateCritPercentage(BASE_ATTACK);                          break;
	case RANGED_CRIT_PERCENTAGE:       UpdateCritPercentage(RANGED_ATTACK);                        break;
	case OFFHAND_CRIT_PERCENTAGE:      UpdateCritPercentage(OFF_ATTACK);                           break;
	case SHIELD_BLOCK_VALUE:           UpdateShieldBlockValue();                                   break;
	default: break;
	}
}

float Player::GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const
{
	if (modGroup >= BASEMOD_END || modType >= MOD_END)
	{
		sLog->outError("trial to access non existed BaseModGroup or wrong BaseModType!");
		return 0.0f;
	}

	if (modType == PCT_MOD && m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
		return 0.0f;

	return m_auraBaseMod[modGroup][modType];
}

float Player::GetTotalBaseModValue(BaseModGroup modGroup) const
{
	if (modGroup >= BASEMOD_END)
	{
		sLog->outError("wrong BaseModGroup in GetTotalBaseModValue()!");
		return 0.0f;
	}

	if (m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
		return 0.0f;

	return m_auraBaseMod[modGroup][FLAT_MOD] * m_auraBaseMod[modGroup][PCT_MOD];
}

uint32 Player::GetShieldBlockValue() const
{
	float value = (m_auraBaseMod[SHIELD_BLOCK_VALUE][FLAT_MOD] + GetStat(STAT_STRENGTH) * 0.5f - 10)*m_auraBaseMod[SHIELD_BLOCK_VALUE][PCT_MOD];

	value = (value < 0) ? 0 : value;

	return uint32(value);
}

float Player::GetMeleeCritFromAgility()
{
	uint8 level = getLevel();
	uint32 pclass = getClass();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	GtChanceToMeleeCritBaseEntry const* critBase = sGtChanceToMeleeCritBaseStore.LookupEntry(pclass - 1);
	GtChanceToMeleeCritEntry     const* critRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	if (critBase == NULL || critRatio == NULL)
		return 0.0f;

	float crit = critBase->base + GetStat(STAT_AGILITY)*critRatio->ratio;
	return crit*100.0f;
}

void Player::GetDodgeFromAgility(float &diminishing, float &nondiminishing)
{
	// Table for base dodge values
	const float dodge_base[MAX_CLASSES] =
	{
		 0.036640f, // Warrior
		 0.034943f, // Paladi
		-0.040873f, // Hunter
		 0.020957f, // Rogue
		 0.034178f, // Priest
		 0.036640f, // DK
		 0.021080f, // Shaman
		 0.036587f, // Mage
		 0.024211f, // Warlock
		 0.0f,      // ??
		 0.056097f  // Druid
	};
	// Crit/agility to dodge/agility coefficient multipliers; 3.2.0 increased required agility by 15%
	const float crit_to_dodge[MAX_CLASSES] =
	{
		 0.85f / 1.15f,    // Warrior
		 1.00f / 1.15f,    // Paladin
		 1.11f / 1.15f,    // Hunter
		 2.00f / 1.15f,    // Rogue
		 1.00f / 1.15f,    // Priest
		 0.85f / 1.15f,    // DK
		 1.60f / 1.15f,    // Shaman
		 1.00f / 1.15f,    // Mage
		 0.97f / 1.15f,    // Warlock (?)
		 0.0f,           // ??
		 2.00f / 1.15f     // Druid
	};

	uint8 level = getLevel();
	uint32 pclass = getClass();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	// Dodge per agility is proportional to crit per agility, which is available from DBC files
	GtChanceToMeleeCritEntry  const* dodgeRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	if (dodgeRatio == NULL || pclass > MAX_CLASSES)
		return;

	// TODO: research if talents/effects that increase total agility by x% should increase non-diminishing part
	float base_agility = GetCreateStat(STAT_AGILITY) * m_auraModifiersGroup[UNIT_MOD_STAT_START + STAT_AGILITY][BASE_PCT];
	float bonus_agility = GetStat(STAT_AGILITY) - base_agility;

	// calculate diminishing (green in char screen) and non-diminishing (white) contribution
	diminishing = 100.0f * bonus_agility * dodgeRatio->ratio * crit_to_dodge[pclass - 1];
	nondiminishing = 100.0f * (dodge_base[pclass - 1] + base_agility * dodgeRatio->ratio * crit_to_dodge[pclass - 1]);
}

float Player::GetSpellCritFromIntellect()
{
	uint8 level = getLevel();
	uint32 pclass = getClass();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	GtChanceToSpellCritBaseEntry const* critBase = sGtChanceToSpellCritBaseStore.LookupEntry(pclass - 1);
	GtChanceToSpellCritEntry     const* critRatio = sGtChanceToSpellCritStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	if (critBase == NULL || critRatio == NULL)
		return 0.0f;

	float crit = critBase->base + GetStat(STAT_INTELLECT)*critRatio->ratio;
	return crit*100.0f;
}

float Player::GetRatingMultiplier(CombatRating cr) const
{
	uint8 level = getLevel();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	GtCombatRatingsEntry const* Rating = sGtCombatRatingsStore.LookupEntry(cr*GT_MAX_LEVEL + level - 1);
	// gtOCTClassCombatRatingScalarStore.dbc starts with 1, CombatRating with zero, so cr+1
	GtOCTClassCombatRatingScalarEntry const* classRating = sGtOCTClassCombatRatingScalarStore.LookupEntry((getClass() - 1)*GT_MAX_RATING + cr + 1);
	if (!Rating || !classRating)
		return 1.0f;                                        // By default use minimum coefficient (not must be called)

	return classRating->ratio / Rating->ratio;
}

float Player::GetRatingBonusValue(CombatRating cr) const
{
	return float(GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + cr)) * GetRatingMultiplier(cr);
}

float Player::GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const
{
	switch (attType)
	{
	case BASE_ATTACK:
		return GetUInt32Value(PLAYER_EXPERTISE) / 4.0f;
	case OFF_ATTACK:
		return GetUInt32Value(PLAYER_OFFHAND_EXPERTISE) / 4.0f;
	default:
		break;
	}
	return 0.0f;
}

float Player::OCTRegenHPPerSpirit()
{
	uint8 level = getLevel();
	uint32 pclass = getClass();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	GtOCTRegenHPEntry     const* baseRatio = sGtOCTRegenHPStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	GtRegenHPPerSptEntry  const* moreRatio = sGtRegenHPPerSptStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	if (baseRatio == NULL || moreRatio == NULL)
		return 0.0f;

	// Formula from PaperDollFrame script
	float spirit = GetStat(STAT_SPIRIT);
	float baseSpirit = spirit;
	if (baseSpirit > 50)
		baseSpirit = 50;
	float moreSpirit = spirit - baseSpirit;
	float regen = baseSpirit * baseRatio->ratio + moreSpirit * moreRatio->ratio;
	return regen;
}

float Player::OCTRegenMPPerSpirit()
{
	uint8 level = getLevel();
	uint32 pclass = getClass();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;

	//    GtOCTRegenMPEntry     const* baseRatio = sGtOCTRegenMPStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
	GtRegenMPPerSptEntry  const* moreRatio = sGtRegenMPPerSptStore.LookupEntry((pclass - 1)*GT_MAX_LEVEL + level - 1);
	if (moreRatio == NULL)
		return 0.0f;

	// Formula get from PaperDollFrame script
	float spirit = GetStat(STAT_SPIRIT);
	float regen = spirit * moreRatio->ratio;
	return regen;
}

void Player::ApplyRatingMod(CombatRating cr, int32 value, bool apply)
{
	float oldRating = m_baseRatingValue[cr];
	m_baseRatingValue[cr] += (apply ? value : -value);
	// explicit affected values
	if (cr == CR_HASTE_MELEE || cr == CR_HASTE_RANGED || cr == CR_HASTE_SPELL)
	{
		float const mult = GetRatingMultiplier(cr);
		float const oldVal = oldRating * mult;
		float const newVal = m_baseRatingValue[cr] * mult;
		switch (cr)
		{
		case CR_HASTE_MELEE:
			ApplyAttackTimePercentMod(BASE_ATTACK, oldVal, false);
			ApplyAttackTimePercentMod(OFF_ATTACK, oldVal, false);
			ApplyAttackTimePercentMod(BASE_ATTACK, newVal, true);
			ApplyAttackTimePercentMod(OFF_ATTACK, newVal, true);
			break;
		case CR_HASTE_RANGED:
			ApplyAttackTimePercentMod(RANGED_ATTACK, oldVal, false);
			ApplyAttackTimePercentMod(RANGED_ATTACK, newVal, true);
			break;
		case CR_HASTE_SPELL:
			ApplyCastTimePercentMod(oldVal, false);
			ApplyCastTimePercentMod(newVal, true);
			break;
		}
	}

	UpdateRating(cr);
}

void Player::UpdateRating(CombatRating cr)
{
	int32 amount = m_baseRatingValue[cr];
	// Apply bonus from SPELL_AURA_MOD_RATING_FROM_STAT
	// stat used stored in miscValueB for this aura
	AuraEffectList const& modRatingFromStat = GetAuraEffectsByType(SPELL_AURA_MOD_RATING_FROM_STAT);
	for (AuraEffectList::const_iterator i = modRatingFromStat.begin(); i != modRatingFromStat.end(); ++i)
		if ((*i)->GetMiscValue() & (1 << cr))
			amount += int32(CalculatePct(GetStat(Stats((*i)->GetMiscValueB())), (*i)->GetAmount()));
	if (amount < 0)
		amount = 0;
	SetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + cr, uint32(amount));

	bool affectStats = CanModifyStats();

	switch (cr)
	{
	case CR_WEAPON_SKILL:                               // Implemented in Unit::RollMeleeOutcomeAgainst
	case CR_DEFENSE_SKILL:
		UpdateDefenseBonusesMod();
		break;
	case CR_DODGE:
		UpdateDodgePercentage();
		break;
	case CR_PARRY:
		UpdateParryPercentage();
		break;
	case CR_BLOCK:
		UpdateBlockPercentage();
		break;
	case CR_HIT_MELEE:
		UpdateMeleeHitChances();
		break;
	case CR_HIT_RANGED:
		UpdateRangedHitChances();
		break;
	case CR_HIT_SPELL:
		UpdateSpellHitChances();
		break;
	case CR_CRIT_MELEE:
		if (affectStats)
		{
			UpdateCritPercentage(BASE_ATTACK);
			UpdateCritPercentage(OFF_ATTACK);
		}
		break;
	case CR_CRIT_RANGED:
		if (affectStats)
			UpdateCritPercentage(RANGED_ATTACK);
		break;
	case CR_CRIT_SPELL:
		if (affectStats)
			UpdateAllSpellCritChances();
		break;
	case CR_HIT_TAKEN_MELEE:                            // Implemented in Unit::MeleeMissChanceCalc
	case CR_HIT_TAKEN_RANGED:
		break;
	case CR_HIT_TAKEN_SPELL:                            // Implemented in Unit::MagicSpellHitResult
		break;
	case CR_CRIT_TAKEN_MELEE:                           // Implemented in Unit::RollMeleeOutcomeAgainst (only for chance to crit)
	case CR_CRIT_TAKEN_RANGED:
		break;
	case CR_CRIT_TAKEN_SPELL:                           // Implemented in Unit::SpellCriticalBonus (only for chance to crit)
		break;
	case CR_HASTE_MELEE:                                // Implemented in Player::ApplyRatingMod
	case CR_HASTE_RANGED:
	case CR_HASTE_SPELL:
		break;
	case CR_WEAPON_SKILL_MAINHAND:                      // Implemented in Unit::RollMeleeOutcomeAgainst
	case CR_WEAPON_SKILL_OFFHAND:
	case CR_WEAPON_SKILL_RANGED:
		break;
	case CR_EXPERTISE:
		if (affectStats)
		{
			UpdateExpertise(BASE_ATTACK);
			UpdateExpertise(OFF_ATTACK);
		}
		break;
	case CR_ARMOR_PENETRATION:
		if (affectStats)
			UpdateArmorPenetration(amount);
		break;
	}
}

void Player::UpdateAllRatings()
{
	for (int cr = 0; cr < MAX_COMBAT_RATING; ++cr)
		UpdateRating(CombatRating(cr));
}

void Player::SetRegularAttackTime()
{
	for (uint8 i = 0; i < MAX_ATTACK; ++i)
	{
		Item* tmpitem = GetWeaponForAttack(WeaponAttackType(i), true);
		if (tmpitem && !tmpitem->IsBroken())
		{
			ItemTemplate const* proto = tmpitem->GetTemplate();
			if (proto->Delay)
				SetAttackTime(WeaponAttackType(i), proto->Delay);
		}
		else
			SetAttackTime(WeaponAttackType(i), BASE_ATTACK_TIME);  // If there is no weapon reset attack time to base (might have been changed from forms)
	}
}

//skill+step, checking for max value
bool Player::UpdateSkill(uint32 skill_id, uint32 step)
{
	if (!skill_id)
		return false;

	if (skill_id == SKILL_FIST_WEAPONS)
		skill_id = SKILL_UNARMED;

	SkillStatusMap::iterator itr = mSkillStatus.find(skill_id);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return false;

	uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
	uint32 data = GetUInt32Value(valueIndex);
	uint32 value = SKILL_VALUE(data);
	uint32 max = SKILL_MAX(data);

	if ((!max) || (!value) || (value >= max))
		return false;

	if (value < max)
	{
		uint32 new_value = value + step;
		if (new_value > max)
			new_value = max;

		SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(new_value, max));
		if (itr->second.uState != SKILL_NEW)
			itr->second.uState = SKILL_CHANGED;
		UpdateSkillEnchantments(skill_id, value, new_value);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, skill_id);
		return true;
	}

	return false;
}

inline int SkillGainChance(uint32 SkillValue, uint32 GrayLevel, uint32 GreenLevel, uint32 YellowLevel)
{
	if (SkillValue >= GrayLevel)
		return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREY) * 10;
	if (SkillValue >= GreenLevel)
		return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREEN) * 10;
	if (SkillValue >= YellowLevel)
		return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_YELLOW) * 10;
	return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_ORANGE) * 10;
}

bool Player::UpdateCraftSkill(uint32 spellid)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "UpdateCraftSkill spellid %d", spellid);

	SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellid);

	for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
	{
		if (_spell_idx->second->skillId)
		{
			uint32 SkillValue = GetPureSkillValue(_spell_idx->second->skillId);

			// Alchemy Discoveries here
			SpellInfo const* spellEntry = sSpellMgr->GetSpellInfo(spellid);
			if (spellEntry && spellEntry->Mechanic == MECHANIC_DISCOVERY)
			{
				if (uint32 discoveredSpell = GetSkillDiscoverySpell(_spell_idx->second->skillId, spellid, this))
					learnSpell(discoveredSpell);
			}

			uint32 craft_skill_gain = sWorld->getIntConfig(CONFIG_SKILL_GAIN_CRAFTING);

			return UpdateSkillPro(_spell_idx->second->skillId, SkillGainChance(SkillValue,
				_spell_idx->second->max_value,
				(_spell_idx->second->max_value + _spell_idx->second->min_value) / 2,
				_spell_idx->second->min_value),
				craft_skill_gain);
		}
	}
	return false;
}

bool Player::UpdateGatherSkill(uint32 SkillId, uint32 SkillValue, uint32 RedLevel, uint32 Multiplicator)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "UpdateGatherSkill(SkillId %d SkillLevel %d RedLevel %d)", SkillId, SkillValue, RedLevel);

	uint32 gathering_skill_gain = sWorld->getIntConfig(CONFIG_SKILL_GAIN_GATHERING);

	// For skinning and Mining chance decrease with level. 1-74 - no decrease, 75-149 - 2 times, 225-299 - 8 times
	switch (SkillId)
	{
	case SKILL_HERBALISM:
	case SKILL_LOCKPICKING:
	case SKILL_JEWELCRAFTING:
	case SKILL_INSCRIPTION:
		return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25)*Multiplicator, gathering_skill_gain);
	case SKILL_SKINNING:
		if (sWorld->getIntConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS) == 0)
			return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25)*Multiplicator, gathering_skill_gain);
		else
			return UpdateSkillPro(SkillId, (SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25)*Multiplicator) >> (SkillValue / sWorld->getIntConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS)), gathering_skill_gain);
	case SKILL_MINING:
		if (sWorld->getIntConfig(CONFIG_SKILL_CHANCE_MINING_STEPS) == 0)
			return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25)*Multiplicator, gathering_skill_gain);
		else
			return UpdateSkillPro(SkillId, (SkillGainChance(SkillValue, RedLevel + 100, RedLevel + 50, RedLevel + 25)*Multiplicator) >> (SkillValue / sWorld->getIntConfig(CONFIG_SKILL_CHANCE_MINING_STEPS)), gathering_skill_gain);
	}
	return false;
}

bool Player::UpdateFishingSkill()
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "UpdateFishingSkill");

	uint32 SkillValue = GetPureSkillValue(SKILL_FISHING);

	int32 chance = SkillValue < 75 ? 100 : 2500 / (SkillValue - 50);

	uint32 gathering_skill_gain = sWorld->getIntConfig(CONFIG_SKILL_GAIN_GATHERING);

	return UpdateSkillPro(SKILL_FISHING, chance * 10, gathering_skill_gain);
}

// levels sync. with spell requirement for skill levels to learn
// bonus abilities in sSkillLineAbilityStore
// Used only to avoid scan DBC at each skill grow
static uint32 bonusSkillLevels[] = { 75, 150, 225, 300, 375, 450 };
static const size_t bonusSkillLevelsSize = sizeof(bonusSkillLevels) / sizeof(uint32);

bool Player::UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "UpdateSkillPro(SkillId %d, Chance %3.1f%%)", SkillId, Chance / 10.0f);
	if (!SkillId)
		return false;

	if (Chance <= 0)                                         // speedup in 0 chance case
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "Player::UpdateSkillPro Chance=%3.1f%% missed", Chance / 10.0f);
		return false;
	}

	SkillStatusMap::iterator itr = mSkillStatus.find(SkillId);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return false;

	uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);

	uint32 data = GetUInt32Value(valueIndex);
	uint16 SkillValue = SKILL_VALUE(data);
	uint16 MaxValue = SKILL_MAX(data);

	if (!MaxValue || !SkillValue || SkillValue >= MaxValue)
		return false;

	int32 Roll = irand(1, 1000);

	if (Roll <= Chance)
	{
		uint32 new_value = SkillValue + step;
		if (new_value > MaxValue)
			new_value = MaxValue;

		SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(new_value, MaxValue));
		if (itr->second.uState != SKILL_NEW)
			itr->second.uState = SKILL_CHANGED;

		for (size_t i = 0; i < bonusSkillLevelsSize; ++i)
		{
			uint32 bsl = bonusSkillLevels[i];
			if (SkillValue < bsl && new_value >= bsl)
			{
				learnSkillRewardedSpells(SkillId, new_value);
				break;
			}
		}
		UpdateSkillEnchantments(SkillId, SkillValue, new_value);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, SkillId);
		;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "Player::UpdateSkillPro Chance=%3.1f%% taken", Chance / 10.0f);
		return true;
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_SKILLS, "Player::UpdateSkillPro Chance=%3.1f%% missed", Chance / 10.0f);
	return false;
}

void Player::UpdateWeaponSkill(WeaponAttackType attType)
{
	// no skill gain in pvp
	Unit* victim = GetVictim();
	if (victim && victim->GetTypeId() == TYPEID_PLAYER)
		return;

	if (IsInFeralForm())
		return;                                             // always maximized SKILL_FERAL_COMBAT in fact

	if (GetShapeshiftForm() == FORM_TREE)
		return;                                             // use weapon but not skill up

	if (victim && victim->GetTypeId() == TYPEID_UNIT && (victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_SKILLGAIN))
		return;

	uint32 weapon_skill_gain = sWorld->getIntConfig(CONFIG_SKILL_GAIN_WEAPON);

	Item* tmpitem = GetWeaponForAttack(attType, true);
	if (!tmpitem && attType == BASE_ATTACK)
		UpdateSkill(SKILL_UNARMED, weapon_skill_gain);
	else if (tmpitem && tmpitem->GetTemplate()->SubClass != ITEM_SUBCLASS_WEAPON_FISHING_POLE)
		UpdateSkill(tmpitem->GetSkill(), weapon_skill_gain);

	UpdateAllCritPercentages();
}

void Player::UpdateCombatSkills(Unit* victim, WeaponAttackType attType, bool defence)
{
	uint8 plevel = getLevel();                              // if defense than victim == attacker
	uint8 greylevel = Trinity::XP::GetGrayLevel(plevel);
	uint8 moblevel = victim->getLevelForTarget(this);
	/*if (moblevel < greylevel)
		return;*/ // Patch 3.0.8 (2009-01-20): You can no longer skill up weapons on mobs that are immune to damage.

	if (moblevel > plevel + 5)
		moblevel = plevel + 5;

	uint8 lvldif = moblevel - greylevel;
	if (lvldif < 3)
		lvldif = 3;

	uint32 skilldif = 5 * plevel - (defence ? GetBaseDefenseSkillValue() : GetBaseWeaponSkillValue(attType));
	if (skilldif <= 0)
		return;

	float chance = float(3 * lvldif * skilldif) / plevel;
	if (!defence)
		if (getClass() == CLASS_WARRIOR || getClass() == CLASS_ROGUE)
			chance += chance * 0.02f * GetStat(STAT_INTELLECT);

	chance = chance < 1.0f ? 1.0f : chance;                 //minimum chance to increase skill is 1%

	if (roll_chance_f(chance))
	{
		if (defence)
			UpdateDefense();
		else
			UpdateWeaponSkill(attType);
	}
	else
		return;
}

void Player::ModifySkillBonus(uint32 skillid, int32 val, bool talent)
{
	SkillStatusMap::const_iterator itr = mSkillStatus.find(skillid);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return;

	uint32 bonusIndex = PLAYER_SKILL_BONUS_INDEX(itr->second.pos);

	uint32 bonus_val = GetUInt32Value(bonusIndex);
	int16 temp_bonus = SKILL_TEMP_BONUS(bonus_val);
	int16 perm_bonus = SKILL_PERM_BONUS(bonus_val);

	if (talent)                                          // permanent bonus stored in high part
		SetUInt32Value(bonusIndex, MAKE_SKILL_BONUS(temp_bonus, perm_bonus + val));
	else                                                // temporary/item bonus stored in low part
		SetUInt32Value(bonusIndex, MAKE_SKILL_BONUS(temp_bonus + val, perm_bonus));
}

void Player::UpdateSkillsForLevel()
{
	uint16 maxconfskill = sWorld->GetConfigMaxSkillValue();
	uint32 maxSkill = GetMaxSkillValueForLevel();

	bool alwaysMaxSkill = sWorld->getBoolConfig(CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL);

	for (SkillStatusMap::iterator itr = mSkillStatus.begin(); itr != mSkillStatus.end(); ++itr)
	{
		if (itr->second.uState == SKILL_DELETED)
			continue;

		uint32 pskill = itr->first;
		SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(pskill);
		if (!pSkill)
			continue;

		if (GetSkillRangeType(pSkill, false) != SKILL_RANGE_LEVEL)
			continue;

		uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
		uint32 data = GetUInt32Value(valueIndex);
		uint32 max = SKILL_MAX(data);
		uint32 val = SKILL_VALUE(data);

		/// update only level dependent max skill values
		if (max != 1)
		{
			/// maximize skill always
			if (alwaysMaxSkill)
			{
				SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(maxSkill, maxSkill));
				if (itr->second.uState != SKILL_NEW)
					itr->second.uState = SKILL_CHANGED;
			}
			else if (max != maxconfskill)                    /// update max skill value if current max skill not maximized
			{
				SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(val, maxSkill));
				if (itr->second.uState != SKILL_NEW)
					itr->second.uState = SKILL_CHANGED;
			}
		}
	}
}

void Player::UpdateSkillsToMaxSkillsForLevel()
{
	for (SkillStatusMap::iterator itr = mSkillStatus.begin(); itr != mSkillStatus.end(); ++itr)
	{
		if (itr->second.uState == SKILL_DELETED)
			continue;

		uint32 pskill = itr->first;
		if (IsProfessionOrRidingSkill(pskill))
			continue;
		uint32 valueIndex = PLAYER_SKILL_VALUE_INDEX(itr->second.pos);
		uint32 data = GetUInt32Value(valueIndex);
		uint32 max = SKILL_MAX(data);

		if (max > 1)
		{
			SetUInt32Value(valueIndex, MAKE_SKILL_VALUE(max, max));
			if (itr->second.uState != SKILL_NEW)
				itr->second.uState = SKILL_CHANGED;
		}
		if (pskill == SKILL_DEFENSE)
			UpdateDefenseBonusesMod();
	}
}

// This functions sets a skill line value (and adds if doesn't exist yet)
// To "remove" a skill line, set it's values to zero
void Player::SetSkill(uint16 id, uint16 step, uint16 newVal, uint16 maxVal)
{
	if (!id)
		return;

	uint16 currVal;
	SkillStatusMap::iterator itr = mSkillStatus.find(id);

	//has skill
	if (itr != mSkillStatus.end() && itr->second.uState != SKILL_DELETED)
	{
		currVal = SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos)));
		if (newVal)
		{
			// if skill value is going down, update enchantments before setting the new value
			if (newVal < currVal)
				UpdateSkillEnchantments(id, currVal, newVal);
			// update step
			SetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos), MAKE_PAIR32(id, step));
			// update value
			SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos), MAKE_SKILL_VALUE(newVal, maxVal));
			if (itr->second.uState != SKILL_NEW)
				itr->second.uState = SKILL_CHANGED;
			learnSkillRewardedSpells(id, newVal);
			// if skill value is going up, update enchantments after setting the new value
			if (newVal > currVal)
				UpdateSkillEnchantments(id, currVal, newVal);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, id);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL, id);
		}
		else                                                //remove
		{
			//remove enchantments needing this skill
			UpdateSkillEnchantments(id, currVal, 0);
			// clear skill fields
			SetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos), 0);
			SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos), 0);
			SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos), 0);

			// mark as deleted or simply remove from map if not saved yet
			if (itr->second.uState != SKILL_NEW)
				itr->second.uState = SKILL_DELETED;
			else
				mSkillStatus.erase(itr);

			// remove all spells that related to this skill
			for (uint32 j = 0; j < sSkillLineAbilityStore.GetNumRows(); ++j)
				if (SkillLineAbilityEntry const* pAbility = sSkillLineAbilityStore.LookupEntry(j))
					if (pAbility->skillId == id)
						removeSpell(sSpellMgr->GetFirstSpellInChain(pAbility->spellId), SPEC_MASK_ALL, false);
		}
	}
	else if (newVal)                                        //add
	{
		currVal = 0;
		for (int i = 0; i < PLAYER_MAX_SKILLS; ++i)
			if (!GetUInt32Value(PLAYER_SKILL_INDEX(i)))
			{
				SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(id);
				if (!pSkill)
				{
					sLog->outError("Skill not found in SkillLineStore: skill #%u", id);
					return;
				}

				SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id, step));
				SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i), MAKE_SKILL_VALUE(newVal, maxVal));
				UpdateSkillEnchantments(id, currVal, newVal);
				UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL, id);
				UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL, id);

				// insert new entry or update if not deleted old entry yet
				if (itr != mSkillStatus.end())
				{
					itr->second.pos = i;
					itr->second.uState = SKILL_CHANGED;
				}
				else
					mSkillStatus.insert(SkillStatusMap::value_type(id, SkillStatusData(i, SKILL_NEW)));

				// apply skill bonuses
				SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i), 0);

				// temporary bonuses
				AuraEffectList const& mModSkill = GetAuraEffectsByType(SPELL_AURA_MOD_SKILL);
				for (AuraEffectList::const_iterator j = mModSkill.begin(); j != mModSkill.end(); ++j)
					if ((*j)->GetMiscValue() == int32(id))
						(*j)->HandleEffect(this, AURA_EFFECT_HANDLE_SKILL, true);

				// permanent bonuses
				AuraEffectList const& mModSkillTalent = GetAuraEffectsByType(SPELL_AURA_MOD_SKILL_TALENT);
				for (AuraEffectList::const_iterator j = mModSkillTalent.begin(); j != mModSkillTalent.end(); ++j)
					if ((*j)->GetMiscValue() == int32(id))
						(*j)->HandleEffect(this, AURA_EFFECT_HANDLE_SKILL, true);

				// Learn all spells for skill
				learnSkillRewardedSpells(id, newVal);
				return;
			}
	}
}

bool Player::HasSkill(uint32 skill) const
{
	if (!skill)
		return false;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	return (itr != mSkillStatus.end() && itr->second.uState != SKILL_DELETED);
}

uint16 Player::GetSkillStep(uint16 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	return PAIR32_HIPART(GetUInt32Value(PLAYER_SKILL_INDEX(itr->second.pos)));
}

uint16 Player::GetSkillValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos));

	int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
	result += SKILL_TEMP_BONUS(bonus);
	result += SKILL_PERM_BONUS(bonus);
	return result < 0 ? 0 : result;
}

uint16 Player::GetMaxSkillValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos));

	int32 result = int32(SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
	result += SKILL_TEMP_BONUS(bonus);
	result += SKILL_PERM_BONUS(bonus);
	return result < 0 ? 0 : result;
}

uint16 Player::GetPureMaxSkillValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	return SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos)));
}

uint16 Player::GetBaseSkillValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos))));
	result += SKILL_PERM_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
	return result < 0 ? 0 : result;
}

uint16 Player::GetPureSkillValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	return SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos)));
}

int16 Player::GetSkillPermBonusValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	return SKILL_PERM_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
}

int16 Player::GetSkillTempBonusValue(uint32 skill) const
{
	if (!skill)
		return 0;

	SkillStatusMap::const_iterator itr = mSkillStatus.find(skill);
	if (itr == mSkillStatus.end() || itr->second.uState == SKILL_DELETED)
		return 0;

	return SKILL_TEMP_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(itr->second.pos)));
}

void Player::SendActionButtons(uint32 state) const
{
	;//sLog->outDetail("Sending Action Buttons for '%u' spec '%u'", GetGUIDLow(), m_activeSpec);

	WorldPacket data(SMSG_ACTION_BUTTONS, 1 + (MAX_ACTION_BUTTONS * 4));
	data << uint8(state);
	/*
		state can be 0, 1, 2
		0 - Looks to be sent when initial action buttons get sent, however on Trinity we use 1 since 0 had some difficulties
		1 - Used in any SMSG_ACTION_BUTTONS packet with button data on Trinity. Only used after spec swaps on retail.
		2 - Clears the action bars client sided. This is sent during spec swap before unlearning and before sending the new buttons
	*/
	if (state != 2)
	{
		for (uint8 button = 0; button < MAX_ACTION_BUTTONS; ++button)
		{
			ActionButtonList::const_iterator itr = m_actionButtons.find(button);
			if (itr != m_actionButtons.end() && itr->second.uState != ACTIONBUTTON_DELETED)
				data << uint32(itr->second.packedData);
			else
				data << uint32(0);
		}
	}

	GetSession()->SendPacket(&data);
	;//sLog->outDetail("Action Buttons for '%u' spec '%u' Sent", GetGUIDLow(), m_activeSpec);
}

bool Player::IsActionButtonDataValid(uint8 button, uint32 action, uint8 type)
{
	if (button >= MAX_ACTION_BUTTONS)
	{
		sLog->outError("Action %u not added into button %u for player %s: button must be < %u", action, button, GetName().c_str(), MAX_ACTION_BUTTONS);
		return false;
	}

	if (action >= MAX_ACTION_BUTTON_ACTION_VALUE)
	{
		sLog->outError("Action %u not added into button %u for player %s: action must be < %u", action, button, GetName().c_str(), MAX_ACTION_BUTTON_ACTION_VALUE);
		return false;
	}

	switch (type)
	{
	case ACTION_BUTTON_SPELL:
		if (!sSpellMgr->GetSpellInfo(action))
		{
			sLog->outError("Spell action %u not added into button %u for player %s: spell not exist", action, button, GetName().c_str());
			return false;
		}

		if (!HasSpell(action))
		{
			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::IsActionButtonDataValid Spell action %u not added into button %u for player %s: player don't known this spell", action, button, GetName().c_str());
			return false;
		}
		break;
	case ACTION_BUTTON_ITEM:
		if (!sObjectMgr->GetItemTemplate(action))
		{
			sLog->outError("Item action %u not added into button %u for player %s: item not exist", action, button, GetName().c_str());
			return false;
		}
		break;
	default:
		break;                                          // other cases not checked at this moment
	}

	return true;
}

ActionButton* Player::addActionButton(uint8 button, uint32 action, uint8 type)
{
	if (!IsActionButtonDataValid(button, action, type))
		return NULL;

	// it create new button (NEW state) if need or return existed
	ActionButton& ab = m_actionButtons[button];

	// set data and update to CHANGED if not NEW
	ab.SetActionAndType(action, ActionButtonType(type));

	;//sLog->outDetail("Player '%u' Added Action '%u' (type %u) to Button '%u'", GetGUIDLow(), action, type, button);
	return &ab;
}

void Player::removeActionButton(uint8 button)
{
	ActionButtonList::iterator buttonItr = m_actionButtons.find(button);
	if (buttonItr == m_actionButtons.end() || buttonItr->second.uState == ACTIONBUTTON_DELETED)
		return;

	if (buttonItr->second.uState == ACTIONBUTTON_NEW)
		m_actionButtons.erase(buttonItr);                   // new and not saved
	else
		buttonItr->second.uState = ACTIONBUTTON_DELETED;    // saved, will deleted at next save

	;//sLog->outDetail("Action Button '%u' Removed from Player '%u'", button, GetGUIDLow());
}

ActionButton const* Player::GetActionButton(uint8 button)
{
	ActionButtonList::iterator buttonItr = m_actionButtons.find(button);
	if (buttonItr == m_actionButtons.end() || buttonItr->second.uState == ACTIONBUTTON_DELETED)
		return NULL;

	return &buttonItr->second;
}

bool Player::UpdatePosition(float x, float y, float z, float orientation, bool teleport)
{
	if (!Unit::UpdatePosition(x, y, z, orientation, teleport))
		return false;

	if (GetGroup())
		SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POSITION);

	if (GetTrader() && !IsWithinDistInMap(GetTrader(), INTERACTION_DISTANCE))
		GetSession()->SendCancelTrade();

	CheckAreaExploreAndOutdoor();

	return true;
}

void Player::SaveRecallPosition()
{
	m_recallMap = GetMapId();
	m_recallX = GetPositionX();
	m_recallY = GetPositionY();
	m_recallZ = GetPositionZ();
	m_recallO = GetOrientation();
}

// pussywizard!
void Player::SendMessageToSetInRange(WorldPacket* data, float dist, bool self, bool includeMargin, Player const* skipped_rcvr)
{
	if (self)
		GetSession()->SendPacket(data);

	dist += GetObjectSize();
	if (includeMargin)
		dist += VISIBILITY_COMPENSATION; // pussywizard: to ensure everyone receives all important packets
	Trinity::MessageDistDeliverer notifier(this, data, dist, false, skipped_rcvr);
	VisitNearbyWorldObject(dist, notifier);
}

// pussywizard!
void Player::SendMessageToSetInRange_OwnTeam(WorldPacket* data, float dist, bool self)
{
	if (self)
		GetSession()->SendPacket(data);

	Trinity::MessageDistDeliverer notifier(this, data, dist, true);
	VisitNearbyWorldObject(dist, notifier);
}

void Player::SendDirectMessage(WorldPacket* data)
{
	m_session->SendPacket(data);
}

void Player::SendCinematicStart(uint32 CinematicSequenceId)
{
	WorldPacket data(SMSG_TRIGGER_CINEMATIC, 4);
	data << uint32(CinematicSequenceId);
	SendDirectMessage(&data);
}

void Player::SendMovieStart(uint32 MovieId)
{
	WorldPacket data(SMSG_TRIGGER_MOVIE, 4);
	data << uint32(MovieId);
	SendDirectMessage(&data);
}

void Player::CheckAreaExploreAndOutdoor()
{
	if (!IsAlive())
		return;

	if (IsInFlight())
		return;

	bool isOutdoor = IsOutdoors();
	uint32 areaFlag = GetAreaFlagByAreaID(GetAreaId());

	if (sWorld->getBoolConfig(CONFIG_VMAP_INDOOR_CHECK) && !isOutdoor)
		RemoveAurasWithAttribute(SPELL_ATTR0_OUTDOORS_ONLY);

	if (areaFlag == 0xffff)
		return;
	int offset = areaFlag / 32;

	if (offset >= PLAYER_EXPLORED_ZONES_SIZE)
	{
		;//sLog->outError("Wrong area flag %u in map data for (X: %f Y: %f) point to field PLAYER_EXPLORED_ZONES_1 + %u ( %u must be < %u ).", areaFlag, GetPositionX(), GetPositionY(), offset, offset, PLAYER_EXPLORED_ZONES_SIZE);
		return;
	}

	uint32 val = (uint32)(1 << (areaFlag % 32));
	uint32 currFields = GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);

	if (!(currFields & val))
	{
		SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, (uint32)(currFields | val));

		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA, GetAreaId());

		AreaTableEntry const* areaEntry = GetAreaEntryByAreaFlagAndMap(areaFlag, GetMapId());
		if (!areaEntry)
		{
			sLog->outError("Player %u discovered unknown area (x: %f y: %f z: %f map: %u", GetGUIDLow(), GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId());
			return;
		}

		if (areaEntry->area_level > 0)
		{
			uint32 area = areaEntry->ID;
			if (getLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
			{
				SendExplorationExperience(area, 0);
			}
			else
			{
				int32 diff = int32(getLevel()) - areaEntry->area_level;
				uint32 XP = 0;
				if (diff < -5)
				{
					XP = uint32(sObjectMgr->GetBaseXP(getLevel() + 5)*sWorld->getRate(RATE_XP_EXPLORE));
				}
				else if (diff > 5)
				{
					int32 exploration_percent = (100 - ((diff - 5) * 5));
					if (exploration_percent > 100)
						exploration_percent = 100;
					else if (exploration_percent < 0)
						exploration_percent = 0;

					XP = uint32(sObjectMgr->GetBaseXP(areaEntry->area_level)*exploration_percent / 100 * sWorld->getRate(RATE_XP_EXPLORE));
				}
				else
				{
					XP = uint32(sObjectMgr->GetBaseXP(areaEntry->area_level)*sWorld->getRate(RATE_XP_EXPLORE));
				}

				GiveXP(XP, NULL);
				SendExplorationExperience(area, XP);
			}
			;//sLog->outDetail("Player %u discovered a new area: %u", GetGUIDLow(), area);
		}
	}
}

TeamId Player::TeamIdForRace(uint8 race)
{
	if (ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race))
	{
		switch (rEntry->TeamID)
		{
		case 1: return TEAM_HORDE;
		case 7: return TEAM_ALLIANCE;
		}
		sLog->outError("Race (%u) has wrong teamid (%u) in DBC: wrong DBC files?", uint32(race), rEntry->TeamID);
	}
	else
		sLog->outError("Race (%u) not found in DBC: wrong DBC files?", uint32(race));

	return TEAM_ALLIANCE;
}

void Player::setFactionForRace(uint8 race)
{
	m_team = TeamIdForRace(race);

	sScriptMgr->OnPlayerUpdateFaction(this);

	if (GetTeamId(true) != GetTeamId())
		return;

	ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race);
	setFaction(rEntry ? rEntry->FactionID : 0);
}

ReputationRank Player::GetReputationRank(uint32 faction) const
{
	FactionEntry const* factionEntry = sFactionStore.LookupEntry(faction);
	return GetReputationMgr().GetRank(factionEntry);
}

// Calculate total reputation percent player gain with quest/creature level
int32 Player::CalculateReputationGain(ReputationSource source, uint32 creatureOrQuestLevel, int32 rep, int32 faction, bool noQuestBonus)
{
	float percent = 100.0f;

	float repMod = noQuestBonus ? 0.0f : float(GetTotalAuraModifier(SPELL_AURA_MOD_REPUTATION_GAIN));

	// faction specific auras only seem to apply to kills
	if (source == REPUTATION_SOURCE_KILL)
		repMod += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_FACTION_REPUTATION_GAIN, faction);

	percent += rep > 0 ? repMod : -repMod;

	float rate;
	switch (source)
	{
	case REPUTATION_SOURCE_KILL:
		rate = sWorld->getRate(RATE_REPUTATION_LOWLEVEL_KILL);
		break;
	case REPUTATION_SOURCE_QUEST:
	case REPUTATION_SOURCE_DAILY_QUEST:
	case REPUTATION_SOURCE_WEEKLY_QUEST:
	case REPUTATION_SOURCE_MONTHLY_QUEST:
	case REPUTATION_SOURCE_REPEATABLE_QUEST:
		rate = sWorld->getRate(RATE_REPUTATION_LOWLEVEL_QUEST);
		break;
	case REPUTATION_SOURCE_SPELL:
	default:
		rate = 1.0f;
		break;
	}

	if (rate != 1.0f && creatureOrQuestLevel <= Trinity::XP::GetGrayLevel(getLevel()))
		percent *= rate;

	if (percent <= 0.0f)
		return 0;

	// Multiply result with the faction specific rate
	if (RepRewardRate const* repData = sObjectMgr->GetRepRewardRate(faction))
	{
		float repRate = 0.0f;
		switch (source)
		{
		case REPUTATION_SOURCE_KILL:
			repRate = repData->creatureRate;
			break;
		case REPUTATION_SOURCE_QUEST:
			repRate = repData->questRate;
			break;
		case REPUTATION_SOURCE_DAILY_QUEST:
			repRate = repData->questDailyRate;
			break;
		case REPUTATION_SOURCE_WEEKLY_QUEST:
			repRate = repData->questWeeklyRate;
			break;
		case REPUTATION_SOURCE_MONTHLY_QUEST:
			repRate = repData->questMonthlyRate;
			break;
		case REPUTATION_SOURCE_REPEATABLE_QUEST:
			repRate = repData->questRepeatableRate;
			break;
		case REPUTATION_SOURCE_SPELL:
			repRate = repData->spellRate;
			break;
		}

		// for custom, a rate of 0.0 will totally disable reputation gain for this faction/type
		if (repRate <= 0.0f)
			return 0;

		percent *= repRate;
	}

	if (source != REPUTATION_SOURCE_SPELL && GetsRecruitAFriendBonus(false))
		percent *= 1.0f + sWorld->getRate(RATE_REPUTATION_RECRUIT_A_FRIEND_BONUS);

	return CalculatePct(rep, percent);
}

// Calculates how many reputation points player gains in victim's enemy factions
void Player::RewardReputation(Unit* victim, float rate)
{
	if (!victim || victim->GetTypeId() == TYPEID_PLAYER)
		return;

	if (victim->ToCreature()->IsReputationGainDisabled())
		return;

	ReputationOnKillEntry const* Rep = sObjectMgr->GetReputationOnKilEntry(victim->ToCreature()->GetCreatureTemplate()->Entry);
	if (!Rep)
		return;

	uint32 ChampioningFaction = 0;

	if (GetChampioningFaction())
	{
		// support for: Championing - http://www.wowwiki.com/Championing
		Map const* map = GetMap();
		if (map->IsNonRaidDungeon())
			if (LFGDungeonEntry const* dungeon = GetLFGDungeon(map->GetId(), map->GetDifficulty()))
				if (dungeon->reclevel == 80)
					ChampioningFaction = GetChampioningFaction();
	}

	TeamId teamId = GetTeamId(true); // Always check player original reputation when rewarding

	if (Rep->RepFaction1 && (!Rep->TeamDependent || teamId == TEAM_ALLIANCE))
	{
		int32 donerep1 = CalculateReputationGain(REPUTATION_SOURCE_KILL, victim->getLevel(), Rep->RepValue1, ChampioningFaction ? ChampioningFaction : Rep->RepFaction1);
		donerep1 = int32(donerep1 * rate);

		FactionEntry const* factionEntry1 = sFactionStore.LookupEntry(ChampioningFaction ? ChampioningFaction : Rep->RepFaction1);
		uint32 current_reputation_rank1 = GetReputationMgr().GetRank(factionEntry1);
		if (factionEntry1)
			GetReputationMgr().ModifyReputation(factionEntry1, donerep1, bool(current_reputation_rank1 > Rep->ReputationMaxCap1));
	}

	if (Rep->RepFaction2 && (!Rep->TeamDependent || teamId == TEAM_HORDE))
	{
		int32 donerep2 = CalculateReputationGain(REPUTATION_SOURCE_KILL, victim->getLevel(), Rep->RepValue2, ChampioningFaction ? ChampioningFaction : Rep->RepFaction2);
		donerep2 = int32(donerep2 * rate);

		FactionEntry const* factionEntry2 = sFactionStore.LookupEntry(ChampioningFaction ? ChampioningFaction : Rep->RepFaction2);
		uint32 current_reputation_rank2 = GetReputationMgr().GetRank(factionEntry2);
		if (factionEntry2)
			GetReputationMgr().ModifyReputation(factionEntry2, donerep2, bool(current_reputation_rank2 > Rep->ReputationMaxCap2));
	}
}

// Calculate how many reputation points player gain with the quest
void Player::RewardReputation(Quest const* quest)
{
	for (uint8 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
	{
		if (!quest->RewardFactionId[i])
			continue;

		int32 rep = 0;
		bool noQuestBonus = false;

		if (quest->RewardFactionValueIdOverride[i])
		{
			rep = quest->RewardFactionValueIdOverride[i] / 100;
			noQuestBonus = true;
		}
		else
		{
			uint32 row = ((quest->RewardFactionValueId[i] < 0) ? 1 : 0) + 1;
			if (QuestFactionRewEntry const* questFactionRewEntry = sQuestFactionRewardStore.LookupEntry(row))
			{
				uint32 field = abs(quest->RewardFactionValueId[i]);
				rep = questFactionRewEntry->QuestRewFactionValue[field];
			}
		}

		if (!rep)
			continue;

		if (quest->IsDaily())
			rep = CalculateReputationGain(REPUTATION_SOURCE_DAILY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], noQuestBonus);
		else if (quest->IsWeekly())
			rep = CalculateReputationGain(REPUTATION_SOURCE_WEEKLY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], noQuestBonus);
		else if (quest->IsMonthly())
			rep = CalculateReputationGain(REPUTATION_SOURCE_MONTHLY_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], noQuestBonus);
		else if (quest->IsRepeatable())
			rep = CalculateReputationGain(REPUTATION_SOURCE_REPEATABLE_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], noQuestBonus);
		else
			rep = CalculateReputationGain(REPUTATION_SOURCE_QUEST, GetQuestLevel(quest), rep, quest->RewardFactionId[i], noQuestBonus);

		if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->RewardFactionId[i]))
			GetReputationMgr().ModifyReputation(factionEntry, rep);
	}
}

void Player::UpdateHonorFields()
{
	/// called when rewarding honor and at each save
	time_t now = time_t(time(NULL));
	time_t today = time_t(time(NULL) / DAY) * DAY;

	if (m_lastHonorUpdateTime < today)
	{
		time_t yesterday = today - DAY;

		uint16 kills_today = PAIR32_LOPART(GetUInt32Value(PLAYER_FIELD_KILLS));

		// update yesterday's contribution
		if (m_lastHonorUpdateTime >= yesterday)
		{
			SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));

			// this is the first update today, reset today's contribution
			SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
			SetUInt32Value(PLAYER_FIELD_KILLS, MAKE_PAIR32(0, kills_today));
		}
		else
		{
			// no honor/kills yesterday or today, reset
			SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
			SetUInt32Value(PLAYER_FIELD_KILLS, 0);
		}
	}

	m_lastHonorUpdateTime = now;
}

///Calculate the amount of honor gained based on the victim
///and the size of the group for which the honor is divided
///An exact honor value can also be given (overriding the calcs)
bool Player::RewardHonor(Unit* uVictim, uint32 groupsize, int32 honor, bool awardXP)
{
	// do not reward honor in arenas, but enable onkill spellproc
	if (InArena())
	{
		if (!uVictim || uVictim == this || uVictim->GetTypeId() != TYPEID_PLAYER)
			return false;

		if (GetBgTeamId() == uVictim->ToPlayer()->GetBgTeamId())
			return false;

		return true;
	}

	// 'Inactive' this aura prevents the player from gaining honor points and battleground tokens
	if (HasAura(SPELL_AURA_PLAYER_INACTIVE))
		return false;

	/* check if player has same IP
	if (uVictim && uVictim->GetTypeId() == TYPEID_PLAYER)
	{
		if (GetSession()->GetRemoteAddress() == uVictim->ToPlayer()->GetSession()->GetRemoteAddress())
			return false;
	}
	*/

	uint64 victim_guid = 0;
	uint32 victim_rank = 0;

	// need call before fields update to have chance move yesterday data to appropriate fields before today data change.
	UpdateHonorFields();

	// do not reward honor in arenas, but return true to enable onkill spellproc
	if (InArena())
		return true;

	// Promote to float for calculations
	float honor_f = (float)honor;

	if (honor_f <= 0)
	{
		if (!uVictim || uVictim == this || uVictim->HasAuraType(SPELL_AURA_NO_PVP_CREDIT))
			return false;

		victim_guid = uVictim->GetGUID();

		if (uVictim->GetTypeId() == TYPEID_PLAYER)
		{
			Player* victim = uVictim->ToPlayer();

			if (GetTeamId() == victim->GetTeamId() && !sWorld->IsFFAPvPRealm())
				return false;

			uint8 k_level = getLevel();
			uint8 k_grey = Trinity::XP::GetGrayLevel(k_level);
			uint8 v_level = victim->getLevel();

			if (v_level <= k_grey)
				return false;

			// PLAYER_CHOSEN_TITLE VALUES DESCRIPTION
			//  [0]      Just name
			//  [1..14]  Alliance honor titles and player name
			//  [15..28] Horde honor titles and player name
			//  [29..38] Other title and player name
			//  [39+]    Nothing
			uint32 victim_title = victim->GetUInt32Value(PLAYER_CHOSEN_TITLE);
			// Get Killer titles, CharTitlesEntry::bit_index
			// Ranks:
			//  title[1..14]  -> rank[5..18]
			//  title[15..28] -> rank[5..18]
			//  title[other]  -> 0
			if (victim_title == 0)
				victim_guid = 0;                        // Don't show HK: <rank> message, only log.
			else if (victim_title < 15)
				victim_rank = victim_title + 4;
			else if (victim_title < 29)
				victim_rank = victim_title - 14 + 4;
			else
				victim_guid = 0;                        // Don't show HK: <rank> message, only log.

			honor_f = ceil(Trinity::Honor::hk_honor_at_level_f(k_level) * (v_level - k_grey) / (k_level - k_grey));

			// count the number of playerkills in one day
			ApplyModUInt32Value(PLAYER_FIELD_KILLS, 1, true);
			// and those in a lifetime
			ApplyModUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 1, true);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS, victim->getClass());
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_RACE, victim->getRace());
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA, GetAreaId());
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL, 1, 0, victim);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL, 1, 0, victim);
		}
		else
		{
			if (!uVictim->ToCreature()->IsRacialLeader())
				return false;

			honor_f = 100.0f;                               // ??? need more info
			victim_rank = 19;                               // HK: Leader
		}
	}

	if (uVictim != NULL)
	{
		if (groupsize > 1)
			honor_f /= groupsize;

		// apply honor multiplier from aura (not stacking-get highest)
		AddPct(honor_f, GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HONOR_GAIN_PCT));
	}

	honor_f *= sWorld->getRate(RATE_HONOR);
	// Back to int now
	honor = int32(honor_f);
	// honor - for show honor points in log
	// victim_guid - for show victim name in log
	// victim_rank [1..4]  HK: <dishonored rank>
	// victim_rank [5..19] HK: <alliance\horde rank>
	// victim_rank [0, 20+] HK: <>
	WorldPacket data(SMSG_PVP_CREDIT, 4 + 8 + 4);
	data << honor;
	data << victim_guid;
	data << victim_rank;

	// Xinef: non quest case, quest honor obtain is send in quest reward packet
	if (uVictim || groupsize > 0)
		GetSession()->SendPacket(&data);

	// add honor points
	ModifyHonorPoints(honor);

	ApplyModUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, honor, true);

	// Xinef: Battleground experience
	if (awardXP)
		if (Battleground* bg = GetBattleground())
		{
			bg->UpdatePlayerScore(this, SCORE_BONUS_HONOR, honor, false); //false: prevent looping
			// Xinef: Only for BG activities
			if (!uVictim)
				GiveXP(uint32(honor*(3 + getLevel()*0.30f)), NULL);
		}

	return true;
}

void Player::SetHonorPoints(uint32 value)
{
	if (value > sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS))
		value = sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS);
	SetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY, value);
	if (value)
		AddKnownCurrency(ITEM_HONOR_POINTS_ID);
}

void Player::SetArenaPoints(uint32 value)
{
	if (value > sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS))
		value = sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS);
	SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, value);
	if (value)
		AddKnownCurrency(ITEM_ARENA_POINTS_ID);
}

void Player::ModifyHonorPoints(int32 value, SQLTransaction* trans /*=NULL*/)
{
	int32 newValue = int32(GetHonorPoints()) + value;
	if (newValue < 0)
		newValue = 0;
	SetHonorPoints(uint32(newValue));

	if (trans && !trans->null())
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_HONOR_POINTS);
		stmt->setUInt32(0, newValue);
		stmt->setUInt32(1, GetGUIDLow());
		(*trans)->Append(stmt);
	}
}

void Player::ModifyArenaPoints(int32 value, SQLTransaction* trans /*=NULL*/)
{
	int32 newValue = int32(GetArenaPoints()) + value;
	if (newValue < 0)
		newValue = 0;
	SetArenaPoints(uint32(newValue));

	if (trans && !trans->null())
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_ARENA_POINTS);
		stmt->setUInt32(0, newValue);
		stmt->setUInt32(1, GetGUIDLow());
		(*trans)->Append(stmt);
	}
}

uint32 Player::GetGuildIdFromStorage(uint32 guid)
{
	if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(guid))
		return playerData->guildId;
	return 0;
}

uint32 Player::GetGroupIdFromStorage(uint32 guid)
{
	if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(guid))
		return playerData->groupId;
	return 0;
}

uint32 Player::GetArenaTeamIdFromStorage(uint32 guid, uint8 slot)
{
	if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(guid))
		return playerData->arenaTeamId[slot];
	return 0;
}

uint32 Player::GetArenaTeamIdFromDB(uint64 guid, uint8 type)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ARENA_TEAM_ID_BY_PLAYER_GUID);
	stmt->setUInt32(0, GUID_LOPART(guid));
	stmt->setUInt8(1, type);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result)
		return 0;

	uint32 id = (*result)[0].GetUInt32();
	return id;
}

uint32 Player::GetZoneIdFromDB(uint64 guid)
{
	uint32 guidLow = GUID_LOPART(guid);
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_ZONE);
	stmt->setUInt32(0, guidLow);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result)
		return 0;
	Field* fields = result->Fetch();
	uint32 zone = fields[0].GetUInt16();

	if (!zone)
	{
		// stored zone is zero, use generic and slow zone detection
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_POSITION_XYZ);
		stmt->setUInt32(0, guidLow);
		PreparedQueryResult result = CharacterDatabase.Query(stmt);

		if (!result)
			return 0;
		fields = result->Fetch();
		uint32 map = fields[0].GetUInt16();
		float posx = fields[1].GetFloat();
		float posy = fields[2].GetFloat();
		float posz = fields[3].GetFloat();

		if (!sMapStore.LookupEntry(map))
			return 0;

		zone = sMapMgr->GetZoneId(map, posx, posy, posz);

		if (zone > 0)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ZONE);

			stmt->setUInt16(0, uint16(zone));
			stmt->setUInt32(1, guidLow);

			CharacterDatabase.Execute(stmt);
		}
	}

	return zone;
}

uint32 Player::GetLevelFromStorage(uint64 guid)
{
	// xinef: Get data from global storage
	if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(GUID_LOPART(guid)))
		return playerData->level;

	return 0;
}

void Player::UpdateArea(uint32 newArea)
{
	// pussywizard: inform instance, needed for Icecrown Citadel
	if (InstanceScript* instance = GetInstanceScript())
		instance->OnPlayerAreaUpdate(this, m_areaUpdateId, newArea);

	// FFA_PVP flags are area and not zone id dependent
	// so apply them accordingly
	m_areaUpdateId = newArea;

	AreaTableEntry const* area = GetAreaEntryByAreaID(newArea);
	bool oldFFAPvPArea = pvpInfo.IsInFFAPvPArea;
	pvpInfo.IsInFFAPvPArea = area && (area->flags & AREA_FLAG_ARENA);
	UpdatePvPState(true);

	// xinef: check if we were in ffa arena and we left
	if (oldFFAPvPArea && !pvpInfo.IsInFFAPvPArea)
	{
		// xinef: iterate attackers
		AttackerSet toRemove;
		AttackerSet const& attackers = getAttackers();
		for (AttackerSet::const_iterator itr = attackers.begin(); itr != attackers.end(); ++itr)
			if (!(*itr)->IsValidAttackTarget(this))
				toRemove.insert(*itr);

		for (AttackerSet::const_iterator itr = toRemove.begin(); itr != toRemove.end(); ++itr)
			(*itr)->AttackStop();

		// xinef: remove our own victim
		if (Unit* victim = GetVictim())
			if (!IsValidAttackTarget(victim))
				AttackStop();
	}

	UpdateAreaDependentAuras(newArea);

	pvpInfo.IsInNoPvPArea = false;
	if (!area)
	{
		RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY);
		RemoveRestState();
		return;
	}

	// Xinef: area should inherit zone flags
	AreaTableEntry const* zone = GetAreaEntryByAreaID(area->zone);
	uint32 areaFlags = area->flags;
	bool isSanctuary = area->IsSanctuary();
	bool isInn = area->IsInn(GetTeamId(true));
	if (zone)
	{
		areaFlags |= zone->flags;
		isSanctuary |= zone->IsSanctuary();
		isInn |= zone->IsInn(GetTeamId(true));
	}

	// previously this was in UpdateZone (but after UpdateArea) so nothing will break
	if (isSanctuary)    // in sanctuary
	{
		SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY);
		pvpInfo.IsInNoPvPArea = true;
		CombatStopWithPets();
	}
	else
		RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY);

	if (isInn)
	{
		SetRestState(0);
		if (sWorld->IsFFAPvPRealm())
			RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
	}
	else if (!(areaFlags & AREA_FLAG_CAPITAL))
	{
		AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(GetInnTriggerId());
		if (!atEntry || !IsInAreaTriggerRadius(atEntry))
			RemoveRestState();
	}
}

uint32 Player::GetZoneId(bool forceRecalc) const
{
	if (forceRecalc)
		*(const_cast<uint32*>(&m_last_zone_id)) = WorldObject::GetZoneId();

	return m_last_zone_id;
}

uint32 Player::GetAreaId(bool forceRecalc) const
{
	if (forceRecalc)
		*(const_cast<uint32*>(&m_last_area_id)) = WorldObject::GetAreaId();

	return m_last_area_id;
}

void Player::GetZoneAndAreaId(uint32& zoneid, uint32& areaid, bool forceRecalc) const
{
	if (forceRecalc)
	{
		WorldObject::GetZoneAndAreaId(zoneid, areaid);
		*(const_cast<uint32*>(&m_last_zone_id)) = zoneid;
		*(const_cast<uint32*>(&m_last_area_id)) = areaid;
		return;
	}

	zoneid = m_last_zone_id;
	areaid = m_last_area_id;
}

void Player::UpdateZone(uint32 newZone, uint32 newArea)
{
	if (m_zoneUpdateId != newZone)
	{
		sOutdoorPvPMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
		sOutdoorPvPMgr->HandlePlayerEnterZone(this, newZone);
		sBattlefieldMgr->HandlePlayerLeaveZone(this, m_zoneUpdateId);
		sBattlefieldMgr->HandlePlayerEnterZone(this, newZone);
		SendInitWorldStates(newZone, newArea);              // only if really enters to new zone, not just area change, works strange...
		if (Guild* guild = GetGuild())
			guild->UpdateMemberData(this, GUILD_MEMBER_DATA_ZONEID, newZone);
	}

	// group update
	if (GetGroup())
		SetGroupUpdateFlag(GROUP_UPDATE_FULL);

	m_zoneUpdateId = newZone;
	m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;

	// zone changed, so area changed as well, update it
	UpdateArea(newArea);

	AreaTableEntry const* zone = GetAreaEntryByAreaID(newZone);
	if (!zone)
		return;

	if (sWorld->getBoolConfig(CONFIG_WEATHER))
	{
		if (Weather* weather = WeatherMgr::FindWeather(zone->ID))
			weather->SendWeatherUpdateToPlayer(this);
		else if (!WeatherMgr::AddWeather(zone->ID))
			// send fine weather packet to remove old zone's weather
			WeatherMgr::SendFineWeatherUpdateToPlayer(this);
	}

	sScriptMgr->OnPlayerUpdateZone(this, newZone, newArea);

	// in PvP, any not controlled zone (except zone->team == 6, default case)
	// in PvE, only opposition team capital
	switch (zone->team)
	{
	case AREATEAM_ALLY:
		pvpInfo.IsInHostileArea = GetTeamId(true) != TEAM_ALLIANCE && (sWorld->IsPvPRealm() || zone->flags & AREA_FLAG_CAPITAL);
		break;
	case AREATEAM_HORDE:
		pvpInfo.IsInHostileArea = GetTeamId(true) != TEAM_HORDE && (sWorld->IsPvPRealm() || zone->flags & AREA_FLAG_CAPITAL);
		break;
	case AREATEAM_NONE:
		// overwrite for battlegrounds, maybe batter some zone flags but current known not 100% fit to this
		pvpInfo.IsInHostileArea = sWorld->IsPvPRealm() || InBattleground() || zone->flags & AREA_FLAG_WINTERGRASP;
		break;
	default:                                            // 6 in fact
		pvpInfo.IsInHostileArea = false;
		break;
	}

	// Treat players having a quest flagging for PvP as always in hostile area
	pvpInfo.IsHostile = pvpInfo.IsInHostileArea || HasPvPForcingQuest();

	if (zone->flags & AREA_FLAG_CAPITAL)                     // Is in a capital city
	{
		if (!pvpInfo.IsHostile || zone->IsSanctuary())
			SetRestState(0);

		pvpInfo.IsInNoPvPArea = true;
	}

	UpdatePvPState();

	// remove items with area/map limitations (delete only for alive player to allow back in ghost mode)
	// if player resurrected at teleport this will be applied in resurrect code
	if (IsAlive())
		DestroyZoneLimitedItem(true, newZone);

	// check some item equip limitations (in result lost CanTitanGrip at talent reset, for example)
	AutoUnequipOffhandIfNeed();

	// recent client version not send leave/join channel packets for built-in local channels
	UpdateLocalChannels(newZone);

	UpdateZoneDependentAuras(newZone);
}

//If players are too far away from the duel flag... they lose the duel
void Player::CheckDuelDistance(time_t currTime)
{
	if (!duel)
		return;

	uint64 duelFlagGUID = GetUInt64Value(PLAYER_DUEL_ARBITER);
	GameObject* obj = GetMap()->GetGameObject(duelFlagGUID);
	if (!obj)
		return;

	if (duel->outOfBound == 0)
	{
		if (!IsWithinDistInMap(obj, 50))
		{
			duel->outOfBound = currTime;

			WorldPacket data(SMSG_DUEL_OUTOFBOUNDS, 0);
			GetSession()->SendPacket(&data);
		}
	}
	else
	{
		if (IsWithinDistInMap(obj, 40))
		{
			duel->outOfBound = 0;

			WorldPacket data(SMSG_DUEL_INBOUNDS, 0);
			GetSession()->SendPacket(&data);
		}
		else if (currTime >= (duel->outOfBound + 10))
			DuelComplete(DUEL_FLED);
	}
}

bool Player::IsOutdoorPvPActive()
{
	return IsAlive() && !HasInvisibilityAura() && !HasStealthAura() && IsPvP() && !HasUnitMovementFlag(MOVEMENTFLAG_FLYING) && !IsInFlight();
}

void Player::DuelComplete(DuelCompleteType type)
{
	// duel not requested
	if (!duel)
		return;

	;//sLog->outDebug(LOG_FILTER_UNITS, "Duel Complete %s %s", GetName().c_str(), duel->opponent->GetName().c_str());

	WorldPacket data(SMSG_DUEL_COMPLETE, (1));
	data << (uint8)((type != DUEL_INTERRUPTED) ? 1 : 0);
	GetSession()->SendPacket(&data);

	duel->opponent->GetSession()->SendPacket(&data);

	if (type != DUEL_INTERRUPTED)
	{
		data.Initialize(SMSG_DUEL_WINNER, (1 + 20));          // we guess size
		data << uint8(type == DUEL_WON ? 0 : 1);            // 0 = just won; 1 = fled
		data << duel->opponent->GetName();
		data << GetName();
		SendMessageToSet(&data, true);
	}

	sScriptMgr->OnPlayerDuelEnd(duel->opponent, this, type);

	switch (type)
	{
	case DUEL_FLED:
		// if initiator and opponent are on the same team
		// or initiator and opponent are not PvP enabled, forcibly stop attacking
		if (duel->initiator->GetTeamId() == duel->opponent->GetTeamId())
		{
			duel->initiator->AttackStop();
			duel->opponent->AttackStop();
		}
		else
		{
			if (!duel->initiator->IsPvP())
				duel->initiator->AttackStop();
			if (!duel->opponent->IsPvP())
				duel->opponent->AttackStop();
		}
		break;
	case DUEL_WON:
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOSE_DUEL, 1);
		duel->opponent->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL, 1);

		// Credit for quest Death's Challenge
		if (getClass() == CLASS_DEATH_KNIGHT && duel->opponent->GetQuestStatus(12733) == QUEST_STATUS_INCOMPLETE)
			duel->opponent->CastSpell(duel->opponent, 52994, true);

		// Honor points after duel (the winner) - ImpConfig
		if (uint32 amount = sWorld->getIntConfig(CONFIG_HONOR_AFTER_DUEL))
			duel->opponent->RewardHonor(NULL, 1, amount);

		break;
	default:
		break;
	}

	// Victory emote spell
	if (type != DUEL_INTERRUPTED && duel->opponent)
		duel->opponent->CastSpell(duel->opponent, 52852, true);

	//Remove Duel Flag object
	GameObject* obj = GetMap()->GetGameObject(GetUInt64Value(PLAYER_DUEL_ARBITER));
	if (obj)
		duel->initiator->RemoveGameObject(obj, true);

	/* remove auras */
	AuraApplicationMap &itsAuras = duel->opponent->GetAppliedAuras();
	for (AuraApplicationMap::iterator i = itsAuras.begin(); i != itsAuras.end();)
	{
		Aura const* aura = i->second->GetBase();
		if (!i->second->IsPositive() && aura->GetCasterGUID() == GetGUID() && aura->GetApplyTime() >= duel->startTime)
			duel->opponent->RemoveAura(i);
		else
			++i;
	}

	AuraApplicationMap &myAuras = GetAppliedAuras();
	for (AuraApplicationMap::iterator i = myAuras.begin(); i != myAuras.end();)
	{
		Aura const* aura = i->second->GetBase();
		if (!i->second->IsPositive() && aura->GetCasterGUID() == duel->opponent->GetGUID() && aura->GetApplyTime() >= duel->startTime)
			RemoveAura(i);
		else
			++i;
	}

	// cleanup combo points
	if (GetComboTarget() == duel->opponent->GetGUID())
		ClearComboPoints();
	else if (GetComboTarget() == duel->opponent->GetPetGUID())
		ClearComboPoints();

	if (duel->opponent->GetComboTarget() == GetGUID())
		duel->opponent->ClearComboPoints();
	else if (duel->opponent->GetComboTarget() == GetPetGUID())
		duel->opponent->ClearComboPoints();

	//cleanups
	SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
	SetUInt32Value(PLAYER_DUEL_TEAM, 0);
	duel->opponent->SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
	duel->opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 0);

	delete duel->opponent->duel;
	duel->opponent->duel = NULL;
	delete duel;
	duel = NULL;
}

//---------------------------------------------------------//

void Player::_ApplyItemMods(Item* item, uint8 slot, bool apply)
{
	if (slot >= INVENTORY_SLOT_BAG_END || !item)
		return;

	ItemTemplate const* proto = item->GetTemplate();

	if (!proto)
		return;

	// not apply/remove mods for broken item
	if (item->IsBroken())
		return;

	;//sLog->outDetail("applying mods for item %u ", item->GetGUIDLow());

	uint8 attacktype = Player::GetAttackBySlot(slot);

	if (proto->Socket[0].Color)                              //only (un)equipping of items with sockets can influence metagems, so no need to waste time with normal items
		CorrectMetaGemEnchants(slot, apply);

	if (attacktype < MAX_ATTACK)
		_ApplyWeaponDependentAuraMods(item, WeaponAttackType(attacktype), apply);

	_ApplyItemBonuses(proto, slot, apply);

	if (slot == EQUIPMENT_SLOT_RANGED)
		_ApplyAmmoBonuses();

	ApplyItemEquipSpell(item, apply);
	ApplyEnchantment(item, apply);

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "_ApplyItemMods complete.");
}

void Player::_ApplyItemBonuses(ItemTemplate const* proto, uint8 slot, bool apply, bool only_level_scale /*= false*/)
{
	if (slot >= INVENTORY_SLOT_BAG_END || !proto)
		return;

	ScalingStatDistributionEntry const* ssd = proto->ScalingStatDistribution ? sScalingStatDistributionStore.LookupEntry(proto->ScalingStatDistribution) : NULL;
	if (only_level_scale && !ssd)
		return;

	// req. check at equip, but allow use for extended range if range limit max level, set proper level
	uint32 ssd_level = getLevel();
	if (ssd && ssd_level > ssd->MaxLevel)
		ssd_level = ssd->MaxLevel;

	ScalingStatValuesEntry const* ssv = proto->ScalingStatValue ? sScalingStatValuesStore.LookupEntry(ssd_level) : NULL;
	if (only_level_scale && !ssv)
		return;

	for (uint8 i = 0; i < MAX_ITEM_PROTO_STATS; ++i)
	{
		uint32 statType = 0;
		int32  val = 0;
		// If set ScalingStatDistribution need get stats and values from it
		if (ssd && ssv)
		{
			if (ssd->StatMod[i] < 0)
				continue;
			statType = ssd->StatMod[i];
			val = (ssv->getssdMultiplier(proto->ScalingStatValue) * ssd->Modifier[i]) / 10000;
		}
		else
		{
			if (i >= proto->StatsCount)
				continue;
			statType = proto->ItemStat[i].ItemStatType;
			val = proto->ItemStat[i].ItemStatValue;
		}

		if (val == 0)
			continue;

		switch (statType)
		{
		case ITEM_MOD_MANA:
			HandleStatModifier(UNIT_MOD_MANA, BASE_VALUE, float(val), apply);
			break;
		case ITEM_MOD_HEALTH:                           // modify HP
			HandleStatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(val), apply);
			break;
		case ITEM_MOD_AGILITY:                          // modify agility
			HandleStatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, float(val), apply);
			ApplyStatBuffMod(STAT_AGILITY, float(val), apply);
			break;
		case ITEM_MOD_STRENGTH:                         //modify strength
			HandleStatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, float(val), apply);
			ApplyStatBuffMod(STAT_STRENGTH, float(val), apply);
			break;
		case ITEM_MOD_INTELLECT:                        //modify intellect
			HandleStatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(val), apply);
			ApplyStatBuffMod(STAT_INTELLECT, float(val), apply);
			break;
		case ITEM_MOD_SPIRIT:                           //modify spirit
			HandleStatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, float(val), apply);
			ApplyStatBuffMod(STAT_SPIRIT, float(val), apply);
			break;
		case ITEM_MOD_STAMINA:                          //modify stamina
			HandleStatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, float(val), apply);
			ApplyStatBuffMod(STAT_STAMINA, float(val), apply);
			break;
		case ITEM_MOD_DEFENSE_SKILL_RATING:
			ApplyRatingMod(CR_DEFENSE_SKILL, int32(val), apply);
			break;
		case ITEM_MOD_DODGE_RATING:
			ApplyRatingMod(CR_DODGE, int32(val), apply);
			break;
		case ITEM_MOD_PARRY_RATING:
			ApplyRatingMod(CR_PARRY, int32(val), apply);
			break;
		case ITEM_MOD_BLOCK_RATING:
			ApplyRatingMod(CR_BLOCK, int32(val), apply);
			break;
		case ITEM_MOD_HIT_MELEE_RATING:
			ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
			break;
		case ITEM_MOD_HIT_RANGED_RATING:
			ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
			break;
		case ITEM_MOD_HIT_SPELL_RATING:
			ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_MELEE_RATING:
			ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_RANGED_RATING:
			ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_SPELL_RATING:
			ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
			ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
			break;
		case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
			ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
			break;
		case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
			ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
			ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
			ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
			ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_HASTE_MELEE_RATING:
			ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
			break;
		case ITEM_MOD_HASTE_RANGED_RATING:
			ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
			break;
		case ITEM_MOD_HASTE_SPELL_RATING:
			ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_HIT_RATING:
			ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
			ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
			ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_RATING:
			ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
			ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
			ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_HIT_TAKEN_RATING:
			ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
			ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
			ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_CRIT_TAKEN_RATING:
			ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
			ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
			ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_RESILIENCE_RATING:
			ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
			ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
			ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_HASTE_RATING:
			ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
			ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
			ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
			break;
		case ITEM_MOD_EXPERTISE_RATING:
			ApplyRatingMod(CR_EXPERTISE, int32(val), apply);
			break;
		case ITEM_MOD_ATTACK_POWER:
			HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(val), apply);
			HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
			break;
		case ITEM_MOD_RANGED_ATTACK_POWER:
			HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
			break;
			//            case ITEM_MOD_FERAL_ATTACK_POWER:
			//                ApplyFeralAPBonus(int32(val), apply);
			//                break;
		case ITEM_MOD_MANA_REGENERATION:
			ApplyManaRegenBonus(int32(val), apply);
			break;
		case ITEM_MOD_ARMOR_PENETRATION_RATING:
			ApplyRatingMod(CR_ARMOR_PENETRATION, int32(val), apply);
			break;
		case ITEM_MOD_SPELL_POWER:
			ApplySpellPowerBonus(int32(val), apply);
			break;
		case ITEM_MOD_HEALTH_REGEN:
			ApplyHealthRegenBonus(int32(val), apply);
			break;
		case ITEM_MOD_SPELL_PENETRATION:
			ApplySpellPenetrationBonus(val, apply);
			break;
		case ITEM_MOD_BLOCK_VALUE:
			HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(val), apply);
			break;
			// deprecated item mods
		case ITEM_MOD_SPELL_HEALING_DONE:
		case ITEM_MOD_SPELL_DAMAGE_DONE:
			break;
		}
	}

	// Apply Spell Power from ScalingStatValue if set
	if (ssv)
		if (int32 spellbonus = ssv->getSpellBonus(proto->ScalingStatValue))
			ApplySpellPowerBonus(spellbonus, apply);

	// If set ScalingStatValue armor get it or use item armor
	uint32 armor = proto->Armor;
	if (ssv)
	{
		if (uint32 ssvarmor = ssv->getArmorMod(proto->ScalingStatValue))
			armor = ssvarmor;
	}
	else if (armor && proto->ArmorDamageModifier)
		armor -= uint32(proto->ArmorDamageModifier);

	if (armor)
	{
		UnitModifierType modType = TOTAL_VALUE;
		if (proto->Class == ITEM_CLASS_ARMOR)
		{
			switch (proto->SubClass)
			{
			case ITEM_SUBCLASS_ARMOR_CLOTH:
			case ITEM_SUBCLASS_ARMOR_LEATHER:
			case ITEM_SUBCLASS_ARMOR_MAIL:
			case ITEM_SUBCLASS_ARMOR_PLATE:
			case ITEM_SUBCLASS_ARMOR_SHIELD:
				modType = BASE_VALUE;
				break;
			}
		}
		HandleStatModifier(UNIT_MOD_ARMOR, modType, float(armor), apply);
	}

	// Add armor bonus from ArmorDamageModifier if > 0
	if (proto->ArmorDamageModifier > 0)
		HandleStatModifier(UNIT_MOD_ARMOR, TOTAL_VALUE, float(proto->ArmorDamageModifier), apply);

	if (proto->Block)
		HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(proto->Block), apply);

	if (proto->HolyRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_HOLY, BASE_VALUE, float(proto->HolyRes), apply);

	if (proto->FireRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_FIRE, BASE_VALUE, float(proto->FireRes), apply);

	if (proto->NatureRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, float(proto->NatureRes), apply);

	if (proto->FrostRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_FROST, BASE_VALUE, float(proto->FrostRes), apply);

	if (proto->ShadowRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, float(proto->ShadowRes), apply);

	if (proto->ArcaneRes)
		HandleStatModifier(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, float(proto->ArcaneRes), apply);

	WeaponAttackType attType = BASE_ATTACK;

	if (slot == EQUIPMENT_SLOT_RANGED && (
		proto->InventoryType == INVTYPE_RANGED || proto->InventoryType == INVTYPE_THROWN ||
		proto->InventoryType == INVTYPE_RANGEDRIGHT))
	{
		attType = RANGED_ATTACK;
	}
	else if (slot == EQUIPMENT_SLOT_OFFHAND)
	{
		attType = OFF_ATTACK;
	}

	if (CanUseAttackType(attType))
		_ApplyWeaponDamage(slot, proto, ssv, apply);


	// Druids get feral AP bonus from weapon dps (also use DPS from ScalingStatValue)
	if (getClass() == CLASS_DRUID)
	{
		int32 dpsMod = 0;
		int32 feral_bonus = 0;
		if (ssv)
		{
			dpsMod = ssv->getDPSMod(proto->ScalingStatValue);
			feral_bonus += ssv->getFeralBonus(proto->ScalingStatValue);
		}

		feral_bonus += proto->getFeralBonus(dpsMod);
		if (feral_bonus)
			ApplyFeralAPBonus(feral_bonus, apply);
	}
}

void Player::_ApplyWeaponDamage(uint8 slot, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv, bool apply)
{
	WeaponAttackType attType = BASE_ATTACK;
	float damage = 0.0f;

	if (slot == EQUIPMENT_SLOT_RANGED && (
		proto->InventoryType == INVTYPE_RANGED || proto->InventoryType == INVTYPE_THROWN ||
		proto->InventoryType == INVTYPE_RANGEDRIGHT))
	{
		attType = RANGED_ATTACK;
	}
	else if (slot == EQUIPMENT_SLOT_OFFHAND)
	{
		attType = OFF_ATTACK;
	}

	float minDamage = proto->Damage[0].DamageMin;
	float maxDamage = proto->Damage[0].DamageMax;

	// If set dpsMod in ScalingStatValue use it for min (70% from average), max (130% from average) damage
	if (ssv)
	{
		int32 extraDPS = ssv->getDPSMod(proto->ScalingStatValue);
		if (extraDPS)
		{
			float average = extraDPS * proto->Delay / 1000.0f;
			minDamage = 0.7f * average;
			maxDamage = 1.3f * average;
		}
	}

	if (minDamage > 0)
	{
		damage = apply ? minDamage : BASE_MINDAMAGE;
		SetBaseWeaponDamage(attType, MINDAMAGE, damage);
	}

	if (maxDamage > 0)
	{
		damage = apply ? maxDamage : BASE_MAXDAMAGE;
		SetBaseWeaponDamage(attType, MAXDAMAGE, damage);
	}

	if (proto->Delay && !IsInFeralForm())
	{
		if (slot == EQUIPMENT_SLOT_RANGED)
			SetAttackTime(RANGED_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
		else if (slot == EQUIPMENT_SLOT_MAINHAND)
			SetAttackTime(BASE_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
		else if (slot == EQUIPMENT_SLOT_OFFHAND)
			SetAttackTime(OFF_ATTACK, apply ? proto->Delay : BASE_ATTACK_TIME);
	}

	// No need to modify any physical damage for ferals as it is calculated from stats only
	if (IsInFeralForm())
		return;

	if (CanModifyStats() && (damage || proto->Delay))
		UpdateDamagePhysical(attType);
}

void Player::_ApplyWeaponDependentAuraMods(Item* item, WeaponAttackType attackType, bool apply)
{
	AuraEffectList const& auraCritList = GetAuraEffectsByType(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
	for (AuraEffectList::const_iterator itr = auraCritList.begin(); itr != auraCritList.end(); ++itr)
		_ApplyWeaponDependentAuraCritMod(item, attackType, *itr, apply);

	AuraEffectList const& auraDamageFlatList = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE);
	for (AuraEffectList::const_iterator itr = auraDamageFlatList.begin(); itr != auraDamageFlatList.end(); ++itr)
		_ApplyWeaponDependentAuraDamageMod(item, attackType, *itr, apply);

	AuraEffectList const& auraDamagePctList = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
	for (AuraEffectList::const_iterator itr = auraDamagePctList.begin(); itr != auraDamagePctList.end(); ++itr)
		_ApplyWeaponDependentAuraDamageMod(item, attackType, *itr, apply);
}

void Player::_ApplyWeaponDependentAuraCritMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
	// don't apply mod if item is broken or cannot be used
	if (item->IsBroken() || !CanUseAttackType(attackType))
		return;

	// generic not weapon specific case processes in aura code
	if (aura->GetSpellInfo()->EquippedItemClass == -1)
		return;

	BaseModGroup mod = BASEMOD_END;
	switch (attackType)
	{
	case BASE_ATTACK:   mod = CRIT_PERCENTAGE;        break;
	case OFF_ATTACK:    mod = OFFHAND_CRIT_PERCENTAGE; break;
	case RANGED_ATTACK: mod = RANGED_CRIT_PERCENTAGE; break;
	default: return;
	}

	if (item->IsFitToSpellRequirements(aura->GetSpellInfo()))
		HandleBaseModValue(mod, FLAT_MOD, float(aura->GetAmount()), apply);
}

void Player::_ApplyWeaponDependentAuraDamageMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
	// don't apply mod if item is broken or cannot be used
	if (item->IsBroken() || !CanUseAttackType(attackType))
		return;

	// ignore spell mods for not wands
	if ((aura->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL) == 0 && (getClassMask() & CLASSMASK_WAND_USERS) == 0)
		return;

	// generic not weapon specific case processes in aura code
	if (aura->GetSpellInfo()->EquippedItemClass == -1)
		return;

	UnitMods unitMod = UNIT_MOD_END;
	switch (attackType)
	{
	case BASE_ATTACK:   unitMod = UNIT_MOD_DAMAGE_MAINHAND; break;
	case OFF_ATTACK:    unitMod = UNIT_MOD_DAMAGE_OFFHAND;  break;
	case RANGED_ATTACK: unitMod = UNIT_MOD_DAMAGE_RANGED;   break;
	default: return;
	}

	UnitModifierType unitModType = TOTAL_VALUE;
	switch (aura->GetAuraType())
	{
	case SPELL_AURA_MOD_DAMAGE_DONE:         unitModType = TOTAL_VALUE; break;
	case SPELL_AURA_MOD_DAMAGE_PERCENT_DONE: unitModType = TOTAL_PCT;   break;
	default: return;
	}

	if (item->IsFitToSpellRequirements(aura->GetSpellInfo()))
	{
		HandleStatModifier(unitMod, unitModType, float(aura->GetAmount()), apply);
		if (unitModType == TOTAL_VALUE)
		{
			if (aura->GetAmount() > 0)
				ApplyModUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS, aura->GetAmount(), apply);
			else
				ApplyModUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG, aura->GetAmount(), apply);
		}
	}
}

void Player::ApplyItemEquipSpell(Item* item, bool apply, bool form_change)
{
	if (!item)
		return;

	ItemTemplate const* proto = item->GetTemplate();
	if (!proto)
		return;

	for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
	{
		_Spell const& spellData = proto->Spells[i];

		// no spell
		if (!spellData.SpellId)
			continue;

		// wrong triggering type
		if (apply && spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_EQUIP)
			continue;

		// check if it is valid spell
		SpellInfo const* spellproto = sSpellMgr->GetSpellInfo(spellData.SpellId);
		if (!spellproto)
			continue;

		ApplyEquipSpell(spellproto, item, apply, form_change);
	}
}

void Player::ApplyEquipSpell(SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
	if (apply)
	{
		// Cannot be used in this stance/form
		if (spellInfo->CheckShapeshift(GetShapeshiftForm()) != SPELL_CAST_OK)
			return;

		if (form_change)                                    // check aura active state from other form
		{
			AuraApplicationMapBounds range = GetAppliedAuras().equal_range(spellInfo->Id);
			for (AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
				if (!item || itr->second->GetBase()->GetCastItemGUID() == item->GetGUID())
					return;
		}

		;//sLog->outStaticDebug("WORLD: cast %s Equip spellId - %i", (item ? "item" : "itemset"), spellInfo->Id);

		CastSpell(this, spellInfo, true, item);
	}
	else
	{
		if (form_change)                                     // check aura compatibility
		{
			// Cannot be used in this stance/form
			if (spellInfo->CheckShapeshift(GetShapeshiftForm()) == SPELL_CAST_OK)
				return;                                     // and remove only not compatible at form change
		}

		if (item)
			RemoveAurasDueToItemSpell(spellInfo->Id, item->GetGUID());  // un-apply all spells, not only at-equipped
		else
			RemoveAurasDueToSpell(spellInfo->Id);           // un-apply spell (item set case)

		// Xinef: Remove Proc Spells and Summons
		for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
		{
			// Xinef: Remove procs
			if (spellInfo->Effects[i].TriggerSpell)
				RemoveAurasDueToSpell(spellInfo->Effects[i].TriggerSpell);

			// Xinef: remove minions summoned by item
			if (spellInfo->Effects[i].Effect == SPELL_EFFECT_SUMMON)
				RemoveAllMinionsByEntry(spellInfo->Effects[i].MiscValue);
		}
	}
}

void Player::UpdateEquipSpellsAtFormChange()
{
	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i] && !m_items[i]->IsBroken() && CanUseAttackType(GetAttackBySlot(i)))
		{
			ApplyItemEquipSpell(m_items[i], false, true);     // remove spells that not fit to form
			ApplyItemEquipSpell(m_items[i], true, true);      // add spells that fit form but not active
		}
	}

	// item set bonuses not dependent from item broken state
	for (size_t setindex = 0; setindex < ItemSetEff.size(); ++setindex)
	{
		ItemSetEffect* eff = ItemSetEff[setindex];
		if (!eff)
			continue;

		for (uint32 y = 0; y < MAX_ITEM_SET_SPELLS; ++y)
		{
			SpellInfo const* spellInfo = eff->spells[y];
			if (!spellInfo)
				continue;

			ApplyEquipSpell(spellInfo, NULL, false, true);       // remove spells that not fit to form
			ApplyEquipSpell(spellInfo, NULL, true, true);        // add spells that fit form but not active
		}
	}
}
void Player::CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx)
{
	if (!target || !target->IsAlive() || target == this)
		return;

	// Xinef: do not use disarmed weapons, special exception - shaman ghost wolf form
	// Xinef: normal forms proc on hit enchants / built in item bonuses
	if (!CanUseAttackType(attType) || GetShapeshiftForm() == FORM_GHOSTWOLF)
		return;

	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		// If usable, try to cast item spell
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (!item->IsBroken())
				if (ItemTemplate const* proto = item->GetTemplate())
				{
					// Additional check for weapons
					if (proto->Class == ITEM_CLASS_WEAPON)
					{
						// offhand item cannot proc from main hand hit etc
						EquipmentSlots slot;
						switch (attType)
						{
						case BASE_ATTACK:   slot = EQUIPMENT_SLOT_MAINHAND; break;
						case OFF_ATTACK:    slot = EQUIPMENT_SLOT_OFFHAND;  break;
						case RANGED_ATTACK: slot = EQUIPMENT_SLOT_RANGED;   break;
						default: slot = EQUIPMENT_SLOT_END; break;
						}
						if (slot != i)
							continue;
					}

					CastItemCombatSpell(target, attType, procVictim, procEx, item, proto);
				}
	}
}

void Player::CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
	// Can do effect if any damage done to target
	if (procVictim & PROC_FLAG_TAKEN_DAMAGE)
		//if (damageInfo->procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE)
	{
		for (uint8 i = 0; i < MAX_ITEM_SPELLS; ++i)
		{
			_Spell const& spellData = proto->Spells[i];

			// no spell
			if (!spellData.SpellId)
				continue;

			// wrong triggering type
			if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_CHANCE_ON_HIT)
				continue;

			SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
			if (!spellInfo)
			{
				sLog->outError("WORLD: unknown Item spellid %i", spellData.SpellId);
				continue;
			}

			// not allow proc extra attack spell at extra attack
			if (m_extraAttacks && spellInfo->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS))
				return;

			float chance = (float)spellInfo->ProcChance;

			if (spellData.SpellPPMRate)
			{

				uint32 WeaponSpeed = GetAttackTime(attType);
				chance = GetPPMProcChance(WeaponSpeed, spellData.SpellPPMRate, spellInfo);
			}
			else if (chance > 100.0f)
			{
				chance = GetWeaponProcChance();
			}

			if (roll_chance_f(chance))
				CastSpell(target, spellInfo->Id, TriggerCastFlags(TRIGGERED_FULL_MASK&~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD), item);
		}
	}

	// item combat enchantments
	for (uint8 e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
	{
		uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
		SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
		if (!pEnchant)
			continue;

		for (uint8 s = 0; s < MAX_ITEM_ENCHANTMENT_EFFECTS; ++s)
		{
			if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
				continue;

			SpellEnchantProcEntry const* entry = sSpellMgr->GetSpellEnchantProcEvent(enchant_id);

			if (entry && entry->procEx)
			{
				// Check hit/crit/dodge/parry requirement
				if ((entry->procEx & procEx) == 0)
					continue;
			}
			else
			{
				// Can do effect if any damage done to target
				if (!(procVictim & PROC_FLAG_TAKEN_DAMAGE))
					//if (!(damageInfo->procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE))
					continue;
			}

			SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(pEnchant->spellid[s]);
			if (!spellInfo)
			{
				sLog->outError("Player::CastItemCombatSpell(GUID: %u, name: %s, enchant: %i): unknown spell %i is casted, ignoring...",
					GetGUIDLow(), GetName().c_str(), pEnchant->ID, pEnchant->spellid[s]);
				continue;
			}

			float chance = pEnchant->amount[s] != 0 ? float(pEnchant->amount[s]) : GetWeaponProcChance();

			if (entry)
			{
				if (entry->PPMChance)
					chance = GetPPMProcChance(proto->Delay, entry->PPMChance, spellInfo);
				else if (entry->customChance)
					chance = (float)entry->customChance;
			}

			// Apply spell mods
			ApplySpellMod(pEnchant->spellid[s], SPELLMOD_CHANCE_OF_SUCCESS, chance);

			// Shiv has 100% chance to apply the poison
			if (FindCurrentSpellBySpellId(5938) && e_slot == TEMP_ENCHANTMENT_SLOT)
				chance = 100.0f;

			if (roll_chance_f(chance))
			{
				// Xinef: implement enchant charges
				if (uint32 charges = item->GetEnchantmentCharges(EnchantmentSlot(e_slot)))
				{
					if (!--charges)
					{
						ApplyEnchantment(item, EnchantmentSlot(e_slot), false);
						item->ClearEnchantment(EnchantmentSlot(e_slot));
					}
					else
						item->SetEnchantmentCharges(EnchantmentSlot(e_slot), charges);
				}

				if (spellInfo->IsPositive())
					CastSpell(this, spellInfo, TriggerCastFlags(TRIGGERED_FULL_MASK&~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD), item);
				else
					CastSpell(target, spellInfo, TriggerCastFlags(TRIGGERED_FULL_MASK&~TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD), item);
			}
		}
	}
}

void Player::CastItemUseSpell(Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
	ItemTemplate const* proto = item->GetTemplate();
	// special learning case
	if (proto->Spells[0].SpellId == 483 || proto->Spells[0].SpellId == 55884)
	{
		uint32 learn_spell_id = proto->Spells[0].SpellId;
		uint32 learning_spell_id = proto->Spells[1].SpellId;

		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(learn_spell_id);
		if (!spellInfo)
		{
			sLog->outError("Player::CastItemUseSpell: Item (Entry: %u) in have wrong spell id %u, ignoring ", proto->ItemId, learn_spell_id);
			SendEquipError(EQUIP_ERR_NONE, item, NULL);
			return;
		}

		Spell* spell = new Spell(this, spellInfo, TRIGGERED_NONE);
		spell->m_CastItem = item;
		spell->m_cast_count = cast_count;                   //set count of casts
		spell->SetSpellValue(SPELLVALUE_BASE_POINT0, learning_spell_id);
		spell->prepare(&targets);
		return;
	}

	// use triggered flag only for items with many spell casts and for not first cast
	uint8 count = 0;

	std::list<Spell*> pushSpells;
	// item spells casted at use
	for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
	{
		_Spell const& spellData = proto->Spells[i];

		// no spell
		if (!spellData.SpellId)
			continue;

		// wrong triggering type
		if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
			continue;

		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
		if (!spellInfo)
		{
			sLog->outError("Player::CastItemUseSpell: Item (Entry: %u) in have wrong spell id %u, ignoring", proto->ItemId, spellData.SpellId);
			continue;
		}

		if (HasSpellCooldown(spellInfo->Id))
			continue;

		Spell* spell = new Spell(this, spellInfo, (count > 0) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
		spell->m_CastItem = item;
		spell->m_cast_count = cast_count;                   // set count of casts
		spell->m_glyphIndex = glyphIndex;                   // glyph index
		spell->InitExplicitTargets(targets);

		// Xinef: dont allow to cast such spells, it may happen that spell possess 2 spells, one for players and one for items / gameobjects
		// Xinef: if first one is cast on player, it may be deleted thus resulting in crash because second spell has saved pointer to the item
		// Xinef: there is one problem with scripts which wont be loaded at the moment of call
		SpellCastResult result = spell->CheckCast(true);
		if (result != SPELL_CAST_OK)
		{
			spell->SendCastResult(result);
			delete spell;
			continue;
		}

		pushSpells.push_back(spell);
		//spell->prepare(&targets);

		++count;
	}

	// Item enchantments spells casted at use
	for (uint8 e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
	{
		uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
		SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
		if (!pEnchant)
			continue;
		for (uint8 s = 0; s < MAX_ITEM_ENCHANTMENT_EFFECTS; ++s)
		{
			if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_USE_SPELL)
				continue;

			SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(pEnchant->spellid[s]);
			if (!spellInfo)
			{
				sLog->outError("Player::CastItemUseSpell Enchant %i, cast unknown spell %i", pEnchant->ID, pEnchant->spellid[s]);
				continue;
			}

			if (HasSpellCooldown(spellInfo->Id))
				continue;

			Spell* spell = new Spell(this, spellInfo, (count > 0) ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
			spell->m_CastItem = item;
			spell->m_cast_count = cast_count;               // set count of casts
			spell->m_glyphIndex = glyphIndex;               // glyph index
			spell->InitExplicitTargets(targets);

			// Xinef: dont allow to cast such spells, it may happen that spell possess 2 spells, one for players and one for items / gameobjects
			// Xinef: if first one is cast on player, it may be deleted thus resulting in crash because second spell has saved pointer to the item
			// Xinef: there is one problem with scripts which wont be loaded at the moment of call
			SpellCastResult result = spell->CheckCast(true);
			if (result != SPELL_CAST_OK)
			{
				spell->SendCastResult(result);
				delete spell;
				continue;
			}

			pushSpells.push_back(spell);
			//spell->prepare(&targets);

			++count;
		}
	}

	// xinef: send all spells in one go, prevents crash because container is not set
	for (std::list<Spell*>::const_iterator itr = pushSpells.begin(); itr != pushSpells.end(); ++itr)
		(*itr)->prepare(&targets);
}

void Player::_RemoveAllItemMods()
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "_RemoveAllItemMods start.");

	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			ItemTemplate const* proto = m_items[i]->GetTemplate();
			if (!proto)
				continue;

			// item set bonuses not dependent from item broken state
			if (proto->ItemSet)
				RemoveItemsSetItem(this, proto);

			if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
				continue;

			ApplyItemEquipSpell(m_items[i], false);
			ApplyEnchantment(m_items[i], false);
		}
	}

	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
				continue;
			ItemTemplate const* proto = m_items[i]->GetTemplate();
			if (!proto)
				continue;

			uint32 attacktype = Player::GetAttackBySlot(i);
			if (attacktype < MAX_ATTACK)
				_ApplyWeaponDependentAuraMods(m_items[i], WeaponAttackType(attacktype), false);

			_ApplyItemBonuses(proto, i, false);

			if (i == EQUIPMENT_SLOT_RANGED)
				_ApplyAmmoBonuses();
		}
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "_RemoveAllItemMods complete.");
}

void Player::_ApplyAllItemMods()
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "_ApplyAllItemMods start.");

	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
				continue;

			ItemTemplate const* proto = m_items[i]->GetTemplate();
			if (!proto)
				continue;

			uint32 attacktype = Player::GetAttackBySlot(i);
			if (attacktype < MAX_ATTACK)
				_ApplyWeaponDependentAuraMods(m_items[i], WeaponAttackType(attacktype), true);

			_ApplyItemBonuses(proto, i, true);

			if (i == EQUIPMENT_SLOT_RANGED)
				_ApplyAmmoBonuses();
		}
	}

	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			ItemTemplate const* proto = m_items[i]->GetTemplate();
			if (!proto)
				continue;

			// item set bonuses not dependent from item broken state
			if (proto->ItemSet)
				AddItemsSetItem(this, m_items[i]);

			if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
				continue;

			ApplyItemEquipSpell(m_items[i], true);
			ApplyEnchantment(m_items[i], true);
		}
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "_ApplyAllItemMods complete.");
}

void Player::_ApplyAllLevelScaleItemMods(bool apply)
{
	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			if (m_items[i]->IsBroken() || !CanUseAttackType(GetAttackBySlot(i)))
				continue;

			ItemTemplate const* proto = m_items[i]->GetTemplate();
			if (!proto)
				continue;

			_ApplyItemBonuses(proto, i, apply, true);
		}
	}
}

void Player::_ApplyAmmoBonuses()
{
	// check ammo
	uint32 ammo_id = GetUInt32Value(PLAYER_AMMO_ID);
	if (!ammo_id)
		return;

	float currentAmmoDPS;

	ItemTemplate const* ammo_proto = sObjectMgr->GetItemTemplate(ammo_id);
	if (!ammo_proto || ammo_proto->Class != ITEM_CLASS_PROJECTILE || !CheckAmmoCompatibility(ammo_proto))
		currentAmmoDPS = 0.0f;
	else
		currentAmmoDPS = (ammo_proto->Damage[0].DamageMin + ammo_proto->Damage[0].DamageMax) / 2;

	if (currentAmmoDPS == GetAmmoDPS())
		return;

	m_ammoDPS = currentAmmoDPS;

	if (CanModifyStats())
		UpdateDamagePhysical(RANGED_ATTACK);
}

bool Player::CheckAmmoCompatibility(const ItemTemplate* ammo_proto) const
{
	if (!ammo_proto)
		return false;

	// check ranged weapon
	Item* weapon = GetWeaponForAttack(RANGED_ATTACK);
	if (!weapon || weapon->IsBroken())
		return false;

	ItemTemplate const* weapon_proto = weapon->GetTemplate();
	if (!weapon_proto || weapon_proto->Class != ITEM_CLASS_WEAPON)
		return false;

	// check ammo ws. weapon compatibility
	switch (weapon_proto->SubClass)
	{
	case ITEM_SUBCLASS_WEAPON_BOW:
	case ITEM_SUBCLASS_WEAPON_CROSSBOW:
		if (ammo_proto->SubClass != ITEM_SUBCLASS_ARROW)
			return false;
		break;
	case ITEM_SUBCLASS_WEAPON_GUN:
		if (ammo_proto->SubClass != ITEM_SUBCLASS_BULLET)
			return false;
		break;
	default:
		return false;
	}

	return true;
}

/*  If in a battleground a player dies, and an enemy removes the insignia, the player's bones is lootable
	Called by remove insignia spell effect    */
void Player::RemovedInsignia(Player* looterPlr)
{
	// Xinef: If player is not in battleground and not in wintergrasp
	if (!GetBattlegroundId() && GetZoneId() != AREA_WINTERGRASP)
		return;

	// If not released spirit, do it !
	if (m_deathTimer > 0)
	{
		m_deathTimer = 0;
		BuildPlayerRepop();
		RepopAtGraveyard();
	}

	// We have to convert player corpse to bones, not to be able to resurrect there
	// SpawnCorpseBones isn't handy, 'cos it saves player while he in BG
	Corpse* bones = sObjectAccessor->ConvertCorpseForPlayer(GetGUID(), true);
	if (!bones)
		return;

	// Now we must make bones lootable, and send player loot
	bones->SetFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE);

	// We store the level of our player in the gold field
	// We retrieve this information at Player::SendLoot()
	bones->loot.gold = getLevel();
	bones->lootRecipient = looterPlr;
	looterPlr->SendLoot(bones->GetGUID(), LOOT_INSIGNIA);
}

void Player::SendLootRelease(uint64 guid)
{
	WorldPacket data(SMSG_LOOT_RELEASE_RESPONSE, (8 + 1));
	data << uint64(guid) << uint8(1);
	SendDirectMessage(&data);
}

void Player::SendLoot(uint64 guid, LootType loot_type)
{
	if (uint64 lguid = GetLootGUID())
		m_session->DoLootRelease(lguid);

	Loot* loot = 0;
	PermissionTypes permission = ALL_PERMISSION;

	;//sLog->outDebug(LOG_FILTER_LOOT, "Player::SendLoot");
	if (IS_GAMEOBJECT_GUID(guid))
	{
		;//sLog->outDebug(LOG_FILTER_LOOT, "IS_GAMEOBJECT_GUID(guid)");
		GameObject* go = GetMap()->GetGameObject(guid);

		// not check distance for GO in case owned GO (fishing bobber case, for example)
		// And permit out of range GO with no owner in case fishing hole
		if (!go || (loot_type != LOOT_FISHINGHOLE && ((loot_type != LOOT_FISHING && loot_type != LOOT_FISHING_JUNK) || go->GetOwnerGUID() != GetGUID()) && !go->IsWithinDistInMap(this, INTERACTION_DISTANCE)) || (loot_type == LOOT_CORPSE && go->GetRespawnTime() && go->isSpawnedByDefault()))
		{
			go->ForceValuesUpdateAtIndex(GAMEOBJECT_BYTES_1);
			SendLootRelease(guid);
			return;
		}

		loot = &go->loot;

		// Xinef: loot was generated and respawntime has passed since then, allow to recreate loot
		// Xinef: to avoid bugs, this rule covers spawned gameobjects only
		if (go->isSpawnedByDefault() && go->getLootState() == GO_ACTIVATED && !go->loot.isLooted() && go->GetLootGenerationTime() + go->GetRespawnDelay() < time(NULL))
			go->SetLootState(GO_READY);

		if (go->getLootState() == GO_READY)
		{
			uint32 lootid = go->GetGOInfo()->GetLootId();

			//TODO: fix this big hack
			if ((go->GetEntry() == BG_AV_OBJECTID_MINE_N || go->GetEntry() == BG_AV_OBJECTID_MINE_S))
				if (Battleground* bg = GetBattleground())
					if (bg->GetBgTypeID() == BATTLEGROUND_AV)
						if (!bg->ToBattlegroundAV()->PlayerCanDoMineQuest(go->GetEntry(), GetTeamId()))
						{
							go->ForceValuesUpdateAtIndex(GAMEOBJECT_BYTES_1);
							SendLootRelease(guid);
							return;
						}

			if (lootid)
			{
				loot->clear();

				Group* group = GetGroup();
				bool groupRules = (group && go->GetGOInfo()->type == GAMEOBJECT_TYPE_CHEST && go->GetGOInfo()->chest.groupLootRules);

				// check current RR player and get next if necessary
				if (groupRules)
					group->UpdateLooterGuid(go, true);

				loot->FillLoot(lootid, LootTemplates_Gameobject, this, !groupRules, false, go->GetLootMode());
				go->SetLootGenerationTime();

				// get next RR player (for next loot)
				if (groupRules && !go->loot.empty())
					group->UpdateLooterGuid(go);
			}

			if (loot_type == LOOT_FISHING)
				go->getFishLoot(loot, this);
			else if (loot_type == LOOT_FISHING_JUNK)
				go->getFishLootJunk(loot, this);

			if (go->GetGOInfo()->type == GAMEOBJECT_TYPE_CHEST && go->GetGOInfo()->chest.groupLootRules)
			{
				if (Group* group = GetGroup())
				{
					switch (group->GetLootMethod())
					{
					case GROUP_LOOT:
						// GroupLoot: rolls items over threshold. Items with quality < threshold, round robin
						group->GroupLoot(loot, go);
						break;
					case NEED_BEFORE_GREED:
						group->NeedBeforeGreed(loot, go);
						break;
					case MASTER_LOOT:
						group->MasterLoot(loot, go);
						break;
					default:
						break;
					}
				}
			}

			go->SetLootState(GO_ACTIVATED, this);
		}

		if (go->getLootState() == GO_ACTIVATED)
		{
			if (Group* group = GetGroup())
			{
				switch (group->GetLootMethod())
				{
				case MASTER_LOOT:
					permission = group->GetMasterLooterGuid() == GetGUID() ? MASTER_PERMISSION : RESTRICTED_PERMISSION;
					break;
				case FREE_FOR_ALL:
					permission = ALL_PERMISSION;
					break;
				case ROUND_ROBIN:
					permission = ROUND_ROBIN_PERMISSION;
					break;
				default:
					permission = GROUP_PERMISSION;
					break;
				}
			}
			else
				permission = ALL_PERMISSION;
		}
	}
	else if (IS_ITEM_GUID(guid))
	{
		Item* item = GetItemByGuid(guid);

		if (!item)
		{
			SendLootRelease(guid);
			return;
		}

		permission = OWNER_PERMISSION;

		loot = &item->loot;

		// Xinef: Store container id
		loot->containerId = item->GetGUIDLow();

		if (!item->m_lootGenerated && !sLootItemStorage->LoadStoredLoot(item))
		{
			item->m_lootGenerated = true;
			loot->clear();

			switch (loot_type)
			{
			case LOOT_DISENCHANTING:
				loot->FillLoot(item->GetTemplate()->DisenchantID, LootTemplates_Disenchant, this, true);
				break;
			case LOOT_PROSPECTING:
				loot->FillLoot(item->GetEntry(), LootTemplates_Prospecting, this, true);
				break;
			case LOOT_MILLING:
				loot->FillLoot(item->GetEntry(), LootTemplates_Milling, this, true);
				break;
			default:
				loot->generateMoneyLoot(item->GetTemplate()->MinMoneyLoot, item->GetTemplate()->MaxMoneyLoot);
				loot->FillLoot(item->GetEntry(), LootTemplates_Item, this, true, loot->gold != 0);

				// Xinef: Add to storage
				if (loot->gold > 0 || loot->unlootedCount > 0)
					sLootItemStorage->AddNewStoredLoot(loot, this);

				break;
			}
		}
	}
	else if (IS_CORPSE_GUID(guid))                          // remove insignia
	{
		Corpse* bones = ObjectAccessor::GetCorpse(*this, guid);

		if (!bones || !(loot_type == LOOT_CORPSE || loot_type == LOOT_INSIGNIA) || bones->GetType() != CORPSE_BONES || !bones->HasFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE))
		{
			SendLootRelease(guid);
			return;
		}

		loot = &bones->loot;

		if (loot->loot_type == LOOT_NONE)
		{
			uint32 pLevel = bones->loot.gold;
			bones->loot.clear();

			// Xinef: For AV Achievement
			if (Battleground* bg = GetBattleground())
			{
				if (bg->GetBgTypeID() == BATTLEGROUND_AV)
					loot->FillLoot(1, LootTemplates_Creature, this, true);
			}
			// Xinef: For wintergrasp Quests
			else if (GetZoneId() == AREA_WINTERGRASP)
				loot->FillLoot(1, LootTemplates_Creature, this, true);

			// It may need a better formula
			// Now it works like this: lvl10: ~6copper, lvl70: ~9silver
			bones->loot.gold = uint32(urand(50, 150) * 0.016f * pow(float(pLevel) / 5.76f, 2.5f) * sWorld->getRate(RATE_DROP_MONEY));
		}

		if (bones->lootRecipient != this)
			permission = NONE_PERMISSION;
		else
			permission = OWNER_PERMISSION;
	}
	else
	{
		Creature* creature = GetMap()->GetCreature(guid);

		// must be in range and creature must be alive for pickpocket and must be dead for another loot
		if (!creature || creature->IsAlive() != (loot_type == LOOT_PICKPOCKETING) || !creature->IsWithinDistInMap(this, INTERACTION_DISTANCE))
		{
			SendLootRelease(guid);
			return;
		}

		if (loot_type == LOOT_PICKPOCKETING && IsFriendlyTo(creature))
		{
			SendLootRelease(guid);
			return;
		}

		loot = &creature->loot;

		if (loot_type == LOOT_PICKPOCKETING)
		{
			if (loot->loot_type != LOOT_PICKPOCKETING)
			{
				if (creature->CanGeneratePickPocketLoot())
				{
					creature->SetPickPocketLootTime();
					loot->clear();

					if (uint32 lootid = creature->GetCreatureTemplate()->pickpocketLootId)
						loot->FillLoot(lootid, LootTemplates_Pickpocketing, this, true);

					// Generate extra money for pick pocket loot
					const uint32 a = urand(0, creature->getLevel() / 2);
					const uint32 b = urand(0, getLevel() / 2);
					loot->gold = uint32(10 * (a + b) * sWorld->getRate(RATE_DROP_MONEY));
					permission = OWNER_PERMISSION;
				}
				else
				{
					permission = NONE_PERMISSION;
					SendLootError(guid, LOOT_ERROR_ALREADY_PICKPOCKETED);
					return;
				}
			}
		}
		else
		{
			// Xinef: Exploit fix
			if (!creature->HasFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE))
			{
				SendLootError(guid, LOOT_ERROR_DIDNT_KILL);
				return;
			}

			// the player whose group may loot the corpse
			Player* recipient = creature->GetLootRecipient();
			Group* recipientGroup = creature->GetLootRecipientGroup();
			if (!recipient && !recipientGroup)
				return;

			if (loot->loot_type == LOOT_NONE)
			{
				// for creature, loot is filled when creature is killed.
				if (recipientGroup)
				{
					switch (recipientGroup->GetLootMethod())
					{
					case GROUP_LOOT:
						// GroupLoot: rolls items over threshold. Items with quality < threshold, round robin
						recipientGroup->GroupLoot(loot, creature);
						break;
					case NEED_BEFORE_GREED:
						recipientGroup->NeedBeforeGreed(loot, creature);
						break;
					case MASTER_LOOT:
						recipientGroup->MasterLoot(loot, creature);
						break;
					default:
						break;
					}
				}
			}

			// if loot is already skinning loot then don't do anything else
			if (loot->loot_type == LOOT_SKINNING)
			{
				loot_type = LOOT_SKINNING;
				permission = creature->GetLootRecipientGUID() == GetGUID() ? OWNER_PERMISSION : NONE_PERMISSION;
			}
			else if (loot_type == LOOT_SKINNING)
			{
				loot->clear();
				loot->FillLoot(creature->GetCreatureTemplate()->SkinLootId, LootTemplates_Skinning, this, true);
				permission = OWNER_PERMISSION;

				// Xinef: Set new loot recipient
				creature->SetLootRecipient(this, false);
			}
			// set group rights only for loot_type != LOOT_SKINNING
			else
			{
				if (recipientGroup)
				{
					if (GetGroup() == recipientGroup)
					{
						switch (recipientGroup->GetLootMethod())
						{
						case MASTER_LOOT:
							permission = recipientGroup->GetMasterLooterGuid() == GetGUID() ? MASTER_PERMISSION : RESTRICTED_PERMISSION;
							break;
						case FREE_FOR_ALL:
							permission = ALL_PERMISSION;
							break;
						case ROUND_ROBIN:
							permission = ROUND_ROBIN_PERMISSION;
							break;
						default:
							permission = GROUP_PERMISSION;
							break;
						}
					}
					else
						permission = NONE_PERMISSION;
				}
				else if (recipient == this)
					permission = OWNER_PERMISSION;
				else
					permission = NONE_PERMISSION;
			}
		}
	}

	// LOOT_INSIGNIA and LOOT_FISHINGHOLE unsupported by client
	switch (loot_type)
	{
	case LOOT_INSIGNIA:    loot_type = LOOT_SKINNING; break;
	case LOOT_FISHINGHOLE: loot_type = LOOT_FISHING; break;
	case LOOT_FISHING_JUNK: loot_type = LOOT_FISHING; break;
	default: break;
	}

	// need know merged fishing/corpse loot type for achievements
	loot->loot_type = loot_type;

	if (permission != NONE_PERMISSION)
	{
		SetLootGUID(guid);

		WorldPacket data(SMSG_LOOT_RESPONSE, (9 + 50));           // we guess size
		data << uint64(guid);
		data << uint8(loot_type);
		data << LootView(*loot, this, permission);

		SendDirectMessage(&data);

		// add 'this' player as one of the players that are looting 'loot'
		loot->AddLooter(GetGUID());

		if (loot_type == LOOT_CORPSE && !IS_ITEM_GUID(guid))
			SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_LOOTING);
	}
	else
		SendLootError(guid, LOOT_ERROR_DIDNT_KILL);
}

void Player::SendLootError(uint64 guid, LootError error)
{
	WorldPacket data(SMSG_LOOT_RESPONSE, 10);
	data << uint64(guid);
	data << uint8(LOOT_NONE);
	data << uint8(error);
	SendDirectMessage(&data);
}

void Player::SendNotifyLootMoneyRemoved()
{
	WorldPacket data(SMSG_LOOT_CLEAR_MONEY, 0);
	GetSession()->SendPacket(&data);
}

void Player::SendNotifyLootItemRemoved(uint8 lootSlot)
{
	WorldPacket data(SMSG_LOOT_REMOVED, 1);
	data << uint8(lootSlot);
	GetSession()->SendPacket(&data);
}

void Player::SendUpdateWorldState(uint32 Field, uint32 Value)
{
	WorldPacket data(SMSG_UPDATE_WORLD_STATE, 8);
	data << Field;
	data << Value;
	GetSession()->SendPacket(&data);
}

void Player::SendInitWorldStates(uint32 zoneid, uint32 areaid)
{
	// data depends on zoneid/mapid...
	Battleground* bg = GetBattleground();
	uint32 mapid = GetMapId();
	OutdoorPvP* pvp = sOutdoorPvPMgr->GetOutdoorPvPToZoneId(zoneid);
	InstanceScript* instance = GetInstanceScript();
	Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(zoneid);

	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "Sending SMSG_INIT_WORLD_STATES to Map: %u, Zone: %u", mapid, zoneid);

	WorldPacket data(SMSG_INIT_WORLD_STATES, (4 + 4 + 4 + 2 + (12 * 8)));
	data << uint32(mapid);                                  // mapid
	data << uint32(zoneid);                                 // zone id
	data << uint32(areaid);                                 // area id, new 2.1.0
	size_t countPos = data.wpos();
	data << uint16(0);                                      // count of uint64 blocks
	data << uint32(0x8d8) << uint32(0x0);                   // 1
	data << uint32(0x8d7) << uint32(0x0);                   // 2
	data << uint32(0x8d6) << uint32(0x0);                   // 3
	data << uint32(0x8d5) << uint32(0x0);                   // 4
	data << uint32(0x8d4) << uint32(0x0);                   // 5
	data << uint32(0x8d3) << uint32(0x0);                   // 6
															// 7 1 - Arena season in progress, 0 - end of season
	data << uint32(0xC77) << uint32(sWorld->getBoolConfig(CONFIG_ARENA_SEASON_IN_PROGRESS));
	// 8 Arena season id
	data << uint32(0xF3D) << uint32(sWorld->getIntConfig(CONFIG_ARENA_SEASON_ID));

	if (mapid == 530)                                       // Outland
	{
		data << uint32(0x9bf) << uint32(0x0);               // 7
		data << uint32(0x9bd) << uint32(0xF);               // 8
		data << uint32(0x9bb) << uint32(0xF);               // 9
	}

	// insert <field> <value>
	switch (zoneid)
	{
	case 1:                                             // Dun Morogh
	case 11:                                            // Wetlands
	case 12:                                            // Elwynn Forest
	case 38:                                            // Loch Modan
	case 40:                                            // Westfall
	case 51:                                            // Searing Gorge
	case 1519:                                          // Stormwind City
	case 1537:                                          // Ironforge
	case 2257:                                          // Deeprun Tram
	case 3703:                                          // Shattrath City
		break;
	case 139:                                           // Eastern Plaguelands
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_EP)
			pvp->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x97a) << uint32(0x0); // 10 2426
			data << uint32(0x917) << uint32(0x0); // 11 2327
			data << uint32(0x918) << uint32(0x0); // 12 2328
			data << uint32(0x97b) << uint32(0x32); // 13 2427
			data << uint32(0x97c) << uint32(0x32); // 14 2428
			data << uint32(0x933) << uint32(0x1); // 15 2355
			data << uint32(0x946) << uint32(0x0); // 16 2374
			data << uint32(0x947) << uint32(0x0); // 17 2375
			data << uint32(0x948) << uint32(0x0); // 18 2376
			data << uint32(0x949) << uint32(0x0); // 19 2377
			data << uint32(0x94a) << uint32(0x0); // 20 2378
			data << uint32(0x94b) << uint32(0x0); // 21 2379
			data << uint32(0x932) << uint32(0x0); // 22 2354
			data << uint32(0x934) << uint32(0x0); // 23 2356
			data << uint32(0x935) << uint32(0x0); // 24 2357
			data << uint32(0x936) << uint32(0x0); // 25 2358
			data << uint32(0x937) << uint32(0x0); // 26 2359
			data << uint32(0x938) << uint32(0x0); // 27 2360
			data << uint32(0x939) << uint32(0x1); // 28 2361
			data << uint32(0x930) << uint32(0x1); // 29 2352
			data << uint32(0x93a) << uint32(0x0); // 30 2362
			data << uint32(0x93b) << uint32(0x0); // 31 2363
			data << uint32(0x93c) << uint32(0x0); // 32 2364
			data << uint32(0x93d) << uint32(0x0); // 33 2365
			data << uint32(0x944) << uint32(0x0); // 34 2372
			data << uint32(0x945) << uint32(0x0); // 35 2373
			data << uint32(0x931) << uint32(0x1); // 36 2353
			data << uint32(0x93e) << uint32(0x0); // 37 2366
			data << uint32(0x931) << uint32(0x1); // 38 2367 ??  grey horde not in dbc! send for consistency's sake, and to match field count
			data << uint32(0x940) << uint32(0x0); // 39 2368
			data << uint32(0x941) << uint32(0x0); // 7 2369
			data << uint32(0x942) << uint32(0x0); // 8 2370
			data << uint32(0x943) << uint32(0x0); // 9 2371
		}
		break;
	case 1377:                                          // Silithus
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_SI)
			pvp->FillInitialWorldStates(data);
		else
		{
			// states are always shown
			data << uint32(2313) << uint32(0x0); // 7 ally silityst gathered
			data << uint32(2314) << uint32(0x0); // 8 horde silityst gathered
			data << uint32(2317) << uint32(0x0); // 9 max silithyst
		}
		// dunno about these... aq opening event maybe?
		data << uint32(2322) << uint32(0x0); // 10 sandworm N
		data << uint32(2323) << uint32(0x0); // 11 sandworm S
		data << uint32(2324) << uint32(0x0); // 12 sandworm SW
		data << uint32(2325) << uint32(0x0); // 13 sandworm E
		break;
	case 2597:                                          // Alterac Valley
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_AV)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x7ae) << uint32(0x1);           // 7 snowfall n
			data << uint32(0x532) << uint32(0x1);           // 8 frostwolfhut hc
			data << uint32(0x531) << uint32(0x0);           // 9 frostwolfhut ac
			data << uint32(0x52e) << uint32(0x0);           // 10 stormpike firstaid a_a
			data << uint32(0x571) << uint32(0x0);           // 11 east frostwolf tower horde assaulted -unused
			data << uint32(0x570) << uint32(0x0);           // 12 west frostwolf tower horde assaulted - unused
			data << uint32(0x567) << uint32(0x1);           // 13 frostwolfe c
			data << uint32(0x566) << uint32(0x1);           // 14 frostwolfw c
			data << uint32(0x550) << uint32(0x1);           // 15 irondeep (N) ally
			data << uint32(0x544) << uint32(0x0);           // 16 ice grave a_a
			data << uint32(0x536) << uint32(0x0);           // 17 stormpike grave h_c
			data << uint32(0x535) << uint32(0x1);           // 18 stormpike grave a_c
			data << uint32(0x518) << uint32(0x0);           // 19 stoneheart grave a_a
			data << uint32(0x517) << uint32(0x0);           // 20 stoneheart grave h_a
			data << uint32(0x574) << uint32(0x0);           // 21 1396 unk
			data << uint32(0x573) << uint32(0x0);           // 22 iceblood tower horde assaulted -unused
			data << uint32(0x572) << uint32(0x0);           // 23 towerpoint horde assaulted - unused
			data << uint32(0x56f) << uint32(0x0);           // 24 1391 unk
			data << uint32(0x56e) << uint32(0x0);           // 25 iceblood a
			data << uint32(0x56d) << uint32(0x0);           // 26 towerp a
			data << uint32(0x56c) << uint32(0x0);           // 27 frostwolfe a
			data << uint32(0x56b) << uint32(0x0);           // 28 froswolfw a
			data << uint32(0x56a) << uint32(0x1);           // 29 1386 unk
			data << uint32(0x569) << uint32(0x1);           // 30 iceblood c
			data << uint32(0x568) << uint32(0x1);           // 31 towerp c
			data << uint32(0x565) << uint32(0x0);           // 32 stoneh tower a
			data << uint32(0x564) << uint32(0x0);           // 33 icewing tower a
			data << uint32(0x563) << uint32(0x0);           // 34 dunn a
			data << uint32(0x562) << uint32(0x0);           // 35 duns a
			data << uint32(0x561) << uint32(0x0);           // 36 stoneheart bunker alliance assaulted - unused
			data << uint32(0x560) << uint32(0x0);           // 37 icewing bunker alliance assaulted - unused
			data << uint32(0x55f) << uint32(0x0);           // 38 dunbaldar south alliance assaulted - unused
			data << uint32(0x55e) << uint32(0x0);           // 39 dunbaldar north alliance assaulted - unused
			data << uint32(0x55d) << uint32(0x0);           // 40 stone tower d
			data << uint32(0x3c6) << uint32(0x0);           // 41 966 unk
			data << uint32(0x3c4) << uint32(0x0);           // 42 964 unk
			data << uint32(0x3c2) << uint32(0x0);           // 43 962 unk
			data << uint32(0x516) << uint32(0x1);           // 44 stoneheart grave a_c
			data << uint32(0x515) << uint32(0x0);           // 45 stonheart grave h_c
			data << uint32(0x3b6) << uint32(0x0);           // 46 950 unk
			data << uint32(0x55c) << uint32(0x0);           // 47 icewing tower d
			data << uint32(0x55b) << uint32(0x0);           // 48 dunn d
			data << uint32(0x55a) << uint32(0x0);           // 49 duns d
			data << uint32(0x559) << uint32(0x0);           // 50 1369 unk
			data << uint32(0x558) << uint32(0x0);           // 51 iceblood d
			data << uint32(0x557) << uint32(0x0);           // 52 towerp d
			data << uint32(0x556) << uint32(0x0);           // 53 frostwolfe d
			data << uint32(0x555) << uint32(0x0);           // 54 frostwolfw d
			data << uint32(0x554) << uint32(0x1);           // 55 stoneh tower c
			data << uint32(0x553) << uint32(0x1);           // 56 icewing tower c
			data << uint32(0x552) << uint32(0x1);           // 57 dunn c
			data << uint32(0x551) << uint32(0x1);           // 58 duns c
			data << uint32(0x54f) << uint32(0x0);           // 59 irondeep (N) horde
			data << uint32(0x54e) << uint32(0x0);           // 60 irondeep (N) ally
			data << uint32(0x54d) << uint32(0x1);           // 61 mine (S) neutral
			data << uint32(0x54c) << uint32(0x0);           // 62 mine (S) horde
			data << uint32(0x54b) << uint32(0x0);           // 63 mine (S) ally
			data << uint32(0x545) << uint32(0x0);           // 64 iceblood h_a
			data << uint32(0x543) << uint32(0x1);           // 65 iceblod h_c
			data << uint32(0x542) << uint32(0x0);           // 66 iceblood a_c
			data << uint32(0x540) << uint32(0x0);           // 67 snowfall h_a
			data << uint32(0x53f) << uint32(0x0);           // 68 snowfall a_a
			data << uint32(0x53e) << uint32(0x0);           // 69 snowfall h_c
			data << uint32(0x53d) << uint32(0x0);           // 70 snowfall a_c
			data << uint32(0x53c) << uint32(0x0);           // 71 frostwolf g h_a
			data << uint32(0x53b) << uint32(0x0);           // 72 frostwolf g a_a
			data << uint32(0x53a) << uint32(0x1);           // 73 frostwolf g h_c
			data << uint32(0x539) << uint32(0x0);           // 74 frostwolf g a_c
			data << uint32(0x538) << uint32(0x0);           // 75 stormpike grave h_a
			data << uint32(0x537) << uint32(0x0);           // 76 stormpike grave a_a
			data << uint32(0x534) << uint32(0x0);           // 77 frostwolf hut h_a
			data << uint32(0x533) << uint32(0x0);           // 78 frostwolf hut a_a
			data << uint32(0x530) << uint32(0x0);           // 79 stormpike first aid h_a
			data << uint32(0x52f) << uint32(0x0);           // 80 stormpike first aid h_c
			data << uint32(0x52d) << uint32(0x1);           // 81 stormpike first aid a_c
		}
		break;
	case 3277:                                          // Warsong Gulch
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_WS)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x62d) << uint32(0x0);       // 7 1581 alliance flag captures
			data << uint32(0x62e) << uint32(0x0);       // 8 1582 horde flag captures
			data << uint32(0x609) << uint32(0x0);       // 9 1545 unk, set to 1 on alliance flag pickup...
			data << uint32(0x60a) << uint32(0x0);       // 10 1546 unk, set to 1 on horde flag pickup, after drop it's -1
			data << uint32(0x60b) << uint32(0x2);       // 11 1547 unk
			data << uint32(0x641) << uint32(0x3);       // 12 1601 unk (max flag captures?)
			data << uint32(0x922) << uint32(0x1);       // 13 2338 horde (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
			data << uint32(0x923) << uint32(0x1);       // 14 2339 alliance (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
		}
		break;
	case 3358:                                          // Arathi Basin
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_AB)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x6e7) << uint32(0x0);       // 7 1767 stables alliance
			data << uint32(0x6e8) << uint32(0x0);       // 8 1768 stables horde
			data << uint32(0x6e9) << uint32(0x0);       // 9 1769 unk, ST?
			data << uint32(0x6ea) << uint32(0x0);       // 10 1770 stables (show/hide)
			data << uint32(0x6ec) << uint32(0x0);       // 11 1772 farm (0 - horde controlled, 1 - alliance controlled)
			data << uint32(0x6ed) << uint32(0x0);       // 12 1773 farm (show/hide)
			data << uint32(0x6ee) << uint32(0x0);       // 13 1774 farm color
			data << uint32(0x6ef) << uint32(0x0);       // 14 1775 gold mine color, may be FM?
			data << uint32(0x6f0) << uint32(0x0);       // 15 1776 alliance resources
			data << uint32(0x6f1) << uint32(0x0);       // 16 1777 horde resources
			data << uint32(0x6f2) << uint32(0x0);       // 17 1778 horde bases
			data << uint32(0x6f3) << uint32(0x0);       // 18 1779 alliance bases
			data << uint32(0x6f4) << uint32(0x640);     // 19 1780 max resources (1600)
			data << uint32(0x6f6) << uint32(0x0);       // 20 1782 blacksmith color
			data << uint32(0x6f7) << uint32(0x0);       // 21 1783 blacksmith (show/hide)
			data << uint32(0x6f8) << uint32(0x0);       // 22 1784 unk, bs?
			data << uint32(0x6f9) << uint32(0x0);       // 23 1785 unk, bs?
			data << uint32(0x6fb) << uint32(0x0);       // 24 1787 gold mine (0 - horde contr, 1 - alliance contr)
			data << uint32(0x6fc) << uint32(0x0);       // 25 1788 gold mine (0 - conflict, 1 - horde)
			data << uint32(0x6fd) << uint32(0x0);       // 26 1789 gold mine (1 - show/0 - hide)
			data << uint32(0x6fe) << uint32(0x0);       // 27 1790 gold mine color
			data << uint32(0x700) << uint32(0x0);       // 28 1792 gold mine color, wtf?, may be LM?
			data << uint32(0x701) << uint32(0x0);       // 29 1793 lumber mill color (0 - conflict, 1 - horde contr)
			data << uint32(0x702) << uint32(0x0);       // 30 1794 lumber mill (show/hide)
			data << uint32(0x703) << uint32(0x0);       // 31 1795 lumber mill color color
			data << uint32(0x732) << uint32(0x1);       // 32 1842 stables (1 - uncontrolled)
			data << uint32(0x733) << uint32(0x1);       // 33 1843 gold mine (1 - uncontrolled)
			data << uint32(0x734) << uint32(0x1);       // 34 1844 lumber mill (1 - uncontrolled)
			data << uint32(0x735) << uint32(0x1);       // 35 1845 farm (1 - uncontrolled)
			data << uint32(0x736) << uint32(0x1);       // 36 1846 blacksmith (1 - uncontrolled)
			data << uint32(0x745) << uint32(0x2);       // 37 1861 unk
			data << uint32(0x7a3) << uint32(0x578);     // 38 1955 warning limit (1400)
		}
		break;
	case 3820:                                          // Eye of the Storm
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_EY)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0xac1) << uint32(0x0);       // 7  2753 Horde Bases
			data << uint32(0xac0) << uint32(0x0);       // 8  2752 Alliance Bases
			data << uint32(0xab6) << uint32(0x0);       // 9  2742 Mage Tower - Horde conflict
			data << uint32(0xab5) << uint32(0x0);       // 10 2741 Mage Tower - Alliance conflict
			data << uint32(0xab4) << uint32(0x0);       // 11 2740 Fel Reaver - Horde conflict
			data << uint32(0xab3) << uint32(0x0);       // 12 2739 Fel Reaver - Alliance conflict
			data << uint32(0xab2) << uint32(0x0);       // 13 2738 Draenei - Alliance conflict
			data << uint32(0xab1) << uint32(0x0);       // 14 2737 Draenei - Horde conflict
			data << uint32(0xab0) << uint32(0x0);       // 15 2736 unk // 0 at start
			data << uint32(0xaaf) << uint32(0x0);       // 16 2735 unk // 0 at start
			data << uint32(0xaad) << uint32(0x0);       // 17 2733 Draenei - Horde control
			data << uint32(0xaac) << uint32(0x0);       // 18 2732 Draenei - Alliance control
			data << uint32(0xaab) << uint32(0x1);       // 19 2731 Draenei uncontrolled (1 - yes, 0 - no)
			data << uint32(0xaaa) << uint32(0x0);       // 20 2730 Mage Tower - Alliance control
			data << uint32(0xaa9) << uint32(0x0);       // 21 2729 Mage Tower - Horde control
			data << uint32(0xaa8) << uint32(0x1);       // 22 2728 Mage Tower uncontrolled (1 - yes, 0 - no)
			data << uint32(0xaa7) << uint32(0x0);       // 23 2727 Fel Reaver - Horde control
			data << uint32(0xaa6) << uint32(0x0);       // 24 2726 Fel Reaver - Alliance control
			data << uint32(0xaa5) << uint32(0x1);       // 25 2725 Fel Reaver uncontrolled (1 - yes, 0 - no)
			data << uint32(0xaa4) << uint32(0x0);       // 26 2724 Boold Elf - Horde control
			data << uint32(0xaa3) << uint32(0x0);       // 27 2723 Boold Elf - Alliance control
			data << uint32(0xaa2) << uint32(0x1);       // 28 2722 Boold Elf uncontrolled (1 - yes, 0 - no)
			data << uint32(0xac5) << uint32(0x1);       // 29 2757 Flag (1 - show, 0 - hide) - doesn't work exactly this way!
			data << uint32(0xad2) << uint32(0x1);       // 30 2770 Horde top-stats (1 - show, 0 - hide) // 02 -> horde picked up the flag
			data << uint32(0xad1) << uint32(0x1);       // 31 2769 Alliance top-stats (1 - show, 0 - hide) // 02 -> alliance picked up the flag
			data << uint32(0xabe) << uint32(0x0);       // 32 2750 Horde resources
			data << uint32(0xabd) << uint32(0x0);       // 33 2749 Alliance resources
			data << uint32(0xa05) << uint32(0x8e);      // 34 2565 unk, constant?
			data << uint32(0xaa0) << uint32(0x0);       // 35 2720 Capturing progress-bar (100 -> empty (only grey), 0 -> blue|red (no grey), default 0)
			data << uint32(0xa9f) << uint32(0x0);       // 36 2719 Capturing progress-bar (0 - left, 100 - right)
			data << uint32(0xa9e) << uint32(0x0);       // 37 2718 Capturing progress-bar (1 - show, 0 - hide)
			data << uint32(0xc0d) << uint32(0x17b);     // 38 3085 unk
			// and some more ... unknown
		}
		break;
		// any of these needs change! the client remembers the prev setting!
		// ON EVERY ZONE LEAVE, RESET THE OLD ZONE'S WORLD STATE, BUT AT LEAST THE UI STUFF!
	case 3483:                                          // Hellfire Peninsula
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_HP)
			pvp->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x9ba) << uint32(0x1);           // 10 // add ally tower main gui icon       // maybe should be sent only on login?
			data << uint32(0x9b9) << uint32(0x1);           // 11 // add horde tower main gui icon      // maybe should be sent only on login?
			data << uint32(0x9b5) << uint32(0x0);           // 12 // show neutral broken hill icon      // 2485
			data << uint32(0x9b4) << uint32(0x1);           // 13 // show icon above broken hill        // 2484
			data << uint32(0x9b3) << uint32(0x0);           // 14 // show ally broken hill icon         // 2483
			data << uint32(0x9b2) << uint32(0x0);           // 15 // show neutral overlook icon         // 2482
			data << uint32(0x9b1) << uint32(0x1);           // 16 // show the overlook arrow            // 2481
			data << uint32(0x9b0) << uint32(0x0);           // 17 // show ally overlook icon            // 2480
			data << uint32(0x9ae) << uint32(0x0);           // 18 // horde pvp objectives captured      // 2478
			data << uint32(0x9ac) << uint32(0x0);           // 19 // ally pvp objectives captured       // 2476
			data << uint32(2475) << uint32(100); //: ally / horde slider grey area                              // show only in direct vicinity!
			data << uint32(2474) << uint32(50);  //: ally / horde slider percentage, 100 for ally, 0 for horde  // show only in direct vicinity!
			data << uint32(2473) << uint32(0);   //: ally / horde slider display                                // show only in direct vicinity!
			data << uint32(0x9a8) << uint32(0x0);           // 20 // show the neutral stadium icon      // 2472
			data << uint32(0x9a7) << uint32(0x0);           // 21 // show the ally stadium icon         // 2471
			data << uint32(0x9a6) << uint32(0x1);           // 22 // show the horde stadium icon        // 2470
		}
		break;
	case 3518:                                          // Nagrand
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_NA)
			pvp->FillInitialWorldStates(data);
		else
		{
			data << uint32(2503) << uint32(0x0);    // 10
			data << uint32(2502) << uint32(0x0);    // 11
			data << uint32(2493) << uint32(0x0);    // 12
			data << uint32(2491) << uint32(0x0);    // 13

			data << uint32(2495) << uint32(0x0);    // 14
			data << uint32(2494) << uint32(0x0);    // 15
			data << uint32(2497) << uint32(0x0);    // 16

			data << uint32(2762) << uint32(0x0);    // 17
			data << uint32(2662) << uint32(0x0);    // 18
			data << uint32(2663) << uint32(0x0);    // 19
			data << uint32(2664) << uint32(0x0);    // 20

			data << uint32(2760) << uint32(0x0);    // 21
			data << uint32(2670) << uint32(0x0);    // 22
			data << uint32(2668) << uint32(0x0);    // 23
			data << uint32(2669) << uint32(0x0);    // 24

			data << uint32(2761) << uint32(0x0);    // 25
			data << uint32(2667) << uint32(0x0);    // 26
			data << uint32(2665) << uint32(0x0);    // 27
			data << uint32(2666) << uint32(0x0);    // 28

			data << uint32(2763) << uint32(0x0);    // 29
			data << uint32(2659) << uint32(0x0);    // 30
			data << uint32(2660) << uint32(0x0);    // 31
			data << uint32(2661) << uint32(0x0);    // 32

			data << uint32(2671) << uint32(0x0);    // 33
			data << uint32(2676) << uint32(0x0);    // 34
			data << uint32(2677) << uint32(0x0);    // 35
			data << uint32(2672) << uint32(0x0);    // 36
			data << uint32(2673) << uint32(0x0);    // 37
		}
		break;
	case 3519:                                          // Terokkar Forest
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_TF)
			pvp->FillInitialWorldStates(data);
		else
		{
			data << uint32(0xa41) << uint32(0x0);           // 10 // 2625 capture bar pos
			data << uint32(0xa40) << uint32(0x14);          // 11 // 2624 capture bar neutral
			data << uint32(0xa3f) << uint32(0x0);           // 12 // 2623 show capture bar
			data << uint32(0xa3e) << uint32(0x0);           // 13 // 2622 horde towers controlled
			data << uint32(0xa3d) << uint32(0x5);           // 14 // 2621 ally towers controlled
			data << uint32(0xa3c) << uint32(0x0);           // 15 // 2620 show towers controlled
			data << uint32(0xa88) << uint32(0x0);           // 16 // 2696 SE Neu
			data << uint32(0xa87) << uint32(0x0);           // 17 // SE Horde
			data << uint32(0xa86) << uint32(0x0);           // 18 // SE Ally
			data << uint32(0xa85) << uint32(0x0);           // 19 //S Neu
			data << uint32(0xa84) << uint32(0x0);           // 20 S Horde
			data << uint32(0xa83) << uint32(0x0);           // 21 S Ally
			data << uint32(0xa82) << uint32(0x0);           // 22 NE Neu
			data << uint32(0xa81) << uint32(0x0);           // 23 NE Horde
			data << uint32(0xa80) << uint32(0x0);           // 24 NE Ally
			data << uint32(0xa7e) << uint32(0x0);           // 25 // 2686 N Neu
			data << uint32(0xa7d) << uint32(0x0);           // 26 N Horde
			data << uint32(0xa7c) << uint32(0x0);           // 27 N Ally
			data << uint32(0xa7b) << uint32(0x0);           // 28 NW Ally
			data << uint32(0xa7a) << uint32(0x0);           // 29 NW Horde
			data << uint32(0xa79) << uint32(0x0);           // 30 NW Neutral
			data << uint32(0x9d0) << uint32(0x5);           // 31 // 2512 locked time remaining seconds first digit
			data << uint32(0x9ce) << uint32(0x0);           // 32 // 2510 locked time remaining seconds second digit
			data << uint32(0x9cd) << uint32(0x0);           // 33 // 2509 locked time remaining minutes
			data << uint32(0x9cc) << uint32(0x0);           // 34 // 2508 neutral locked time show
			data << uint32(0xad0) << uint32(0x0);           // 35 // 2768 horde locked time show
			data << uint32(0xacf) << uint32(0x1);           // 36 // 2767 ally locked time show
		}
		break;
	case 3521:                                          // Zangarmarsh
		if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_ZM)
			pvp->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x9e1) << uint32(0x0);           // 10 //2529
			data << uint32(0x9e0) << uint32(0x0);           // 11
			data << uint32(0x9df) << uint32(0x0);           // 12
			data << uint32(0xa5d) << uint32(0x1);           // 13 //2653
			data << uint32(0xa5c) << uint32(0x0);           // 14 //2652 east beacon neutral
			data << uint32(0xa5b) << uint32(0x1);           // 15 horde
			data << uint32(0xa5a) << uint32(0x0);           // 16 ally
			data << uint32(0xa59) << uint32(0x1);           // 17 // 2649 Twin spire graveyard horde  12???
			data << uint32(0xa58) << uint32(0x0);           // 18 ally     14 ???
			data << uint32(0xa57) << uint32(0x0);           // 19 neutral  7???
			data << uint32(0xa56) << uint32(0x0);           // 20 // 2646 west beacon neutral
			data << uint32(0xa55) << uint32(0x1);           // 21 horde
			data << uint32(0xa54) << uint32(0x0);           // 22 ally
			data << uint32(0x9e7) << uint32(0x0);           // 23 // 2535
			data << uint32(0x9e6) << uint32(0x0);           // 24
			data << uint32(0x9e5) << uint32(0x0);           // 25
			data << uint32(0xa00) << uint32(0x0);           // 26 // 2560
			data << uint32(0x9ff) << uint32(0x1);           // 27
			data << uint32(0x9fe) << uint32(0x0);           // 28
			data << uint32(0x9fd) << uint32(0x0);           // 29
			data << uint32(0x9fc) << uint32(0x1);           // 30
			data << uint32(0x9fb) << uint32(0x0);           // 31
			data << uint32(0xa62) << uint32(0x0);           // 32 // 2658
			data << uint32(0xa61) << uint32(0x1);           // 33
			data << uint32(0xa60) << uint32(0x1);           // 34
			data << uint32(0xa5f) << uint32(0x0);           // 35
		}
		break;
	case 3698:                                          // Nagrand Arena
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_NA)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0xa0f) << uint32(0x0);           // 7
			data << uint32(0xa10) << uint32(0x0);           // 8
			data << uint32(0xa11) << uint32(0x0);           // 9 show
		}
		break;
	case 3702:                                          // Blade's Edge Arena
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_BE)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0x9f0) << uint32(0x0);           // 7 gold
			data << uint32(0x9f1) << uint32(0x0);           // 8 green
			data << uint32(0x9f3) << uint32(0x0);           // 9 show
		}
		break;
	case 3968:                                          // Ruins of Lordaeron
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_RL)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0xbb8) << uint32(0x0);           // 7 gold
			data << uint32(0xbb9) << uint32(0x0);           // 8 green
			data << uint32(0xbba) << uint32(0x0);           // 9 show
		}
		break;
	case 4378:                                          // Dalaran Sewers
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_DS)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(3601) << uint32(0x0);           // 7 gold
			data << uint32(3600) << uint32(0x0);           // 8 green
			data << uint32(3610) << uint32(0x0);           // 9 show
		}
		break;
	case 4384:                                          // Strand of the Ancients
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_SA)
			bg->FillInitialWorldStates(data);
		else
		{
			// 1-3 A defend, 4-6 H defend, 7-9 unk defend, 1 - ok, 2 - half destroyed, 3 - destroyed
			data << uint32(0xf09) << uint32(0x0);       // 7  3849 Gate of Temple
			data << uint32(0xe36) << uint32(0x0);       // 8  3638 Gate of Yellow Moon
			data << uint32(0xe27) << uint32(0x0);       // 9  3623 Gate of Green Emerald
			data << uint32(0xe24) << uint32(0x0);       // 10 3620 Gate of Blue Sapphire
			data << uint32(0xe21) << uint32(0x0);       // 11 3617 Gate of Red Sun
			data << uint32(0xe1e) << uint32(0x0);       // 12 3614 Gate of Purple Ametyst

			data << uint32(0xdf3) << uint32(0x0);       // 13 3571 bonus timer (1 - on, 0 - off)
			data << uint32(0xded) << uint32(0x0);       // 14 3565 Horde Attacker
			data << uint32(0xdec) << uint32(0x0);       // 15 3564 Alliance Attacker
			// End Round (timer), better explain this by example, eg. ends in 19:59 -> A:BC
			data << uint32(0xde9) << uint32(0x0);       // 16 3561 C
			data << uint32(0xde8) << uint32(0x0);       // 17 3560 B
			data << uint32(0xde7) << uint32(0x0);       // 18 3559 A
			data << uint32(0xe35) << uint32(0x0);       // 19 3637 East g - Horde control
			data << uint32(0xe34) << uint32(0x0);       // 20 3636 West g - Horde control
			data << uint32(0xe33) << uint32(0x0);       // 21 3635 South g - Horde control
			data << uint32(0xe32) << uint32(0x0);       // 22 3634 East g - Alliance control
			data << uint32(0xe31) << uint32(0x0);       // 23 3633 West g - Alliance control
			data << uint32(0xe30) << uint32(0x0);       // 24 3632 South g - Alliance control
			data << uint32(0xe2f) << uint32(0x0);       // 25 3631 Chamber of Ancients - Horde control
			data << uint32(0xe2e) << uint32(0x0);       // 26 3630 Chamber of Ancients - Alliance control
			data << uint32(0xe2d) << uint32(0x0);       // 27 3629 Beach1 - Horde control
			data << uint32(0xe2c) << uint32(0x0);       // 28 3628 Beach2 - Horde control
			data << uint32(0xe2b) << uint32(0x0);       // 29 3627 Beach1 - Alliance control
			data << uint32(0xe2a) << uint32(0x0);       // 30 3626 Beach2 - Alliance control
			// and many unks...
		}
		break;
	case 4406:                                          // Ring of Valor
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_RV)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(0xe10) << uint32(0x0);           // 7 gold
			data << uint32(0xe11) << uint32(0x0);           // 8 green
			data << uint32(0xe1a) << uint32(0x0);           // 9 show
		}
		break;
	case 4710:
		if (bg && bg->GetBgTypeID() == BATTLEGROUND_IC)
			bg->FillInitialWorldStates(data);
		else
		{
			data << uint32(4221) << uint32(1); // 7 BG_IC_ALLIANCE_RENFORT_SET
			data << uint32(4222) << uint32(1); // 8 BG_IC_HORDE_RENFORT_SET
			data << uint32(4226) << uint32(300); // 9 BG_IC_ALLIANCE_RENFORT
			data << uint32(4227) << uint32(300); // 10 BG_IC_HORDE_RENFORT
			data << uint32(4322) << uint32(1); // 11 BG_IC_GATE_FRONT_H_WS_OPEN
			data << uint32(4321) << uint32(1); // 12 BG_IC_GATE_WEST_H_WS_OPEN
			data << uint32(4320) << uint32(1); // 13 BG_IC_GATE_EAST_H_WS_OPEN
			data << uint32(4323) << uint32(1); // 14 BG_IC_GATE_FRONT_A_WS_OPEN
			data << uint32(4324) << uint32(1); // 15 BG_IC_GATE_WEST_A_WS_OPEN
			data << uint32(4325) << uint32(1); // 16 BG_IC_GATE_EAST_A_WS_OPEN
			data << uint32(4317) << uint32(1); // 17 unknown

			data << uint32(4301) << uint32(1); // 18 BG_IC_DOCKS_UNCONTROLLED
			data << uint32(4296) << uint32(1); // 19 BG_IC_HANGAR_UNCONTROLLED
			data << uint32(4306) << uint32(1); // 20 BG_IC_QUARRY_UNCONTROLLED
			data << uint32(4311) << uint32(1); // 21 BG_IC_REFINERY_UNCONTROLLED
			data << uint32(4294) << uint32(1); // 22 BG_IC_WORKSHOP_UNCONTROLLED
			data << uint32(4243) << uint32(1); // 23 unknown
			data << uint32(4345) << uint32(1); // 24 unknown
		}
		break;
		// The Ruby Sanctum
	case 4987:
		if (instance && mapid == 724)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(5049) << uint32(50);             // 9  WORLDSTATE_CORPOREALITY_MATERIAL
			data << uint32(5050) << uint32(50);             // 10 WORLDSTATE_CORPOREALITY_TWILIGHT
			data << uint32(5051) << uint32(0);              // 11 WORLDSTATE_CORPOREALITY_TOGGLE
		}
		break;
		// Icecrown Citadel
	case 4812:
		if (instance && mapid == 631)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(4903) << uint32(0);              // 9  WORLDSTATE_SHOW_TIMER (Blood Quickening weekly)
			data << uint32(4904) << uint32(30);             // 10 WORLDSTATE_EXECUTION_TIME
			data << uint32(4940) << uint32(0);              // 11 WORLDSTATE_SHOW_ATTEMPTS
			data << uint32(4941) << uint32(50);             // 12 WORLDSTATE_ATTEMPTS_REMAINING
			data << uint32(4942) << uint32(50);             // 13 WORLDSTATE_ATTEMPTS_MAX
		}
		break;
		// The Culling of Stratholme
	case 4100:
		if (instance && mapid == 595)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(3479) << uint32(0);              // 9  WORLDSTATE_SHOW_CRATES
			data << uint32(3480) << uint32(0);              // 10 WORLDSTATE_CRATES_REVEALED
			data << uint32(3504) << uint32(0);              // 11 WORLDSTATE_WAVE_COUNT
			data << uint32(3931) << uint32(25);             // 12 WORLDSTATE_TIME_GUARDIAN
			data << uint32(3932) << uint32(0);              // 13 WORLDSTATE_TIME_GUARDIAN_SHOW
		}
		break;
		// The Oculus
	case 4228:
		if (instance && mapid == 578)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(3524) << uint32(0);              // 9  WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW
			data << uint32(3486) << uint32(0);              // 10 WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT
		}
		break;
		// Ulduar
	case 4273:
		if (instance && mapid == 603)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(4132) << uint32(0);              // 9  WORLDSTATE_ALGALON_TIMER_ENABLED
			data << uint32(4131) << uint32(0);              // 10 WORLDSTATE_ALGALON_DESPAWN_TIMER
		}
		break;
		// Halls of Refection
	case 4820:
		if (instance && mapid == 668)
			instance->FillInitialWorldStates(data);
		else
		{
			data << uint32(4884) << uint32(0);              // 9  WORLD_STATE_HOR_WAVES_ENABLED
			data << uint32(4882) << uint32(0);              // 10 WORLD_STATE_HOR_WAVE_COUNT
		}
		break;
		// Scarlet Enclave (DK starting zone)
	case 4298:
		// Get Mograine, GUID and ENTRY should NEVER change
		if (Creature* mograine = ObjectAccessor::GetCreature(*this, MAKE_NEW_GUID(130956, 29173, HIGHGUID_UNIT)))
		{
			if (CreatureAI* mograineAI = mograine->AI())
			{
				data << uint32(3590) << uint32(mograineAI->GetData(3590));
				data << uint32(3591) << uint32(mograineAI->GetData(3591));
				data << uint32(3592) << uint32(mograineAI->GetData(3592));
				data << uint32(3603) << uint32(mograineAI->GetData(3603));
				data << uint32(3604) << uint32(mograineAI->GetData(3604));
				data << uint32(3605) << uint32(mograineAI->GetData(3605));
			}
		}
		break;
		// Wintergrasp
	case 4197:
		if (bf && bf->GetTypeId() == BATTLEFIELD_WG)
		{
			bf->FillInitialWorldStates(data);
			break;
		}
		// No break here, intended.
	default:
		data << uint32(0x914) << uint32(0x0);           // 7
		data << uint32(0x913) << uint32(0x0);           // 8
		data << uint32(0x912) << uint32(0x0);           // 9
		data << uint32(0x915) << uint32(0x0);           // 10
		break;
	}

	uint16 length = (data.wpos() - countPos) / 8;
	data.put<uint16>(countPos, length);

	GetSession()->SendPacket(&data);
	SendBGWeekendWorldStates();
	SendBattlefieldWorldStates();
}

void Player::SendBGWeekendWorldStates()
{
	for (uint32 i = 1; i < sBattlemasterListStore.GetNumRows(); ++i)
	{
		BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(i);
		if (bl && bl->HolidayWorldStateId)
		{
			if (BattlegroundMgr::IsBGWeekend((BattlegroundTypeId)bl->id))
				SendUpdateWorldState(bl->HolidayWorldStateId, 1);
			else
				SendUpdateWorldState(bl->HolidayWorldStateId, 0);
		}
	}
}

void Player::SendBattlefieldWorldStates()
{
	/// Send misc stuff that needs to be sent on every login, like the battle timers.
	if (sWorld->getBoolConfig(CONFIG_WINTERGRASP_ENABLE))
	{
		if (BattlefieldWG* wg = (BattlefieldWG*)sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
		{
			SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_ATTACKER, wg->GetAttackerTeam());
			SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER, wg->GetDefenderTeam());
			SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE, wg->IsWarTime() ? 0 : 1); // Note: cleanup these two, their names look awkward
			SendUpdateWorldState(BATTLEFIELD_WG_WORLD_STATE_SHOW_WORLDSTATE, wg->IsWarTime() ? 1 : 0);

			for (uint32 i = 0; i < 2; ++i)
				SendUpdateWorldState(ClockWorldState[i], uint32(time(NULL) + (wg->GetTimer() / 1000)));
		}
	}
}

uint32 Player::GetXPRestBonus(uint32 xp)
{
	uint32 rested_bonus = (uint32)GetRestBonus();           // xp for each rested bonus

	if (rested_bonus > xp)                                   // max rested_bonus == xp or (r+x) = 200% xp
		rested_bonus = xp;

	SetRestBonus(GetRestBonus() - rested_bonus);

	;//sLog->outDetail("Player gain %u xp (+ %u Rested Bonus). Rested points=%f", xp+rested_bonus, rested_bonus, GetRestBonus());
	return rested_bonus;
}

void Player::SetBindPoint(uint64 guid)
{
	WorldPacket data(SMSG_BINDER_CONFIRM, 8);
	data << uint64(guid);
	GetSession()->SendPacket(&data);
}

void Player::SendTalentWipeConfirm(uint64 guid)
{
	WorldPacket data(MSG_TALENT_WIPE_CONFIRM, (8 + 4));
	data << uint64(guid);
	uint32 cost = sWorld->getBoolConfig(CONFIG_NO_RESET_TALENT_COST) ? 0 : resetTalentsCost();
	data << cost;
	GetSession()->SendPacket(&data);
}

void Player::ResetPetTalents()
{
	// This needs another gossip option + NPC text as a confirmation.
	// The confirmation gossip listid has the text: "Yes, please do."
	Pet* pet = GetPet();

	if (!pet || pet->getPetType() != HUNTER_PET || pet->m_usedTalentCount == 0)
		return;

	CharmInfo* charmInfo = pet->GetCharmInfo();
	if (!charmInfo)
	{
		sLog->outError("Object (GUID: %u TypeId: %u) is considered pet-like but doesn't have a charminfo!", pet->GetGUIDLow(), pet->GetTypeId());
		return;
	}
	pet->resetTalents();
	SendTalentsInfoData(true);
}

/*********************************************************/
/***                    STORAGE SYSTEM                 ***/
/*********************************************************/

void Player::SetVirtualItemSlot(uint8 i, Item* item)
{
	ASSERT(i < 3);
	if (i < 2 && item)
	{
		if (!item->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT))
			return;
		uint32 charges = item->GetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT);
		if (charges == 0)
			return;
		if (charges > 1)
			item->SetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT, charges - 1);
		else if (charges <= 1)
		{
			ApplyEnchantment(item, TEMP_ENCHANTMENT_SLOT, false);
			item->ClearEnchantment(TEMP_ENCHANTMENT_SLOT);
		}
	}
}

void Player::SetSheath(SheathState sheathed)
{
	switch (sheathed)
	{
	case SHEATH_STATE_UNARMED:                          // no prepared weapon
		SetVirtualItemSlot(0, NULL);
		SetVirtualItemSlot(1, NULL);
		SetVirtualItemSlot(2, NULL);
		break;
	case SHEATH_STATE_MELEE:                            // prepared melee weapon
		SetVirtualItemSlot(0, GetWeaponForAttack(BASE_ATTACK, true));
		SetVirtualItemSlot(1, GetWeaponForAttack(OFF_ATTACK, true));
		SetVirtualItemSlot(2, NULL);
		break;
	case SHEATH_STATE_RANGED:                           // prepared ranged weapon
		SetVirtualItemSlot(0, NULL);
		SetVirtualItemSlot(1, NULL);
		SetVirtualItemSlot(2, GetWeaponForAttack(RANGED_ATTACK, true));
		break;
	default:
		SetVirtualItemSlot(0, NULL);
		SetVirtualItemSlot(1, NULL);
		SetVirtualItemSlot(2, NULL);
		break;
	}
	Unit::SetSheath(sheathed);                              // this must visualize Sheath changing for other players...
}

uint8 Player::FindEquipSlot(ItemTemplate const* proto, uint32 slot, bool swap) const
{
	uint8 playerClass = getClass();

	uint8 slots[4];
	slots[0] = NULL_SLOT;
	slots[1] = NULL_SLOT;
	slots[2] = NULL_SLOT;
	slots[3] = NULL_SLOT;
	switch (proto->InventoryType)
	{
	case INVTYPE_HEAD:
		slots[0] = EQUIPMENT_SLOT_HEAD;
		break;
	case INVTYPE_NECK:
		slots[0] = EQUIPMENT_SLOT_NECK;
		break;
	case INVTYPE_SHOULDERS:
		slots[0] = EQUIPMENT_SLOT_SHOULDERS;
		break;
	case INVTYPE_BODY:
		slots[0] = EQUIPMENT_SLOT_BODY;
		break;
	case INVTYPE_CHEST:
		slots[0] = EQUIPMENT_SLOT_CHEST;
		break;
	case INVTYPE_ROBE:
		slots[0] = EQUIPMENT_SLOT_CHEST;
		break;
	case INVTYPE_WAIST:
		slots[0] = EQUIPMENT_SLOT_WAIST;
		break;
	case INVTYPE_LEGS:
		slots[0] = EQUIPMENT_SLOT_LEGS;
		break;
	case INVTYPE_FEET:
		slots[0] = EQUIPMENT_SLOT_FEET;
		break;
	case INVTYPE_WRISTS:
		slots[0] = EQUIPMENT_SLOT_WRISTS;
		break;
	case INVTYPE_HANDS:
		slots[0] = EQUIPMENT_SLOT_HANDS;
		break;
	case INVTYPE_FINGER:
		slots[0] = EQUIPMENT_SLOT_FINGER1;
		slots[1] = EQUIPMENT_SLOT_FINGER2;
		break;
	case INVTYPE_TRINKET:
		slots[0] = EQUIPMENT_SLOT_TRINKET1;
		slots[1] = EQUIPMENT_SLOT_TRINKET2;
		break;
	case INVTYPE_CLOAK:
		slots[0] = EQUIPMENT_SLOT_BACK;
		break;
	case INVTYPE_WEAPON:
	{
		slots[0] = EQUIPMENT_SLOT_MAINHAND;

		// suggest offhand slot only if know dual wielding
		// (this will be replace mainhand weapon at auto equip instead unwonted "you don't known dual wielding" ...
		if (CanDualWield())
			slots[1] = EQUIPMENT_SLOT_OFFHAND;
		break;
	}
	case INVTYPE_SHIELD:
		slots[0] = EQUIPMENT_SLOT_OFFHAND;
		break;
	case INVTYPE_RANGED:
		slots[0] = EQUIPMENT_SLOT_RANGED;
		break;
	case INVTYPE_2HWEAPON:
		slots[0] = EQUIPMENT_SLOT_MAINHAND;
		if (Item* mhWeapon = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
		{
			if (ItemTemplate const* mhWeaponProto = mhWeapon->GetTemplate())
			{
				if (mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_STAFF || mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE)
				{
					const_cast<Player*>(this)->AutoUnequipOffhandIfNeed(true);
					break;
				}
			}
		}

		if (GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
		{
			if (proto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || proto->SubClass == ITEM_SUBCLASS_WEAPON_STAFF || proto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE)
			{
				const_cast<Player*>(this)->AutoUnequipOffhandIfNeed(true);
				break;
			}
		}
		if (CanDualWield() && CanTitanGrip() && proto->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM && proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF && proto->SubClass != ITEM_SUBCLASS_WEAPON_FISHING_POLE)
			slots[1] = EQUIPMENT_SLOT_OFFHAND;
		break;
	case INVTYPE_TABARD:
		slots[0] = EQUIPMENT_SLOT_TABARD;
		break;
	case INVTYPE_WEAPONMAINHAND:
		slots[0] = EQUIPMENT_SLOT_MAINHAND;
		break;
	case INVTYPE_WEAPONOFFHAND:
		slots[0] = EQUIPMENT_SLOT_OFFHAND;
		break;
	case INVTYPE_HOLDABLE:
		slots[0] = EQUIPMENT_SLOT_OFFHAND;
		break;
	case INVTYPE_THROWN:
		slots[0] = EQUIPMENT_SLOT_RANGED;
		break;
	case INVTYPE_RANGEDRIGHT:
		slots[0] = EQUIPMENT_SLOT_RANGED;
		break;
	case INVTYPE_BAG:
		slots[0] = INVENTORY_SLOT_BAG_START + 0;
		slots[1] = INVENTORY_SLOT_BAG_START + 1;
		slots[2] = INVENTORY_SLOT_BAG_START + 2;
		slots[3] = INVENTORY_SLOT_BAG_START + 3;
		break;
	case INVTYPE_RELIC:
	{
		switch (proto->SubClass)
		{
		case ITEM_SUBCLASS_ARMOR_LIBRAM:
			if (playerClass == CLASS_PALADIN)
				slots[0] = EQUIPMENT_SLOT_RANGED;
			break;
		case ITEM_SUBCLASS_ARMOR_IDOL:
			if (playerClass == CLASS_DRUID)
				slots[0] = EQUIPMENT_SLOT_RANGED;
			break;
		case ITEM_SUBCLASS_ARMOR_TOTEM:
			if (playerClass == CLASS_SHAMAN)
				slots[0] = EQUIPMENT_SLOT_RANGED;
			break;
		case ITEM_SUBCLASS_ARMOR_MISC:
			if (playerClass == CLASS_WARLOCK)
				slots[0] = EQUIPMENT_SLOT_RANGED;
			break;
		case ITEM_SUBCLASS_ARMOR_SIGIL:
			if (playerClass == CLASS_DEATH_KNIGHT)
				slots[0] = EQUIPMENT_SLOT_RANGED;
			break;
		}
		break;
	}
	default:
		return NULL_SLOT;
	}

	if (slot != NULL_SLOT)
	{
		if (swap || !GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
			for (uint8 i = 0; i < 4; ++i)
				if (slots[i] == slot)
					return slot;
	}
	else
	{
		// search free slot at first
		for (uint8 i = 0; i < 4; ++i)
			if (slots[i] != NULL_SLOT && !GetItemByPos(INVENTORY_SLOT_BAG_0, slots[i]))
				// in case 2hand equipped weapon (without titan grip) offhand slot empty but not free
				if (slots[i] != EQUIPMENT_SLOT_OFFHAND || !IsTwoHandUsed())
					return slots[i];

		// if not found free and can swap return first appropriate from used
		for (uint8 i = 0; i < 4; ++i)
			if (slots[i] != NULL_SLOT && swap)
				return slots[i];
	}

	// no free position
	return NULL_SLOT;
}

InventoryResult Player::CanUnequipItems(uint32 item, uint32 count) const
{
	uint32 tempcount = 0;

	InventoryResult res = EQUIP_ERR_OK;

	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == item)
			{
				InventoryResult ires = CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i, false);
				if (ires == EQUIP_ERR_OK)
				{
					tempcount += pItem->GetCount();
					if (tempcount >= count)
						return EQUIP_ERR_OK;
				}
				else
					res = ires;
			}

	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == item)
			{
				tempcount += pItem->GetCount();
				if (tempcount >= count)
					return EQUIP_ERR_OK;
			}

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == item)
			{
				tempcount += pItem->GetCount();
				if (tempcount >= count)
					return EQUIP_ERR_OK;
			}

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = GetItemByPos(i, j))
					if (pItem->GetEntry() == item)
					{
						tempcount += pItem->GetCount();
						if (tempcount >= count)
							return EQUIP_ERR_OK;
					}

	// not found req. item count and have unequippable items
	return res;
}

uint32 Player::GetItemCount(uint32 item, bool inBankAlso, Item* skipItem) const
{
	uint32 count = 0;
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem != skipItem &&  pItem->GetEntry() == item)
				count += pItem->GetCount();

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem != skipItem && pItem->GetEntry() == item)
				count += pItem->GetCount();

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			count += pBag->GetItemCount(item, skipItem);

	if (skipItem && skipItem->GetTemplate()->GemProperties)
		for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
			if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				if (pItem != skipItem && pItem->GetTemplate()->Socket[0].Color)
					count += pItem->GetGemCountWithID(item);

	if (inBankAlso)
	{
		// checking every item from 39 to 74 (including bank bags)
		for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
			if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				if (pItem != skipItem && pItem->GetEntry() == item)
					count += pItem->GetCount();

		for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
			if (Bag* pBag = GetBagByPos(i))
				count += pBag->GetItemCount(item, skipItem);

		if (skipItem && skipItem->GetTemplate()->GemProperties)
			for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; ++i)
				if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
					if (pItem != skipItem && pItem->GetTemplate()->Socket[0].Color)
						count += pItem->GetGemCountWithID(item);
	}

	return count;
}

uint32 Player::GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem) const
{
	uint32 count = 0;
	for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem != skipItem)
				if (ItemTemplate const* pProto = pItem->GetTemplate())
					if (pProto->ItemLimitCategory == limitCategory)
						count += pItem->GetCount();

	for (int i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem != skipItem)
				if (ItemTemplate const* pProto = pItem->GetTemplate())
					if (pProto->ItemLimitCategory == limitCategory)
						count += pItem->GetCount();

	for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			count += pBag->GetItemCountWithLimitCategory(limitCategory, skipItem);

	for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem != skipItem)
				if (ItemTemplate const* pProto = pItem->GetTemplate())
					if (pProto->ItemLimitCategory == limitCategory)
						count += pItem->GetCount();

	for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			count += pBag->GetItemCountWithLimitCategory(limitCategory, skipItem);

	return count;
}

Item* Player::GetItemByGuid(uint64 guid) const
{
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetGUID() == guid)
				return pItem;

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetGUID() == guid)
				return pItem;

	for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetGUID() == guid)
				return pItem;

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (pItem->GetGUID() == guid)
						return pItem;

	for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (pItem->GetGUID() == guid)
						return pItem;

	return NULL;
}

Item* Player::GetItemByPos(uint16 pos) const
{
	uint8 bag = pos >> 8;
	uint8 slot = pos & 255;
	return GetItemByPos(bag, slot);
}

Item* Player::GetItemByPos(uint8 bag, uint8 slot) const
{
	if (bag == INVENTORY_SLOT_BAG_0 && (slot < BANK_SLOT_BAG_END || (slot >= KEYRING_SLOT_START && slot < CURRENCYTOKEN_SLOT_END)))
		return m_items[slot];
	else if (Bag* pBag = GetBagByPos(bag))
		return pBag->GetItemByPos(slot);
	return NULL;
}

Bag* Player::GetBagByPos(uint8 bag) const
{
	if ((bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
		|| (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END))
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, bag))
			return item->ToBag();
	return NULL;
}

Item* Player::GetWeaponForAttack(WeaponAttackType attackType, bool useable /*= false*/) const
{
	uint8 slot;
	switch (attackType)
	{
	case BASE_ATTACK:   slot = EQUIPMENT_SLOT_MAINHAND; break;
	case OFF_ATTACK:    slot = EQUIPMENT_SLOT_OFFHAND;  break;
	case RANGED_ATTACK: slot = EQUIPMENT_SLOT_RANGED;   break;
	default: return NULL;
	}

	Item* item = NULL;
	if (useable)
		item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, slot);
	else
		item = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
	if (!item || item->GetTemplate()->Class != ITEM_CLASS_WEAPON)
		return NULL;

	if (!useable)
		return item;

	if (item->IsBroken() || IsInFeralForm())
		return NULL;

	return item;
}

Item* Player::GetShield(bool useable) const
{
	Item* item = NULL;
	if (useable)
		item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
	else
		item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
	if (!item || item->GetTemplate()->Class != ITEM_CLASS_ARMOR)
		return NULL;

	if (!useable)
		return item;

	if (item->IsBroken())
		return NULL;

	return item;
}

uint8 Player::GetAttackBySlot(uint8 slot)
{
	switch (slot)
	{
	case EQUIPMENT_SLOT_MAINHAND: return BASE_ATTACK;
	case EQUIPMENT_SLOT_OFFHAND:  return OFF_ATTACK;
	case EQUIPMENT_SLOT_RANGED:   return RANGED_ATTACK;
	default:                      return MAX_ATTACK;
	}
}

bool Player::IsInventoryPos(uint8 bag, uint8 slot)
{
	if (bag == INVENTORY_SLOT_BAG_0 && slot == NULL_SLOT)
		return true;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END))
		return true;
	if (bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
		return true;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= KEYRING_SLOT_START && slot < CURRENCYTOKEN_SLOT_END))
		return true;
	return false;
}

bool Player::IsEquipmentPos(uint8 bag, uint8 slot)
{
	if (bag == INVENTORY_SLOT_BAG_0 && (slot < EQUIPMENT_SLOT_END))
		return true;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
		return true;
	return false;
}

bool Player::IsBankPos(uint8 bag, uint8 slot)
{
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END))
		return true;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
		return true;
	if (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END)
		return true;
	return false;
}

bool Player::IsBagPos(uint16 pos)
{
	uint8 bag = pos >> 8;
	uint8 slot = pos & 255;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
		return true;
	if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
		return true;
	return false;
}

bool Player::IsValidPos(uint8 bag, uint8 slot, bool explicit_pos)
{
	// post selected
	if (bag == NULL_BAG && !explicit_pos)
		return true;

	if (bag == INVENTORY_SLOT_BAG_0)
	{
		// any post selected
		if (slot == NULL_SLOT && !explicit_pos)
			return true;

		// equipment
		if (slot < EQUIPMENT_SLOT_END)
			return true;

		// bag equip slots
		if (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END)
			return true;

		// backpack slots
		if (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END)
			return true;

		// keyring slots
		if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_END)
			return true;

		// bank main slots
		if (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END)
			return true;

		// bank bag slots
		if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
			return true;

		return false;
	}

	// bag content slots
	// bank bag content slots
	if (Bag* pBag = GetBagByPos(bag))
	{
		// any post selected
		if (slot == NULL_SLOT && !explicit_pos)
			return true;

		return slot < pBag->GetBagSize();
	}

	// where this?
	return false;
}

bool Player::HasItemCount(uint32 item, uint32 count, bool inBankAlso) const
{
	uint32 tempcount = 0;
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
	{
		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
		{
			tempcount += pItem->GetCount();
			if (tempcount >= count)
				return true;
		}
	}
	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
	{
		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
		{
			tempcount += pItem->GetCount();
			if (tempcount >= count)
				return true;
		}
	}
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
	{
		if (Bag* pBag = GetBagByPos(i))
		{
			for (uint32 j = 0; j < pBag->GetBagSize(); j++)
			{
				Item* pItem = GetItemByPos(i, j);
				if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
				{
					tempcount += pItem->GetCount();
					if (tempcount >= count)
						return true;
				}
			}
		}
	}

	if (inBankAlso)
	{
		for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
		{
			Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
			if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
			{
				tempcount += pItem->GetCount();
				if (tempcount >= count)
					return true;
			}
		}
		for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
		{
			if (Bag* pBag = GetBagByPos(i))
			{
				for (uint32 j = 0; j < pBag->GetBagSize(); j++)
				{
					Item* pItem = GetItemByPos(i, j);
					if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
					{
						tempcount += pItem->GetCount();
						if (tempcount >= count)
							return true;
					}
				}
			}
		}
	}

	return false;
}

bool Player::HasItemOrGemWithIdEquipped(uint32 item, uint32 count, uint8 except_slot) const
{
	uint32 tempcount = 0;
	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		if (i == except_slot)
			continue;

		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem && pItem->GetEntry() == item)
		{
			tempcount += pItem->GetCount();
			if (tempcount >= count)
				return true;
		}
	}

	ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
	if (pProto && pProto->GemProperties)
	{
		for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
		{
			if (i == except_slot)
				continue;

			Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
			if (pItem && pItem->GetTemplate()->Socket[0].Color)
			{
				tempcount += pItem->GetGemCountWithID(item);
				if (tempcount >= count)
					return true;
			}
		}
	}

	return false;
}

bool Player::HasItemOrGemWithLimitCategoryEquipped(uint32 limitCategory, uint32 count, uint8 except_slot) const
{
	uint32 tempcount = 0;
	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		if (i == except_slot)
			continue;

		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (!pItem)
			continue;

		ItemTemplate const* pProto = pItem->GetTemplate();
		if (!pProto)
			continue;

		if (pProto->ItemLimitCategory == limitCategory)
		{
			tempcount += pItem->GetCount();
			if (tempcount >= count)
				return true;
		}

		if (pProto->Socket[0].Color || pItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT))
		{
			tempcount += pItem->GetGemCountWithLimitCategory(limitCategory);
			if (tempcount >= count)
				return true;
		}
	}

	return false;
}

InventoryResult Player::CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count) const
{
	ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(entry);
	if (!pProto)
	{
		if (no_space_count)
			*no_space_count = count;
		return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
	}

	if (pItem && pItem->m_lootGenerated)
		return EQUIP_ERR_ALREADY_LOOTED;

	// no maximum
	if ((pProto->MaxCount <= 0 && pProto->ItemLimitCategory == 0) || pProto->MaxCount == 2147483647)
		return EQUIP_ERR_OK;

	if (pProto->MaxCount > 0)
	{
		uint32 curcount = GetItemCount(pProto->ItemId, true, pItem);
		if (curcount + count > uint32(pProto->MaxCount))
		{
			if (no_space_count)
				*no_space_count = count + curcount - pProto->MaxCount;
			return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
		}
	}

	// check unique-equipped limit
	if (pProto->ItemLimitCategory)
	{
		ItemLimitCategoryEntry const* limitEntry = sItemLimitCategoryStore.LookupEntry(pProto->ItemLimitCategory);
		if (!limitEntry)
		{
			if (no_space_count)
				*no_space_count = count;
			return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;
		}

		if (limitEntry->mode == ITEM_LIMIT_CATEGORY_MODE_HAVE)
		{
			uint32 curcount = GetItemCountWithLimitCategory(pProto->ItemLimitCategory, pItem);
			if (curcount + count > uint32(limitEntry->maxCount))
			{
				if (no_space_count)
					*no_space_count = count + curcount - limitEntry->maxCount;
				return EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED;
			}
		}
	}

	return EQUIP_ERR_OK;
}

bool Player::HasItemTotemCategory(uint32 TotemCategory) const
{
	Item* pItem;
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
	{
		pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
			return true;
	}
	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
	{
		pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
			return true;
	}
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (Bag* pBag = GetBagByPos(i))
		{
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
			{
				pItem = GetItemByPos(i, j);
				if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
					return true;
			}
		}
	}
	return false;
}

bool Player::IsTotemCategoryCompatiableWith(const ItemTemplate* pProto, uint32 requiredTotemCategoryId) const
{
	if (requiredTotemCategoryId == 0)
		return true;
	if (pProto->TotemCategory == 0)
		return false;

	TotemCategoryEntry const* itemEntry = sTotemCategoryStore.LookupEntry(pProto->TotemCategory);
	if (!itemEntry)
		return false;
	TotemCategoryEntry const* reqEntry = sTotemCategoryStore.LookupEntry(requiredTotemCategoryId);
	if (!reqEntry)
		return false;

	if (itemEntry->categoryType != reqEntry->categoryType)
		return false;

	if ((itemEntry->categoryMask & reqEntry->categoryMask) != reqEntry->categoryMask)
		return false;

	// xinef: check skill requirements, needed for enchants!
	if (pProto->RequiredSkill)
		if (this->GetSkillValue(pProto->RequiredSkill) < pProto->RequiredSkillRank)
			return false;

	return true;
}

InventoryResult Player::CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec &dest, ItemTemplate const* pProto, uint32& count, bool swap, Item* pSrcItem) const
{
	Item* pItem2 = GetItemByPos(bag, slot);

	// ignore move item (this slot will be empty at move)
	if (pItem2 == pSrcItem)
		pItem2 = NULL;

	uint32 need_space;

	if (pSrcItem && pSrcItem->IsNotEmptyBag() && !IsBagPos(uint16(bag) << 8 | slot))
		return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

	// empty specific slot - check item fit to slot
	if (!pItem2 || swap)
	{
		if (bag == INVENTORY_SLOT_BAG_0)
		{
			// keyring case
			if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_START + GetMaxKeyringSize() && !(pProto->BagFamily & BAG_FAMILY_MASK_KEYS))
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

			// currencytoken case
			if (slot >= CURRENCYTOKEN_SLOT_START && slot < CURRENCYTOKEN_SLOT_END && !(pProto->IsCurrencyToken()))
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

			// prevent cheating
			if ((slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END) || slot >= PLAYER_SLOT_END)
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
		}
		else
		{
			Bag* pBag = GetBagByPos(bag);
			if (!pBag)
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

			ItemTemplate const* pBagProto = pBag->GetTemplate();
			if (!pBagProto)
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

			if (slot >= pBagProto->ContainerSlots)
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

			if (!ItemCanGoIntoBag(pProto, pBagProto))
				return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
		}

		// non empty stack with space
		need_space = pProto->GetMaxStackSize();
	}
	// non empty slot, check item type
	else
	{
		// can be merged at least partly
		InventoryResult res = pItem2->CanBeMergedPartlyWith(pProto);
		if (res != EQUIP_ERR_OK)
			return res;

		// free stack space or infinity
		need_space = pProto->GetMaxStackSize() - pItem2->GetCount();
	}

	if (need_space > count)
		need_space = count;

	ItemPosCount newPosition = ItemPosCount((bag << 8) | slot, need_space);
	if (!newPosition.isContainedIn(dest))
	{
		dest.push_back(newPosition);
		count -= need_space;
	}
	return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem_InBag(uint8 bag, ItemPosCountVec &dest, ItemTemplate const* pProto, uint32& count, bool merge, bool non_specialized, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
	// skip specific bag already processed in first called CanStoreItem_InBag
	if (bag == skip_bag)
		return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

	// skip not existed bag or self targeted bag
	Bag* pBag = GetBagByPos(bag);
	if (!pBag || pBag == pSrcItem || (pSrcItem && (pSrcItem->GetGUID() == pBag->GetGUID())))
		return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

	if (pSrcItem && pSrcItem->IsNotEmptyBag())
		return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

	ItemTemplate const* pBagProto = pBag->GetTemplate();
	if (!pBagProto)
		return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

	// specialized bag mode or non-specilized
	if (non_specialized != (pBagProto->Class == ITEM_CLASS_CONTAINER && pBagProto->SubClass == ITEM_SUBCLASS_CONTAINER))
		return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

	if (!ItemCanGoIntoBag(pProto, pBagProto))
		return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

	for (uint32 j = 0; j < pBag->GetBagSize(); j++)
	{
		// skip specific slot already processed in first called CanStoreItem_InSpecificSlot
		if (j == skip_slot)
			continue;

		Item* pItem2 = GetItemByPos(bag, j);

		// ignore move item (this slot will be empty at move)
		if (pItem2 == pSrcItem)
			pItem2 = NULL;

		// if merge skip empty, if !merge skip non-empty
		if ((pItem2 != NULL) != merge)
			continue;

		uint32 need_space = pProto->GetMaxStackSize();

		if (pItem2)
		{
			// can be merged at least partly
			uint8 res = pItem2->CanBeMergedPartlyWith(pProto);
			if (res != EQUIP_ERR_OK)
				continue;

			// descrease at current stacksize
			need_space -= pItem2->GetCount();
		}

		if (need_space > count)
			need_space = count;

		ItemPosCount newPosition = ItemPosCount((bag << 8) | j, need_space);
		if (!newPosition.isContainedIn(dest))
		{
			dest.push_back(newPosition);
			count -= need_space;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
	}
	return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec &dest, ItemTemplate const* pProto, uint32& count, bool merge, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
	//this is never called for non-bag slots so we can do this
	if (pSrcItem && pSrcItem->IsNotEmptyBag())
		return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

	for (uint32 j = slot_begin; j < slot_end; j++)
	{
		// skip specific slot already processed in first called CanStoreItem_InSpecificSlot
		if (INVENTORY_SLOT_BAG_0 == skip_bag && j == skip_slot)
			continue;

		Item* pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, j);

		// ignore move item (this slot will be empty at move)
		if (pItem2 == pSrcItem)
			pItem2 = NULL;

		// if merge skip empty, if !merge skip non-empty
		if ((pItem2 != NULL) != merge)
			continue;

		uint32 need_space = pProto->GetMaxStackSize();

		if (pItem2)
		{
			// can be merged at least partly
			uint8 res = pItem2->CanBeMergedPartlyWith(pProto);
			if (res != EQUIP_ERR_OK)
				continue;

			// descrease at current stacksize
			need_space -= pItem2->GetCount();
		}

		if (need_space > count)
			need_space = count;

		ItemPosCount newPosition = ItemPosCount((INVENTORY_SLOT_BAG_0 << 8) | j, need_space);
		if (!newPosition.isContainedIn(dest))
		{
			dest.push_back(newPosition);
			count -= need_space;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
	}
	return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec &dest, uint32 entry, uint32 count, Item* pItem, bool swap, uint32* no_space_count) const
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanStoreItem bag = %u, slot = %u, item = %u, count = %u", bag, slot, entry, count);

	ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(entry);
	if (!pProto)
	{
		if (no_space_count)
			*no_space_count = count;
		return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;
	}

	if (pItem)
	{
		// you bad chet0rz, wpe pro
		if (bag == NULL_BAG && slot == NULL_SLOT)
			if (pItem->IsBag() && pItem->IsNotEmptyBag())
				return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

		// Xinef: Removed next bullshit loot generated check
		if (pItem->GetGUID() == GetLootGUID())
		{
			if (no_space_count)
				*no_space_count = count;
			return EQUIP_ERR_ALREADY_LOOTED;
		}

		if (pItem->IsBindedNotWith(this))
		{
			if (no_space_count)
				*no_space_count = count;
			return EQUIP_ERR_DONT_OWN_THAT_ITEM;
		}
	}

	// check count of items (skip for auto move for same player from bank)
	uint32 no_similar_count = 0;                            // can't store this amount similar items
	InventoryResult res = CanTakeMoreSimilarItems(entry, count, pItem, &no_similar_count);
	if (res != EQUIP_ERR_OK)
	{
		if (count == no_similar_count)
		{
			if (no_space_count)
				*no_space_count = no_similar_count;
			return res;
		}
		count -= no_similar_count;
	}

	// in specific slot
	if (bag != NULL_BAG && slot != NULL_SLOT)
	{
		res = CanStoreItem_InSpecificSlot(bag, slot, dest, pProto, count, swap, pItem);
		if (res != EQUIP_ERR_OK)
		{
			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return res;
		}

		if (count == 0)
		{
			if (no_similar_count == 0)
				return EQUIP_ERR_OK;

			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
		}
	}

	// not specific slot or have space for partly store only in specific slot

	// in specific bag
	if (bag != NULL_BAG)
	{
		// search stack in bag for merge to
		if (pProto->Stackable != 1)
		{
			if (bag == INVENTORY_SLOT_BAG_0)               // inventory
			{
				res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, true, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}

				res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}
			}
			else                                            // equipped bag
			{
				// we need check 2 time (specialized/non_specialized), use NULL_BAG to prevent skipping bag
				res = CanStoreItem_InBag(bag, dest, pProto, count, true, false, pItem, NULL_BAG, slot);
				if (res != EQUIP_ERR_OK)
					res = CanStoreItem_InBag(bag, dest, pProto, count, true, true, pItem, NULL_BAG, slot);

				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}
			}
		}

		// search free slot in bag for place to
		if (bag == INVENTORY_SLOT_BAG_0)                     // inventory
		{
			// search free slot - keyring case
			if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
			{
				uint32 keyringSize = GetMaxKeyringSize();
				res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, KEYRING_SLOT_START + keyringSize, dest, pProto, count, false, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}

				res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}
			}
			else if (pProto->IsCurrencyToken())
			{
				res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
				{
					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return res;
				}

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}
			}

			res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
			{
				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return res;
			}

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}
		else                                                // equipped bag
		{
			res = CanStoreItem_InBag(bag, dest, pProto, count, false, false, pItem, NULL_BAG, slot);
			if (res != EQUIP_ERR_OK)
				res = CanStoreItem_InBag(bag, dest, pProto, count, false, true, pItem, NULL_BAG, slot);

			if (res != EQUIP_ERR_OK)
			{
				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return res;
			}

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}
	}

	// not specific bag or have space for partly store only in specific bag

	// search stack for merge to
	if (pProto->Stackable != 1)
	{
		res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, true, pItem, bag, slot);
		if (res != EQUIP_ERR_OK)
		{
			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return res;
		}

		if (count == 0)
		{
			if (no_similar_count == 0)
				return EQUIP_ERR_OK;

			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
		}

		res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
		if (res != EQUIP_ERR_OK)
		{
			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return res;
		}

		if (count == 0)
		{
			if (no_similar_count == 0)
				return EQUIP_ERR_OK;

			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
		}

		if (pProto->BagFamily)
		{
			for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
			{
				res = CanStoreItem_InBag(i, dest, pProto, count, true, false, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
					continue;

				if (count == 0)
				{
					if (no_similar_count == 0)
						return EQUIP_ERR_OK;

					if (no_space_count)
						*no_space_count = count + no_similar_count;
					return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
				}
			}
		}

		for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
		{
			res = CanStoreItem_InBag(i, dest, pProto, count, true, true, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
				continue;

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}
	}

	// search free slot - special bag case
	if (pProto->BagFamily)
	{
		if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
		{
			uint32 keyringSize = GetMaxKeyringSize();
			res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, KEYRING_SLOT_START + keyringSize, dest, pProto, count, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
			{
				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return res;
			}

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}
		else if (pProto->IsCurrencyToken())
		{
			res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
			{
				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return res;
			}

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}

		for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
		{
			res = CanStoreItem_InBag(i, dest, pProto, count, false, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
				continue;

			if (count == 0)
			{
				if (no_similar_count == 0)
					return EQUIP_ERR_OK;

				if (no_space_count)
					*no_space_count = count + no_similar_count;
				return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
			}
		}
	}

	if (pItem && pItem->IsNotEmptyBag())
		return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;

	// search free slot
	res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
	if (res != EQUIP_ERR_OK)
	{
		if (no_space_count)
			*no_space_count = count + no_similar_count;
		return res;
	}

	if (count == 0)
	{
		if (no_similar_count == 0)
			return EQUIP_ERR_OK;

		if (no_space_count)
			*no_space_count = count + no_similar_count;
		return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
	}

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
	{
		res = CanStoreItem_InBag(i, dest, pProto, count, false, true, pItem, bag, slot);
		if (res != EQUIP_ERR_OK)
			continue;

		if (count == 0)
		{
			if (no_similar_count == 0)
				return EQUIP_ERR_OK;

			if (no_space_count)
				*no_space_count = count + no_similar_count;
			return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
		}
	}

	if (no_space_count)
		*no_space_count = count + no_similar_count;

	return EQUIP_ERR_INVENTORY_FULL;
}

//////////////////////////////////////////////////////////////////////////
InventoryResult Player::CanStoreItems(Item** pItems, int count) const
{
	Item* pItem2;

	// fill space table
	int inv_slot_items[INVENTORY_SLOT_ITEM_END - INVENTORY_SLOT_ITEM_START];
	int inv_bags[INVENTORY_SLOT_BAG_END - INVENTORY_SLOT_BAG_START][MAX_BAG_SIZE];
	int inv_keys[KEYRING_SLOT_END - KEYRING_SLOT_START];
	int inv_tokens[CURRENCYTOKEN_SLOT_END - CURRENCYTOKEN_SLOT_START];

	memset(inv_slot_items, 0, sizeof(int) * (INVENTORY_SLOT_ITEM_END - INVENTORY_SLOT_ITEM_START));
	memset(inv_bags, 0, sizeof(int) * (INVENTORY_SLOT_BAG_END - INVENTORY_SLOT_BAG_START) * MAX_BAG_SIZE);
	memset(inv_keys, 0, sizeof(int) * (KEYRING_SLOT_END - KEYRING_SLOT_START));
	memset(inv_tokens, 0, sizeof(int) * (CURRENCYTOKEN_SLOT_END - CURRENCYTOKEN_SLOT_START));

	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
	{
		pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem2 && !pItem2->IsInTrade())
			inv_slot_items[i - INVENTORY_SLOT_ITEM_START] = pItem2->GetCount();
	}

	for (uint8 i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
	{
		pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem2 && !pItem2->IsInTrade())
			inv_keys[i - KEYRING_SLOT_START] = pItem2->GetCount();
	}

	for (uint8 i = CURRENCYTOKEN_SLOT_START; i < CURRENCYTOKEN_SLOT_END; i++)
	{
		pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem2 && !pItem2->IsInTrade())
			inv_tokens[i - CURRENCYTOKEN_SLOT_START] = pItem2->GetCount();
	}

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); j++)
			{
				pItem2 = GetItemByPos(i, j);
				if (pItem2 && !pItem2->IsInTrade())
					inv_bags[i - INVENTORY_SLOT_BAG_START][j] = pItem2->GetCount();
			}

	// check free space for all items
	for (int k = 0; k < count; ++k)
	{
		Item* pItem = pItems[k];

		// no item
		if (!pItem)
			continue;

		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanStoreItems %i. item = %u, count = %u", k + 1, pItem->GetEntry(), pItem->GetCount());
		ItemTemplate const* pProto = pItem->GetTemplate();

		// strange item
		if (!pProto)
			return EQUIP_ERR_ITEM_NOT_FOUND;

		// Xinef: Removed next bullshit loot generated check
		if (pItem->GetGUID() == GetLootGUID())
			return EQUIP_ERR_ALREADY_LOOTED;

		// item it 'bind'
		if (pItem->IsBindedNotWith(this))
			return EQUIP_ERR_DONT_OWN_THAT_ITEM;

		ItemTemplate const* pBagProto;

		// item is 'one item only'
		InventoryResult res = CanTakeMoreSimilarItems(pItem);
		if (res != EQUIP_ERR_OK)
			return res;

		// search stack for merge to
		if (pProto->Stackable != 1)
		{
			bool b_found = false;

			for (uint8 t = KEYRING_SLOT_START; t < KEYRING_SLOT_END; ++t)
			{
				pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
				if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_keys[t - KEYRING_SLOT_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
				{
					inv_keys[t - KEYRING_SLOT_START] += pItem->GetCount();
					b_found = true;
					break;
				}
			}
			if (b_found)
				continue;

			for (int t = CURRENCYTOKEN_SLOT_START; t < CURRENCYTOKEN_SLOT_END; ++t)
			{
				pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
				if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_tokens[t - CURRENCYTOKEN_SLOT_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
				{
					inv_tokens[t - CURRENCYTOKEN_SLOT_START] += pItem->GetCount();
					b_found = true;
					break;
				}
			}
			if (b_found)
				continue;

			for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; ++t)
			{
				pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
				if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_slot_items[t - INVENTORY_SLOT_ITEM_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
				{
					inv_slot_items[t - INVENTORY_SLOT_ITEM_START] += pItem->GetCount();
					b_found = true;
					break;
				}
			}
			if (b_found)
				continue;

			for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
			{
				if (Bag* bag = GetBagByPos(t))
				{
					if (ItemCanGoIntoBag(pItem->GetTemplate(), bag->GetTemplate()))
					{
						for (uint32 j = 0; j < bag->GetBagSize(); j++)
						{
							pItem2 = GetItemByPos(t, j);
							if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_bags[t - INVENTORY_SLOT_BAG_START][j] + pItem->GetCount() <= pProto->GetMaxStackSize())
							{
								inv_bags[t - INVENTORY_SLOT_BAG_START][j] += pItem->GetCount();
								b_found = true;
								break;
							}
						}
					}
				}
			}
			if (b_found)
				continue;
		}

		// special bag case
		if (pProto->BagFamily)
		{
			bool b_found = false;
			if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
			{
				uint32 keyringSize = GetMaxKeyringSize();
				for (uint32 t = KEYRING_SLOT_START; t < KEYRING_SLOT_START + keyringSize; ++t)
				{
					if (inv_keys[t - KEYRING_SLOT_START] == 0)
					{
						inv_keys[t - KEYRING_SLOT_START] = 1;
						b_found = true;
						break;
					}
				}
			}

			if (b_found)
				continue;

			if (pProto->IsCurrencyToken())
			{
				for (uint32 t = CURRENCYTOKEN_SLOT_START; t < CURRENCYTOKEN_SLOT_END; ++t)
				{
					if (inv_tokens[t - CURRENCYTOKEN_SLOT_START] == 0)
					{
						inv_tokens[t - CURRENCYTOKEN_SLOT_START] = 1;
						b_found = true;
						break;
					}
				}
			}

			if (b_found)
				continue;

			for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
			{
				if (Bag* bag = GetBagByPos(t))
				{
					pBagProto = bag->GetTemplate();

					// not plain container check
					if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER) &&
						ItemCanGoIntoBag(pProto, pBagProto))
					{
						for (uint32 j = 0; j < bag->GetBagSize(); j++)
						{
							if (inv_bags[t - INVENTORY_SLOT_BAG_START][j] == 0)
							{
								inv_bags[t - INVENTORY_SLOT_BAG_START][j] = 1;
								b_found = true;
								break;
							}
						}
					}
				}
			}
			if (b_found)
				continue;
		}

		// search free slot
		bool b_found = false;
		for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; ++t)
		{
			if (inv_slot_items[t - INVENTORY_SLOT_ITEM_START] == 0)
			{
				inv_slot_items[t - INVENTORY_SLOT_ITEM_START] = 1;
				b_found = true;
				break;
			}
		}
		if (b_found)
			continue;

		// search free slot in bags
		for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
		{
			if (Bag* bag = GetBagByPos(t))
			{
				pBagProto = bag->GetTemplate();

				// special bag already checked
				if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER))
					continue;

				for (uint32 j = 0; j < bag->GetBagSize(); j++)
				{
					if (inv_bags[t - INVENTORY_SLOT_BAG_START][j] == 0)
					{
						inv_bags[t - INVENTORY_SLOT_BAG_START][j] = 1;
						b_found = true;
						break;
					}
				}
			}
		}

		// no free slot found?
		if (!b_found)
			return EQUIP_ERR_INVENTORY_FULL;
	}

	return EQUIP_ERR_OK;
}

//////////////////////////////////////////////////////////////////////////
InventoryResult Player::CanEquipNewItem(uint8 slot, uint16 &dest, uint32 item, bool swap) const
{
	dest = 0;
	Item* pItem = Item::CreateItem(item, 1, this);
	if (pItem)
	{
		InventoryResult result = CanEquipItem(slot, dest, pItem, swap);
		delete pItem;
		return result;
	}

	return EQUIP_ERR_ITEM_NOT_FOUND;
}

InventoryResult Player::CanEquipItem(uint8 slot, uint16 &dest, Item* pItem, bool swap, bool not_loading) const
{
	dest = 0;
	if (pItem)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanEquipItem slot = %u, item = %u, count = %u", slot, pItem->GetEntry(), pItem->GetCount());
		ItemTemplate const* pProto = pItem->GetTemplate();
		if (pProto)
		{
			// item used
			if (pItem->m_lootGenerated)
				return EQUIP_ERR_ALREADY_LOOTED;

			if (pItem->IsBindedNotWith(this))
				return EQUIP_ERR_DONT_OWN_THAT_ITEM;

			// check count of items (skip for auto move for same player from bank)
			InventoryResult res = CanTakeMoreSimilarItems(pItem);
			if (res != EQUIP_ERR_OK)
				return res;

			// check this only in game
			if (not_loading)
			{
				// May be here should be more stronger checks; STUNNED checked
				// ROOT, CONFUSED, DISTRACTED, FLEEING this needs to be checked.
				if (HasUnitState(UNIT_STATE_STUNNED))
					return EQUIP_ERR_YOU_ARE_STUNNED;

				// do not allow equipping gear except weapons, offhands, projectiles, relics in
				// - combat
				// - in-progress arenas
				if (!pProto->CanChangeEquipStateInCombat())
				{
					if (IsInCombat())
						return EQUIP_ERR_NOT_IN_COMBAT;

					if (Battleground* bg = GetBattleground())
						if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
							return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
				}

				if (IsInCombat() && (pProto->Class == ITEM_CLASS_WEAPON || pProto->InventoryType == INVTYPE_RELIC) && m_weaponChangeTimer != 0)
					return EQUIP_ERR_CANT_DO_RIGHT_NOW;         // maybe exist better err

				if (IsNonMeleeSpellCast(false))
					return EQUIP_ERR_CANT_DO_RIGHT_NOW;
			}

			ScalingStatDistributionEntry const* ssd = pProto->ScalingStatDistribution ? sScalingStatDistributionStore.LookupEntry(pProto->ScalingStatDistribution) : 0;
			// check allowed level (extend range to upper values if MaxLevel more or equal max player level, this let GM set high level with 1...max range items)
			if (ssd && ssd->MaxLevel < DEFAULT_MAX_LEVEL && ssd->MaxLevel < getLevel())
				return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

			uint8 eslot = FindEquipSlot(pProto, slot, swap);
			if (eslot == NULL_SLOT)
				return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

			// Xinef: dont allow to equip items on disarmed slot
			if (!CanUseAttackType(GetAttackBySlot(eslot)))
				return EQUIP_ERR_NOT_WHILE_DISARMED;

			res = CanUseItem(pItem, not_loading);
			if (res != EQUIP_ERR_OK)
				return res;

			if (!swap && GetItemByPos(INVENTORY_SLOT_BAG_0, eslot))
				return EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE;

			// if we are swapping 2 equiped items, CanEquipUniqueItem check
			// should ignore the item we are trying to swap, and not the
			// destination item. CanEquipUniqueItem should ignore destination
			// item only when we are swapping weapon from bag
			uint8 ignore = uint8(NULL_SLOT);
			switch (eslot)
			{
			case EQUIPMENT_SLOT_MAINHAND:
				ignore = EQUIPMENT_SLOT_OFFHAND;
				break;
			case EQUIPMENT_SLOT_OFFHAND:
				ignore = EQUIPMENT_SLOT_MAINHAND;
				break;
			case EQUIPMENT_SLOT_FINGER1:
				ignore = EQUIPMENT_SLOT_FINGER2;
				break;
			case EQUIPMENT_SLOT_FINGER2:
				ignore = EQUIPMENT_SLOT_FINGER1;
				break;
			case EQUIPMENT_SLOT_TRINKET1:
				ignore = EQUIPMENT_SLOT_TRINKET2;
				break;
			case EQUIPMENT_SLOT_TRINKET2:
				ignore = EQUIPMENT_SLOT_TRINKET1;
				break;
			}

			if (ignore == uint8(NULL_SLOT) || pItem != GetItemByPos(INVENTORY_SLOT_BAG_0, ignore))
				ignore = eslot;

			InventoryResult res2 = CanEquipUniqueItem(pItem, swap ? ignore : uint8(NULL_SLOT));
			if (res2 != EQUIP_ERR_OK)
				return res2;

			// check unique-equipped special item classes
			if (pProto->Class == ITEM_CLASS_QUIVER)
				for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
					if (Item* pBag = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
						if (pBag != pItem)
							if (ItemTemplate const* pBagProto = pBag->GetTemplate())
								if (pBagProto->Class == pProto->Class && (!swap || pBag->GetSlot() != eslot))
									return (pBagProto->SubClass == ITEM_SUBCLASS_AMMO_POUCH)
									? EQUIP_ERR_CAN_EQUIP_ONLY1_AMMOPOUCH
									: EQUIP_ERR_CAN_EQUIP_ONLY1_QUIVER;

			uint32 type = pProto->InventoryType;

			if (eslot == EQUIPMENT_SLOT_OFFHAND)
			{
				// Do not allow polearm to be equipped in the offhand (rare case for the only 1h polearm 41750)
				// xinef: same for fishing poles
				if (type == INVTYPE_WEAPON && (pProto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || pProto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE))
					return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;

				else if (type == INVTYPE_WEAPON || type == INVTYPE_WEAPONOFFHAND)
				{
					if (!CanDualWield())
						return EQUIP_ERR_CANT_DUAL_WIELD;
				}
				else if (type == INVTYPE_2HWEAPON)
				{
					if (!CanDualWield() || !CanTitanGrip())
						return EQUIP_ERR_CANT_DUAL_WIELD;
				}

				if (IsTwoHandUsed())
					return EQUIP_ERR_CANT_EQUIP_WITH_TWOHANDED;
			}

			// equip two-hand weapon case (with possible unequip 2 items)
			if (type == INVTYPE_2HWEAPON)
			{
				if (eslot == EQUIPMENT_SLOT_OFFHAND)
				{
					if (!CanTitanGrip())
						return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;
				}
				else if (eslot != EQUIPMENT_SLOT_MAINHAND)
					return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

				if (!CanTitanGrip())
				{
					// offhand item must can be stored in inventory for offhand item and it also must be unequipped
					Item* offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
					ItemPosCountVec off_dest;
					if (offItem && (!not_loading ||
						CanUnequipItem(uint16(INVENTORY_SLOT_BAG_0) << 8 | EQUIPMENT_SLOT_OFFHAND, false) != EQUIP_ERR_OK ||
						CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false) != EQUIP_ERR_OK))
						return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_INVENTORY_FULL;
				}
			}
			dest = ((INVENTORY_SLOT_BAG_0 << 8) | eslot);
			return EQUIP_ERR_OK;
		}
	}

	return !swap ? EQUIP_ERR_ITEM_NOT_FOUND : EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;
}

InventoryResult Player::CanUnequipItem(uint16 pos, bool swap) const
{
	// Applied only to equipped items and bank bags
	if (!IsEquipmentPos(pos) && !IsBagPos(pos))
		return EQUIP_ERR_OK;

	Item* pItem = GetItemByPos(pos);

	// Applied only to existed equipped item
	if (!pItem)
		return EQUIP_ERR_OK;

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanUnequipItem slot = %u, item = %u, count = %u", pos, pItem->GetEntry(), pItem->GetCount());

	ItemTemplate const* pProto = pItem->GetTemplate();
	if (!pProto)
		return EQUIP_ERR_ITEM_NOT_FOUND;

	// item used
	if (pItem->m_lootGenerated)
		return EQUIP_ERR_ALREADY_LOOTED;

	// do not allow unequipping gear except weapons, offhands, projectiles, relics in
	// - combat
	// - in-progress arenas
	if (!pProto->CanChangeEquipStateInCombat())
	{
		if (IsInCombat())
			return EQUIP_ERR_NOT_IN_COMBAT;

		if (Battleground* bg = GetBattleground())
			if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
				return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
	}

	// Xinef: dont allow to unequip items on disarmed slot
	if (!CanUseAttackType(GetAttackBySlot(pItem->GetSlot())))
		return EQUIP_ERR_NOT_WHILE_DISARMED;

	if (!swap && pItem->IsNotEmptyBag())
		return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

	return EQUIP_ERR_OK;
}

InventoryResult Player::CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec &dest, Item* pItem, bool swap, bool not_loading) const
{
	if (!pItem)
		return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

	uint32 count = pItem->GetCount();

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanBankItem bag = %u, slot = %u, item = %u, count = %u", bag, slot, pItem->GetEntry(), pItem->GetCount());
	ItemTemplate const* pProto = pItem->GetTemplate();
	if (!pProto)
		return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

	// Xinef: Removed next bullshit loot generated check
	if (pItem->GetGUID() == GetLootGUID())
		return EQUIP_ERR_ALREADY_LOOTED;

	if (pItem->IsBindedNotWith(this))
		return EQUIP_ERR_DONT_OWN_THAT_ITEM;

	// Currency tokens are not supposed to be swapped out of their hidden bag
	uint8 pItemslot = pItem->GetSlot();
	if (pItemslot >= CURRENCYTOKEN_SLOT_START && pItemslot < CURRENCYTOKEN_SLOT_END)
	{
		sLog->outError("Possible hacking attempt: Player %s [guid: %u] tried to move token [guid: %u, entry: %u] out of the currency bag!",
			GetName().c_str(), GetGUIDLow(), pItem->GetGUIDLow(), pProto->ItemId);
		return EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;
	}

	// check count of items (skip for auto move for same player from bank)
	InventoryResult res = CanTakeMoreSimilarItems(pItem);
	if (res != EQUIP_ERR_OK)
		return res;

	// in specific slot
	if (bag != NULL_BAG && slot != NULL_SLOT)
	{
		if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
		{
			if (!pItem->IsBag())
				return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;

			if (slot - BANK_SLOT_BAG_START >= GetBankBagSlotCount())
				return EQUIP_ERR_MUST_PURCHASE_THAT_BAG_SLOT;

			res = CanUseItem(pItem, not_loading);
			if (res != EQUIP_ERR_OK)
				return res;
		}

		res = CanStoreItem_InSpecificSlot(bag, slot, dest, pProto, count, swap, pItem);
		if (res != EQUIP_ERR_OK)
			return res;

		if (count == 0)
			return EQUIP_ERR_OK;
	}

	// not specific slot or have space for partly store only in specific slot

	// in specific bag
	if (bag != NULL_BAG)
	{
		if (pItem->IsNotEmptyBag())
			return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;

		// search stack in bag for merge to
		if (pProto->Stackable != 1)
		{
			if (bag == INVENTORY_SLOT_BAG_0)
			{
				res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
					return res;

				if (count == 0)
					return EQUIP_ERR_OK;
			}
			else
			{
				res = CanStoreItem_InBag(bag, dest, pProto, count, true, false, pItem, NULL_BAG, slot);
				if (res != EQUIP_ERR_OK)
					res = CanStoreItem_InBag(bag, dest, pProto, count, true, true, pItem, NULL_BAG, slot);

				if (res != EQUIP_ERR_OK)
					return res;

				if (count == 0)
					return EQUIP_ERR_OK;
			}
		}

		// search free slot in bag
		if (bag == INVENTORY_SLOT_BAG_0)
		{
			res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
				return res;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
		else
		{
			res = CanStoreItem_InBag(bag, dest, pProto, count, false, false, pItem, NULL_BAG, slot);
			if (res != EQUIP_ERR_OK)
				res = CanStoreItem_InBag(bag, dest, pProto, count, false, true, pItem, NULL_BAG, slot);

			if (res != EQUIP_ERR_OK)
				return res;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
	}

	// not specific bag or have space for partly store only in specific bag

	// search stack for merge to
	if (pProto->Stackable != 1)
	{
		// in slots
		res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
		if (res != EQUIP_ERR_OK)
			return res;

		if (count == 0)
			return EQUIP_ERR_OK;

		// in special bags
		if (pProto->BagFamily)
		{
			for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
			{
				res = CanStoreItem_InBag(i, dest, pProto, count, true, false, pItem, bag, slot);
				if (res != EQUIP_ERR_OK)
					continue;

				if (count == 0)
					return EQUIP_ERR_OK;
			}
		}

		for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
		{
			res = CanStoreItem_InBag(i, dest, pProto, count, true, true, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
				continue;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
	}

	// search free place in special bag
	if (pProto->BagFamily)
	{
		for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
		{
			res = CanStoreItem_InBag(i, dest, pProto, count, false, false, pItem, bag, slot);
			if (res != EQUIP_ERR_OK)
				continue;

			if (count == 0)
				return EQUIP_ERR_OK;
		}
	}

	// search free space
	res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
	if (res != EQUIP_ERR_OK)
		return res;

	if (count == 0)
		return EQUIP_ERR_OK;

	for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
	{
		res = CanStoreItem_InBag(i, dest, pProto, count, false, true, pItem, bag, slot);
		if (res != EQUIP_ERR_OK)
			continue;

		if (count == 0)
			return EQUIP_ERR_OK;
	}
	return EQUIP_ERR_BANK_FULL;
}

InventoryResult Player::CanUseItem(Item* pItem, bool not_loading) const
{
	if (pItem)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanUseItem item = %u", pItem->GetEntry());

		if (!IsAlive() && not_loading)
			return EQUIP_ERR_YOU_ARE_DEAD;

		//if (isStunned())
		//    return EQUIP_ERR_YOU_ARE_STUNNED;

		ItemTemplate const* pProto = pItem->GetTemplate();
		if (pProto)
		{
			if (pItem->IsBindedNotWith(this))
				return EQUIP_ERR_DONT_OWN_THAT_ITEM;

			InventoryResult res = CanUseItem(pProto);
			if (res != EQUIP_ERR_OK)
				return res;

			if (pItem->GetSkill() != 0)
			{
				bool allowEquip = false;
				uint32 itemSkill = pItem->GetSkill();
				// Armor that is binded to account can "morph" from plate to mail, etc. if skill is not learned yet.
				if (pProto->Quality == ITEM_QUALITY_HEIRLOOM && pProto->Class == ITEM_CLASS_ARMOR && !HasSkill(itemSkill))
				{
					// TODO: when you right-click already equipped item it throws EQUIP_ERR_NO_REQUIRED_PROFICIENCY.

					// In fact it's a visual bug, everything works properly... I need sniffs of operations with
					// binded to account items from off server.

					switch (getClass())
					{
					case CLASS_HUNTER:
					case CLASS_SHAMAN:
						allowEquip = (itemSkill == SKILL_MAIL);
						break;
					case CLASS_PALADIN:
					case CLASS_WARRIOR:
						allowEquip = (itemSkill == SKILL_PLATE_MAIL);
						break;
					}
				}
				if (!allowEquip && GetSkillValue(itemSkill) == 0)
					return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
			}

			if (pProto->RequiredReputationFaction && uint32(GetReputationRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank)
				return EQUIP_ERR_CANT_EQUIP_REPUTATION;

			return EQUIP_ERR_OK;
		}
	}
	return EQUIP_ERR_ITEM_NOT_FOUND;
}

InventoryResult Player::CanUseItem(ItemTemplate const* proto) const
{
	// Used by group, function NeedBeforeGreed, to know if a prototype can be used by a player

	if (proto)
	{
		if ((proto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && GetTeamId(true) != TEAM_HORDE)
			return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;

		if ((proto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && GetTeamId(true) != TEAM_ALLIANCE)
			return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;

		if ((proto->AllowableClass & getClassMask()) == 0 || (proto->AllowableRace & getRaceMask()) == 0)
			return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;

		if (proto->RequiredSkill != 0)
		{
			if (GetSkillValue(proto->RequiredSkill) == 0)
				return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
			else if (GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
				return EQUIP_ERR_CANT_EQUIP_SKILL;
		}

		if (proto->RequiredSpell != 0 && !HasSpell(proto->RequiredSpell))
			return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;

		if (getLevel() < proto->RequiredLevel)
			return EQUIP_ERR_CANT_EQUIP_LEVEL_I;

		// If World Event is not active, prevent using event dependant items
		if (proto->HolidayId && !IsHolidayActive((HolidayIds)proto->HolidayId))
			return EQUIP_ERR_CANT_DO_RIGHT_NOW;

		return EQUIP_ERR_OK;
	}

	return EQUIP_ERR_ITEM_NOT_FOUND;
}

InventoryResult Player::CanRollForItemInLFG(ItemTemplate const* proto, WorldObject const* lootedObject) const
{
	if (!GetGroup() || !GetGroup()->isLFGGroup())
		return EQUIP_ERR_OK;    // not in LFG group

	// check if looted object is inside the lfg dungeon
	Map const* map = lootedObject->GetMap();
	if (!sLFGMgr->inLfgDungeonMap(GetGroup()->GetGUID(), map->GetId(), map->GetDifficulty()))
		return EQUIP_ERR_OK;

	if (!proto)
		return EQUIP_ERR_ITEM_NOT_FOUND;
	// Used by group, function NeedBeforeGreed, to know if a prototype can be used by a player

	const static uint32 item_weapon_skills[MAX_ITEM_SUBCLASS_WEAPON] =
	{
		SKILL_AXES,     SKILL_2H_AXES,  SKILL_BOWS,          SKILL_GUNS,      SKILL_MACES,
		SKILL_2H_MACES, SKILL_POLEARMS, SKILL_SWORDS,        SKILL_2H_SWORDS, 0,
		SKILL_STAVES,   0,              0,                   SKILL_FIST_WEAPONS,   0,
		SKILL_DAGGERS,  SKILL_THROWN,   SKILL_ASSASSINATION, SKILL_CROSSBOWS, SKILL_WANDS,
		SKILL_FISHING
	}; //Copy from function Item::GetSkill()

	if ((proto->AllowableClass & getClassMask()) == 0 || (proto->AllowableRace & getRaceMask()) == 0)
		return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;

	if (proto->RequiredSpell != 0 && !HasSpell(proto->RequiredSpell))
		return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;

	if (proto->RequiredSkill != 0)
	{
		if (!GetSkillValue(proto->RequiredSkill))
			return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
		else if (GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
			return EQUIP_ERR_CANT_EQUIP_SKILL;
	}

	uint8 _class = getClass();

	if (proto->Class == ITEM_CLASS_WEAPON && GetSkillValue(item_weapon_skills[proto->SubClass]) == 0)
		return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;

	if (proto->Class == ITEM_CLASS_ARMOR && proto->SubClass > ITEM_SUBCLASS_ARMOR_MISC && proto->SubClass < ITEM_SUBCLASS_ARMOR_BUCKLER && proto->InventoryType != INVTYPE_CLOAK)
	{
		if (_class == CLASS_WARRIOR || _class == CLASS_PALADIN || _class == CLASS_DEATH_KNIGHT)
		{
			if (getLevel() < 40)
			{
				if (proto->SubClass != ITEM_SUBCLASS_ARMOR_MAIL)
					return EQUIP_ERR_CANT_DO_RIGHT_NOW;
			}
			else if (proto->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
				return EQUIP_ERR_CANT_DO_RIGHT_NOW;
		}
		else if (_class == CLASS_HUNTER || _class == CLASS_SHAMAN)
		{
			if (getLevel() < 40)
			{
				if (proto->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER)
					return EQUIP_ERR_CANT_DO_RIGHT_NOW;
			}
			else if (proto->SubClass != ITEM_SUBCLASS_ARMOR_MAIL)
				return EQUIP_ERR_CANT_DO_RIGHT_NOW;
		}

		if (_class == CLASS_ROGUE || _class == CLASS_DRUID)
			if (proto->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER)
				return EQUIP_ERR_CANT_DO_RIGHT_NOW;

		if (_class == CLASS_MAGE || _class == CLASS_PRIEST || _class == CLASS_WARLOCK)
			if (proto->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH)
				return EQUIP_ERR_CANT_DO_RIGHT_NOW;
	}

	return EQUIP_ERR_OK;
}

InventoryResult Player::CanUseAmmo(uint32 item) const
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: CanUseAmmo item = %u", item);
	if (!IsAlive())
		return EQUIP_ERR_YOU_ARE_DEAD;
	//if (isStunned())
	//    return EQUIP_ERR_YOU_ARE_STUNNED;
	ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
	if (pProto)
	{
		if (pProto->InventoryType != INVTYPE_AMMO)
			return EQUIP_ERR_ONLY_AMMO_CAN_GO_HERE;

		InventoryResult res = CanUseItem(pProto);
		if (res != EQUIP_ERR_OK)
			return res;

		/*if (GetReputationMgr().GetReputation() < pProto->RequiredReputation)
		return EQUIP_ERR_CANT_EQUIP_REPUTATION;
		*/

		// Requires No Ammo
		if (HasAura(46699))
			return EQUIP_ERR_BAG_FULL6;

		return EQUIP_ERR_OK;
	}
	return EQUIP_ERR_ITEM_NOT_FOUND;
}

void Player::SetAmmo(uint32 item)
{
	if (!item)
		return;

	// already set
	if (GetUInt32Value(PLAYER_AMMO_ID) == item)
		return;

	// check ammo
	if (item)
	{
		InventoryResult msg = CanUseAmmo(item);
		if (msg != EQUIP_ERR_OK)
		{
			SendEquipError(msg, NULL, NULL, item);
			return;
		}
	}

	SetUInt32Value(PLAYER_AMMO_ID, item);

	_ApplyAmmoBonuses();
}

void Player::RemoveAmmo()
{
	SetUInt32Value(PLAYER_AMMO_ID, 0);

	m_ammoDPS = 0.0f;

	if (CanModifyStats())
		UpdateDamagePhysical(RANGED_ATTACK);
}

Item* Player::StoreNewItem(ItemPosCountVec const& dest, uint32 item, bool update, int32 randomPropertyId)
{
	AllowedLooterSet allowedLooters;
	return StoreNewItem(dest, item, update, randomPropertyId, allowedLooters);
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::StoreNewItem(ItemPosCountVec const& dest, uint32 item, bool update, int32 randomPropertyId, AllowedLooterSet& allowedLooters)
{
	uint32 count = 0;
	for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end(); ++itr)
		count += itr->count;

	Item* pItem = Item::CreateItem(item, count, this);
	if (pItem)
	{
		// pussywizard: obtaining blue or better items saves to db
		if (ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item))
			if (pProto->Quality >= ITEM_QUALITY_RARE)
				AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD);

		ItemAddedQuestCheck(item, count);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, item, count);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM, item, count);
		if (randomPropertyId)
			pItem->SetItemRandomProperties(randomPropertyId);
		pItem = StoreItem(dest, pItem, update);


		if (allowedLooters.size() > 1 && pItem->GetTemplate()->GetMaxStackSize() == 1 && pItem->IsSoulBound())
		{
			pItem->SetSoulboundTradeable(allowedLooters);
			pItem->SetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME, GetTotalPlayedTime());
			AddTradeableItem(pItem);

			// save data
			std::ostringstream ss;
			AllowedLooterSet::const_iterator itr = allowedLooters.begin();
			ss << *itr;
			for (++itr; itr != allowedLooters.end(); ++itr)
				ss << ' ' << *itr;

			PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEM_BOP_TRADE);
			stmt->setUInt32(0, pItem->GetGUIDLow());
			stmt->setString(1, ss.str());
			CharacterDatabase.Execute(stmt);
		}
	}
	return pItem;
}

Item* Player::StoreItem(ItemPosCountVec const& dest, Item* pItem, bool update)
{
	if (!pItem)
		return NULL;

	Item* lastItem = pItem;
	const ItemTemplate *proto = pItem->GetTemplate();

	for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end();)
	{
		uint16 pos = itr->pos;
		uint32 count = itr->count;

		++itr;

		if (itr == dest.end())
		{
			lastItem = _StoreItem(pos, pItem, count, false, update);
			break;
		}

		lastItem = _StoreItem(pos, pItem, count, true, update);
	}

	// cast after item storing - some checks in checkcast requires item to be present!!
	if (lastItem)
		for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
			if (proto->Spells[i].SpellTrigger == ITEM_SPELLTRIGGER_ON_NO_DELAY_USE && proto->Spells[i].SpellId > 0) // On obtain trigger
				if (!HasAura(proto->Spells[i].SpellId))
					CastSpell(this, proto->Spells[i].SpellId, true, lastItem);

	return lastItem;
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::_StoreItem(uint16 pos, Item* pItem, uint32 count, bool clone, bool update)
{
	if (!pItem)
		return NULL;

	uint8 bag = pos >> 8;
	uint8 slot = pos & 255;

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: StoreItem bag = %u, slot = %u, item = %u, count = %u, guid = %u", bag, slot, pItem->GetEntry(), count, pItem->GetGUIDLow());

	Item* pItem2 = GetItemByPos(bag, slot);

	if (!pItem2)
	{
		if (clone)
			pItem = pItem->CloneItem(count, this);
		else
			pItem->SetCount(count);

		if (!pItem)
			return NULL;

		if (pItem->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP ||
			pItem->GetTemplate()->Bonding == BIND_QUEST_ITEM ||
			(pItem->GetTemplate()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos)))
			pItem->SetBinding(true);

		Bag* pBag = (bag == INVENTORY_SLOT_BAG_0) ? NULL : GetBagByPos(bag);
		if (!pBag)
		{
			m_items[slot] = pItem;
			SetUInt64Value(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), pItem->GetGUID());
			pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, GetGUID());
			pItem->SetUInt64Value(ITEM_FIELD_OWNER, GetGUID());

			pItem->SetSlot(slot);
			pItem->SetContainer(NULL);

			// need update known currency
			if (slot >= CURRENCYTOKEN_SLOT_START && slot < CURRENCYTOKEN_SLOT_END)
				AddKnownCurrency(pItem->GetEntry());
		}
		else
			pBag->StoreItem(slot, pItem, update);

		if (IsInWorld() && update)
		{
			pItem->AddToWorld();
			pItem->SendUpdateToPlayer(this);
		}

		pItem->SetState(ITEM_CHANGED, this);
		if (pBag)
			pBag->SetState(ITEM_CHANGED, this);

		AddEnchantmentDurations(pItem);
		AddItemDurations(pItem);

		return pItem;
	}
	else
	{
		if (pItem2->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP ||
			pItem2->GetTemplate()->Bonding == BIND_QUEST_ITEM ||
			(pItem2->GetTemplate()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos)))
			pItem2->SetBinding(true);

		pItem2->SetCount(pItem2->GetCount() + count);
		if (IsInWorld() && update)
			pItem2->SendUpdateToPlayer(this);

		if (!clone)
		{
			// delete item (it not in any slot currently)
			if (IsInWorld() && update)
			{
				pItem->RemoveFromWorld();
				pItem->DestroyForPlayer(this);
			}

			RemoveEnchantmentDurations(pItem);
			RemoveItemDurations(pItem);

			pItem->SetOwnerGUID(GetGUID());                 // prevent error at next SetState in case trade/mail/buy from vendor
			pItem->SetNotRefundable(this);
			pItem->ClearSoulboundTradeable(this);
			RemoveTradeableItem(pItem);
			pItem->SetState(ITEM_REMOVED, this);
		}

		AddEnchantmentDurations(pItem2);

		pItem2->SetState(ITEM_CHANGED, this);

		return pItem2;
	}
}

Item* Player::EquipNewItem(uint16 pos, uint32 item, bool update)
{
	if (Item* pItem = Item::CreateItem(item, 1, this))
	{
		// pussywizard: obtaining blue or better items saves to db
		if (ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item))
			if (pProto->Quality >= ITEM_QUALITY_RARE)
				AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD);

		ItemAddedQuestCheck(item, 1);
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, item, 1);
		return EquipItem(pos, pItem, update);
	}

	return NULL;
}

Item* Player::EquipItem(uint16 pos, Item* pItem, bool update)
{
	AddEnchantmentDurations(pItem);
	AddItemDurations(pItem);

	uint8 bag = pos >> 8;
	uint8 slot = pos & 255;

	Item* pItem2 = GetItemByPos(bag, slot);

	if (!pItem2)
	{
		VisualizeItem(slot, pItem);

		if (IsAlive())
		{
			ItemTemplate const* pProto = pItem->GetTemplate();

			// item set bonuses applied only at equip and removed at unequip, and still active for broken items
			if (pProto && pProto->ItemSet)
				AddItemsSetItem(this, pItem);

			_ApplyItemMods(pItem, slot, true);

			if (pProto && IsInCombat() && (pProto->Class == ITEM_CLASS_WEAPON || pProto->InventoryType == INVTYPE_RELIC) && m_weaponChangeTimer == 0)
			{
				uint32 cooldownSpell = getClass() == CLASS_ROGUE ? 6123 : 6119;
				SpellInfo const* spellProto = sSpellMgr->GetSpellInfo(cooldownSpell);

				if (!spellProto)
					sLog->outError("Weapon switch cooldown spell %u couldn't be found in Spell.dbc", cooldownSpell);
				else
				{
					m_weaponChangeTimer = spellProto->StartRecoveryTime;

					GetGlobalCooldownMgr().AddGlobalCooldown(spellProto, m_weaponChangeTimer);

					WorldPacket data;
					BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_INCLUDE_GCD, cooldownSpell, 0);
					GetSession()->SendPacket(&data);
				}
			}
		}

		if (IsInWorld() && update)
		{
			pItem->AddToWorld();
			pItem->SendUpdateToPlayer(this);
		}

		ApplyEquipCooldown(pItem);

		// update expertise and armor penetration - passive auras may need it

		if (slot == EQUIPMENT_SLOT_MAINHAND)
			UpdateExpertise(BASE_ATTACK);

		else if (slot == EQUIPMENT_SLOT_OFFHAND)
			UpdateExpertise(OFF_ATTACK);

		switch (slot)
		{
		case EQUIPMENT_SLOT_MAINHAND:
		case EQUIPMENT_SLOT_OFFHAND:
		case EQUIPMENT_SLOT_RANGED:
			RecalculateRating(CR_ARMOR_PENETRATION);
		default:
			break;
		}
	}
	else
	{
		pItem2->SetCount(pItem2->GetCount() + pItem->GetCount());
		if (IsInWorld() && update)
			pItem2->SendUpdateToPlayer(this);

		// delete item (it not in any slot currently)
		//pItem->DeleteFromDB();
		if (IsInWorld() && update)
		{
			pItem->RemoveFromWorld();
			pItem->DestroyForPlayer(this);
		}

		RemoveEnchantmentDurations(pItem);
		RemoveItemDurations(pItem);

		pItem->SetOwnerGUID(GetGUID());                     // prevent error at next SetState in case trade/mail/buy from vendor
		pItem->SetNotRefundable(this);
		pItem->ClearSoulboundTradeable(this);
		RemoveTradeableItem(pItem);
		pItem->SetState(ITEM_REMOVED, this);
		pItem2->SetState(ITEM_CHANGED, this);

		ApplyEquipCooldown(pItem2);

		return pItem2;
	}

	// only for full equip instead adding to stack
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM, pItem->GetEntry());
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM, pItem->GetEntry(), slot);

	sScriptMgr->OnEquip(this, pItem, bag, slot, update);
	return pItem;
}

void Player::QuickEquipItem(uint16 pos, Item* pItem)
{
	if (pItem)
	{
		AddEnchantmentDurations(pItem);
		AddItemDurations(pItem);

		uint8 slot = pos & 255;
		VisualizeItem(slot, pItem);

		if (IsInWorld())
		{
			pItem->AddToWorld();
			pItem->SendUpdateToPlayer(this);
		}

		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM, pItem->GetEntry());
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM, pItem->GetEntry(), slot);
	}
}

void Player::SetVisibleItemSlot(uint8 slot, Item* pItem)
{
	if (pItem)
	{
		SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2), pItem->GetEntry());
		SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 0, pItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
		SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 1, pItem->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT));
	}
	else
	{
		SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2), 0);
		SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 0);
	}

	sScriptMgr->OnAfterPlayerSetVisibleItemSlot(this, slot, pItem);
}

void Player::VisualizeItem(uint8 slot, Item* pItem)
{
	if (!pItem)
		return;

	// check also  BIND_WHEN_PICKED_UP and BIND_QUEST_ITEM for .additem or .additemset case by GM (not binded at adding to inventory)
	if (pItem->GetTemplate()->Bonding == BIND_WHEN_EQUIPED || pItem->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP || pItem->GetTemplate()->Bonding == BIND_QUEST_ITEM)
		pItem->SetBinding(true);

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: EquipItem slot = %u, item = %u", slot, pItem->GetEntry());

	m_items[slot] = pItem;
	SetUInt64Value(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), pItem->GetGUID());
	pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, GetGUID());
	pItem->SetUInt64Value(ITEM_FIELD_OWNER, GetGUID());
	pItem->SetSlot(slot);
	pItem->SetContainer(NULL);

	if (slot < EQUIPMENT_SLOT_END)
		SetVisibleItemSlot(slot, pItem);

	pItem->SetState(ITEM_CHANGED, this);
}

void Player::RemoveItem(uint8 bag, uint8 slot, bool update, bool swap)
{
	// note: removeitem does not actually change the item
	// it only takes the item out of storage temporarily
	// note2: if removeitem is to be used for delinking
	// the item must be removed from the player's updatequeue

	Item* pItem = GetItemByPos(bag, slot);
	if (pItem)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: RemoveItem bag = %u, slot = %u, item = %u", bag, slot, pItem->GetEntry());

		RemoveEnchantmentDurations(pItem);
		RemoveItemDurations(pItem);
		RemoveTradeableItem(pItem);

		if (bag == INVENTORY_SLOT_BAG_0)
		{
			if (slot < INVENTORY_SLOT_BAG_END)
			{
				ItemTemplate const* pProto = pItem->GetTemplate();
				// item set bonuses applied only at equip and removed at unequip, and still active for broken items

				if (pProto && pProto->ItemSet)
					RemoveItemsSetItem(this, pProto);

				_ApplyItemMods(pItem, slot, false);

				// remove item dependent auras and casts (only weapon and armor slots)
				if (slot < EQUIPMENT_SLOT_END)
				{
					// Xinef: Ensure that this function is called for places with swap=true
					if (!swap)
						RemoveItemDependentAurasAndCasts(pItem);

					// remove held enchantments, update expertise
					if (slot == EQUIPMENT_SLOT_MAINHAND)
					{
						if (pItem->GetItemSuffixFactor())
						{
							pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_3);
							pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_4);
						}
						else
						{
							pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_0);
							pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_1);
						}

						UpdateExpertise(BASE_ATTACK);
					}
					else if (slot == EQUIPMENT_SLOT_OFFHAND)
						UpdateExpertise(OFF_ATTACK);
					// update armor penetration - passive auras may need it
					switch (slot)
					{
					case EQUIPMENT_SLOT_MAINHAND:
					case EQUIPMENT_SLOT_OFFHAND:
					case EQUIPMENT_SLOT_RANGED:
						RecalculateRating(CR_ARMOR_PENETRATION);
					default:
						break;
					}
				}
			}

			m_items[slot] = NULL;
			SetUInt64Value(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), 0);

			if (slot < EQUIPMENT_SLOT_END)
				SetVisibleItemSlot(slot, NULL);
		}
		else if (Bag* pBag = GetBagByPos(bag))
			pBag->RemoveItem(slot, update);

		pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
		// pItem->SetUInt64Value(ITEM_FIELD_OWNER, 0); not clear owner at remove (it will be set at store). This used in mail and auction code
		pItem->SetSlot(NULL_SLOT);
		if (IsInWorld() && update)
			pItem->SendUpdateToPlayer(this);
	}
}

// Common operation need to remove item from inventory without delete in trade, auction, guild bank, mail....
void Player::MoveItemFromInventory(uint8 bag, uint8 slot, bool update)
{
	if (Item* it = GetItemByPos(bag, slot))
	{
		ItemRemovedQuestCheck(it->GetEntry(), it->GetCount());
		RemoveItem(bag, slot, update);
		UpdateTitansGrip();
		it->SetNotRefundable(this, false);
		it->RemoveFromUpdateQueueOf(this);
		if (it->IsInWorld())
		{
			it->RemoveFromWorld();
			it->DestroyForPlayer(this);
		}

		sScriptMgr->OnAfterPlayerMoveItemFromInventory(this, it, bag, slot, update);
	}
}

// Common operation need to add item from inventory without delete in trade, guild bank, mail....
void Player::MoveItemToInventory(ItemPosCountVec const& dest, Item* pItem, bool update, bool in_characterInventoryDB)
{
	// update quest counters
	ItemAddedQuestCheck(pItem->GetEntry(), pItem->GetCount());
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, pItem->GetEntry(), pItem->GetCount());

	// store item
	Item* pLastItem = StoreItem(dest, pItem, update);

	// only set if not merged to existed stack (pItem can be deleted already but we can compare pointers any way)
	if (pLastItem == pItem)
	{
		// update owner for last item (this can be original item with wrong owner
		if (pLastItem->GetOwnerGUID() != GetGUID())
			pLastItem->SetOwnerGUID(GetGUID());

		// if this original item then it need create record in inventory
		// in case trade we already have item in other player inventory
		pLastItem->SetState(in_characterInventoryDB ? ITEM_CHANGED : ITEM_NEW, this);

		if (pLastItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_BOP_TRADEABLE))
			AddTradeableItem(pLastItem);
	}
}

void Player::DestroyItem(uint8 bag, uint8 slot, bool update)
{
	Item* pItem = GetItemByPos(bag, slot);
	if (pItem)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: DestroyItem bag = %u, slot = %u, item = %u", bag, slot, pItem->GetEntry());
		// Also remove all contained items if the item is a bag.
		// This if () prevents item saving crashes if the condition for a bag to be empty before being destroyed was bypassed somehow.
		if (pItem->IsNotEmptyBag())
			for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
				DestroyItem(slot, i, update);

		if (pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_WRAPPED))
		{
			PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GIFT);

			stmt->setUInt32(0, pItem->GetGUIDLow());

			CharacterDatabase.Execute(stmt);
		}

		RemoveEnchantmentDurations(pItem);
		RemoveItemDurations(pItem);

		pItem->SetNotRefundable(this);
		pItem->ClearSoulboundTradeable(this);
		RemoveTradeableItem(pItem);

		const ItemTemplate* proto = pItem->GetTemplate();
		for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
			if (proto->Spells[i].SpellTrigger == ITEM_SPELLTRIGGER_ON_NO_DELAY_USE && proto->Spells[i].SpellId > 0) // On obtain trigger
				RemoveAurasDueToSpell(proto->Spells[i].SpellId);

		ItemRemovedQuestCheck(pItem->GetEntry(), pItem->GetCount());

		if (bag == INVENTORY_SLOT_BAG_0)
		{
			SetUInt64Value(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), 0);

			// equipment and equipped bags can have applied bonuses
			if (slot < INVENTORY_SLOT_BAG_END)
			{
				ItemTemplate const* pProto = pItem->GetTemplate();

				// item set bonuses applied only at equip and removed at unequip, and still active for broken items
				if (pProto && pProto->ItemSet)
					RemoveItemsSetItem(this, pProto);

				_ApplyItemMods(pItem, slot, false);
			}

			if (slot < EQUIPMENT_SLOT_END)
			{
				// remove item dependent auras and casts (only weapon and armor slots)
				RemoveItemDependentAurasAndCasts(pItem);

				// update expertise and armor penetration - passive auras may need it
				switch (slot)
				{
				case EQUIPMENT_SLOT_MAINHAND:
				case EQUIPMENT_SLOT_OFFHAND:
				case EQUIPMENT_SLOT_RANGED:
					RecalculateRating(CR_ARMOR_PENETRATION);
				default:
					break;
				}

				if (slot == EQUIPMENT_SLOT_MAINHAND)
					UpdateExpertise(BASE_ATTACK);
				else if (slot == EQUIPMENT_SLOT_OFFHAND)
					UpdateExpertise(OFF_ATTACK);

				// equipment visual show
				SetVisibleItemSlot(slot, NULL);
			}

			m_items[slot] = NULL;
		}
		else if (Bag* pBag = GetBagByPos(bag))
			pBag->RemoveItem(slot, update);

		// Xinef: item is removed, remove loot from storage if any
		if (proto->Flags & ITEM_PROTO_FLAG_OPENABLE)
			sLootItemStorage->RemoveStoredLoot(pItem->GetGUIDLow());

		if (IsInWorld() && update)
		{
			pItem->RemoveFromWorld();
			pItem->DestroyForPlayer(this);
		}

		//pItem->SetOwnerGUID(0);
		pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
		pItem->SetSlot(NULL_SLOT);
		pItem->SetState(ITEM_REMOVED, this);
	}
}

void Player::DestroyItemCount(uint32 itemEntry, uint32 count, bool update, bool unequip_check)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: DestroyItemCount item = %u, count = %u", itemEntry, count);
	uint32 remcount = 0;

	// in inventory
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
	{
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		{
			if (item->GetEntry() == itemEntry && !item->IsInTrade())
			{
				if (item->GetCount() + remcount <= count)
				{
					// all items in inventory can unequipped
					remcount += item->GetCount();
					DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

					if (remcount >= count)
						return;
				}
				else
				{
					ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
					item->SetCount(item->GetCount() - count + remcount);
					if (IsInWorld() && update)
						item->SendUpdateToPlayer(this);
					item->SetState(ITEM_CHANGED, this);
					return;
				}
			}
		}
	}

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
	{
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		{
			if (item->GetEntry() == itemEntry && !item->IsInTrade())
			{
				if (item->GetCount() + remcount <= count)
				{
					// all keys can be unequipped
					remcount += item->GetCount();
					DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

					if (remcount >= count)
						return;
				}
				else
				{
					ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
					item->SetCount(item->GetCount() - count + remcount);
					if (IsInWorld() && update)
						item->SendUpdateToPlayer(this);
					item->SetState(ITEM_CHANGED, this);
					return;
				}
			}
		}
	}

	// in inventory bags
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
	{
		if (Bag* bag = GetBagByPos(i))
		{
			for (uint32 j = 0; j < bag->GetBagSize(); j++)
			{
				if (Item* item = bag->GetItemByPos(j))
				{
					if (item->GetEntry() == itemEntry && !item->IsInTrade())
					{
						// all items in bags can be unequipped
						if (item->GetCount() + remcount <= count)
						{
							remcount += item->GetCount();
							DestroyItem(i, j, update);

							if (remcount >= count)
								return;
						}
						else
						{
							ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
							item->SetCount(item->GetCount() - count + remcount);
							if (IsInWorld() && update)
								item->SendUpdateToPlayer(this);
							item->SetState(ITEM_CHANGED, this);
							return;
						}
					}
				}
			}
		}
	}

	// in equipment and bag list
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
	{
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		{
			if (item && item->GetEntry() == itemEntry && !item->IsInTrade())
			{
				if (item->GetCount() + remcount <= count)
				{
					if (!unequip_check || CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i, false) == EQUIP_ERR_OK)
					{
						remcount += item->GetCount();
						DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

						if (remcount >= count)
							return;
					}
				}
				else
				{
					ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
					item->SetCount(item->GetCount() - count + remcount);
					if (IsInWorld() && update)
						item->SendUpdateToPlayer(this);
					item->SetState(ITEM_CHANGED, this);
					return;
				}
			}
		}
	}

	// in bank
	for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
	{
		if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		{
			if (item->GetEntry() == itemEntry && !item->IsInTrade())
			{
				if (item->GetCount() + remcount <= count)
				{
					remcount += item->GetCount();
					DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
					if (remcount >= count)
						return;
				}
				else
				{
					ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
					item->SetCount(item->GetCount() - count + remcount);
					if (IsInWorld() && update)
						item->SendUpdateToPlayer(this);
					item->SetState(ITEM_CHANGED, this);
					return;
				}
			}
		}
	}

	// in bank bags
	for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
	{
		if (Bag* bag = GetBagByPos(i))
		{
			for (uint32 j = 0; j < bag->GetBagSize(); j++)
			{
				if (Item* item = bag->GetItemByPos(j))
				{
					if (item->GetEntry() == itemEntry && !item->IsInTrade())
					{
						// all items in bags can be unequipped
						if (item->GetCount() + remcount <= count)
						{
							remcount += item->GetCount();
							DestroyItem(i, j, update);

							if (remcount >= count)
								return;
						}
						else
						{
							ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
							item->SetCount(item->GetCount() - count + remcount);
							if (IsInWorld() && update)
								item->SendUpdateToPlayer(this);
							item->SetState(ITEM_CHANGED, this);
							return;
						}
					}
				}
			}
		}
	}
}

void Player::DestroyZoneLimitedItem(bool update, uint32 new_zone)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: DestroyZoneLimitedItem in map %u and area %u", GetMapId(), new_zone);

	// in inventory
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
				DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
				DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

	// in inventory bags
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); j++)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
						DestroyItem(i, j, update);

	// in equipment and bag list
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
				DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
}

void Player::DestroyConjuredItems(bool update)
{
	// used when entering arena
	// destroys all conjured items
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: DestroyConjuredItems");

	// in inventory
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->IsConjuredConsumable())
				DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

	// in inventory bags
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); j++)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (pItem->IsConjuredConsumable())
						DestroyItem(i, j, update);

	// in equipment and bag list
	for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->IsConjuredConsumable())
				DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
}

Item* Player::GetItemByEntry(uint32 entry) const
{
	// in inventory
	for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == entry)
				return pItem;

	for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == entry)
				return pItem;

	for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (pItem->GetEntry() == entry)
						return pItem;

	for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (pItem->GetEntry() == entry)
				return pItem;

	return NULL;
}

void Player::DestroyItemCount(Item* pItem, uint32 &count, bool update)
{
	if (!pItem)
		return;

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: DestroyItemCount item (GUID: %u, Entry: %u) count = %u", pItem->GetGUIDLow(), pItem->GetEntry(), count);

	if (pItem->GetCount() <= count)
	{
		count -= pItem->GetCount();

		DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), update);
	}
	else
	{
		ItemRemovedQuestCheck(pItem->GetEntry(), count);
		pItem->SetCount(pItem->GetCount() - count);
		count = 0;
		if (IsInWorld() && update)
			pItem->SendUpdateToPlayer(this);
		pItem->SetState(ITEM_CHANGED, this);
	}
}

void Player::SplitItem(uint16 src, uint16 dst, uint32 count)
{
	uint8 srcbag = src >> 8;
	uint8 srcslot = src & 255;

	uint8 dstbag = dst >> 8;
	uint8 dstslot = dst & 255;

	Item* pSrcItem = GetItemByPos(srcbag, srcslot);
	if (!pSrcItem)
	{
		SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, NULL);
		return;
	}

	if (pSrcItem->m_lootGenerated)                           // prevent split looting item (item
	{
		//best error message found for attempting to split while looting
		SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, NULL);
		return;
	}

	// not let split all items (can be only at cheating)
	if (pSrcItem->GetCount() == count)
	{
		SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, NULL);
		return;
	}

	// not let split more existed items (can be only at cheating)
	if (pSrcItem->GetCount() < count)
	{
		SendEquipError(EQUIP_ERR_TRIED_TO_SPLIT_MORE_THAN_COUNT, pSrcItem, NULL);
		return;
	}

	//! If trading
	if (TradeData* tradeData = GetTradeData())
	{
		//! If current item is in trade window (only possible with packet spoofing - silent return)
		if (tradeData->GetTradeSlotForItem(pSrcItem->GetGUID()) != TRADE_SLOT_INVALID)
			return;
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: SplitItem bag = %u, slot = %u, item = %u, count = %u", dstbag, dstslot, pSrcItem->GetEntry(), count);
	Item* pNewItem = pSrcItem->CloneItem(count, this);
	if (!pNewItem)
	{
		SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, NULL);
		return;
	}

	if (IsInventoryPos(dst))
	{
		// change item amount before check (for unique max count check)
		pSrcItem->SetCount(pSrcItem->GetCount() - count);

		ItemPosCountVec dest;
		InventoryResult msg = CanStoreItem(dstbag, dstslot, dest, pNewItem, false);
		if (msg != EQUIP_ERR_OK)
		{
			delete pNewItem;
			pSrcItem->SetCount(pSrcItem->GetCount() + count);
			SendEquipError(msg, pSrcItem, NULL);
			return;
		}

		if (IsInWorld())
			pSrcItem->SendUpdateToPlayer(this);
		pSrcItem->SetState(ITEM_CHANGED, this);
		StoreItem(dest, pNewItem, true);
	}
	else if (IsBankPos(dst))
	{
		// change item amount before check (for unique max count check)
		pSrcItem->SetCount(pSrcItem->GetCount() - count);

		ItemPosCountVec dest;
		InventoryResult msg = CanBankItem(dstbag, dstslot, dest, pNewItem, false);
		if (msg != EQUIP_ERR_OK)
		{
			delete pNewItem;
			pSrcItem->SetCount(pSrcItem->GetCount() + count);
			SendEquipError(msg, pSrcItem, NULL);
			return;
		}

		if (IsInWorld())
			pSrcItem->SendUpdateToPlayer(this);
		pSrcItem->SetState(ITEM_CHANGED, this);
		BankItem(dest, pNewItem, true);
	}
	else if (IsEquipmentPos(dst))
	{
		// change item amount before check (for unique max count check), provide space for splitted items
		pSrcItem->SetCount(pSrcItem->GetCount() - count);

		uint16 dest;
		InventoryResult msg = CanEquipItem(dstslot, dest, pNewItem, false);
		if (msg != EQUIP_ERR_OK)
		{
			delete pNewItem;
			pSrcItem->SetCount(pSrcItem->GetCount() + count);
			SendEquipError(msg, pSrcItem, NULL);
			return;
		}

		if (IsInWorld())
			pSrcItem->SendUpdateToPlayer(this);
		pSrcItem->SetState(ITEM_CHANGED, this);
		EquipItem(dest, pNewItem, true);
		AutoUnequipOffhandIfNeed();
	}
}

void Player::SwapItem(uint16 src, uint16 dst)
{
	uint8 srcbag = src >> 8;
	uint8 srcslot = src & 255;

	uint8 dstbag = dst >> 8;
	uint8 dstslot = dst & 255;

	Item* pSrcItem = GetItemByPos(srcbag, srcslot);
	Item* pDstItem = GetItemByPos(dstbag, dstslot);

	if (!pSrcItem)
		return;

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: SwapItem bag = %u, slot = %u, item = %u", dstbag, dstslot, pSrcItem->GetEntry());

	if (!IsAlive())
	{
		SendEquipError(EQUIP_ERR_YOU_ARE_DEAD, pSrcItem, pDstItem);
		return;
	}

	// SRC checks

	if (GetLootGUID() == pSrcItem->GetGUID())                           // prevent swap looting item
	{
		//best error message found for attempting to swap while looting
		SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pSrcItem, NULL);
		return;
	}

	// check unequip potability for equipped items and bank bags
	if (IsEquipmentPos(src) || IsBagPos(src))
	{
		// bags can be swapped with empty bag slots, or with empty bag (items move possibility checked later)
		InventoryResult msg = CanUnequipItem(src, !IsBagPos(src) || IsBagPos(dst) || (pDstItem && pDstItem->ToBag() && pDstItem->ToBag()->IsEmpty()));
		if (msg != EQUIP_ERR_OK)
		{
			SendEquipError(msg, pSrcItem, pDstItem);
			return;
		}
	}

	// anti-wpe
	if (pSrcItem->IsBag() && pSrcItem->IsNotEmptyBag() && !IsBagPos(dst))
	{
		SendEquipError(EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS, pSrcItem, pDstItem);
		return;
	}

	// prevent put equipped/bank bag in self
	if (IsBagPos(src) && srcslot == dstbag)
	{
		SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
		return;
	}

	// prevent equipping bag in the same slot from its inside
	if (IsBagPos(dst) && srcbag == dstslot)
	{
		SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
		return;
	}

	// DST checks

	if (pDstItem)
	{
		// Xinef: Removed next bullshit loot generated check
		if (pDstItem->GetGUID() == GetLootGUID())                       // prevent swap looting item
		{
			//best error message found for attempting to swap while looting
			SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pDstItem, NULL);
			return;
		}

		// check unequip potability for equipped items and bank bags
		if (IsEquipmentPos(dst) || IsBagPos(dst))
		{
			// bags can be swapped with empty bag slots, or with empty bag (items move possibility checked later)
			InventoryResult msg = CanUnequipItem(dst, !IsBagPos(dst) || IsBagPos(src) || (pSrcItem->ToBag() && pSrcItem->ToBag()->IsEmpty()));
			if (msg != EQUIP_ERR_OK)
			{
				SendEquipError(msg, pSrcItem, pDstItem);
				return;
			}
		}
	}

	// NOW this is or item move (swap with empty), or swap with another item (including bags in bag possitions)
	// or swap empty bag with another empty or not empty bag (with items exchange)

	// Move case
	if (!pDstItem)
	{
		if (IsInventoryPos(dst))
		{
			ItemPosCountVec dest;
			InventoryResult msg = CanStoreItem(dstbag, dstslot, dest, pSrcItem, false);
			if (msg != EQUIP_ERR_OK)
			{
				SendEquipError(msg, pSrcItem, NULL);
				return;
			}

			RemoveItem(srcbag, srcslot, true);
			StoreItem(dest, pSrcItem, true);
			UpdateTitansGrip();
			if (IsBankPos(src))
				ItemAddedQuestCheck(pSrcItem->GetEntry(), pSrcItem->GetCount());
		}
		else if (IsBankPos(dst))
		{
			ItemPosCountVec dest;
			InventoryResult msg = CanBankItem(dstbag, dstslot, dest, pSrcItem, false);
			if (msg != EQUIP_ERR_OK)
			{
				SendEquipError(msg, pSrcItem, NULL);
				return;
			}

			RemoveItem(srcbag, srcslot, true);
			BankItem(dest, pSrcItem, true);
			UpdateTitansGrip();
			ItemRemovedQuestCheck(pSrcItem->GetEntry(), pSrcItem->GetCount());
		}
		else if (IsEquipmentPos(dst))
		{
			uint16 dest;
			InventoryResult msg = CanEquipItem(dstslot, dest, pSrcItem, false);
			if (msg != EQUIP_ERR_OK)
			{
				SendEquipError(msg, pSrcItem, NULL);
				return;
			}

			RemoveItem(srcbag, srcslot, true);
			EquipItem(dest, pSrcItem, true);
			AutoUnequipOffhandIfNeed();
		}

		return;
	}

	// attempt merge to / fill target item
	if (!pSrcItem->IsBag() && !pDstItem->IsBag())
	{
		InventoryResult msg;
		ItemPosCountVec sDest;
		uint16 eDest = 0;
		if (IsInventoryPos(dst))
			msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, false);
		else if (IsBankPos(dst))
			msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, false);
		else if (IsEquipmentPos(dst))
			msg = CanEquipItem(dstslot, eDest, pSrcItem, false);
		else
			return;

		// can be merge/fill
		if (msg == EQUIP_ERR_OK)
		{
			if (pSrcItem->GetCount() + pDstItem->GetCount() <= pSrcItem->GetTemplate()->GetMaxStackSize())
			{
				RemoveItem(srcbag, srcslot, true);

				if (IsInventoryPos(dst))
					StoreItem(sDest, pSrcItem, true);
				else if (IsBankPos(dst))
					BankItem(sDest, pSrcItem, true);
				else if (IsEquipmentPos(dst))
				{
					EquipItem(eDest, pSrcItem, true);
					AutoUnequipOffhandIfNeed();
				}
			}
			else
			{
				pSrcItem->SetCount(pSrcItem->GetCount() + pDstItem->GetCount() - pSrcItem->GetTemplate()->GetMaxStackSize());
				pDstItem->SetCount(pSrcItem->GetTemplate()->GetMaxStackSize());
				pSrcItem->SetState(ITEM_CHANGED, this);
				pDstItem->SetState(ITEM_CHANGED, this);
				if (IsInWorld())
				{
					pSrcItem->SendUpdateToPlayer(this);
					pDstItem->SendUpdateToPlayer(this);
				}
			}
			SendRefundInfo(pDstItem);
			return;
		}
	}

	// impossible merge/fill, do real swap
	InventoryResult msg = EQUIP_ERR_OK;

	// check src->dest move possibility
	ItemPosCountVec sDest;
	uint16 eDest = 0;
	if (IsInventoryPos(dst))
		msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, true);
	else if (IsBankPos(dst))
		msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, true);
	else if (IsEquipmentPos(dst))
	{
		msg = CanEquipItem(dstslot, eDest, pSrcItem, true);
		if (msg == EQUIP_ERR_OK)
			msg = CanUnequipItem(eDest, true);
	}

	if (msg != EQUIP_ERR_OK)
	{
		SendEquipError(msg, pSrcItem, pDstItem);
		return;
	}

	// check dest->src move possibility
	ItemPosCountVec sDest2;
	uint16 eDest2 = 0;
	if (IsInventoryPos(src))
		msg = CanStoreItem(srcbag, srcslot, sDest2, pDstItem, true);
	else if (IsBankPos(src))
		msg = CanBankItem(srcbag, srcslot, sDest2, pDstItem, true);
	else if (IsEquipmentPos(src))
	{
		msg = CanEquipItem(srcslot, eDest2, pDstItem, true);
		if (msg == EQUIP_ERR_OK)
			msg = CanUnequipItem(eDest2, true);
	}

	if (msg != EQUIP_ERR_OK)
	{
		SendEquipError(msg, pDstItem, pSrcItem);
		return;
	}

	// Check bag swap with item exchange (one from empty in not bag possition (equipped (not possible in fact) or store)
	if (Bag* srcBag = pSrcItem->ToBag())
	{
		if (Bag* dstBag = pDstItem->ToBag())
		{
			Bag* emptyBag = NULL;
			Bag* fullBag = NULL;
			if (srcBag->IsEmpty() && !IsBagPos(src))
			{
				emptyBag = srcBag;
				fullBag = dstBag;
			}
			else if (dstBag->IsEmpty() && !IsBagPos(dst))
			{
				emptyBag = dstBag;
				fullBag = srcBag;
			}

			// bag swap (with items exchange) case
			if (emptyBag && fullBag)
			{
				ItemTemplate const* emptyProto = emptyBag->GetTemplate();

				uint32 count = 0;

				for (uint32 i = 0; i < fullBag->GetBagSize(); ++i)
				{
					Item* bagItem = fullBag->GetItemByPos(i);
					if (!bagItem)
						continue;

					ItemTemplate const* bagItemProto = bagItem->GetTemplate();
					if (!bagItemProto || !ItemCanGoIntoBag(bagItemProto, emptyProto))
					{
						// one from items not go to empty target bag
						SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
						return;
					}

					++count;
				}

				if (count > emptyBag->GetBagSize())
				{
					// too small targeted bag
					SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
					return;
				}

				// Items swap
				count = 0;                                      // will pos in new bag
				for (uint32 i = 0; i < fullBag->GetBagSize(); ++i)
				{
					Item* bagItem = fullBag->GetItemByPos(i);
					if (!bagItem)
						continue;

					fullBag->RemoveItem(i, true);
					emptyBag->StoreItem(count, bagItem, true);
					bagItem->SetState(ITEM_CHANGED, this);

					++count;
				}
			}
		}
	}

	// now do moves, remove...
	RemoveItem(dstbag, dstslot, false, true);
	RemoveItem(srcbag, srcslot, false, true);

	// add to dest
	if (IsInventoryPos(dst))
		StoreItem(sDest, pSrcItem, true);
	else if (IsBankPos(dst))
		BankItem(sDest, pSrcItem, true);
	else if (IsEquipmentPos(dst))
		EquipItem(eDest, pSrcItem, true);

	// add to src
	if (IsInventoryPos(src))
		StoreItem(sDest2, pDstItem, true);
	else if (IsBankPos(src))
		BankItem(sDest2, pDstItem, true);
	else if (IsEquipmentPos(src))
		EquipItem(eDest2, pDstItem, true);

	// Xinef: Call this here after all needed items are equipped
	RemoveItemDependentAurasAndCasts((Item*)NULL);

	// if player is moving bags and is looting an item inside this bag
	// release the loot
	if (GetLootGUID())
	{
		bool released = false;
		if (IsBagPos(src))
		{
			Bag* bag = pSrcItem->ToBag();
			for (uint32 i = 0; i < bag->GetBagSize(); ++i)
			{
				if (Item* bagItem = bag->GetItemByPos(i))
				{
					// Xinef: Removed next bullshit loot generated check
					if (bagItem->GetGUID() == GetLootGUID())
					{
						m_session->DoLootRelease(GetLootGUID());
						released = true;                    // so we don't need to look at dstBag
						break;
					}
				}
			}
		}

		if (!released && IsBagPos(dst) && pDstItem)
		{
			Bag* bag = pDstItem->ToBag();
			for (uint32 i = 0; i < bag->GetBagSize(); ++i)
			{
				if (Item* bagItem = bag->GetItemByPos(i))
				{
					// Xinef: Removed next bullshit loot generated check
					if (bagItem->GetGUID() == GetLootGUID())
					{
						m_session->DoLootRelease(GetLootGUID());
						released = true;                    // not realy needed here
						break;
					}
				}
			}
		}
	}

	AutoUnequipOffhandIfNeed();
}

void Player::AddItemToBuyBackSlot(Item* pItem)
{
	if (pItem)
	{
		uint32 slot = m_currentBuybackSlot;
		// if current back slot non-empty search oldest or free
		if (m_items[slot])
		{
			uint32 oldest_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1);
			uint32 oldest_slot = BUYBACK_SLOT_START;

			for (uint32 i = BUYBACK_SLOT_START + 1; i < BUYBACK_SLOT_END; ++i)
			{
				// found empty
				if (!m_items[i])
				{
					slot = i;
					break;
				}

				uint32 i_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + i - BUYBACK_SLOT_START);

				if (oldest_time > i_time)
				{
					oldest_time = i_time;
					oldest_slot = i;
				}
			}

			// find oldest
			slot = oldest_slot;
		}

		RemoveItemFromBuyBackSlot(slot, true);
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: AddItemToBuyBackSlot item = %u, slot = %u", pItem->GetEntry(), slot);

		m_items[slot] = pItem;
		time_t base = time(NULL);
		uint32 etime = uint32(base - m_logintime + (30 * 3600));
		uint32 eslot = slot - BUYBACK_SLOT_START;

		SetUInt64Value(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + (eslot * 2), pItem->GetGUID());
		if (ItemTemplate const* proto = pItem->GetTemplate())
			SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, proto->SellPrice * pItem->GetCount());
		else
			SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
		SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, (uint32)etime);

		// move to next (for non filled list is move most optimized choice)
		if (m_currentBuybackSlot < BUYBACK_SLOT_END - 1)
			++m_currentBuybackSlot;
	}
}

Item* Player::GetItemFromBuyBackSlot(uint32 slot)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: GetItemFromBuyBackSlot slot = %u", slot);
	if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
		return m_items[slot];
	return NULL;
}

void Player::RemoveItemFromBuyBackSlot(uint32 slot, bool del)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "STORAGE: RemoveItemFromBuyBackSlot slot = %u", slot);
	if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
	{
		Item* pItem = m_items[slot];
		if (pItem)
		{
			pItem->RemoveFromWorld();
			if (del)
				pItem->SetState(ITEM_REMOVED, this);
		}

		m_items[slot] = NULL;

		uint32 eslot = slot - BUYBACK_SLOT_START;
		SetUInt64Value(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + (eslot * 2), 0);
		SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
		SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, 0);

		// if current backslot is filled set to now free slot
		if (m_items[m_currentBuybackSlot])
			m_currentBuybackSlot = slot;
	}
}

void Player::SendEquipError(InventoryResult msg, Item* pItem, Item* pItem2, uint32 itemid)
{
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_INVENTORY_CHANGE_FAILURE (%u)", msg);
	WorldPacket data(SMSG_INVENTORY_CHANGE_FAILURE, (msg == EQUIP_ERR_CANT_EQUIP_LEVEL_I ? 22 : 18));
	data << uint8(msg);

	if (msg != EQUIP_ERR_OK)
	{
		data << uint64(pItem ? pItem->GetGUID() : 0);
		data << uint64(pItem2 ? pItem2->GetGUID() : 0);
		data << uint8(0);                                   // bag type subclass, used with EQUIP_ERR_EVENT_AUTOEQUIP_BIND_CONFIRM and EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG2

		switch (msg)
		{
		case EQUIP_ERR_CANT_EQUIP_LEVEL_I:
		case EQUIP_ERR_PURCHASE_LEVEL_TOO_LOW:
		{
			ItemTemplate const* proto = pItem ? pItem->GetTemplate() : sObjectMgr->GetItemTemplate(itemid);
			data << uint32(proto ? proto->RequiredLevel : 0);
			break;
		}
		case EQUIP_ERR_EVENT_AUTOEQUIP_BIND_CONFIRM:    // no idea about this one...
		{
			data << uint64(0); // item guid
			data << uint32(0); // slot
			data << uint64(0); // container
			break;
		}
		case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED:
		case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_SOCKETED_EXCEEDED:
		case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_EQUIPPED_EXCEEDED:
		{
			ItemTemplate const* proto = pItem ? pItem->GetTemplate() : sObjectMgr->GetItemTemplate(itemid);
			data << uint32(proto ? proto->ItemLimitCategory : 0);
			break;
		}
		default:
			break;
		}
	}
	GetSession()->SendPacket(&data);
}

void Player::SendBuyError(BuyResult msg, Creature* creature, uint32 item, uint32 param)
{
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_BUY_FAILED");
	WorldPacket data(SMSG_BUY_FAILED, (8 + 4 + 4 + 1));
	data << uint64(creature ? creature->GetGUID() : 0);
	data << uint32(item);
	if (param > 0)
		data << uint32(param);
	data << uint8(msg);
	GetSession()->SendPacket(&data);
}

void Player::SendSellError(SellResult msg, Creature* creature, uint64 guid, uint32 param)
{
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_SELL_ITEM");
	WorldPacket data(SMSG_SELL_ITEM, (8 + 8 + (param ? 4 : 0) + 1));  // last check 2.0.10
	data << uint64(creature ? creature->GetGUID() : 0);
	data << uint64(guid);
	if (param > 0)
		data << uint32(param);
	data << uint8(msg);
	GetSession()->SendPacket(&data);
}

void Player::TradeCancel(bool sendback)
{
	if (m_trade)
	{
		Player* trader = m_trade->GetTrader();

		// send yellow "Trade canceled" message to both traders
		if (sendback)
			GetSession()->SendCancelTrade();

		trader->GetSession()->SendCancelTrade();

		// cleanup
		delete m_trade;
		m_trade = NULL;
		delete trader->m_trade;
		trader->m_trade = NULL;
	}
}

void Player::UpdateSoulboundTradeItems()
{
	TRINITY_GUARD(ACE_Thread_Mutex, m_soulboundTradableLock);
	if (m_itemSoulboundTradeable.empty())
		return;

	// also checks for garbage data
	for (ItemDurationList::iterator itr = m_itemSoulboundTradeable.begin(); itr != m_itemSoulboundTradeable.end();)
	{
		ASSERT(*itr);
		if ((*itr)->GetOwnerGUID() != GetGUID())
		{
			m_itemSoulboundTradeable.erase(itr++);
			continue;
		}
		if ((*itr)->CheckSoulboundTradeExpire())
		{
			m_itemSoulboundTradeable.erase(itr++);
			continue;
		}
		++itr;
	}
}

void Player::AddTradeableItem(Item* item)
{
	TRINITY_GUARD(ACE_Thread_Mutex, m_soulboundTradableLock);
	m_itemSoulboundTradeable.push_back(item);
}

//TODO: should never allow an item to be added to m_itemSoulboundTradeable twice
void Player::RemoveTradeableItem(Item* item)
{
	TRINITY_GUARD(ACE_Thread_Mutex, m_soulboundTradableLock);
	m_itemSoulboundTradeable.remove(item);
}

void Player::UpdateItemDuration(uint32 time, bool realtimeonly)
{
	if (m_itemDuration.empty())
		return;

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Player::UpdateItemDuration(%u, %u)", time, realtimeonly);

	for (ItemDurationList::const_iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end();)
	{
		Item* item = *itr;
		++itr;                                              // current element can be erased in UpdateDuration

		if (!realtimeonly || item->GetTemplate()->FlagsCu & ITEM_FLAGS_CU_DURATION_REAL_TIME)
			item->UpdateDuration(this, time);
	}
}

void Player::UpdateEnchantTime(uint32 time)
{
	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(), next; itr != m_enchantDuration.end(); itr = next)
	{
		ASSERT(itr->item);
		next = itr;
		if (!itr->item->GetEnchantmentId(itr->slot))
		{
			next = m_enchantDuration.erase(itr);
		}
		else if (itr->leftduration <= time)
		{
			ApplyEnchantment(itr->item, itr->slot, false, false);
			itr->item->ClearEnchantment(itr->slot);
			next = m_enchantDuration.erase(itr);
		}
		else if (itr->leftduration > time)
		{
			itr->leftduration -= time;
			++next;
		}
	}
}

void Player::AddEnchantmentDurations(Item* item)
{
	for (int x = 0; x < MAX_ENCHANTMENT_SLOT; ++x)
	{
		if (!item->GetEnchantmentId(EnchantmentSlot(x)))
			continue;

		uint32 duration = item->GetEnchantmentDuration(EnchantmentSlot(x));
		if (duration > 0)
			AddEnchantmentDuration(item, EnchantmentSlot(x), duration);
	}
}

void Player::RemoveEnchantmentDurations(Item* item)
{
	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end();)
	{
		if (itr->item == item)
		{
			// save duration in item
			item->SetEnchantmentDuration(EnchantmentSlot(itr->slot), itr->leftduration, this);
			itr = m_enchantDuration.erase(itr);
		}
		else
			++itr;
	}
}

void Player::RemoveEnchantmentDurationsReferences(Item* item)
{
	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end();)
	{
		if (itr->item == item)
			itr = m_enchantDuration.erase(itr);
		else
			++itr;
	}
}

void Player::RemoveArenaEnchantments(EnchantmentSlot slot)
{
	// remove enchantments from equipped items first to clean up the m_enchantDuration list
	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(), next; itr != m_enchantDuration.end(); itr = next)
	{
		next = itr;
		if (itr->slot == slot)
		{
			if (itr->item && itr->item->GetEnchantmentId(slot))
			{
				// Poisons and DK runes are enchants which are allowed on arenas
				if (sSpellMgr->IsArenaAllowedEnchancment(itr->item->GetEnchantmentId(slot)))
				{
					++next;
					continue;
				}
				// remove from stats
				ApplyEnchantment(itr->item, slot, false, false);
				// remove visual
				itr->item->ClearEnchantment(slot);
			}
			// remove from update list
			next = m_enchantDuration.erase(itr);
		}
		else
			++next;
	}

	// Xinef: check arena allowed enchantments :)
	// remove enchants from inventory items
	// NOTE: no need to remove these from stats, since these aren't equipped
	// in inventory
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
		if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (uint32 enchId = pItem->GetEnchantmentId(slot))
				if (!sSpellMgr->IsArenaAllowedEnchancment(enchId))
					pItem->ClearEnchantment(slot);

	// in inventory bags
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); j++)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (uint32 enchId = pItem->GetEnchantmentId(slot))
						if (!sSpellMgr->IsArenaAllowedEnchancment(enchId))
							pItem->ClearEnchantment(slot);
}

// duration == 0 will remove item enchant
void Player::AddEnchantmentDuration(Item* item, EnchantmentSlot slot, uint32 duration)
{
	if (!item)
		return;

	if (slot >= MAX_ENCHANTMENT_SLOT)
		return;

	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
	{
		if (itr->item == item && itr->slot == slot)
		{
			itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration, this);
			m_enchantDuration.erase(itr);
			break;
		}
	}
	if (item && duration > 0)
	{
		GetSession()->SendItemEnchantTimeUpdate(GetGUID(), item->GetGUID(), slot, uint32(duration / 1000));
		m_enchantDuration.push_back(EnchantDuration(item, slot, duration));
	}
}

void Player::ApplyEnchantment(Item* item, bool apply)
{
	for (uint32 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
		ApplyEnchantment(item, EnchantmentSlot(slot), apply);
}

void Player::ApplyEnchantment(Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
	if (!item || !item->IsEquipped())
		return;

	if (slot >= MAX_ENCHANTMENT_SLOT)
		return;

	uint32 enchant_id = item->GetEnchantmentId(slot);
	if (!enchant_id)
		return;

	SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
	if (!pEnchant)
		return;

	if (!ignore_condition && pEnchant->EnchantmentCondition && !EnchantmentFitsRequirements(pEnchant->EnchantmentCondition, -1))
		return;

	if (pEnchant->requiredLevel > getLevel())
		return;

	if (pEnchant->requiredSkill > 0 && pEnchant->requiredSkillValue > GetSkillValue(pEnchant->requiredSkill))
		return;

	// If we're dealing with a gem inside a prismatic socket we need to check the prismatic socket requirements
	// rather than the gem requirements itself. If the socket has no color it is a prismatic socket.
	if ((slot == SOCK_ENCHANTMENT_SLOT || slot == SOCK_ENCHANTMENT_SLOT_2 || slot == SOCK_ENCHANTMENT_SLOT_3)
		&& !item->GetTemplate()->Socket[slot - SOCK_ENCHANTMENT_SLOT].Color)
	{
		// Check if the requirements for the prismatic socket are met before applying the gem stats
		SpellItemEnchantmentEntry const* pPrismaticEnchant = sSpellItemEnchantmentStore.LookupEntry(item->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
		if (!pPrismaticEnchant || (pPrismaticEnchant->requiredSkill > 0 && pPrismaticEnchant->requiredSkillValue > GetSkillValue(pPrismaticEnchant->requiredSkill)))
			return;
	}

	if (!item->IsBroken())
	{
		for (int s = 0; s < MAX_ITEM_ENCHANTMENT_EFFECTS; ++s)
		{
			uint32 enchant_display_type = pEnchant->type[s];
			uint32 enchant_amount = pEnchant->amount[s];
			uint32 enchant_spell_id = pEnchant->spellid[s];

			switch (enchant_display_type)
			{
			case ITEM_ENCHANTMENT_TYPE_NONE:
				break;
			case ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL:
				// processed in Player::CastItemCombatSpell
				break;
			case ITEM_ENCHANTMENT_TYPE_DAMAGE:
				if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
					HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, float(enchant_amount), apply);
				else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
					HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, float(enchant_amount), apply);
				else if (item->GetSlot() == EQUIPMENT_SLOT_RANGED)
					HandleStatModifier(UNIT_MOD_DAMAGE_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
				break;
			case ITEM_ENCHANTMENT_TYPE_EQUIP_SPELL:
				if (enchant_spell_id)
				{
					if (apply)
					{
						int32 basepoints = 0;
						// Random Property Exist - try found basepoints for spell (basepoints depends from item suffix factor)
						if (item->GetItemRandomPropertyId())
						{
							ItemRandomSuffixEntry const* item_rand = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
							if (item_rand)
							{
								// Search enchant_amount
								for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
								{
									if (item_rand->enchant_id[k] == enchant_id)
									{
										basepoints = int32((item_rand->prefix[k] * item->GetItemSuffixFactor()) / 10000);
										break;
									}
								}
							}
						}
						// Cast custom spell vs all equal basepoints got from enchant_amount
						if (basepoints)
							CastCustomSpell(this, enchant_spell_id, &basepoints, &basepoints, &basepoints, true, item);
						else
							CastSpell(this, enchant_spell_id, true, item);
					}
					else
						RemoveAurasDueToItemSpell(enchant_spell_id, item->GetGUID());
				}
				break;
			case ITEM_ENCHANTMENT_TYPE_RESISTANCE:
				if (!enchant_amount)
				{
					ItemRandomSuffixEntry const* item_rand = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
					if (item_rand)
					{
						for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
						{
							if (item_rand->enchant_id[k] == enchant_id)
							{
								enchant_amount = uint32((item_rand->prefix[k] * item->GetItemSuffixFactor()) / 10000);
								break;
							}
						}
					}
				}

				HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + enchant_spell_id), TOTAL_VALUE, float(enchant_amount), apply);
				break;
			case ITEM_ENCHANTMENT_TYPE_STAT:
			{
				if (!enchant_amount)
				{
					ItemRandomSuffixEntry const* item_rand_suffix = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
					if (item_rand_suffix)
					{
						for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
						{
							if (item_rand_suffix->enchant_id[k] == enchant_id)
							{
								enchant_amount = uint32((item_rand_suffix->prefix[k] * item->GetItemSuffixFactor()) / 10000);
								break;
							}
						}
					}
				}

				;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Adding %u to stat nb %u", enchant_amount, enchant_spell_id);
				switch (enchant_spell_id)
				{
				case ITEM_MOD_MANA:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u MANA", enchant_amount);
					HandleStatModifier(UNIT_MOD_MANA, BASE_VALUE, float(enchant_amount), apply);
					break;
				case ITEM_MOD_HEALTH:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u HEALTH", enchant_amount);
					HandleStatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(enchant_amount), apply);
					break;
				case ITEM_MOD_AGILITY:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u AGILITY", enchant_amount);
					HandleStatModifier(UNIT_MOD_STAT_AGILITY, TOTAL_VALUE, float(enchant_amount), apply);
					ApplyStatBuffMod(STAT_AGILITY, (float)enchant_amount, apply);
					break;
				case ITEM_MOD_STRENGTH:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u STRENGTH", enchant_amount);
					HandleStatModifier(UNIT_MOD_STAT_STRENGTH, TOTAL_VALUE, float(enchant_amount), apply);
					ApplyStatBuffMod(STAT_STRENGTH, (float)enchant_amount, apply);
					break;
				case ITEM_MOD_INTELLECT:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u INTELLECT", enchant_amount);
					HandleStatModifier(UNIT_MOD_STAT_INTELLECT, TOTAL_VALUE, float(enchant_amount), apply);
					ApplyStatBuffMod(STAT_INTELLECT, (float)enchant_amount, apply);
					break;
				case ITEM_MOD_SPIRIT:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SPIRIT", enchant_amount);
					HandleStatModifier(UNIT_MOD_STAT_SPIRIT, TOTAL_VALUE, float(enchant_amount), apply);
					ApplyStatBuffMod(STAT_SPIRIT, (float)enchant_amount, apply);
					break;
				case ITEM_MOD_STAMINA:
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u STAMINA", enchant_amount);
					HandleStatModifier(UNIT_MOD_STAT_STAMINA, TOTAL_VALUE, float(enchant_amount), apply);
					ApplyStatBuffMod(STAT_STAMINA, (float)enchant_amount, apply);
					break;
				case ITEM_MOD_DEFENSE_SKILL_RATING:
					ApplyRatingMod(CR_DEFENSE_SKILL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u DEFENCE", enchant_amount);
					break;
				case  ITEM_MOD_DODGE_RATING:
					ApplyRatingMod(CR_DODGE, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u DODGE", enchant_amount);
					break;
				case ITEM_MOD_PARRY_RATING:
					ApplyRatingMod(CR_PARRY, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u PARRY", enchant_amount);
					break;
				case ITEM_MOD_BLOCK_RATING:
					ApplyRatingMod(CR_BLOCK, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SHIELD_BLOCK", enchant_amount);
					break;
				case ITEM_MOD_HIT_MELEE_RATING:
					ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u MELEE_HIT", enchant_amount);
					break;
				case ITEM_MOD_HIT_RANGED_RATING:
					ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u RANGED_HIT", enchant_amount);
					break;
				case ITEM_MOD_HIT_SPELL_RATING:
					ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SPELL_HIT", enchant_amount);
					break;
				case ITEM_MOD_CRIT_MELEE_RATING:
					ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u MELEE_CRIT", enchant_amount);
					break;
				case ITEM_MOD_CRIT_RANGED_RATING:
					ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u RANGED_CRIT", enchant_amount);
					break;
				case ITEM_MOD_CRIT_SPELL_RATING:
					ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SPELL_CRIT", enchant_amount);
					break;
					//                        Values from ITEM_STAT_MELEE_HA_RATING to ITEM_MOD_HASTE_RANGED_RATING are never used
					//                        in Enchantments
					//                        case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
					//                            ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
					//                            ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
					//                            ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
					//                            ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
					//                            ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
					//                            ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_HASTE_MELEE_RATING:
					//                            ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
					//                            break;
				case ITEM_MOD_HASTE_RANGED_RATING:
					ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
					break;
				case ITEM_MOD_HASTE_SPELL_RATING:
					ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
					break;
				case ITEM_MOD_HIT_RATING:
					ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
					ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
					ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u HIT", enchant_amount);
					break;
				case ITEM_MOD_CRIT_RATING:
					ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
					ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
					ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u CRITICAL", enchant_amount);
					break;
					//                        Values ITEM_MOD_HIT_TAKEN_RATING and ITEM_MOD_CRIT_TAKEN_RATING are never used in Enchantment
					//                        case ITEM_MOD_HIT_TAKEN_RATING:
					//                            ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
					//                            ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
					//                            ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
					//                            break;
					//                        case ITEM_MOD_CRIT_TAKEN_RATING:
					//                            ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
					//                            ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
					//                            ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
					//                            break;
				case ITEM_MOD_RESILIENCE_RATING:
					ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
					ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
					ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u RESILIENCE", enchant_amount);
					break;
				case ITEM_MOD_HASTE_RATING:
					ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
					ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
					ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u HASTE", enchant_amount);
					break;
				case ITEM_MOD_EXPERTISE_RATING:
					ApplyRatingMod(CR_EXPERTISE, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u EXPERTISE", enchant_amount);
					break;
				case ITEM_MOD_ATTACK_POWER:
					HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(enchant_amount), apply);
					HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u ATTACK_POWER", enchant_amount);
					break;
				case ITEM_MOD_RANGED_ATTACK_POWER:
					HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u RANGED_ATTACK_POWER", enchant_amount);
					break;
					//                        case ITEM_MOD_FERAL_ATTACK_POWER:
					//                            ApplyFeralAPBonus(enchant_amount, apply);
					//                            ;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u FERAL_ATTACK_POWER", enchant_amount);
					//                            break;
				case ITEM_MOD_MANA_REGENERATION:
					ApplyManaRegenBonus(enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u MANA_REGENERATION", enchant_amount);
					break;
				case ITEM_MOD_ARMOR_PENETRATION_RATING:
					ApplyRatingMod(CR_ARMOR_PENETRATION, enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u ARMOR PENETRATION", enchant_amount);
					break;
				case ITEM_MOD_SPELL_POWER:
					ApplySpellPowerBonus(enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SPELL_POWER", enchant_amount);
					break;
				case ITEM_MOD_HEALTH_REGEN:
					ApplyHealthRegenBonus(enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u HEALTH_REGENERATION", enchant_amount);
					break;
				case ITEM_MOD_SPELL_PENETRATION:
					ApplySpellPenetrationBonus(enchant_amount, apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u SPELL_PENETRATION", enchant_amount);
					break;
				case ITEM_MOD_BLOCK_VALUE:
					HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(enchant_amount), apply);
					;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "+ %u BLOCK_VALUE", enchant_amount);
					break;
				case ITEM_MOD_SPELL_HEALING_DONE:   // deprecated
				case ITEM_MOD_SPELL_DAMAGE_DONE:    // deprecated
				default:
					break;
				}
				break;
			}
			case ITEM_ENCHANTMENT_TYPE_TOTEM:           // Shaman Rockbiter Weapon
			{
				if (getClass() == CLASS_SHAMAN)
				{
					float addValue = 0.0f;
					if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
					{
						addValue = float(enchant_amount * item->GetTemplate()->Delay / 1000.0f);
						HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, addValue, apply);
					}
					else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
					{
						addValue = float(enchant_amount * item->GetTemplate()->Delay / 1000.0f);
						HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, addValue, apply);
					}
				}
				break;
			}
			case ITEM_ENCHANTMENT_TYPE_USE_SPELL:
				// processed in Player::CastItemUseSpell
				break;
			case ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET:
				// nothing do..
				break;
			default:
				sLog->outError("Unknown item enchantment (id = %d) display type: %d", enchant_id, enchant_display_type);
				break;
			}                                               /*switch (enchant_display_type)*/
		}                                                   /*for*/
	}

	// visualize enchantment at player and equipped items
	if (slot == PERM_ENCHANTMENT_SLOT)
		SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (item->GetSlot() * 2), 0, apply ? item->GetEnchantmentId(slot) : 0);

	if (slot == TEMP_ENCHANTMENT_SLOT)
		SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (item->GetSlot() * 2), 1, apply ? item->GetEnchantmentId(slot) : 0);

	if (apply_dur)
	{
		if (apply)
		{
			// set duration
			uint32 duration = item->GetEnchantmentDuration(slot);
			if (duration > 0)
				AddEnchantmentDuration(item, slot, duration);
		}
		else
		{
			// duration == 0 will remove EnchantDuration
			AddEnchantmentDuration(item, slot, 0);
		}
	}
}

void Player::UpdateSkillEnchantments(uint16 skill_id, uint16 curr_value, uint16 new_value)
{
	for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
	{
		if (m_items[i])
		{
			for (uint8 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
			{
				uint32 ench_id = m_items[i]->GetEnchantmentId(EnchantmentSlot(slot));
				if (!ench_id)
					continue;

				SpellItemEnchantmentEntry const* Enchant = sSpellItemEnchantmentStore.LookupEntry(ench_id);
				if (!Enchant)
					return;

				if (Enchant->requiredSkill == skill_id)
				{
					// Checks if the enchantment needs to be applied or removed
					if (curr_value < Enchant->requiredSkillValue && new_value >= Enchant->requiredSkillValue)
						ApplyEnchantment(m_items[i], EnchantmentSlot(slot), true);
					else if (new_value < Enchant->requiredSkillValue && curr_value >= Enchant->requiredSkillValue)
						ApplyEnchantment(m_items[i], EnchantmentSlot(slot), false);
				}

				// If we're dealing with a gem inside a prismatic socket we need to check the prismatic socket requirements
				// rather than the gem requirements itself. If the socket has no color it is a prismatic socket.
				if ((slot == SOCK_ENCHANTMENT_SLOT || slot == SOCK_ENCHANTMENT_SLOT_2 || slot == SOCK_ENCHANTMENT_SLOT_3)
					&& !m_items[i]->GetTemplate()->Socket[slot - SOCK_ENCHANTMENT_SLOT].Color)
				{
					SpellItemEnchantmentEntry const* pPrismaticEnchant = sSpellItemEnchantmentStore.LookupEntry(m_items[i]->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));

					if (pPrismaticEnchant && pPrismaticEnchant->requiredSkill == skill_id)
					{
						if (curr_value < pPrismaticEnchant->requiredSkillValue && new_value >= pPrismaticEnchant->requiredSkillValue)
							ApplyEnchantment(m_items[i], EnchantmentSlot(slot), true);
						else if (new_value < pPrismaticEnchant->requiredSkillValue && curr_value >= pPrismaticEnchant->requiredSkillValue)
							ApplyEnchantment(m_items[i], EnchantmentSlot(slot), false);
					}
				}
			}
		}
	}
}

void Player::SendEnchantmentDurations()
{
	for (EnchantDurationList::const_iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
	{
		GetSession()->SendItemEnchantTimeUpdate(GetGUID(), itr->item->GetGUID(), itr->slot, uint32(itr->leftduration) / 1000);
	}
}

void Player::SendItemDurations()
{
	for (ItemDurationList::const_iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end(); ++itr)
	{
		(*itr)->SendTimeUpdate(this);
	}
}

void Player::SendNewItem(Item* item, uint32 count, bool received, bool created, bool broadcast)
{
	if (!item)                                               // prevent crash
		return;

	// last check 2.0.10
	WorldPacket data(SMSG_ITEM_PUSH_RESULT, (8 + 4 + 4 + 4 + 1 + 4 + 4 + 4 + 4 + 4));
	data << uint64(GetGUID());                              // player GUID
	data << uint32(received);                               // 0=looted, 1=from npc
	data << uint32(created);                                // 0=received, 1=created
	data << uint32(1);                                      // bool print error to chat
	data << uint8(item->GetBagSlot());                      // bagslot
															// item slot, but when added to stack: 0xFFFFFFFF
	data << uint32((item->GetCount() == count) ? item->GetSlot() : -1);
	data << uint32(item->GetEntry());                       // item id
	data << uint32(item->GetItemSuffixFactor());            // SuffixFactor
	data << int32(item->GetItemRandomPropertyId());         // random item property id
	data << uint32(count);                                  // count of items
	data << uint32(GetItemCount(item->GetEntry()));         // count of items in inventory

	if (broadcast && GetGroup())
		GetGroup()->BroadcastPacket(&data, true);
	else
		GetSession()->SendPacket(&data);
}

/*********************************************************/
/***                    GOSSIP SYSTEM                  ***/
/*********************************************************/

void Player::PrepareGossipMenu(WorldObject* source, uint32 menuId /*= 0*/, bool showQuests /*= false*/)
{
	PlayerMenu* menu = PlayerTalkClass;
	menu->ClearMenus();

	menu->GetGossipMenu().SetMenuId(menuId);

	GossipMenuItemsMapBounds menuItemBounds = sObjectMgr->GetGossipMenuItemsMapBounds(menuId);

	// if default menuId and no menu options exist for this, use options from default options
	if (menuItemBounds.first == menuItemBounds.second && menuId == GetDefaultGossipMenuForSource(source))
		menuItemBounds = sObjectMgr->GetGossipMenuItemsMapBounds(0);

	uint32 npcflags = 0;

	if (source->GetTypeId() == TYPEID_UNIT)
	{
		npcflags = source->GetUInt32Value(UNIT_NPC_FLAGS);
		if (showQuests && npcflags & UNIT_NPC_FLAG_QUESTGIVER)
			PrepareQuestMenu(source->GetGUID());
	}
	else if (source->GetTypeId() == TYPEID_GAMEOBJECT)
		if (showQuests && source->ToGameObject()->GetGoType() == GAMEOBJECT_TYPE_QUESTGIVER)
			PrepareQuestMenu(source->GetGUID());

	for (GossipMenuItemsContainer::const_iterator itr = menuItemBounds.first; itr != menuItemBounds.second; ++itr)
	{
		bool canTalk = true;
		if (!sConditionMgr->IsObjectMeetToConditions(this, source, itr->second.Conditions))
			continue;

		if (Creature* creature = source->ToCreature())
		{
			if (!(itr->second.OptionNpcflag & npcflags))
				continue;

			switch (itr->second.OptionType)
			{
			case GOSSIP_OPTION_ARMORER:
				canTalk = false;                       // added in special mode
				break;
			case GOSSIP_OPTION_SPIRITHEALER:
				if (!isDead())
					canTalk = false;
				break;
			case GOSSIP_OPTION_VENDOR:
			{
				VendorItemData const* vendorItems = creature->GetVendorItems();
				if (!vendorItems || vendorItems->Empty())
				{
					sLog->outErrorDb("Creature %u (Entry: %u) have UNIT_NPC_FLAG_VENDOR but have empty trading item list.", creature->GetGUIDLow(), creature->GetEntry());
					canTalk = false;
				}
				break;
			}
			case GOSSIP_OPTION_LEARNDUALSPEC:
				if (!(GetSpecsCount() == 1 && creature->isCanTrainingAndResetTalentsOf(this) && !(getLevel() < sWorld->getIntConfig(CONFIG_MIN_DUALSPEC_LEVEL))))
					canTalk = false;
				break;
			case GOSSIP_OPTION_UNLEARNTALENTS:
				if (!creature->isCanTrainingAndResetTalentsOf(this))
					canTalk = false;
				break;
			case GOSSIP_OPTION_UNLEARNPETTALENTS:
				if (!GetPet() || GetPet()->getPetType() != HUNTER_PET || GetPet()->m_spells.size() <= 1 || creature->GetCreatureTemplate()->trainer_type != TRAINER_TYPE_PETS || creature->GetCreatureTemplate()->trainer_class != CLASS_HUNTER)
					canTalk = false;
				break;
			case GOSSIP_OPTION_TAXIVENDOR:
				if (GetSession()->SendLearnNewTaxiNode(creature))
					return;
				break;
			case GOSSIP_OPTION_BATTLEFIELD:
				if (!creature->isCanInteractWithBattleMaster(this, false))
					canTalk = false;
				break;
			case GOSSIP_OPTION_STABLEPET:
				if (getClass() != CLASS_HUNTER)
					canTalk = false;
				break;
			case GOSSIP_OPTION_QUESTGIVER:
				canTalk = false;
				break;
			case GOSSIP_OPTION_TRAINER:
			case GOSSIP_OPTION_GOSSIP:
			case GOSSIP_OPTION_SPIRITGUIDE:
			case GOSSIP_OPTION_INNKEEPER:
			case GOSSIP_OPTION_BANKER:
			case GOSSIP_OPTION_PETITIONER:
			case GOSSIP_OPTION_TABARDDESIGNER:
			case GOSSIP_OPTION_AUCTIONEER:
				break;                                  // no checks
			case GOSSIP_OPTION_OUTDOORPVP:
				if (!sOutdoorPvPMgr->CanTalkTo(this, creature, itr->second))
					canTalk = false;
				break;
			default:
				sLog->outErrorDb("Creature entry %u has unknown gossip option %u for menu %u", creature->GetEntry(), itr->second.OptionType, itr->second.MenuId);
				canTalk = false;
				break;
			}
		}
		else if (GameObject* go = source->ToGameObject())
		{
			switch (itr->second.OptionType)
			{
			case GOSSIP_OPTION_GOSSIP:
				if (go->GetGoType() != GAMEOBJECT_TYPE_QUESTGIVER && go->GetGoType() != GAMEOBJECT_TYPE_GOOBER)
					canTalk = false;
				break;
			default:
				canTalk = false;
				break;
			}
		}

		if (canTalk)
		{
			menu->GetGossipMenu().AddMenuItem(itr->second.OptionIndex, itr->second.OptionIcon, itr->second.OptionText, 0, itr->second.OptionType, itr->second.BoxText, itr->second.BoxMoney, itr->second.BoxCoded);
			menu->GetGossipMenu().AddGossipMenuItemData(itr->second.OptionIndex, itr->second.ActionMenuId, itr->second.ActionPoiId);
		}
	}
}

void Player::SendPreparedGossip(WorldObject* source)
{
	if (!source)
		return;

	if (source->GetTypeId() == TYPEID_UNIT)
	{
		// in case no gossip flag and quest menu not empty, open quest menu (client expect gossip menu with this flag)
		if (!source->ToCreature()->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP) && !PlayerTalkClass->GetQuestMenu().Empty())
		{
			SendPreparedQuest(source->GetGUID());
			return;
		}
	}
	else if (source->GetTypeId() == TYPEID_GAMEOBJECT)
	{
		// probably need to find a better way here
		if (!PlayerTalkClass->GetGossipMenu().GetMenuId() && !PlayerTalkClass->GetQuestMenu().Empty())
		{
			SendPreparedQuest(source->GetGUID());
			return;
		}
	}

	// in case non empty gossip menu (that not included quests list size) show it
	// (quest entries from quest menu will be included in list)

	uint32 textId = GetGossipTextId(source);

	if (uint32 menuId = PlayerTalkClass->GetGossipMenu().GetMenuId())
		textId = GetGossipTextId(menuId, source);

	PlayerTalkClass->SendGossipMenu(textId, source->GetGUID());
}

void Player::OnGossipSelect(WorldObject* source, uint32 gossipListId, uint32 menuId)
{
	GossipMenu& gossipMenu = PlayerTalkClass->GetGossipMenu();

	// if not same, then something funky is going on
	if (menuId != gossipMenu.GetMenuId())
		return;

	GossipMenuItem const* item = gossipMenu.GetItem(gossipListId);
	if (!item)
		return;

	uint32 gossipOptionId = item->OptionType;
	uint64 guid = source->GetGUID();

	if (source->GetTypeId() == TYPEID_GAMEOBJECT)
	{
		if (gossipOptionId > GOSSIP_OPTION_QUESTGIVER)
		{
			sLog->outError("Player guid %u request invalid gossip option for GameObject entry %u", GetGUIDLow(), source->GetEntry());
			return;
		}
	}

	GossipMenuItemData const* menuItemData = gossipMenu.GetItemData(gossipListId);
	if (!menuItemData)
		return;

	int32 cost = int32(item->BoxMoney);
	if (!HasEnoughMoney(cost))
	{
		SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
		PlayerTalkClass->SendCloseGossip();
		return;
	}

	switch (gossipOptionId)
	{
	case GOSSIP_OPTION_GOSSIP:
	{
		if (menuItemData->GossipActionPoi)
			PlayerTalkClass->SendPointOfInterest(menuItemData->GossipActionPoi);

		if (menuItemData->GossipActionMenuId)
		{
			PrepareGossipMenu(source, menuItemData->GossipActionMenuId);
			SendPreparedGossip(source);
		}

		break;
	}
	case GOSSIP_OPTION_OUTDOORPVP:
		sOutdoorPvPMgr->HandleGossipOption(this, source->GetGUID(), gossipListId);
		break;
	case GOSSIP_OPTION_SPIRITHEALER:
		if (isDead())
			source->ToCreature()->CastSpell(source->ToCreature(), 17251, true, NULL, NULL, GetGUID());
		break;
	case GOSSIP_OPTION_QUESTGIVER:
		PrepareQuestMenu(guid);
		SendPreparedQuest(guid);
		break;
	case GOSSIP_OPTION_VENDOR:
	case GOSSIP_OPTION_ARMORER:
		GetSession()->SendListInventory(guid);
		break;
	case GOSSIP_OPTION_STABLEPET:
		GetSession()->SendStablePet(guid);
		break;
	case GOSSIP_OPTION_TRAINER:
		GetSession()->SendTrainerList(guid);
		break;
	case GOSSIP_OPTION_LEARNDUALSPEC:
		if (GetSpecsCount() == 1 && getLevel() >= sWorld->getIntConfig(CONFIG_MIN_DUALSPEC_LEVEL))
		{
			// Cast spells that teach dual spec
			// Both are also ImplicitTarget self and must be cast by player
			CastSpell(this, 63680, true, NULL, NULL, GetGUID());
			CastSpell(this, 63624, true, NULL, NULL, GetGUID());

			// Should show another Gossip text with "Congratulations..."
			PlayerTalkClass->SendCloseGossip();
		}
		break;
	case GOSSIP_OPTION_UNLEARNTALENTS:
		PlayerTalkClass->SendCloseGossip();
		SendTalentWipeConfirm(guid);
		break;
	case GOSSIP_OPTION_UNLEARNPETTALENTS:
		PlayerTalkClass->SendCloseGossip();
		ResetPetTalents();
		break;
	case GOSSIP_OPTION_TAXIVENDOR:
		GetSession()->SendTaxiMenu(source->ToCreature());
		break;
	case GOSSIP_OPTION_INNKEEPER:
		PlayerTalkClass->SendCloseGossip();
		SetBindPoint(guid);
		break;
	case GOSSIP_OPTION_BANKER:
		GetSession()->SendShowBank(guid);
		break;
	case GOSSIP_OPTION_PETITIONER:
		PlayerTalkClass->SendCloseGossip();
		GetSession()->SendPetitionShowList(guid);
		break;
	case GOSSIP_OPTION_TABARDDESIGNER:
		PlayerTalkClass->SendCloseGossip();
		GetSession()->SendTabardVendorActivate(guid);
		break;
	case GOSSIP_OPTION_AUCTIONEER:
		GetSession()->SendAuctionHello(guid, source->ToCreature());
		break;
	case GOSSIP_OPTION_SPIRITGUIDE:
		PrepareGossipMenu(source);
		SendPreparedGossip(source);
		break;
	case GOSSIP_OPTION_BATTLEFIELD:
	{
		BattlegroundTypeId bgTypeId = sBattlegroundMgr->GetBattleMasterBG(source->GetEntry());

		if (bgTypeId == BATTLEGROUND_TYPE_NONE)
		{
			sLog->outError("a user (guid %u) requested battlegroundlist from a npc who is no battlemaster", GetGUIDLow());
			return;
		}

		GetSession()->SendBattleGroundList(guid, bgTypeId);
		break;
	}
	}

	ModifyMoney(-cost);
}

uint32 Player::GetGossipTextId(WorldObject* source)
{
	if (!source)
		return DEFAULT_GOSSIP_MESSAGE;

	return GetGossipTextId(GetDefaultGossipMenuForSource(source), source);
}

uint32 Player::GetGossipTextId(uint32 menuId, WorldObject* source)
{
	uint32 textId = DEFAULT_GOSSIP_MESSAGE;

	if (!menuId)
		return textId;

	GossipMenusMapBounds menuBounds = sObjectMgr->GetGossipMenusMapBounds(menuId);

	for (GossipMenusContainer::const_iterator itr = menuBounds.first; itr != menuBounds.second; ++itr)
	{
		if (sConditionMgr->IsObjectMeetToConditions(this, source, itr->second.conditions))
			textId = itr->second.text_id;
	}

	return textId;
}

uint32 Player::GetDefaultGossipMenuForSource(WorldObject* source)
{
	switch (source->GetTypeId())
	{
	case TYPEID_UNIT:
		return source->ToCreature()->GetCreatureTemplate()->GossipMenuId;
	case TYPEID_GAMEOBJECT:
		return source->ToGameObject()->GetGOInfo()->GetGossipMenuId();
	default:
		break;
	}

	return 0;
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/

void Player::PrepareQuestMenu(uint64 guid)
{
	QuestRelationBounds objectQR;
	QuestRelationBounds objectQIR;

	// pets also can have quests
	Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
	if (creature)
	{
		objectQR = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
		objectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());
	}
	else
	{
		//we should obtain map pointer from GetMap() in 99% of cases. Special case
		//only for quests which cast teleport spells on player
		Map* _map = IsInWorld() ? GetMap() : sMapMgr->FindMap(GetMapId(), GetInstanceId());
		ASSERT(_map);
		GameObject* pGameObject = _map->GetGameObject(guid);
		if (pGameObject)
		{
			objectQR = sObjectMgr->GetGOQuestRelationBounds(pGameObject->GetEntry());
			objectQIR = sObjectMgr->GetGOQuestInvolvedRelationBounds(pGameObject->GetEntry());
		}
		else
			return;
	}

	QuestMenu &qm = PlayerTalkClass->GetQuestMenu();
	qm.ClearMenu();

	for (QuestRelations::const_iterator i = objectQIR.first; i != objectQIR.second; ++i)
	{
		uint32 quest_id = i->second;
		QuestStatus status = GetQuestStatus(quest_id);
		if (status == QUEST_STATUS_COMPLETE)
			qm.AddMenuItem(quest_id, 4);
		else if (status == QUEST_STATUS_INCOMPLETE)
			qm.AddMenuItem(quest_id, 4);
		//else if (status == QUEST_STATUS_AVAILABLE)
		//    qm.AddMenuItem(quest_id, 2);
	}

	for (QuestRelations::const_iterator i = objectQR.first; i != objectQR.second; ++i)
	{
		uint32 quest_id = i->second;
		Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
		if (!quest)
			continue;

		if (!CanTakeQuest(quest, false))
			continue;

		if (quest->IsAutoComplete())
			qm.AddMenuItem(quest_id, 4);
		else if (GetQuestStatus(quest_id) == QUEST_STATUS_NONE)
			qm.AddMenuItem(quest_id, 2);
	}
}

void Player::SendPreparedQuest(uint64 guid)
{
	QuestMenu& questMenu = PlayerTalkClass->GetQuestMenu();
	if (questMenu.Empty())
		return;

	// single element case
	if (questMenu.GetMenuItemCount() == 1)
	{
		QuestMenuItem const& qmi0 = questMenu.GetItem(0);
		uint32 questId = qmi0.QuestId;

		// Auto open -- maybe also should verify there is no greeting
		if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
		{
			if (qmi0.QuestIcon == 4)
				PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, CanRewardQuest(quest, false), true);
			// Send completable on repeatable and autoCompletable quest if player don't have quest
			/// @todo verify if check for !quest->IsDaily() is really correct (possibly not)
			else
			{
				Object* object = ObjectAccessor::GetObjectByTypeMask(*this, guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT | TYPEMASK_ITEM);
				if (!object || (!object->hasQuest(questId) && !object->hasInvolvedQuest(questId)))
				{
					PlayerTalkClass->SendCloseGossip();
					return;
				}

				if (quest->IsAutoAccept() && CanAddQuest(quest, true) && CanTakeQuest(quest, true))
					AddQuestAndCheckCompletion(quest, object);

				if ((quest->IsAutoComplete() && quest->IsRepeatable() && !quest->IsDailyOrWeekly()) || quest->HasFlag(QUEST_FLAGS_AUTOCOMPLETE))
					PlayerTalkClass->SendQuestGiverRequestItems(quest, guid, CanCompleteRepeatableQuest(quest), true);
				else
					PlayerTalkClass->SendQuestGiverQuestDetails(quest, guid, true);
			}
		}
	}
	// multiple entries
	else
	{
		QEmote qe;
		qe._Delay = 0;
		qe._Emote = 0;
		std::string title = "";

		// need pet case for some quests
		Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
		if (creature)
		{
			uint32 textid = GetGossipTextId(creature);
			GossipText const* gossiptext = sObjectMgr->GetGossipText(textid);
			if (!gossiptext)
			{
				qe._Delay = 0;                              //TEXTEMOTE_MESSAGE;              //zyg: player emote
				qe._Emote = 0;                              //TEXTEMOTE_HELLO;                //zyg: NPC emote
				title = "";
			}
			else
			{
				qe = gossiptext->Options[0].Emotes[0];

				if (!gossiptext->Options[0].Text_0.empty())
				{
					title = gossiptext->Options[0].Text_0;
				}
				else
				{
					title = gossiptext->Options[0].Text_1;
				}
			}
		}
		PlayerTalkClass->SendQuestGiverQuestList(qe, title, guid);
	}
}

bool Player::IsActiveQuest(uint32 quest_id) const
{
	return m_QuestStatus.find(quest_id) != m_QuestStatus.end();
}

Quest const* Player::GetNextQuest(uint64 guid, Quest const* quest)
{
	QuestRelationBounds objectQR;

	Creature* creature = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, guid);
	if (creature)
		objectQR = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
	else
	{
		//we should obtain map pointer from GetMap() in 99% of cases. Special case
		//only for quests which cast teleport spells on player
		Map* _map = IsInWorld() ? GetMap() : sMapMgr->FindMap(GetMapId(), GetInstanceId());
		ASSERT(_map);
		GameObject* pGameObject = _map->GetGameObject(guid);
		if (pGameObject)
			objectQR = sObjectMgr->GetGOQuestRelationBounds(pGameObject->GetEntry());
		else
			return NULL;
	}

	uint32 nextQuestID = quest->GetNextQuestInChain();
	for (QuestRelations::const_iterator itr = objectQR.first; itr != objectQR.second; ++itr)
	{
		if (itr->second == nextQuestID)
			return sObjectMgr->GetQuestTemplate(nextQuestID);
	}

	return NULL;
}

bool Player::CanSeeStartQuest(Quest const* quest)
{
	if (!DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, quest->GetQuestId(), this) && SatisfyQuestClass(quest, false) && SatisfyQuestRace(quest, false) &&
		SatisfyQuestSkill(quest, false) && SatisfyQuestExclusiveGroup(quest, false) && SatisfyQuestReputation(quest, false) &&
		SatisfyQuestPreviousQuest(quest, false) && SatisfyQuestNextChain(quest, false) &&
		SatisfyQuestPrevChain(quest, false) && SatisfyQuestDay(quest, false) && SatisfyQuestWeek(quest, false) &&
		SatisfyQuestMonth(quest, false) && SatisfyQuestSeasonal(quest, false))
	{
		return getLevel() + sWorld->getIntConfig(CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF) >= quest->GetMinLevel();
	}

	return false;
}

bool Player::CanTakeQuest(Quest const* quest, bool msg)
{
	return !DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, quest->GetQuestId(), this)
		&& SatisfyQuestStatus(quest, msg) && SatisfyQuestExclusiveGroup(quest, msg)
		&& SatisfyQuestClass(quest, msg) && SatisfyQuestRace(quest, msg) && SatisfyQuestLevel(quest, msg)
		&& SatisfyQuestSkill(quest, msg) && SatisfyQuestReputation(quest, msg)
		&& SatisfyQuestPreviousQuest(quest, msg) && SatisfyQuestTimed(quest, msg)
		&& SatisfyQuestNextChain(quest, msg) && SatisfyQuestPrevChain(quest, msg)
		&& SatisfyQuestDay(quest, msg) && SatisfyQuestWeek(quest, msg)
		&& SatisfyQuestMonth(quest, msg) && SatisfyQuestSeasonal(quest, msg)
		&& SatisfyQuestConditions(quest, msg);
}

bool Player::CanAddQuest(Quest const* quest, bool msg)
{
	if (!SatisfyQuestLog(msg))
		return false;

	uint32 srcitem = quest->GetSrcItemId();
	if (srcitem > 0)
	{
		uint32 count = quest->GetSrcItemCount();
		ItemPosCountVec dest;
		InventoryResult msg2 = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);

		// player already have max number (in most case 1) source item, no additional item needed and quest can be added.
		if (msg2 == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
			return true;
		else if (msg2 != EQUIP_ERR_OK)
		{
			SendEquipError(msg2, NULL, NULL, srcitem);
			return false;
		}
	}
	return true;
}

bool Player::CanCompleteQuest(uint32 quest_id, const QuestStatusData* q_savedStatus)
{
	if (quest_id)
	{
		Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
		if (!qInfo)
			return false;

		// Xinef: take seasonals into account
		if (!qInfo->IsRepeatable() && !qInfo->IsSeasonal() && IsQuestRewarded(quest_id))
			return false;                                   // not allow re-complete quest

		// auto complete quest
		if ((qInfo->IsAutoComplete() || qInfo->GetFlags() & QUEST_FLAGS_AUTOCOMPLETE) && CanTakeQuest(qInfo, false))
			return true;

		QuestStatusData q_status;
		if (q_savedStatus)
			q_status = *q_savedStatus;
		else
		{
			QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);
			if (itr == m_QuestStatus.end())
				return false;

			q_status = itr->second;
		}

		if (q_status.Status == QUEST_STATUS_INCOMPLETE)
		{
			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
			{
				for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
				{
					if (qInfo->RequiredItemCount[i] != 0 && q_status.ItemCount[i] < qInfo->RequiredItemCount[i])
						return false;
				}
			}

			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
			{
				for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
				{
					if (qInfo->RequiredNpcOrGo[i] == 0)
						continue;

					if (qInfo->RequiredNpcOrGoCount[i] != 0 && q_status.CreatureOrGOCount[i] < qInfo->RequiredNpcOrGoCount[i])
						return false;
				}
			}

			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL))
				if (qInfo->GetPlayersSlain() != 0 && q_status.PlayerCount < qInfo->GetPlayersSlain())
					return false;

			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT) && !q_status.Explored)
				return false;

			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED) && q_status.Timer == 0)
				return false;

			if (qInfo->GetRewOrReqMoney() < 0)
			{
				if (!HasEnoughMoney(-qInfo->GetRewOrReqMoney()))
					return false;
			}

			uint32 repFacId = qInfo->GetRepObjectiveFaction();
			if (repFacId && GetReputationMgr().GetReputation(repFacId) < qInfo->GetRepObjectiveValue())
				return false;

			return true;
		}
	}
	return false;
}

bool Player::CanCompleteRepeatableQuest(Quest const* quest)
{
	// Solve problem that player don't have the quest and try complete it.
	// if repeatable she must be able to complete event if player don't have it.
	// Seem that all repeatable quest are DELIVER Flag so, no need to add more.
	if (!CanTakeQuest(quest, false))
		return false;

	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
		for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
			if (quest->RequiredItemId[i] && quest->RequiredItemCount[i] && !HasItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i]))
				return false;

	if (!CanRewardQuest(quest, false))
		return false;

	return true;
}

bool Player::CanRewardQuest(Quest const* quest, bool msg)
{
	// not auto complete quest and not completed quest (only cheating case, then ignore without message)
	if (!quest->IsDFQuest() && !quest->IsAutoComplete() && !(quest->GetFlags() & QUEST_FLAGS_AUTOCOMPLETE) && GetQuestStatus(quest->GetQuestId()) != QUEST_STATUS_COMPLETE)
		return false;

	// daily quest can't be rewarded (25 daily quest already completed)
	if (!SatisfyQuestDay(quest, true) || !SatisfyQuestWeek(quest, true) || !SatisfyQuestMonth(quest, true) || !SatisfyQuestSeasonal(quest, true))
		return false;

	// rewarded and not repeatable quest (only cheating case, then ignore without message)
	if (GetQuestRewardStatus(quest->GetQuestId()))
		return false;

	// prevent receive reward with quest items in bank
	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
	{
		for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
		{
			if (quest->RequiredItemCount[i] != 0 &&
				GetItemCount(quest->RequiredItemId[i]) < quest->RequiredItemCount[i])
			{
				if (msg)
					SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL, quest->RequiredItemId[i]);
				return false;
			}
		}
	}

	// prevent receive reward with low money and GetRewOrReqMoney() < 0
	if (quest->GetRewOrReqMoney() < 0 && !HasEnoughMoney(-quest->GetRewOrReqMoney()))
		return false;

	return true;
}

void Player::AddQuestAndCheckCompletion(Quest const* quest, Object* questGiver)
{
	AddQuest(quest, questGiver);

	if (CanCompleteQuest(quest->GetQuestId()))
		CompleteQuest(quest->GetQuestId());

	if (!questGiver)
		return;

	switch (questGiver->GetTypeId())
	{
	case TYPEID_UNIT:
		sScriptMgr->OnQuestAccept(this, (questGiver->ToCreature()), quest);
		questGiver->ToCreature()->AI()->sQuestAccept(this, quest);
		break;
	case TYPEID_ITEM:
	case TYPEID_CONTAINER:
	{
		Item* item = (Item*)questGiver;
		sScriptMgr->OnQuestAccept(this, item, quest);

		// destroy not required for quest finish quest starting item
		bool destroyItem = true;
		for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
		{
			if (quest->RequiredItemId[i] == item->GetEntry() && item->GetTemplate()->MaxCount > 0)
			{
				destroyItem = false;
				break;
			}
		}

		if (destroyItem)
			DestroyItem(item->GetBagSlot(), item->GetSlot(), true);

		break;
	}
	case TYPEID_GAMEOBJECT:
		sScriptMgr->OnQuestAccept(this, questGiver->ToGameObject(), quest);
		questGiver->ToGameObject()->AI()->QuestAccept(this, quest);
		break;
	default:
		break;
	}
}

bool Player::CanRewardQuest(Quest const* quest, uint32 reward, bool msg)
{
	// prevent receive reward with quest items in bank or for not completed quest
	if (!CanRewardQuest(quest, msg))
		return false;

	ItemPosCountVec dest;
	if (quest->GetRewChoiceItemsCount() > 0)
	{
		if (quest->RewardChoiceItemId[reward])
		{
			InventoryResult res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, quest->RewardChoiceItemId[reward], quest->RewardChoiceItemCount[reward]);
			if (res != EQUIP_ERR_OK)
			{
				SendEquipError(res, NULL, NULL, quest->RewardChoiceItemId[reward]);
				return false;
			}
		}
	}

	if (quest->GetRewItemsCount() > 0)
	{
		for (uint32 i = 0; i < quest->GetRewItemsCount(); ++i)
		{
			if (quest->RewardItemId[i])
			{
				InventoryResult res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, quest->RewardItemId[i], quest->RewardItemIdCount[i]);
				if (res != EQUIP_ERR_OK)
				{
					SendEquipError(res, NULL, NULL, quest->RewardItemId[i]);
					return false;
				}
			}
		}
	}

	return true;
}

void Player::AddQuest(Quest const* quest, Object* questGiver)
{
	uint16 log_slot = FindQuestSlot(0);

	if (log_slot >= MAX_QUEST_LOG_SIZE) // Player does not have any free slot in the quest log
		return;

	uint32 quest_id = quest->GetQuestId();

	// if not exist then created with set uState == NEW and rewarded=false
	QuestStatusData& questStatusData = m_QuestStatus[quest_id];

	// check for repeatable quests status reset
	questStatusData.Status = QUEST_STATUS_INCOMPLETE;
	questStatusData.Explored = false;

	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
	{
		for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
			questStatusData.ItemCount[i] = 0;
	}

	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
	{
		for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
			questStatusData.CreatureOrGOCount[i] = 0;
	}

	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL))
		questStatusData.PlayerCount = 0;

	GiveQuestSourceItem(quest);
	AdjustQuestReqItemCount(quest, questStatusData);

	if (quest->GetRepObjectiveFaction())
		if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->GetRepObjectiveFaction()))
			GetReputationMgr().SetVisible(factionEntry);

	if (quest->GetRepObjectiveFaction2())
		if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(quest->GetRepObjectiveFaction2()))
			GetReputationMgr().SetVisible(factionEntry);

	uint32 qtime = 0;
	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
	{
		uint32 limittime = quest->GetLimitTime();

		// shared timed quest
		if (questGiver && questGiver->GetTypeId() == TYPEID_PLAYER)
			limittime = questGiver->ToPlayer()->getQuestStatusMap()[quest_id].Timer / IN_MILLISECONDS;

		AddTimedQuest(quest_id);
		questStatusData.Timer = limittime * IN_MILLISECONDS;
		qtime = static_cast<uint32>(time(NULL)) + limittime;
	}
	else
		questStatusData.Timer = 0;

	if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
	{
		pvpInfo.IsHostile = true;
		UpdatePvPState();
	}

	SetQuestSlot(log_slot, quest_id, qtime);

	m_QuestStatusSave[quest_id] = true;

	StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_QUEST, quest_id);

	SendQuestUpdate(quest_id);

	// Xinef: area auras may change on quest accept!
	UpdateZoneDependentAuras(GetZoneId());
	UpdateAreaDependentAuras(GetAreaId());
}

void Player::CompleteQuest(uint32 quest_id)
{
	if (quest_id)
	{
		SetQuestStatus(quest_id, QUEST_STATUS_COMPLETE);

		uint16 log_slot = FindQuestSlot(quest_id);
		if (log_slot < MAX_QUEST_LOG_SIZE)
			SetQuestSlotState(log_slot, QUEST_STATE_COMPLETE);

		if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id))
		{
			if (qInfo->HasFlag(QUEST_FLAGS_TRACKING))
				RewardQuest(qInfo, 0, this, false);
			else
				SendQuestComplete(quest_id);
		}

		// Xinef: area auras may change on quest completion!
		UpdateZoneDependentAuras(GetZoneId());
		UpdateAreaDependentAuras(GetAreaId());
		AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD | ADDITIONAL_SAVING_QUEST_STATUS);
	}
}

void Player::IncompleteQuest(uint32 quest_id)
{
	if (quest_id)
	{
		SetQuestStatus(quest_id, QUEST_STATUS_INCOMPLETE);

		uint16 log_slot = FindQuestSlot(quest_id);
		if (log_slot < MAX_QUEST_LOG_SIZE)
			RemoveQuestSlotState(log_slot, QUEST_STATE_COMPLETE);

		// Xinef: area auras may change on quest completion!
		UpdateZoneDependentAuras(GetZoneId());
		UpdateAreaDependentAuras(GetAreaId());
		AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
	}
}

void Player::RewardQuest(Quest const* quest, uint32 reward, Object* questGiver, bool announce)
{
	//this THING should be here to protect code from quest, which cast on player far teleport as a reward
	//should work fine, cause far teleport will be executed in Player::Update()
	SetMustDelayTeleport(true);

	uint32 quest_id = quest->GetQuestId();

	for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
		if (quest->RequiredItemId[i])
			DestroyItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i], true);

	for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
	{
		if (quest->RequiredSourceItemId[i])
		{
			uint32 count = quest->RequiredSourceItemCount[i];
			DestroyItemCount(quest->RequiredSourceItemId[i], count ? count : 9999, true);
		}
	}

	RemoveTimedQuest(quest_id);

	std::vector<std::pair<uint32, uint32> > problematicItems;

	if (quest->GetRewChoiceItemsCount() > 0)
	{
		if (uint32 itemId = quest->RewardChoiceItemId[reward])
		{
			ItemPosCountVec dest;
			if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, quest->RewardChoiceItemCount[reward]) == EQUIP_ERR_OK)
			{
				Item* item = StoreNewItem(dest, itemId, true, Item::GenerateItemRandomPropertyId(itemId));
				SendNewItem(item, quest->RewardChoiceItemCount[reward], true, false);
			}
			else
				problematicItems.push_back(std::pair<uint32, uint32>(itemId, quest->RewardChoiceItemCount[reward]));
		}
	}

	if (quest->GetRewItemsCount() > 0)
	{
		for (uint32 i = 0; i < quest->GetRewItemsCount(); ++i)
		{
			if (uint32 itemId = quest->RewardItemId[i])
			{
				ItemPosCountVec dest;
				if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, quest->RewardItemIdCount[i]) == EQUIP_ERR_OK)
				{
					Item* item = StoreNewItem(dest, itemId, true, Item::GenerateItemRandomPropertyId(itemId));
					SendNewItem(item, quest->RewardItemIdCount[i], true, false);
				}
				else
					problematicItems.push_back(std::pair<uint32, uint32>(itemId, quest->RewardItemIdCount[i]));
			}
		}
	}

	// Xinef: send items that couldn't be added properly by mail
	if (!problematicItems.empty())
	{
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		MailSender sender(MAIL_CREATURE, 34337 /* The Postmaster */);
		MailDraft draft("Recovered Item", "We recovered a lost item in the twisting nether and noted that it was yours.$B$BPlease find said object enclosed."); // This is the text used in Cataclysm, it probably wasn't changed.

		for (std::vector<std::pair<uint32, uint32> >::const_iterator itr = problematicItems.begin(); itr != problematicItems.end(); ++itr)
		{
			if (Item* item = Item::CreateItem(itr->first, itr->second))
			{
				item->SaveToDB(trans);
				draft.AddItem(item);
			}
		}

		draft.SendMailTo(trans, MailReceiver(this, this->GetGUIDLow()), sender);
		CharacterDatabase.CommitTransaction(trans);
	}

	RewardReputation(quest);

	uint16 log_slot = FindQuestSlot(quest_id);
	if (log_slot < MAX_QUEST_LOG_SIZE)
		SetQuestSlot(log_slot, 0);

	bool rewarded = IsQuestRewarded(quest_id) && !quest->IsDFQuest();

	// Not give XP in case already completed once repeatable quest
	uint32 XP = rewarded ? 0 : uint32(quest->XPValue(this)*sWorld->getRate(RATE_XP_QUEST));

	// handle SPELL_AURA_MOD_XP_QUEST_PCT auras
	Unit::AuraEffectList const& ModXPPctAuras = GetAuraEffectsByType(SPELL_AURA_MOD_XP_QUEST_PCT);
	for (Unit::AuraEffectList::const_iterator i = ModXPPctAuras.begin(); i != ModXPPctAuras.end(); ++i)
		AddPct(XP, (*i)->GetAmount());

	int32 moneyRew = 0;
	if (getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
		GiveXP(XP, NULL);
	else
		moneyRew = int32(quest->GetRewMoneyMaxLevel() * sWorld->getRate(RATE_DROP_MONEY));

	// Give player extra money if GetRewOrReqMoney > 0 and get ReqMoney if negative
	if (quest->GetRewOrReqMoney())
		moneyRew += quest->GetRewOrReqMoney();

	if (moneyRew)
	{
		ModifyMoney(moneyRew);

		if (moneyRew > 0)
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD, uint32(moneyRew));
	}

	// honor reward
	if (uint32 honor = quest->CalculateHonorGain(getLevel()))
		RewardHonor(NULL, 0, honor);

	// title reward
	if (quest->GetCharTitleId())
	{
		if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(quest->GetCharTitleId()))
			SetTitle(titleEntry);
	}

	if (quest->GetBonusTalents())
	{
		m_questRewardTalentCount += quest->GetBonusTalents();
		InitTalentForLevel();
	}

	if (quest->GetRewArenaPoints())
		ModifyArenaPoints(quest->GetRewArenaPoints());

	// Send reward mail
	if (uint32 mail_template_id = quest->GetRewMailTemplateId())
	{
		//- TODO: Poor design of mail system
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		MailDraft(mail_template_id).SendMailTo(trans, this, questGiver, MAIL_CHECK_MASK_HAS_BODY, quest->GetRewMailDelaySecs());
		CharacterDatabase.CommitTransaction(trans);
	}

	if (quest->IsDaily() || quest->IsDFQuest())
	{
		SetDailyQuestStatus(quest_id);
		if (quest->IsDaily())
		{
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST, quest_id);
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST_DAILY, quest_id);
		}
	}
	else if (quest->IsWeekly())
		SetWeeklyQuestStatus(quest_id);
	else if (quest->IsMonthly())
		SetMonthlyQuestStatus(quest_id);
	else if (quest->IsSeasonal())
		SetSeasonalQuestStatus(quest_id);

	RemoveActiveQuest(quest_id, false);
	m_RewardedQuests.insert(quest_id);
	m_RewardedQuestsSave[quest_id] = true;

	if (announce)
		SendQuestReward(quest, XP);

	// cast spells after mark quest complete (some spells have quest completed state requirements in spell_area data)
	if (quest->GetRewSpellCast() > 0)
	{
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(quest->GetRewSpellCast());
		if (questGiver->isType(TYPEMASK_UNIT) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL) && !spellInfo->HasEffect(SPELL_EFFECT_CREATE_ITEM) && !spellInfo->IsSelfCast())
		{
			if (Creature* creature = GetMap()->GetCreature(questGiver->GetGUID()))
				creature->CastSpell(this, quest->GetRewSpellCast(), true);
		}
		else
			CastSpell(this, quest->GetRewSpellCast(), true);
	}
	else if (quest->GetRewSpell() > 0)
	{
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(quest->GetRewSpell());
		if (questGiver->isType(TYPEMASK_UNIT) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL) && !spellInfo->HasEffect(SPELL_EFFECT_CREATE_ITEM) && !spellInfo->IsSelfCast())
		{
			if (Creature* creature = GetMap()->GetCreature(questGiver->GetGUID()))
				creature->CastSpell(this, quest->GetRewSpell(), true);
		}
		else
			CastSpell(this, quest->GetRewSpell(), true);
	}

	if (quest->GetZoneOrSort() > 0)
		UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE, quest->GetZoneOrSort());
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST_COUNT);
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST, quest->GetQuestId());

	// pussywizard: replaced partial save with full save
	SaveToDB(false, false);

	if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
	{
		pvpInfo.IsHostile = pvpInfo.IsInHostileArea || HasPvPForcingQuest();
		UpdatePvPState();
	}

	SendQuestUpdate(quest_id);

	//lets remove flag for delayed teleports
	SetMustDelayTeleport(false);

	// Xinef: area auras may change on quest completion!
	UpdateZoneDependentAuras(GetZoneId());
	UpdateAreaDependentAuras(GetAreaId());
}

void Player::FailQuest(uint32 questId)
{
	if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
	{
		QuestStatus qStatus = GetQuestStatus(questId);
		// xinef: if quest is marked as failed, dont do it again
		if (qStatus != QUEST_STATUS_INCOMPLETE)
			return;

		SetQuestStatus(questId, QUEST_STATUS_FAILED);

		uint16 log_slot = FindQuestSlot(questId);

		if (log_slot < MAX_QUEST_LOG_SIZE)
		{
			SetQuestSlotTimer(log_slot, 1);
			SetQuestSlotState(log_slot, QUEST_STATE_FAIL);
		}

		if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
		{
			QuestStatusData& q_status = m_QuestStatus[questId];

			RemoveTimedQuest(questId);
			q_status.Timer = 0;

			SendQuestTimerFailed(questId);
		}
		else
			SendQuestFailed(questId);

		// Destroy quest items on quest failure.
		for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
			if (quest->RequiredItemId[i] > 0 && quest->RequiredItemCount[i] > 0)
				// Destroy items received on starting the quest.
				DestroyItemCount(quest->RequiredItemId[i], quest->RequiredItemCount[i], true, true);
		for (uint8 i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
			if (quest->RequiredSourceItemId[i] > 0 && quest->RequiredSourceItemCount[i] > 0)
				// Destroy items received during the quest.
				DestroyItemCount(quest->RequiredSourceItemId[i], quest->RequiredSourceItemCount[i], true, true);
	}
}

bool Player::SatisfyQuestSkill(Quest const* qInfo, bool msg) const
{
	uint32 skill = qInfo->GetRequiredSkill();

	// skip 0 case RequiredSkill
	if (skill == 0)
		return true;

	// check skill value
	if (GetSkillValue(skill) < qInfo->GetRequiredSkillValue())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

		return false;
	}

	return true;
}

bool Player::SatisfyQuestLevel(Quest const* qInfo, bool msg) const
{
	if (getLevel() < qInfo->GetMinLevel())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_QUEST_FAILED_LOW_LEVEL);
		return false;
	}
	else if (qInfo->GetMaxLevel() > 0 && getLevel() > qInfo->GetMaxLevel())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ); // There doesn't seem to be a specific response for too high player level
		return false;
	}
	return true;
}

bool Player::SatisfyQuestLog(bool msg)
{
	// exist free slot
	if (FindQuestSlot(0) < MAX_QUEST_LOG_SIZE)
		return true;

	if (msg)
	{
		WorldPacket data(SMSG_QUESTLOG_FULL, 0);
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTLOG_FULL");
	}
	return false;
}

bool Player::SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg) const
{
	// No previous quest (might be first quest in a series)
	if (qInfo->prevQuests.empty())
		return true;

	for (Quest::PrevQuests::const_iterator iter = qInfo->prevQuests.begin(); iter != qInfo->prevQuests.end(); ++iter)
	{
		uint32 prevId = abs(*iter);

		Quest const* qPrevInfo = sObjectMgr->GetQuestTemplate(prevId);

		if (qPrevInfo)
		{
			// If any of the positive previous quests completed, return true
			if (*iter > 0 && IsQuestRewarded(prevId) && (!qPrevInfo->IsSeasonal() || !SatisfyQuestSeasonal(qPrevInfo, false)))
			{
				// skip one-from-all exclusive group
				if (qPrevInfo->GetExclusiveGroup() >= 0)
					return true;

				// each-from-all exclusive group (< 0)
				// can be start if only all quests in prev quest exclusive group completed and rewarded
				ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qPrevInfo->GetExclusiveGroup()));

				for (; range.first != range.second; ++range.first)
				{
					uint32 exclude_Id = range.first->second;

					// skip checked quest id, only state of other quests in group is interesting
					if (exclude_Id == prevId)
						continue;

					// alternative quest from group also must be completed and rewarded(reported)

					Quest const* qExcludeInfo = sObjectMgr->GetQuestTemplate(exclude_Id);
					if (!IsQuestRewarded(exclude_Id) || (qExcludeInfo->IsSeasonal() && SatisfyQuestSeasonal(qExcludeInfo, false)))
					{
						if (msg)
							SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
						return false;
					}
				}
				return true;
			}

			// If any of the negative previous quests active, return true
			if (*iter < 0 && GetQuestStatus(prevId) != QUEST_STATUS_NONE)
			{
				// skip one-from-all exclusive group
				if (qPrevInfo->GetExclusiveGroup() >= 0)
					return true;

				// each-from-all exclusive group (< 0)
				// can be start if only all quests in prev quest exclusive group active
				ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qPrevInfo->GetExclusiveGroup()));

				for (; range.first != range.second; ++range.first)
				{
					uint32 exclude_Id = range.first->second;

					// skip checked quest id, only state of other quests in group is interesting
					if (exclude_Id == prevId)
						continue;

					// alternative quest from group also must be active
					if (GetQuestStatus(exclude_Id) != QUEST_STATUS_NONE)
					{
						if (msg)
							SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
						return false;
					}
				}
				return true;
			}
		}
	}

	// Has only positive prev. quests in non-rewarded state
	// and negative prev. quests in non-active state
	if (msg)
		SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

	return false;
}

bool Player::SatisfyQuestClass(Quest const* qInfo, bool msg) const
{
	uint32 reqClass = qInfo->GetRequiredClasses();

	if (reqClass == 0)
		return true;

	if ((reqClass & getClassMask()) == 0)
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

		return false;
	}

	return true;
}

bool Player::SatisfyQuestRace(Quest const* qInfo, bool msg) const
{
	uint32 reqraces = qInfo->GetRequiredRaces();
	if (reqraces == 0)
		return true;
	if ((reqraces & getRaceMask()) == 0)
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_QUEST_FAILED_WRONG_RACE);
		return false;
	}
	return true;
}

bool Player::SatisfyQuestReputation(Quest const* qInfo, bool msg) const
{
	uint32 fIdMin = qInfo->GetRequiredMinRepFaction();      //Min required rep
	if (fIdMin && GetReputationMgr().GetReputation(fIdMin) < qInfo->GetRequiredMinRepValue())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
		return false;
	}

	uint32 fIdMax = qInfo->GetRequiredMaxRepFaction();      //Max required rep
	if (fIdMax && GetReputationMgr().GetReputation(fIdMax) >= qInfo->GetRequiredMaxRepValue())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
		return false;
	}

	// ReputationObjective2 does not seem to be an objective requirement but a requirement
	// to be able to accept the quest
	uint32 fIdObj = qInfo->GetRepObjectiveFaction2();
	if (fIdObj && GetReputationMgr().GetReputation(fIdObj) >= qInfo->GetRepObjectiveValue2())
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
		return false;
	}

	return true;
}

bool Player::SatisfyQuestStatus(Quest const* qInfo, bool msg) const
{
	if (GetQuestStatus(qInfo->GetQuestId()) != QUEST_STATUS_NONE)
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_QUEST_ALREADY_ON);
		return false;
	}
	return true;
}

bool Player::SatisfyQuestConditions(Quest const* qInfo, bool msg)
{
	ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_ACCEPT, qInfo->GetQuestId());
	if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
		;//sLog->outDebug(LOG_FILTER_CONDITIONSYS, "Player::SatisfyQuestConditions: conditions not met for quest %u", qInfo->GetQuestId());
		return false;
	}
	return true;
}

bool Player::SatisfyQuestTimed(Quest const* qInfo, bool msg) const
{
	if (!m_timedquests.empty() && qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_QUEST_ONLY_ONE_TIMED);
		return false;
	}
	return true;
}

bool Player::SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg) const
{
	// non positive exclusive group, if > 0 then can be start if any other quest in exclusive group already started/completed
	if (qInfo->GetExclusiveGroup() <= 0)
		return true;

	ObjectMgr::ExclusiveQuestGroupsBounds range(sObjectMgr->mExclusiveQuestGroups.equal_range(qInfo->GetExclusiveGroup()));

	for (; range.first != range.second; ++range.first)
	{
		uint32 exclude_Id = range.first->second;

		// skip checked quest id, only state of other quests in group is interesting
		if (exclude_Id == qInfo->GetQuestId())
			continue;

		// not allow have daily quest if daily quest from exclusive group already recently completed
		Quest const* Nquest = sObjectMgr->GetQuestTemplate(exclude_Id);
		if (!SatisfyQuestDay(Nquest, false) || !SatisfyQuestWeek(Nquest, false) || !SatisfyQuestSeasonal(Nquest, false))
		{
			if (msg)
				SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

			return false;
		}

		// alternative quest already started or completed - but don't check rewarded states if both are repeatable
		if (GetQuestStatus(exclude_Id) != QUEST_STATUS_NONE || (!(qInfo->IsRepeatable() && Nquest->IsRepeatable()) && !Nquest->IsSeasonal() && IsQuestRewarded(exclude_Id))) // pussywizard: added !Nquest->IsSeasonal() because seasonal quests are considered rewarded only if finished this year, this is checked above in SatisfyQuestSeasonal
		{
			if (msg)
				SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
			return false;
		}
	}
	return true;
}

bool Player::SatisfyQuestNextChain(Quest const* qInfo, bool msg) const
{
	uint32 nextQuest = qInfo->GetNextQuestInChain();
	if (!nextQuest)
		return true;

	// next quest in chain already started or completed
	if (GetQuestStatus(nextQuest) != QUEST_STATUS_NONE) // GetQuestStatus returns QUEST_STATUS_COMPLETED for rewarded quests
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
		return false;
	}

	// check for all quests further up the chain
	// only necessary if there are quest chains with more than one quest that can be skipped
	//return SatisfyQuestNextChain(qInfo->GetNextQuestInChain(), msg);
	return true;
}

bool Player::SatisfyQuestPrevChain(Quest const* qInfo, bool msg) const
{
	// No previous quest in chain
	if (qInfo->prevChainQuests.empty())
		return true;

	for (Quest::PrevChainQuests::const_iterator iter = qInfo->prevChainQuests.begin(); iter != qInfo->prevChainQuests.end(); ++iter)
	{
		QuestStatusMap::const_iterator itr = m_QuestStatus.find(*iter);

		// If any of the previous quests in chain active, return false
		if (itr != m_QuestStatus.end() && itr->second.Status != QUEST_STATUS_NONE)
		{
			if (msg)
				SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
			return false;
		}

		// check for all quests further down the chain
		// only necessary if there are quest chains with more than one quest that can be skipped
		//if (!SatisfyQuestPrevChain(prevId, msg))
		//    return false;
	}

	// No previous quest in chain active
	return true;
}

bool Player::SatisfyQuestDay(Quest const* qInfo, bool msg) const
{
	if (!qInfo->IsDaily() && !qInfo->IsDFQuest())
		return true;

	if (qInfo->IsDFQuest())
	{
		if (!m_DFQuests.empty())
			return false;

		return true;
	}

	bool have_slot = false;
	for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
	{
		uint32 id = GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx);
		if (qInfo->GetQuestId() == id)
			return false;

		if (!id)
			have_slot = true;
	}

	if (!have_slot)
	{
		if (msg)
			SendCanTakeQuestResponse(INVALIDREASON_DAILY_QUESTS_REMAINING);
		return false;
	}

	return true;
}

bool Player::SatisfyQuestWeek(Quest const* qInfo, bool /*msg*/) const
{
	if (!qInfo->IsWeekly() || m_weeklyquests.empty())
		return true;

	// if not found in cooldown list
	return m_weeklyquests.find(qInfo->GetQuestId()) == m_weeklyquests.end();
}

bool Player::SatisfyQuestSeasonal(Quest const* qInfo, bool /*msg*/) const
{
	if (!qInfo->IsSeasonal() || m_seasonalquests.empty())
		return true;

	Player::SeasonalEventQuestMap::iterator itr = ((Player*)this)->m_seasonalquests.find(qInfo->GetEventIdForQuest());

	if (itr == m_seasonalquests.end() || itr->second.empty())
		return true;

	// if not found in cooldown list
	return itr->second.find(qInfo->GetQuestId()) == itr->second.end();
}

bool Player::SatisfyQuestMonth(Quest const* qInfo, bool /*msg*/) const
{
	if (!qInfo->IsMonthly() || m_monthlyquests.empty())
		return true;

	// if not found in cooldown list
	return m_monthlyquests.find(qInfo->GetQuestId()) == m_monthlyquests.end();
}

bool Player::GiveQuestSourceItem(Quest const* quest)
{
	uint32 srcitem = quest->GetSrcItemId();
	if (srcitem > 0)
	{
		uint32 count = quest->GetSrcItemCount();
		if (count <= 0)
			count = 1;

		ItemPosCountVec dest;
		InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);
		if (msg == EQUIP_ERR_OK)
		{
			Item* item = StoreNewItem(dest, srcitem, true);
			SendNewItem(item, count, true, false);
			return true;
		}
		// player already have max amount required item, just report success
		else if (msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
			return true;
		else
			SendEquipError(msg, NULL, NULL, srcitem);
		return false;
	}

	return true;
}

bool Player::TakeQuestSourceItem(uint32 questId, bool msg)
{
	Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
	if (quest)
	{
		uint32 srcItemId = quest->GetSrcItemId();
		ItemTemplate const* item = sObjectMgr->GetItemTemplate(srcItemId);

		if (srcItemId > 0)
		{
			uint32 count = quest->GetSrcItemCount();
			if (count <= 0)
				count = 1;

			// exist two cases when destroy source quest item not possible:
			// a) non un-equippable item (equipped non-empty bag, for example)
			// b) when quest is started from an item and item also is needed in
			// the end as RequiredItemId
			InventoryResult res = CanUnequipItems(srcItemId, count);
			if (res != EQUIP_ERR_OK)
			{
				if (msg)
					SendEquipError(res, NULL, NULL, srcItemId);
				return false;
			}

			bool destroyItem = true;
			for (uint8 n = 0; n < QUEST_ITEM_OBJECTIVES_COUNT; ++n)
				if (item->StartQuest == questId && srcItemId == quest->RequiredItemId[n])
					destroyItem = false;

			if (destroyItem)
				DestroyItemCount(srcItemId, count, true, true);
		}
	}

	return true;
}

bool Player::GetQuestRewardStatus(uint32 quest_id) const
{
	Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
	if (qInfo)
	{
		if (qInfo->IsSeasonal())
			return !SatisfyQuestSeasonal(qInfo, false);

		// for repeatable quests: rewarded field is set after first reward only to prevent getting XP more than once
		if (!qInfo->IsRepeatable())
			return IsQuestRewarded(quest_id);
	}
	return false;
}

QuestStatus Player::GetQuestStatus(uint32 quest_id) const
{
	if (quest_id)
	{
		QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);
		if (itr != m_QuestStatus.end())
			return itr->second.Status;

		if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id))
		{
			if (qInfo->IsSeasonal())
				return SatisfyQuestSeasonal(qInfo, false) ? QUEST_STATUS_NONE : QUEST_STATUS_REWARDED;

			if (!qInfo->IsRepeatable() && IsQuestRewarded(quest_id))
				return QUEST_STATUS_REWARDED;
		}
	}
	return QUEST_STATUS_NONE;
}

bool Player::CanShareQuest(uint32 quest_id) const
{
	Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
	if (qInfo && qInfo->HasFlag(QUEST_FLAGS_SHARABLE))
	{
		QuestStatusMap::const_iterator itr = m_QuestStatus.find(quest_id);
		if (itr != m_QuestStatus.end())
		{
			if (itr->second.Status != QUEST_STATUS_INCOMPLETE)
				return false;

			// pussywizard: in pool and not currently available (wintergrasp weekly, dalaran weekly) - can't share
			if (sPoolMgr->IsPartOfAPool<Quest>(quest_id) && !sPoolMgr->IsSpawnedObject<Quest>(quest_id))
				return false;

			return true;
		}
	}
	return false;
}

void Player::SetQuestStatus(uint32 questId, QuestStatus status, bool update /*= true*/)
{
	if (sObjectMgr->GetQuestTemplate(questId))
	{
		m_QuestStatus[questId].Status = status;
		m_QuestStatusSave[questId] = true;
	}

	if (update)
		SendQuestUpdate(questId);
}

void Player::RemoveActiveQuest(uint32 questId, bool update /*= true*/)
{
	QuestStatusMap::iterator itr = m_QuestStatus.find(questId);
	if (itr != m_QuestStatus.end())
	{
		m_QuestStatus.erase(itr);
		m_QuestStatusSave[questId] = false;
	}

	if (update)
		SendQuestUpdate(questId);

	// Xinef: area auras may change on quest remove!
	UpdateZoneDependentAuras(GetZoneId());
	UpdateAreaDependentAuras(GetAreaId());
	AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
}

void Player::RemoveRewardedQuest(uint32 questId, bool update /*= true*/)
{
	RewardedQuestSet::iterator rewItr = m_RewardedQuests.find(questId);
	if (rewItr != m_RewardedQuests.end())
	{
		m_RewardedQuests.erase(rewItr);
		m_RewardedQuestsSave[questId] = false;
	}

	if (update)
		SendQuestUpdate(questId);
}

void Player::SendQuestUpdate(uint32 questId)
{
	uint32 zone = 0, area = 0;
	// xinef: shittness fixup
	uint32 oldSpellId = 0;

	SpellAreaForQuestMapBounds saBounds = sSpellMgr->GetSpellAreaForQuestMapBounds(questId);
	if (saBounds.first != saBounds.second)
	{
		GetZoneAndAreaId(zone, area);

		for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
		{
			// xinef: spell was already casted, skip different areas with same spell
			if (itr->second->spellId == oldSpellId)
				continue;
			if (itr->second->autocast && itr->second->IsFitToRequirements(this, zone, area))
				if (!HasAura(itr->second->spellId))
				{
					CastSpell(this, itr->second->spellId, true);
					oldSpellId = itr->second->spellId;
				}
		}
	}

	saBounds = sSpellMgr->GetSpellAreaForQuestEndMapBounds(questId);

	// xinef: shittness fixup
	uint32 skipSpellId = 0;
	oldSpellId = 0;
	if (saBounds.first != saBounds.second)
	{
		if (!zone || !area)
			GetZoneAndAreaId(zone, area);

		for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
		{
			// xinef: skip spell for which condition is already fulfilled
			if (itr->second->spellId == skipSpellId)
				continue;
			skipSpellId = 0;

			// xinef: spells are sorted, if no condition is fulfilled remove aura
			if (oldSpellId && oldSpellId != itr->second->spellId)
			{
				RemoveAurasDueToSpell(oldSpellId);
				oldSpellId = 0;
			}

			if (!itr->second->IsFitToRequirements(this, zone, area))
			{
				//RemoveAurasDueToSpell(itr->second->spellId);
				oldSpellId = itr->second->spellId;
			}
			else
			{
				skipSpellId = itr->second->spellId;
				oldSpellId = 0;
			}
		}

		// xinef: check if we have something to remove yet
		if (oldSpellId)
			RemoveAurasDueToSpell(oldSpellId);
	}

	UpdateForQuestWorldObjects();
}

QuestGiverStatus Player::GetQuestDialogStatus(Object* questgiver)
{
	QuestRelationBounds qr;
	QuestRelationBounds qir;

	switch (questgiver->GetTypeId())
	{
	case TYPEID_GAMEOBJECT:
	{
		QuestGiverStatus questStatus = QuestGiverStatus(sScriptMgr->GetDialogStatus(this, questgiver->ToGameObject()));
		if (questStatus != DIALOG_STATUS_SCRIPTED_NO_STATUS)
			return questStatus;
		qr = sObjectMgr->GetGOQuestRelationBounds(questgiver->GetEntry());
		qir = sObjectMgr->GetGOQuestInvolvedRelationBounds(questgiver->GetEntry());
		break;
	}
	case TYPEID_UNIT:
	{
		QuestGiverStatus questStatus = QuestGiverStatus(sScriptMgr->GetDialogStatus(this, questgiver->ToCreature()));
		if (questStatus != DIALOG_STATUS_SCRIPTED_NO_STATUS)
			return questStatus;
		qr = sObjectMgr->GetCreatureQuestRelationBounds(questgiver->GetEntry());
		qir = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(questgiver->GetEntry());
		break;
	}
	default:
		// it's impossible, but check
		//TC_LOG_ERROR("entities.player.quest", "GetQuestDialogStatus called for unexpected type %u", questgiver->GetTypeId());
		return DIALOG_STATUS_NONE;
	}

	QuestGiverStatus result = DIALOG_STATUS_NONE;

	for (QuestRelations::const_iterator i = qir.first; i != qir.second; ++i)
	{
		QuestGiverStatus result2 = DIALOG_STATUS_NONE;
		uint32 questId = i->second;
		Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
		if (!quest)
			continue;

		ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_SHOW_MARK, quest->GetQuestId());
		if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
			continue;

		QuestStatus status = GetQuestStatus(questId);
		if ((status == QUEST_STATUS_COMPLETE && !GetQuestRewardStatus(questId)) ||
			(quest->IsAutoComplete() && CanTakeQuest(quest, false)))
		{
			if (quest->IsAutoComplete() && quest->IsRepeatable() && !quest->IsDailyOrWeekly())
				result2 = DIALOG_STATUS_REWARD_REP;
			else
				result2 = DIALOG_STATUS_REWARD;
		}
		else if (status == QUEST_STATUS_INCOMPLETE)
			result2 = DIALOG_STATUS_INCOMPLETE;

		if (result2 > result)
			result = result2;
	}

	for (QuestRelations::const_iterator i = qr.first; i != qr.second; ++i)
	{
		QuestGiverStatus result2 = DIALOG_STATUS_NONE;
		uint32 questId = i->second;
		Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
		if (!quest)
			continue;

		ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_SHOW_MARK, quest->GetQuestId());
		if (!sConditionMgr->IsObjectMeetToConditions(this, conditions))
			continue;

		QuestStatus status = GetQuestStatus(questId);
		if (status == QUEST_STATUS_NONE)
		{
			if (CanSeeStartQuest(quest))
			{
				if (SatisfyQuestLevel(quest, false))
				{
					if (quest->IsAutoComplete())
						result2 = DIALOG_STATUS_REWARD_REP;
					else if (getLevel() <= (GetQuestLevel(quest) + sWorld->getIntConfig(CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF)))
					{
						if (quest->IsDaily())
							result2 = DIALOG_STATUS_AVAILABLE_REP;
						else
							result2 = DIALOG_STATUS_AVAILABLE;
					}
					else
						result2 = DIALOG_STATUS_LOW_LEVEL_AVAILABLE;
				}
				else
					result2 = DIALOG_STATUS_UNAVAILABLE;
			}
		}

		if (result2 > result)
			result = result2;
	}

	return result;
}

// not used in Trinity, but used in scripting code
uint16 Player::GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry)
{
	Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest_id);
	if (!qInfo)
		return 0;

	for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
		if (qInfo->RequiredNpcOrGo[j] == entry)
			return m_QuestStatus[quest_id].CreatureOrGOCount[j];

	return 0;
}

void Player::AdjustQuestReqItemCount(Quest const* quest, QuestStatusData& questStatusData)
{
	if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
	{
		for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
		{
			uint32 reqitemcount = quest->RequiredItemCount[i];
			if (reqitemcount != 0)
			{
				uint32 curitemcount = GetItemCount(quest->RequiredItemId[i], true);

				questStatusData.ItemCount[i] = std::min(curitemcount, reqitemcount);
				m_QuestStatusSave[quest->GetQuestId()] = true;
			}
		}
	}
}

uint16 Player::FindQuestSlot(uint32 quest_id) const
{
	for (uint16 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
		if (GetQuestSlotQuestId(i) == quest_id)
			return i;

	return MAX_QUEST_LOG_SIZE;
}

void Player::AreaExploredOrEventHappens(uint32 questId)
{
	if (questId)
	{
		uint16 log_slot = FindQuestSlot(questId);
		QuestStatusData* q_status = NULL;
		if (log_slot < MAX_QUEST_LOG_SIZE)
		{
			q_status = &m_QuestStatus[questId];

			// xinef: added failed check
			if (!q_status->Explored && q_status->Status != QUEST_STATUS_FAILED)
			{
				q_status->Explored = true;
				m_QuestStatusSave[questId] = true;

				// xinef: if we cannot complete quest send exploration succeded
				if (!CanCompleteQuest(questId, q_status))
					SendQuestComplete(questId);
			}
		}
		if (CanCompleteQuest(questId, q_status))
			CompleteQuest(questId);
		else
			AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);
	}
}

//not used in Trinityd, function for external script library
void Player::GroupEventHappens(uint32 questId, WorldObject const* pEventObject)
{
	if (Group* group = GetGroup())
	{
		for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
		{
			Player* player = itr->GetSource();

			// for any leave or dead (with not released body) group member at appropriate distance
			if (player && player->IsAtGroupRewardDistance(pEventObject) && !player->GetCorpse())
				player->AreaExploredOrEventHappens(questId);
		}
	}
	else
		AreaExploredOrEventHappens(questId);
}

void Player::ItemAddedQuestCheck(uint32 entry, uint32 count)
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (questid == 0)
			continue;

		QuestStatusData& q_status = m_QuestStatus[questid];

		if (q_status.Status != QUEST_STATUS_INCOMPLETE)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo || !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
			continue;

		for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
		{
			uint32 reqitem = qInfo->RequiredItemId[j];
			if (reqitem == entry)
			{
				uint32 reqitemcount = qInfo->RequiredItemCount[j];
				uint16 curitemcount = q_status.ItemCount[j];
				if (curitemcount < reqitemcount)
				{
					q_status.ItemCount[j] = std::min<uint16>(q_status.ItemCount[j] + count, reqitemcount);
					m_QuestStatusSave[questid] = true;
				}
				if (CanCompleteQuest(questid))
					CompleteQuest(questid);
				else
					AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD | ADDITIONAL_SAVING_QUEST_STATUS);
				return;
			}
		}
	}
	UpdateForQuestWorldObjects();
}

void Player::ItemRemovedQuestCheck(uint32 entry, uint32 count)
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo)
			continue;

		if (!qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER))
			continue;

		for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
		{
			uint32 reqitem = qInfo->RequiredItemId[j];
			if (reqitem == entry)
			{
				QuestStatusData& q_status = m_QuestStatus[questid];
				uint32 reqitemcount = qInfo->RequiredItemCount[j];
				uint16 curitemcount = q_status.ItemCount[j];

				if (q_status.ItemCount[j] >= reqitemcount) // we may have more than what the status shows
					curitemcount = GetItemCount(entry, false);

				uint16 newItemCount = (count > curitemcount) ? 0 : curitemcount - count;
				newItemCount = std::min<uint16>(newItemCount, reqitemcount);
				if (newItemCount != q_status.ItemCount[j])
				{
					q_status.ItemCount[j] = newItemCount;
					m_QuestStatusSave[questid] = true;
					IncompleteQuest(questid);
				}
				return;
			}
		}
	}
	UpdateForQuestWorldObjects();
}

void Player::KilledMonster(CreatureTemplate const* cInfo, uint64 guid)
{
	ASSERT(cInfo);

	if (cInfo->Entry)
		KilledMonsterCredit(cInfo->Entry, guid);

	for (uint8 i = 0; i < MAX_KILL_CREDIT; ++i)
		if (cInfo->KillCredit[i])
			KilledMonsterCredit(cInfo->KillCredit[i], 0);
}

void Player::KilledMonsterCredit(uint32 entry, uint64 guid)
{
	uint16 addkillcount = 1;
	uint32 real_entry = entry;
	if (guid)
	{
		Creature* killed = GetMap()->GetCreature(guid);
		if (killed && killed->GetEntry())
			real_entry = killed->GetEntry();
	}

	StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_CREATURE, real_entry);   // MUST BE CALLED FIRST
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, real_entry, addkillcount, guid ? GetMap()->GetCreature(guid) : NULL);

	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo)
			continue;
		// just if !ingroup || !noraidgroup || raidgroup
		// xinef: or is pvp quest, and player in BG/BF group
		QuestStatusData& q_status = m_QuestStatus[questid];
		if (q_status.Status == QUEST_STATUS_INCOMPLETE && (!GetGroup() || !GetGroup()->isRaidGroup() || qInfo->IsAllowedInRaid(GetMap()->GetDifficulty()) ||
			(qInfo->IsPVPQuest() && (GetGroup()->isBFGroup() || GetGroup()->isBGGroup()))))
		{
			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL) /*&& !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST)*/)
			{
				for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
				{
					// skip GO activate objective or none
					if (qInfo->RequiredNpcOrGo[j] <= 0)
						continue;

					uint32 reqkill = qInfo->RequiredNpcOrGo[j];

					if (reqkill == real_entry)
					{
						uint32 reqkillcount = qInfo->RequiredNpcOrGoCount[j];
						uint16 curkillcount = q_status.CreatureOrGOCount[j];
						if (curkillcount < reqkillcount)
						{
							q_status.CreatureOrGOCount[j] = curkillcount + addkillcount;

							m_QuestStatusSave[questid] = true;

							SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curkillcount, addkillcount);
						}
						if (CanCompleteQuest(questid))
							CompleteQuest(questid);
						else
							AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

						// same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
						break;
					}
				}
			}
		}
	}
}

void Player::KilledPlayerCredit()
{
	uint16 addkillcount = 1;

	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo)
			continue;
		// just if !ingroup || !noraidgroup || raidgroup
		QuestStatusData& q_status = m_QuestStatus[questid];
		if (q_status.Status == QUEST_STATUS_INCOMPLETE && (!GetGroup() || !GetGroup()->isRaidGroup() || qInfo->IsAllowedInRaid(GetMap()->GetDifficulty())))
		{
			// Xinef: PvP Killing quest require player to be in same zone as quest zone (only 2 quests so no doubt, can be extended to conditions in cata ;s)
			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL) && GetZoneId() == qInfo->GetZoneOrSort())
			{
				uint32 reqkill = qInfo->GetPlayersSlain();
				uint16 curkill = q_status.PlayerCount;

				if (curkill < reqkill)
				{
					q_status.PlayerCount = curkill + addkillcount;

					m_QuestStatusSave[questid] = true;

					SendQuestUpdateAddPlayer(qInfo, curkill, addkillcount);
				}

				if (CanCompleteQuest(questid))
					CompleteQuest(questid);

				break;
			}
		}
	}
}

void Player::KillCreditGO(uint32 entry, uint64 guid)
{
	bool isCreature = IS_CRE_OR_VEH_GUID(guid);

	uint16 addCastCount = 1;
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo)
			continue;

		QuestStatusData& q_status = m_QuestStatus[questid];

		if (q_status.Status == QUEST_STATUS_INCOMPLETE)
		{
			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST) /*&& !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL)*/)
			{
				for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
				{
					uint32 reqTarget = 0;

					// GO activate objective
					if (qInfo->RequiredNpcOrGo[j] < 0)
						// checked at quest_template loading
						reqTarget = -qInfo->RequiredNpcOrGo[j];

					// other not this creature/GO related objectives
					if (reqTarget != entry)
						continue;

					uint32 reqCastCount = qInfo->RequiredNpcOrGoCount[j];
					uint16 curCastCount = q_status.CreatureOrGOCount[j];
					if (curCastCount < reqCastCount)
					{
						q_status.CreatureOrGOCount[j] = curCastCount + addCastCount;

						m_QuestStatusSave[questid] = true;

						SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curCastCount, addCastCount);
					}

					if (CanCompleteQuest(questid))
						CompleteQuest(questid);
					else
						AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

					// same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
					break;
				}
			}
		}
	}
}

void Player::TalkedToCreature(uint32 entry, uint64 guid)
{
	uint16 addTalkCount = 1;
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (!qInfo)
			continue;

		QuestStatusData& q_status = m_QuestStatus[questid];

		if (q_status.Status == QUEST_STATUS_INCOMPLETE)
		{
			if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO))
			{
				for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
				{
					// skip Gameobject objectives
					if (qInfo->RequiredNpcOrGo[j] < 0)
						continue;

					uint32 reqTarget = 0;

					if (qInfo->RequiredNpcOrGo[j] > 0)    // creature activate objectives
															// checked at quest_template loading
						reqTarget = qInfo->RequiredNpcOrGo[j];
					else
						continue;

					if (reqTarget == entry)
					{
						uint32 reqTalkCount = qInfo->RequiredNpcOrGoCount[j];
						uint16 curTalkCount = q_status.CreatureOrGOCount[j];
						if (curTalkCount < reqTalkCount)
						{
							q_status.CreatureOrGOCount[j] = curTalkCount + addTalkCount;

							m_QuestStatusSave[questid] = true;

							SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curTalkCount, addTalkCount);
						}
						if (CanCompleteQuest(questid))
							CompleteQuest(questid);
						else
							AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

						// same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
						continue;
					}
				}
			}
		}
	}
}

void Player::MoneyChanged(uint32 count)
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (!questid)
			continue;

		Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
		if (qInfo && qInfo->GetRewOrReqMoney() < 0)
		{
			QuestStatusData& q_status = m_QuestStatus[questid];

			if (q_status.Status == QUEST_STATUS_INCOMPLETE)
			{
				if (int32(count) >= -qInfo->GetRewOrReqMoney())
				{
					if (CanCompleteQuest(questid))
						CompleteQuest(questid);
				}
			}
			else if (q_status.Status == QUEST_STATUS_COMPLETE)
			{
				if (int32(count) < -qInfo->GetRewOrReqMoney())
					IncompleteQuest(questid);
			}
		}
	}
}

void Player::ReputationChanged(FactionEntry const* factionEntry)
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		if (uint32 questid = GetQuestSlotQuestId(i))
		{
			if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid))
			{
				if (qInfo->GetRepObjectiveFaction() == factionEntry->ID)
				{
					QuestStatusData& q_status = m_QuestStatus[questid];
					if (q_status.Status == QUEST_STATUS_INCOMPLETE)
					{
						if (GetReputationMgr().GetReputation(factionEntry) >= qInfo->GetRepObjectiveValue())
							if (CanCompleteQuest(questid))
								CompleteQuest(questid);
					}
					else if (q_status.Status == QUEST_STATUS_COMPLETE)
					{
						if (GetReputationMgr().GetReputation(factionEntry) < qInfo->GetRepObjectiveValue())
							IncompleteQuest(questid);
					}
				}
			}
		}
	}
}

void Player::ReputationChanged2(FactionEntry const* factionEntry)
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		if (uint32 questid = GetQuestSlotQuestId(i))
		{
			if (Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid))
			{
				if (qInfo->GetRepObjectiveFaction2() == factionEntry->ID)
				{
					QuestStatusData& q_status = m_QuestStatus[questid];
					if (q_status.Status == QUEST_STATUS_INCOMPLETE)
					{
						if (GetReputationMgr().GetReputation(factionEntry) >= qInfo->GetRepObjectiveValue2())
							if (CanCompleteQuest(questid))
								CompleteQuest(questid);
					}
					else if (q_status.Status == QUEST_STATUS_COMPLETE)
					{
						if (GetReputationMgr().GetReputation(factionEntry) < qInfo->GetRepObjectiveValue2())
							IncompleteQuest(questid);
					}
				}
			}
		}
	}
}

bool Player::HasQuestForItem(uint32 itemid) const
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (questid == 0)
			continue;

		QuestStatusMap::const_iterator qs_itr = m_QuestStatus.find(questid);
		if (qs_itr == m_QuestStatus.end())
			continue;

		QuestStatusData const& q_status = qs_itr->second;

		if (q_status.Status == QUEST_STATUS_INCOMPLETE)
		{
			Quest const* qinfo = sObjectMgr->GetQuestTemplate(questid);
			if (!qinfo)
				continue;

			// hide quest if player is in raid-group and quest is no raid quest
			if (GetGroup() && GetGroup()->isRaidGroup() && !qinfo->IsAllowedInRaid(GetMap()->GetDifficulty()))
				if (!InBattleground()) //there are two ways.. we can make every bg-quest a raidquest, or add this code here.. i don't know if this can be exploited by other quests, but i think all other quests depend on a specific area.. but keep this in mind, if something strange happens later
					continue;

			// There should be no mixed ReqItem/ReqSource drop
			// This part for ReqItem drop
			for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
			{
				if (itemid == qinfo->RequiredItemId[j] && q_status.ItemCount[j] < qinfo->RequiredItemCount[j])
					return true;
			}
			// This part - for ReqSource
			for (uint8 j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; ++j)
			{
				// examined item is a source item
				if (qinfo->RequiredSourceItemId[j] == itemid)
				{
					ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(itemid);

					// 'unique' item
					if (pProto->MaxCount && int32(GetItemCount(itemid, true)) < pProto->MaxCount)
						return true;

					// allows custom amount drop when not 0
					if (qinfo->RequiredSourceItemCount[j])
					{
						if (GetItemCount(itemid, true) < qinfo->RequiredSourceItemCount[j])
							return true;
					}
					else if (GetItemCount(itemid, true) < pProto->GetMaxStackSize())
						return true;
				}
			}
		}
	}
	return false;
}

void Player::SendQuestComplete(uint32 quest_id)
{
	if (quest_id)
	{
		WorldPacket data(SMSG_QUESTUPDATE_COMPLETE, 4);
		data << uint32(quest_id);
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTUPDATE_COMPLETE quest = %u", quest_id);
	}
}

void Player::SendQuestReward(Quest const* quest, uint32 XP)
{
	uint32 questid = quest->GetQuestId();
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTGIVER_QUEST_COMPLETE quest = %u", questid);
	sGameEventMgr->HandleQuestComplete(questid);
	WorldPacket data(SMSG_QUESTGIVER_QUEST_COMPLETE, (4 + 4 + 4 + 4 + 4));
	data << uint32(questid);

	if (getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
	{
		data << uint32(XP);
		data << uint32(quest->GetRewOrReqMoney());
	}
	else
	{
		data << uint32(0);
		data << uint32(quest->GetRewOrReqMoney() + int32(quest->GetRewMoneyMaxLevel() * sWorld->getRate(RATE_DROP_MONEY)));
	}

	data << uint32(10 * quest->CalculateHonorGain(GetQuestLevel(quest)));
	data << uint32(quest->GetBonusTalents());              // bonus talents
	data << uint32(quest->GetRewArenaPoints());
	GetSession()->SendPacket(&data);
}

void Player::SendQuestFailed(uint32 questId, InventoryResult reason)
{
	if (questId)
	{
		WorldPacket data(SMSG_QUESTGIVER_QUEST_FAILED, 4 + 4);
		data << uint32(questId);
		data << uint32(reason);                             // failed reason (valid reasons: 4, 16, 50, 17, 74, other values show default message)
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTGIVER_QUEST_FAILED");
	}
}

void Player::SendQuestTimerFailed(uint32 quest_id)
{
	if (quest_id)
	{
		WorldPacket data(SMSG_QUESTUPDATE_FAILEDTIMER, 4);
		data << uint32(quest_id);
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTUPDATE_FAILEDTIMER");
	}
}

void Player::SendCanTakeQuestResponse(uint32 msg) const
{
	WorldPacket data(SMSG_QUESTGIVER_QUEST_INVALID, 4);
	data << uint32(msg);
	GetSession()->SendPacket(&data);
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTGIVER_QUEST_INVALID");
}

void Player::SendQuestConfirmAccept(const Quest* quest, Player* pReceiver)
{
	if (pReceiver)
	{
		WorldPacket data(SMSG_QUEST_CONFIRM_ACCEPT, (4 + quest->GetTitle().size() + 8));
		data << uint32(quest->GetQuestId());
		data << quest->GetTitle();
		data << uint64(GetGUID());
		pReceiver->GetSession()->SendPacket(&data);

		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUEST_CONFIRM_ACCEPT");
	}
}

void Player::SendPushToPartyResponse(Player* player, uint8 msg)
{
	if (player)
	{
		WorldPacket data(MSG_QUEST_PUSH_RESULT, (8 + 1));
		data << uint64(player->GetGUID());
		data << uint8(msg);                                 // valid values: 0-8
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent MSG_QUEST_PUSH_RESULT");
	}
}

void Player::SendQuestUpdateAddItem(Quest const* /*quest*/, uint32 /*item_idx*/, uint16 /*count*/)
{
	WorldPacket data(SMSG_QUESTUPDATE_ADD_ITEM, 0);
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTUPDATE_ADD_ITEM");
	//data << quest->RequiredItemId[item_idx];
	//data << count;
	GetSession()->SendPacket(&data);
}

void Player::SendQuestUpdateAddCreatureOrGo(Quest const* quest, uint64 guid, uint32 creatureOrGO_idx, uint16 old_count, uint16 add_count)
{
	ASSERT(old_count + add_count < 65536 && "mob/GO count store in 16 bits 2^16 = 65536 (0..65536)");

	int32 entry = quest->RequiredNpcOrGo[creatureOrGO_idx];
	if (entry < 0)
		// client expected gameobject template id in form (id|0x80000000)
		entry = (-entry) | 0x80000000;

	WorldPacket data(SMSG_QUESTUPDATE_ADD_KILL, (4 * 4 + 8));
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTUPDATE_ADD_KILL");
	data << uint32(quest->GetQuestId());
	data << uint32(entry);
	data << uint32(old_count + add_count);
	data << uint32(quest->RequiredNpcOrGoCount[creatureOrGO_idx]);
	data << uint64(guid);
	GetSession()->SendPacket(&data);

	uint16 log_slot = FindQuestSlot(quest->GetQuestId());
	if (log_slot < MAX_QUEST_LOG_SIZE)
		SetQuestSlotCounter(log_slot, creatureOrGO_idx, GetQuestSlotCounter(log_slot, creatureOrGO_idx) + add_count);
}

void Player::SendQuestUpdateAddPlayer(Quest const* quest, uint16 old_count, uint16 add_count)
{
	ASSERT(old_count + add_count < 65536 && "player count store in 16 bits");

	WorldPacket data(SMSG_QUESTUPDATE_ADD_PVP_KILL, (3 * 4));
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_QUESTUPDATE_ADD_PVP_KILL");
	data << uint32(quest->GetQuestId());
	data << uint32(old_count + add_count);
	data << uint32(quest->GetPlayersSlain());
	GetSession()->SendPacket(&data);

	uint16 log_slot = FindQuestSlot(quest->GetQuestId());
	if (log_slot < MAX_QUEST_LOG_SIZE)
		SetQuestSlotCounter(log_slot, QUEST_PVP_KILL_SLOT, GetQuestSlotCounter(log_slot, QUEST_PVP_KILL_SLOT) + add_count);
}

bool Player::HasPvPForcingQuest() const
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questId = GetQuestSlotQuestId(i);
		if (questId == 0)
			continue;

		Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
		if (!quest)
			continue;

		if (quest->HasFlag(QUEST_FLAGS_FLAGS_PVP))
			return true;
	}

	return false;
}

/*********************************************************/
/***                   LOAD SYSTEM                     ***/
/*********************************************************/

void Player::Initialize(uint32 guid)
{
	Object::_Create(guid, 0, HIGHGUID_PLAYER);
}

void Player::_LoadDeclinedNames(PreparedQueryResult result)
{
	if (!result)
		return;

	delete m_declinedname;
	m_declinedname = new DeclinedName;
	for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
		m_declinedname->name[i] = (*result)[i].GetString();
}

void Player::_LoadArenaTeamInfo()
{
	memset((void*)&m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1], 0, sizeof(uint32) * MAX_ARENA_SLOT * ARENA_TEAM_END);

	for (uint8 slot = 0; slot <= 2; ++slot)
		if (uint32 arenaTeamId = Player::GetArenaTeamIdFromStorage(GetGUIDLow(), slot))
		{
			ArenaTeam* arenaTeam = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
			if (!arenaTeam) // some shit, should be assert, but just ignore
				continue;
			ArenaTeamMember const* member = arenaTeam->GetMember(GetGUID());
			if (!member) // some shit, should be assert, but just ignore
				continue;

			SetArenaTeamInfoField(slot, ARENA_TEAM_ID, arenaTeamId);
			SetArenaTeamInfoField(slot, ARENA_TEAM_TYPE, arenaTeam->GetType());
			SetArenaTeamInfoField(slot, ARENA_TEAM_MEMBER, (arenaTeam->GetCaptain() == GetGUID()) ? 0 : 1);
			SetArenaTeamInfoField(slot, ARENA_TEAM_GAMES_WEEK, member->WeekGames);
			SetArenaTeamInfoField(slot, ARENA_TEAM_GAMES_SEASON, member->SeasonGames);
			SetArenaTeamInfoField(slot, ARENA_TEAM_WINS_SEASON, member->SeasonWins);
			SetArenaTeamInfoField(slot, ARENA_TEAM_PERSONAL_RATING, member->PersonalRating);
		}
}

void Player::_LoadEquipmentSets(PreparedQueryResult result)
{
	// SetPQuery(PLAYER_LOGIN_QUERY_LOADEQUIPMENTSETS,   "SELECT setguid, setindex, name, iconname, item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18 FROM character_equipmentsets WHERE guid = '%u' ORDER BY setindex", GUID_LOPART(m_guid));
	if (!result)
		return;

	uint32 count = 0;
	do
	{
		Field* fields = result->Fetch();
		EquipmentSet eqSet;

		eqSet.Guid = fields[0].GetUInt64();
		uint8 index = fields[1].GetUInt8();
		eqSet.Name = fields[2].GetString();
		eqSet.IconName = fields[3].GetString();
		eqSet.IgnoreMask = fields[4].GetUInt32();
		eqSet.state = EQUIPMENT_SET_UNCHANGED;

		for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
			eqSet.Items[i] = fields[5 + i].GetUInt32();

		m_EquipmentSets[index] = eqSet;

		++count;

		if (count >= MAX_EQUIPMENT_SET_INDEX)                // client limit
			break;
	} while (result->NextRow());
}

void Player::_LoadEntryPointData(PreparedQueryResult result)
{
	if (!result)
		return;

	Field* fields = result->Fetch();
	m_entryPointData.joinPos = WorldLocation(fields[4].GetUInt32(),  // Map
		fields[0].GetFloat(),   // X
		fields[1].GetFloat(),   // Y
		fields[2].GetFloat(),   // Z
		fields[3].GetFloat());  // Orientation

	std::string taxi = fields[5].GetString();
	if (!taxi.empty())
	{
		Tokenizer tokens(taxi, ' ');
		for (Tokenizer::const_iterator iter = tokens.begin(); iter != tokens.end(); ++iter)
		{
			uint32 node = uint32(atol(*iter));
			m_entryPointData.taxiPath.push_back(node);
		}

		// Check integrity
		if (m_entryPointData.taxiPath.size() < 3)
			m_entryPointData.ClearTaxiPath();
	}

	m_entryPointData.mountSpell = fields[6].GetUInt32();
}

bool Player::LoadPositionFromDB(uint32& mapid, float& x, float& y, float& z, float& o, bool& in_flight, uint64 guid)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_POSITION);
	stmt->setUInt32(0, GUID_LOPART(guid));
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result)
		return false;

	Field* fields = result->Fetch();

	x = fields[0].GetFloat();
	y = fields[1].GetFloat();
	z = fields[2].GetFloat();
	o = fields[3].GetFloat();
	mapid = fields[4].GetUInt16();
	in_flight = !fields[5].GetString().empty();

	return true;
}

void Player::SetHomebind(WorldLocation const& loc, uint32 areaId)
{
	loc.GetPosition(m_homebindX, m_homebindY, m_homebindZ);
	m_homebindMapId = loc.GetMapId();
	m_homebindAreaId = areaId;

	// update sql homebind
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_PLAYER_HOMEBIND);
	stmt->setUInt16(0, m_homebindMapId);
	stmt->setUInt16(1, m_homebindAreaId);
	stmt->setFloat(2, m_homebindX);
	stmt->setFloat(3, m_homebindY);
	stmt->setFloat(4, m_homebindZ);
	stmt->setUInt32(5, GetGUIDLow());
	CharacterDatabase.Execute(stmt);
}

uint32 Player::GetUInt32ValueFromArray(Tokenizer const& data, uint16 index)
{
	if (index >= data.size())
		return 0;

	return (uint32)atoi(data[index]);
}

float Player::GetFloatValueFromArray(Tokenizer const& data, uint16 index)
{
	float result;
	uint32 temp = Player::GetUInt32ValueFromArray(data, index);
	memcpy(&result, &temp, sizeof(result));

	return result;
}

bool Player::isBeingLoaded() const
{
	return GetSession()->PlayerLoading();
}

bool Player::LoadFromDB(uint32 guid, SQLQueryHolder *holder)
{
	////                                                     0     1        2     3     4        5      6    7      8     9           10              11
	//QueryResult* result = CharacterDatabase.PQuery("SELECT guid, account, name, race, class, gender, level, xp, money, playerBytes, playerBytes2, playerFlags, "
	 // 12          13          14          15   16           17        18        19         20         21          22           23                 24
	//"position_x, position_y, position_z, map, orientation, taximask, cinematic, totaltime, leveltime, rest_bonus, logout_time, is_logout_resting, resettalents_cost, "
	// 25                 26       27       28       29       30         31           32             33        34    35      36                 37         38
	//"resettalents_time, trans_x, trans_y, trans_z, trans_o, transguid, extra_flags, stable_slots, at_login, zone, online, death_expire_time, taxi_path, instance_mode_mask, "
	// 39           40                41                 42                    43          44          45              46           47               48              49
	//"arenaPoints, totalHonorPoints, todayHonorPoints, yesterdayHonorPoints, totalKills, todayKills, yesterdayKills, chosenTitle, knownCurrencies, watchedFaction, drunk, "
	// 50      51      52      53      54      55      56      57      58           59                 60                 61             62              63      64           65          66
	//"health, power1, power2, power3, power4, power5, power6, power7, instance_id, talentGroupsCount, activeTalentGroup, exploredZones, equipmentCache, ammoId, knownTitles, actionBars, grantableLevels FROM characters WHERE guid = '%u'", guid);
	PreparedQueryResult result = holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_FROM);

	if (!result)
	{
		sLog->outError("Player (GUID: %u) not found in table `characters`, can't load. ", guid);
		return false;
	}

	Field* fields = result->Fetch();

	uint32 dbAccountId = fields[1].GetUInt32();

	// check if the character's account in the db and the logged in account match.
	// player should be able to load/delete character only with correct account!
	if (dbAccountId != GetSession()->GetAccountId())
	{
		sLog->outError("Player (GUID: %u) loading from wrong account (is: %u, should be: %u)", guid, GetSession()->GetAccountId(), dbAccountId);
		return false;
	}

	if (holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_BANNED))
	{
		sLog->outError("Player (GUID: %u) is banned, can't load.", guid);
		return false;
	}

	Object::_Create(guid, 0, HIGHGUID_PLAYER);

	m_name = fields[2].GetString();

	// check name limitations
	if (ObjectMgr::CheckPlayerName(m_name) != CHAR_NAME_SUCCESS ||
		(AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()) && sObjectMgr->IsReservedName(m_name)))
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
		stmt->setUInt16(0, uint16(AT_LOGIN_RENAME));
		stmt->setUInt32(1, guid);
		CharacterDatabase.Execute(stmt);
		return false;
	}

	// overwrite possible wrong/corrupted guid
	SetUInt64Value(OBJECT_FIELD_GUID, MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));

	uint8 Gender = fields[5].GetUInt8();
	if (!IsValidGender(Gender))
	{
		sLog->outError("Player (GUID: %u) has wrong gender (%hu), can't be loaded.", guid, Gender);
		return false;
	}

	// overwrite some data fields
	uint32 bytes0 = 0;
	bytes0 |= fields[3].GetUInt8();                         // race
	bytes0 |= fields[4].GetUInt8() << 8;                    // class
	bytes0 |= Gender << 16;                                 // gender
	SetUInt32Value(UNIT_FIELD_BYTES_0, bytes0);

	m_realRace = fields[3].GetUInt8(); // set real race
	m_race = fields[3].GetUInt8(); // set real race

	SetUInt32Value(UNIT_FIELD_LEVEL, fields[6].GetUInt8());
	SetUInt32Value(PLAYER_XP, fields[7].GetUInt32());

	_LoadIntoDataField(fields[61].GetCString(), PLAYER_EXPLORED_ZONES_1, PLAYER_EXPLORED_ZONES_SIZE);
	_LoadIntoDataField(fields[64].GetCString(), PLAYER__FIELD_KNOWN_TITLES, KNOWN_TITLES_SIZE * 2);

	SetObjectScale(1.0f);
	SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 1.0f);

	// load achievements before anything else to prevent multiple gains for the same achievement/criteria on every loading (as loading does call UpdateAchievementCriteria)
	m_achievementMgr->LoadFromDB(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACHIEVEMENTS), holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_CRITERIA_PROGRESS));

	uint32 money = fields[8].GetUInt32();
	if (money > MAX_MONEY_AMOUNT)
		money = MAX_MONEY_AMOUNT;
	SetMoney(money);

	SetUInt32Value(PLAYER_BYTES, fields[9].GetUInt32());
	SetUInt32Value(PLAYER_BYTES_2, fields[10].GetUInt32());
	SetByteValue(PLAYER_BYTES_3, 0, fields[5].GetUInt8());
	SetByteValue(PLAYER_BYTES_3, 1, fields[49].GetUInt8());
	SetUInt32Value(PLAYER_FLAGS, fields[11].GetUInt32());
	SetInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, fields[48].GetUInt32());

	SetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES, fields[47].GetUInt64());

	SetUInt32Value(PLAYER_AMMO_ID, fields[63].GetUInt32());

	// set which actionbars the client has active - DO NOT REMOVE EVER AGAIN (can be changed though, if it does change fieldwise)
	SetByteValue(PLAYER_FIELD_BYTES, 2, fields[65].GetUInt8());

	InitDisplayIds();

	// cleanup inventory related item value fields (its will be filled correctly in _LoadInventory)
	for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
	{
		SetUInt64Value(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), 0);
		SetVisibleItemSlot(slot, NULL);

		delete m_items[slot];
		m_items[slot] = NULL;
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Load Basic value of player %s is: ", m_name.c_str());
	outDebugValues();

	//Need to call it to initialize m_team (m_team can be calculated from race)
	//Other way is to saves m_team into characters table.
	setFactionForRace(getRace(true));

	// pussywizard: create empty instance bind containers if necessary
	sInstanceSaveMgr->PlayerCreateBoundInstancesMaps(guid);

	// load home bind and check in same time class/race pair, it used later for restore broken positions
	if (!_LoadHomeBind(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_HOME_BIND)))
		return false;

	InitPrimaryProfessions();                               // to max set before any spell loaded

	// init saved position, and fix it later if problematic
	uint32 transLowGUID = fields[30].GetUInt32();
	Relocate(fields[12].GetFloat(), fields[13].GetFloat(), fields[14].GetFloat(), fields[16].GetFloat());
	uint32 mapId = fields[15].GetUInt16();
	uint32 instanceId = fields[58].GetUInt32();

	uint32 dungeonDiff = fields[38].GetUInt8() & 0x0F;
	if (dungeonDiff >= MAX_DUNGEON_DIFFICULTY)
		dungeonDiff = DUNGEON_DIFFICULTY_NORMAL;
	uint32 raidDiff = (fields[38].GetUInt8() >> 4) & 0x0F;
	if (raidDiff >= MAX_RAID_DIFFICULTY)
		raidDiff = RAID_DIFFICULTY_10MAN_NORMAL;
	SetDungeonDifficulty(Difficulty(dungeonDiff));          // may be changed in _LoadGroup
	SetRaidDifficulty(Difficulty(raidDiff));                // may be changed in _LoadGroup

	std::string taxi_nodes = fields[37].GetString();

#define RelocateToHomebind(){ mapId = m_homebindMapId; instanceId = 0; Relocate(m_homebindX, m_homebindY, m_homebindZ); }

	_LoadGroup();

	_LoadArenaTeamInfo();

	SetArenaPoints(fields[39].GetUInt32());

	SetHonorPoints(fields[40].GetUInt32());
	SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, fields[41].GetUInt32());
	SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, fields[42].GetUInt32());
	SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, fields[43].GetUInt32());
	SetUInt16Value(PLAYER_FIELD_KILLS, 0, fields[44].GetUInt16());
	SetUInt16Value(PLAYER_FIELD_KILLS, 1, fields[45].GetUInt16());

	_LoadInstanceTimeRestrictions(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_INSTANCE_LOCK_TIMES));
	_LoadEntryPointData(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ENTRY_POINT));

	GetSession()->SetPlayer(this);
	MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);

	// pussywizard: group changed difficulty when player was offline, teleport to the enterance of new difficulty
	if (mapEntry && (mapEntry->IsNonRaidDungeon() && dungeonDiff != GetDungeonDifficulty() || mapEntry->IsRaid() && raidDiff != GetRaidDifficulty()))
	{
		bool fixed = false;
		if (uint32 destInstId = sInstanceSaveMgr->PlayerGetDestinationInstanceId(this, mapId, GetDifficulty(mapEntry->IsRaid())))
		{
			instanceId = destInstId;
			if (AreaTrigger const* at = sObjectMgr->GetMapEntranceTrigger(mapId))
			{
				Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
				fixed = true;
			}
		}
		if (!fixed)
		{
			RelocateToHomebind();
			mapEntry = sMapStore.LookupEntry(mapId);
		}
	}

	if (!mapEntry || !IsPositionValid())
	{
		sLog->outError("Player (guidlow %d) have invalid coordinates (MapId: %u X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
		RelocateToHomebind();
	}
	// Player was saved in Arena or Bg
	else if (mapEntry->IsBattlegroundOrArena())
	{
		// xinef: resurrect player, cant log in dead without corpse
		{
			if (HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
				RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
			if (!IsAlive())
				ResurrectPlayer(1.0f);
		}

		const WorldLocation& _loc = GetEntryPoint();
		mapId = _loc.GetMapId();
		instanceId = 0;

		if (mapId == MAPID_INVALID)
		{
			RelocateToHomebind();
		}
		else
		{
			Relocate(&_loc);

			// xinef: restore taxi flight from entry point data
			if (m_entryPointData.HasTaxiPath())
			{
				for (size_t i = 0; i < m_entryPointData.taxiPath.size() - 1; ++i)
					m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[i]);
				m_taxi.SetTaxiSegment(m_entryPointData.taxiPath[m_entryPointData.taxiPath.size() - 1]);

				m_entryPointData.ClearTaxiPath();
			}
		}
	}
	// currently we do not support transport in bg
	else if (transLowGUID)
	{
		uint64 transGUID = MAKE_NEW_GUID(transLowGUID, 0, HIGHGUID_MO_TRANSPORT);
		GameObject* transGO = HashMapHolder<GameObject>::Find(transGUID);
		if (!transGO) // pussywizard: if not MotionTransport, look for StaticTransport
		{
			transGUID = MAKE_NEW_GUID(transLowGUID, 0, HIGHGUID_TRANSPORT);
			transGO = HashMapHolder<GameObject>::Find(transGUID);
		}
		if (transGO)
			if (transGO->IsInWorld() && transGO->FindMap()) // pussywizard: must be on map, for one world tick transport is not in map and has old GetMapId(), player would be added to old map and to the transport, multithreading crashfix
				m_transport = transGO->ToTransport();

		if (m_transport)
		{
			float x = fields[26].GetFloat(), y = fields[27].GetFloat(), z = fields[28].GetFloat(), o = fields[29].GetFloat();
			m_movementInfo.transport.guid = transGUID;
			m_movementInfo.transport.pos.Relocate(x, y, z, o);
			m_transport->CalculatePassengerPosition(x, y, z, &o);

			if (!Trinity::IsValidMapCoord(x, y, z, o) || std::fabs(m_movementInfo.transport.pos.GetPositionX()) > 75.0f || std::fabs(m_movementInfo.transport.pos.GetPositionY()) > 75.0f || std::fabs(m_movementInfo.transport.pos.GetPositionZ()) > 75.0f)
			{
				m_transport = NULL;
				m_movementInfo.transport.Reset();
				m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
				RelocateToHomebind();
			}
			else
			{
				Relocate(x, y, z, o);
				mapId = m_transport->GetMapId();
				m_transport->AddPassenger(this);
				AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
			}
		}
		else
		{
			bool fixed = false;
			if (mapEntry->Instanceable())
				if (AreaTrigger const* at = sObjectMgr->GetMapEntranceTrigger(mapId))
				{
					fixed = true;
					Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
				}
			if (!fixed)
				RelocateToHomebind();
		}
	}
	// currently we do not support taxi in instance
	else if (!taxi_nodes.empty())
	{
		instanceId = 0;
		if (!m_taxi.LoadTaxiDestinationsFromString(taxi_nodes, GetTeamId(true)))
		{
			// xinef: could no load valid data for taxi, relocate to homebind and clear
			m_taxi.ClearTaxiDestinations();
			RelocateToHomebind();
		}
	}

	// Map could be changed before
	mapEntry = sMapStore.LookupEntry(mapId);
	// client without expansion support
	if (mapEntry)
	{
		if (GetSession()->Expansion() < mapEntry->Expansion())
		{
			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player %s using client without required expansion tried login at non accessible map %u", GetName().c_str(), mapId);
			RelocateToHomebind();
		}

		// check whether player was unbound or is bound to another instance
		if (instanceId)
		{
			InstanceSave* save = sInstanceSaveMgr->PlayerGetInstanceSave(GetGUIDLow(), mapId, GetDifficulty(mapEntry->IsRaid()));
			if (!save || save->GetInstanceId() != instanceId)
				instanceId = 0;
		}
	}

	// if the player is in an instance and it has been reset in the meantime teleport him to the entrance
	if ((instanceId && !sInstanceSaveMgr->GetInstanceSave(instanceId) && !mapEntry->IsBattlegroundOrArena()) || (!instanceId && mapEntry->IsDungeon()))
	{
		AreaTrigger const* at = sObjectMgr->GetMapEntranceTrigger(mapId);
		if (at)
			Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
		else
			RelocateToHomebind();
	}

	// NOW player must have valid map
	// load the player's map here if it's not already loaded
	Map* map = sMapMgr->CreateMap(mapId, this);

	if (!map)
	{
		instanceId = 0;
		AreaTrigger const* at = sObjectMgr->GetGoBackTrigger(mapId);
		if (at)
		{
			sLog->outError("Player (guidlow %d) is teleported to gobacktrigger (Map: %u X: %f Y: %f Z: %f O: %f).", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
			Relocate(at->target_X, at->target_Y, at->target_Z, GetOrientation());
			mapId = at->target_mapId;
		}
		else
		{
			sLog->outError("Player (guidlow %d) is teleported to home (Map: %u X: %f Y: %f Z: %f O: %f).", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
			RelocateToHomebind();
		}

		map = sMapMgr->CreateMap(mapId, this);
		if (!map)
		{
			PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
			mapId = info->mapId;
			Relocate(info->positionX, info->positionY, info->positionZ, 0.0f);
			sLog->outError("Player (guidlow %d) have invalid coordinates (X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.", guid, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
			map = sMapMgr->CreateMap(mapId, this);
			if (!map)
			{
				sLog->outError("Player (guidlow %d) has invalid default map coordinates (X: %f Y: %f Z: %f O: %f). or instance couldn't be created", guid, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
				return false;
			}
		}
	}

	SetMap(map);
	StoreRaidMapDifficulty();

	SaveRecallPosition();

	time_t now = time(NULL);
	time_t logoutTime = time_t(fields[22].GetUInt32());

	// since last logout (in seconds)
	uint32 time_diff = uint32(now - logoutTime); //uint64 is excessive for a time_diff in seconds.. uint32 allows for 136~ year difference.

	// set value, including drunk invisibility detection
	// calculate sobering. after 15 minutes logged out, the player will be sober again
	uint8 newDrunkValue = 0;
	if (time_diff < uint32(GetDrunkValue()) * 9)
		newDrunkValue = GetDrunkValue() - time_diff / 9;

	SetDrunkValue(newDrunkValue);

	m_cinematic = fields[18].GetUInt8();
	m_Played_time[PLAYED_TIME_TOTAL] = fields[19].GetUInt32();
	m_Played_time[PLAYED_TIME_LEVEL] = fields[20].GetUInt32();

	m_resetTalentsCost = fields[24].GetUInt32();
	m_resetTalentsTime = time_t(fields[25].GetUInt32());

	m_taxi.LoadTaxiMask(fields[17].GetCString());            // must be before InitTaxiNodesForLevel

	uint32 extraflags = fields[31].GetUInt16();

	m_stableSlots = fields[32].GetUInt8();
	if (m_stableSlots > MAX_PET_STABLES)
	{
		sLog->outError("Player can have not more %u stable slots, but have in DB %u", MAX_PET_STABLES, uint32(m_stableSlots));
		m_stableSlots = MAX_PET_STABLES;
	}

	m_atLoginFlags = fields[33].GetUInt16();

	if (HasAtLoginFlag(AT_LOGIN_RENAME))
	{
		sLog->outError("Player (GUID: %u) tried to login while forced to rename, can't load.'", GetGUIDLow());
		return false;
	}

	// Honor system
	// Update Honor kills data
	m_lastHonorUpdateTime = logoutTime;
	UpdateHonorFields();

	m_deathExpireTime = time_t(fields[36].GetUInt32());

	if (m_deathExpireTime > now + MAX_DEATH_COUNT * DEATH_EXPIRE_STEP)
		m_deathExpireTime = now + MAX_DEATH_COUNT * DEATH_EXPIRE_STEP - 1;

	// clear channel spell data (if saved at channel spell casting)
	SetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT, 0);
	SetUInt32Value(UNIT_CHANNEL_SPELL, 0);

	// clear charm/summon related fields
	SetOwnerGUID(0);
	SetUInt64Value(UNIT_FIELD_CHARMEDBY, 0);
	SetUInt64Value(UNIT_FIELD_CHARM, 0);
	SetUInt64Value(UNIT_FIELD_SUMMON, 0);
	SetUInt64Value(PLAYER_FARSIGHT, 0);
	SetCreatorGUID(0);

	RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FORCE_MOVEMENT);

	// reset some aura modifiers before aura apply
	SetUInt32Value(PLAYER_TRACK_CREATURES, 0);
	SetUInt32Value(PLAYER_TRACK_RESOURCES, 0);

	// make sure the unit is considered not in duel for proper loading
	SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
	SetUInt32Value(PLAYER_DUEL_TEAM, 0);

	// reset stats before loading any modifiers
	InitStatsForLevel();
	InitGlyphsForLevel();
	InitTaxiNodesForLevel();
	InitRunes();

	// make sure the unit is considered out of combat for proper loading
	ClearInCombat();

	// rest bonus can only be calculated after InitStatsForLevel()
	_restBonus = fields[21].GetFloat();

	if (time_diff > 0)
	{
		//speed collect rest bonus in offline, in logout, far from tavern, city (section/in hour)
		float bubble0 = 0.031f;
		//speed collect rest bonus in offline, in logout, in tavern, city (section/in hour)
		float bubble1 = 0.125f;
		float bubble = fields[23].GetUInt8() > 0
			? bubble1*sWorld->getRate(RATE_REST_OFFLINE_IN_TAVERN_OR_CITY)
			: bubble0*sWorld->getRate(RATE_REST_OFFLINE_IN_WILDERNESS);

		SetRestBonus(GetRestBonus() + time_diff*((float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP) / 72000)*bubble);
	}

	// load skills after InitStatsForLevel because it triggering aura apply also
	_LoadSkills(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SKILLS));
	UpdateSkillsForLevel(); //update skills after load, to make sure they are correctly update at player load

	// apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()

	//mails are loaded only when needed ;-) - when player in game click on mailbox.
	//_LoadMail();

	m_specsCount = fields[59].GetUInt8();
	m_activeSpec = fields[60].GetUInt8();

	learnDefaultSpells(); // pussywizard: move before loading spells and talents
	_LoadSpells(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SPELLS));
	_LoadTalents(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_TALENTS));

	_LoadGlyphs(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_GLYPHS));
	_LoadAuras(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_AURAS), time_diff);
	_LoadGlyphAuras();
	// add ghost flag (must be after aura load: PLAYER_FLAGS_GHOST set in aura)
	if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST))
	{
		m_deathState = DEAD;
		AddUnitState(UNIT_STATE_ISOLATED);
	}

	// pussywizard: remove auras that are removed at map change (after _LoadAuras)
	RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP);

	// after spell load, learn rewarded spell if need also
	_LoadQuestStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS));
	_LoadQuestStatusRewarded(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS_REW));
	_LoadDailyQuestStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_DAILY_QUEST_STATUS));
	_LoadWeeklyQuestStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_WEEKLY_QUEST_STATUS));
	_LoadSeasonalQuestStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SEASONAL_QUEST_STATUS));
	_LoadMonthlyQuestStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS));
	_LoadRandomBGStatus(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_RANDOM_BG));

	// after spell and quest load
	InitTalentForLevel();

	// must be before inventory (some items required reputation check)
	m_reputationMgr->LoadFromDB(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_REPUTATION));

	// xinef: load mails before inventory, so problematic items can be added to already loaded mails
	// unread mails and next delivery time, actual mails not loaded
	_LoadMailInit(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MAIL_COUNT), holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MAIL_DATE));

	// pussywizard:
	_LoadMailAsynch(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MAIL));

	_LoadInventory(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_INVENTORY), time_diff);

	// update items with duration and realtime
	UpdateItemDuration(time_diff, true);

	_LoadActions(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACTIONS));

	m_social = sSocialMgr->LoadFromDB(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SOCIAL_LIST), GetGUIDLow());

	// check PLAYER_CHOSEN_TITLE compatibility with PLAYER__FIELD_KNOWN_TITLES
	// note: PLAYER__FIELD_KNOWN_TITLES updated at quest status loaded
	uint32 curTitle = fields[46].GetUInt32();
	if (curTitle && !HasTitle(curTitle))
		curTitle = 0;

	SetUInt32Value(PLAYER_CHOSEN_TITLE, curTitle);

	// has to be called after last Relocate() in Player::LoadFromDB
	SetFallInformation(time(NULL), GetPositionZ());

	_LoadSpellCooldowns(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SPELL_COOLDOWNS));

	// Spell code allow apply any auras to dead character in load time in aura/spell/item loading
	// Do now before stats re-calculation cleanup for ghost state unexpected auras
	if (!IsAlive())
		RemoveAllAurasOnDeath();
	else
		RemoveAllAurasRequiringDeadTarget();

	//apply all stat bonuses from items and auras
	SetCanModifyStats(true);
	UpdateAllStats();

	// restore remembered power/health values (but not more max values)
	uint32 savedHealth = fields[50].GetUInt32();
	SetHealth(savedHealth > GetMaxHealth() ? GetMaxHealth() : savedHealth);
	for (uint8 i = 0; i < MAX_POWERS; ++i)
	{
		uint32 savedPower = fields[51 + i].GetUInt32();
		SetPower(Powers(i), savedPower > GetMaxPower(Powers(i)) ? GetMaxPower(Powers(i)) : savedPower);
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "The value of player %s after load item and aura is: ", m_name.c_str());
	outDebugValues();

	// GM state
	if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
	{
		switch (sWorld->getIntConfig(CONFIG_GM_LOGIN_STATE))
		{
		default:
		case 0:                      break;             // disable
		case 1: SetGameMaster(true); break;             // enable
		case 2:                                         // save state
			if (extraflags & PLAYER_EXTRA_GM_ON)
				SetGameMaster(true);
			break;
		}

		switch (sWorld->getIntConfig(CONFIG_GM_VISIBLE_STATE))
		{
		default:
		case 0: SetGMVisible(false); break;             // invisible
		case 1:                      break;             // visible
		case 2:                                         // save state
			if (extraflags & PLAYER_EXTRA_GM_INVISIBLE)
				SetGMVisible(false);
			break;
		}

		switch (sWorld->getIntConfig(CONFIG_GM_CHAT))
		{
		default:
		case 0:                  break;                 // disable
		case 1: SetGMChat(true); break;                 // enable
		case 2:                                         // save state
			if (extraflags & PLAYER_EXTRA_GM_CHAT)
				SetGMChat(true);
			break;
		}

		switch (sWorld->getIntConfig(CONFIG_GM_WHISPERING_TO))
		{
		default:
		case 0:                          break;         // disable
		case 1: SetAcceptWhispers(true); break;         // enable
		case 2:                                         // save state
			if (extraflags & PLAYER_EXTRA_ACCEPT_WHISPERS)
				SetAcceptWhispers(true);
			break;
		}
	}

	// RaF stuff.
	m_grantableLevels = fields[66].GetUInt8();
	if (GetSession()->IsARecruiter() || (GetSession()->GetRecruiterId() != 0))
		SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_REFER_A_FRIEND);

	if (m_grantableLevels > 0)
		SetByteValue(PLAYER_FIELD_BYTES, 1, 0x01);

	_LoadDeclinedNames(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_DECLINED_NAMES));

	//m_achievementMgr->CheckAllAchievementCriteria(); // pussywizard: ZOMG! disabled this bullshit

	_LoadEquipmentSets(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_EQUIPMENT_SETS));

	_LoadBrewOfTheMonth(holder->GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_BREW_OF_THE_MONTH));

	// Players are immune to taunt
	ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
	ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);

	// Init charm info
	PrepareCharmAISpells();

	// Fix aurastate auras, depending on health!
	// Set aurastate manualy, prevents aura switching
	if (HealthBelowPct(20))
		SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_20_PERCENT - 1));
	if (HealthBelowPct(35))
		SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_35_PERCENT - 1));
	if (HealthAbovePct(75))
		SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTH_ABOVE_75_PERCENT - 1));

	// unapply aura stats if dont meet requirements
	AuraApplicationMap const& Auras = GetAppliedAuras();
	for (AuraApplicationMap::const_iterator itr = Auras.begin(); itr != Auras.end(); ++itr)
	{
		// we assume that all auras are applied now, aurastate was modfied MANUALY preventing any apply/unapply state switching
		Aura* aura = itr->second->GetBase();
		SpellInfo const* m_spellInfo = aura->GetSpellInfo();
		if (m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_20_PERCENT &&
			m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_35_PERCENT &&
			m_spellInfo->CasterAuraState != AURA_STATE_HEALTH_ABOVE_75_PERCENT)
			continue;

		if (!HasAuraState((AuraStateType)m_spellInfo->CasterAuraState))
			aura->HandleAllEffects(itr->second, AURA_EFFECT_HANDLE_REAL, false);
	}
	return true;
}

bool Player::isAllowedToLoot(const Creature* creature)
{
	if (!creature->isDead() || !creature->IsDamageEnoughForLootingAndReward())
		return false;

	if (HasPendingBind())
		return false;

	const Loot* loot = &creature->loot;
	if (loot->isLooted()) // nothing to loot or everything looted.
		return false;

	Group* thisGroup = GetGroup();
	if (!thisGroup)
		return this == creature->GetLootRecipient();
	else if (thisGroup != creature->GetLootRecipientGroup())
		return false;

	switch (thisGroup->GetLootMethod())
	{
	case MASTER_LOOT:
	case FREE_FOR_ALL:
		return true;
	case ROUND_ROBIN:
		// may only loot if the player is the loot roundrobin player
		// or if there are free/quest/conditional item for the player
		if (loot->roundRobinPlayer == 0 || loot->roundRobinPlayer == GetGUID())
			return true;

		return loot->hasItemFor(this);
	case GROUP_LOOT:
	case NEED_BEFORE_GREED:
		// may only loot if the player is the loot roundrobin player
		// or item over threshold (so roll(s) can be launched)
		// or if there are free/quest/conditional item for the player
		if (loot->roundRobinPlayer == 0 || loot->roundRobinPlayer == GetGUID())
			return true;

		if (loot->hasOverThresholdItem())
			return true;

		return loot->hasItemFor(this);
	}

	return false;
}

void Player::_LoadActions(PreparedQueryResult result)
{
	m_actionButtons.clear();

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			uint8 button = fields[0].GetUInt8();
			uint32 action = fields[1].GetUInt32();
			uint8 type = fields[2].GetUInt8();

			if (ActionButton* ab = addActionButton(button, action, type))
				ab->uState = ACTIONBUTTON_UNCHANGED;
			else
			{
				;//sLog->outError("ActionButton loading problem, will be deleted from db...");

				// Will deleted in DB at next save (it can create data until save but marked as deleted)
				m_actionButtons[button].uState = ACTIONBUTTON_DELETED;
			}
		} while (result->NextRow());
	}
}

void Player::_LoadAuras(PreparedQueryResult result, uint32 timediff)
{
	;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Loading auras for player %u", GetGUIDLow());

	/*                                                     0           1      2           3                4           5        6        7        8             9             10
	QueryResult* result = CharacterDatabase.PQuery("SELECT casterGuid, spell, effectMask, recalculateMask, stackCount, amount0, amount1, amount2, base_amount0, base_amount1, base_amount2,
													11           12          13
													maxDuration, remainTime, remainCharges FROM character_aura WHERE guid = '%u'", GetGUIDLow());
	*/

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			int32 damage[3];
			int32 baseDamage[3];
			uint64 caster_guid = fields[0].GetUInt64();
			uint32 spellid = fields[1].GetUInt32();
			uint8 effmask = fields[2].GetUInt8();
			uint8 recalculatemask = fields[3].GetUInt8();
			uint8 stackcount = fields[4].GetUInt8();
			damage[0] = fields[5].GetInt32();
			damage[1] = fields[6].GetInt32();
			damage[2] = fields[7].GetInt32();
			baseDamage[0] = fields[8].GetInt32();
			baseDamage[1] = fields[9].GetInt32();
			baseDamage[2] = fields[10].GetInt32();
			int32 maxduration = fields[11].GetInt32();
			int32 remaintime = fields[12].GetInt32();
			uint8 remaincharges = fields[13].GetUInt8();

			SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
			if (!spellInfo)
			{
				sLog->outError("Unknown aura (spellid %u), ignore.", spellid);
				continue;
			}

			// Xinef: leave this
			if (spellInfo->HasAura(SPELL_AURA_MOUNTED))
			{
				SetMountBlockId(spellInfo->Id);
				continue;
			}

			// negative effects should continue counting down after logout
			if (remaintime != -1 && ((!spellInfo->IsPositive() && spellInfo->Id != 15007) || spellInfo->HasAttribute(SPELL_ATTR4_FADES_WHILE_LOGGED_OUT))) // Xinef: resurrection sickness should not tick when logged off
			{
				if (remaintime / IN_MILLISECONDS <= int32(timediff))
					continue;

				remaintime -= timediff*IN_MILLISECONDS;
			}

			// prevent wrong values of remaincharges
			if (spellInfo->ProcCharges)
			{
				// we have no control over the order of applying auras and modifiers allow auras
				// to have more charges than value in SpellInfo
				if (remaincharges <= 0/* || remaincharges > spellproto->procCharges*/)
					remaincharges = spellInfo->ProcCharges;
			}
			else
				remaincharges = 0;

			if (Aura* aura = Aura::TryCreate(spellInfo, effmask, this, NULL, &baseDamage[0], NULL, caster_guid))
			{
				if (!aura->CanBeSaved())
				{
					aura->Remove();
					continue;
				}

				aura->SetLoadedState(maxduration, remaintime, remaincharges, stackcount, recalculatemask, &damage[0]);
				aura->ApplyForTargets();
				;//sLog->outDetail("Added aura spellid %u, effectmask %u", spellInfo->Id, effmask);
			}
		} while (result->NextRow());
	}
}

void Player::_LoadGlyphAuras()
{
	for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
	{
		if (uint32 glyph = GetGlyph(i))
		{
			if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
			{
				if (GlyphSlotEntry const* glyphSlotEntry = sGlyphSlotStore.LookupEntry(GetGlyphSlot(i)))
				{
					const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(glyphEntry->SpellId);
					if (glyphEntry->TypeFlags == glyphSlotEntry->TypeFlags)
					{
						if (!spellInfo->Stances)
							CastSpell(this, glyphEntry->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK&~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)));
						continue;
					}
					else
						sLog->outError("Player %s has glyph with typeflags %u in slot with typeflags %u, removing.", m_name.c_str(), glyphEntry->TypeFlags, glyphSlotEntry->TypeFlags);
				}
				else
					sLog->outError("Player %s has not existing glyph slot entry %u on index %u", m_name.c_str(), GetGlyphSlot(i), i);
			}
			else
				sLog->outError("Player %s has not existing glyph entry %u on index %u", m_name.c_str(), glyph, i);

			// On any error remove glyph
			SetGlyph(i, 0, true);
		}
	}
}

void Player::LoadCorpse()
{
	if (IsAlive())
		sObjectAccessor->ConvertCorpseForPlayer(GetGUID());
	else
	{
		if (Corpse* corpse = GetCorpse())
			ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, corpse && !sMapStore.LookupEntry(corpse->GetMapId())->Instanceable());
		else
			//Prevent Dead Player login without corpse
			ResurrectPlayer(0.5f);
	}
}

void Player::_LoadInventory(PreparedQueryResult result, uint32 timeDiff)
{
	//QueryResult* result = CharacterDatabase.PQuery("SELECT data, text, bag, slot, item, item_template FROM character_inventory JOIN item_instance ON character_inventory.item = item_instance.guid WHERE character_inventory.guid = '%u' ORDER BY bag, slot", GetGUIDLow());
	//NOTE: the "order by `bag`" is important because it makes sure
	//the bagMap is filled before items in the bags are loaded
	//NOTE2: the "order by `slot`" is needed because mainhand weapons are (wrongly?)
	//expected to be equipped before offhand items (TODO: fixme)

	if (result)
	{
		uint32 zoneId = GetZoneId(true);

		std::map<uint32, Bag*> bagMap;                               // fast guid lookup for bags
		std::map<uint32, Item*> invalidBagMap;                       // fast guid lookup for bags
		std::list<Item*> problematicItems;
		SQLTransaction trans = CharacterDatabase.BeginTransaction();

		// Prevent items from being added to the queue while loading
		m_itemUpdateQueueBlocked = true;
		do
		{
			Field* fields = result->Fetch();
			if (Item* item = _LoadItem(trans, zoneId, timeDiff, fields))
			{
				uint32 bagGuid = fields[11].GetUInt32();
				uint8  slot = fields[12].GetUInt8();

				uint8 err = EQUIP_ERR_OK;
				// Item is not in bag
				if (!bagGuid)
				{
					item->SetContainer(NULL);
					item->SetSlot(slot);

					if (IsInventoryPos(INVENTORY_SLOT_BAG_0, slot))
					{
						ItemPosCountVec dest;
						err = CanStoreItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false);
						if (err == EQUIP_ERR_OK)
							item = StoreItem(dest, item, true);
					}
					else if (IsEquipmentPos(INVENTORY_SLOT_BAG_0, slot))
					{
						uint16 dest;
						err = CanEquipItem(slot, dest, item, false, false);
						if (err == EQUIP_ERR_OK)
							QuickEquipItem(dest, item);
					}
					else if (IsBankPos(INVENTORY_SLOT_BAG_0, slot))
					{
						ItemPosCountVec dest;
						err = CanBankItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false, false);
						if (err == EQUIP_ERR_OK)
							item = BankItem(dest, item, true);
					}

					// Remember bags that may contain items in them
					if (err == EQUIP_ERR_OK)
					{
						if (IsBagPos(item->GetPos()))
							if (Bag* pBag = item->ToBag())
								bagMap[item->GetGUIDLow()] = pBag;
					}
					else
						if (IsBagPos(item->GetPos()))
							if (item->IsBag())
								invalidBagMap[item->GetGUIDLow()] = item;
				}
				else
				{
					item->SetSlot(NULL_SLOT);
					// Item is in the bag, find the bag
					std::map<uint32, Bag*>::iterator itr = bagMap.find(bagGuid);
					if (itr != bagMap.end())
					{
						ItemPosCountVec dest;
						err = CanStoreItem(itr->second->GetSlot(), slot, dest, item);
						if (err == EQUIP_ERR_OK)
							item = StoreItem(dest, item, true);
					}
					else if (invalidBagMap.find(bagGuid) != invalidBagMap.end())
					{
						std::map<uint32, Item*>::iterator itr = invalidBagMap.find(bagGuid);
						if (std::find(problematicItems.begin(), problematicItems.end(), itr->second) != problematicItems.end())
							err = EQUIP_ERR_INT_BAG_ERROR;
					}
					else
					{
						sLog->outError("Player::_LoadInventory: player (GUID: %u, name: '%s') has item (GUID: %u, entry: %u) which doesnt have a valid bag (Bag GUID: %u, slot: %u). Possible cheat?",
							GetGUIDLow(), GetName().c_str(), item->GetGUIDLow(), item->GetEntry(), bagGuid, slot);
						item->DeleteFromInventoryDB(trans);
						delete item;
						continue;
					}

				}

				// Item's state may have changed after storing
				if (err == EQUIP_ERR_OK)
					item->SetState(ITEM_UNCHANGED, this);
				else
				{
					sLog->outError("Player::_LoadInventory: player (GUID: %u, name: '%s') has item (GUID: %u, entry: %u) which can't be loaded into inventory (Bag GUID: %u, slot: %u) by reason %u. Item will be sent by mail.",
						GetGUIDLow(), GetName().c_str(), item->GetGUIDLow(), item->GetEntry(), bagGuid, slot, err);
					item->DeleteFromInventoryDB(trans);
					problematicItems.push_back(item);
				}
			}
		} while (result->NextRow());

		m_itemUpdateQueueBlocked = false;

		// Send problematic items by mail
		while (!problematicItems.empty())
		{
			std::string subject = GetSession()->GetTrinityString(LANG_NOT_EQUIPPED_ITEM);

			MailDraft draft(subject, "There were problems with equipping item(s).");
			for (uint8 i = 0; !problematicItems.empty() && i < MAX_MAIL_ITEMS; ++i)
			{
				draft.AddItem(problematicItems.front());
				problematicItems.pop_front();
			}
			draft.SendMailTo(trans, this, MailSender(this, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);
		}
		CharacterDatabase.CommitTransaction(trans);
	}
	//if (IsAlive())
	_ApplyAllItemMods();
}

Item* Player::_LoadItem(SQLTransaction& trans, uint32 zoneId, uint32 timeDiff, Field* fields)
{
	Item* item = NULL;
	uint32 itemGuid = fields[13].GetUInt32();
	uint32 itemEntry = fields[14].GetUInt32();
	if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemEntry))
	{
		bool remove = false;
		item = NewItemOrBag(proto);
		if (item->LoadFromDB(itemGuid, GetGUID(), fields, itemEntry))
		{
			PreparedStatement* stmt = NULL;

			// Do not allow to have item limited to another map/zone in alive state
			if (IsAlive() && item->IsLimitedToAnotherMapOrZone(GetMapId(), zoneId))
			{
				;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::_LoadInventory: player (GUID: %u, name: '%s', map: %u) has item (GUID: %u, entry: %u) limited to another map (%u). Deleting item.",
				//    GetGUIDLow(), GetName().c_str(), GetMapId(), item->GetGUIDLow(), item->GetEntry(), zoneId);
				remove = true;
			}
			// "Conjured items disappear if you are logged out for more than 15 minutes"
			else if (timeDiff > 15 * MINUTE && proto->Flags & ITEM_PROTO_FLAG_CONJURED)
			{
				;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::_LoadInventory: player (GUID: %u, name: '%s', diff: %u) has conjured item (GUID: %u, entry: %u) with expired lifetime (15 minutes). Deleting item.",
				//    GetGUIDLow(), GetName().c_str(), timeDiff, item->GetGUIDLow(), item->GetEntry());
				remove = true;
			}
			else if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE))
			{
				if (item->GetPlayedTime() > (2 * HOUR))
				{
					;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::_LoadInventory: player (GUID: %u, name: '%s') has item (GUID: %u, entry: %u) with expired refund time (%u). Deleting refund data and removing refundable flag.",
					//    GetGUIDLow(), GetName().c_str(), item->GetGUIDLow(), item->GetEntry(), item->GetPlayedTime());

					stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_REFUND_INSTANCE);
					stmt->setUInt32(0, item->GetGUIDLow());
					trans->Append(stmt);

					item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE);
				}
				else
				{
					// xinef: zomg! sync query
					stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_REFUNDS);
					stmt->setUInt32(0, item->GetGUIDLow());
					stmt->setUInt32(1, GetGUIDLow());
					if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
					{
						item->SetRefundRecipient((*result)[0].GetUInt32());
						item->SetPaidMoney((*result)[1].GetUInt32());
						item->SetPaidExtendedCost((*result)[2].GetUInt16());
						AddRefundReference(item->GetGUIDLow());
					}
					else
					{
						;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::_LoadInventory: player (GUID: %u, name: '%s') has item (GUID: %u, entry: %u) with refundable flags, but without data in item_refund_instance. Removing flag.",
						//    GetGUIDLow(), GetName().c_str(), item->GetGUIDLow(), item->GetEntry());
						item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE);
					}
				}
			}
			else if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_BOP_TRADEABLE))
			{
				stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_BOP_TRADE);
				stmt->setUInt32(0, item->GetGUIDLow());
				if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
				{
					std::string strGUID = (*result)[0].GetString();
					Tokenizer GUIDlist(strGUID, ' ');
					AllowedLooterSet looters;
					for (Tokenizer::const_iterator itr = GUIDlist.begin(); itr != GUIDlist.end(); ++itr)
						looters.insert(atol(*itr));

					if (looters.size() > 1 && item->GetTemplate()->GetMaxStackSize() == 1 && item->IsSoulBound())
					{
						item->SetSoulboundTradeable(looters);
						AddTradeableItem(item);
					}
					else
						item->ClearSoulboundTradeable(this);
				}
				else
				{
					;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Player::_LoadInventory: player (GUID: %u, name: '%s') has item (GUID: %u, entry: %u) with ITEM_FLAG_BOP_TRADEABLE flag, but without data in item_soulbound_trade_data. Removing flag.",
					//    GetGUIDLow(), GetName().c_str(), item->GetGUIDLow(), item->GetEntry());
					item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_BOP_TRADEABLE);
				}
			}
			else if (proto->HolidayId)
			{
				remove = true;
				GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
				GameEventMgr::ActiveEvents const& activeEventsList = sGameEventMgr->GetActiveEventList();
				for (GameEventMgr::ActiveEvents::const_iterator itr = activeEventsList.begin(); itr != activeEventsList.end(); ++itr)
				{
					if (uint32(events[*itr].holiday_id) == proto->HolidayId)
					{
						remove = false;
						break;
					}
				}
			}
		}
		else
		{
			sLog->outError("Player::_LoadInventory: player (GUID: %u, name: '%s') has broken item (GUID: %u, entry: %u) in inventory. Deleting item.",
				GetGUIDLow(), GetName().c_str(), itemGuid, itemEntry);
			remove = true;
		}
		// Remove item from inventory if necessary
		if (remove)
		{
			Item::DeleteFromInventoryDB(trans, itemGuid);
			item->FSetState(ITEM_REMOVED);
			item->SaveToDB(trans);                           // it also deletes item object!
			item = NULL;
		}
	}
	else
	{
		sLog->outError("Player::_LoadInventory: player (GUID: %u, name: '%s') has unknown item (entry: %u) in inventory. Deleting item.",
			GetGUIDLow(), GetName().c_str(), itemEntry);
		Item::DeleteFromInventoryDB(trans, itemGuid);
		Item::DeleteFromDB(trans, itemGuid);
	}
	return item;
}

// load mailed item which should receive current player
void Player::_LoadMailedItems(Mail* mail)
{
	// data needs to be at first place for Item::LoadFromDB
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS);
	stmt->setUInt32(0, mail->messageID);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);
	if (!result)
		return;

	do
	{
		Field* fields = result->Fetch();

		uint32 itemGuid = fields[11].GetUInt32();
		uint32 itemTemplate = fields[12].GetUInt32();

		mail->AddItem(itemGuid, itemTemplate);

		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemTemplate);

		if (!proto)
		{
			sLog->outError("Player %u has unknown item_template (ProtoType) in mailed items(GUID: %u template: %u) in mail (%u), deleted.", GetGUIDLow(), itemGuid, itemTemplate, mail->messageID);

			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
			stmt->setUInt32(0, itemGuid);
			CharacterDatabase.Execute(stmt);

			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
			stmt->setUInt32(0, itemGuid);
			CharacterDatabase.Execute(stmt);
			continue;
		}

		Item* item = NewItemOrBag(proto);

		if (!item->LoadFromDB(itemGuid, MAKE_NEW_GUID(fields[13].GetUInt32(), 0, HIGHGUID_PLAYER), fields, itemTemplate))
		{
			sLog->outError("Player::_LoadMailedItems - Item in mail (%u) doesn't exist !!!! - item guid: %u, deleted from mail", mail->messageID, itemGuid);

			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
			stmt->setUInt32(0, itemGuid);
			CharacterDatabase.Execute(stmt);

			item->FSetState(ITEM_REMOVED);

			SQLTransaction temp = SQLTransaction(NULL);
			item->SaveToDB(temp);                               // it also deletes item object !
			continue;
		}

		AddMItem(item);
	} while (result->NextRow());
}

void Player::_LoadMailInit(PreparedQueryResult resultUnread, PreparedQueryResult resultDelivery)
{
	//set a count of unread mails
	//QueryResult* resultMails = CharacterDatabase.PQuery("SELECT COUNT(id) FROM mail WHERE receiver = '%u' AND (checked & 1)=0 AND deliver_time <= '" UI64FMTD "'", GUID_LOPART(playerGuid), (uint64)cTime);
	if (resultUnread)
		unReadMails = uint8((*resultUnread)[0].GetUInt64());

	// store nearest delivery time (it > 0 and if it < current then at next player update SendNewMaill will be called)
	//resultMails = CharacterDatabase.PQuery("SELECT MIN(deliver_time) FROM mail WHERE receiver = '%u' AND (checked & 1)=0", GUID_LOPART(playerGuid));
	if (resultDelivery)
		m_nextMailDelivereTime = time_t((*resultDelivery)[0].GetUInt32());
}

void Player::_LoadMailAsynch(PreparedQueryResult result)
{
	m_mail.clear();
	uint32 prevMailID = 0;
	Mail* m = NULL;
	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			if (fields[14].GetUInt32() != prevMailID)
			{
				if (m)
					m_mail.push_back(m);

				m = new Mail;

				m->messageID = fields[14].GetUInt32();
				m->messageType = fields[15].GetUInt8();
				m->sender = fields[16].GetUInt32();
				m->receiver = fields[17].GetUInt32();
				m->subject = fields[18].GetString();
				m->body = fields[19].GetString();
				bool has_items = fields[20].GetBool();
				m->expire_time = time_t(fields[21].GetUInt32());
				m->deliver_time = time_t(fields[22].GetUInt32());
				m->money = fields[23].GetUInt32();
				m->COD = fields[24].GetUInt32();
				m->checked = fields[25].GetUInt8();
				m->stationery = fields[26].GetUInt8();
				m->mailTemplateId = fields[27].GetInt16();

				if (m->mailTemplateId && !sMailTemplateStore.LookupEntry(m->mailTemplateId))
				{
					sLog->outError("Player::_LoadMail - Mail (%u) have not existed MailTemplateId (%u), remove at load", m->messageID, m->mailTemplateId);
					m->mailTemplateId = 0;
				}

				m->state = MAIL_STATE_UNCHANGED;
			}

			if (m && fields[20].GetBool() /*has_items*/ && fields[12].GetUInt32() /*itemEntry*/)
			{
				uint32 itemGuid = fields[11].GetUInt32();
				uint32 itemTemplate = fields[12].GetUInt32();

				m->AddItem(itemGuid, itemTemplate);

				ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemTemplate);

				if (!proto)
				{
					sLog->outError("Player %u has unknown item_template (ProtoType) in mailed items(GUID: %u template: %u) in mail (%u), deleted.", GetGUIDLow(), itemGuid, itemTemplate, m->messageID);

					PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
					stmt->setUInt32(0, itemGuid);
					CharacterDatabase.Execute(stmt);

					stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
					stmt->setUInt32(0, itemGuid);
					CharacterDatabase.Execute(stmt);
					continue;
				}

				Item* item = NewItemOrBag(proto);

				if (!item->LoadFromDB(itemGuid, MAKE_NEW_GUID(fields[13].GetUInt32(), 0, HIGHGUID_PLAYER), fields, itemTemplate))
				{
					sLog->outError("Player::_LoadMailedItems - Item in mail (%u) doesn't exist !!!! - item guid: %u, deleted from mail", m->messageID, itemGuid);

					PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
					stmt->setUInt32(0, itemGuid);
					CharacterDatabase.Execute(stmt);

					item->FSetState(ITEM_REMOVED);

					SQLTransaction temp = SQLTransaction(NULL);
					item->SaveToDB(temp);                               // it also deletes item object !
					continue;
				}

				AddMItem(item);
			}

			prevMailID = fields[14].GetUInt32();
		} while (result->NextRow());

		m_mail.push_back(m);
	}
	// Xinef: this is stored during storage initialization
	sWorld->UpdateGlobalPlayerMails(GetGUIDLow(), m_mail.size(), false);
	m_mailsLoaded = true;
}

void Player::_LoadMail()
{
	m_mail.clear();

	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL);
	stmt->setUInt32(0, GetGUIDLow());
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			Mail* m = new Mail;

			m->messageID = fields[0].GetUInt32();
			m->messageType = fields[1].GetUInt8();
			m->sender = fields[2].GetUInt32();
			m->receiver = fields[3].GetUInt32();
			m->subject = fields[4].GetString();
			m->body = fields[5].GetString();
			bool has_items = fields[6].GetBool();
			m->expire_time = time_t(fields[7].GetUInt32());
			m->deliver_time = time_t(fields[8].GetUInt32());
			m->money = fields[9].GetUInt32();
			m->COD = fields[10].GetUInt32();
			m->checked = fields[11].GetUInt8();
			m->stationery = fields[12].GetUInt8();
			m->mailTemplateId = fields[13].GetInt16();

			if (m->mailTemplateId && !sMailTemplateStore.LookupEntry(m->mailTemplateId))
			{
				sLog->outError("Player::_LoadMail - Mail (%u) have not existed MailTemplateId (%u), remove at load", m->messageID, m->mailTemplateId);
				m->mailTemplateId = 0;
			}

			m->state = MAIL_STATE_UNCHANGED;

			if (has_items)
				_LoadMailedItems(m);

			m_mail.push_back(m);
		} while (result->NextRow());
	}
	m_mailsLoaded = true;
}

void Player::LoadPet()
{
	//fixme: the pet should still be loaded if the player is not in world
	// just not added to the map
	if (IsInWorld())
	{
		Pet::LoadPetFromDB(this, PET_LOAD_SUMMON_PET, 0, 0, true);
	}
}

void Player::_LoadQuestStatus(PreparedQueryResult result)
{
	uint16 slot = 0;

	////                                                       0      1       2        3        4           5          6         7           8           9           10
	//QueryResult* result = CharacterDatabase.PQuery("SELECT quest, status, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3,
	//                                                    11           12
	//                                                itemcount4, playercount FROM character_queststatus WHERE guid = '%u'", GetGUIDLow());

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();

			uint32 quest_id = fields[0].GetUInt32();
			// used to be new, no delete?
			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (quest)
			{
				// find or create
				QuestStatusData& questStatusData = m_QuestStatus[quest_id];

				uint8 qstatus = fields[1].GetUInt8();
				if (qstatus < MAX_QUEST_STATUS)
					questStatusData.Status = QuestStatus(qstatus);
				else
				{
					questStatusData.Status = QUEST_STATUS_INCOMPLETE;
					sLog->outError("Player %s (GUID: %u) has invalid quest %d status (%u), replaced by QUEST_STATUS_INCOMPLETE(3).",
						GetName().c_str(), GetGUIDLow(), quest_id, qstatus);
				}

				questStatusData.Explored = (fields[2].GetUInt8() > 0);

				time_t quest_time = time_t(fields[3].GetUInt32());

				if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED) && !GetQuestRewardStatus(quest_id))
				{
					AddTimedQuest(quest_id);

					if (quest_time <= sWorld->GetGameTime())
						questStatusData.Timer = 1;
					else
						questStatusData.Timer = uint32((quest_time - sWorld->GetGameTime()) * IN_MILLISECONDS);
				}
				else
					quest_time = 0;

				questStatusData.CreatureOrGOCount[0] = fields[4].GetUInt16();
				questStatusData.CreatureOrGOCount[1] = fields[5].GetUInt16();
				questStatusData.CreatureOrGOCount[2] = fields[6].GetUInt16();
				questStatusData.CreatureOrGOCount[3] = fields[7].GetUInt16();
				questStatusData.ItemCount[0] = fields[8].GetUInt16();
				questStatusData.ItemCount[1] = fields[9].GetUInt16();
				questStatusData.ItemCount[2] = fields[10].GetUInt16();
				questStatusData.ItemCount[3] = fields[11].GetUInt16();
				questStatusData.PlayerCount = fields[12].GetUInt16();

				// add to quest log
				if (slot < MAX_QUEST_LOG_SIZE && questStatusData.Status != QUEST_STATUS_NONE)
				{
					SetQuestSlot(slot, quest_id, uint32(quest_time)); // cast can't be helped

					if (questStatusData.Status == QUEST_STATUS_COMPLETE)
						SetQuestSlotState(slot, QUEST_STATE_COMPLETE);
					else if (questStatusData.Status == QUEST_STATUS_FAILED)
						SetQuestSlotState(slot, QUEST_STATE_FAIL);

					for (uint8 idx = 0; idx < QUEST_OBJECTIVES_COUNT; ++idx)
						if (questStatusData.CreatureOrGOCount[idx])
							SetQuestSlotCounter(slot, idx, questStatusData.CreatureOrGOCount[idx]);

					if (questStatusData.PlayerCount)
						SetQuestSlotCounter(slot, QUEST_PVP_KILL_SLOT, questStatusData.PlayerCount);

					++slot;
				}

				;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Quest status is {%u} for quest {%u} for player (GUID: %u)", questStatusData.Status, quest_id, GetGUIDLow());
			}
		} while (result->NextRow());
	}

	// clear quest log tail
	for (uint16 i = slot; i < MAX_QUEST_LOG_SIZE; ++i)
		SetQuestSlot(i, 0);
}

void Player::_LoadQuestStatusRewarded(PreparedQueryResult result)
{
	// SELECT quest FROM character_queststatus_rewarded WHERE guid = ?

	if (result)
	{
		m_RewardedQuests.rehash(result->GetRowCount());
		do
		{
			Field* fields = result->Fetch();

			uint32 quest_id = fields[0].GetUInt32();
			// used to be new, no delete?
			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (quest)
			{
				// learn rewarded spell if unknown
				learnQuestRewardedSpells(quest);

				// set rewarded title if any
				if (quest->GetCharTitleId())
				{
					if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(quest->GetCharTitleId()))
						SetTitle(titleEntry);
				}

				if (quest->GetBonusTalents())
					m_questRewardTalentCount += quest->GetBonusTalents();
			}

			m_RewardedQuests.insert(quest_id);
		} while (result->NextRow());
	}
}

void Player::_LoadDailyQuestStatus(PreparedQueryResult result)
{
	for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
		SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, 0);

	m_DFQuests.clear();

	//QueryResult* result = CharacterDatabase.PQuery("SELECT quest, time FROM character_queststatus_daily WHERE guid = '%u'", GetGUIDLow());

	if (result)
	{
		uint32 quest_daily_idx = 0;

		do
		{
			Field* fields = result->Fetch();
			if (Quest const* qQuest = sObjectMgr->GetQuestTemplate(fields[0].GetUInt32()))
			{
				if (qQuest->IsDFQuest())
				{
					m_DFQuests.insert(qQuest->GetQuestId());
					m_lastDailyQuestTime = time_t(fields[1].GetUInt32());
					continue;
				}
			}

			if (quest_daily_idx >= PLAYER_MAX_DAILY_QUESTS)  // max amount with exist data in query
			{
				sLog->outError("Player (GUID: %u) have more 25 daily quest records in `charcter_queststatus_daily`", GetGUIDLow());
				break;
			}

			uint32 quest_id = fields[0].GetUInt32();

			// save _any_ from daily quest times (it must be after last reset anyway)
			m_lastDailyQuestTime = time_t(fields[1].GetUInt32());

			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (!quest)
				continue;

			SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, quest_id);
			++quest_daily_idx;

			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Daily quest (%u) cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
		} while (result->NextRow());
	}

	m_DailyQuestChanged = false;
}

void Player::_LoadWeeklyQuestStatus(PreparedQueryResult result)
{
	m_weeklyquests.clear();

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			uint32 quest_id = fields[0].GetUInt32();
			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (!quest)
				continue;

			m_weeklyquests.insert(quest_id);
			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Weekly quest {%u} cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
		} while (result->NextRow());
	}

	m_WeeklyQuestChanged = false;
}

void Player::_LoadSeasonalQuestStatus(PreparedQueryResult result)
{
	m_seasonalquests.clear();

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			uint32 quest_id = fields[0].GetUInt32();
			uint32 event_id = fields[1].GetUInt32();
			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (!quest)
				continue;

			m_seasonalquests[event_id].insert(quest_id);
			;//sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Seasonal quest {%u} cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
		} while (result->NextRow());
	}

	m_SeasonalQuestChanged = false;
}

void Player::_LoadMonthlyQuestStatus(PreparedQueryResult result)
{
	m_monthlyquests.clear();

	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			uint32 quest_id = fields[0].GetUInt32();
			Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
			if (!quest)
				continue;

			m_monthlyquests.insert(quest_id);
			sLog->outDebug(LOG_FILTER_PLAYER_LOADING, "Monthly quest {%u} cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
		} while (result->NextRow());
	}

	m_MonthlyQuestChanged = false;
}

void Player::_LoadSpells(PreparedQueryResult result)
{
	//QueryResult* result = CharacterDatabase.PQuery("SELECT spell, specMask FROM character_spell WHERE guid = '%u'", GetGUIDLow());

	if (result)
	{
		do
			// xinef: checked
			addSpell((*result)[0].GetUInt32(), (*result)[1].GetUInt8(), true);
		while (result->NextRow());
	}
}

void Player::_LoadGroup()
{
	if (uint32 groupId = GetGroupIdFromStorage(GetGUIDLow()))
		if (Group* group = sGroupMgr->GetGroupByGUID(groupId))
			if (group->GetMemberGroup(GetGUID()) <= MAX_RAID_SUBGROUPS)
			{
				if (group->IsLeader(GetGUID()))
					SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_GROUP_LEADER);

				uint8 subgroup = group->GetMemberGroup(GetGUID());
				SetGroup(group, subgroup);

				// the group leader may change the instance difficulty while the player is offline
				SetDungeonDifficulty(group->GetDungeonDifficulty());
				SetRaidDifficulty(group->GetRaidDifficulty());
			}

	if (!GetGroup() || !GetGroup()->IsLeader(GetGUID()))
		RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GROUP_LEADER);
}

void Player::BindToInstance()
{
	InstanceSave* mapSave = sInstanceSaveMgr->GetInstanceSave(_pendingBindId);
	if (!mapSave) //it seems sometimes mapSave is NULL, but I did not check why
		return;

	WorldPacket data(SMSG_INSTANCE_SAVE_CREATED, 4);
	data << uint32(0);
	GetSession()->SendPacket(&data);
	sInstanceSaveMgr->PlayerBindToInstance(this->GetGUIDLow(), mapSave, true, this);
}

void Player::SendRaidInfo()
{
	uint32 counter = 0;

	WorldPacket data(SMSG_RAID_INSTANCE_INFO, 4);

	size_t p_counter = data.wpos();
	data << uint32(counter);                                // placeholder

	time_t now = time(NULL);

	for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
	{
		BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUIDLow(), Difficulty(i));
		for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
		{
			if (itr->second.perm)
			{
				InstanceSave* save = itr->second.save;
				time_t resetTime = itr->second.extended ? save->GetExtendedResetTime() : save->GetResetTime();
				data << uint32(save->GetMapId());           // map id
				data << uint32(save->GetDifficulty());      // difficulty
				data << uint64(MAKE_NEW_GUID(save->GetInstanceId(), 0, HIGHGUID_INSTANCE)); // instance id
				data << uint8(1);                           // expired = 0
				data << uint8(itr->second.extended ? 1 : 0);// extended = 1
				data << uint32(resetTime >= now ? resetTime - now : 0); // reset time
				++counter;
			}
		}
	}
	data.put<uint32>(p_counter, counter);
	GetSession()->SendPacket(&data);
}

/*
- called on every successful teleportation to a map
*/
void Player::SendSavedInstances()
{
	bool hasBeenSaved = false;
	WorldPacket data;

	for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
	{
		BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUIDLow(), Difficulty(i));
		for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
		{
			if (itr->second.perm)                               // only permanent binds are sent
			{
				hasBeenSaved = true;
				break;
			}
		}
	}

	//Send opcode 811. true or false means, whether you have current raid/heroic instances
	data.Initialize(SMSG_UPDATE_INSTANCE_OWNERSHIP);
	data << uint32(hasBeenSaved);
	GetSession()->SendPacket(&data);

	if (!hasBeenSaved)
		return;

	for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
	{
		BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUIDLow(), Difficulty(i));
		for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
		{
			if (itr->second.perm)
			{
				data.Initialize(SMSG_UPDATE_LAST_INSTANCE);
				data << uint32(itr->second.save->GetMapId());
				GetSession()->SendPacket(&data);
			}
		}
	}
}

bool Player::Satisfy(AccessRequirement const* ar, uint32 target_map, bool report)
{
	if (!IsGameMaster() && ar)
	{
		uint8 LevelMin = 0;
		uint8 LevelMax = 0;

		MapEntry const* mapEntry = sMapStore.LookupEntry(target_map);
		if (!mapEntry)
			return false;

		if (!sWorld->getBoolConfig(CONFIG_INSTANCE_IGNORE_LEVEL))
		{
			if (ar->levelMin && getLevel() < ar->levelMin)
				LevelMin = ar->levelMin;
			if (ar->levelMax && getLevel() > ar->levelMax)
				LevelMax = ar->levelMax;
		}

		uint32 missingItem = 0;
		if (ar->item)
		{
			if (!HasItemCount(ar->item, 1) &&
				(!ar->item2 || !HasItemCount(ar->item2)))
				missingItem = ar->item;
		}
		else if (ar->item2 && !HasItemCount(ar->item2))
			missingItem = ar->item2;

		if (DisableMgr::IsDisabledFor(DISABLE_TYPE_MAP, target_map, this))
		{
			GetSession()->SendAreaTriggerMessage("%s", GetSession()->GetTrinityString(LANG_INSTANCE_CLOSED));
			return false;
		}

		uint32 missingQuest = 0;
		if (GetTeamId(true) == TEAM_ALLIANCE && ar->quest_A && !GetQuestRewardStatus(ar->quest_A))
			missingQuest = ar->quest_A;
		else if (GetTeamId(true) == TEAM_HORDE && ar->quest_H && !GetQuestRewardStatus(ar->quest_H))
			missingQuest = ar->quest_H;

		uint32 missingAchievement = 0;
		Player* leader = this;
		uint64 leaderGuid = GetGroup() ? GetGroup()->GetLeaderGUID() : GetGUID();
		if (leaderGuid != GetGUID())
			leader = HashMapHolder<Player>::Find(leaderGuid);

		if (ar->achievement)
			if (!leader || !leader->HasAchieved(ar->achievement))
				missingAchievement = ar->achievement;

		Difficulty target_difficulty = GetDifficulty(mapEntry->IsRaid());
		MapDifficulty const* mapDiff = GetDownscaledMapDifficultyData(target_map, target_difficulty);
		if (LevelMin || LevelMax || missingItem || missingQuest || missingAchievement)
		{
			if (report)
			{
				if (missingQuest && !ar->questFailedText.empty())
					ChatHandler(GetSession()).PSendSysMessage("%s", ar->questFailedText.c_str());
				else if (mapDiff->hasErrorMessage) // if (missingAchievement) covered by this case
					SendTransferAborted(target_map, TRANSFER_ABORT_DIFFICULTY, target_difficulty);
				else if (missingItem)
					GetSession()->SendAreaTriggerMessage(GetSession()->GetTrinityString(LANG_LEVEL_MINREQUIRED_AND_ITEM), LevelMin, sObjectMgr->GetItemTemplate(missingItem)->Name1.c_str());
				else if (LevelMin)
					GetSession()->SendAreaTriggerMessage(GetSession()->GetTrinityString(LANG_LEVEL_MINREQUIRED), LevelMin);
			}
			return false;
		}
	}
	return true;
}

bool Player::CheckInstanceLoginValid()
{
	if (!GetMap())
		return false;

	if (!GetMap()->IsDungeon() || IsGameMaster())
		return true;

	if (GetMap()->IsRaid())
	{
		// cannot be in raid instance without a group
		if (!GetGroup())
			return false;
	}
	else
	{
		// cannot be in normal instance without a group and more players than 1 in instance
		if (!GetGroup() && GetMap()->GetPlayersCountExceptGMs() > 1)
			return false;
	}

	// pussywizard: check CanEnter for GetMap(), because in CanPlayerEnter it is called for a map decided before loading screen (can change)
	if (!GetMap()->CanEnter(this, true))
		return false;

	// do checks for satisfy accessreqs, instance full, encounter in progress (raid), perm bind group != perm bind player
	return sMapMgr->CanPlayerEnter(GetMap()->GetId(), this, true);
}

bool Player::CheckInstanceCount(uint32 instanceId) const
{
	if (_instanceResetTimes.size() < sWorld->getIntConfig(CONFIG_MAX_INSTANCES_PER_HOUR))
		return true;
	return _instanceResetTimes.find(instanceId) != _instanceResetTimes.end();
}

bool Player::_LoadHomeBind(PreparedQueryResult result)
{
	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
	if (!info)
	{
		sLog->outError("Player (Name %s) has incorrect race/class pair. Can't be loaded.", GetName().c_str());
		return false;
	}

	bool ok = false;
	// SELECT mapId, zoneId, posX, posY, posZ FROM character_homebind WHERE guid = ?
	if (result)
	{
		Field* fields = result->Fetch();

		m_homebindMapId = fields[0].GetUInt16();
		m_homebindAreaId = fields[1].GetUInt16();
		m_homebindX = fields[2].GetFloat();
		m_homebindY = fields[3].GetFloat();
		m_homebindZ = fields[4].GetFloat();

		MapEntry const* bindMapEntry = sMapStore.LookupEntry(m_homebindMapId);

		// accept saved data only for valid position (and non instanceable), and accessable
		if (MapManager::IsValidMapCoord(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ) &&
			!bindMapEntry->Instanceable() && GetSession()->Expansion() >= bindMapEntry->Expansion())
			ok = true;
		else
		{
			PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
			stmt->setUInt32(0, GetGUIDLow());
			CharacterDatabase.Execute(stmt);
		}
	}

	if (!ok)
	{
		m_homebindMapId = info->mapId;
		m_homebindAreaId = info->areaId;
		m_homebindX = info->positionX;
		m_homebindY = info->positionY;
		m_homebindZ = info->positionZ;

		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_HOMEBIND);
		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt16(1, m_homebindMapId);
		stmt->setUInt16(2, m_homebindAreaId);
		stmt->setFloat(3, m_homebindX);
		stmt->setFloat(4, m_homebindY);
		stmt->setFloat(5, m_homebindZ);
		CharacterDatabase.Execute(stmt);
	}

	;//sLog->outStaticDebug("Setting player home position - mapid: %u, areaid: %u, X: %f, Y: %f, Z: %f",
	//    m_homebindMapId, m_homebindAreaId, m_homebindX, m_homebindY, m_homebindZ);

	return true;
}

/*********************************************************/
/***                   SAVE SYSTEM                     ***/
/*********************************************************/

void Player::SaveToDB(bool create, bool logout)
{
	//lets allow only players in world to be saved
	if (IsBeingTeleportedFar())
	{
		ScheduleDelayedOperation(DELAYED_SAVE_PLAYER);
		return;
	}

	// pussywizard: full save now, so clear partial additional saves
	m_additionalSaveTimer = 0;
	m_additionalSaveMask = 0;

	// first save/honor gain after midnight will also update the player's honor fields
	UpdateHonorFields();

	;//sLog->outDebug(LOG_FILTER_UNITS, "The value of player %s at save: ", m_name.c_str());
	outDebugValues();

	SQLTransaction trans = CharacterDatabase.BeginTransaction();

	_SaveCharacter(create, trans);

	if (m_mailsUpdated)                                     //save mails only when needed
		_SaveMail(trans);

	_SaveEntryPoint(trans);
	_SaveInventory(trans);
	_SaveQuestStatus(trans);
	_SaveDailyQuestStatus(trans);
	_SaveWeeklyQuestStatus(trans);
	_SaveSeasonalQuestStatus(trans);
	_SaveMonthlyQuestStatus(trans);
	_SaveTalents(trans);
	_SaveSpells(trans);
	_SaveSpellCooldowns(trans, logout);
	_SaveActions(trans);
	_SaveAuras(trans, logout);
	_SaveSkills(trans);
	m_achievementMgr->SaveToDB(trans);
	m_reputationMgr->SaveToDB(trans);
	_SaveEquipmentSets(trans);
	GetSession()->SaveTutorialsData(trans);                 // changed only while character in game
	_SaveGlyphs(trans);
	_SaveInstanceTimeRestrictions(trans);

	// check if stats should only be saved on logout
	// save stats can be out of transaction
	if (m_session->isLogingOut() || !sWorld->getBoolConfig(CONFIG_STATS_SAVE_ONLY_ON_LOGOUT))
		_SaveStats(trans);

	CharacterDatabase.CommitTransaction(trans);

	// save pet (hunter pet level and experience and all type pets health/mana).
	if (Pet* pet = GetPet())
		pet->SavePetToDB(PET_SAVE_AS_CURRENT, logout);

	// our: saving system
	if (!create && !logout)
	{
		// pussywizard: if it was not yet our time to save, be we are saved (additional save after important changes)
		// pussywizard: then free our original ticket in saving queue, so saving is fluent with no gaps
		SavingSystemMgr::InsertToSavingSkipListIfNeeded(m_nextSave);

		m_nextSave = SavingSystemMgr::IncreaseSavingMaxValue(1);
	}
}

// fast save function for item/money cheating preventing - save only inventory and money state
void Player::SaveInventoryAndGoldToDB(SQLTransaction& trans)
{
	_SaveInventory(trans);
	SaveGoldToDB(trans);
}

void Player::SaveGoldToDB(SQLTransaction& trans)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_MONEY);
	stmt->setUInt32(0, GetMoney());
	stmt->setUInt32(1, GetGUIDLow());
	trans->Append(stmt);
}

void Player::_SaveActions(SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;

	for (ActionButtonList::iterator itr = m_actionButtons.begin(); itr != m_actionButtons.end();)
	{
		switch (itr->second.uState)
		{
		case ACTIONBUTTON_NEW:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACTION);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt8(1, m_activeSpec);
			stmt->setUInt8(2, itr->first);
			stmt->setUInt32(3, itr->second.GetAction());
			stmt->setUInt8(4, uint8(itr->second.GetType()));
			trans->Append(stmt);

			itr->second.uState = ACTIONBUTTON_UNCHANGED;
			++itr;
			break;
		case ACTIONBUTTON_CHANGED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ACTION);
			stmt->setUInt32(0, itr->second.GetAction());
			stmt->setUInt8(1, uint8(itr->second.GetType()));
			stmt->setUInt32(2, GetGUIDLow());
			stmt->setUInt8(3, itr->first);
			stmt->setUInt8(4, m_activeSpec);
			trans->Append(stmt);

			itr->second.uState = ACTIONBUTTON_UNCHANGED;
			++itr;
			break;
		case ACTIONBUTTON_DELETED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACTION_BY_BUTTON_SPEC);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt8(1, itr->first);
			stmt->setUInt8(2, m_activeSpec);
			trans->Append(stmt);

			m_actionButtons.erase(itr++);
			break;
		default:
			++itr;
			break;
		}
	}
}

void Player::_SaveAuras(SQLTransaction& trans, bool logout)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_AURA);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	for (AuraMap::const_iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end(); ++itr)
	{
		if (!itr->second->CanBeSaved())
			continue;

		Aura* aura = itr->second;
		if (!logout && aura->GetDuration() < 60 * IN_MILLISECONDS)
			continue;

		int32 damage[MAX_SPELL_EFFECTS];
		int32 baseDamage[MAX_SPELL_EFFECTS];
		uint8 effMask = 0;
		uint8 recalculateMask = 0;
		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
		{
			if (AuraEffect const* effect = aura->GetEffect(i))
			{
				baseDamage[i] = effect->GetBaseAmount();
				damage[i] = effect->GetAmount();
				effMask |= 1 << i;
				if (effect->CanBeRecalculated())
					recalculateMask |= 1 << i;
			}
			else
			{
				baseDamage[i] = 0;
				damage[i] = 0;
			}
		}

		uint8 index = 0;
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AURA);
		stmt->setUInt32(index++, GetGUIDLow());
		stmt->setUInt64(index++, itr->second->GetCasterGUID());
		stmt->setUInt64(index++, itr->second->GetCastItemGUID());
		stmt->setUInt32(index++, itr->second->GetId());
		stmt->setUInt8(index++, effMask);
		stmt->setUInt8(index++, recalculateMask);
		stmt->setUInt8(index++, itr->second->GetStackAmount());
		stmt->setInt32(index++, damage[0]);
		stmt->setInt32(index++, damage[1]);
		stmt->setInt32(index++, damage[2]);
		stmt->setInt32(index++, baseDamage[0]);
		stmt->setInt32(index++, baseDamage[1]);
		stmt->setInt32(index++, baseDamage[2]);
		stmt->setInt32(index++, itr->second->GetMaxDuration());
		stmt->setInt32(index++, itr->second->GetDuration());
		stmt->setUInt8(index, itr->second->GetCharges());
		trans->Append(stmt);
	}
}

void Player::_SaveInventory(SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;
	// force items in buyback slots to new state
	// and remove those that aren't already
	for (uint8 i = BUYBACK_SLOT_START; i < BUYBACK_SLOT_END; ++i)
	{
		Item* item = m_items[i];
		if (!item)
			continue;

		if (item->GetState() == ITEM_NEW)
		{
			// Xinef: item is removed, remove loot from storage if any
			if (item->GetTemplate()->Flags & ITEM_PROTO_FLAG_OPENABLE)
				sLootItemStorage->RemoveStoredLoot(item->GetGUIDLow());
			continue;
		}

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
		stmt->setUInt32(0, item->GetGUIDLow());
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
		stmt->setUInt32(0, item->GetGUIDLow());
		trans->Append(stmt);
		m_items[i]->FSetState(ITEM_NEW);

		// Xinef: item is removed, remove loot from storage if any
		if (item->GetTemplate()->Flags & ITEM_PROTO_FLAG_OPENABLE)
			sLootItemStorage->RemoveStoredLoot(item->GetGUIDLow());
	}

	// Updated played time for refundable items. We don't do this in Player::Update because there's simply no need for it,
	// the client auto counts down in real time after having received the initial played time on the first
	// SMSG_ITEM_REFUND_INFO_RESPONSE packet.
	// Item::UpdatePlayedTime is only called when needed, which is in DB saves, and item refund info requests.
	RefundableItemsSet::iterator i_next;
	for (RefundableItemsSet::iterator itr = m_refundableItems.begin(); itr != m_refundableItems.end(); itr = i_next)
	{
		// use copy iterator because itr may be invalid after operations in this loop
		i_next = itr;
		++i_next;

		Item* iPtr = GetItemByGuid(MAKE_NEW_GUID(*itr, 0, HIGHGUID_ITEM));
		if (iPtr)
		{
			iPtr->UpdatePlayedTime(this);
			continue;
		}
		else
		{
			sLog->outError("Can't find item guid %u but is in refundable storage for player %u ! Removing.", *itr, GetGUIDLow());
			m_refundableItems.erase(itr);
		}
	}

	// update enchantment durations
	for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
		itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration, this);

	// if no changes
	if (m_itemUpdateQueue.empty())
		return;

	uint32 lowGuid = GetGUIDLow();
	for (size_t i = 0; i < m_itemUpdateQueue.size(); ++i)
	{
		Item* item = m_itemUpdateQueue[i];
		if (!item)
			continue;

		Bag* container = item->GetContainer();
		uint32 bag_guid = container ? container->GetGUIDLow() : 0;

		if (item->GetState() != ITEM_REMOVED)
		{
			Item* test = GetItemByPos(item->GetBagSlot(), item->GetSlot());
			if (test == NULL)
			{
				uint32 bagTestGUID = 0;
				if (Item* test2 = GetItemByPos(INVENTORY_SLOT_BAG_0, item->GetBagSlot()))
					bagTestGUID = test2->GetGUIDLow();
				sLog->outError("Player(GUID: %u Name: %s)::_SaveInventory - the bag(%u) and slot(%u) values for the item with guid %u (state %d) are incorrect, the player doesn't have an item at that position!", lowGuid, GetName().c_str(), item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow(), (int32)item->GetState());
				// according to the test that was just performed nothing should be in this slot, delete
				stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_BAG_SLOT);
				stmt->setUInt32(0, bagTestGUID);
				stmt->setUInt8(1, item->GetSlot());
				stmt->setUInt32(2, lowGuid);
				trans->Append(stmt);

				RemoveTradeableItem(item); // pussywizard
				RemoveEnchantmentDurationsReferences(item); // pussywizard
				RemoveItemDurations(item); // pussywizard

				// also THIS item should be somewhere else, cheat attempt
				item->FSetState(ITEM_REMOVED); // we are IN updateQueue right now, can't use SetState which modifies the queue
				DeleteRefundReference(item->GetGUIDLow());
				// don't skip, let the switch delete it
				continue;
			}
			else if (test != item)
			{
				sLog->outError("Player(GUID: %u Name: %s)::_SaveInventory - the bag(%u) and slot(%u) values for the item with guid %u are incorrect, the item with guid %u is there instead!", lowGuid, GetName().c_str(), item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow(), test->GetGUIDLow());
				// save all changes to the item...
				if (item->GetState() != ITEM_NEW) // only for existing items, no dupes
					item->SaveToDB(trans);
				// ...but do not save position in invntory
				continue;
			}
		}

		switch (item->GetState())
		{
		case ITEM_NEW:
		case ITEM_CHANGED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_INVENTORY_ITEM);
			stmt->setUInt32(0, lowGuid);
			stmt->setUInt32(1, bag_guid);
			stmt->setUInt8(2, item->GetSlot());
			stmt->setUInt32(3, item->GetGUIDLow());
			trans->Append(stmt);
			break;
		case ITEM_REMOVED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
			stmt->setUInt32(0, item->GetGUIDLow());
			trans->Append(stmt);
		case ITEM_UNCHANGED:
			break;
		}

		item->SaveToDB(trans);                                   // item have unchanged inventory record and can be save standalone
	}
	m_itemUpdateQueue.clear();
}

void Player::_SaveMail(SQLTransaction& trans)
{
	if (!m_mailsLoaded)
		return;

	PreparedStatement* stmt = NULL;

	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
	{
		Mail* m = (*itr);
		if (m->state == MAIL_STATE_CHANGED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL);
			stmt->setUInt8(0, uint8(m->HasItems() ? 1 : 0));
			stmt->setUInt32(1, uint32(m->expire_time));
			stmt->setUInt32(2, uint32(m->deliver_time));
			stmt->setUInt32(3, m->money);
			stmt->setUInt32(4, m->COD);
			stmt->setUInt8(5, uint8(m->checked));
			stmt->setUInt32(6, m->messageID);

			trans->Append(stmt);

			if (!m->removedItems.empty())
			{
				for (std::vector<uint32>::iterator itr2 = m->removedItems.begin(); itr2 != m->removedItems.end(); ++itr2)
				{
					stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
					stmt->setUInt32(0, *itr2);
					trans->Append(stmt);
				}
				m->removedItems.clear();
			}
			m->state = MAIL_STATE_UNCHANGED;
		}
		else if (m->state == MAIL_STATE_DELETED)
		{
			if (m->HasItems())
			{
				for (MailItemInfoVec::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
				{
					stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
					stmt->setUInt32(0, itr2->item_guid);
					trans->Append(stmt);
				}
			}
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
			stmt->setUInt32(0, m->messageID);
			trans->Append(stmt);

			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
			stmt->setUInt32(0, m->messageID);
			trans->Append(stmt);
		}
	}

	//deallocate deleted mails...
	for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end();)
	{
		if ((*itr)->state == MAIL_STATE_DELETED)
		{
			Mail* m = *itr;
			m_mail.erase(itr);
			delete m;
			itr = m_mail.begin();
		}
		else
			++itr;
	}

	m_mailsUpdated = false;
}

void Player::_SaveQuestStatus(SQLTransaction& trans)
{
	bool isTransaction = !trans.null();
	if (!isTransaction)
		trans = CharacterDatabase.BeginTransaction();

	QuestStatusSaveMap::iterator saveItr;
	QuestStatusMap::iterator statusItr;
	PreparedStatement* stmt = NULL;

	bool keepAbandoned = !(sWorld->GetCleaningFlags() & CharacterDatabaseCleaner::CLEANING_FLAG_QUESTSTATUS);

	for (saveItr = m_QuestStatusSave.begin(); saveItr != m_QuestStatusSave.end(); ++saveItr)
	{
		if (saveItr->second)
		{
			statusItr = m_QuestStatus.find(saveItr->first);
			if (statusItr != m_QuestStatus.end() && (keepAbandoned || statusItr->second.Status != QUEST_STATUS_NONE))
			{
				uint8 index = 0;
				stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_QUESTSTATUS);

				stmt->setUInt32(index++, GetGUIDLow());
				stmt->setUInt32(index++, statusItr->first);
				stmt->setUInt8(index++, uint8(statusItr->second.Status));
				stmt->setBool(index++, statusItr->second.Explored);
				stmt->setUInt32(index++, uint32(statusItr->second.Timer / IN_MILLISECONDS + sWorld->GetGameTime()));

				for (uint8 i = 0; i < 4; i++)
					stmt->setUInt16(index++, statusItr->second.CreatureOrGOCount[i]);

				for (uint8 i = 0; i < 4; i++)
					stmt->setUInt16(index++, statusItr->second.ItemCount[i]);

				stmt->setUInt16(index, statusItr->second.PlayerCount);
				trans->Append(stmt);
			}
		}
		else
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_BY_QUEST);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, saveItr->first);
			trans->Append(stmt);
		}
	}

	m_QuestStatusSave.clear();

	for (saveItr = m_RewardedQuestsSave.begin(); saveItr != m_RewardedQuestsSave.end(); ++saveItr)
	{
		if (saveItr->second)
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_QUESTSTATUS_REWARDED);
		else // xinef: what the fuck is this shit? quest can be removed by spelleffect if (!keepAbandoned)
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST);

		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt32(1, saveItr->first);
		trans->Append(stmt);
	}

	m_RewardedQuestsSave.clear();

	if (!isTransaction)
		CharacterDatabase.CommitTransaction(trans);
}

void Player::_SaveDailyQuestStatus(SQLTransaction& trans)
{
	if (!m_DailyQuestChanged)
		return;

	m_DailyQuestChanged = false;

	// save last daily quest time for all quests: we need only mostly reset time for reset check anyway

	// we don't need transactions here.
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_DAILY_CHAR);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);
	for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
	{
		if (GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx))
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx));
			stmt->setUInt64(2, uint64(m_lastDailyQuestTime));
			trans->Append(stmt);
		}
	}

	if (!m_DFQuests.empty())
	{
		for (DFQuestsDoneList::iterator itr = m_DFQuests.begin(); itr != m_DFQuests.end(); ++itr)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, (*itr));
			stmt->setUInt64(2, uint64(m_lastDailyQuestTime));
			trans->Append(stmt);
		}
	}
}

void Player::_SaveWeeklyQuestStatus(SQLTransaction& trans)
{
	if (!m_WeeklyQuestChanged || m_weeklyquests.empty())
		return;

	// we don't need transactions here.
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_WEEKLY_CHAR);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	for (QuestSet::const_iterator iter = m_weeklyquests.begin(); iter != m_weeklyquests.end(); ++iter)
	{
		uint32 quest_id = *iter;

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_WEEKLYQUESTSTATUS);
		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt32(1, quest_id);
		trans->Append(stmt);
	}

	m_WeeklyQuestChanged = false;
}

void Player::_SaveSeasonalQuestStatus(SQLTransaction& trans)
{
	if (!m_SeasonalQuestChanged || m_seasonalquests.empty())
		return;

	// we don't need transactions here.
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_SEASONAL_CHAR);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	for (SeasonalEventQuestMap::const_iterator iter = m_seasonalquests.begin(); iter != m_seasonalquests.end(); ++iter)
	{
		uint16 event_id = iter->first;
		for (SeasonalQuestSet::const_iterator itr = iter->second.begin(); itr != iter->second.end(); ++itr)
		{
			uint32 quest_id = (*itr);

			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_SEASONALQUESTSTATUS);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, quest_id);
			stmt->setUInt32(2, event_id);
			trans->Append(stmt);
		}
	}

	m_SeasonalQuestChanged = false;
}

void Player::_SaveMonthlyQuestStatus(SQLTransaction& trans)
{
	if (!m_MonthlyQuestChanged || m_monthlyquests.empty())
		return;

	// we don't need transactions here.
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_MONTHLY_CHAR);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	for (QuestSet::const_iterator iter = m_monthlyquests.begin(); iter != m_monthlyquests.end(); ++iter)
	{
		uint32 quest_id = *iter;
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_MONTHLYQUESTSTATUS);
		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt32(1, quest_id);
		trans->Append(stmt);
	}

	m_MonthlyQuestChanged = false;
}

void Player::_SaveSkills(SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;
	// we don't need transactions here.
	for (SkillStatusMap::iterator itr = mSkillStatus.begin(); itr != mSkillStatus.end();)
	{
		if (itr->second.uState == SKILL_UNCHANGED)
		{
			++itr;
			continue;
		}

		if (itr->second.uState == SKILL_DELETED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILL_BY_SKILL);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, itr->first);
			trans->Append(stmt);

			mSkillStatus.erase(itr++);
			continue;
		}

		uint32 valueData = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos));
		uint16 value = SKILL_VALUE(valueData);
		uint16 max = SKILL_MAX(valueData);

		switch (itr->second.uState)
		{
		case SKILL_NEW:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILLS);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt16(1, uint16(itr->first));
			stmt->setUInt16(2, value);
			stmt->setUInt16(3, max);
			trans->Append(stmt);

			break;
		case SKILL_CHANGED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_SKILLS);
			stmt->setUInt16(0, value);
			stmt->setUInt16(1, max);
			stmt->setUInt32(2, GetGUIDLow());
			stmt->setUInt16(3, uint16(itr->first));
			trans->Append(stmt);

			break;
		default:
			break;
		}
		itr->second.uState = SKILL_UNCHANGED;

		++itr;
	}
}

void Player::_SaveSpells(SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;

	for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end();)
	{
		// xinef: skip temporary spells
		if (itr->second->State == PLAYERSPELL_TEMPORARY)
		{
			++itr;
			continue;
		}

		// xinef: Delete statement for removed / updated spell
		if (itr->second->State == PLAYERSPELL_REMOVED || itr->second->State == PLAYERSPELL_CHANGED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_BY_SPELL);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, itr->first);
			trans->Append(stmt);
		}

		// xinef: insert statement for new / updated spell
		if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_CHANGED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SPELL);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, itr->first);
			stmt->setUInt8(2, itr->second->specMask);
			trans->Append(stmt);
		}

		if (itr->second->State == PLAYERSPELL_REMOVED)
		{
			delete itr->second;
			m_spells.erase(itr++);
		}
		else
		{
			itr->second->State = PLAYERSPELL_UNCHANGED;
			++itr;
		}
	}
}

// save player stats -- only for external usage
// real stats will be recalculated on player login
void Player::_SaveStats(SQLTransaction& trans)
{
	// check if stat saving is enabled and if char level is high enough
	if (!sWorld->getIntConfig(CONFIG_MIN_LEVEL_STAT_SAVE) || getLevel() < sWorld->getIntConfig(CONFIG_MIN_LEVEL_STAT_SAVE))
		return;

	PreparedStatement* stmt = NULL;

	stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_STATS);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	uint8 index = 0;

	stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_STATS);
	stmt->setUInt32(index++, GetGUIDLow());
	stmt->setUInt32(index++, GetMaxHealth());

	for (uint8 i = 0; i < MAX_POWERS; ++i)
		stmt->setUInt32(index++, GetMaxPower(Powers(i)));

	for (uint8 i = 0; i < MAX_STATS; ++i)
		stmt->setUInt32(index++, GetStat(Stats(i)));

	for (int i = 0; i < MAX_SPELL_SCHOOL; ++i)
		stmt->setUInt32(index++, GetResistance(SpellSchools(i)));

	stmt->setFloat(index++, GetFloatValue(PLAYER_BLOCK_PERCENTAGE));
	stmt->setFloat(index++, GetFloatValue(PLAYER_DODGE_PERCENTAGE));
	stmt->setFloat(index++, GetFloatValue(PLAYER_PARRY_PERCENTAGE));
	stmt->setFloat(index++, GetFloatValue(PLAYER_CRIT_PERCENTAGE));
	stmt->setFloat(index++, GetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE));
	stmt->setFloat(index++, GetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1));
	stmt->setUInt32(index++, GetUInt32Value(UNIT_FIELD_ATTACK_POWER));
	stmt->setUInt32(index++, GetUInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER));
	stmt->setUInt32(index++, GetBaseSpellPowerBonus());
	stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + CR_CRIT_TAKEN_SPELL));

	trans->Append(stmt);
}

void Player::outDebugValues() const
{
	if (!sLog->IsOutDebug())                                  // optimize disabled debug output
		return;

	;//sLog->outDebug(LOG_FILTER_UNITS, "HP is: \t\t\t%u\t\tMP is: \t\t\t%u", GetMaxHealth(), GetMaxPower(POWER_MANA));
	;//sLog->outDebug(LOG_FILTER_UNITS, "AGILITY is: \t\t%f\t\tSTRENGTH is: \t\t%f", GetStat(STAT_AGILITY), GetStat(STAT_STRENGTH));
	;//sLog->outDebug(LOG_FILTER_UNITS, "INTELLECT is: \t\t%f\t\tSPIRIT is: \t\t%f", GetStat(STAT_INTELLECT), GetStat(STAT_SPIRIT));
	;//sLog->outDebug(LOG_FILTER_UNITS, "STAMINA is: \t\t%f", GetStat(STAT_STAMINA));
	;//sLog->outDebug(LOG_FILTER_UNITS, "Armor is: \t\t%u\t\tBlock is: \t\t%f", GetArmor(), GetFloatValue(PLAYER_BLOCK_PERCENTAGE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "HolyRes is: \t\t%u\t\tFireRes is: \t\t%u", GetResistance(SPELL_SCHOOL_HOLY), GetResistance(SPELL_SCHOOL_FIRE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "NatureRes is: \t\t%u\t\tFrostRes is: \t\t%u", GetResistance(SPELL_SCHOOL_NATURE), GetResistance(SPELL_SCHOOL_FROST));
	;//sLog->outDebug(LOG_FILTER_UNITS, "ShadowRes is: \t\t%u\t\tArcaneRes is: \t\t%u", GetResistance(SPELL_SCHOOL_SHADOW), GetResistance(SPELL_SCHOOL_ARCANE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "MIN_DAMAGE is: \t\t%f\tMAX_DAMAGE is: \t\t%f", GetFloatValue(UNIT_FIELD_MINDAMAGE), GetFloatValue(UNIT_FIELD_MAXDAMAGE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "MIN_OFFHAND_DAMAGE is: \t%f\tMAX_OFFHAND_DAMAGE is: \t%f", GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE), GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "MIN_RANGED_DAMAGE is: \t%f\tMAX_RANGED_DAMAGE is: \t%f", GetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE), GetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE));
	;//sLog->outDebug(LOG_FILTER_UNITS, "ATTACK_TIME is: \t%u\t\tRANGE_ATTACK_TIME is: \t%u", GetAttackTime(BASE_ATTACK), GetAttackTime(RANGED_ATTACK));
}

/*********************************************************/
/***               FLOOD FILTER SYSTEM                 ***/
/*********************************************************/

void Player::UpdateSpeakTime(uint32 specialMessageLimit)
{
	// ignore chat spam protection for GMs in any mode
	if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
		return;

	time_t current = time(NULL);
	if (m_speakTime > current)
	{
		uint32 max_count = specialMessageLimit ? specialMessageLimit : sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_COUNT);
		if (!max_count)
			return;

		++m_speakCount;
		if (m_speakCount >= max_count)
		{
			// prevent overwrite mute time, if message send just before mutes set, for example.
			time_t new_mute = current + sWorld->getIntConfig(CONFIG_CHATFLOOD_MUTE_TIME);
			if (GetSession()->m_muteTime < new_mute)
				GetSession()->m_muteTime = new_mute;

			m_speakCount = 0;
		}
	}
	else
		m_speakCount = 1;

	m_speakTime = current + sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_DELAY);
}

bool Player::CanSpeak() const
{
	return  GetSession()->m_muteTime <= time(NULL);
}

/*********************************************************/
/***              LOW LEVEL FUNCTIONS:Notifiers        ***/
/*********************************************************/

void Player::SendAttackSwingNotInRange()
{
	WorldPacket data(SMSG_ATTACKSWING_NOTINRANGE, 0);
	GetSession()->SendPacket(&data);
}

void Player::SavePositionInDB(uint32 mapid, float x, float y, float z, float o, uint32 zone, uint64 guid)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);

	stmt->setFloat(0, x);
	stmt->setFloat(1, y);
	stmt->setFloat(2, z);
	stmt->setFloat(3, o);
	stmt->setUInt16(4, uint16(mapid));
	stmt->setUInt16(5, uint16(zone));
	stmt->setUInt32(6, GUID_LOPART(guid));

	CharacterDatabase.Execute(stmt);
}

void Player::SetUInt32ValueInArray(Tokenizer& tokens, uint16 index, uint32 value)
{
	char buf[11];
	snprintf(buf, 11, "%u", value);

	if (index >= tokens.size())
		return;

	tokens[index] = buf;
}

void Player::Customize(uint64 guid, uint8 gender, uint8 skin, uint8 face, uint8 hairStyle, uint8 hairColor, uint8 facialHair)
{
	// xinef: zomg! sync query
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PLAYERBYTES2);
	stmt->setUInt32(0, GUID_LOPART(guid));
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result)
		return;

	Field* fields = result->Fetch();

	uint32 playerBytes2 = fields[0].GetUInt32();
	playerBytes2 &= ~0xFF;
	playerBytes2 |= facialHair;

	stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_GENDER_PLAYERBYTES);

	stmt->setUInt8(0, gender);
	stmt->setUInt32(1, skin | (face << 8) | (hairStyle << 16) | (hairColor << 24));
	stmt->setUInt32(2, playerBytes2);
	stmt->setUInt32(3, GUID_LOPART(guid));

	CharacterDatabase.Execute(stmt);
}

void Player::SendAttackSwingDeadTarget()
{
	WorldPacket data(SMSG_ATTACKSWING_DEADTARGET, 0);
	GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingCantAttack()
{
	WorldPacket data(SMSG_ATTACKSWING_CANT_ATTACK, 0);
	GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingCancelAttack()
{
	WorldPacket data(SMSG_CANCEL_COMBAT, 0);
	GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingBadFacingAttack()
{
	WorldPacket data(SMSG_ATTACKSWING_BADFACING, 0);
	GetSession()->SendPacket(&data);
}

void Player::SendAutoRepeatCancel(Unit* target)
{
	WorldPacket data(SMSG_CANCEL_AUTO_REPEAT, target->GetPackGUID().size());
	data.append(target->GetPackGUID());                     // may be it's target guid
	SendMessageToSet(&data, true);
}

void Player::SendExplorationExperience(uint32 Area, uint32 Experience)
{
	WorldPacket data(SMSG_EXPLORATION_EXPERIENCE, 8);
	data << uint32(Area);
	data << uint32(Experience);
	GetSession()->SendPacket(&data);
}

void Player::SendDungeonDifficulty(bool IsInGroup)
{
	uint8 val = 0x00000001;
	WorldPacket data(MSG_SET_DUNGEON_DIFFICULTY, 12);
	data << (uint32)GetDungeonDifficulty();
	data << uint32(val);
	data << uint32(IsInGroup);
	GetSession()->SendPacket(&data);
}

void Player::SendRaidDifficulty(bool IsInGroup, int32 forcedDifficulty)
{
	uint8 val = 0x00000001;
	WorldPacket data(MSG_SET_RAID_DIFFICULTY, 12);
	data << uint32(forcedDifficulty == -1 ? GetRaidDifficulty() : forcedDifficulty);
	data << uint32(val);
	data << uint32(IsInGroup);
	GetSession()->SendPacket(&data);
}

void Player::SendResetFailedNotify(uint32 mapid)
{
	WorldPacket data(SMSG_RESET_FAILED_NOTIFY, 4);
	data << uint32(mapid);
	GetSession()->SendPacket(&data);
}

/// Reset all solo instances and optionally send a message on success for each
void Player::ResetInstances(uint64 guid, uint8 method, bool isRaid)
{
	switch (method)
	{
	case INSTANCE_RESET_ALL:
	{
		Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
		if (!p || p->GetDifficulty(false) != DUNGEON_DIFFICULTY_NORMAL)
			break;
		std::vector<InstanceSave*> toUnbind;
		BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUIDLow(), Difficulty(DUNGEON_DIFFICULTY_NORMAL));
		for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
		{
			InstanceSave* instanceSave = itr->second.save;
			const MapEntry* entry = sMapStore.LookupEntry(itr->first);
			if (!entry || entry->IsRaid() || !instanceSave->CanReset())
				continue;

			Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
			if (!map || map->ToInstanceMap()->Reset(method))
			{
				p->SendResetInstanceSuccess(instanceSave->GetMapId());
				toUnbind.push_back(instanceSave);
			}
			else
				p->SendResetInstanceFailed(0, instanceSave->GetMapId());
		}
		for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
			sInstanceSaveMgr->UnbindAllFor(*itr);
	}
	break;
	case INSTANCE_RESET_CHANGE_DIFFICULTY:
	{
		Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
		if (!p)
			break;
		std::vector<InstanceSave*> toUnbind;
		BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUIDLow(), p->GetDifficulty(isRaid));
		for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
		{
			InstanceSave* instanceSave = itr->second.save;
			const MapEntry* entry = sMapStore.LookupEntry(itr->first);
			if (!entry || entry->IsRaid() != isRaid || !instanceSave->CanReset())
				continue;

			Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
			if (!map || map->ToInstanceMap()->Reset(method))
			{
				p->SendResetInstanceSuccess(instanceSave->GetMapId());
				toUnbind.push_back(instanceSave);
			}
			else
				p->SendResetInstanceFailed(0, instanceSave->GetMapId());
		}
		for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
			sInstanceSaveMgr->UnbindAllFor(*itr);
	}
	break;
	case INSTANCE_RESET_GROUP_JOIN:
	{
		Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
		if (!p)
			break;
		for (uint8 d = 0; d < MAX_DIFFICULTY; ++d)
		{
			std::vector<InstanceSave*> toUnbind;
			BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUIDLow(), Difficulty(d));
			for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
			{
				if (itr->second.perm)
					continue;
				InstanceSave* instanceSave = itr->second.save;
				Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
				if (!map || p->FindMap() != map)
				{
					//p->SendResetInstanceSuccess(instanceSave->GetMapId());
					toUnbind.push_back(instanceSave);
				}
				//else
				//  p->SendResetInstanceFailed(0, instanceSave->GetMapId());
			}
			for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
				sInstanceSaveMgr->PlayerUnbindInstance(p->GetGUIDLow(), (*itr)->GetMapId(), (*itr)->GetDifficulty(), true, p);
		}
	}
	break;
	case INSTANCE_RESET_GROUP_LEAVE:
	{
		Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
		for (uint8 d = 0; d < MAX_DIFFICULTY; ++d)
		{
			std::vector<InstanceSave*> toUnbind;
			BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GUID_LOPART(guid), Difficulty(d));
			for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
			{
				if (itr->second.perm)
					continue;
				InstanceSave* instanceSave = itr->second.save;
				Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
				if (!p || !map || p->FindMap() != map)
				{
					//p->SendResetInstanceSuccess(instanceSave->GetMapId());
					toUnbind.push_back(instanceSave);
				}
				//else
				//  p->SendResetInstanceFailed(0, instanceSave->GetMapId());
			}
			for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
				sInstanceSaveMgr->PlayerUnbindInstance(GUID_LOPART(guid), (*itr)->GetMapId(), (*itr)->GetDifficulty(), true, p);
		}
	}
	break;
	}
}

void Player::SendResetInstanceSuccess(uint32 MapId)
{
	WorldPacket data(SMSG_INSTANCE_RESET, 4);
	data << uint32(MapId);
	GetSession()->SendPacket(&data);
}

void Player::SendResetInstanceFailed(uint32 reason, uint32 MapId)
{
	/*reasons for instance reset failure:
	// 0: There are players inside the instance.
	// 1: There are players offline in your party.
	// 2>: There are players in your party attempting to zone into an instance.
	*/
	WorldPacket data(SMSG_INSTANCE_RESET_FAILED, 4);
	data << uint32(reason);
	data << uint32(MapId);
	GetSession()->SendPacket(&data);
}

/*********************************************************/
/***              Update timers                        ***/
/*********************************************************/

///checks the 15 afk reports per 5 minutes limit
void Player::UpdateAfkReport(time_t currTime)
{
	if (m_bgData.bgAfkReportedTimer <= currTime)
	{
		m_bgData.bgAfkReportedCount = 0;
		m_bgData.bgAfkReportedTimer = currTime + 5 * MINUTE;
	}
}

void Player::UpdateContestedPvP(uint32 diff)
{
	if (!m_contestedPvPTimer || IsInCombat())
		return;
	if (m_contestedPvPTimer <= diff)
	{
		ResetContestedPvP();
	}
	else
		m_contestedPvPTimer -= diff;
}

void Player::UpdatePvPFlag(time_t currTime)
{
	if (!IsPvP())
		return;
	if (pvpInfo.EndTimer == 0 || pvpInfo.IsHostile)
		return;
	if (currTime < (pvpInfo.EndTimer + 300 + 5))
	{
		if (currTime > (pvpInfo.EndTimer + 4) && !HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER))
			SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER);
		return;
	}

	UpdatePvP(false);
}

void Player::UpdateDuelFlag(time_t currTime)
{
	if (!duel || duel->startTimer == 0 || currTime < duel->startTimer + 3)
		return;

	sScriptMgr->OnPlayerDuelStart(this, duel->opponent);

	SetUInt32Value(PLAYER_DUEL_TEAM, 1);
	duel->opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 2);

	duel->startTimer = 0;
	duel->startTime = currTime;
	duel->opponent->duel->startTimer = 0;
	duel->opponent->duel->startTime = currTime;
}

Pet* Player::GetPet() const
{
	if (uint64 pet_guid = GetPetGUID())
	{
		if (!IS_PET_GUID(pet_guid))
			return NULL;

		Pet* pet = ObjectAccessor::GetPet(*this, pet_guid);

		if (!pet)
			return NULL;

		if (IsInWorld() && pet)
			return pet;

		//there may be a guardian in slot
		//sLog->outError("Player::GetPet: Pet %u not exist.", GUID_LOPART(pet_guid));
		//const_cast<Player*>(this)->SetPetGUID(0);
	}

	return NULL;
}

void Player::RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent)
{
	if (!pet)
		pet = GetPet();

	if (pet)
	{
		// xinef: dont save dead pet as current, save him not in slot
		if (!pet->IsAlive() && mode == PET_SAVE_AS_CURRENT && pet->getPetType() == HUNTER_PET)
			mode = PET_SAVE_NOT_IN_SLOT;

		;//sLog->outDebug(LOG_FILTER_PETS, "RemovePet %u, %u, %u", pet->GetEntry(), mode, returnreagent);
		if (pet->m_removed)
			return;
	}

	if (returnreagent && (pet || m_temporaryUnsummonedPetNumber) && !InBattleground())
	{
		//returning of reagents only for players, so best done here
		uint32 spellId = pet ? pet->GetUInt32Value(UNIT_CREATED_BY_SPELL) : m_oldpetspell;
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);

		if (spellInfo)
		{
			for (uint32 i = 0; i < MAX_SPELL_REAGENTS; ++i)
			{
				if (spellInfo->Reagent[i] > 0)
				{
					ItemPosCountVec dest;                   //for succubus, voidwalker, felhunter and felguard credit soulshard when despawn reason other than death (out of range, logout)
					InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, spellInfo->Reagent[i], spellInfo->ReagentCount[i]);
					if (msg == EQUIP_ERR_OK)
					{
						Item* item = StoreNewItem(dest, spellInfo->Reagent[i], true);
						if (IsInWorld())
							SendNewItem(item, spellInfo->ReagentCount[i], true, false);
					}
				}
			}
		}
		m_temporaryUnsummonedPetNumber = 0;
	}

	if (!pet || pet->GetOwnerGUID() != GetGUID())
		return;

	pet->CombatStop();

	// only if current pet in slot
	pet->SavePetToDB(mode, true);

	SetMinion(pet, false);

	pet->AddObjectToRemoveList();
	pet->m_removed = true;

	if (pet->isControlled())
	{
		WorldPacket data(SMSG_PET_SPELLS, 8);
		data << uint64(0);
		GetSession()->SendPacket(&data);

		if (GetGroup())
			SetGroupUpdateFlag(GROUP_UPDATE_PET);
	}

	if (NeedSendSpectatorData() && pet->GetCreatureTemplate()->family)
	{
		ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PHP", 0);
		ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PET", 0);
	}
}

void Player::StopCastingCharm()
{
	Unit* charm = GetCharm();
	if (!charm)
		return;

	if (charm->GetTypeId() == TYPEID_UNIT)
	{
		if (charm->ToCreature()->HasUnitTypeMask(UNIT_MASK_PUPPET))
			((Puppet*)charm)->UnSummon();
		else if (charm->IsVehicle())
			ExitVehicle();
	}
	if (GetCharmGUID())
		charm->RemoveCharmAuras();

	if (GetCharmGUID())
	{
		sLog->outCrash("Player %s (GUID: " UI64FMTD " is not able to uncharm unit (GUID: " UI64FMTD " Entry: %u, Type: %u)", GetName().c_str(), GetGUID(), GetCharmGUID(), charm->GetEntry(), charm->GetTypeId());
		if (charm->GetCharmerGUID())
		{
			sLog->outCrash("Charmed unit has charmer guid " UI64FMTD, charm->GetCharmerGUID());
			ASSERT(false);
		}
		else
			SetCharm(charm, false);
	}
}

void Player::Say(const std::string& text, const uint32 language)
{
	std::string _text(text);
	sScriptMgr->OnPlayerChat(this, CHAT_MSG_SAY, language, _text);

	WorldPacket data;
	ChatHandler::BuildChatPacket(data, CHAT_MSG_SAY, Language(language), this, this, text);
	SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), true);
}

void Player::Yell(const std::string& text, const uint32 language)
{
	std::string _text(text);
	sScriptMgr->OnPlayerChat(this, CHAT_MSG_YELL, language, _text);

	WorldPacket data;
	ChatHandler::BuildChatPacket(data, CHAT_MSG_YELL, Language(language), this, this, text);
	SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL), true);
}

void Player::TextEmote(const std::string& text)
{
	std::string _text(text);
	sScriptMgr->OnPlayerChat(this, CHAT_MSG_EMOTE, LANG_UNIVERSAL, _text);

	WorldPacket data;
	ChatHandler::BuildChatPacket(data, CHAT_MSG_EMOTE, LANG_UNIVERSAL, this, this, text);
	SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), true, !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT));
}

void Player::Whisper(const std::string& text, uint32 language, uint64 receiver)
{
	bool isAddonMessage = language == LANG_ADDON;

	if (!isAddonMessage)                                    // if not addon data
		language = LANG_UNIVERSAL;                          // whispers should always be readable

	Player* rPlayer = ObjectAccessor::GetObjectInOrOutOfWorld(receiver, (Player*)NULL);

	std::string _text(text);
	sScriptMgr->OnPlayerChat(this, CHAT_MSG_WHISPER, language, _text, rPlayer);

	WorldPacket data;
	ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, Language(language), this, this, text);
	rPlayer->GetSession()->SendPacket(&data);

	// rest stuff shouldn't happen in case of addon message
	if (isAddonMessage)
		return;

	ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER_INFORM, Language(language), rPlayer, rPlayer, text);
	GetSession()->SendPacket(&data);

	if (!isAcceptWhispers() && !IsGameMaster() && !rPlayer->IsGameMaster())
	{
		SetAcceptWhispers(true);
		ChatHandler(GetSession()).SendSysMessage(LANG_COMMAND_WHISPERON);
	}

	// announce afk or dnd message
	if (rPlayer->isAFK())
		ChatHandler(GetSession()).PSendSysMessage(LANG_PLAYER_AFK, rPlayer->GetName().c_str(), rPlayer->autoReplyMsg.c_str());
	else if (rPlayer->isDND())
		ChatHandler(GetSession()).PSendSysMessage(LANG_PLAYER_DND, rPlayer->GetName().c_str(), rPlayer->autoReplyMsg.c_str());
}

void Player::PetSpellInitialize()
{
	Pet* pet = GetPet();

	if (!pet)
		return;

	;//sLog->outDebug(LOG_FILTER_PETS, "Pet Spells Groups");

	CharmInfo* charmInfo = pet->GetCharmInfo();

	WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 1);
	data << uint64(pet->GetGUID());
	data << uint16(pet->GetCreatureTemplate()->family);         // creature family (required for pet talents)
	data << uint32(pet->GetDuration());
	data << uint8(pet->GetReactState());
	data << uint8(charmInfo->GetCommandState());
	data << uint16(0); // Flags, mostly unknown

	// action bar loop
	charmInfo->BuildActionBar(&data);

	size_t spellsCountPos = data.wpos();

	// spells count
	uint8 addlist = 0;
	data << uint8(addlist);                                 // placeholder

	if (pet->IsPermanentPetFor(this))
	{
		// spells loop
		for (PetSpellMap::iterator itr = pet->m_spells.begin(); itr != pet->m_spells.end(); ++itr)
		{
			if (itr->second.state == PETSPELL_REMOVED)
				continue;

			data << uint32(MAKE_UNIT_ACTION_BUTTON(itr->first, itr->second.active));
			++addlist;
		}
	}

	data.put<uint8>(spellsCountPos, addlist);

	uint8 cooldownsCount = pet->m_CreatureSpellCooldowns.size();
	data << uint8(cooldownsCount);

	uint32 curTime = World::GetGameTimeMS();

	for (CreatureSpellCooldowns::const_iterator itr = pet->m_CreatureSpellCooldowns.begin(); itr != pet->m_CreatureSpellCooldowns.end(); ++itr)
	{
		uint32 cooldown = (itr->second > curTime) ? itr->second - curTime : 0;

		data << uint32(itr->first);                         // spellid
		data << uint16(0);                                  // spell category?
		data << uint32(cooldown);                           // cooldown
		data << uint32(0);                                  // category cooldown
	}

	GetSession()->SendPacket(&data);
}

void Player::PossessSpellInitialize()
{
	Unit* charm = GetCharm();
	if (!charm)
		return;

	CharmInfo* charmInfo = charm->GetCharmInfo();

	if (!charmInfo)
	{
		sLog->outError("Player::PossessSpellInitialize(): charm (" UI64FMTD ") has no charminfo!", charm->GetGUID());
		return;
	}

	WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 1);
	data << uint64(charm->GetGUID());
	data << uint16(0);
	data << uint32(0);
	data << uint32(0);

	charmInfo->BuildActionBar(&data);

	data << uint8(0);                                       // spells count
	data << uint8(0);                                       // cooldowns count

	GetSession()->SendPacket(&data);
}

void Player::VehicleSpellInitialize()
{
	Creature* vehicle = GetVehicleCreatureBase();
	if (!vehicle)
		return;

	uint8 cooldownCount = vehicle->m_CreatureSpellCooldowns.size();

	WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * 10 + 1 + 1 + cooldownCount * (4 + 2 + 4 + 4));
	data << uint64(vehicle->GetGUID());                     // Guid
	data << uint16(0);                                      // Pet Family (0 for all vehicles)
	data << uint32(vehicle->IsSummon() ? vehicle->ToTempSummon()->GetTimer() : 0); // Duration
	// The following three segments are read by the client as one uint32
	data << uint8(vehicle->GetReactState());                // React State
	data << uint8(0);                                       // Command State
	data << uint16(0x800);                                  // DisableActions (set for all vehicles)

	for (uint32 i = 0; i < CREATURE_MAX_SPELLS; ++i)
	{
		uint32 spellId = vehicle->m_spells[i];
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
		if (!spellInfo)
		{
			data << uint16(0) << uint8(0) << uint8(i + 8);
			continue;
		}

		ConditionList conditions = sConditionMgr->GetConditionsForVehicleSpell(vehicle->GetEntry(), spellId);
		if (!sConditionMgr->IsObjectMeetToConditions(this, vehicle, conditions))
		{
			;//sLog->outDebug(LOG_FILTER_CONDITIONSYS, "VehicleSpellInitialize: conditions not met for Vehicle entry %u spell %u", vehicle->ToCreature()->GetEntry(), spellId);
			data << uint16(0) << uint8(0) << uint8(i + 8);
			continue;
		}

		if (spellInfo->IsPassive())
			vehicle->CastSpell(vehicle, spellId, true);

		data << uint32(MAKE_UNIT_ACTION_BUTTON(spellId, i + 8));
	}

	for (uint32 i = CREATURE_MAX_SPELLS; i < MAX_SPELL_CONTROL_BAR; ++i)
		data << uint32(0);

	data << uint8(0); // Auras?

	// Cooldowns
	data << uint8(cooldownCount);

	uint32 curTime = World::GetGameTimeMS();

	for (CreatureSpellCooldowns::const_iterator itr = vehicle->m_CreatureSpellCooldowns.begin(); itr != vehicle->m_CreatureSpellCooldowns.end(); ++itr)
	{
		uint32 cooldown = (itr->second > curTime) ? itr->second - curTime : 0;
		data << uint32(itr->first); // SpellId
		data << uint16(0);          // unk
		data << uint32(cooldown);   // spell cooldown
		data << uint32(0);          // category cooldown
	}

	GetSession()->SendPacket(&data);
}

void Player::CharmSpellInitialize()
{
	Unit* charm = GetFirstControlled();
	if (!charm)
		return;

	CharmInfo* charmInfo = charm->GetCharmInfo();
	if (!charmInfo)
	{
		sLog->outError("Player::CharmSpellInitialize(): the player's charm (" UI64FMTD ") has no charminfo!", charm->GetGUID());
		return;
	}

	uint8 addlist = 0;
	if (charm->GetTypeId() != TYPEID_PLAYER)
	{
		//CreatureInfo const* cinfo = charm->ToCreature()->GetCreatureTemplate();
		//if (cinfo && cinfo->type == CREATURE_TYPE_DEMON && getClass() == CLASS_WARLOCK)
		{
			for (uint32 i = 0; i < MAX_SPELL_CHARM; ++i)
				if (charmInfo->GetCharmSpell(i)->GetAction())
					++addlist;
		}
	}

	WorldPacket data(SMSG_PET_SPELLS, 8 + 2 + 4 + 4 + 4 * MAX_UNIT_ACTION_BAR_INDEX + 1 + 4 * addlist + 1);
	data << uint64(charm->GetGUID());
	data << uint16(0);
	data << uint32(0);

	if (charm->GetTypeId() != TYPEID_PLAYER)
		data << uint8(charm->ToCreature()->GetReactState()) << uint8(charmInfo->GetCommandState()) << uint16(0);
	else
		data << uint32(0);

	charmInfo->BuildActionBar(&data);

	data << uint8(addlist);

	if (addlist)
	{
		for (uint32 i = 0; i < MAX_SPELL_CHARM; ++i)
		{
			CharmSpellInfo* cspell = charmInfo->GetCharmSpell(i);
			if (cspell->GetAction())
				data << uint32(cspell->packedData);
		}
	}

	data << uint8(0);                                       // cooldowns count

	GetSession()->SendPacket(&data);
}

void Player::SendRemoveControlBar()
{
	WorldPacket data(SMSG_PET_SPELLS, 8);
	data << uint64(0);
	GetSession()->SendPacket(&data);
}

bool Player::HasSpellMod(SpellModifier* mod, Spell* spell)
{
	if (!mod || !spell)
		return false;

	return spell->m_appliedMods.find(mod->ownerAura) != spell->m_appliedMods.end();
}

bool Player::IsAffectedBySpellmod(SpellInfo const* spellInfo, SpellModifier* mod, Spell* spell)
{
	if (!mod || !spellInfo)
		return false;

	// Mod out of charges
	if (spell && mod->charges == -1 && spell->m_appliedMods.find(mod->ownerAura) == spell->m_appliedMods.end())
		return false;

	// +duration to infinite duration spells making them limited
	if (mod->op == SPELLMOD_DURATION && spellInfo->GetDuration() == -1)
		return false;

	return spellInfo->IsAffectedBySpellMod(mod);
}

// Binary predicate for sorting SpellModifiers
class SpellModPred
{
public:
	SpellModPred() {}
	bool operator() (const SpellModifier* a, const SpellModifier* b) const
	{
		if (a->type != b->type)
			return a->type == SPELLMOD_FLAT;
		return a->value < b->value;
	}
};
class MageSpellModPred
{
public:
	MageSpellModPred() {}
	bool operator() (const SpellModifier* a, const SpellModifier* b) const
	{
		if (a->type != b->type)
			return a->type == SPELLMOD_FLAT;
		if (a->spellId == 44401)
			return true;
		if (b->spellId == 44401)
			return false;
		return a->value < b->value;
	}
};

void Player::AddSpellMod(SpellModifier* mod, bool apply)
{
	;//sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "Player::AddSpellMod %d", mod->spellId);
	uint16 Opcode = (mod->type == SPELLMOD_FLAT) ? SMSG_SET_FLAT_SPELL_MODIFIER : SMSG_SET_PCT_SPELL_MODIFIER;

	int i = 0;
	flag96 _mask = 0;
	for (int eff = 0; eff < 96; ++eff)
	{
		if (eff != 0 && eff % 32 == 0)
			_mask[i++] = 0;

		_mask[i] = uint32(1) << (eff - (32 * i));
		if (mod->mask & _mask)
		{
			int32 val = 0;
			for (SpellModList::iterator itr = m_spellMods[mod->op].begin(); itr != m_spellMods[mod->op].end(); ++itr)
			{
				if ((*itr)->type == mod->type && (*itr)->mask & _mask)
					val += (*itr)->value;
			}
			val += apply ? mod->value : -(mod->value);
			WorldPacket data(Opcode, (1 + 1 + 4));
			data << uint8(eff);
			data << uint8(mod->op);
			data << int32(val);
			SendDirectMessage(&data);
		}
	}

	if (apply)
	{
		m_spellMods[mod->op].push_back(mod);
		if (getClass() == CLASS_MAGE)
			m_spellMods[mod->op].sort(MageSpellModPred());
		else
			m_spellMods[mod->op].sort(SpellModPred());
	}
	else
	{
		m_spellMods[mod->op].remove(mod);
		// mods bound to aura will be removed in AuraEffect::~AuraEffect
		if (!mod->ownerAura)
			delete mod;
	}
}

// Restore spellmods in case of failed cast
void Player::RestoreSpellMods(Spell* spell, uint32 ownerAuraId, Aura* aura)
{
	if (!spell || spell->m_appliedMods.empty())
		return;

	std::list<Aura*> aurasQueue;

	for (uint8 i = 0; i < MAX_SPELLMOD; ++i)
	{
		for (SpellModList::iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end(); ++itr)
		{
			SpellModifier* mod = *itr;

			// Spellmods without aura set cannot be charged
			if (!mod->ownerAura || !mod->ownerAura->IsUsingCharges())
				continue;

			// Restore only specific owner aura mods
			if (ownerAuraId && (ownerAuraId != mod->ownerAura->GetSpellInfo()->Id))
				continue;

			if (aura && mod->ownerAura != aura)
				continue;

			// Check if mod affected this spell
			// First, check if the mod aura applied at least one spellmod to this spell
			Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(mod->ownerAura);
			if (iterMod == spell->m_appliedMods.end())
				continue;
			// Second, check if the current mod is one of those applied by the mod aura
			if (!(mod->mask & spell->m_spellInfo->SpellFamilyFlags))
				continue;

			// remove from list - This will be done after all mods have been gone through
			// to ensure we iterate over all mods of an aura before removing said aura
			// from applied mods (Else, an aura with two mods on the current spell would
			// only see the first of its modifier restored)
			aurasQueue.push_back(mod->ownerAura);

			// add mod charges back to mod
			if (mod->charges == -1)
				mod->charges = 1;
			else
				mod->charges++;

			// Do not set more spellmods than available
			if (mod->ownerAura->GetCharges() < mod->charges)
				mod->charges = mod->ownerAura->GetCharges();

			// Skip this check for now - aura charges may change due to various reason
			/// @todo track these changes correctly
			//ASSERT (mod->ownerAura->GetCharges() <= mod->charges);
		}
	}

	for (std::list<Aura*>::iterator itr = aurasQueue.begin(); itr != aurasQueue.end(); ++itr)
	{
		Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(*itr);
		if (iterMod != spell->m_appliedMods.end())
			spell->m_appliedMods.erase(iterMod);
	}

	// Xinef: clear the list just do be sure
	if (!ownerAuraId && !aura)
		spell->m_appliedMods.clear();
}

void Player::RestoreAllSpellMods(uint32 ownerAuraId, Aura* aura)
{
	for (uint32 i = 0; i < CURRENT_MAX_SPELL; ++i)
		if (m_currentSpells[i])
			RestoreSpellMods(m_currentSpells[i], ownerAuraId, aura);
}

void Player::RemoveSpellMods(Spell* spell)
{
	if (!spell)
		return;

	if (spell->m_appliedMods.empty())
		return;

	const SpellInfo *const spellInfo = spell->m_spellInfo;

	for (uint8 i = 0; i < MAX_SPELLMOD; ++i)
	{
		for (SpellModList::const_iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end();)
		{
			SpellModifier* mod = *itr;
			++itr;

			// spellmods without aura set cannot be charged
			if (!mod->ownerAura || !mod->ownerAura->IsUsingCharges())
				continue;

			// check if mod affected this spell
			Spell::UsedSpellMods::iterator iterMod = spell->m_appliedMods.find(mod->ownerAura);
			if (iterMod == spell->m_appliedMods.end())
				continue;

			// remove from list
			// leave this here, if spell have two mods it will remove 2 charges - wrong
			spell->m_appliedMods.erase(iterMod);

			// MAGE T8P4 BONUS
			if (spellInfo->SpellFamilyName == SPELLFAMILY_MAGE)
			{
				const SpellInfo *sp = mod->ownerAura->GetSpellInfo();
				// Missile Barrage, Hot Streak, Brain Freeze (trigger spell - Fireball!)
				if (sp->SpellIconID == 3261 || sp->SpellIconID == 2999 || sp->SpellIconID == 2938)
					if (AuraEffect *aurEff = GetAuraEffectDummy(64869))
						if (roll_chance_i(aurEff->GetAmount()))
						{
							mod->charges = 1;
							continue;
						}
			}

			if (mod->ownerAura->DropCharge(AURA_REMOVE_BY_EXPIRE))
				itr = m_spellMods[i].begin();
		}
	}
}

void Player::DropModCharge(SpellModifier* mod, Spell* spell)
{
	// don't handle spells with proc_event entry defined
	// this is a temporary workaround, because all spellmods should be handled like that
	if (sSpellMgr->GetSpellProcEvent(mod->spellId))
		return;

	if (spell && mod->ownerAura && mod->charges > 0)
	{
		if (--mod->charges == 0)
			mod->charges = -1;

		spell->m_appliedMods.insert(mod->ownerAura);
	}
}

void Player::SetSpellModTakingSpell(Spell* spell, bool apply)
{
	if (apply && m_spellModTakingSpell != NULL)
	{
		sLog->outMisc("Player::SetSpellModTakingSpell (A1) - %u, %u", spell->m_spellInfo->Id, m_spellModTakingSpell->m_spellInfo->Id);
		return;
		//ASSERT(m_spellModTakingSpell == NULL);
	}
	else if (!apply)
	{
		if (!m_spellModTakingSpell)
			sLog->outMisc("Player::SetSpellModTakingSpell (B1) - %u", spell->m_spellInfo->Id);
		else if (m_spellModTakingSpell != spell)
		{
			sLog->outMisc("Player::SetSpellModTakingSpell (C1) - %u, %u", spell->m_spellInfo->Id, m_spellModTakingSpell->m_spellInfo->Id);
			return;
		}
		//ASSERT(m_spellModTakingSpell && m_spellModTakingSpell == spell);
	}

	m_spellModTakingSpell = apply ? spell : NULL;
}

// send Proficiency
void Player::SendProficiency(ItemClass itemClass, uint32 itemSubclassMask)
{
	WorldPacket data(SMSG_SET_PROFICIENCY, 1 + 4);
	data << uint8(itemClass) << uint32(itemSubclassMask);
	GetSession()->SendPacket(&data);
}

void Player::RemovePetitionsAndSigns(uint64 guid, uint32 type)
{
	SignatureContainer* signatureStore = sPetitionMgr->GetSignatureStore();
	uint32 playerGuid = GUID_LOPART(guid);

	for (SignatureContainer::iterator itr = signatureStore->begin(); itr != signatureStore->end(); ++itr)
	{
		SignatureMap::iterator signItr = itr->second.signatureMap.find(playerGuid);
		if (signItr != itr->second.signatureMap.end())
		{
			Petition const* petition = sPetitionMgr->GetPetition(itr->first);
			if (!petition || (type != 10 && type != petition->petitionType))
				continue;

			// erase this
			itr->second.signatureMap.erase(signItr);

			uint64 ownerguid = MAKE_NEW_GUID(petition->ownerGuid, 0, HIGHGUID_PLAYER);
			uint64 petitionguid = MAKE_NEW_GUID(petition->petitionGuid, 0, HIGHGUID_ITEM);

			// send update if charter owner in game
			Player* owner = ObjectAccessor::FindPlayerInOrOutOfWorld(ownerguid);
			if (owner)
				owner->GetSession()->SendPetitionQueryOpcode(petitionguid);
		}
	}

	if (type == 10)
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ALL_PETITION_SIGNATURES);
		stmt->setUInt32(0, playerGuid);
		CharacterDatabase.Execute(stmt);
	}
	else
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE);
		stmt->setUInt32(0, playerGuid);
		stmt->setUInt8(1, uint8(type));
		CharacterDatabase.Execute(stmt);
	}

	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	if (type == 10)
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_BY_OWNER);
		stmt->setUInt32(0, playerGuid);
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER);
		stmt->setUInt32(0, playerGuid);
		trans->Append(stmt);

		// xinef: clear petition store
		sPetitionMgr->RemovePetitionByOwnerAndType(playerGuid, 0);
	}
	else
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_BY_OWNER_AND_TYPE);
		stmt->setUInt32(0, playerGuid);
		stmt->setUInt8(1, uint8(type));
		trans->Append(stmt);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER_AND_TYPE);
		stmt->setUInt32(0, playerGuid);
		stmt->setUInt8(1, uint8(type));
		trans->Append(stmt);

		// xinef: clear petition store
		sPetitionMgr->RemovePetitionByOwnerAndType(playerGuid, uint8(type));
	}
	CharacterDatabase.CommitTransaction(trans);
}

void Player::LeaveAllArenaTeams(uint64 guid)
{
	// xinef: zomg! sync query
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ARENA_TEAMS);
	stmt->setUInt32(0, GUID_LOPART(guid));
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result)
		return;

	do
	{
		Field* fields = result->Fetch();
		uint32 arenaTeamId = fields[0].GetUInt32();
		if (arenaTeamId != 0)
		{
			ArenaTeam* arenaTeam = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
			if (arenaTeam)
				arenaTeam->DelMember(guid, true);
		}
	} while (result->NextRow());
}

void Player::SetRestBonus(float rest_bonus_new)
{
	// Prevent resting on max level
	if (getLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
		rest_bonus_new = 0;

	if (rest_bonus_new < 0)
		rest_bonus_new = 0;

	float rest_bonus_max = (float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP)*1.5f / 2;

	if (rest_bonus_new > rest_bonus_max)
		_restBonus = rest_bonus_max;
	else
		_restBonus = rest_bonus_new;

	// update data for client
	if ((GetsRecruitAFriendBonus(true) && (GetSession()->IsARecruiter() || GetSession()->GetRecruiterId() != 0)))
		SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_RAF_LINKED);
	else
	{
		if (_restBonus > 10)
			SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_RESTED);
		else if (_restBonus <= 1)
			SetByteValue(PLAYER_BYTES_2, 3, REST_STATE_NOT_RAF_LINKED);
	}

	//RestTickUpdate
	SetUInt32Value(PLAYER_REST_STATE_EXPERIENCE, uint32(_restBonus));
}

bool Player::ActivateTaxiPathTo(std::vector<uint32> const& nodes, Creature* npc /*= NULL*/, uint32 spellid /*= 1*/)
{
	if (nodes.size() < 2)
		return false;

	// not let cheating with start flight in time of logout process || while in combat || has type state: stunned || has type state: root
	if (GetSession()->isLogingOut() || IsInCombat() || HasUnitState(UNIT_STATE_STUNNED) || HasUnitState(UNIT_STATE_ROOT))
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERBUSY);
		return false;
	}

	if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
		return false;

	// taximaster case
	if (npc)
	{
		// not let cheating with start flight mounted
		if (IsMounted())
		{
			GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERALREADYMOUNTED);
			return false;
		}

		if (IsInDisallowedMountForm())
		{
			GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERSHAPESHIFTED);
			return false;
		}

		// not let cheating with start flight in time of logout process || if casting not finished || while in combat || if not use Spell's with EffectSendTaxi
		if (IsNonMeleeSpellCast(false))
		{
			GetSession()->SendActivateTaxiReply(ERR_TAXIPLAYERBUSY);
			return false;
		}
	}
	// cast case or scripted call case
	else
	{
		RemoveAurasByType(SPELL_AURA_MOUNTED);

		if (IsInDisallowedMountForm())
			RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

		if (Spell* spell = GetCurrentSpell(CURRENT_GENERIC_SPELL))
			if (spell->m_spellInfo->Id != spellid)
				InterruptSpell(CURRENT_GENERIC_SPELL, false);

		InterruptSpell(CURRENT_AUTOREPEAT_SPELL, false);

		if (Spell* spell = GetCurrentSpell(CURRENT_CHANNELED_SPELL))
			if (spell->m_spellInfo->Id != spellid)
				InterruptSpell(CURRENT_CHANNELED_SPELL, true);
	}

	uint32 sourcenode = nodes[0];

	// starting node too far away (cheat?)
	TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(sourcenode);
	if (!node)
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXINOSUCHPATH);
		return false;
	}

	// check node starting pos data set case if provided
	if (node->x != 0.0f || node->y != 0.0f || node->z != 0.0f)
	{
		if (node->map_id != GetMapId() ||
			(node->x - GetPositionX())*(node->x - GetPositionX()) +
			(node->y - GetPositionY())*(node->y - GetPositionY()) +
			(node->z - GetPositionZ())*(node->z - GetPositionZ()) >
			(2 * INTERACTION_DISTANCE)*(2 * INTERACTION_DISTANCE)*(2 * INTERACTION_DISTANCE))
		{
			GetSession()->SendActivateTaxiReply(ERR_TAXITOOFARAWAY);
			return false;
		}
	}
	// node must have pos if taxi master case (npc != NULL)
	else if (npc)
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXIUNSPECIFIEDSERVERERROR);
		return false;
	}

	// Prepare to flight start now

	// stop combat at start taxi flight if any
	CombatStop();

	StopCastingCharm();
	StopCastingBindSight();
	ExitVehicle();

	// stop trade (client cancel trade at taxi map open but cheating tools can be used for reopen it)
	TradeCancel(true);

	// clean not finished taxi path if any
	m_taxi.ClearTaxiDestinations();

	// 0 element current node
	m_taxi.AddTaxiDestination(sourcenode);

	// fill destinations path tail
	uint32 sourcepath = 0;
	uint32 totalcost = 0;

	uint32 prevnode = sourcenode;
	uint32 lastnode = 0;

	for (uint32 i = 1; i < nodes.size(); ++i)
	{
		uint32 path, cost;

		lastnode = nodes[i];
		sObjectMgr->GetTaxiPath(prevnode, lastnode, path, cost);

		if (!path)
		{
			m_taxi.ClearTaxiDestinations();
			return false;
		}

		totalcost += cost;

		if (prevnode == sourcenode)
			sourcepath = path;

		m_taxi.AddTaxiDestination(lastnode);

		prevnode = lastnode;
	}

	// get mount model (in case non taximaster (npc == NULL) allow more wide lookup)
	//
	// Hack-Fix for Alliance not being able to use Acherus taxi. There is
	// only one mount ID for both sides. Probably not good to use 315 in case DBC nodes
	// change but I couldn't find a suitable alternative. OK to use class because only DK
	// can use this taxi.
	uint32 mount_display_id = sObjectMgr->GetTaxiMountDisplayId(sourcenode, GetTeamId(true), npc == NULL || (sourcenode == 315 && getClass() == CLASS_DEATH_KNIGHT));

	// in spell case allow 0 model
	if ((mount_display_id == 0 && spellid == 0) || sourcepath == 0)
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXIUNSPECIFIEDSERVERERROR);
		m_taxi.ClearTaxiDestinations();
		return false;
	}

	uint32 money = GetMoney();

	if (npc)
		totalcost = (uint32)ceil(totalcost*GetReputationPriceDiscount(npc));

	if (money < totalcost)
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXINOTENOUGHMONEY);
		m_taxi.ClearTaxiDestinations();
		return false;
	}

	//Checks and preparations done, DO FLIGHT
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_FLIGHT_PATHS_TAKEN, 1);
	ModifyMoney(-(int32)totalcost);
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TRAVELLING, totalcost);

	// prevent stealth flight
	//RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);

	// Xinef: dont use instant flight paths if spellid is present (custom calls use spellid = 1)
	if (sWorld->getBoolConfig(CONFIG_INSTANT_TAXI) && !spellid)
	{
		TaxiNodesEntry const* lastPathNode = sTaxiNodesStore.LookupEntry(nodes[nodes.size() - 1]);
		m_taxi.ClearTaxiDestinations();
		TeleportTo(lastPathNode->map_id, lastPathNode->x, lastPathNode->y, lastPathNode->z, GetOrientation());
		return false;
	}
	else
	{
		GetSession()->SendActivateTaxiReply(ERR_TAXIOK);
		GetSession()->SendDoFlight(mount_display_id, sourcepath);
	}
	return true;
}

bool Player::ActivateTaxiPathTo(uint32 taxi_path_id, uint32 spellid /*= 1*/)
{
	TaxiPathEntry const* entry = sTaxiPathStore.LookupEntry(taxi_path_id);
	if (!entry)
		return false;

	std::vector<uint32> nodes;

	nodes.resize(2);
	nodes[0] = entry->from;
	nodes[1] = entry->to;

	return ActivateTaxiPathTo(nodes, NULL, spellid);
}

void Player::CleanupAfterTaxiFlight()
{
	m_taxi.ClearTaxiDestinations();        // not destinations, clear source node
	Dismount();
	RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
	getHostileRefManager().setOnlineOfflineState(true);
}

void Player::ContinueTaxiFlight()
{
	uint32 sourceNode = m_taxi.GetTaxiSource();
	if (!sourceNode)
		return;

	;//sLog->outDebug(LOG_FILTER_UNITS, "WORLD: Restart character %u taxi flight", GetGUIDLow());

	uint32 mountDisplayId = sObjectMgr->GetTaxiMountDisplayId(sourceNode, GetTeamId(true), true);
	if (!mountDisplayId)
		return;

	uint32 path = m_taxi.GetCurrentTaxiPath();

	// search appropriate start path node
	uint32 startNode = 0;

	TaxiPathNodeList const& nodeList = sTaxiPathNodesByPath[path];

	float bestDist = SIZE_OF_GRIDS*SIZE_OF_GRIDS; // xinef: large value
	float currDist = 0.0f;

	// xinef: changed to -1, we dont want to catch last node
	for (uint32 i = 0; i < nodeList.size() - 1; ++i)
	{
		TaxiPathNodeEntry const* node = nodeList[i];
		TaxiPathNodeEntry const* nextNode = nodeList[i + 1];

		// xinef: skip nodes at another map, get last valid node on current map
		if (nextNode->mapid != GetMapId() || node->mapid != GetMapId())
			continue;

		currDist = (node->x - GetPositionX())*(node->x - GetPositionX()) + (node->y - GetPositionY())*(node->y - GetPositionY()) + (node->z - GetPositionZ())*(node->z - GetPositionZ());
		if (currDist < bestDist)
		{
			startNode = i;
			bestDist = currDist;
		}
	}

	// xinef: no proper node was found
	if (startNode == 0)
	{
		m_taxi.ClearTaxiDestinations();
		return;
	}

	GetSession()->SendDoFlight(mountDisplayId, path, startNode);
}

void Player::ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
	PacketCooldowns cooldowns;
	WorldPacket data;

	for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;
		uint32 unSpellId = itr->first;
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(unSpellId);
		if (!spellInfo)
		{
			ASSERT(spellInfo);
			continue;
		}

		// Not send cooldown for this spells
		if (spellInfo->IsCooldownStartedOnEvent())
			continue;

		if (spellInfo->PreventionType != SPELL_PREVENTION_TYPE_SILENCE)
			continue;

		if ((idSchoolMask & spellInfo->GetSchoolMask()) && GetSpellCooldownDelay(unSpellId) < unTimeMs)
		{
			cooldowns[unSpellId] = unTimeMs;
			AddSpellCooldown(unSpellId, 0, unTimeMs, true);
		}
	}

	if (!cooldowns.empty())
	{
		BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, cooldowns);
		GetSession()->SendPacket(&data);
	}
}

void Player::InitDataForForm(bool reapplyMods)
{
	ShapeshiftForm form = GetShapeshiftForm();

	SpellShapeshiftEntry const* ssEntry = sSpellShapeshiftStore.LookupEntry(form);
	if (ssEntry && ssEntry->attackSpeed)
	{
		SetAttackTime(BASE_ATTACK, ssEntry->attackSpeed);
		SetAttackTime(OFF_ATTACK, ssEntry->attackSpeed);
		SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);
	}
	else
		SetRegularAttackTime();

	switch (form)
	{
	case FORM_GHOUL:
	case FORM_CAT:
	{
		if (getPowerType() != POWER_ENERGY)
			setPowerType(POWER_ENERGY);
		break;
	}
	case FORM_BEAR:
	case FORM_DIREBEAR:
	{
		if (getPowerType() != POWER_RAGE)
			setPowerType(POWER_RAGE);
		break;
	}
	default:                                            // 0, for example
	{
		ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(getClass());
		if (cEntry && cEntry->powerType < MAX_POWERS && uint32(getPowerType()) != cEntry->powerType)
			setPowerType(Powers(cEntry->powerType));
		break;
	}
	}

	// update auras at form change, ignore this at mods reapply (.reset stats/etc) when form not change.
	if (!reapplyMods)
		UpdateEquipSpellsAtFormChange();

	UpdateAttackPowerAndDamage();
	UpdateAttackPowerAndDamage(true);
}

void Player::InitDisplayIds()
{
	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
	if (!info)
	{
		sLog->outError("Player %u has incorrect race/class pair. Can't init display ids.", GetGUIDLow());
		return;
	}

	uint8 gender = getGender();
	switch (gender)
	{
	case GENDER_FEMALE:
		SetDisplayId(info->displayId_f);
		SetNativeDisplayId(info->displayId_f);
		break;
	case GENDER_MALE:
		SetDisplayId(info->displayId_m);
		SetNativeDisplayId(info->displayId_m);
		break;
	default:
		sLog->outError("Invalid gender %u for player", gender);
		return;
	}
}

inline bool Player::_StoreOrEquipNewItem(uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot, int32 price, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
	ItemPosCountVec vDest;
	uint16 uiDest = 0;
	InventoryResult msg = bStore ?
		CanStoreNewItem(bag, slot, vDest, item, pProto->BuyCount * count) :
		CanEquipNewItem(slot, uiDest, item, false);
	if (msg != EQUIP_ERR_OK)
	{
		SendEquipError(msg, NULL, NULL, item);
		return false;
	}

	ModifyMoney(-price);

	if (crItem->ExtendedCost)                            // case for new honor system
	{
		ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
		if (iece->reqhonorpoints)
			ModifyHonorPoints(-int32(iece->reqhonorpoints * count));

		if (iece->reqarenapoints)
			ModifyArenaPoints(-int32(iece->reqarenapoints * count));

		for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
		{
			if (iece->reqitem[i])
				DestroyItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count), true);
		}
	}

	Item* it = bStore ?
		StoreNewItem(vDest, item, true) :
		EquipNewItem(uiDest, item, true);
	if (it)
	{
		uint32 new_count = pVendor->UpdateVendorItemCurrentCount(crItem, pProto->BuyCount * count);

		WorldPacket data(SMSG_BUY_ITEM, (8 + 4 + 4 + 4));
		data << uint64(pVendor->GetGUID());
		data << uint32(vendorslot + 1);                   // numbered from 1 at client
		data << int32(crItem->maxcount > 0 ? new_count : 0xFFFFFFFF);
		data << uint32(count);
		GetSession()->SendPacket(&data);
		SendNewItem(it, pProto->BuyCount * count, true, false, false);

		if (!bStore)
			AutoUnequipOffhandIfNeed();

		if (pProto->Flags & ITEM_PROTO_FLAG_REFUNDABLE && crItem->ExtendedCost && pProto->GetMaxStackSize() == 1)
		{
			it->SetFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE);
			it->SetRefundRecipient(GetGUIDLow());
			it->SetPaidMoney(price);
			it->SetPaidExtendedCost(crItem->ExtendedCost);
			it->SaveRefundDataToDB();
			AddRefundReference(it->GetGUIDLow());
		}
	}
	return true;
}

// Return true is the bought item has a max count to force refresh of window by caller
bool Player::BuyItemFromVendorSlot(uint64 vendorguid, uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot)
{
	// cheating attempt
	if (count < 1) count = 1;

	// cheating attempt
	if (slot > MAX_BAG_SIZE && slot != NULL_SLOT)
		return false;

	if (!IsAlive())
		return false;

	ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
	if (!pProto)
	{
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, NULL, item, 0);
		return false;
	}

	if (!(pProto->AllowableClass & getClassMask()) && pProto->Bonding == BIND_WHEN_PICKED_UP && !IsGameMaster())
	{
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, NULL, item, 0);
		return false;
	}

	if (!IsGameMaster() && ((pProto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY && GetTeamId(true) == TEAM_ALLIANCE) || (pProto->Flags2 == ITEM_FLAGS_EXTRA_ALLIANCE_ONLY && GetTeamId(true) == TEAM_HORDE)))
		return false;

	Creature* creature = GetNPCIfCanInteractWith(vendorguid, UNIT_NPC_FLAG_VENDOR);
	if (!creature)
	{
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: BuyItemFromVendor - Unit (GUID: %u) not found or you can't interact with him.", uint32(GUID_LOPART(vendorguid)));
		SendBuyError(BUY_ERR_DISTANCE_TOO_FAR, NULL, item, 0);
		return false;
	}

	ConditionList conditions = sConditionMgr->GetConditionsForNpcVendorEvent(creature->GetEntry(), item);
	if (!sConditionMgr->IsObjectMeetToConditions(this, creature, conditions))
	{
		//TC_LOG_DEBUG("condition", "BuyItemFromVendor: conditions not met for creature entry %u item %u", creature->GetEntry(), item);
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
		return false;
	}

	VendorItemData const* vItems = creature->GetVendorItems();
	if (!vItems || vItems->Empty())
	{
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
		return false;
	}

	if (vendorslot >= vItems->GetItemCount())
	{
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
		return false;
	}

	VendorItem const* crItem = vItems->GetItem(vendorslot);
	// store diff item (cheating)
	if (!crItem || crItem->item != item)
	{
		SendBuyError(BUY_ERR_CANT_FIND_ITEM, creature, item, 0);
		return false;
	}

	// check current item amount if it limited
	if (crItem->maxcount != 0)
	{
		if (creature->GetVendorItemCurrentCount(crItem) < pProto->BuyCount * count)
		{
			SendBuyError(BUY_ERR_ITEM_ALREADY_SOLD, creature, item, 0);
			return false;
		}
	}

	if (pProto->RequiredReputationFaction && (uint32(GetReputationRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank))
	{
		SendBuyError(BUY_ERR_REPUTATION_REQUIRE, creature, item, 0);
		return false;
	}

	if (crItem->ExtendedCost)
	{
		ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
		if (!iece)
		{
			sLog->outError("Item %u have wrong ExtendedCost field value %u", pProto->ItemId, crItem->ExtendedCost);
			return false;
		}

		// honor points price
		if (GetHonorPoints() < (iece->reqhonorpoints * count))
		{
			SendEquipError(EQUIP_ERR_NOT_ENOUGH_HONOR_POINTS, NULL, NULL);
			return false;
		}

		// arena points price
		if (GetArenaPoints() < (iece->reqarenapoints * count))
		{
			SendEquipError(EQUIP_ERR_NOT_ENOUGH_ARENA_POINTS, NULL, NULL);
			return false;
		}

		// item base price
		for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
		{
			if (iece->reqitem[i] && !HasItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count)))
			{
				SendEquipError(EQUIP_ERR_VENDOR_MISSING_TURNINS, NULL, NULL);
				return false;
			}
		}

		// check for personal arena rating requirement
		if (GetMaxPersonalArenaRatingRequirement(iece->reqarenaslot) < iece->reqpersonalarenarating)
		{
			// probably not the proper equip err
			SendEquipError(EQUIP_ERR_CANT_EQUIP_RANK, NULL, NULL);
			return false;
		}
	}

	uint32 price = 0;
	if (crItem->IsGoldRequired(pProto) && pProto->BuyPrice > 0) //Assume price cannot be negative (do not know why it is int32)
	{
		uint32 maxCount = MAX_MONEY_AMOUNT / pProto->BuyPrice;
		if ((uint32)count > maxCount)
		{
			sLog->outError("Player %s tried to buy %u item id %u, causing overflow", GetName().c_str(), (uint32)count, pProto->ItemId);
			count = (uint8)maxCount;
		}
		price = pProto->BuyPrice * count; //it should not exceed MAX_MONEY_AMOUNT

		// reputation discount
		price = uint32(floor(price * GetReputationPriceDiscount(creature)));

		if (!HasEnoughMoney(price))
		{
			SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, creature, item, 0);
			return false;
		}
	}

	if ((bag == NULL_BAG && slot == NULL_SLOT) || IsInventoryPos(bag, slot))
	{
		if (!_StoreOrEquipNewItem(vendorslot, item, count, bag, slot, price, pProto, creature, crItem, true))
			return false;
	}
	else if (IsEquipmentPos(bag, slot))
	{
		if (pProto->BuyCount * count != 1)
		{
			SendEquipError(EQUIP_ERR_ITEM_CANT_BE_EQUIPPED, NULL, NULL);
			return false;
		}
		if (!_StoreOrEquipNewItem(vendorslot, item, count, bag, slot, price, pProto, creature, crItem, false))
			return false;
	}
	else
	{
		SendEquipError(EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT, NULL, NULL);
		return false;
	}

	return crItem->maxcount != 0;
}

uint32 Player::GetMaxPersonalArenaRatingRequirement(uint32 minarenaslot) const
{
	// returns the maximal personal arena rating that can be used to purchase items requiring this condition
	// the personal rating of the arena team must match the required limit as well
	// so return max[in arenateams](min(personalrating[teamtype], teamrating[teamtype]))
	uint32 max_personal_rating = 0;
	for (uint8 i = minarenaslot; i < MAX_ARENA_SLOT; ++i)
	{
		if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamId(i)))
		{
			uint32 p_rating = GetArenaPersonalRating(i);
			uint32 t_rating = at->GetRating();
			p_rating = p_rating < t_rating ? p_rating : t_rating;
			if (max_personal_rating < p_rating)
				max_personal_rating = p_rating;
		}
	}
	return max_personal_rating;
}

void Player::UpdateHomebindTime(uint32 time)
{
	// GMs never get homebind timer online
	if (m_InstanceValid || IsGameMaster())
	{
		if (m_HomebindTimer)                                 // instance valid, but timer not reset
		{
			// hide reminder
			WorldPacket data(SMSG_RAID_GROUP_ONLY, 4 + 4);
			data << uint32(0);
			data << uint32(0);
			GetSession()->SendPacket(&data);
		}
		// instance is valid, reset homebind timer
		m_HomebindTimer = 0;
	}
	else if (m_HomebindTimer > 0)
	{
		if (time >= m_HomebindTimer)
		{
			// teleport to nearest graveyard
			RepopAtGraveyard();
		}
		else
			m_HomebindTimer -= time;
	}
	else
	{
		// instance is invalid, start homebind timer
		m_HomebindTimer = 60000;
		// send message to player
		WorldPacket data(SMSG_RAID_GROUP_ONLY, 4 + 4);
		data << uint32(m_HomebindTimer);
		data << uint32(1);
		GetSession()->SendPacket(&data);
		;//sLog->outDebug(LOG_FILTER_MAPS, "PLAYER: Player '%s' (GUID: %u) will be teleported to homebind in 60 seconds", GetName().c_str(), GetGUIDLow());
	}
}

void Player::UpdatePvPState(bool onlyFFA)
{
	// TODO: should we always synchronize UNIT_FIELD_BYTES_2, 1 of controller and controlled?
	// no, we shouldn't, those are checked for affecting player by client
	if (!pvpInfo.IsInNoPvPArea && !IsGameMaster()
		&& (pvpInfo.IsInFFAPvPArea || sWorld->IsFFAPvPRealm()))
	{
		if (!IsFFAPvP())
		{
			SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
			for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
				(*itr)->SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
		}
	}
	else if (IsFFAPvP())
	{
		RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
		for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
			(*itr)->RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
	}

	if (onlyFFA)
		return;

	if (pvpInfo.IsHostile)                               // in hostile area
	{
		if (!IsPvP() || pvpInfo.EndTimer != 0)
			UpdatePvP(true, true);
	}
	else                                                    // in friendly area
	{
		if (IsPvP() && !HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP) && pvpInfo.EndTimer == 0)
			pvpInfo.EndTimer = time(NULL);                     // start toggle-off
	}
}

void Player::UpdatePvP(bool state, bool _override)
{
	if (!state || _override)
	{
		SetPvP(state);
		pvpInfo.EndTimer = 0;
	}
	else
	{
		pvpInfo.EndTimer = time(NULL);
		SetPvP(state);
	}
	RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER);
}

void Player::AddSpellAndCategoryCooldowns(SpellInfo const* spellInfo, uint32 itemId, Spell* spell, bool infinityCooldown)
{
	// init cooldown values
	uint32 cat = 0;
	int32 rec = -1;
	int32 catrec = -1;

	// some special item spells without correct cooldown in SpellInfo
	// cooldown information stored in item prototype
	// This used in same way in WorldSession::HandleItemQuerySingleOpcode data sending to client.

	if (itemId)
	{
		if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId))
		{
			for (uint8 idx = 0; idx < MAX_ITEM_SPELLS; ++idx)
			{
				if (uint32(proto->Spells[idx].SpellId) == spellInfo->Id)
				{
					cat = proto->Spells[idx].SpellCategory;
					rec = proto->Spells[idx].SpellCooldown;
					catrec = proto->Spells[idx].SpellCategoryCooldown;
					break;
				}
			}
		}
	}

	// if no cooldown found above then base at DBC data
	if (rec < 0 && catrec < 0)
	{
		cat = spellInfo->GetCategory();
		rec = spellInfo->RecoveryTime;
		catrec = spellInfo->CategoryRecoveryTime;
	}

	time_t catrecTime;
	time_t recTime;

	bool needsCooldownPacket = false;

	// overwrite time for selected category
	if (infinityCooldown)
	{
		// use +MONTH as infinity mark for spell cooldown (will checked as MONTH/2 at save ans skipped)
		// but not allow ignore until reset or re-login
		catrecTime = catrec > 0 ? infinityCooldownDelay : 0;
		recTime = rec > 0 ? infinityCooldownDelay : catrecTime;
	}
	else
	{
		// shoot spells used equipped item cooldown values already assigned in GetAttackTime(RANGED_ATTACK)
		// prevent 0 cooldowns set by another way
		if (rec <= 0 && catrec <= 0 && (cat == 76 || (spellInfo->IsAutoRepeatRangedSpell() && spellInfo->Id != 75)))
			rec = GetAttackTime(RANGED_ATTACK);

		// Now we have cooldown data (if found any), time to apply mods
		if (rec > 0)
			ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, rec, spell);

		if (catrec > 0 && !spellInfo->HasAttribute(SPELL_ATTR6_IGNORE_CATEGORY_COOLDOWN_MODS))
			ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, catrec, spell);

		if (int32 cooldownMod = GetTotalAuraModifier(SPELL_AURA_MOD_COOLDOWN))
		{
			// Apply SPELL_AURA_MOD_COOLDOWN only to own spells
			if (HasSpell(spellInfo->Id))
			{
				needsCooldownPacket = true;
				rec += cooldownMod * IN_MILLISECONDS;   // SPELL_AURA_MOD_COOLDOWN does not affect category cooldows, verified with shaman shocks
			}
		}

		// replace negative cooldowns by 0
		if (rec < 0) rec = 0;
		if (catrec < 0) catrec = 0;

		// no cooldown after applying spell mods
		if (rec == 0 && catrec == 0)
			return;

		catrecTime = catrec ? catrec : 0;
		recTime = rec ? rec : catrecTime;
	}

	// self spell cooldown
	if (recTime > 0)
	{
		AddSpellCooldown(spellInfo->Id, itemId, recTime, true, true);

		if (needsCooldownPacket)
		{
			WorldPacket data;
			BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spellInfo->Id, rec);
			SendDirectMessage(&data);
		}
	}

	// category spells
	if (cat && catrec > 0)
	{
		SpellCategoryStore::const_iterator i_scstore = sSpellsByCategoryStore.find(cat);
		if (i_scstore != sSpellsByCategoryStore.end())
		{
			for (SpellCategorySet::const_iterator i_scset = i_scstore->second.begin(); i_scset != i_scstore->second.end(); ++i_scset)
			{
				if (*i_scset == spellInfo->Id)                    // skip main spell, already handled above
					continue;

				AddSpellCooldown(*i_scset, itemId, catrecTime, !spellInfo->IsCooldownStartedOnEvent() && spellInfo->CategoryRecoveryTime != spellInfo->RecoveryTime && spellInfo->RecoveryTime && spellInfo->CategoryRecoveryTime); // Xinef: send category cooldowns on login if category cooldown is different from base cooldown
			}
		}
	}
}

void Player::AddSpellCooldown(uint32 spellid, uint32 itemid, uint32 end_time, bool needSendToClient, bool forceSendToSpectator)
{
	SpellCooldown sc;
	sc.end = World::GetGameTimeMS() + end_time;
	sc.itemid = itemid;
	sc.maxduration = end_time;
	sc.sendToSpectator = false;
	sc.needSendToClient = needSendToClient;

	if (end_time >= SPECTATOR_COOLDOWN_MIN*IN_MILLISECONDS && end_time <= SPECTATOR_COOLDOWN_MAX*IN_MILLISECONDS)
		if (NeedSendSpectatorData() && forceSendToSpectator && (itemid || HasActiveSpell(spellid)))
		{
			sc.sendToSpectator = true;
			ArenaSpectator::SendCommand_Cooldown(FindMap(), GetGUID(), "ACD", spellid, end_time / IN_MILLISECONDS, end_time / IN_MILLISECONDS);
		}
	m_spellCooldowns[spellid] = sc;
}

void Player::ModifySpellCooldown(uint32 spellId, int32 cooldown)
{
	SpellCooldowns::iterator itr = m_spellCooldowns.find(spellId);
	if (itr == m_spellCooldowns.end())
		return;

	itr->second.end += cooldown;

	WorldPacket data(SMSG_MODIFY_COOLDOWN, 4 + 8 + 4);
	data << uint32(spellId);            // Spell ID
	data << uint64(GetGUID());          // Player GUID
	data << int32(cooldown);            // Cooldown mod in milliseconds
	GetSession()->SendPacket(&data);
}

void Player::SendCooldownEvent(SpellInfo const* spellInfo, uint32 itemId /*= 0*/, Spell* spell /*= NULL*/, bool setCooldown /*= true*/)
{
	// start cooldowns at server side, if any
	if (setCooldown)
		AddSpellAndCategoryCooldowns(spellInfo, itemId, spell);

	// Send activate cooldown timer (possible 0) at client side
	WorldPacket data(SMSG_COOLDOWN_EVENT, 4 + 8);
	data << uint32(spellInfo->Id);
	data << uint64(GetGUID());
	SendDirectMessage(&data);
}

void Player::UpdatePotionCooldown()
{
	// no potion used i combat or still in combat
	if (!GetLastPotionId() || IsInCombat())
		return;

	// spell/item pair let set proper cooldown (except not existed charged spell cooldown spellmods for potions)
	if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(GetLastPotionId()))
		for (uint8 idx = 0; idx < MAX_ITEM_SPELLS; ++idx)
			if (proto->Spells[idx].SpellId && proto->Spells[idx].SpellTrigger == ITEM_SPELLTRIGGER_ON_USE)
				if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(proto->Spells[idx].SpellId))
					SendCooldownEvent(spellInfo, GetLastPotionId());

	SetLastPotionId(0);
}

//slot to be excluded while counting
bool Player::EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot)
{
	if (!enchantmentcondition)
		return true;

	SpellItemEnchantmentConditionEntry const* Condition = sSpellItemEnchantmentConditionStore.LookupEntry(enchantmentcondition);

	if (!Condition)
		return true;

	uint8 curcount[4] = { 0, 0, 0, 0 };

	//counting current equipped gem colors
	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		if (i == slot)
			continue;
		Item* pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
		if (pItem2 && !pItem2->IsBroken() && pItem2->GetTemplate()->Socket[0].Color)
		{
			for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot <= PRISMATIC_ENCHANTMENT_SLOT; ++enchant_slot)
			{
				if (enchant_slot == BONUS_ENCHANTMENT_SLOT)
					continue;

				uint32 enchant_id = pItem2->GetEnchantmentId(EnchantmentSlot(enchant_slot));
				if (!enchant_id)
					continue;

				SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
				if (!enchantEntry)
					continue;

				uint32 gemid = enchantEntry->GemID;
				if (!gemid)
					continue;

				ItemTemplate const* gemProto = sObjectMgr->GetItemTemplate(gemid);
				if (!gemProto)
					continue;

				GemPropertiesEntry const* gemProperty = sGemPropertiesStore.LookupEntry(gemProto->GemProperties);
				if (!gemProperty)
					continue;

				uint8 GemColor = gemProperty->color;

				for (uint8 b = 0, tmpcolormask = 1; b < 4; b++, tmpcolormask <<= 1)
				{
					if (tmpcolormask & GemColor)
						++curcount[b];
				}
			}
		}
	}

	bool activate = true;

	for (uint8 i = 0; i < 5; i++)
	{
		if (!Condition->Color[i])
			continue;

		uint32 _cur_gem = curcount[Condition->Color[i] - 1];

		// if have <CompareColor> use them as count, else use <value> from Condition
		uint32 _cmp_gem = Condition->CompareColor[i] ? curcount[Condition->CompareColor[i] - 1] : Condition->Value[i];

		switch (Condition->Comparator[i])
		{
		case 2:                                         // requires less <color> than (<value> || <comparecolor>) gems
			activate &= (_cur_gem < _cmp_gem) ? true : false;
			break;
		case 3:                                         // requires more <color> than (<value> || <comparecolor>) gems
			activate &= (_cur_gem > _cmp_gem) ? true : false;
			break;
		case 5:                                         // requires at least <color> than (<value> || <comparecolor>) gems
			activate &= (_cur_gem >= _cmp_gem) ? true : false;
			break;
		}
	}

	;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Checking Condition %u, there are %u Meta Gems, %u Red Gems, %u Yellow Gems and %u Blue Gems, Activate:%s", enchantmentcondition, curcount[0], curcount[1], curcount[2], curcount[3], activate ? "yes" : "no");

	return activate;
}

void Player::CorrectMetaGemEnchants(uint8 exceptslot, bool apply)
{
	//cycle all equipped items
	for (uint32 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
	{
		//enchants for the slot being socketed are handled by Player::ApplyItemMods
		if (slot == exceptslot)
			continue;

		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

		if (!pItem || !pItem->GetTemplate()->Socket[0].Color)
			continue;

		for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
		{
			uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
			if (!enchant_id)
				continue;

			SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
			if (!enchantEntry)
				continue;

			uint32 condition = enchantEntry->EnchantmentCondition;
			if (condition)
			{
				//was enchant active with/without item?
				bool wasactive = EnchantmentFitsRequirements(condition, apply ? exceptslot : -1);
				//should it now be?
				if (wasactive ^ EnchantmentFitsRequirements(condition, apply ? -1 : exceptslot))
				{
					// ignore item gem conditions
															//if state changed, (dis)apply enchant
					ApplyEnchantment(pItem, EnchantmentSlot(enchant_slot), !wasactive, true, true);
				}
			}
		}
	}
}

//if false -> then toggled off if was on| if true -> toggled on if was off AND meets requirements
void Player::ToggleMetaGemsActive(uint8 exceptslot, bool apply)
{
	//cycle all equipped items
	for (int slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
	{
		//enchants for the slot being socketed are handled by WorldSession::HandleSocketOpcode(WorldPacket& recvData)
		if (slot == exceptslot)
			continue;

		Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

		if (!pItem || !pItem->GetTemplate()->Socket[0].Color)   //if item has no sockets or no item is equipped go to next item
			continue;

		//cycle all (gem)enchants
		for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
		{
			uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
			if (!enchant_id)                                 //if no enchant go to next enchant(slot)
				continue;

			SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
			if (!enchantEntry)
				continue;

			//only metagems to be (de)activated, so only enchants with condition
			uint32 condition = enchantEntry->EnchantmentCondition;
			if (condition)
				ApplyEnchantment(pItem, EnchantmentSlot(enchant_slot), apply);
		}
	}
}

void Player::SetEntryPoint()
{
	m_entryPointData.joinPos.m_mapId = MAPID_INVALID;
	m_entryPointData.ClearTaxiPath();

	if (!m_taxi.empty())
	{
		m_entryPointData.mountSpell = 0;
		m_entryPointData.joinPos = WorldLocation(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());

		std::vector<uint32> const& taxi = m_taxi.GetPath();
		for (std::vector<uint32>::const_iterator itr = taxi.begin(); itr != taxi.end(); ++itr)
			m_entryPointData.taxiPath.push_back(*itr);

		m_entryPointData.taxiPath.push_back(m_taxi.GetTaxiSegment());
	}
	else
	{
		if (IsMounted())
		{
			AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_MOUNTED);
			if (!auras.empty())
				m_entryPointData.mountSpell = (*auras.begin())->GetId();
		}
		else
			m_entryPointData.mountSpell = 0;

		if (GetMap()->IsDungeon())
		{
			if (const WorldSafeLocsEntry* entry = sObjectMgr->GetClosestGraveyard(GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId(), GetTeamId()))
				m_entryPointData.joinPos = WorldLocation(entry->map_id, entry->x, entry->y, entry->z, 0.0f);
		}
		else if (!GetMap()->IsBattlegroundOrArena())
			m_entryPointData.joinPos = WorldLocation(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
	}

	if (m_entryPointData.joinPos.m_mapId == MAPID_INVALID)
		m_entryPointData.joinPos = WorldLocation(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, 0.0f);
}

void Player::LeaveBattleground(Battleground* bg)
{
	if (!bg)
		bg = GetBattleground();

	if (!bg)
		return;

	// Deserter tracker - leave BG
	if (bg->isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS)
		&& (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt8(1, BG_DESERTION_TYPE_LEAVE_BG);
		CharacterDatabase.Execute(stmt);
	}

	// xinef: reset corpse reclaim time
	m_deathExpireTime = time(NULL);

	// pussywizard: clear movement, because after porting player will move to arena cords
	GetMotionMaster()->MovementExpired();
	StopMoving();
	TeleportToEntryPoint();
}

bool Player::CanJoinToBattleground() const
{
	// check Deserter debuff
	if (HasAura(26013))
		return false;

	return true;
}

bool Player::CanReportAfkDueToLimit()
{
	// a player can complain about 15 people per 5 minutes
	if (m_bgData.bgAfkReportedCount++ >= 15)
		return false;

	return true;
}

///This player has been blamed to be inactive in a battleground
void Player::ReportedAfkBy(Player* reporter)
{
	Battleground* bg = GetBattleground();
	// Battleground also must be in progress!
	if (!bg || bg != reporter->GetBattleground() || GetTeamId() != reporter->GetTeamId() || bg->GetStatus() != STATUS_IN_PROGRESS)
		return;

	// Xinef: 2 minutes startup + 2 minute of match
	if (bg->GetStartTime() < 4 * MINUTE*IN_MILLISECONDS)
		return;

	// check if player has 'Idle' or 'Inactive' debuff
	if (m_bgData.bgAfkReporter.find(reporter->GetGUIDLow()) == m_bgData.bgAfkReporter.end() && !HasAura(43680) && !HasAura(43681) && reporter->CanReportAfkDueToLimit())
	{
		m_bgData.bgAfkReporter.insert(reporter->GetGUIDLow());
		// 3 players have to complain to apply debuff
		if (m_bgData.bgAfkReporter.size() >= 3)
		{
			// cast 'Idle' spell
			CastSpell(this, 43680, true);
			m_bgData.bgAfkReporter.clear();
		}
	}
}

WorldLocation Player::GetStartPosition() const
{
	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
	uint32 mapId = info->mapId;
	if (getClass() == CLASS_DEATH_KNIGHT && HasSpell(50977))
		return WorldLocation(0, 2352.0f, -5709.0f, 154.5f, 0.0f);
	return WorldLocation(mapId, info->positionX, info->positionY, info->positionZ, 0);
}

bool Player::IsNeverVisible() const
{
	if (Unit::IsNeverVisible())
		return true;

	if (GetSession()->PlayerLogout() || GetSession()->PlayerLoading())
		return true;

	return false;
}

bool Player::CanAlwaysSee(WorldObject const* obj) const
{
	// Always can see self
	if (m_mover == obj)
		return true;

	if (uint64 guid = GetUInt64Value(PLAYER_FARSIGHT))
		if (obj->GetGUID() == guid)
			return true;

	return false;
}

bool Player::IsAlwaysDetectableFor(WorldObject const* seer) const
{
	if (Unit::IsAlwaysDetectableFor(seer))
		return true;

	if (const Player* seerPlayer = seer->ToPlayer())
		if (IsGroupVisibleFor(seerPlayer))
			return !(seerPlayer->duel && seerPlayer->duel->startTime != 0 && seerPlayer->duel->opponent == this);

	return false;
}

bool Player::IsVisibleGloballyFor(Player const* u) const
{
	if (!u)
		return false;

	// Always can see self
	if (u == this)
		return true;

	// Visible units, always are visible for all players
	if (IsVisible())
		return true;

	// GMs are visible for higher gms (or players are visible for gms)
	if (!AccountMgr::IsPlayerAccount(u->GetSession()->GetSecurity()))
		return GetSession()->GetSecurity() <= u->GetSession()->GetSecurity();

	// non faction visibility non-breakable for non-GMs
	return false;
}

template<class T>
inline void UpdateVisibilityOf_helper(T* target, std::vector<Unit*>& /*v*/)
{
}

template<>
inline void UpdateVisibilityOf_helper(Creature* target, std::vector<Unit*>& v)
{
	v.push_back(target);
}

template<>
inline void UpdateVisibilityOf_helper(Player* target, std::vector<Unit*>& v)
{
	v.push_back(target);
}

template<class T>
inline void BeforeVisibilityDestroy(T* /*t*/, Player* /*p*/)
{
}

template<>
inline void BeforeVisibilityDestroy<Creature>(Creature* t, Player* p)
{
	if (p->GetPetGUID() == t->GetGUID() && t->IsPet())
		((Pet*)t)->Remove(PET_SAVE_NOT_IN_SLOT, true);
}

void Player::UpdateVisibilityOf(WorldObject* target)
{
	if (HaveAtClient(target))
	{
		if (!CanSeeOrDetect(target, false, true))
		{
			if (target->GetTypeId() == TYPEID_UNIT)
				BeforeVisibilityDestroy<Creature>(target->ToCreature(), this);

			target->DestroyForPlayer(this);
			m_clientGUIDs.erase(target->GetGUID());
		}
	}
	else
	{
		if (CanSeeOrDetect(target, false, true))
		{
			target->SendUpdateToPlayer(this);
			m_clientGUIDs.insert(target->GetGUID());

			// target aura duration for caster show only if target exist at caster client
			// send data at target visibility change (adding to client)
			if (target->isType(TYPEMASK_UNIT))
				GetInitialVisiblePackets((Unit*)target);
		}
	}
}

void Player::UpdateTriggerVisibility()
{
	if (m_clientGUIDs.empty())
		return;

	if (!IsInWorld())
		return;

	UpdateData udata;
	WorldPacket packet;
	for (ClientGUIDs::iterator itr = m_clientGUIDs.begin(); itr != m_clientGUIDs.end(); ++itr)
	{
		if (IS_VEHICLE_GUID(*itr) || IS_CREATURE_GUID(*itr))
		{
			Creature* creature = GetMap()->GetCreature(*itr);
			// Update fields of triggers, transformed units or unselectable units (values dependent on GM state)
			if (!creature || (!creature->IsTrigger() && !creature->HasAuraType(SPELL_AURA_TRANSFORM) && !creature->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)))
				continue;

			creature->SetFieldNotifyFlag(UF_FLAG_PUBLIC);
			creature->BuildValuesUpdateBlockForPlayer(&udata, this);
			creature->RemoveFieldNotifyFlag(UF_FLAG_PUBLIC);
		}
		else if (IS_GAMEOBJECT_GUID((*itr)))
		{
			GameObject* go = GetMap()->GetGameObject(*itr);
			if (!go)
				continue;

			go->SetFieldNotifyFlag(UF_FLAG_PUBLIC);
			go->BuildValuesUpdateBlockForPlayer(&udata, this);
			go->RemoveFieldNotifyFlag(UF_FLAG_PUBLIC);
		}
	}

	if (!udata.HasData())
		return;

	udata.BuildPacket(&packet);
	GetSession()->SendPacket(&packet);
}

void Player::GetInitialVisiblePackets(Unit* target)
{
	GetAurasForTarget(target);
	if (target->IsAlive())
	{
		if (target->HasUnitState(UNIT_STATE_MELEE_ATTACKING) && target->GetVictim())
			target->SendMeleeAttackStart(target->GetVictim(), this);
	}
}

template<class T>
void Player::UpdateVisibilityOf(T* target, UpdateData& data, std::vector<Unit*>& visibleNow)
{
	if (HaveAtClient(target))
	{
		if (!CanSeeOrDetect(target, false, true))
		{
			BeforeVisibilityDestroy<T>(target, this);

			target->BuildOutOfRangeUpdateBlock(&data);
			m_clientGUIDs.erase(target->GetGUID());
		}
	}
	else
	{
		if (CanSeeOrDetect(target, false, true))
		{
			target->BuildCreateUpdateBlockForPlayer(&data, this);
			m_clientGUIDs.insert(target->GetGUID());

			UpdateVisibilityOf_helper(target, visibleNow);
		}
	}
}

template void Player::UpdateVisibilityOf(Player*        target, UpdateData& data, std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(Creature*      target, UpdateData& data, std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(Corpse*        target, UpdateData& data, std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(GameObject*    target, UpdateData& data, std::vector<Unit*>& visibleNow);
template void Player::UpdateVisibilityOf(DynamicObject* target, UpdateData& data, std::vector<Unit*>& visibleNow);

void Player::UpdateObjectVisibility(bool forced, bool fromUpdate)
{
	if (!forced)
		AddToNotify(NOTIFY_VISIBILITY_CHANGED);
	else if (!isBeingLoaded())
	{
		if (!fromUpdate) // pussywizard:
		{
			bRequestForcedVisibilityUpdate = true;
			return;
		}
		Unit::UpdateObjectVisibility(true);
		UpdateVisibilityForPlayer();
	}
}

void Player::UpdateVisibilityForPlayer(bool mapChange)
{
	Trinity::VisibleNotifier notifier(*this, mapChange);
	m_seer->VisitNearbyObject(GetSightRange() + VISIBILITY_INC_FOR_GOBJECTS, notifier);
	notifier.SendToSelf();

	if (mapChange)
		m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);
}

void Player::InitPrimaryProfessions()
{
	SetFreePrimaryProfessions(sWorld->getIntConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL));
}

bool Player::ModifyMoney(int32 amount, bool sendError /*= true*/)
{
	if (!amount)
		return true;

	sScriptMgr->OnPlayerMoneyChanged(this, amount);

	if (amount < 0)
		SetMoney(GetMoney() > uint32(-amount) ? GetMoney() + amount : 0);
	else
	{
		if (GetMoney() < uint32(MAX_MONEY_AMOUNT - amount))
			SetMoney(GetMoney() + amount);
		else
		{
			if (sendError)
				SendEquipError(EQUIP_ERR_TOO_MUCH_GOLD, NULL, NULL);
			return false;
		}
	}

	return true;
}

Unit* Player::GetSelectedUnit() const
{
	if (uint64 selectionGUID = GetUInt64Value(UNIT_FIELD_TARGET))
		return ObjectAccessor::GetUnit(*this, selectionGUID);
	return NULL;
}

Player* Player::GetSelectedPlayer() const
{
	if (uint64 selectionGUID = GetUInt64Value(UNIT_FIELD_TARGET))
		return ObjectAccessor::GetPlayer(*this, selectionGUID);
	return NULL;
}

void Player::SetSelection(uint64 guid)
{
	SetUInt64Value(UNIT_FIELD_TARGET, guid);

	if (NeedSendSpectatorData())
		ArenaSpectator::SendCommand_GUID(FindMap(), GetGUID(), "TRG", guid);
}

void Player::SendComboPoints()
{
	Unit* combotarget = ObjectAccessor::GetUnit(*this, m_comboTarget);
	if (combotarget)
	{
		WorldPacket data;
		if (m_mover != this)
		{
			data.Initialize(SMSG_PET_UPDATE_COMBO_POINTS, m_mover->GetPackGUID().size() + combotarget->GetPackGUID().size() + 1);
			data.append(m_mover->GetPackGUID());
		}
		else
			data.Initialize(SMSG_UPDATE_COMBO_POINTS, combotarget->GetPackGUID().size() + 1);
		data.append(combotarget->GetPackGUID());
		data << uint8(m_comboPoints);
		GetSession()->SendPacket(&data);
	}
}

void Player::AddComboPoints(Unit* target, int8 count)
{
	if (!count)
		return;

	int8 * comboPoints = &m_comboPoints;

	// without combo points lost (duration checked in aura)
	RemoveAurasByType(SPELL_AURA_RETAIN_COMBO_POINTS);

	if (target->GetGUID() == m_comboTarget)
		*comboPoints += count;
	else
	{
		if (m_comboTarget)
			if (Unit* target2 = ObjectAccessor::GetUnit(*this, m_comboTarget))
				target2->RemoveComboPointHolder(GetGUIDLow());

		m_comboTarget = target->GetGUID();
		*comboPoints = count;

		target->AddComboPointHolder(GetGUIDLow());
	}

	if (*comboPoints > 5)
		*comboPoints = 5;
	else if (*comboPoints < 0)
		*comboPoints = 0;


	SendComboPoints();
}

void Player::ClearComboPoints()
{
	if (!m_comboTarget)
		return;

	// without combopoints lost (duration checked in aura)
	RemoveAurasByType(SPELL_AURA_RETAIN_COMBO_POINTS);

	m_comboPoints = 0;

	SendComboPoints();

	if (Unit* target = ObjectAccessor::GetUnit(*this, m_comboTarget))
		target->RemoveComboPointHolder(GetGUIDLow());

	m_comboTarget = 0;
}

void Player::SetGroup(Group* group, int8 subgroup)
{
	if (group == NULL)
		m_group.unlink();
	else
	{
		// never use SetGroup without a subgroup unless you specify NULL for group
		ASSERT(subgroup >= 0);
		m_group.link(group, this);
		m_group.setSubGroup((uint8)subgroup);
	}

	UpdateObjectVisibility(false);
}

void Player::SendInitialPacketsBeforeAddToMap()
{
	/// Pass 'this' as argument because we're not stored in ObjectAccessor yet
	GetSocial()->SendSocialList(this);

	// guild bank list wtf?

	// Homebind
	WorldPacket data(SMSG_BINDPOINTUPDATE, 5 * 4);
	data << m_homebindX << m_homebindY << m_homebindZ;
	data << (uint32)m_homebindMapId;
	data << (uint32)m_homebindAreaId;
	GetSession()->SendPacket(&data);

	// SMSG_SET_PROFICIENCY
	// SMSG_SET_PCT_SPELL_MODIFIER
	// SMSG_SET_FLAT_SPELL_MODIFIER
	// SMSG_UPDATE_AURA_DURATION

	SendTalentsInfoData(false);

	// SMSG_INSTANCE_DIFFICULTY
	data.Initialize(SMSG_INSTANCE_DIFFICULTY, 4 + 4);
	data << uint32(GetMap()->GetDifficulty());
	data << uint32(GetMap()->GetEntry()->IsDynamicDifficultyMap() && GetMap()->IsHeroic()); // Raid dynamic difficulty
	GetSession()->SendPacket(&data);

	SendInitialSpells();

	data.Initialize(SMSG_SEND_UNLEARN_SPELLS, 4);
	data << uint32(0);                                      // count, for (count) uint32;
	GetSession()->SendPacket(&data);

	SendInitialActionButtons();
	m_reputationMgr->SendInitialReputations();
	m_achievementMgr->SendAllAchievementData();

	SendEquipmentSetList();

	data.Initialize(SMSG_LOGIN_SETTIMESPEED, 4 + 4 + 4);
	data.AppendPackedTime(sWorld->GetGameTime());
	data << float(0.01666667f);                             // game speed
	data << uint32(0);                                      // added in 3.1.2
	GetSession()->SendPacket(&data);

	GetReputationMgr().SendForceReactions();                // SMSG_SET_FORCED_REACTIONS

	// SMSG_TALENTS_INFO x 2 for pet (unspent points and talents in separate packets...)
	// SMSG_PET_GUIDS
	// SMSG_UPDATE_WORLD_STATE
	// SMSG_POWER_UPDATE

	SetMover(this);
}

void Player::SendInitialPacketsAfterAddToMap()
{
	UpdateVisibilityForPlayer(true);

	ResetTimeSync();
	SendTimeSync();

	CastSpell(this, 836, true);                             // LOGINEFFECT

	// set some aura effects that send packet to player client after add player to map
	// SendMessageToSet not send it to player not it map, only for aura that not changed anything at re-apply
	// same auras state lost at far teleport, send it one more time in this case also
	static const AuraType auratypes[] =
	{
		SPELL_AURA_MOD_FEAR,     SPELL_AURA_TRANSFORM,                 SPELL_AURA_WATER_WALK,
		SPELL_AURA_FEATHER_FALL, SPELL_AURA_HOVER,                     SPELL_AURA_SAFE_FALL,
		SPELL_AURA_FLY,          SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED, SPELL_AURA_NONE
	};
	for (AuraType const* itr = &auratypes[0]; itr && itr[0] != SPELL_AURA_NONE; ++itr)
	{
		Unit::AuraEffectList const& auraList = GetAuraEffectsByType(*itr);
		if (!auraList.empty())
			auraList.front()->HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true);
	}

	// Fix mount shit... to tired to think, update block gets messed somewhere
	{
		if (!isBeingLoaded() && GetMountBlockId() && !HasAuraType(SPELL_AURA_MOUNTED))
		{
			AddAura(GetMountBlockId(), this);
			SetMountBlockId(0);
		}
	}

	// update zone
	uint32 newzone, newarea;
	GetZoneAndAreaId(newzone, newarea, true);
	UpdateZone(newzone, newarea);                            // also call SendInitWorldStates();

	if (HasAuraType(SPELL_AURA_MOD_STUN))
		SetMovement(MOVE_ROOT);

	// manual send package (have code in HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true); that must not be re-applied.
	if (HasAuraType(SPELL_AURA_MOD_ROOT))
	{
		WorldPacket data2(SMSG_FORCE_MOVE_ROOT, 10);
		data2.append(GetPackGUID());
		data2 << (uint32)2;
		SendMessageToSet(&data2, true);
	}

	GetAurasForTarget(this);
	SendEnchantmentDurations();                             // must be after add to map
	SendItemDurations();                                    // must be after add to map

	// raid downscaling - send difficulty to player
	if (GetMap()->IsRaid())
	{
		if (GetMap()->GetDifficulty() != GetRaidDifficulty())
		{
			StoreRaidMapDifficulty();
			SendRaidDifficulty(GetGroup() != NULL, GetStoredRaidDifficulty());
		}
	}
	else if (GetRaidDifficulty() != GetStoredRaidDifficulty())
		SendRaidDifficulty(GetGroup() != NULL);
}

void Player::SendUpdateToOutOfRangeGroupMembers()
{
	if (m_groupUpdateMask == GROUP_UPDATE_FLAG_NONE)
		return;
	if (Group* group = GetGroup())
		group->UpdatePlayerOutOfRange(this);

	m_groupUpdateMask = GROUP_UPDATE_FLAG_NONE;
	m_auraRaidUpdateMask = 0;
	if (Pet* pet = GetPet())
		pet->ResetAuraUpdateMaskForRaid();
}

void Player::SendTransferAborted(uint32 mapid, TransferAbortReason reason, uint8 arg)
{
	WorldPacket data(SMSG_TRANSFER_ABORTED, 4 + 2);
	data << uint32(mapid);
	data << uint8(reason);                                 // transfer abort reason
	switch (reason)
	{
	case TRANSFER_ABORT_INSUF_EXPAN_LVL:
	case TRANSFER_ABORT_DIFFICULTY:
	case TRANSFER_ABORT_UNIQUE_MESSAGE:
		// these are the ONLY cases that have an extra argument in the packet!!!
		data << uint8(arg);
		break;
	default:
		break;
	}
	GetSession()->SendPacket(&data);
}

void Player::SendInstanceResetWarning(uint32 mapid, Difficulty difficulty, uint32 time, bool onEnterMap)
{
	// pussywizard:
	InstancePlayerBind* bind = sInstanceSaveMgr->PlayerGetBoundInstance(GetGUIDLow(), mapid, difficulty);
	if (bind && bind->extended)
	{
		if (!onEnterMap) // extended id player shouldn't be warned about lock expiration
			return;
		time += (bind->save->GetExtendedResetTime() - bind->save->GetResetTime()); // add lockout period to the time left
	}

	// type of warning, based on the time remaining until reset
	uint32 type;
	if (time > 3600)
		type = RAID_INSTANCE_WELCOME;
	else if (time > 900)
		type = RAID_INSTANCE_WARNING_HOURS;
	else if (time > 300)
		type = RAID_INSTANCE_WARNING_MIN;
	else
		type = RAID_INSTANCE_WARNING_MIN_SOON;

	WorldPacket data(SMSG_RAID_INSTANCE_MESSAGE, 4 + 4 + 4 + 4);
	data << uint32(type);
	data << uint32(mapid);
	data << uint32(difficulty);                             // difficulty
	data << uint32(time);
	if (type == RAID_INSTANCE_WELCOME)
	{
		data << uint8(bind && bind->perm);                  // is locked
		data << uint8(bind && bind->extended);              // is extended, ignored if prev field is 0
	}
	GetSession()->SendPacket(&data);
}

void Player::ApplyEquipCooldown(Item* pItem)
{
	if (pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_PROTO_FLAG_NO_EQUIP_COOLDOWN))
		return;

	for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
	{
		_Spell const& spellData = pItem->GetTemplate()->Spells[i];

		// no spell
		if (!spellData.SpellId)
			continue;

		// xinef: apply hidden cooldown for procs
		if (spellData.SpellTrigger == ITEM_SPELLTRIGGER_ON_EQUIP)
		{
			// xinef: uint32(-1) special marker for proc cooldowns
			AddSpellCooldown(spellData.SpellId, uint32(-1), 30 * IN_MILLISECONDS);
			continue;
		}

		// wrong triggering type (note: ITEM_SPELLTRIGGER_ON_NO_DELAY_USE not have cooldown)
		if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
			continue;

		// xinef: dont apply equip cooldown if spell on item has insignificant cooldown
		SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellData.SpellId);
		if (spellData.SpellCooldown <= 3000 && spellData.SpellCategoryCooldown <= 3000 && (!spellInfo || spellInfo->RecoveryTime <= 3000 && spellInfo->CategoryRecoveryTime <= 3000))
			continue;

		// Don't replace longer cooldowns by equip cooldown if we have any.
		SpellCooldowns::iterator itr = m_spellCooldowns.find(spellData.SpellId);
		if (itr != m_spellCooldowns.end() && itr->second.itemid == pItem->GetEntry() && itr->second.end > time(NULL) + 30)
			continue;

		// xinef: dont apply eqiup cooldown for spells with this attribute
		if (spellInfo && spellInfo->HasAttribute(SPELL_ATTR0_CANT_USED_IN_COMBAT))
			continue;

		AddSpellCooldown(spellData.SpellId, pItem->GetEntry(), 30 * IN_MILLISECONDS, true, true);

		WorldPacket data(SMSG_ITEM_COOLDOWN, 12);
		data << pItem->GetGUID();
		data << uint32(spellData.SpellId);
		GetSession()->SendPacket(&data);
	}
}

void Player::resetSpells()
{
	// not need after this call
	if (HasAtLoginFlag(AT_LOGIN_RESET_SPELLS))
		RemoveAtLoginFlag(AT_LOGIN_RESET_SPELLS, true);

	// make full copy of map (spells removed and marked as deleted at another spell remove
	// and we can't use original map for safe iterative with visit each spell at loop end
	PlayerSpellMap spellMap = GetSpellMap();

	for (PlayerSpellMap::const_iterator iter = spellMap.begin(); iter != spellMap.end(); ++iter)
		removeSpell(iter->first, SPEC_MASK_ALL, false);

	learnDefaultSpells();
	learnQuestRewardedSpells();
}

void Player::learnDefaultSpells()
{
	// xinef: learn default race/class spells
	PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
	for (PlayerCreateInfoSpells::const_iterator itr = info->spell.begin(); itr != info->spell.end(); ++itr)
		_addSpell(*itr, SPEC_MASK_ALL, true);
}

void Player::learnQuestRewardedSpells(Quest const* quest)
{
	// xinef: quest does not learn anything
	int32 spellId = quest->GetRewSpellCast();
	if (!spellId)
		return;

	SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	if (!spellInfo)
		return;

	// xinef: find effect with learn spell and check if we have this spell
	bool found = false;
	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
		if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL && spellInfo->Effects[i].TriggerSpell && !HasSpell(spellInfo->Effects[i].TriggerSpell))
		{
			// pusywizard: don't re-add profession specialties!
			if (SpellInfo const* triggeredInfo = sSpellMgr->GetSpellInfo(spellInfo->Effects[i].TriggerSpell))
				if (triggeredInfo->Effects[0].Effect == SPELL_EFFECT_TRADE_SKILL)
					break; // pussywizard: break and not cast the spell (found is false)

			found = true;
			break;
		}

	// xinef: we know the spell, return
	if (!found)
		return;

	CastSpell(this, spellId, true);
}

void Player::learnQuestRewardedSpells()
{
	// learn spells received from quest completing
	for (RewardedQuestSet::const_iterator itr = m_RewardedQuests.begin(); itr != m_RewardedQuests.end(); ++itr)
	{
		Quest const* quest = sObjectMgr->GetQuestTemplate(*itr);
		if (!quest)
			continue;

		learnQuestRewardedSpells(quest);
	}
}

void Player::learnSkillRewardedSpells(uint32 skill_id, uint32 skill_value)
{
	uint32 raceMask = getRaceMask();
	uint32 classMask = getClassMask();
	for (uint32 j = 0; j < sSkillLineAbilityStore.GetNumRows(); ++j)
	{
		SkillLineAbilityEntry const* pAbility = sSkillLineAbilityStore.LookupEntry(j);
		if (!pAbility || pAbility->skillId != skill_id || pAbility->learnOnGetSkill != ABILITY_LEARNED_ON_GET_PROFESSION_SKILL)
			continue;
		// Check race if set
		if (pAbility->racemask && !(pAbility->racemask & raceMask))
			continue;
		// Check class if set
		if (pAbility->classmask && !(pAbility->classmask & classMask))
			continue;

		if (sSpellMgr->GetSpellInfo(pAbility->spellId))
		{
			// need unlearn spell
			if (skill_value < pAbility->req_skill_value)
				removeSpell(pAbility->spellId, SPEC_MASK_ALL, true);
			// need learn
			else
			{
				// Xinef: there is next spell and we have enough skill value to obtain it - skip current spell
				if (pAbility->req_skill_value > 1 && pAbility->forward_spellid)
				{
					bool hasForwardSpell = false;
					SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(pAbility->forward_spellid);
					for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
						if (skill_value >= _spell_idx->second->req_skill_value)
						{
							hasForwardSpell = true;
							break;
						}
					if (hasForwardSpell)
						continue;
				}

				addSpell(pAbility->spellId, SPEC_MASK_ALL, true, true);
			}
		}
	}
}

void Player::GetAurasForTarget(Unit* target) // pussywizard: contact before changing ANYTHING!
{
	if (!target/* || target->GetVisibleAuras()->empty()*/)                  // speedup things
		return;

	/*! Blizz sends certain movement packets sometimes even before CreateObject
		These movement packets are usually found in SMSG_COMPRESSED_MOVES
	*/
	if (target->HasAuraType(SPELL_AURA_FEATHER_FALL))
		target->SendMovementFeatherFall(this);

	if (target->HasAuraType(SPELL_AURA_WATER_WALK))
		target->SendMovementWaterWalking(this);

	if (target->HasAuraType(SPELL_AURA_HOVER))
		target->SendMovementHover(this);

	WorldPacket data(SMSG_AURA_UPDATE_ALL);
	data.append(target->GetPackGUID());

	Unit::VisibleAuraMap const* visibleAuras = target->GetVisibleAuras();
	for (Unit::VisibleAuraMap::const_iterator itr = visibleAuras->begin(); itr != visibleAuras->end(); ++itr)
	{
		AuraApplication * auraApp = itr->second;
		auraApp->BuildUpdatePacket(data, false);
	}

	GetSession()->SendPacket(&data);
}

void Player::SetDailyQuestStatus(uint32 quest_id)
{
	if (Quest const* qQuest = sObjectMgr->GetQuestTemplate(quest_id))
	{
		if (!qQuest->IsDFQuest())
		{
			for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
			{
				if (!GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx))
				{
					SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, quest_id);
					m_lastDailyQuestTime = time(NULL);              // last daily quest time
					m_DailyQuestChanged = true;
					break;
				}
			}
		}
		else
		{
			m_DFQuests.insert(quest_id);
			m_lastDailyQuestTime = time(NULL);
			m_DailyQuestChanged = true;
		}
	}
}

void Player::SetWeeklyQuestStatus(uint32 quest_id)
{
	m_weeklyquests.insert(quest_id);
	m_WeeklyQuestChanged = true;
}

void Player::SetSeasonalQuestStatus(uint32 quest_id)
{
	Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
	if (!quest)
		return;

	m_seasonalquests[quest->GetEventIdForQuest()].insert(quest_id);
	m_SeasonalQuestChanged = true;
}

void Player::SetMonthlyQuestStatus(uint32 quest_id)
{
	m_monthlyquests.insert(quest_id);
	m_MonthlyQuestChanged = true;
}

void Player::ResetDailyQuestStatus()
{
	for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
		SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, 0);

	m_DFQuests.clear(); // Dungeon Finder Quests.

	// DB data deleted in caller
	m_DailyQuestChanged = false;
	m_lastDailyQuestTime = 0;
}

void Player::ResetWeeklyQuestStatus()
{
	if (m_weeklyquests.empty())
		return;

	m_weeklyquests.clear();
	// DB data deleted in caller
	m_WeeklyQuestChanged = false;
}

void Player::ResetSeasonalQuestStatus(uint16 event_id)
{
	if (m_seasonalquests.empty() || m_seasonalquests[event_id].empty())
		return;

	m_seasonalquests.erase(event_id);
	// DB data deleted in caller
	m_SeasonalQuestChanged = false;
}

void Player::ResetMonthlyQuestStatus()
{
	if (m_monthlyquests.empty())
		return;

	m_monthlyquests.clear();
	// DB data deleted in caller
	m_MonthlyQuestChanged = false;
}

Battleground* Player::GetBattleground(bool create) const
{
	if (GetBattlegroundId() == 0)
		return NULL;

	Battleground* bg = sBattlegroundMgr->GetBattleground(GetBattlegroundId());
	return (create || (bg && bg->FindBgMap()) ? bg : NULL);
}

bool Player::InArena() const
{
	Battleground* bg = GetBattleground();
	if (!bg || !bg->isArena())
		return false;

	return true;
}

void Player::SetBattlegroundId(uint32 id, BattlegroundTypeId bgTypeId, uint32 queueSlot, bool invited, bool isRandom, TeamId teamId)
{
	// if leaving current bg (and was invited) - decrease invited count for current one
	if (m_bgData.bgInstanceID && m_bgData.isInvited)
		if (Battleground* bg = sBattlegroundMgr->GetBattleground(m_bgData.bgInstanceID))
			bg->DecreaseInvitedCount(m_bgData.bgTeamId);

	// if entering new bg (and is invited) - increase invited count for new one
	if (id && invited)
		if (Battleground* bg = sBattlegroundMgr->GetBattleground(id))
			bg->IncreaseInvitedCount(teamId);

	m_bgData.bgInstanceID = id;
	m_bgData.bgTypeID = bgTypeId;
	m_bgData.bgQueueSlot = queueSlot;
	m_bgData.isInvited = invited;
	m_bgData.bgIsRandom = isRandom;

	m_bgData.bgTeamId = teamId;
	SetByteValue(PLAYER_BYTES_3, 3, uint8(teamId == TEAM_ALLIANCE ? 1 : 0));
}

bool Player::GetBGAccessByLevel(BattlegroundTypeId bgTypeId) const
{
	// get a template bg instead of running one
	Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
	if (!bgt)
		return false;

	// limit check leel to dbc compatible level range
	uint32 level = getLevel();
	if (level > DEFAULT_MAX_LEVEL)
		level = DEFAULT_MAX_LEVEL;

	if (level < bgt->GetMinLevel() || level > bgt->GetMaxLevel())
		return false;

	return true;
}

float Player::GetReputationPriceDiscount(Creature const* creature) const
{
	FactionTemplateEntry const* vendor_faction = creature->GetFactionTemplateEntry();
	if (!vendor_faction || !vendor_faction->faction)
		return 1.0f;

	ReputationRank rank = GetReputationRank(vendor_faction->faction);
	if (rank <= REP_NEUTRAL)
		return 1.0f;

	return 1.0f - 0.05f* (rank - REP_NEUTRAL);
}

bool Player::IsSpellFitByClassAndRace(uint32 spell_id) const
{
	uint32 racemask = getRaceMask();
	uint32 classmask = getClassMask();

	SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spell_id);
	if (bounds.first == bounds.second)
		return true;

	for (SkillLineAbilityMap::const_iterator _spell_idx = bounds.first; _spell_idx != bounds.second; ++_spell_idx)
	{
		// skip wrong race skills
		if (_spell_idx->second->racemask && (_spell_idx->second->racemask & racemask) == 0)
			continue;

		// skip wrong class skills
		if (_spell_idx->second->classmask && (_spell_idx->second->classmask & classmask) == 0)
			continue;

		return true;
	}

	return false;
}

bool Player::HasQuestForGO(int32 GOId) const
{
	for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
	{
		uint32 questid = GetQuestSlotQuestId(i);
		if (questid == 0)
			continue;

		QuestStatusMap::const_iterator qs_itr = m_QuestStatus.find(questid);
		if (qs_itr == m_QuestStatus.end())
			continue;

		QuestStatusData const& qs = qs_itr->second;

		if (qs.Status == QUEST_STATUS_INCOMPLETE)
		{
			Quest const* qinfo = sObjectMgr->GetQuestTemplate(questid);
			if (!qinfo)
				continue;

			if (GetGroup() && GetGroup()->isRaidGroup() && !qinfo->IsAllowedInRaid(GetMap()->GetDifficulty()))
				continue;

			for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
			{
				if (qinfo->RequiredNpcOrGo[j] >= 0)       //skip non GO case
					continue;

				if ((-1)*GOId == qinfo->RequiredNpcOrGo[j] && qs.CreatureOrGOCount[j] < qinfo->RequiredNpcOrGoCount[j])
					return true;
			}
		}
	}
	return false;
}

void Player::UpdateForQuestWorldObjects()
{
	if (m_clientGUIDs.empty())
		return;

	UpdateData udata;
	WorldPacket packet;
	for (ClientGUIDs::iterator itr = m_clientGUIDs.begin(); itr != m_clientGUIDs.end(); ++itr)
	{
		if (IS_GAMEOBJECT_GUID(*itr))
		{
			if (GameObject* obj = HashMapHolder<GameObject>::Find(*itr))
				obj->BuildValuesUpdateBlockForPlayer(&udata, this);
		}
		else if (IS_CRE_OR_VEH_GUID(*itr))
		{
			Creature* obj = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, *itr);
			if (!obj)
				continue;

			// check if this unit requires quest specific flags
			if (!obj->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK))
				continue;

			SpellClickInfoMapBounds clickPair = sObjectMgr->GetSpellClickInfoMapBounds(obj->GetEntry());
			for (SpellClickInfoContainer::const_iterator _itr = clickPair.first; _itr != clickPair.second; ++_itr)
			{
				//! This code doesn't look right, but it was logically converted to condition system to do the exact
				//! same thing it did before. It definitely needs to be overlooked for intended functionality.
				ConditionList conds = sConditionMgr->GetConditionsForSpellClickEvent(obj->GetEntry(), _itr->second.spellId);
				bool buildUpdateBlock = false;
				for (ConditionList::const_iterator jtr = conds.begin(); jtr != conds.end() && !buildUpdateBlock; ++jtr)
					if ((*jtr)->ConditionType == CONDITION_QUESTREWARDED || (*jtr)->ConditionType == CONDITION_QUESTTAKEN)
						buildUpdateBlock = true;

				if (buildUpdateBlock)
				{
					obj->BuildValuesUpdateBlockForPlayer(&udata, this);
					break;
				}
			}
		}
	}
	udata.BuildPacket(&packet);
	GetSession()->SendPacket(&packet);
}

void Player::SummonIfPossible(bool agree)
{
	if (!agree)
	{
		m_summon_expire = 0;
		return;
	}

	// expire and auto declined
	if (m_summon_expire < time(NULL))
		return;

	// drop flag at summon
	// this code can be reached only when GM is summoning player who carries flag, because player should be immune to summoning spells when he carries flag
	if (Battleground* bg = GetBattleground())
		bg->EventPlayerDroppedFlag(this);

	m_summon_expire = 0;

	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_ACCEPTED_SUMMONINGS, 1);

	TeleportTo(m_summon_mapid, m_summon_x, m_summon_y, m_summon_z, GetOrientation());
}

void Player::RemoveItemDurations(Item* item)
{
	for (ItemDurationList::iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end(); ++itr)
	{
		if (*itr == item)
		{
			m_itemDuration.erase(itr);
			break;
		}
	}
}

void Player::AddItemDurations(Item* item)
{
	if (item->GetUInt32Value(ITEM_FIELD_DURATION))
	{
		m_itemDuration.push_back(item);
		item->SendTimeUpdate(this);
	}
}

void Player::UpdateTitansGrip()
{
	// 10% damage reduce if 2x2h weapons are used
	if (!CanTitanGrip())
		RemoveAurasDueToSpell(49152);
	else if (Aura* aur = GetAura(49152))
		aur->RecalculateAmountOfEffects();
}

void Player::AutoUnequipOffhandIfNeed(bool force /*= false*/)
{
	Item* offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
	if (!offItem)
	{
		UpdateTitansGrip();
		return;
	}

	// unequip offhand weapon if player doesn't have dual wield anymore
	if (!CanDualWield() && (offItem->GetTemplate()->InventoryType == INVTYPE_WEAPONOFFHAND || offItem->GetTemplate()->InventoryType == INVTYPE_WEAPON))
		force = true;

	// need unequip offhand for 2h-weapon without TitanGrip (in any from hands)
	if (!force && (CanTitanGrip() || (offItem->GetTemplate()->InventoryType != INVTYPE_2HWEAPON && !IsTwoHandUsed())))
	{
		UpdateTitansGrip();
		return;
	}

	ItemPosCountVec off_dest;
	uint8 off_msg = CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false);
	if (off_msg == EQUIP_ERR_OK)
	{
		RemoveItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
		StoreItem(off_dest, offItem, true);
	}
	else
	{
		MoveItemFromInventory(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		offItem->DeleteFromInventoryDB(trans);                   // deletes item from character's inventory
		offItem->SaveToDB(trans);                                // recursive and not have transaction guard into self, item not in inventory and can be save standalone

		std::string subject = GetSession()->GetTrinityString(LANG_NOT_EQUIPPED_ITEM);
		MailDraft(subject, "There were problems with equipping one or several items").AddItem(offItem).SendMailTo(trans, this, MailSender(this, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);

		CharacterDatabase.CommitTransaction(trans);
	}
	UpdateTitansGrip();
}

OutdoorPvP* Player::GetOutdoorPvP() const
{
	return sOutdoorPvPMgr->GetOutdoorPvPToZoneId(GetZoneId());
}

bool Player::HasItemFitToSpellRequirements(SpellInfo const* spellInfo, Item const* ignoreItem) const
{
	if (spellInfo->EquippedItemClass < 0)
		return true;

	// scan other equipped items for same requirements (mostly 2 daggers/etc)
	// for optimize check 2 used cases only
	switch (spellInfo->EquippedItemClass)
	{
	case ITEM_CLASS_WEAPON:
	{
		for (uint8 i = EQUIPMENT_SLOT_MAINHAND; i < EQUIPMENT_SLOT_TABARD; ++i)
			if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, i))
				if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
					return true;
		break;
	}
	case ITEM_CLASS_ARMOR:
	{
		// tabard not have dependent spells
		for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_MAINHAND; ++i)
			if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, i))
				if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
					return true;

		// shields can be equipped to offhand slot
		if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
			if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
				return true;

		// ranged slot can have some armor subclasses
		if (Item* item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED))
			if (item != ignoreItem && item->IsFitToSpellRequirements(spellInfo))
				return true;

		break;
	}
	default:
		sLog->outError("HasItemFitToSpellRequirements: Not handled spell requirement for item class %u", spellInfo->EquippedItemClass);
		break;
	}

	return false;
}

bool Player::CanNoReagentCast(SpellInfo const* spellInfo) const
{
	// don't take reagents for spells with SPELL_ATTR5_NO_REAGENT_WHILE_PREP
	if (spellInfo->HasAttribute(SPELL_ATTR5_NO_REAGENT_WHILE_PREP) && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREPARATION))
		return true;

	// Check no reagent use mask
	flag96 noReagentMask;
	noReagentMask[0] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1);
	noReagentMask[1] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 1);
	noReagentMask[2] = GetUInt32Value(PLAYER_NO_REAGENT_COST_1 + 2);
	if (spellInfo->SpellFamilyFlags  & noReagentMask)
		return true;

	return false;
}

void Player::RemoveItemDependentAurasAndCasts(Item* pItem)
{
	for (AuraMap::iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end();)
	{
		Aura* aura = itr->second;

		// skip passive (passive item dependent spells work in another way) and not self applied auras
		SpellInfo const* spellInfo = aura->GetSpellInfo();
		if (aura->IsPassive() || aura->GetCasterGUID() != GetGUID())
		{
			++itr;
			continue;
		}

		// skip if not item dependent or have alternative item
		if (HasItemFitToSpellRequirements(spellInfo, pItem))
		{
			++itr;
			continue;
		}

		// no alt item, remove aura, restart check
		RemoveOwnedAura(itr);
	}

	// currently casted spells can be dependent from item
	for (uint32 i = 0; i < CURRENT_MAX_SPELL; ++i)
		if (Spell* spell = GetCurrentSpell(CurrentSpellTypes(i)))
			if (spell->getState() != SPELL_STATE_DELAYED && !HasItemFitToSpellRequirements(spell->m_spellInfo, pItem))
				InterruptSpell(CurrentSpellTypes(i));
}

uint32 Player::GetResurrectionSpellId()
{
	// search priceless resurrection possibilities
	uint32 prio = 0;
	uint32 spell_id = 0;
	AuraEffectList const& dummyAuras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
	for (AuraEffectList::const_iterator itr = dummyAuras.begin(); itr != dummyAuras.end(); ++itr)
	{
		// Soulstone Resurrection                           // prio: 3 (max, non death persistent)
		if (prio < 2 && (*itr)->GetSpellInfo()->SpellVisual[0] == 99 && (*itr)->GetSpellInfo()->SpellIconID == 92)
		{
			switch ((*itr)->GetId())
			{
			case 20707: spell_id = 3026; break;        // rank 1
			case 20762: spell_id = 20758; break;        // rank 2
			case 20763: spell_id = 20759; break;        // rank 3
			case 20764: spell_id = 20760; break;        // rank 4
			case 20765: spell_id = 20761; break;        // rank 5
			case 27239: spell_id = 27240; break;        // rank 6
			case 47883: spell_id = 47882; break;        // rank 7
			default:
				sLog->outError("Unhandled spell %u: S.Resurrection", (*itr)->GetId());
				continue;
			}

			prio = 3;
		}
		// Twisting Nether                                  // prio: 2 (max)
		else if ((*itr)->GetId() == 23701 && roll_chance_i(10))
		{
			prio = 2;
			spell_id = 23700;
		}
	}

	// Reincarnation (passive spell)  // prio: 1                  // Glyph of Renewed Life
	if (prio < 1 && HasSpell(20608) && !HasSpellCooldown(21169) && (HasAura(58059) || HasItemCount(17030)))
		spell_id = 21169;

	return spell_id;
}

// Used in triggers for check "Only to targets that grant experience or honor" req
bool Player::isHonorOrXPTarget(Unit* victim) const
{
	uint8 v_level = victim->getLevel();
	uint8 k_grey = Trinity::XP::GetGrayLevel(getLevel());

	// Victim level less gray level
	if (v_level <= k_grey)
		return false;

	if (victim->GetTypeId() == TYPEID_UNIT)
	{
		if (victim->IsTotem() ||
			victim->IsPet() ||
			victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_XP_AT_KILL)
			return false;
	}
	return true;
}

bool Player::GetsRecruitAFriendBonus(bool forXP)
{
	bool recruitAFriend = false;
	if (getLevel() <= sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL) || !forXP)
	{
		if (Group* group = this->GetGroup())
		{
			for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
			{
				Player* player = itr->GetSource();
				if (!player || !player->IsInMap(this))
					continue;

				if (!player->IsAtRecruitAFriendDistance(this))
					continue;                               // member (alive or dead) or his corpse at req. distance

				if (forXP)
				{
					// level must be allowed to get RaF bonus
					if (player->getLevel() > sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
						continue;

					// level difference must be small enough to get RaF bonus, UNLESS we are lower level
					if (player->getLevel() < getLevel())
						if (uint8(getLevel() - player->getLevel()) > sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL_DIFFERENCE))
							continue;
				}

				bool ARecruitedB = (player->GetSession()->GetRecruiterId() == GetSession()->GetAccountId());
				bool BRecruitedA = (GetSession()->GetRecruiterId() == player->GetSession()->GetAccountId());
				if (ARecruitedB || BRecruitedA)
				{
					recruitAFriend = true;
					break;
				}
			}
		}
	}
	return recruitAFriend;
}

void Player::RewardPlayerAndGroupAtKill(Unit* victim, bool isBattleGround)
{
	KillRewarder(this, victim, isBattleGround).Reward();
}

void Player::RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource)
{
	if (!pRewardSource)
		return;
	uint64 creature_guid = (pRewardSource->GetTypeId() == TYPEID_UNIT) ? pRewardSource->GetGUID() : uint64(0);

	// prepare data for near group iteration
	if (Group* group = GetGroup())
	{
		for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
		{
			Player* player = itr->GetSource();
			if (!player)
				continue;

			if (!player->IsAtGroupRewardDistance(pRewardSource))
				continue;                               // member (alive or dead) or his corpse at req. distance

			// quest objectives updated only for alive group member or dead but with not released body
			if (player->IsAlive() || !player->GetCorpse())
				player->KilledMonsterCredit(creature_id, creature_guid);
		}
	}
	else                                                    // if (!group)
		KilledMonsterCredit(creature_id, creature_guid);
}

bool Player::IsAtGroupRewardDistance(WorldObject const* pRewardSource) const
{
	if (!pRewardSource || !IsInMap(pRewardSource))
		return false;
	const WorldObject* player = GetCorpse();
	if (!player || IsAlive())
		player = this;

	if (pRewardSource->GetMap()->IsDungeon())
		return true;

	return pRewardSource->GetDistance(player) <= sWorld->getFloatConfig(CONFIG_GROUP_XP_DISTANCE);
}

bool Player::IsAtRecruitAFriendDistance(WorldObject const* pOther) const
{
	if (!pOther)
		return false;
	const WorldObject* player = GetCorpse();
	if (!player || IsAlive())
		player = this;

	if (player->GetMapId() != pOther->GetMapId() || player->GetInstanceId() != pOther->GetInstanceId())
		return false;

	return pOther->GetDistance(player) <= sWorld->getFloatConfig(CONFIG_MAX_RECRUIT_A_FRIEND_DISTANCE);
}

uint32 Player::GetBaseWeaponSkillValue(WeaponAttackType attType) const
{
	Item* item = GetWeaponForAttack(attType, true);

	// unarmed only with base attack
	if (attType != BASE_ATTACK && !item)
		return 0;

	// weapon skill or (unarmed for base attack and for fist weapons)
	uint32  skill = (item && item->GetSkill() != SKILL_FIST_WEAPONS) ? item->GetSkill() : uint32(SKILL_UNARMED);
	return GetBaseSkillValue(skill);
}

void Player::ResurectUsingRequestData()
{
	/// Teleport before resurrecting by player, otherwise the player might get attacked from creatures near his corpse
	TeleportTo(m_resurrectMap, m_resurrectX, m_resurrectY, m_resurrectZ, GetOrientation());

	if (IsBeingTeleported())
	{
		ScheduleDelayedOperation(DELAYED_RESURRECT_PLAYER);
		return;
	}

	ResurrectPlayer(0.0f, false);

	if (GetMaxHealth() > m_resurrectHealth)
		SetHealth(m_resurrectHealth);
	else
		SetFullHealth();

	if (GetMaxPower(POWER_MANA) > m_resurrectMana)
		SetPower(POWER_MANA, m_resurrectMana);
	else
		SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

	SetPower(POWER_RAGE, 0);

	SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));

	SpawnCorpseBones();
}

void Player::SetClientControl(Unit* target, bool allowMove, bool packetOnly /*= false*/)
{
	WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, target->GetPackGUID().size() + 1);
	data.append(target->GetPackGUID());
	data << uint8((allowMove && !target->HasUnitState(UNIT_STATE_FLEEING | UNIT_STATE_CONFUSED)) ? 1 : 0);
	GetSession()->SendPacket(&data);

	// We want to set the packet only
	if (packetOnly)
		return;

	if (this != target)
		SetViewpoint(target, allowMove);

	if (allowMove)
		SetMover(target);

	// Xinef: disable moving if target has disable move flag
	if (target->GetTypeId() != TYPEID_UNIT)
		return;

	if (allowMove && target->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
	{
		target->ClearUnitState(UNIT_STATE_ROOT);
		target->SetControlled(true, UNIT_STATE_ROOT);
	}
	else if (!allowMove && target->HasUnitState(UNIT_STATE_ROOT) && !target->HasUnitTypeMask(UNIT_MASK_ACCESSORY))
	{
		if (target->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
		{
			// Xinef: restore original orientation, important for shooting vehicles!
			Position pos = target->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && target->GetTransGUID() && IS_MO_TRANSPORT_GUID(target->GetTransGUID()) ? target->ToCreature()->GetTransportHomePosition() : target->ToCreature()->GetHomePosition();
			target->SetOrientation(pos.GetOrientation());
			target->SetFacingTo(pos.GetOrientation());
			target->DisableSpline();
		}
		else
			target->SetControlled(false, UNIT_STATE_ROOT);
	}
}

void Player::SetMover(Unit* target)
{
	if (this != target && target->m_movedByPlayer && target->m_movedByPlayer != target && target->m_movedByPlayer != this)
	{
		sLog->outMisc("Player::SetMover (A1) - %u, %u, %u, %u, %u, %u, %u, %u", GetGUIDLow(), GetMapId(), GetInstanceId(), FindMap(), IsInWorld() ? 1 : 0, IsDuringRemoveFromWorld() ? 1 : 0, IsBeingTeleported() ? 1 : 0, isBeingLoaded() ? 1 : 0);
		sLog->outMisc("Player::SetMover (A2) - %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u", target->GetTypeId(), target->GetEntry(), target->GetUnitTypeMask(), target->GetGUIDLow(), target->GetMapId(), target->GetInstanceId(), target->FindMap(), target->IsInWorld() ? 1 : 0, target->IsDuringRemoveFromWorld() ? 1 : 0, (target->ToPlayer() && target->ToPlayer()->IsBeingTeleported() ? 1 : 0), target->isBeingLoaded() ? 1 : 0);
		sLog->outMisc("Player::SetMover (A3) - %u, %u, %u, %u, %u, %u, %u, %u", target->m_movedByPlayer->GetGUIDLow(), target->m_movedByPlayer->GetMapId(), target->m_movedByPlayer->GetInstanceId(), target->m_movedByPlayer->FindMap(), target->m_movedByPlayer->IsInWorld() ? 1 : 0, target->m_movedByPlayer->IsDuringRemoveFromWorld() ? 1 : 0, target->m_movedByPlayer->ToPlayer()->IsBeingTeleported() ? 1 : 0, target->m_movedByPlayer->isBeingLoaded() ? 1 : 0);
	}
	if (this != target && (!target->IsInWorld() || target->IsDuringRemoveFromWorld() || GetMapId() != target->GetMapId() || GetInstanceId() != target->GetInstanceId()))
	{
		sLog->outMisc("Player::SetMover (B1) - %u, %u, %u, %u, %u, %u, %u, %u", GetGUIDLow(), GetMapId(), GetInstanceId(), FindMap(), IsInWorld() ? 1 : 0, IsDuringRemoveFromWorld() ? 1 : 0, IsBeingTeleported() ? 1 : 0, isBeingLoaded() ? 1 : 0);
		sLog->outMisc("Player::SetMover (B2) - %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u", target->GetTypeId(), target->GetEntry(), target->GetUnitTypeMask(), target->GetGUIDLow(), target->GetMapId(), target->GetInstanceId(), target->FindMap(), target->IsInWorld() ? 1 : 0, target->IsDuringRemoveFromWorld() ? 1 : 0, (target->ToPlayer() && target->ToPlayer()->IsBeingTeleported() ? 1 : 0), target->isBeingLoaded() ? 1 : 0);
	}
	m_mover->m_movedByPlayer = NULL;
	m_mover = target;
	m_mover->m_movedByPlayer = this;
}

void Player::UpdateZoneDependentAuras(uint32 newZone)
{
	// Some spells applied at enter into zone (with subzones), aura removed in UpdateAreaDependentAuras that called always at zone->area update
	SpellAreaForAreaMapBounds saBounds = sSpellMgr->GetSpellAreaForAreaMapBounds(newZone);
	for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
		if (itr->second->autocast && itr->second->IsFitToRequirements(this, newZone, 0))
			if (!HasAura(itr->second->spellId))
				CastSpell(this, itr->second->spellId, true);
}

void Player::UpdateAreaDependentAuras(uint32 newArea)
{
	// remove auras from spells with area limitations
	for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
	{
		// use m_zoneUpdateId for speed: UpdateArea called from UpdateZone or instead UpdateZone in both cases m_zoneUpdateId up-to-date
		if (iter->second->GetSpellInfo()->CheckLocation(GetMapId(), m_zoneUpdateId, newArea, this) != SPELL_CAST_OK)
			RemoveOwnedAura(iter);
		else
			++iter;
	}

	// Xinef: check controlled auras
	if (!m_Controlled.empty())
		for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); )
		{
			Unit* controlled = *itr;
			++itr;
			if (controlled && !controlled->IsPet())
			{
				Unit::AuraMap& tAuras = controlled->GetOwnedAuras();
				for (Unit::AuraMap::iterator auraIter = tAuras.begin(); auraIter != tAuras.end();)
				{
					if (auraIter->second->GetSpellInfo()->CheckLocation(GetMapId(), m_zoneUpdateId, newArea, NULL) != SPELL_CAST_OK)
						controlled->RemoveOwnedAura(auraIter);
					else
						++auraIter;
				}
			}
		}

	// some auras applied at subzone enter
	SpellAreaForAreaMapBounds saBounds = sSpellMgr->GetSpellAreaForAreaMapBounds(newArea);
	for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
		if (itr->second->autocast && itr->second->IsFitToRequirements(this, m_zoneUpdateId, newArea))
			if (!HasAura(itr->second->spellId))
				CastSpell(this, itr->second->spellId, true);

	if (newArea == 4273 && GetVehicle() && GetPositionX() > 400) // Ulduar
	{
		switch (GetVehicleBase()->GetEntry())
		{
		case 33062:
		case 33109:
		case 33060:
			GetVehicle()->Dismiss();
			break;
		}
	}
}

uint32 Player::GetCorpseReclaimDelay(bool pvp) const
{
	if (pvp)
	{
		if (!sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP))
			return copseReclaimDelay[0];
	}
	else if (!sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE))
		return 0;

	time_t now = time(NULL);
	// 0..2 full period
	// should be ceil(x)-1 but not floor(x)
	uint64 count = (now < m_deathExpireTime - 1) ? (m_deathExpireTime - 1 - now) / DEATH_EXPIRE_STEP : 0;
	return copseReclaimDelay[count];
}

void Player::UpdateCorpseReclaimDelay()
{
	bool pvp = m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH;

	if ((pvp && !sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP)) ||
		(!pvp && !sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE)))
		return;

	time_t now = time(NULL);

	if (now < m_deathExpireTime)
	{
		// full and partly periods 1..3
		uint64 count = (m_deathExpireTime - now) / DEATH_EXPIRE_STEP + 1;

		if (count < MAX_DEATH_COUNT)
			m_deathExpireTime = now + (count + 1) * DEATH_EXPIRE_STEP;
		else
			m_deathExpireTime = now + MAX_DEATH_COUNT*DEATH_EXPIRE_STEP;
	}
	else
		m_deathExpireTime = now + DEATH_EXPIRE_STEP;
}

int32 Player::CalculateCorpseReclaimDelay(bool load)
{
	Corpse* corpse = GetCorpse();

	if (load && !corpse)
		return -1;

	bool pvp = corpse ? corpse->GetType() == CORPSE_RESURRECTABLE_PVP : m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH;

	uint32 delay;

	if (load)
	{
		if (corpse->GetGhostTime() > m_deathExpireTime)
			return -1;

		uint64 count = 0;

		if ((pvp && sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP)) ||
			(!pvp && sWorld->getBoolConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE)))
		{
			count = (m_deathExpireTime - corpse->GetGhostTime()) / DEATH_EXPIRE_STEP;

			if (count >= MAX_DEATH_COUNT)
				count = MAX_DEATH_COUNT - 1;
		}

		time_t expected_time = corpse->GetGhostTime() + copseReclaimDelay[count];
		time_t now = time(NULL);

		if (now >= expected_time)
			return -1;

		delay = expected_time - now;
	}
	else
		delay = GetCorpseReclaimDelay(pvp);

	return delay * IN_MILLISECONDS;
}

void Player::SendCorpseReclaimDelay(uint32 delay)
{
	WorldPacket data(SMSG_CORPSE_RECLAIM_DELAY, 4);
	data << uint32(delay);
	GetSession()->SendPacket(&data);
}

Player* Player::GetNextRandomRaidMember(float radius)
{
	Group* group = GetGroup();
	if (!group)
		return NULL;

	std::vector<Player*> nearMembers;
	nearMembers.reserve(group->GetMembersCount());

	for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
	{
		Player* Target = itr->GetSource();

		// IsHostileTo check duel and controlled by enemy
		if (Target && Target != this && IsWithinDistInMap(Target, radius) &&
			!Target->HasInvisibilityAura() && !IsHostileTo(Target))
			nearMembers.push_back(Target);
	}

	if (nearMembers.empty())
		return NULL;

	uint32 randTarget = urand(0, nearMembers.size() - 1);
	return nearMembers[randTarget];
}

PartyResult Player::CanUninviteFromGroup() const
{
	Group const* grp = GetGroup();
	if (!grp)
		return ERR_NOT_IN_GROUP;

	if (grp->isLFGGroup())
	{
		uint64 gguid = grp->GetGUID();
		if (!sLFGMgr->GetKicksLeft(gguid))
			return ERR_PARTY_LFG_BOOT_LIMIT;

		lfg::LfgState state = sLFGMgr->GetState(gguid);
		if (state == lfg::LFG_STATE_BOOT)
			return ERR_PARTY_LFG_BOOT_IN_PROGRESS;

		if (grp->GetMembersCount() <= lfg::LFG_GROUP_KICK_VOTES_NEEDED)
			return ERR_PARTY_LFG_BOOT_TOO_FEW_PLAYERS;

		if (state == lfg::LFG_STATE_FINISHED_DUNGEON)
			return ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE;

		if (grp->isRollLootActive())
			return ERR_PARTY_LFG_BOOT_LOOT_ROLLS;

		// TODO: Should also be sent when anyone has recently left combat, with an aprox ~5 seconds timer.
		for (GroupReference const* itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
			if (itr->GetSource() && itr->GetSource()->IsInMap(this) && itr->GetSource()->IsInCombat())
				return ERR_PARTY_LFG_BOOT_IN_COMBAT;

		/* Missing support for these types
			return ERR_PARTY_LFG_BOOT_COOLDOWN_S;
			return ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S;
		*/
	}
	else
	{
		if (!grp->IsLeader(GetGUID()) && !grp->IsAssistant(GetGUID()))
			return ERR_NOT_LEADER;

		if (InBattleground())
			return ERR_INVITE_RESTRICTED;
	}

	return ERR_PARTY_RESULT_OK;
}

bool Player::isUsingLfg()
{
	return sLFGMgr->GetState(GetGUID()) != lfg::LFG_STATE_NONE;
}

bool Player::inRandomLfgDungeon()
{
	if (sLFGMgr->selectedRandomLfgDungeon(GetGUID()))
	{
		Map const* map = GetMap();
		return sLFGMgr->inLfgDungeonMap(GetGUID(), map->GetId(), map->GetDifficulty());
	}

	return false;
}

void Player::SetBattlegroundOrBattlefieldRaid(Group *group, int8 subgroup)
{
	//we must move references from m_group to m_originalGroup
	if (GetGroup() && (GetGroup()->isBGGroup() || GetGroup()->isBFGroup()))
	{
		sLog->outMisc("Player::SetBattlegroundOrBattlefieldRaid - current group is %s group!", (GetGroup()->isBGGroup() ? "BG" : "BF"));
		//ASSERT(false); // pussywizard: origanal group can never be bf/bg group
	}

	SetOriginalGroup(GetGroup(), GetSubGroup());

	m_group.unlink();
	m_group.link(group, this);
	m_group.setSubGroup((uint8)subgroup);
}

void Player::RemoveFromBattlegroundOrBattlefieldRaid()
{
	//remove existing reference
	m_group.unlink();
	if (Group* group = GetOriginalGroup())
	{
		m_group.link(group, this);
		m_group.setSubGroup(GetOriginalSubGroup());
	}
	SetOriginalGroup(NULL);
}

void Player::SetOriginalGroup(Group* group, int8 subgroup)
{
	if (group == NULL)
		m_originalGroup.unlink();
	else
	{
		// never use SetOriginalGroup without a subgroup unless you specify NULL for group
		ASSERT(subgroup >= 0);
		m_originalGroup.link(group, this);
		m_originalGroup.setSubGroup((uint8)subgroup);
	}
}

void Player::UpdateUnderwaterState(Map* m, float x, float y, float z)
{
	// pussywizard: optimization
	if (GetExactDistSq(&m_last_underwaterstate_position) < 3.0f*3.0f)
		return;
	m_last_underwaterstate_position.Relocate(m_positionX, m_positionY, m_positionZ);

	if (!IsPositionValid()) // pussywizard: crashfix if calculated grid coords would be out of range 0-64
		return;

	LiquidData liquid_status;
	ZLiquidStatus res = m->getLiquidStatus(x, y, z, MAP_ALL_LIQUIDS, &liquid_status);
	if (!res)
	{
		m_MirrorTimerFlags &= ~(UNDERWATER_INWATER | UNDERWATER_INLAVA | UNDERWATER_INSLIME | UNDERWARER_INDARKWATER);
		if (_lastLiquid && _lastLiquid->SpellId)
			RemoveAurasDueToSpell(_lastLiquid->SpellId);

		_lastLiquid = NULL;
		return;
	}

	if (uint32 liqEntry = liquid_status.entry)
	{
		LiquidTypeEntry const* liquid = sLiquidTypeStore.LookupEntry(liqEntry);
		if (_lastLiquid && _lastLiquid->SpellId && _lastLiquid->Id != liqEntry)
			RemoveAurasDueToSpell(_lastLiquid->SpellId);

		if (liquid && liquid->SpellId)
		{
			if (res & (LIQUID_MAP_UNDER_WATER | LIQUID_MAP_IN_WATER))
			{
				if (!HasAura(liquid->SpellId))
					CastSpell(this, liquid->SpellId, true);
			}
			else
				RemoveAurasDueToSpell(liquid->SpellId);
		}

		_lastLiquid = liquid;
	}
	else if (_lastLiquid && _lastLiquid->SpellId)
	{
		RemoveAurasDueToSpell(_lastLiquid->SpellId);
		_lastLiquid = NULL;
	}


	// All liquids type - check under water position
	if (liquid_status.type_flags & (MAP_LIQUID_TYPE_WATER | MAP_LIQUID_TYPE_OCEAN | MAP_LIQUID_TYPE_MAGMA | MAP_LIQUID_TYPE_SLIME))
	{
		if (res & LIQUID_MAP_UNDER_WATER)
			m_MirrorTimerFlags |= UNDERWATER_INWATER;
		else
			m_MirrorTimerFlags &= ~UNDERWATER_INWATER;
	}

	// Allow travel in dark water on taxi or transport
	if ((liquid_status.type_flags & MAP_LIQUID_TYPE_DARK_WATER) && !IsInFlight() && !GetTransport())
		m_MirrorTimerFlags |= UNDERWARER_INDARKWATER;
	else
		m_MirrorTimerFlags &= ~UNDERWARER_INDARKWATER;

	// in lava check, anywhere in lava level
	if (liquid_status.type_flags & MAP_LIQUID_TYPE_MAGMA)
	{
		if (res & (LIQUID_MAP_UNDER_WATER | LIQUID_MAP_IN_WATER | LIQUID_MAP_WATER_WALK))
			m_MirrorTimerFlags |= UNDERWATER_INLAVA;
		else
			m_MirrorTimerFlags &= ~UNDERWATER_INLAVA;
	}
	// in slime check, anywhere in slime level
	if (liquid_status.type_flags & MAP_LIQUID_TYPE_SLIME)
	{
		if (res & (LIQUID_MAP_UNDER_WATER | LIQUID_MAP_IN_WATER | LIQUID_MAP_WATER_WALK))
			m_MirrorTimerFlags |= UNDERWATER_INSLIME;
		else
			m_MirrorTimerFlags &= ~UNDERWATER_INSLIME;
	}
}

void Player::SetCanParry(bool value)
{
	if (m_canParry == value)
		return;

	m_canParry = value;
	UpdateParryPercentage();
}

void Player::SetCanBlock(bool value)
{
	if (m_canBlock == value)
		return;

	m_canBlock = value;
	UpdateBlockPercentage();
}

void Player::SetCanTitanGrip(bool value)
{
	m_canTitanGrip = value;
}

bool ItemPosCount::isContainedIn(ItemPosCountVec const& vec) const
{
	for (ItemPosCountVec::const_iterator itr = vec.begin(); itr != vec.end(); ++itr)
		if (itr->pos == pos)
			return true;
	return false;
}

void Player::StopCastingBindSight()
{
	if (WorldObject* target = GetViewpoint())
	{
		if (target->isType(TYPEMASK_UNIT))
		{
			((Unit*)target)->RemoveAurasByType(SPELL_AURA_BIND_SIGHT, GetGUID());
			((Unit*)target)->RemoveAurasByType(SPELL_AURA_MOD_POSSESS, GetGUID());
			((Unit*)target)->RemoveAurasByType(SPELL_AURA_MOD_POSSESS_PET, GetGUID());
		}
	}
}

void Player::SetViewpoint(WorldObject* target, bool apply)
{
	if (apply)
	{
		// target must be in world
		if (!target->IsInWorld())
			return;

		if (!IsInWorld() || IsDuringRemoveFromWorld())
			return;

		;//sLog->outDebug(LOG_FILTER_MAPS, "Player::CreateViewpoint: Player %s create seer %u (TypeId: %u).", GetName().c_str(), target->GetEntry(), target->GetTypeId());

		if (!AddUInt64Value(PLAYER_FARSIGHT, target->GetGUID()))
		{
			sLog->outCrash("Player::CreateViewpoint: Player %s cannot add new viewpoint!", GetName().c_str());
			return;
		}

		// farsight dynobj or puppet may be very far away
		UpdateVisibilityOf(target);

		if (target->isType(TYPEMASK_UNIT) && !GetVehicle())
			((Unit*)target)->AddPlayerToVision(this);
	}
	else
	{
		//must immediately set seer back otherwise may crash
		m_seer = this;

		;//sLog->outDebug(LOG_FILTER_MAPS, "Player::CreateViewpoint: Player %s remove seer", GetName().c_str());

		if (target->isType(TYPEMASK_UNIT) && !GetVehicle())
			((Unit*)target)->RemovePlayerFromVision(this);

		if (!RemoveUInt64Value(PLAYER_FARSIGHT, target->GetGUID()))
		{
			sLog->outCrash("Player::CreateViewpoint: Player %s cannot remove current viewpoint!", GetName().c_str());
			return;
		}

		//WorldPacket data(SMSG_CLEAR_FAR_SIGHT_IMMEDIATE, 0);
		//GetSession()->SendPacket(&data);
	}
}

WorldObject* Player::GetViewpoint() const
{
	if (uint64 guid = GetUInt64Value(PLAYER_FARSIGHT))
		return (WorldObject*)ObjectAccessor::GetObjectByTypeMask(*this, guid, TYPEMASK_SEER);
	return NULL;
}

bool Player::CanUseBattlegroundObject(GameObject* gameobject) const
{
	// It is possible to call this method will a null pointer, only skipping faction check.
	if (gameobject)
	{
		FactionTemplateEntry const* playerFaction = GetFactionTemplateEntry();
		FactionTemplateEntry const* faction = sFactionTemplateStore.LookupEntry(gameobject->GetUInt32Value(GAMEOBJECT_FACTION));

		if (playerFaction && faction && !playerFaction->IsFriendlyTo(*faction))
			return false;
	}

	// BUG: sometimes when player clicks on flag in AB - client won't send gameobject_use, only gameobject_report_use packet
	// Note: Mount, stealth and invisibility will be removed when used
	return (!isTotalImmune() &&                            // Damage immune
		!HasAura(SPELL_RECENTLY_DROPPED_FLAG) &&       // Still has recently held flag debuff
		IsAlive());                                    // Alive
}

bool Player::CanCaptureTowerPoint() const
{
	return (!HasStealthAura() &&                            // not stealthed
		!HasInvisibilityAura() &&                      // not invisible
		IsAlive()                                      // live player
		);
}

uint32 Player::GetBarberShopCost(uint8 newhairstyle, uint8 newhaircolor, uint8 newfacialhair, BarberShopStyleEntry const* newSkin)
{
	uint8 level = getLevel();

	if (level > GT_MAX_LEVEL)
		level = GT_MAX_LEVEL;                               // max level in this dbc

	uint8 hairstyle = GetByteValue(PLAYER_BYTES, 2);
	uint8 haircolor = GetByteValue(PLAYER_BYTES, 3);
	uint8 facialhair = GetByteValue(PLAYER_BYTES_2, 0);
	uint8 skincolor = GetByteValue(PLAYER_BYTES, 0);

	if ((hairstyle == newhairstyle) && (haircolor == newhaircolor) && (facialhair == newfacialhair) && (!newSkin || (newSkin->hair_id == skincolor)))
		return 0;

	GtBarberShopCostBaseEntry const* bsc = sGtBarberShopCostBaseStore.LookupEntry(level - 1);

	if (!bsc)                                                // shouldn't happen
		return 0xFFFFFFFF;

	float cost = 0;

	if (hairstyle != newhairstyle)
		cost += bsc->cost;                                  // full price

	if ((haircolor != newhaircolor) && (hairstyle == newhairstyle))
		cost += bsc->cost * 0.5f;                           // +1/2 of price

	if (facialhair != newfacialhair)
		cost += bsc->cost * 0.75f;                          // +3/4 of price

	if (newSkin && skincolor != newSkin->hair_id)
		cost += bsc->cost * 0.75f;                          // +5/6 of price

	return uint32(cost);
}

void Player::InitGlyphsForLevel()
{
	for (uint32 i = 0; i < sGlyphSlotStore.GetNumRows(); ++i)
		if (GlyphSlotEntry const* gs = sGlyphSlotStore.LookupEntry(i))
			if (gs->Order)
				SetGlyphSlot(gs->Order - 1, gs->Id);

	uint8 level = getLevel();
	uint32 value = 0;

	// 0x3F = 0x01 | 0x02 | 0x04 | 0x08 | 0x10 | 0x20 for 80 level
	if (level >= 15)
		value |= (0x01 | 0x02);
	if (level >= 30)
		value |= 0x08;
	if (level >= 50)
		value |= 0x04;
	if (level >= 70)
		value |= 0x10;
	if (level >= 80)
		value |= 0x20;

	SetUInt32Value(PLAYER_GLYPHS_ENABLED, value);
}

bool Player::isTotalImmune() const
{
	AuraEffectList const& immune = GetAuraEffectsByType(SPELL_AURA_SCHOOL_IMMUNITY);

	uint32 immuneMask = 0;
	for (AuraEffectList::const_iterator itr = immune.begin(); itr != immune.end(); ++itr)
	{
		immuneMask |= (*itr)->GetMiscValue();
		if (immuneMask & SPELL_SCHOOL_MASK_ALL)            // total immunity
			return true;
	}
	return false;
}

bool Player::HasTitle(uint32 bitIndex) const
{
	if (bitIndex > MAX_TITLE_INDEX)
		return false;

	uint32 fieldIndexOffset = bitIndex / 32;
	uint32 flag = 1 << (bitIndex % 32);
	return HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
}

void Player::SetTitle(CharTitlesEntry const* title, bool lost)
{
	uint32 fieldIndexOffset = title->bit_index / 32;
	uint32 flag = 1 << (title->bit_index % 32);

	if (lost)
	{
		if (!HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag))
			return;

		RemoveFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
	}
	else
	{
		if (HasFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag))
			return;

		SetFlag(PLAYER__FIELD_KNOWN_TITLES + fieldIndexOffset, flag);
	}

	WorldPacket data(SMSG_TITLE_EARNED, 4 + 4);
	data << uint32(title->bit_index);
	data << uint32(lost ? 0 : 1);                           // 1 - earned, 0 - lost
	GetSession()->SendPacket(&data);
}

void Player::UpdateCharmedAI()
{
	// Xinef: maybe passed as argument?
	Unit* charmer = GetCharmer();
	CharmInfo* charmInfo = GetCharmInfo();

	// Xinef: needs more thinking, maybe kill player?
	if (!charmer || !charmInfo)
		return;

	// Xinef: we should be killed if caster enters evade mode and charm is infinite
	if (charmer->GetTypeId() == TYPEID_UNIT && charmer->ToCreature()->IsInEvadeMode())
	{
		AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_MOD_CHARM);
		for (AuraEffectList::const_iterator iter = auras.begin(); iter != auras.end(); ++iter)
			if ((*iter)->GetCasterGUID() == charmer->GetGUID() && (*iter)->GetBase()->IsPermanent())
			{
				Unit::DealDamage(charmer, this, GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
				return;
			}
	}

	Unit* target = GetVictim();
	if (target)
	{
		SetInFront(target);
		SendMovementFlagUpdate(true);
	}

	if (HasUnitState(UNIT_STATE_CASTING))
		return;

	bool Mages = getClassMask() & (1 << (CLASS_MAGE - 1) | 1 << (CLASS_WARLOCK - 1) | 1 << (CLASS_DRUID - 1) | 1 << (CLASS_HUNTER - 1) | 1 << (CLASS_PRIEST - 1));

	// Xinef: charmer type specific actions
	if (charmer->GetTypeId() == TYPEID_PLAYER)
	{
		bool follow = false;
		if (!target)
		{
			if (charmInfo->GetPlayerReactState() == REACT_PASSIVE)
				follow = true;
			else if (charmInfo->GetPlayerReactState() == REACT_DEFENSIVE)
			{
				if (charmer->GetVictim())
					target = charmer->GetVictim();
				else
					follow = true;
			}

			if (follow)
			{
				if (!HasUnitState(UNIT_STATE_FOLLOW))
					GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
				return;
			}
		}
		else if (target && GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE)
			GetMotionMaster()->MoveChase(target, Mages ? 15 : 4);
	}

	if (!target || !IsValidAttackTarget(target))
	{
		target = SelectNearbyTarget(NULL, 30);
		if (!target)
		{
			if (!HasUnitState(UNIT_STATE_FOLLOW))
				GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

			return;
		}

		GetMotionMaster()->MoveChase(target, Mages ? 15 : 4);
		Attack(target, true);
	}
	else
	{
		float Distance = GetDistance(target);
		uint8 rnd = urand(0, 1);

		if (Mages)
		{
			if ((GetPower(POWER_MANA) * 100 / GetMaxPower(POWER_MANA)) < 10)
			{
				GetMotionMaster()->MoveChase(target, 4);
				return;
			}

			if (Distance <= 3)
			{
				if (urand(0, 1))
				{
					if (m_charmAISpells[SPELL_T_STUN] && !HasSpellCooldown(m_charmAISpells[SPELL_T_STUN]))
						CastSpell(target, m_charmAISpells[SPELL_T_STUN], false);
					else if (m_charmAISpells[SPELL_ROOT_OR_FEAR] && !HasSpellCooldown(m_charmAISpells[SPELL_ROOT_OR_FEAR]))
						CastSpell(target, m_charmAISpells[SPELL_ROOT_OR_FEAR], false);
					else if (m_charmAISpells[SPELL_IMMUNITY] && !HasSpellCooldown(m_charmAISpells[SPELL_IMMUNITY]))
						CastSpell(this, m_charmAISpells[SPELL_IMMUNITY], true);
				}
				else
				{
					switch (urand(0, 1))
					{
					case 0:
						if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] && !HasSpellCooldown(m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
							CastSpell(target, m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd], false);
						break;
					case 1:
						if (m_charmAISpells[SPELL_DOT_DAMAGE] && !HasSpellCooldown(m_charmAISpells[SPELL_DOT_DAMAGE]))
							CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE], false);
						break;
					}
				}
			}
			else
			{
				switch (urand(0, 2))
				{
				case 0:
					if (m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd] && !HasSpellCooldown(m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd]))
						CastSpell(target, m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd], false);
					break;
				case 1:
					if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] && !HasSpellCooldown(m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
						CastSpell(target, m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd], false);
					break;
				case 2:
					if (m_charmAISpells[SPELL_DOT_DAMAGE] && !HasSpellCooldown(m_charmAISpells[SPELL_DOT_DAMAGE]))
						CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE], false);
					break;
				}
			}
		}
		else
		{
			if (Distance > 10)
			{
				GetMotionMaster()->MoveChase(target, 2.0f);
				if (m_charmAISpells[SPELL_T_CHARGE] && !HasSpellCooldown(m_charmAISpells[SPELL_T_CHARGE]))
					CastSpell(target, m_charmAISpells[SPELL_T_CHARGE], false);
				else if (m_charmAISpells[SPELL_FAST_RUN] && !HasSpellCooldown(m_charmAISpells[SPELL_FAST_RUN]))
					CastSpell(this, m_charmAISpells[SPELL_FAST_RUN], false);
			}

			if (HasUnitState(UNIT_STATE_CASTING))
				return;

			switch (urand(0, 2))
			{
			case 0:
				if (m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd] && !HasSpellCooldown(m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd]))
					CastSpell(target, m_charmAISpells[SPELL_INSTANT_DAMAGE + rnd], false);
				break;
			case 1:
				if (m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd] && !HasSpellCooldown(m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd]))
					CastSpell(target, m_charmAISpells[SPELL_HIGH_DAMAGE1 + rnd], false);
				break;
			case 2:
				if (m_charmAISpells[SPELL_DOT_DAMAGE] && !HasSpellCooldown(m_charmAISpells[SPELL_DOT_DAMAGE]))
					CastSpell(target, m_charmAISpells[SPELL_DOT_DAMAGE], false);
				break;
			}
		}
	}
}

uint32 Player::GetRuneBaseCooldown(uint8 index, bool skipGrace)
{
	uint8 rune = GetBaseRune(index);
	uint32 cooldown = RUNE_BASE_COOLDOWN;
	if (!skipGrace)
		cooldown -= GetGracePeriod(index) < 250 ? 0 : GetGracePeriod(index) - 250;    // xinef: reduce by grace period, treat first 250ms as instant use of rune

	AuraEffectList const& regenAura = GetAuraEffectsByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
	for (AuraEffectList::const_iterator i = regenAura.begin(); i != regenAura.end(); ++i)
	{
		if ((*i)->GetMiscValue() == POWER_RUNE && (*i)->GetMiscValueB() == rune)
			cooldown = cooldown*(100 - (*i)->GetAmount()) / 100;
	}

	return cooldown;
}

void Player::RemoveRunesByAuraEffect(AuraEffect const* aura)
{
	for (uint8 i = 0; i < MAX_RUNES; ++i)
	{
		if (m_runes->runes[i].ConvertAura == aura)
		{
			ConvertRune(i, GetBaseRune(i));
			SetRuneConvertAura(i, NULL);
		}
	}
}

void Player::RestoreBaseRune(uint8 index)
{
	AuraEffect const* aura = m_runes->runes[index].ConvertAura;
	// If rune was converted by a non-pasive aura that still active we should keep it converted
	if (aura && !aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_PASSIVE))
		return;
	ConvertRune(index, GetBaseRune(index));
	SetRuneConvertAura(index, NULL);
	// Don't drop passive talents providing rune convertion
	if (!aura || aura->GetAuraType() != SPELL_AURA_CONVERT_RUNE)
		return;
	for (uint8 i = 0; i < MAX_RUNES; ++i)
	{
		if (aura == m_runes->runes[i].ConvertAura)
			return;
	}
	aura->GetBase()->Remove();
}

void Player::ConvertRune(uint8 index, RuneType newType)
{
	SetCurrentRune(index, newType);

	WorldPacket data(SMSG_CONVERT_RUNE, 2);
	data << uint8(index);
	data << uint8(newType);
	GetSession()->SendPacket(&data);
}

void Player::ResyncRunes(uint8 count)
{
	WorldPacket data(SMSG_RESYNC_RUNES, 4 + count * 2);
	data << uint32(count);
	for (uint32 i = 0; i < count; ++i)
	{
		data << uint8(GetCurrentRune(i));                   // rune type
		data << uint8(255 - (GetRuneCooldown(i) * 51));     // passed cooldown time (0-255)
	}
	GetSession()->SendPacket(&data);
}

void Player::AddRunePower(uint8 index)
{
	WorldPacket data(SMSG_ADD_RUNE_POWER, 4);
	data << uint32(1 << index);                             // mask (0x00-0x3F probably)
	GetSession()->SendPacket(&data);
}

static RuneType runeSlotTypes[MAX_RUNES] =
{
	/*0*/ RUNE_BLOOD,
	/*1*/ RUNE_BLOOD,
	/*2*/ RUNE_UNHOLY,
	/*3*/ RUNE_UNHOLY,
	/*4*/ RUNE_FROST,
	/*5*/ RUNE_FROST
};

void Player::InitRunes()
{
	if (getClass() != CLASS_DEATH_KNIGHT)
		return;

	m_runes = new Runes;

	m_runes->runeState = 0;
	m_runes->lastUsedRune = RUNE_BLOOD;

	for (uint8 i = 0; i < MAX_RUNES; ++i)
	{
		SetBaseRune(i, runeSlotTypes[i]);                              // init base types
		SetCurrentRune(i, runeSlotTypes[i]);                           // init current types
		SetRuneCooldown(i, 0);                                         // reset cooldowns
		SetGracePeriod(i, 0);                                          // xinef: reset grace period
		SetRuneConvertAura(i, NULL);
		m_runes->SetRuneState(i);
	}

	for (uint8 i = 0; i < NUM_RUNE_TYPES; ++i)
		SetFloatValue(PLAYER_RUNE_REGEN_1 + i, 0.1f);
}

bool Player::IsBaseRuneSlotsOnCooldown(RuneType runeType) const
{
	for (uint8 i = 0; i < MAX_RUNES; ++i)
		if (GetBaseRune(i) == runeType && GetRuneCooldown(i) == 0)
			return false;

	return true;
}

void Player::AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast)
{
	Loot loot;
	loot.FillLoot(loot_id, store, this, true);

	uint32 max_slot = loot.GetMaxSlotInLootFor(this);
	for (uint32 i = 0; i < max_slot; ++i)
	{
		LootItem* lootItem = loot.LootItemInSlot(i, this);

		ItemPosCountVec dest;
		InventoryResult msg = CanStoreNewItem(bag, slot, dest, lootItem->itemid, lootItem->count);
		if (msg != EQUIP_ERR_OK && slot != NULL_SLOT)
			msg = CanStoreNewItem(bag, NULL_SLOT, dest, lootItem->itemid, lootItem->count);
		if (msg != EQUIP_ERR_OK && bag != NULL_BAG)
			msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, lootItem->itemid, lootItem->count);
		if (msg != EQUIP_ERR_OK)
		{
			SendEquipError(msg, NULL, NULL, lootItem->itemid);
			continue;
		}

		Item* pItem = StoreNewItem(dest, lootItem->itemid, true, lootItem->randomPropertyId);
		SendNewItem(pItem, lootItem->count, false, false, broadcast);
	}
}

void Player::StoreLootItem(uint8 lootSlot, Loot* loot)
{
	QuestItem* qitem = NULL;
	QuestItem* ffaitem = NULL;
	QuestItem* conditem = NULL;

	LootItem* item = loot->LootItemInSlot(lootSlot, this, &qitem, &ffaitem, &conditem);

	if (!item)
	{
		SendEquipError(EQUIP_ERR_ALREADY_LOOTED, NULL, NULL);
		return;
	}

	// Xinef: exploit protection, dont allow to loot normal items if player is not master loot
	// Xinef: only quest, ffa and conditioned items
	if (!IS_ITEM_GUID(GetLootGUID()) && GetGroup() && GetGroup()->GetLootMethod() == MASTER_LOOT && GetGUID() != GetGroup()->GetMasterLooterGuid())
		if (qitem == NULL && ffaitem == NULL && conditem == NULL)
		{
			SendLootRelease(GetLootGUID());
			return;
		}

	if (!item->AllowedForPlayer(this))
	{
		SendLootRelease(GetLootGUID());
		return;
	}

	// questitems use the blocked field for other purposes
	if (!qitem && item->is_blocked)
	{
		SendLootRelease(GetLootGUID());
		return;
	}

	// xinef: dont allow protected item to be looted by someone else
	if (item->rollWinnerGUID && item->rollWinnerGUID != GetGUID())
	{
		SendLootRelease(GetLootGUID());
		return;
	}

	ItemPosCountVec dest;
	InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->itemid, item->count);
	if (msg == EQUIP_ERR_OK)
	{
		AllowedLooterSet looters = item->GetAllowedLooters();
		Item* newitem = StoreNewItem(dest, item->itemid, true, item->randomPropertyId, looters);

		if (qitem)
		{
			qitem->is_looted = true;
			//freeforall is 1 if everyone's supposed to get the quest item.
			if (item->freeforall || loot->GetPlayerQuestItems().size() == 1)
				SendNotifyLootItemRemoved(lootSlot);
			else
				loot->NotifyQuestItemRemoved(qitem->index);
		}
		else
		{
			if (ffaitem)
			{
				//freeforall case, notify only one player of the removal
				ffaitem->is_looted = true;
				SendNotifyLootItemRemoved(lootSlot);
			}
			else
			{
				//not freeforall, notify everyone
				if (conditem)
					conditem->is_looted = true;
				loot->NotifyItemRemoved(lootSlot);
			}
		}

		//if only one person is supposed to loot the item, then set it to looted
		if (!item->freeforall)
			item->is_looted = true;

		--loot->unlootedCount;

		SendNewItem(newitem, uint32(item->count), false, false, true);
		UpdateLootAchievements(item, loot);

		// LootItem is being removed (looted) from the container, delete it from the DB.
		if (loot->containerId > 0)
			sLootItemStorage->RemoveStoredLootItem(loot->containerId, item->itemid, item->count);
	}
	else
		SendEquipError(msg, NULL, NULL, item->itemid);
}

void Player::UpdateLootAchievements(LootItem *item, Loot* loot)
{
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM, item->itemid, item->count);
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE, loot->loot_type, item->count);
	UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_EPIC_ITEM, item->itemid, item->count);
}

uint32 Player::CalculateTalentsPoints() const
{
	uint32 base_talent = getLevel() < 10 ? 0 : getLevel() - 9;

	if (getClass() != CLASS_DEATH_KNIGHT || GetMapId() != 609)
		return uint32(base_talent * sWorld->getRate(RATE_TALENT));

	uint32 talentPointsForLevel = getLevel() < 56 ? 0 : getLevel() - 55;
	talentPointsForLevel += m_questRewardTalentCount;

	if (talentPointsForLevel > base_talent)
		talentPointsForLevel = base_talent;

	return uint32(talentPointsForLevel * sWorld->getRate(RATE_TALENT));
}

bool Player::canFlyInZone(uint32 mapid, uint32 zone) const
{
	// continent checked in SpellInfo::CheckLocation at cast and area update
	uint32 v_map = GetVirtualMapForMapAndZone(mapid, zone);
	return v_map != 571 || HasSpell(54197); // 54197 = Cold Weather Flying
}

void Player::learnSpellHighRank(uint32 spellid)
{
	learnSpell(spellid);

	if (uint32 next = sSpellMgr->GetNextSpellInChain(spellid))
		learnSpellHighRank(next);
}

void Player::_LoadSkills(PreparedQueryResult result)
{
	//                                                           0      1      2
	// SetPQuery(PLAYER_LOGIN_QUERY_LOADSKILLS,          "SELECT skill, value, max FROM character_skills WHERE guid = '%u'", GUID_LOPART(m_guid));

	uint32 count = 0;
	if (result)
	{
		do
		{
			Field* fields = result->Fetch();
			uint16 skill = fields[0].GetUInt16();
			uint16 value = fields[1].GetUInt16();
			uint16 max = fields[2].GetUInt16();

			SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(skill);
			if (!pSkill)
			{
				sLog->outError("Character %u has skill %u that does not exist.", GetGUIDLow(), skill);
				continue;
			}

			// set fixed skill ranges
			switch (GetSkillRangeType(pSkill, false))
			{
			case SKILL_RANGE_LANGUAGE:                      // 300..300
				value = max = 300;
				break;
			case SKILL_RANGE_MONO:                          // 1..1, grey monolite bar
				value = max = 1;
				break;
			default:
				break;
			}
			if (value == 0)
			{
				sLog->outError("Character %u has skill %u with value 0. Will be deleted.", GetGUIDLow(), skill);

				PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER_SKILL);

				stmt->setUInt32(0, GetGUIDLow());
				stmt->setUInt16(1, skill);

				CharacterDatabase.Execute(stmt);

				continue;
			}

			// enable unlearn button for primary professions only
			if (pSkill->categoryId == SKILL_CATEGORY_PROFESSION)
				SetUInt32Value(PLAYER_SKILL_INDEX(count), MAKE_PAIR32(skill, 1));
			else
				SetUInt32Value(PLAYER_SKILL_INDEX(count), MAKE_PAIR32(skill, 0));

			SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(count), MAKE_SKILL_VALUE(value, max));
			SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(count), 0);

			mSkillStatus.insert(SkillStatusMap::value_type(skill, SkillStatusData(count, SKILL_UNCHANGED)));

			learnSkillRewardedSpells(skill, value);

			++count;

			if (count >= PLAYER_MAX_SKILLS)                      // client limit
			{
				sLog->outError("Character %u has more than %u skills.", GetGUIDLow(), PLAYER_MAX_SKILLS);
				break;
			}
		} while (result->NextRow());
	}

	for (; count < PLAYER_MAX_SKILLS; ++count)
	{
		SetUInt32Value(PLAYER_SKILL_INDEX(count), 0);
		SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(count), 0);
		SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(count), 0);
	}

	// special settings
	if (getClass() == CLASS_DEATH_KNIGHT)
	{
		uint8 base_level = std::min(getLevel(), uint8(sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL)));
		if (base_level < 1)
			base_level = 1;
		uint16 base_skill = (base_level - 1) * 5;               // 270 at starting level 55
		if (base_skill < 1)
			base_skill = 1;                                 // skill mast be known and then > 0 in any case

		if (GetPureSkillValue(SKILL_FIRST_AID) < base_skill)
			SetSkill(SKILL_FIRST_AID, 4 /*artisan*/, base_skill, 300);
		if (GetPureSkillValue(SKILL_AXES) < base_skill)
			SetSkill(SKILL_AXES, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_DEFENSE) < base_skill)
			SetSkill(SKILL_DEFENSE, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_POLEARMS) < base_skill)
			SetSkill(SKILL_POLEARMS, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_SWORDS) < base_skill)
			SetSkill(SKILL_SWORDS, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_2H_AXES) < base_skill)
			SetSkill(SKILL_2H_AXES, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_2H_SWORDS) < base_skill)
			SetSkill(SKILL_2H_SWORDS, 0, base_skill, base_skill);
		if (GetPureSkillValue(SKILL_UNARMED) < base_skill)
			SetSkill(SKILL_UNARMED, 0, base_skill, base_skill);
	}
}

uint32 Player::GetPhaseMaskForSpawn() const
{
	uint32 phase = PHASEMASK_NORMAL;
	if (!IsGameMaster())
		phase = GetPhaseMask();
	else
	{
		AuraEffectList const& phases = GetAuraEffectsByType(SPELL_AURA_PHASE);
		if (!phases.empty())
			phase = phases.front()->GetMiscValue();
	}

	// some aura phases include 1 normal map in addition to phase itself
	if (uint32 n_phase = phase & ~PHASEMASK_NORMAL)
		return n_phase;

	return PHASEMASK_NORMAL;
}

InventoryResult Player::CanEquipUniqueItem(Item* pItem, uint8 eslot, uint32 limit_count) const
{
	ItemTemplate const* pProto = pItem->GetTemplate();

	// proto based limitations
	if (InventoryResult res = CanEquipUniqueItem(pProto, eslot, limit_count))
		return res;

	// check unique-equipped on gems
	for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT + 3; ++enchant_slot)
	{
		uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
		if (!enchant_id)
			continue;
		SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
		if (!enchantEntry)
			continue;

		ItemTemplate const* pGem = sObjectMgr->GetItemTemplate(enchantEntry->GemID);
		if (!pGem)
			continue;

		// include for check equip another gems with same limit category for not equipped item (and then not counted)
		uint32 gem_limit_count = !pItem->IsEquipped() && pGem->ItemLimitCategory
			? pItem->GetGemCountWithLimitCategory(pGem->ItemLimitCategory) : 1;

		if (InventoryResult res = CanEquipUniqueItem(pGem, eslot, gem_limit_count))
			return res;
	}

	return EQUIP_ERR_OK;
}

InventoryResult Player::CanEquipUniqueItem(ItemTemplate const* itemProto, uint8 except_slot, uint32 limit_count) const
{
	// check unique-equipped on item
	if (itemProto->Flags & ITEM_PROTO_FLAG_UNIQUE_EQUIPPED)
	{
		// there is an equip limit on this item
		if (HasItemOrGemWithIdEquipped(itemProto->ItemId, 1, except_slot))
			return EQUIP_ERR_ITEM_UNIQUE_EQUIPABLE;
	}

	// check unique-equipped limit
	if (itemProto->ItemLimitCategory)
	{
		ItemLimitCategoryEntry const* limitEntry = sItemLimitCategoryStore.LookupEntry(itemProto->ItemLimitCategory);
		if (!limitEntry)
			return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

		// NOTE: limitEntry->mode not checked because if item have have-limit then it applied and to equip case

		if (limit_count > limitEntry->maxCount)
			return EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_EQUIPPED_EXCEEDED;

		// there is an equip limit on this item
		if (HasItemOrGemWithLimitCategoryEquipped(itemProto->ItemLimitCategory, limitEntry->maxCount - limit_count + 1, except_slot))
			return EQUIP_ERR_ITEM_MAX_COUNT_EQUIPPED_SOCKETED;
	}

	return EQUIP_ERR_OK;
}

void Player::HandleFall(MovementInfo const& movementInfo)
{
	// calculate total z distance of the fall
	float z_diff = m_lastFallZ - movementInfo.pos.GetPositionZ();
	//sLog->outDebug("zDiff = %f", z_diff);

	//Players with low fall distance, Feather Fall or physical immunity (charges used) are ignored
	// 14.57 can be calculated by resolving damageperc formula below to 0
	if (z_diff >= 14.57f && !isDead() && !IsGameMaster() &&
		!HasAuraType(SPELL_AURA_HOVER) && !HasAuraType(SPELL_AURA_FEATHER_FALL) &&
		!HasAuraType(SPELL_AURA_FLY))
	{
		//Safe fall, fall height reduction
		int32 safe_fall = GetTotalAuraModifier(SPELL_AURA_SAFE_FALL);

		float damageperc = 0.018f*(z_diff - safe_fall) - 0.2426f;
		uint32 original_health = GetHealth(), final_damage = 0;

		if (damageperc > 0 && !IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_NORMAL))
		{
			uint32 damage = (uint32)(damageperc * GetMaxHealth()*sWorld->getRate(RATE_DAMAGE_FALL));

			//float height = movementInfo.pos.m_positionZ;
			//UpdateGroundPositionZ(movementInfo.pos.m_positionX, movementInfo.pos.m_positionY, height);

			if (damage > 0)
			{
				//Prevent fall damage from being more than the player maximum health
				if (damage > GetMaxHealth())
					damage = GetMaxHealth();

				// Gust of Wind
				if (HasAura(43621))
					damage = GetMaxHealth() / 2;

				final_damage = EnvironmentalDamage(DAMAGE_FALL, damage);
			}

			//Z given by moveinfo, LastZ, FallTime, WaterZ, MapZ, Damage, Safefall reduction
			;//sLog->outStaticDebug("FALLDAMAGE z=%f sz=%f pZ=%f FallTime=%d mZ=%f damage=%d SF=%d", movementInfo.pos.GetPositionZ(), height, GetPositionZ(), movementInfo.fallTime, height, damage, safe_fall);
		}

		// recheck alive, might have died of EnvironmentalDamage, avoid cases when player die in fact like Spirit of Redemption case
		if (IsAlive() && final_damage < original_health)
			UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING, uint32(z_diff * 100));
	}
}

void Player::CheckAllAchievementCriteria()
{
	m_achievementMgr->CheckAllAchievementCriteria();
}

void Player::ResetAchievements()
{
	m_achievementMgr->Reset();
}

void Player::SendRespondInspectAchievements(Player* player) const
{
	m_achievementMgr->SendRespondInspectAchievements(player);
}

bool Player::HasAchieved(uint32 achievementId) const
{
	return m_achievementMgr->HasAchieved(achievementId);
}

void Player::StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost/* = 0*/)
{
	m_achievementMgr->StartTimedAchievement(type, entry, timeLost);
}

void Player::RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
	m_achievementMgr->RemoveTimedAchievement(type, entry);
}

void Player::ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete /* = false*/)
{
	m_achievementMgr->ResetAchievementCriteria(condition, value, evenIfCriteriaComplete);
}

void Player::UpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 /*= 0*/, uint32 miscValue2 /*= 0*/, Unit* unit /*= NULL*/)
{
	m_achievementMgr->UpdateAchievementCriteria(type, miscValue1, miscValue2, unit);
}

void Player::CompletedAchievement(AchievementEntry const* entry)
{
	m_achievementMgr->CompletedAchievement(entry);
}

void Player::LearnTalent(uint32 talentId, uint32 talentRank)
{
	uint32 CurTalentPoints = GetFreeTalentPoints();

	// xinef: check basic data
	if (CurTalentPoints == 0)
		return;

	if (talentRank >= MAX_TALENT_RANK)
		return;

	TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
	if (!talentInfo)
		return;

	TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
	if (!talentTabInfo)
		return;

	// xinef: prevent learn talent for different class (cheating)
	if ((getClassMask() & talentTabInfo->ClassMask) == 0)
		return;

	// xinef: find current talent rank
	uint32 currentTalentRank = 0;
	for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
	{
		if (talentInfo->RankID[rank] && HasTalent(talentInfo->RankID[rank], GetActiveSpec()))
		{
			currentTalentRank = rank + 1;
			break;
		}
	}

	// xinef: we already have same or higher rank talent learned
	if (currentTalentRank >= talentRank + 1)
		return;

	// xinef: check if we have enough free talent points
	uint32 talentPointsChange = (talentRank - currentTalentRank + 1);
	if (CurTalentPoints < talentPointsChange)
		return;

	// xinef: check if talent deponds on another talent
	if (talentInfo->DependsOn > 0)
		if (TalentEntry const* depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn))
		{
			bool hasEnoughRank = false;
			for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
			{
				if (depTalentInfo->RankID[rank] != 0)
					if (HasTalent(depTalentInfo->RankID[rank], GetActiveSpec()))
					{
						hasEnoughRank = true;
						break;
					}
			}

			// xinef: does not have enough talent points spend in required talent
			if (!hasEnoughRank)
				return;
		}

	// xinef: check amount of points spent in current talent tree
	// xinef: be smart and quick, not retarded like TC
	uint32 spentPoints = 0;
	if (talentInfo->Row > 0)
	{
		const PlayerTalentMap& talentMap = GetTalentMap();
		for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
			if (TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first))
				if (TalentEntry const* itrTalentInfo = sTalentStore.LookupEntry(talentPos->talent_id))
					if (itrTalentInfo->TalentTab == talentInfo->TalentTab)
						if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec())) // pussywizard
							spentPoints += talentPos->rank + 1;
	}

	// xinef: we do not have enough talent points to add talent of this tier
	if (spentPoints < (talentInfo->Row * MAX_TALENT_RANK))
		return;

	// xinef: hacking attempt, tries to learn unknown rank
	uint32 spellId = talentInfo->RankID[talentRank];
	if (spellId == 0)
		return;

	const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(spellId);
	if (!spellInfo)
		return;

	bool learned = false;

	// xinef: if talent info has special marker in dbc - add to spell book
	if (talentInfo->addToSpellBook)
		if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
		{
			learnSpell(spellId);
			learned = true;
		}

	if (!learned)
		SendLearnPacket(spellId, true);

	for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
		if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
			if (sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
				learnSpell(spellInfo->Effects[i].TriggerSpell);

	addTalent(spellId, GetActiveSpecMask(), currentTalentRank);

	// xinef: update free talent points count
	m_usedTalentCount += talentPointsChange;
	SetFreeTalentPoints(CurTalentPoints - talentPointsChange);
}

void Player::LearnPetTalent(uint64 petGuid, uint32 talentId, uint32 talentRank)
{
	Pet* pet = GetPet();

	if (!pet)
		return;

	if (petGuid != pet->GetGUID())
		return;

	uint32 CurTalentPoints = pet->GetFreeTalentPoints();

	if (CurTalentPoints == 0)
		return;

	if (talentRank >= MAX_PET_TALENT_RANK)
		return;

	TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);

	if (!talentInfo)
		return;

	TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);

	if (!talentTabInfo)
		return;

	CreatureTemplate const* ci = pet->GetCreatureTemplate();

	if (!ci)
		return;

	CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ci->family);

	if (!pet_family)
		return;

	if (pet_family->petTalentType < 0)                       // not hunter pet
		return;

	// prevent learn talent for different family (cheating)
	if (!((1 << pet_family->petTalentType) & talentTabInfo->petTalentMask))
		return;

	// find current max talent rank (0~5)
	uint8 curtalent_maxrank = 0; // 0 = not learned any rank
	for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
	{
		if (talentInfo->RankID[rank] && pet->HasSpell(talentInfo->RankID[rank]))
		{
			curtalent_maxrank = (rank + 1);
			break;
		}
	}

	// we already have same or higher talent rank learned
	if (curtalent_maxrank >= (talentRank + 1))
		return;

	// check if we have enough talent points
	if (CurTalentPoints < (talentRank - curtalent_maxrank + 1))
		return;

	// Check if it requires another talent
	if (talentInfo->DependsOn > 0)
	{
		if (TalentEntry const* depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn))
		{
			bool hasEnoughRank = false;
			for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
			{
				if (depTalentInfo->RankID[rank] != 0)
					if (pet->HasSpell(depTalentInfo->RankID[rank]))
						hasEnoughRank = true;
			}
			if (!hasEnoughRank)
				return;
		}
	}

	// Find out how many points we have in this field
	uint32 spentPoints = 0;

	uint32 tTab = talentInfo->TalentTab;
	if (talentInfo->Row > 0)
	{
		uint32 numRows = sTalentStore.GetNumRows();
		for (uint32 i = 0; i < numRows; ++i)          // Loop through all talents.
		{
			// Someday, someone needs to revamp
			const TalentEntry* tmpTalent = sTalentStore.LookupEntry(i);
			if (tmpTalent)                                  // the way talents are tracked
			{
				if (tmpTalent->TalentTab == tTab)
				{
					for (uint8 rank = 0; rank < MAX_TALENT_RANK; rank++)
					{
						if (tmpTalent->RankID[rank] != 0)
						{
							if (pet->HasSpell(tmpTalent->RankID[rank]))
							{
								spentPoints += (rank + 1);
							}
						}
					}
				}
			}
		}
	}

	// not have required min points spent in talent tree
	if (spentPoints < (talentInfo->Row * MAX_PET_TALENT_RANK))
		return;

	// spell not set in talent.dbc
	uint32 spellid = talentInfo->RankID[talentRank];
	if (spellid == 0)
	{
		sLog->outError("Talent.dbc have for talent: %u Rank: %u spell id = 0", talentId, talentRank);
		return;
	}

	// already known
	if (pet->HasSpell(spellid))
		return;

	// learn! (other talent ranks will unlearned at learning)
	pet->learnSpell(spellid);
	;//sLog->outDetail("PetTalentID: %u Rank: %u Spell: %u\n", talentId, talentRank, spellid);

	// update free talent points
	pet->SetFreeTalentPoints(CurTalentPoints - (talentRank - curtalent_maxrank + 1));
}

void Player::AddKnownCurrency(uint32 itemId)
{
	if (CurrencyTypesEntry const* ctEntry = sCurrencyTypesStore.LookupEntry(itemId))
		SetFlag64(PLAYER_FIELD_KNOWN_CURRENCIES, (1LL << (ctEntry->BitIndex - 1)));
}

void Player::UpdateFallInformationIfNeed(MovementInfo const& minfo, uint16 opcode)
{
	if (m_lastFallTime >= minfo.fallTime || m_lastFallZ <= minfo.pos.GetPositionZ() || opcode == MSG_MOVE_FALL_LAND)
		SetFallInformation(minfo.fallTime, minfo.pos.GetPositionZ());
}

void Player::UnsummonPetTemporaryIfAny()
{
	Pet* pet = GetPet();
	if (!pet || !pet->IsInWorld())
		return;

	if (!m_temporaryUnsummonedPetNumber && pet->isControlled() && !pet->isTemporarySummoned())
	{
		m_temporaryUnsummonedPetNumber = pet->GetCharmInfo()->GetPetNumber();
		SetLastPetSpell(pet->GetUInt32Value(UNIT_CREATED_BY_SPELL));
	}

	RemovePet(pet, PET_SAVE_AS_CURRENT);
}

void Player::ResummonPetTemporaryUnSummonedIfAny()
{
	if (!m_temporaryUnsummonedPetNumber || IsSpectator())
		return;

	// not resummon in not appropriate state
	if (IsPetNeedBeTemporaryUnsummoned())
		return;

	if (GetPetGUID())
		return;

	if (!CanResummonPet(GetLastPetSpell()))
		return;

	Pet::LoadPetFromDB(this, PET_LOAD_SUMMON_PET, 0, m_temporaryUnsummonedPetNumber, true);
	//m_temporaryUnsummonedPetNumber = 0;
}

bool Player::CanResummonPet(uint32 spellid)
{
	if (getClass() == CLASS_DEATH_KNIGHT)
	{
		if (CanSeeDKPet())
			return true;
		else if (spellid == 52150)
			return false;
	}
	else if (getClass() == CLASS_HUNTER || getClass() == CLASS_MAGE)
		return true;

	if (!HasSpell(spellid))
		return false;

	return true;
}

bool Player::CanSeeSpellClickOn(Creature const* c) const
{
	if (!c->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK))
		return false;

	SpellClickInfoMapBounds clickPair = sObjectMgr->GetSpellClickInfoMapBounds(c->GetEntry());
	if (clickPair.first == clickPair.second)
		return true;

	for (SpellClickInfoContainer::const_iterator itr = clickPair.first; itr != clickPair.second; ++itr)
	{
		if (!itr->second.IsFitToRequirements(this, c))
			return false;

		ConditionList conds = sConditionMgr->GetConditionsForSpellClickEvent(c->GetEntry(), itr->second.spellId);
		ConditionSourceInfo info = ConditionSourceInfo(const_cast<Player*>(this), const_cast<Creature*>(c));
		if (sConditionMgr->IsObjectMeetToConditions(info, conds))
			return true;
	}

	return false;
}

void Player::BuildPlayerTalentsInfoData(WorldPacket* data)
{
	*data << uint32(GetFreeTalentPoints());                 // unspentTalentPoints
	*data << uint8(m_specsCount);                           // talent group count (0, 1 or 2)
	*data << uint8(m_activeSpec);                           // talent group index (0 or 1)

	if (m_specsCount > MAX_TALENT_SPECS)
		m_specsCount = MAX_TALENT_SPECS;

	for (uint32 specIdx = 0; specIdx < m_specsCount; ++specIdx)
	{
		uint8 talentIdCount = 0;
		size_t pos = data->wpos();
		*data << uint8(talentIdCount);                      // [PH], talentIdCount

		const PlayerTalentMap& talentMap = GetTalentMap();
		for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
			if (TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first))
				if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(specIdx)) // pussywizard
				{
					*data << uint32(talentPos->talent_id);  // Talent.dbc
					*data << uint8(talentPos->rank);        // talentMaxRank (0-4)
					++talentIdCount;
				}

		data->put<uint8>(pos, talentIdCount);               // put real count

		*data << uint8(MAX_GLYPH_SLOT_INDEX);               // glyphs count

		for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
			*data << uint16(m_Glyphs[specIdx][i]);          // GlyphProperties.dbc
	}
}

void Player::BuildPetTalentsInfoData(WorldPacket* data)
{
	uint32 unspentTalentPoints = 0;
	size_t pointsPos = data->wpos();
	*data << uint32(unspentTalentPoints);                   // [PH], unspentTalentPoints

	uint8 talentIdCount = 0;
	size_t countPos = data->wpos();
	*data << uint8(talentIdCount);                          // [PH], talentIdCount

	Pet* pet = GetPet();
	if (!pet)
		return;

	unspentTalentPoints = pet->GetFreeTalentPoints();

	data->put<uint32>(pointsPos, unspentTalentPoints);      // put real points

	CreatureTemplate const* ci = pet->GetCreatureTemplate();
	if (!ci)
		return;

	CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ci->family);
	if (!pet_family || pet_family->petTalentType < 0)
		return;

	for (uint32 talentTabId = 1; talentTabId < sTalentTabStore.GetNumRows(); ++talentTabId)
	{
		TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentTabId);
		if (!talentTabInfo)
			continue;

		if (!((1 << pet_family->petTalentType) & talentTabInfo->petTalentMask))
			continue;

		for (uint32 talentId = 0; talentId < sTalentStore.GetNumRows(); ++talentId)
		{
			TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
			if (!talentInfo)
				continue;

			// skip another tab talents
			if (talentInfo->TalentTab != talentTabId)
				continue;

			// find max talent rank (0~4)
			int8 curtalent_maxrank = -1;
			for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
			{
				if (talentInfo->RankID[rank] && pet->HasSpell(talentInfo->RankID[rank]))
				{
					curtalent_maxrank = rank;
					break;
				}
			}

			// not learned talent
			if (curtalent_maxrank < 0)
				continue;

			*data << uint32(talentInfo->TalentID);          // Talent.dbc
			*data << uint8(curtalent_maxrank);              // talentMaxRank (0-4)

			++talentIdCount;
		}

		data->put<uint8>(countPos, talentIdCount);          // put real count

		break;
	}
}

void Player::SendTalentsInfoData(bool pet)
{
	WorldPacket data(SMSG_TALENTS_INFO, 50);
	data << uint8(pet ? 1 : 0);
	if (pet)
		BuildPetTalentsInfoData(&data);
	else
		BuildPlayerTalentsInfoData(&data);
	GetSession()->SendPacket(&data);
}

void Player::BuildEnchantmentsInfoData(WorldPacket* data)
{
	uint32 slotUsedMask = 0;
	size_t slotUsedMaskPos = data->wpos();
	*data << uint32(slotUsedMask);                          // slotUsedMask < 0x80000

	for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
	{
		Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i);

		if (!item)
			continue;

		slotUsedMask |= (1 << i);

		*data << uint32(item->GetEntry());                  // item entry

		uint16 enchantmentMask = 0;
		size_t enchantmentMaskPos = data->wpos();
		*data << uint16(enchantmentMask);                   // enchantmentMask < 0x1000

		for (uint32 j = 0; j < MAX_ENCHANTMENT_SLOT; ++j)
		{
			uint32 enchId = item->GetEnchantmentId(EnchantmentSlot(j));

			if (!enchId)
				continue;

			enchantmentMask |= (1 << j);

			*data << uint16(enchId);                        // enchantmentId?
		}

		data->put<uint16>(enchantmentMaskPos, enchantmentMask);

		*data << uint16(0);                                 // unknown
		data->appendPackGUID(item->GetUInt64Value(ITEM_FIELD_CREATOR)); // item creator
		*data << uint32(0);                                 // seed?
	}

	data->put<uint32>(slotUsedMaskPos, slotUsedMask);
}

void Player::SendEquipmentSetList()
{
	uint32 count = 0;
	WorldPacket data(SMSG_EQUIPMENT_SET_LIST, 4);
	size_t count_pos = data.wpos();
	data << uint32(count);                                  // count placeholder
	for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
	{
		if (itr->second.state == EQUIPMENT_SET_DELETED)
			continue;

		data.appendPackGUID(itr->second.Guid);
		data << uint32(itr->first);
		data << itr->second.Name;
		data << itr->second.IconName;
		for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
		{
			// ignored slots stored in IgnoreMask, client wants "1" as raw GUID, so no HIGHGUID_ITEM
			if (itr->second.IgnoreMask & (1 << i))
				data.appendPackGUID(uint64(1));
			else // xinef: send proper data (do not append 0 with high guid)
				data.appendPackGUID(itr->second.Items[i] > 0 ? MAKE_NEW_GUID(itr->second.Items[i], 0, HIGHGUID_ITEM) : uint64(0));
		}

		++count;                                            // client have limit but it checked at loading and set
	}
	data.put<uint32>(count_pos, count);
	GetSession()->SendPacket(&data);
}

void Player::SetEquipmentSet(uint32 index, EquipmentSet eqset)
{
	if (eqset.Guid != 0)
	{
		bool found = false;

		for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
		{
			if ((itr->second.Guid == eqset.Guid) && (itr->first == index))
			{
				found = true;
				break;
			}
		}

		if (!found)                                          // something wrong...
		{
			sLog->outError("Player %s tried to save equipment set " UI64FMTD " (index %u), but that equipment set not found!", GetName().c_str(), eqset.Guid, index);
			return;
		}
	}

	EquipmentSet& eqslot = m_EquipmentSets[index];

	EquipmentSetUpdateState old_state = eqslot.state;

	eqslot = eqset;

	if (eqset.Guid == 0)
	{
		eqslot.Guid = sObjectMgr->GenerateEquipmentSetGuid();

		WorldPacket data(SMSG_EQUIPMENT_SET_SAVED, 4 + 1);
		data << uint32(index);
		data.appendPackGUID(eqslot.Guid);
		GetSession()->SendPacket(&data);
	}

	eqslot.state = old_state == EQUIPMENT_SET_NEW ? EQUIPMENT_SET_NEW : EQUIPMENT_SET_CHANGED;
}

void Player::_SaveEquipmentSets(SQLTransaction& trans)
{
	for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end();)
	{
		uint32 index = itr->first;
		EquipmentSet& eqset = itr->second;
		PreparedStatement* stmt = NULL;
		uint8 j = 0;
		switch (eqset.state)
		{
		case EQUIPMENT_SET_UNCHANGED:
			++itr;
			break;                                      // nothing do
		case EQUIPMENT_SET_CHANGED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_EQUIP_SET);
			stmt->setString(j++, eqset.Name.c_str());
			stmt->setString(j++, eqset.IconName.c_str());
			stmt->setUInt32(j++, eqset.IgnoreMask);
			for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
				stmt->setUInt32(j++, eqset.Items[i]);
			stmt->setUInt32(j++, GetGUIDLow());
			stmt->setUInt64(j++, eqset.Guid);
			stmt->setUInt32(j, index);
			trans->Append(stmt);
			eqset.state = EQUIPMENT_SET_UNCHANGED;
			++itr;
			break;
		case EQUIPMENT_SET_NEW:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_EQUIP_SET);
			stmt->setUInt32(j++, GetGUIDLow());
			stmt->setUInt64(j++, eqset.Guid);
			stmt->setUInt32(j++, index);
			stmt->setString(j++, eqset.Name.c_str());
			stmt->setString(j++, eqset.IconName.c_str());
			stmt->setUInt32(j++, eqset.IgnoreMask);
			for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
				stmt->setUInt32(j++, eqset.Items[i]);
			trans->Append(stmt);
			eqset.state = EQUIPMENT_SET_UNCHANGED;
			++itr;
			break;
		case EQUIPMENT_SET_DELETED:
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_EQUIP_SET);
			stmt->setUInt64(0, eqset.Guid);
			trans->Append(stmt);
			m_EquipmentSets.erase(itr++);
			break;
		}
	}
}

void Player::_SaveEntryPoint(SQLTransaction& trans)
{
	// xinef: dont save joinpos with invalid mapid
	MapEntry const* mEntry = sMapStore.LookupEntry(m_entryPointData.joinPos.GetMapId());
	if (!mEntry)
		return;

	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_ENTRY_POINT);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);
	stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_ENTRY_POINT);
	stmt->setUInt32(0, GetGUIDLow());
	stmt->setFloat(1, m_entryPointData.joinPos.GetPositionX());
	stmt->setFloat(2, m_entryPointData.joinPos.GetPositionY());
	stmt->setFloat(3, m_entryPointData.joinPos.GetPositionZ());
	stmt->setFloat(4, m_entryPointData.joinPos.GetOrientation());
	stmt->setUInt32(5, m_entryPointData.joinPos.GetMapId());

	std::ostringstream ss("");
	if (m_entryPointData.HasTaxiPath())
	{
		for (size_t i = 0; i < m_entryPointData.taxiPath.size(); ++i)
			ss << m_entryPointData.taxiPath[i] << ' '; // xinef: segment is stored as last point
	}

	stmt->setString(6, ss.str());
	stmt->setUInt32(7, m_entryPointData.mountSpell);
	trans->Append(stmt);
}

void Player::DeleteEquipmentSet(uint64 setGuid)
{
	for (EquipmentSets::iterator itr = m_EquipmentSets.begin(); itr != m_EquipmentSets.end(); ++itr)
	{
		if (itr->second.Guid == setGuid)
		{
			if (itr->second.state == EQUIPMENT_SET_NEW)
				m_EquipmentSets.erase(itr);
			else
				itr->second.state = EQUIPMENT_SET_DELETED;
			break;
		}
	}
}

void Player::RemoveAtLoginFlag(AtLoginFlags flags, bool persist /*= false*/)
{
	m_atLoginFlags &= ~flags;

	if (persist)
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REM_AT_LOGIN_FLAG);

		stmt->setUInt16(0, uint16(flags));
		stmt->setUInt32(1, GetGUIDLow());

		CharacterDatabase.Execute(stmt);
	}
}

void Player::SendClearCooldown(uint32 spell_id, Unit* target)
{
	WorldPacket data(SMSG_CLEAR_COOLDOWN, 4 + 8);
	data << uint32(spell_id);
	data << uint64(target->GetGUID());
	SendDirectMessage(&data);

	if (target == this && NeedSendSpectatorData())
		ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "RCD", spell_id);
}

void Player::ResetMap()
{
	// this may be called during Map::Update
	// after decrement+unlink, ++m_mapRefIter will continue correctly
	// when the first element of the list is being removed
	// nocheck_prev will return the padding element of the RefManager
	// instead of NULL in the case of prev
	GetMap()->UpdateIteratorBack(this);
	Unit::ResetMap();
	GetMapRef().unlink();
}

void Player::SetMap(Map* map)
{
	Unit::SetMap(map);
	m_mapRef.link(map, this);
}

void Player::_SaveCharacter(bool create, SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;
	uint8 index = 0;

	if (create)
	{
		//! Insert query
		//! TO DO: Filter out more redundant fields that can take their default value at player create
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER);
		stmt->setUInt32(index++, GetGUIDLow());
		stmt->setUInt32(index++, GetSession()->GetAccountId());
		stmt->setString(index++, GetName());
		stmt->setUInt8(index++, getRace(true));
		stmt->setUInt8(index++, getClass());
		stmt->setUInt8(index++, getGender());
		stmt->setUInt8(index++, getLevel());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_XP));
		stmt->setUInt32(index++, GetMoney());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_BYTES));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_BYTES_2));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FLAGS));
		stmt->setUInt16(index++, (uint16)GetMapId());
		stmt->setUInt32(index++, (uint32)GetInstanceId());
		stmt->setUInt8(index++, (uint8(GetDungeonDifficulty()) | uint8(GetRaidDifficulty()) << 4));
		stmt->setFloat(index++, finiteAlways(GetPositionX()));
		stmt->setFloat(index++, finiteAlways(GetPositionY()));
		stmt->setFloat(index++, finiteAlways(GetPositionZ()));
		stmt->setFloat(index++, finiteAlways(GetOrientation()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetX()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetY()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetZ()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetO()));
		uint32 transLowGUID = 0;
		if (GetTransport())
			transLowGUID = GetTransport()->GetGUIDLow();
		stmt->setUInt32(index++, transLowGUID);

		std::ostringstream ss;
		ss << m_taxi;
		stmt->setString(index++, ss.str());
		stmt->setUInt8(index++, m_cinematic);
		stmt->setUInt32(index++, m_Played_time[PLAYED_TIME_TOTAL]);
		stmt->setUInt32(index++, m_Played_time[PLAYED_TIME_LEVEL]);
		stmt->setFloat(index++, finiteAlways(_restBonus));
		stmt->setUInt32(index++, uint32(time(NULL)));
		stmt->setUInt8(index++, (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING) ? 1 : 0));
		//save, far from tavern/city
		//save, but in tavern/city
		stmt->setUInt32(index++, m_resetTalentsCost);
		stmt->setUInt32(index++, uint32(m_resetTalentsTime));
		stmt->setUInt16(index++, (uint16)m_ExtraFlags);
		stmt->setUInt8(index++, m_stableSlots);
		stmt->setUInt16(index++, (uint16)m_atLoginFlags);
		stmt->setUInt16(index++, GetZoneId(true));
		stmt->setUInt32(index++, uint32(m_deathExpireTime));

		ss.str("");
		ss << m_taxi.SaveTaxiDestinationsToString();

		stmt->setString(index++, ss.str());
		stmt->setUInt32(index++, GetArenaPoints());
		stmt->setUInt32(index++, GetHonorPoints());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
		stmt->setUInt16(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 0));
		stmt->setUInt16(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 1));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_CHOSEN_TITLE));
		stmt->setUInt64(index++, GetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX));
		stmt->setUInt8(index++, GetDrunkValue());
		stmt->setUInt32(index++, GetHealth());

		for (uint32 i = 0; i < MAX_POWERS; ++i)
			stmt->setUInt32(index++, GetPower(Powers(i)));

		stmt->setUInt32(index++, GetSession()->GetLatency());

		stmt->setUInt8(index++, m_specsCount);
		stmt->setUInt8(index++, m_activeSpec);

		ss.str("");
		for (uint32 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; ++i)
			ss << GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + i) << ' ';
		stmt->setString(index++, ss.str());

		ss.str("");
		// cache equipment...
		for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
			ss << GetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + i) << ' ';

		// ...and bags for enum opcode
		for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		{
			if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				ss << item->GetEntry();
			else
				ss << '0';
			ss << " 0 ";
		}

		stmt->setString(index++, ss.str());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_AMMO_ID));

		ss.str("");
		for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
			ss << GetUInt32Value(PLAYER__FIELD_KNOWN_TITLES + i) << ' ';

		stmt->setString(index++, ss.str());
		stmt->setUInt8(index++, GetByteValue(PLAYER_FIELD_BYTES, 2));
		stmt->setUInt32(index++, m_grantableLevels);
	}
	else
	{
		// Update query
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER);
		stmt->setString(index++, GetName());
		stmt->setUInt8(index++, getRace(true));
		stmt->setUInt8(index++, getClass());
		stmt->setUInt8(index++, getGender());
		stmt->setUInt8(index++, getLevel());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_XP));
		stmt->setUInt32(index++, GetMoney());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_BYTES));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_BYTES_2));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FLAGS));

		if (!IsBeingTeleported())
		{
			Difficulty dd = GetDungeonDifficulty(), rd = GetRaidDifficulty();
			if (Map* m = FindMap())
				if (m->IsDungeon())
				{
					if (m->IsNonRaidDungeon()) dd = m->GetDifficulty();
					else rd = m->GetDifficulty();
				}
			stmt->setUInt16(index++, (uint16)GetMapId());
			stmt->setUInt32(index++, (uint32)GetInstanceId());
			stmt->setUInt8(index++, (uint8(dd) | uint8(rd) << 4));
			stmt->setFloat(index++, finiteAlways(GetPositionX()));
			stmt->setFloat(index++, finiteAlways(GetPositionY()));
			stmt->setFloat(index++, finiteAlways(GetPositionZ()));
			stmt->setFloat(index++, finiteAlways(GetOrientation()));
		}
		else
		{
			stmt->setUInt16(index++, (uint16)GetTeleportDest().GetMapId());
			stmt->setUInt32(index++, (uint32)0);
			stmt->setUInt8(index++, (uint8(GetDungeonDifficulty()) | uint8(GetRaidDifficulty()) << 4));
			stmt->setFloat(index++, finiteAlways(GetTeleportDest().GetPositionX()));
			stmt->setFloat(index++, finiteAlways(GetTeleportDest().GetPositionY()));
			stmt->setFloat(index++, finiteAlways(GetTeleportDest().GetPositionZ()));
			stmt->setFloat(index++, finiteAlways(GetTeleportDest().GetOrientation()));
		}

		stmt->setFloat(index++, finiteAlways(GetTransOffsetX()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetY()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetZ()));
		stmt->setFloat(index++, finiteAlways(GetTransOffsetO()));
		uint32 transLowGUID = 0;
		if (GetTransport())
			transLowGUID = GetTransport()->GetGUIDLow();
		stmt->setUInt32(index++, transLowGUID);

		std::ostringstream ss;
		ss << m_taxi;
		stmt->setString(index++, ss.str());
		stmt->setUInt8(index++, m_cinematic);
		stmt->setUInt32(index++, m_Played_time[PLAYED_TIME_TOTAL]);
		stmt->setUInt32(index++, m_Played_time[PLAYED_TIME_LEVEL]);
		stmt->setFloat(index++, finiteAlways(_restBonus));
		stmt->setUInt32(index++, uint32(time(NULL)));
		stmt->setUInt8(index++, (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING) ? 1 : 0));
		//save, far from tavern/city
		//save, but in tavern/city
		stmt->setUInt32(index++, m_resetTalentsCost);
		stmt->setUInt32(index++, uint32(m_resetTalentsTime));
		stmt->setUInt16(index++, (uint16)m_ExtraFlags);
		stmt->setUInt8(index++, m_stableSlots);
		stmt->setUInt16(index++, (uint16)m_atLoginFlags);
		stmt->setUInt16(index++, GetZoneId(true));
		stmt->setUInt32(index++, uint32(m_deathExpireTime));

		ss.str("");
		ss << m_taxi.SaveTaxiDestinationsToString();

		stmt->setString(index++, ss.str());
		stmt->setUInt32(index++, GetArenaPoints());
		stmt->setUInt32(index++, GetHonorPoints());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
		stmt->setUInt16(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 0));
		stmt->setUInt16(index++, GetUInt16Value(PLAYER_FIELD_KILLS, 1));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_CHOSEN_TITLE));
		stmt->setUInt64(index++, GetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES));
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX));
		stmt->setUInt8(index++, GetDrunkValue());
		stmt->setUInt32(index++, GetHealth());

		for (uint32 i = 0; i < MAX_POWERS; ++i)
			stmt->setUInt32(index++, GetPower(Powers(i)));

		stmt->setUInt32(index++, GetSession()->GetLatency());

		stmt->setUInt8(index++, m_specsCount);
		stmt->setUInt8(index++, m_activeSpec);

		ss.str("");
		for (uint32 i = 0; i < PLAYER_EXPLORED_ZONES_SIZE; ++i)
			ss << GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + i) << ' ';
		stmt->setString(index++, ss.str());

		ss.str("");
		// cache equipment...
		for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
			ss << GetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + i) << ' ';

		// ...and bags for enum opcode
		for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		{
			if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
				ss << item->GetEntry();
			else
				ss << '0';
			ss << " 0 ";
		}

		stmt->setString(index++, ss.str());
		stmt->setUInt32(index++, GetUInt32Value(PLAYER_AMMO_ID));

		ss.str("");
		for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
			ss << GetUInt32Value(PLAYER__FIELD_KNOWN_TITLES + i) << ' ';

		stmt->setString(index++, ss.str());
		stmt->setUInt8(index++, GetByteValue(PLAYER_FIELD_BYTES, 2));
		stmt->setUInt32(index++, m_grantableLevels);

		stmt->setUInt8(index++, IsInWorld() && !GetSession()->PlayerLogout() ? 1 : 0);
		// Index
		stmt->setUInt32(index++, GetGUIDLow());
	}

	trans->Append(stmt);
}

void Player::_LoadGlyphs(PreparedQueryResult result)
{
	// SELECT talentGroup, glyph1, glyph2, glyph3, glyph4, glyph5, glyph6 from character_glyphs WHERE guid = '%u'
	if (!result)
		return;

	do
	{
		Field* fields = result->Fetch();

		uint8 spec = fields[0].GetUInt8();
		if (spec >= m_specsCount)
			continue;

		m_Glyphs[spec][0] = fields[1].GetUInt16();
		m_Glyphs[spec][1] = fields[2].GetUInt16();
		m_Glyphs[spec][2] = fields[3].GetUInt16();
		m_Glyphs[spec][3] = fields[4].GetUInt16();
		m_Glyphs[spec][4] = fields[5].GetUInt16();
		m_Glyphs[spec][5] = fields[6].GetUInt16();
	} while (result->NextRow());
}

void Player::_SaveGlyphs(SQLTransaction& trans)
{
	if (!NeedToSaveGlyphs())
		return;

	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_GLYPHS);
	stmt->setUInt32(0, GetGUIDLow());
	trans->Append(stmt);

	for (uint8 spec = 0; spec < m_specsCount; ++spec)
	{
		uint8 index = 0;

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_GLYPHS);
		stmt->setUInt32(index++, GetGUIDLow());
		stmt->setUInt8(index++, spec);

		for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
			stmt->setUInt16(index++, uint16(m_Glyphs[spec][i]));

		trans->Append(stmt);
	}
}

void Player::_LoadTalents(PreparedQueryResult result)
{
	// SetPQuery(PLAYER_LOGIN_QUERY_LOADTALENTS, "SELECT spell, specMask FROM character_talent WHERE guid = '%u'", GUID_LOPART(m_guid));
	if (result)
	{
		do
		{
			// xinef: checked
			uint32 spellId = (*result)[0].GetUInt32();
			uint8 specMask = (*result)[1].GetUInt8();
			addTalent(spellId, specMask, 0);
			TalentSpellPos const* talentPos = GetTalentSpellPos(spellId);
			ASSERT(talentPos);

			// xinef: increase used talent points count
			if (GetActiveSpecMask() & specMask)
				m_usedTalentCount += talentPos->rank + 1;
		} while (result->NextRow());
	}
}

void Player::_SaveTalents(SQLTransaction& trans)
{
	PreparedStatement* stmt = NULL;

	for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end();)
	{
		// xinef: skip temporary spells
		if (itr->second->State == PLAYERSPELL_TEMPORARY)
		{
			++itr;
			continue;
		}

		// xinef: delete statement for removed / updated talent
		if (itr->second->State == PLAYERSPELL_REMOVED || itr->second->State == PLAYERSPELL_CHANGED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_TALENT_BY_SPELL);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, itr->first);
			trans->Append(stmt);
		}

		// xinef: insert statement for new / updated spell
		if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_CHANGED)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_TALENT);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt32(1, itr->first);
			stmt->setUInt8(2, itr->second->specMask);
			trans->Append(stmt);
		}

		if (itr->second->State == PLAYERSPELL_REMOVED)
		{
			delete itr->second;
			m_talents.erase(itr++);
		}
		else
		{
			itr->second->State = PLAYERSPELL_UNCHANGED;
			++itr;
		}
	}
}

void Player::UpdateSpecCount(uint8 count)
{
	uint32 curCount = GetSpecsCount();
	if (curCount == count)
		return;

	if (m_activeSpec >= count)
		ActivateSpec(0);

	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = NULL;

	// Copy spec data
	if (count > curCount)
	{
		_SaveActions(trans); // make sure the button list is cleaned up
		for (ActionButtonList::iterator itr = m_actionButtons.begin(); itr != m_actionButtons.end(); ++itr)
		{
			stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACTION);
			stmt->setUInt32(0, GetGUIDLow());
			stmt->setUInt8(1, 1);
			stmt->setUInt8(2, itr->first);
			stmt->setUInt32(3, itr->second.GetAction());
			stmt->setUInt8(4, uint8(itr->second.GetType()));
			trans->Append(stmt);
		}
	}
	// Delete spec data for removed spec.
	else if (count < curCount)
	{
		_SaveActions(trans);

		stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACTION_EXCEPT_SPEC);
		stmt->setUInt8(0, m_activeSpec);
		stmt->setUInt32(1, GetGUIDLow());
		trans->Append(stmt);

		m_activeSpec = 0;
	}

	CharacterDatabase.CommitTransaction(trans);

	SetSpecsCount(count);

	SendTalentsInfoData(false);
}

void Player::ActivateSpec(uint8 spec)
{
	// xinef: some basic checks
	if (GetActiveSpec() == spec)
		return;

	if (spec > GetSpecsCount())
		return;

	// xinef: interrupt currently casted spell just in case
	if (IsNonMeleeSpellCast(false))
		InterruptNonMeleeSpells(false);

	// xinef: save current actions order
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	_SaveActions(trans);
	CharacterDatabase.CommitTransaction(trans);

	// xinef: remove pet, it will be resummoned later
	if (Pet* pet = GetPet())
		RemovePet(pet, PET_SAVE_NOT_IN_SLOT);

	// xinef: remove other summoned units and clear reactives
	ClearAllReactives();
	UnsummonAllTotems();
	RemoveAllControlled();

	// xinef: let client clear his current Actions
	SendActionButtons(2);
	uint8 oldSpec = GetActiveSpec();

	// xinef: reset talent auras
	for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		// xinef: remove all active talent auras
		if (!(itr->second->specMask & GetActiveSpecMask()))
			continue;

		_removeTalentAurasAndSpells(itr->first);

		// pussywizard: was => isn't
		if (!itr->second->IsInSpec(spec) && !itr->second->inSpellBook)
			SendLearnPacket(itr->first, false);
	}

	// xinef: remove glyph auras
	for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
		if (uint32 glyphId = m_Glyphs[GetActiveSpec()][slot])
			if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyphId))
				RemoveAurasDueToSpell(glyphEntry->SpellId);

	// xinef: set active spec as new one
	SetActiveSpec(spec);
	uint32 spentTalents = 0;

	// xinef: add talent auras
	for (PlayerTalentMap::iterator itr = m_talents.begin(); itr != m_talents.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		// xinef: talent not in new spec
		if (!(itr->second->specMask & GetActiveSpecMask()))
			continue;

		// pussywizard: wasn't => is
		if (!itr->second->IsInSpec(oldSpec) && !itr->second->inSpellBook)
			SendLearnPacket(itr->first, true);

		_addTalentAurasAndSpells(itr->first);
		TalentSpellPos const* talentPos = GetTalentSpellPos(itr->first);
		spentTalents += talentPos->rank + 1;
	}

	// pussywizard: remove spells that are in previous spec, but are not present in new one (or are in new spec, but not in the old one)
	for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
	{
		if (!itr->second->Active || itr->second->State == PLAYERSPELL_REMOVED)
			continue;

		// pussywizard: was => isn't
		if (itr->second->IsInSpec(oldSpec) && !itr->second->IsInSpec(spec))
			SendLearnPacket(itr->first, false);
		// pussywizard: wasn't => is
		else if (!itr->second->IsInSpec(oldSpec) && itr->second->IsInSpec(spec))
			SendLearnPacket(itr->first, true);
	}

	// xinef: apply glyphs from second spec
	for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
		if (uint32 glyphId = m_Glyphs[GetActiveSpec()][slot])
			if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyphId))
				CastSpell(this, glyphEntry->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK&~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)));

	m_usedTalentCount = spentTalents;
	InitTalentForLevel();

	// xinef: optimization, use callback to read the data
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ACTIONS_SPEC);
	stmt->setUInt32(0, GetGUIDLow());
	stmt->setUInt8(1, m_activeSpec);
	GetSession()->_loadActionsSwitchSpecCallback = CharacterDatabase.AsyncQuery(stmt); // FutureResult

	// xinef: reset power
	Powers pw = getPowerType();
	if (pw != POWER_MANA)
		SetPower(POWER_MANA, 0); // Mana must be 0 even if it isn't the active power type.
	SetPower(pw, 0);

	// xinef: remove titan grip if player had it set and does not have appropriate talent
	if (!HasTalent(46917, GetActiveSpec()) && m_canTitanGrip)
		SetCanTitanGrip(false);
	// xinef: remove dual wield if player does not have dual wield spell (shamans)
	if (!HasSpell(674) && m_canDualWield)
		SetCanDualWield(false);

	AutoUnequipOffhandIfNeed();

	// Xinef: Patch 3.2.0: Switching spec removes paladins spell Righteous Fury (25780)
	if (getClass() == CLASS_PALADIN)
		RemoveAurasDueToSpell(25780);

	// Xinef: Remove talented single target auras at other targets
	AuraList& scAuras = GetSingleCastAuras();
	for (AuraList::iterator iter = scAuras.begin(); iter != scAuras.end();)
	{
		Aura* aura = *iter;
		if (!HasActiveSpell(aura->GetId()) && !HasTalent(aura->GetId(), GetActiveSpec()))
		{
			aura->Remove();
			iter = scAuras.begin();
		}
		else
			++iter;
	}
}

void Player::GetTalentTreePoints(uint8(&specPoints)[3]) const
{
	const PlayerTalentMap& talentMap = GetTalentMap();
	for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
		if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec()))
			if (TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID))
				if (TalentTabEntry const* tab = sTalentTabStore.LookupEntry(talentInfo->TalentTab))
					if (tab->tabpage < 3)
					{
						// find current talent rank
						uint8 currentTalentRank = 0;
						for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
							if (talentInfo->RankID[rank] && itr->first == talentInfo->RankID[rank])
							{
								currentTalentRank = rank + 1;
								break;
							}
						specPoints[tab->tabpage] += currentTalentRank;
					}
}

uint8 Player::GetMostPointsTalentTree() const
{
	uint32 specPoints[3] = { 0, 0, 0 };
	const PlayerTalentMap& talentMap = GetTalentMap();
	for (PlayerTalentMap::const_iterator itr = talentMap.begin(); itr != talentMap.end(); ++itr)
		if (itr->second->State != PLAYERSPELL_REMOVED && itr->second->IsInSpec(GetActiveSpec()))
			if (TalentEntry const* talentInfo = sTalentStore.LookupEntry(itr->second->talentID))
				if (TalentTabEntry const* tab = sTalentTabStore.LookupEntry(talentInfo->TalentTab))
					if (tab->tabpage < 3)
					{
						// find current talent rank
						uint8 currentTalentRank = 0;
						for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
							if (talentInfo->RankID[rank] && itr->first == talentInfo->RankID[rank])
							{
								currentTalentRank = rank + 1;
								break;
							}
						specPoints[tab->tabpage] += currentTalentRank;
					}
	uint8 maxIndex = 0;
	uint8 maxCount = specPoints[0];
	for (uint8 i = 1; i < 3; ++i)
		if (specPoints[i] > maxCount)
		{
			maxIndex = i;
			maxCount = specPoints[i];
		}
	return maxIndex;
}

bool Player::IsHealerTalentSpec() const
{
	uint8 tree = GetMostPointsTalentTree();
	return (getClass() == CLASS_DRUID && tree == 2 || getClass() == CLASS_PALADIN && tree == 0 || getClass() == CLASS_PRIEST && tree <= 1 || getClass() == CLASS_SHAMAN && tree == 2);
}

void Player::ResetTimeSync()
{
	m_timeSyncCounter = 0;
	m_timeSyncTimer = 0;
	m_timeSyncClient = 0;
	m_timeSyncServer = World::GetGameTimeMS();
}

void Player::SendTimeSync()
{
	WorldPacket data(SMSG_TIME_SYNC_REQ, 4);
	data << uint32(m_timeSyncCounter++);
	GetSession()->SendPacket(&data);

	// Schedule next sync in 10 sec
	m_timeSyncTimer = 10000;
	m_timeSyncServer = World::GetGameTimeMS();
}

void Player::SetReputation(uint32 factionentry, uint32 value)
{
	GetReputationMgr().SetReputation(sFactionStore.LookupEntry(factionentry), value);
}
uint32 Player::GetReputation(uint32 factionentry) const
{
	return GetReputationMgr().GetReputation(sFactionStore.LookupEntry(factionentry));
}

std::string const& Player::GetGuildName()
{
	return sGuildMgr->GetGuildById(GetGuildId())->GetName();
}

void Player::SendDuelCountdown(uint32 counter)
{
	WorldPacket data(SMSG_DUEL_COUNTDOWN, 4);
	data << uint32(counter);                                // seconds
	GetSession()->SendPacket(&data);
}

void Player::SetIsSpectator(bool on)
{
	if (on)
	{
		AddAura(SPECTATOR_SPELL_SPEED, this);
		m_ExtraFlags |= PLAYER_EXTRA_SPECTATOR_ON;
		AddUnitState(UNIT_STATE_ISOLATED);
		//setFaction(1100);
		SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
		RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
		ResetContestedPvP();
		SetDisplayId(23691);
	}
	else
	{
		RemoveAurasDueToSpell(SPECTATOR_SPELL_SPEED);
		if (IsSpectator())
			ClearUnitState(UNIT_STATE_ISOLATED);
		m_ExtraFlags &= ~PLAYER_EXTRA_SPECTATOR_ON;
		RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
		RestoreDisplayId();

		if (!IsGameMaster())
		{
			//setFactionForRace(getRace());

			// restore FFA PvP Server state
			// Xinef: it will be removed if necessery in UpdateArea called in WorldPortOpcode
			if (sWorld->IsFFAPvPRealm())
				SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
		}
	}
}

bool Player::NeedSendSpectatorData() const
{
	if (FindMap() && FindMap()->IsBattleArena() && !IsSpectator())
	{
		Battleground* bg = ((BattlegroundMap*)FindMap())->GetBG();
		if (bg && bg->HaveSpectators() && bg->GetStatus() == STATUS_IN_PROGRESS && !bg->GetPlayers().empty())
			if (bg->GetPlayers().find(GetGUID()) != bg->GetPlayers().end())
				return true;
	}
	return false;
}

void Player::PrepareCharmAISpells()
{
	for (int i = 0; i < NUM_CAI_SPELLS; ++i)
		m_charmAISpells[i] = 0;

	uint32 damage_type[4] = { 0, 0, 0, 0 };
	uint32 stun_duration = 0;
	uint32 periodic_damage = 0;
	uint32 b = 0;
	uint32 temp_spell = 0;
	uint32 temp_damage = 0;

	for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
	{
		if (itr->second->State == PLAYERSPELL_REMOVED || !itr->second->Active || !itr->second->IsInSpec(GetActiveSpec()))
			continue;

		SpellInfo const *spellInfo = sSpellMgr->GetSpellInfo(itr->first);
		if (!spellInfo)
			continue;

		if (!spellInfo->SpellFamilyName || spellInfo->IsPassive() || spellInfo->NeedsComboPoints() || (spellInfo->Stances && !spellInfo->HasAttribute(SPELL_ATTR2_NOT_NEED_SHAPESHIFT)))
			continue;

		bool allow = false;
		uint8 type = 0;
		float cast = spellInfo->CalcCastTime() / 1000.0f;
		if (cast > 3.0f)
			continue;

		for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
		{
			if (spellInfo->Effects[i].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)
			{
				int32 dmg = CalculateSpellDamage(this, spellInfo, i);
				uint8 offset = 0;
				if (cast)
				{
					dmg = dmg / cast;
					offset = 2;
				}

				if ((int32)damage_type[offset] < dmg)
				{
					if (!m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] || !spellInfo->IsHighRankOf(sSpellMgr->GetSpellInfo(m_charmAISpells[SPELL_INSTANT_DAMAGE + offset])) || urand(0, 1))
						if (damage_type[1 + offset] < damage_type[offset])
						{
							m_charmAISpells[SPELL_INSTANT_DAMAGE2 + offset] = m_charmAISpells[SPELL_INSTANT_DAMAGE + offset];
							damage_type[1 + offset] = damage_type[offset];
						}

					m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] = spellInfo->Id;
					damage_type[offset] = dmg;
				}
				else if ((int32)damage_type[1 + offset] < dmg)
				{
					if (m_charmAISpells[SPELL_INSTANT_DAMAGE + offset] && sSpellMgr->GetSpellInfo(m_charmAISpells[SPELL_INSTANT_DAMAGE + offset])->IsHighRankOf(spellInfo) && urand(0, 1))
						continue;

					m_charmAISpells[SPELL_INSTANT_DAMAGE2 + offset] = spellInfo->Id;
					damage_type[1 + offset] = dmg;
				}
				break;
			}
			else if (spellInfo->HasAttribute(SPELL_ATTR7_HAS_CHARGE_EFFECT))
			{
				m_charmAISpells[SPELL_T_CHARGE] = spellInfo->Id;
				break;
			}
			else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_SPEED)
			{
				m_charmAISpells[SPELL_FAST_RUN] = spellInfo->Id;
				break;
			}
			else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_SCHOOL_IMMUNITY)
			{
				m_charmAISpells[SPELL_IMMUNITY] = spellInfo->Id;
				break;
			}
			else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE)
			{
				if ((int32)periodic_damage < CalculateSpellDamage(this, spellInfo, i))
				{
					m_charmAISpells[SPELL_DOT_DAMAGE] = spellInfo->Id;
					break;
				}
			}
			else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_STUN)
			{
				m_charmAISpells[SPELL_T_STUN] = spellInfo->Id;
				break;
			}
			else if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_ROOT || spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_FEAR)
			{
				m_charmAISpells[SPELL_ROOT_OR_FEAR] = spellInfo->Id;
				break;
			}
		}
	}
}

void Player::AddRefundReference(uint32 it)
{
	m_refundableItems.insert(it);
}

void Player::DeleteRefundReference(uint32 it)
{
	RefundableItemsSet::iterator itr = m_refundableItems.find(it);
	if (itr != m_refundableItems.end())
		m_refundableItems.erase(itr);
}

void Player::SendRefundInfo(Item* item)
{
	// This function call unsets ITEM_FLAGS_REFUNDABLE if played time is over 2 hours.
	item->UpdatePlayedTime(this);

	if (!item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE))
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: item not refundable!");
		return;
	}

	if (GetGUIDLow() != item->GetRefundRecipient()) // Formerly refundable item got traded
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: item was traded!");
		item->SetNotRefundable(this);
		return;
	}

	ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(item->GetPaidExtendedCost());
	if (!iece)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: cannot find extendedcost data.");
		return;
	}

	WorldPacket data(SMSG_ITEM_REFUND_INFO_RESPONSE, 8 + 4 + 4 + 4 + 4 * 4 + 4 * 4 + 4 + 4);
	data << uint64(item->GetGUID());                    // item guid
	data << uint32(item->GetPaidMoney());               // money cost
	data << uint32(iece->reqhonorpoints);               // honor point cost
	data << uint32(iece->reqarenapoints);               // arena point cost
	for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)                       // item cost data
	{
		data << uint32(iece->reqitem[i]);
		data << uint32(iece->reqitemcount[i]);
	}
	data << uint32(0);
	data << uint32(GetTotalPlayedTime() - item->GetPlayedTime());
	GetSession()->SendPacket(&data);
}

bool Player::AddItem(uint32 itemId, uint32 count)
{
	uint32 noSpaceForCount = 0;
	ItemPosCountVec dest;
	InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, count, &noSpaceForCount);
	if (msg != EQUIP_ERR_OK)
		count -= noSpaceForCount;

	if (count == 0 || dest.empty())
	{
		// -- TODO: Send to mailbox if no space
		ChatHandler(GetSession()).PSendSysMessage("You don't have any space in your bags.");
		return false;
	}

	Item* item = StoreNewItem(dest, itemId, true, Item::GenerateItemRandomPropertyId(itemId));
	if (item)
		SendNewItem(item, count, true, false);
	else
		return false;
	return true;
}

void Player::RefundItem(Item* item)
{
	if (!item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_REFUNDABLE))
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: item not refundable!");
		return;
	}

	if (item->IsRefundExpired())    // item refund has expired
	{
		item->SetNotRefundable(this);
		WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4);
		data << uint64(item->GetGUID());             // Guid
		data << uint32(10);                          // Error!
		GetSession()->SendPacket(&data);
		return;
	}

	if (GetGUIDLow() != item->GetRefundRecipient()) // Formerly refundable item got traded
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: item was traded!");
		item->SetNotRefundable(this);
		return;
	}

	ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(item->GetPaidExtendedCost());
	if (!iece)
	{
		;//sLog->outDebug(LOG_FILTER_PLAYER_ITEMS, "Item refund: cannot find extendedcost data.");
		return;
	}

	bool store_error = false;
	for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
	{
		uint32 count = iece->reqitemcount[i];
		uint32 itemid = iece->reqitem[i];

		if (count && itemid)
		{
			ItemPosCountVec dest;
			InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemid, count);
			if (msg != EQUIP_ERR_OK)
			{
				store_error = true;
				break;
			}
		}
	}

	if (store_error)
	{
		WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4);
		data << uint64(item->GetGUID());                 // Guid
		data << uint32(10);                              // Error!
		GetSession()->SendPacket(&data);
		return;
	}

	WorldPacket data(SMSG_ITEM_REFUND_RESULT, 8 + 4 + 4 + 4 + 4 + 4 * 4 + 4 * 4);
	data << uint64(item->GetGUID());                    // item guid
	data << uint32(0);                                  // 0, or error code
	data << uint32(item->GetPaidMoney());               // money cost
	data << uint32(iece->reqhonorpoints);               // honor point cost
	data << uint32(iece->reqarenapoints);               // arena point cost
	for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i) // item cost data
	{
		data << uint32(iece->reqitem[i]);
		data << uint32(iece->reqitemcount[i]);
	}
	GetSession()->SendPacket(&data);

	uint32 moneyRefund = item->GetPaidMoney();  // item-> will be invalidated in DestroyItem

	// Save all relevant data to DB to prevent desynchronisation exploits
	SQLTransaction trans = CharacterDatabase.BeginTransaction();

	// Delete any references to the refund data
	item->SetNotRefundable(this, true, &trans);

	// Destroy item
	DestroyItem(item->GetBagSlot(), item->GetSlot(), true);

	// Grant back extendedcost items
	for (uint8 i = 0; i < MAX_ITEM_EXTENDED_COST_REQUIREMENTS; ++i)
	{
		uint32 count = iece->reqitemcount[i];
		uint32 itemid = iece->reqitem[i];
		if (count && itemid)
		{
			ItemPosCountVec dest;
			InventoryResult msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemid, count);
			ASSERT(msg == EQUIP_ERR_OK); /// Already checked before
			Item* it = StoreNewItem(dest, itemid, true);
			SendNewItem(it, count, true, false, true);
		}
	}

	// Grant back money
	if (moneyRefund)
		ModifyMoney(moneyRefund); // Saved in SaveInventoryAndGoldToDB

	// Grant back Honor points
	if (uint32 honorRefund = iece->reqhonorpoints)
		ModifyHonorPoints(honorRefund, &trans);

	// Grant back Arena points
	if (uint32 arenaRefund = iece->reqarenapoints)
		ModifyArenaPoints(arenaRefund, &trans);

	SaveInventoryAndGoldToDB(trans);

	CharacterDatabase.CommitTransaction(trans);
}

void Player::SetRandomWinner(bool isWinner)
{
	m_IsBGRandomWinner = isWinner;
	if (m_IsBGRandomWinner)
	{
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_BATTLEGROUND_RANDOM);
		stmt->setUInt32(0, GetGUIDLow());
		CharacterDatabase.Execute(stmt);
	}
}

void Player::_LoadRandomBGStatus(PreparedQueryResult result)
{
	if (result)
		m_IsBGRandomWinner = true;
}

float Player::GetAverageItemLevel()
{
	float sum = 0;
	uint32 count = 0;
	uint8 level = getLevel();

	for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		// don't check tabard, ranged, offhand or shirt
		if (i == EQUIPMENT_SLOT_TABARD || i == EQUIPMENT_SLOT_RANGED || i == EQUIPMENT_SLOT_OFFHAND || i == EQUIPMENT_SLOT_BODY)
			continue;

		if (m_items[i] && m_items[i]->GetTemplate())
			sum += m_items[i]->GetTemplate()->GetItemLevelIncludingQuality(level);

		++count;
	}

	return std::max<float>(0.0f, sum / (float)count);
}

float Player::GetAverageItemLevelForDF()
{
	float sum = 0;
	uint32 count = 0;
	uint8 level = getLevel();

	for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
	{
		// don't check tabard, ranged, offhand or shirt
		if (i == EQUIPMENT_SLOT_TABARD || i == EQUIPMENT_SLOT_RANGED || i == EQUIPMENT_SLOT_OFFHAND || i == EQUIPMENT_SLOT_BODY)
			continue;

		if (m_items[i] && m_items[i]->GetTemplate())
		{
			if (m_items[i]->GetTemplate()->Quality == ITEM_QUALITY_HEIRLOOM)
				sum += level*2.33f;
			else
				sum += m_items[i]->GetTemplate()->ItemLevel;
		}

		++count;
	}

	return std::max(0.0f, sum / (float)count);
}

void Player::_LoadInstanceTimeRestrictions(PreparedQueryResult result)
{
	if (!result)
		return;

	do
	{
		Field* fields = result->Fetch();
		_instanceResetTimes.insert(InstanceTimeMap::value_type(fields[0].GetUInt32(), fields[1].GetUInt64()));
	} while (result->NextRow());
}

void Player::_LoadBrewOfTheMonth(PreparedQueryResult result)
{
	uint32 lastEventId = 0;
	if (result)
	{
		Field* fields = result->Fetch();
		lastEventId = fields[0].GetUInt32();
	}

	time_t curtime = time(NULL);
	tm localTime;
	ACE_OS::localtime_r(&curtime, &localTime);

	uint16 month = uint16(localTime.tm_mon);
	uint16 eventId = month;
	if (eventId < 9)
		eventId += 3;
	else
		eventId -= 9;

	// Brew of the Month October (first in list)
	eventId += 34;

	if (lastEventId != eventId && IsEventActive(eventId) && HasAchieved(2796 /* Brew of the Month*/))
	{
		// Send Mail
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		MailSender sender(MAIL_CREATURE, 27487 /*NPC_BREW_OF_THE_MONTH_CLUB*/);
		MailDraft draft(uint16(212 + month)); // 212 is starting template id
		draft.SendMailTo(trans, MailReceiver(this, GetGUIDLow()), sender);

		// Update Event Id
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_BREW_OF_THE_MONTH);
		stmt->setUInt32(0, GetGUIDLow());
		stmt->setUInt32(1, uint32(eventId));
		trans->Append(stmt);

		CharacterDatabase.CommitTransaction(trans);
	}
}

void Player::_SaveInstanceTimeRestrictions(SQLTransaction& trans)
{
	if (_instanceResetTimes.empty())
		return;

	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ACCOUNT_INSTANCE_LOCK_TIMES);
	stmt->setUInt32(0, GetSession()->GetAccountId());
	trans->Append(stmt);

	for (InstanceTimeMap::const_iterator itr = _instanceResetTimes.begin(); itr != _instanceResetTimes.end(); ++itr)
	{
		stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ACCOUNT_INSTANCE_LOCK_TIMES);
		stmt->setUInt32(0, GetSession()->GetAccountId());
		stmt->setUInt32(1, itr->first);
		stmt->setUInt64(2, itr->second);
		trans->Append(stmt);
	}
}

bool Player::IsInWhisperWhiteList(uint64 guid)
{
	for (WhisperListContainer::const_iterator itr = WhisperList.begin(); itr != WhisperList.end(); ++itr)
		if (*itr == guid)
			return true;

	return false;
}

bool Player::SetDisableGravity(bool disable, bool packetOnly /*= false*/)
{
	if (!packetOnly && !Unit::SetDisableGravity(disable))
		return false;

	WorldPacket data(disable ? SMSG_MOVE_GRAVITY_DISABLE : SMSG_MOVE_GRAVITY_ENABLE, 12);
	data.append(GetPackGUID());
	data << uint32(0);          //! movement counter
	SendDirectMessage(&data);

	data.Initialize(MSG_MOVE_GRAVITY_CHNG, 64);
	data.append(GetPackGUID());
	BuildMovementPacket(&data);
	SendMessageToSet(&data, false);
	return true;
}

bool Player::SetCanFly(bool apply, bool packetOnly /*= false*/)
{
	if (!packetOnly && !Unit::SetCanFly(apply))
		return false;

	if (!apply)
		SetFallInformation(time(NULL), GetPositionZ());

	WorldPacket data(apply ? SMSG_MOVE_SET_CAN_FLY : SMSG_MOVE_UNSET_CAN_FLY, 12);
	data.append(GetPackGUID());
	data << uint32(0);          //! movement counter
	SendDirectMessage(&data);

	data.Initialize(MSG_MOVE_UPDATE_CAN_FLY, 64);
	data.append(GetPackGUID());
	BuildMovementPacket(&data);
	SendMessageToSet(&data, false);
	return true;
}

bool Player::SetHover(bool apply, bool packetOnly /*= false*/)
{
	if (!packetOnly && !Unit::SetHover(apply))
		return false;

	WorldPacket data(apply ? SMSG_MOVE_SET_HOVER : SMSG_MOVE_UNSET_HOVER, 12);
	data.append(GetPackGUID());
	data << uint32(0);          //! movement counter
	SendDirectMessage(&data);

	data.Initialize(MSG_MOVE_HOVER, 64);
	data.append(GetPackGUID());
	BuildMovementPacket(&data);
	SendMessageToSet(&data, false);
	return true;
}

bool Player::SetWaterWalking(bool apply, bool packetOnly /*= false*/)
{
	if (!packetOnly && !Unit::SetWaterWalking(apply))
		return false;

	WorldPacket data(apply ? SMSG_MOVE_WATER_WALK : SMSG_MOVE_LAND_WALK, 12);
	data.append(GetPackGUID());
	data << uint32(0);          //! movement counter
	SendDirectMessage(&data);

	data.Initialize(MSG_MOVE_WATER_WALK, 64);
	data.append(GetPackGUID());
	BuildMovementPacket(&data);
	SendMessageToSet(&data, false);
	return true;
}

bool Player::SetFeatherFall(bool apply, bool packetOnly /*= false*/)
{
	// Xinef: moved inside, flag can be removed on landing and wont send appropriate packet to client when aura is removed
	if (!packetOnly/* && !Unit::SetFeatherFall(apply)*/)
	{
		Unit::SetFeatherFall(apply);
		//return false;
	}

	WorldPacket data(apply ? SMSG_MOVE_FEATHER_FALL : SMSG_MOVE_NORMAL_FALL, 12);
	data.append(GetPackGUID());
	data << uint32(0);          //! movement counter
	SendDirectMessage(&data);

	data.Initialize(MSG_MOVE_FEATHER_FALL, 64);
	data.append(GetPackGUID());
	BuildMovementPacket(&data);
	SendMessageToSet(&data, false);
	return true;
}

Guild* Player::GetGuild() const
{
	uint32 guildId = GetGuildId();
	return guildId ? sGuildMgr->GetGuildById(guildId) : NULL;
}

void Player::SummonPet(uint32 entry, float x, float y, float z, float ang, PetType petType, uint32 duration, uint32 createdBySpell, uint64 casterGUID, uint8 asynchLoadType)
{
	Position pos = { x, y, z, ang };
	if (!pos.IsPositionValid())
		return;

	AsynchPetSummon* asynchPetInfo = new AsynchPetSummon(entry, pos, petType, duration, createdBySpell, casterGUID);
	Pet::LoadPetFromDB(this, asynchLoadType, entry, 0, false, asynchPetInfo);
}
