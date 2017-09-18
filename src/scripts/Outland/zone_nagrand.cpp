/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Nagrand
SD%Complete: 90
SDComment: Quest support: 9868, 9874, 10085. TextId's unknown for altruis_the_sufferer and greatmother_geyah (npc_text)
SDCategory: Nagrand
EndScriptData */

/* ContentData
npc_maghar_captive
npc_creditmarker_visit_with_ancestors
EndContentData */
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "SpellInfo.h"

/*#####
## npc_maghar_captive
#####*/

enum MagharCaptive
{
    SAY_MAG_START               = 0,
    SAY_MAG_NO_ESCAPE           = 0,
    SAY_MAG_MORE                = 1,
    SAY_MAG_MORE_REPLY          = 0,
    SAY_MAG_LIGHTNING           = 2,
    SAY_MAG_SHOCK               = 3,
    SAY_MAG_COMPLETE            = 4,

    SPELL_CHAIN_LIGHTNING       = 16006,
    SPELL_EARTHBIND_TOTEM       = 15786,
    SPELL_FROST_SHOCK           = 12548,
    SPELL_HEALING_WAVE          = 12491,

    QUEST_TOTEM_KARDASH_H       = 9868,

    NPC_MURK_RAIDER             = 18203,
    NPC_MURK_BRUTE              = 18211,
    NPC_MURK_SCAVENGER          = 18207,
    NPC_MURK_PUTRIFIER          = 18202
};

static float m_afAmbushA[]= {-1568.805786f, 8533.873047f, 1.958f};
static float m_afAmbushB[]= {-1491.554321f, 8506.483398f, 1.248f};

class npc_maghar_captive : public CreatureScript
{
public:
    npc_maghar_captive() : CreatureScript("npc_maghar_captive") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_TOTEM_KARDASH_H)
        {
            if (npc_maghar_captiveAI* EscortAI = dynamic_cast<npc_maghar_captiveAI*>(creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                creature->setFaction(232);
                EscortAI->Start(true, false, player->GetGUID(), quest);
                creature->AI()->Talk(SAY_MAG_START);

                creature->SummonCreature(NPC_MURK_RAIDER, m_afAmbushA[0]+2.5f, m_afAmbushA[1]-2.5f, m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushA[0]-2.5f, m_afAmbushA[1]+2.5f, m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_BRUTE, m_afAmbushA[0], m_afAmbushA[1], m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_maghar_captiveAI(creature);
    }

    struct npc_maghar_captiveAI : public npc_escortAI
    {
        npc_maghar_captiveAI(Creature* creature) : npc_escortAI(creature) { Reset(); }

        uint32 ChainLightningTimer;
        uint32 HealTimer;
        uint32 FrostShockTimer;

        void Reset()
        {
            ChainLightningTimer = 1000;
            HealTimer = 0;
            FrostShockTimer = 6000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoCast(me, SPELL_EARTHBIND_TOTEM, false);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = GetPlayerForEscort())
            {
                if (player->GetQuestStatus(QUEST_TOTEM_KARDASH_H) != QUEST_STATUS_COMPLETE)
                    player->FailQuest(QUEST_TOTEM_KARDASH_H);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 7:
                    Talk(SAY_MAG_MORE);

                    if (Creature* temp = me->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushB[0], m_afAmbushB[1], m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        temp->AI()->Talk(SAY_MAG_MORE_REPLY);

                    me->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushB[0]-2.5f, m_afAmbushB[1]-2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, m_afAmbushB[0]+2.5f, m_afAmbushB[1]+2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, m_afAmbushB[0]+2.5f, m_afAmbushB[1]-2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 16:
                    Talk(SAY_MAG_COMPLETE);

                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_TOTEM_KARDASH_H, me);

                    SetRun();
                    break;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            if (summoned->GetEntry() == NPC_MURK_BRUTE)
                summoned->AI()->Talk(SAY_MAG_NO_ESCAPE);

            if (summoned->IsTotem())
                return;

            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            summoned->AI()->AttackStart(me);

        }

        void SpellHitTarget(Unit* /*target*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_CHAIN_LIGHTNING)
            {
                if (rand()%10)
                    return;

                Talk(SAY_MAG_LIGHTNING);
            }
        }

        void UpdateAI(uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (ChainLightningTimer <= diff)
            {
                DoCastVictim(SPELL_CHAIN_LIGHTNING);
                ChainLightningTimer = urand(7000, 14000);
            }
            else
                ChainLightningTimer -= diff;

            if (HealthBelowPct(30))
            {
                if (HealTimer <= diff)
                {
                    DoCast(me, SPELL_HEALING_WAVE);
                    HealTimer = 5000;
                }
                else
                    HealTimer -= diff;
            }

            if (FrostShockTimer <= diff)
            {
                DoCastVictim(SPELL_FROST_SHOCK);
                FrostShockTimer = urand(7500, 15000);
            }
            else
                FrostShockTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_creditmarker_visist_with_ancestors
######*/

class npc_creditmarker_visit_with_ancestors : public CreatureScript
{
public:
    npc_creditmarker_visit_with_ancestors() : CreatureScript("npc_creditmarker_visit_with_ancestors") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_creditmarker_visit_with_ancestorsAI(creature);
    }

    struct npc_creditmarker_visit_with_ancestorsAI : public ScriptedAI
    {
        npc_creditmarker_visit_with_ancestorsAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() { }

        void EnterCombat(Unit* /*who*/) { }

        void MoveInLineOfSight(Unit* who)

        {
            if (!who)
                return;

            Player* player = who->ToPlayer();
            if (player && player->GetQuestStatus(10085) == QUEST_STATUS_INCOMPLETE)
            {
                uint32 creditMarkerId = me->GetEntry();
                if (creditMarkerId >= 18840 && creditMarkerId <= 18843)
                {
                    // 18840: Sunspring, 18841: Laughing, 18842: Garadar, 18843: Bleeding
                    if (!player->GetReqKillOrCastCurrentCount(10085, creditMarkerId))
                        player->KilledMonsterCredit(creditMarkerId, me->GetGUID());
                }
            }
        }
    };
};

/*######
## go_corkis_prison and npc_corki
######*/

enum CorkiData
{
  // first quest
  QUEST_HELP                                    = 9923,
  NPC_CORKI                                     = 18445,
  NPC_CORKI_CREDIT_1                            = 18369,
  GO_CORKIS_PRISON                              = 182349,
  CORKI_SAY_THANKS                              = 0,
  // 2nd quest
  QUEST_CORKIS_GONE_MISSING_AGAIN               = 9924,
  NPC_CORKI_2                                   = 20812,
  GO_CORKIS_PRISON_2                            = 182350,
  CORKI_SAY_PROMISE                             = 0,
  // 3rd quest
  QUEST_CHOWAR_THE_PILLAGER                     = 9955,
  NPC_CORKI_3                                   = 18369,
  NPC_CORKI_CREDIT_3                            = 18444,
  GO_CORKIS_PRISON_3                            = 182521,
  CORKI_SAY_LAST                                = 0
};

class go_corkis_prison : public GameObjectScript
{
public:
  go_corkis_prison() : GameObjectScript("go_corkis_prison") { }

  bool OnGossipHello(Player* player, GameObject* go)
  {
      go->SetGoState(GO_STATE_READY);
      if (go->GetEntry() == GO_CORKIS_PRISON)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI, 25, true))
          {
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()+5, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_CREDIT_1, 0);
          }
      }

      if (go->GetEntry() == GO_CORKIS_PRISON_2)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI_2, 25, true))
          {
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()-5, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_2, 0);
          }
      }

      if (go->GetEntry() == GO_CORKIS_PRISON_3)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI_3, 25, true))
          {
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()+4, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_CREDIT_3, 0);
          }
      }
      return true;
  }
};

class npc_corki : public CreatureScript
{
public:
  npc_corki() : CreatureScript("npc_corki") { }

  CreatureAI* GetAI(Creature* creature) const
  {
      return new npc_corkiAI(creature);
  }

  struct npc_corkiAI : public ScriptedAI
  {
      npc_corkiAI(Creature* creature) : ScriptedAI(creature) { }

      uint32 Say_Timer;
      bool ReleasedFromCage;

      void Reset()
      {
          Say_Timer = 5000;
          ReleasedFromCage = false;
      }

      void UpdateAI(uint32 diff)
      {
          if (ReleasedFromCage)
          {
              if (Say_Timer <= diff)
              {
                  me->DespawnOrUnsummon();
                  ReleasedFromCage = false;
              }
              else
                  Say_Timer -= diff;
          }
      }

      void MovementInform(uint32 type, uint32 id)
      {
          if (type == POINT_MOTION_TYPE && id == 1)
          {
              Say_Timer = 5000;
              ReleasedFromCage = true;
              if (me->GetEntry() == NPC_CORKI)
                  Talk(CORKI_SAY_THANKS);
              if (me->GetEntry() == NPC_CORKI_2)
                  Talk(CORKI_SAY_PROMISE);
              if (me->GetEntry() == NPC_CORKI_3)
                  Talk(CORKI_SAY_LAST);
          }
      };
  };
};

/*#####
## npc_kurenai_captive
#####*/

enum KurenaiCaptive
{
    SAY_KUR_START                   = 0,
    SAY_KUR_NO_ESCAPE               = 1,
    SAY_KUR_MORE                    = 2,
    SAY_KUR_MORE_TWO                = 3,
    SAY_KUR_LIGHTNING               = 4,
    SAY_KUR_SHOCK                   = 5,
    SAY_KUR_COMPLETE                = 6,

    SPELL_KUR_CHAIN_LIGHTNING       = 16006,
    SPELL_KUR_EARTHBIND_TOTEM       = 15786,
    SPELL_KUR_FROST_SHOCK           = 12548,
    SPELL_KUR_HEALING_WAVE          = 12491,

    QUEST_TOTEM_KARDASH_A           = 9879,

    NPC_KUR_MURK_RAIDER             = 18203,
    NPC_KUR_MURK_BRUTE              = 18211,
    NPC_KUR_MURK_SCAVENGER          = 18207,
    NPC_KUR_MURK_PUTRIFIER          = 18202,
};

static float kurenaiAmbushA[]= {-1520.6f, 8468.4f, -4.1f};
static float kurenaiAmbushB[]= {-1491.554321f, 8506.483398f, 1.248f};

class npc_kurenai_captive : public CreatureScript
{
public:
    npc_kurenai_captive() : CreatureScript("npc_kurenai_captive") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_TOTEM_KARDASH_A)
            creature->AI()->SetGUID(player->GetGUID(), quest->GetQuestId());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_kurenai_captiveAI(creature);
    }

    struct npc_kurenai_captiveAI : public npc_escortAI
    {
        npc_kurenai_captiveAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 ChainLightningTimer;
        uint32 HealTimer;
        uint32 FrostShockTimer;

        void SetGUID(uint64 guid, int32  /*questId*/)
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            Start(true, false, guid);
            Talk(SAY_KUR_START);

            me->SummonCreature(NPC_KUR_MURK_RAIDER, kurenaiAmbushA[0]+2.5f, kurenaiAmbushA[1]-2.5f, kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 50000);
            me->SummonCreature(NPC_KUR_MURK_BRUTE, kurenaiAmbushA[0]-2.5f, kurenaiAmbushA[1]+2.5f, kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 50000);
            me->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushA[0], kurenaiAmbushA[1], kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 50000);
        }

        void Reset()
        {
            ChainLightningTimer = 1000;
            HealTimer = 0;
            FrostShockTimer = 6000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoCast(me, SPELL_KUR_EARTHBIND_TOTEM, false);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = GetPlayerForEscort())
            {
                if (player->GetQuestStatus(QUEST_TOTEM_KARDASH_A) != QUEST_STATUS_COMPLETE)
                    player->FailQuest(QUEST_TOTEM_KARDASH_A);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 3:
                {
                    Talk(SAY_KUR_MORE);

                    if (Creature* cr = me->SummonCreature(NPC_KUR_MURK_PUTRIFIER, kurenaiAmbushB[0], kurenaiAmbushB[1], kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        cr->AI()->Talk(SAY_KUR_MORE_TWO);

                    me->SummonCreature(NPC_KUR_MURK_PUTRIFIER, kurenaiAmbushB[0]-2.5f, kurenaiAmbushB[1]-2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushB[0]+2.5f, kurenaiAmbushB[1]+2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushB[0]+2.5f, kurenaiAmbushB[1]-2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                }
                case 7:
                {
                    Talk(SAY_KUR_COMPLETE);

                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_TOTEM_KARDASH_A, me);

                    SetRun();
                    break;
                }
            }
        }

        void JustSummoned(Creature* summoned)
        {
            if (summoned->GetEntry() == NPC_KUR_MURK_BRUTE)
                summoned->AI()->Talk(SAY_KUR_NO_ESCAPE);

            // This function is for when we summoned enemies to fight - so that does NOT mean we should make our totem count in this!
            if (summoned->IsTotem())
                return;

            summoned->AI()->AttackStart(me);
        }

        void SpellHitTarget(Unit* /*target*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_KUR_CHAIN_LIGHTNING)
            {
                if (rand()%30)
                    return;

                Talk(SAY_KUR_LIGHTNING);
            }

            if (spell->Id == SPELL_KUR_FROST_SHOCK)
            {
                if (rand()%30)
                    return;

                Talk(SAY_KUR_SHOCK);
            }
        }

        void UpdateEscortAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (ChainLightningTimer <= diff)
            {
                DoCastVictim(SPELL_KUR_CHAIN_LIGHTNING);
                ChainLightningTimer = urand(7000, 14000);
            } else ChainLightningTimer -= diff;

            if (HealthBelowPct(30))
            {
                if (HealTimer <= diff)
                {
                    DoCast(me, SPELL_KUR_HEALING_WAVE);
                    HealTimer = 5000;
                } else HealTimer -= diff;
            }

            if (FrostShockTimer <= diff)
            {
                DoCastVictim(SPELL_KUR_FROST_SHOCK);
                FrostShockTimer = urand(7500, 15000);
            } else FrostShockTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## go_warmaul_prison
######*/

enum FindingTheSurvivorsData
{
    QUEST_FINDING_THE_SURVIVORS                     = 9948,
    NPC_MAGHAR_PRISONER                             = 18428,

    SAY_FREE                                        = 0,
};

class go_warmaul_prison : public GameObjectScript
{
    public:
        go_warmaul_prison() : GameObjectScript("go_warmaul_prison") { }

        bool OnGossipHello(Player* player, GameObject* go)
        {
            go->UseDoorOrButton();
            if (player->GetQuestStatus(QUEST_FINDING_THE_SURVIVORS) != QUEST_STATUS_INCOMPLETE)
                return false;

            if (Creature* prisoner = go->FindNearestCreature(NPC_MAGHAR_PRISONER, 5.0f))
            {
                player->KilledMonsterCredit(NPC_MAGHAR_PRISONER, 0);

                prisoner->AI()->Talk(SAY_FREE, player);
                prisoner->DespawnOrUnsummon(6000);
            }
            return true;
        }
};

void AddSC_nagrand()
{
    new npc_maghar_captive();
    new npc_creditmarker_visit_with_ancestors();
    new npc_corki();
    new go_corkis_prison();
    new npc_kurenai_captive();
    new go_warmaul_prison();
}
