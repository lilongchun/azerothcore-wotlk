/* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 *
 *
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#include "CreatureTextMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "npc_stave_of_ancients.h"

uint32 NPCStaveQuestAI::GetFormEntry(std::string type)
{
    uint32 currentEntry = me->GetEntry();
    uint32 entryKey = entryKeys[currentEntry];
    return entryList[entryKey][type];
}

bool NPCStaveQuestAI::InNormalForm()
{
    return me->GetEntry() == GetFormEntry("normal");
}

void NPCStaveQuestAI::RevealForm()
{
    if (encounterStarted && InNormalForm())
    {
        me->UpdateEntry(GetFormEntry("evil"));
        me->DespawnOrUnsummon(900000);
    }
}

void NPCStaveQuestAI::StorePlayerGUID()
{
    if (!playerGUID.IsEmpty())
    {
        return;
    }

    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
    {
        if ((*itr)->getTarget()->GetTypeId() == TYPEID_PLAYER)
        {
            playerGUID = (*itr)->getUnitGuid();
        }
    }
}

bool NPCStaveQuestAI::IsAllowedEntry(uint32 entry)
{
    uint32 allowedEntries[4] = { 0, 12999, 19833, 19921 }; //player, World Invisible Trigger(traps) and snake trap snakes
    bool isAllowed = std::find(std::begin(allowedEntries), std::end(allowedEntries), entry) != std::end(allowedEntries);
    return isAllowed;
}

bool NPCStaveQuestAI::IsFairFight()
{
    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
    {
        Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
        bool allowedEntry = IsAllowedEntry(unit->GetEntry());

        if (!(*itr)->getThreat())
        {
            // if target threat is 0 its fair, this prevents despawn in the case when
            // there is a bystander since UpdateVictim adds nearby enemies to the threatlist
            continue;
        }

        if (unit->IsPlayer())
        {
            if (playerGUID != unit->GetGUID())
            {
                // if there is another player in the threatlist its unfair
                return false;
            }
        }
        else
        {
            if (!playerGUID.IsEmpty() && unit->GetOwnerGUID() != playerGUID)
            {
                // if a creature attacking isn't owned by the player its unfair
                return false;
            }
            else if (!allowedEntry)
            {
                // if not in the whitelist its unfair
                return false;
            }
        }
    }

    return true;
}

bool NPCStaveQuestAI::ValidThreatlist()
{
    if (threatList.size() == 1)
    {
        return true;
    }

    bool isFair = IsFairFight();

    return isFair;
}

void NPCStaveQuestAI::SetHomePosition()
{
    Position homePosition;
    me->GetPosition(&homePosition);

    if (homePosition.IsPositionValid())
    {
        me->SetHomePosition(homePosition);
    }
}

void NPCStaveQuestAI::PrepareForEncounter()
{
    encounterStarted = true;
    me->GetMotionMaster()->MoveIdle();
    me->GetMotionMaster()->Clear();
    SetHomePosition();

    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
}

void NPCStaveQuestAI::ClearLootIfUnfair(Unit* killer)
{
    // Remove loot if there is more than 1 attacker or Player doesn't have the quest
    // this should prevent party kills and looting the quest item without putting any effort
    if (attackerGuids.size() > 1 || !PlayerEligibleForReward(killer))
    {
        me->loot.clear();
        return;
    }
}

bool NPCStaveQuestAI::PlayerEligibleForReward(Unit* killer)
{
    if (!killer)
    {
        return true;
    }

    if (Player* player = killer->ToPlayer())
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) != QUEST_STATUS_INCOMPLETE)
        {
            return false;
        }
    }

    return true;
}

void NPCStaveQuestAI::StoreAttackerGuidValue(Unit* attacker)
{
    if (!attacker)
    {
        return;
    }

    uint64 guidValue = attacker->GetGUID().GetRawValue();
    bool isGUIDPresent = std::find(attackerGuids.begin(), attackerGuids.end(), guidValue) != attackerGuids.end();

    // don't store snaketrap's snakes and trap triggers
    if(isGUIDPresent || (IsAllowedEntry(attacker->GetEntry()) && attacker->GetTypeId() != TYPEID_PLAYER)) {
        return;
    } else {
        attackerGuids.push_back(guidValue);
    }
}

class npc_artorius : public CreatureScript
{
public:
    npc_artorius() : CreatureScript("npc_artorius") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_artoriusAI(creature);
    }

    struct npc_artoriusAI : public NPCStaveQuestAI
    {
        npc_artoriusAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;

        void JustDied(Unit* killer) override
        {
            // Prevent looting if killer doesn't have the quest
            ClearLootIfUnfair(killer);
        }

        void Reset() override
        {
            encounterStarted = false;
            playerGUID.Clear();
            attackerGuids.clear();
            events.Reset();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            if (me->HasAura(ARTORIUS_SPELL_STINGING_TRAUMA))
            {
                me->RemoveAura(ARTORIUS_SPELL_STINGING_TRAUMA);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (!InNormalForm())
            {
                events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_DOOM, urand(3000, 5000));
                events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_ENRAGE, urand(6000, 8000));
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1000);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->MonsterSay(ARTORIUS_SAY, LANG_UNIVERSAL, 0);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 8000);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist())
                    {
                        SetHomePosition();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->DespawnOrUnsummon(5000);
                        break;
                    }
                    events.RepeatEvent(2000);
                    break;
                case ARTORIUS_EVENT_DEMONIC_DOOM:
                    if (!me->GetVictim()->HasAura(ARTORIUS_SPELL_DEMONIC_DOOM))
                    {
                        me->CastSpell(me->GetVictim(), ARTORIUS_SPELL_DEMONIC_DOOM, false);
                    }
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case ARTORIUS_EVENT_DEMONIC_ENRAGE:
                    me->CastSpell(me, ARTORIUS_SPELL_DEMONIC_ENRAGE, false);
                    events.RepeatEvent(urand(22000, 39000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, const SpellInfo* Spell) override
        {
            uint32 serpentStings[12] = { 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016, 49000, 49001 };

            if (!InNormalForm())
            {
                bool applyAura = std::find(std::begin(serpentStings), std::end(serpentStings), Spell->Id) != std::end(serpentStings);

                if (applyAura)
                {
                    me->AddAura(ARTORIUS_SPELL_STINGING_TRAUMA, me);
                    me->MonsterTextEmote(ARTORIUS_WEAKNESS_EMOTE, 0);
                }
            }
        }

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            StoreAttackerGuidValue(attacker);
        }

        void DoAction(int32 action) override
        {
            if (action == EVENT_ENCOUNTER_START)
            {
                PrepareForEncounter();
                events.ScheduleEvent(EVENT_ENCOUNTER_START, 2000);
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(EVENT_ENCOUNTER_START);

        return true;
    }

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(ARTORIUS_HEAD, 1, true))
        {
            std::string const& gossipOptionText = sCreatureTextMgr->GetLocalizedChatString(ARTORIUS_GOSSIP_OPTION_TEXT, 0, 0, 0, LOCALE_enUS);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipOptionText, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, ARTORIUS_GOSSIP_TEXT, creature->GetGUID());

        return true;
    }
};

void AddSC_npc_stave_of_ancients()
{
    new npc_artorius();
}
