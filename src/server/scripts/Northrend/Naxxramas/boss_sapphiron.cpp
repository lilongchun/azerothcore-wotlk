/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "naxxramas.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

enum Yells
{
    EMOTE_AIR_PHASE         = 0,
    EMOTE_GROUND_PHASE      = 1,
    EMOTE_BREATH            = 2,
    EMOTE_ENRAGE            = 3
};

enum Spells
{
    // Fight
    SPELL_FROST_AURA_10             = 28531,
    SPELL_FROST_AURA_25             = 55799,
    SPELL_CLEAVE                    = 19983,
    SPELL_TAIL_SWEEP_10             = 55697,
    SPELL_TAIL_SWEEP_25             = 55696,
    SPELL_SUMMON_BLIZZARD           = 28560,
    SPELL_LIFE_DRAIN_10             = 28542,
    SPELL_LIFE_DRAIN_25             = 55665,
    SPELL_BERSERK                   = 26662,

    // Ice block
    SPELL_ICEBOLT_CAST              = 28526,
    SPELL_ICEBOLT_TRIGGER           = 28522,
    SPELL_FROST_MISSILE             = 30101,
    SPELL_FROST_EXPLOSION           = 28524,

    // Visuals
    SPELL_SAPPHIRON_DIES            = 29357
};

enum Misc
{
    GO_ICE_BLOCK                    = 181247,
    NPC_BLIZZARD                    = 16474,

    POINT_CENTER                    = 1
};

enum Events
{
    EVENT_BERSERK                   = 1,
    EVENT_CLEAVE                    = 2,
    EVENT_TAIL_SWEEP                = 3,
    EVENT_LIFE_DRAIN                = 4,
    EVENT_BLIZZARD                  = 5,
    EVENT_FLIGHT_START              = 6,
    EVENT_FLIGHT_LIFTOFF            = 7,
    EVENT_FLIGHT_ICEBOLT            = 8,
    EVENT_FLIGHT_BREATH             = 9,
    EVENT_FLIGHT_SPELL_EXPLOSION    = 10,
    EVENT_FLIGHT_START_LAND         = 11,
    EVENT_LAND                      = 12,
    EVENT_GROUND                    = 13,
    EVENT_HUNDRED_CLUB              = 14
};

class boss_sapphiron : public CreatureScript
{
public:
    boss_sapphiron() : CreatureScript("boss_sapphiron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_sapphironAI>(pCreature);
    }

    struct boss_sapphironAI : public BossAI
    {
        explicit boss_sapphironAI(Creature* c) : BossAI(c, BOSS_SAPPHIRON)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* pInstance;
        uint8 iceboltCount{};
        uint32 spawnTimer{};
        GuidList blockList;
        ObjectGuid currentTarget;

        void InitializeAI() override
        {
            me->SummonGameObject(GO_SAPPHIRON_BIRTH, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 0, 0);
            me->SetVisible(false);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
            ScriptedAI::InitializeAI();
        }

        bool IsInRoom()
        {
            if (me->GetExactDist(3523.5f, -5235.3f, 137.6f) > 100.0f)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            if (me->IsVisible())
            {
                me->SetReactState(REACT_AGGRESSIVE);
            }
            events.Reset();
            iceboltCount = 0;
            spawnTimer = 0;
            currentTarget.Clear();
            blockList.clear();
        }

        void EnterCombatSelfFunction()
        {
            Map::PlayerList const& PlList = me->GetMap()->GetPlayers();
            if (PlList.isEmpty())
                return;

            for (const auto& i : PlList)
            {
                if (Player* player = i.GetSource())
                {
                    if (player->IsGameMaster())
                        continue;

                    if (player->IsAlive() && me->GetDistance(player) < 80.0f)
                    {
                        me->SetInCombatWith(player);
                        player->SetInCombatWith(me);
                        me->AddThreat(player, 0.0f);
                    }
                }
            }
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            EnterCombatSelfFunction();
            me->CastSpell(me, RAID_MODE(SPELL_FROST_AURA_10, SPELL_FROST_AURA_25), true);
            events.ScheduleEvent(EVENT_BERSERK, 900000);
            events.ScheduleEvent(EVENT_CLEAVE, 5000);
            events.ScheduleEvent(EVENT_TAIL_SWEEP, 10000);
            events.ScheduleEvent(EVENT_LIFE_DRAIN, 17000);
            events.ScheduleEvent(EVENT_BLIZZARD, 17000);
            events.ScheduleEvent(EVENT_FLIGHT_START, 45000);
            events.ScheduleEvent(EVENT_HUNDRED_CLUB, 5000);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            me->CastSpell(me, SPELL_SAPPHIRON_DIES, true);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SAPPHIRON_BIRTH)
            {
                spawnTimer = 1;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_CENTER)
            {
                events.ScheduleEvent(EVENT_FLIGHT_LIFTOFF, 500);
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo) override
        {
            if (spellInfo->Id == SPELL_ICEBOLT_CAST)
            {
                me->CastSpell(target, SPELL_ICEBOLT_TRIGGER, true);
            }
        }

        bool IsValidExplosionTarget(WorldObject* target)
        {
            for (ObjectGuid const& guid : blockList)
            {
                if (target->GetGUID() == guid)
                    return false;

                if (Unit* block = ObjectAccessor::GetUnit(*me, guid))
                {
                    if (block->IsInBetween(me, target, 2.0f) && block->IsWithinDist(target, 10.0f))
                        return false;
                }
            }
            return true;
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (spawnTimer)
            {
                spawnTimer += diff;
                if (spawnTimer >= 21500)
                {
                    me->SetVisible(true);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    spawnTimer = 0;
                }
                return;
            }

            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    Talk(EMOTE_ENRAGE);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    return;
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.RepeatEvent(10000);
                    return;
                case EVENT_TAIL_SWEEP:
                    me->CastSpell(me, RAID_MODE(SPELL_TAIL_SWEEP_10, SPELL_TAIL_SWEEP_25), false);
                    events.RepeatEvent(10000);
                    return;
                case EVENT_LIFE_DRAIN:
                    me->CastCustomSpell(RAID_MODE(SPELL_LIFE_DRAIN_10, SPELL_LIFE_DRAIN_25), SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5), me, false);
                    events.RepeatEvent(24000);
                    return;
                case EVENT_BLIZZARD:
                    {
                        Creature* cr;
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                        {
                            cr = me->SummonCreature(NPC_BLIZZARD, *target, TEMPSUMMON_TIMED_DESPAWN, 16000);
                        }
                        else
                        {
                            cr = me->SummonCreature(NPC_BLIZZARD, *me, TEMPSUMMON_TIMED_DESPAWN, 16000);
                        }
                        if (cr)
                        {
                            cr->GetMotionMaster()->MoveRandom(40);
                        }
                        events.RepeatEvent(RAID_MODE(8000, 6500));
                        return;
                    }
                case EVENT_FLIGHT_START:
                    if (me->HealthBelowPct(11))
                    {
                        return;
                    }
                    events.RepeatEvent(45000);
                    events.DelayEvents(35000);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(POINT_CENTER, x, y, z);
                    return;
                case EVENT_FLIGHT_LIFTOFF:
                    Talk(EMOTE_AIR_PHASE);
                    me->GetMotionMaster()->MoveIdle();
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    me->SetDisableGravity(true);
                    currentTarget.Clear();
                    events.ScheduleEvent(EVENT_FLIGHT_ICEBOLT, 3000);
                    iceboltCount = RAID_MODE(2, 3);
                    return;
                case EVENT_FLIGHT_ICEBOLT:
                    {
                        if (currentTarget)
                        {
                            if (Unit* target = ObjectAccessor::GetUnit(*me, currentTarget))
                            {
                                me->SummonGameObject(GO_ICE_BLOCK, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0);
                            }
                        }

                        std::vector<Unit*> targets;
                        auto i = me->getThreatManager().getThreatList().begin();
                        for (; i != me->getThreatManager().getThreatList().end(); ++i)
                        {
                            if ((*i)->getTarget()->GetTypeId() == TYPEID_PLAYER)
                            {
                                bool inList = false;
                                if (!blockList.empty())
                                {
                                    for (GuidList::const_iterator itr = blockList.begin(); itr != blockList.end(); ++itr)
                                    {
                                        if ((*i)->getTarget()->GetGUID() == *itr)
                                        {
                                            inList = true;
                                            break;
                                        }
                                    }
                                }
                                if (!inList)
                                {
                                    targets.push_back((*i)->getTarget());
                                }
                            }
                        }

                        if (!targets.empty() && iceboltCount)
                        {
                            auto itr = targets.begin();
                            advance(itr, urand(0, targets.size() - 1));
                            me->CastSpell(*itr, SPELL_ICEBOLT_CAST, false);
                            blockList.push_back((*itr)->GetGUID());
                            currentTarget = (*itr)->GetGUID();
                            --iceboltCount;
                            events.ScheduleEvent(EVENT_FLIGHT_ICEBOLT, (me->GetExactDist(*itr) / 13.0f)*IN_MILLISECONDS);
                        }
                        else
                        {
                            events.ScheduleEvent(EVENT_FLIGHT_BREATH, 1000);
                        }
                        return;
                    }
                case EVENT_FLIGHT_BREATH:
                    currentTarget.Clear();
                    Talk(EMOTE_BREATH);
                    me->CastSpell(me, SPELL_FROST_MISSILE, false);
                    events.ScheduleEvent(EVENT_FLIGHT_SPELL_EXPLOSION, 8500);
                    return;
                case EVENT_FLIGHT_SPELL_EXPLOSION:
                    me->CastSpell(me, SPELL_FROST_EXPLOSION, true);
                    events.ScheduleEvent(EVENT_FLIGHT_START_LAND, 3000);
                    return;
                case EVENT_FLIGHT_START_LAND:
                    if (!blockList.empty())
                    {
                        for (GuidList::const_iterator itr = blockList.begin(); itr != blockList.end(); ++itr)
                        {
                            if (Unit* block = ObjectAccessor::GetUnit(*me, *itr))
                            {
                                block->RemoveAurasDueToSpell(SPELL_ICEBOLT_TRIGGER);
                            }
                        }
                    }
                    blockList.clear();
                    me->RemoveAllGameObjects();
                    events.ScheduleEvent(EVENT_LAND, 1000);
                    return;
                case EVENT_LAND:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetDisableGravity(false);
                    events.ScheduleEvent(EVENT_GROUND, 1500);
                    return;
                case EVENT_GROUND:
                    Talk(EMOTE_GROUND_PHASE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                    return;
                case EVENT_HUNDRED_CLUB:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (const auto& itr : pList)
                        {
                            if (itr.GetSource()->GetResistance(SPELL_SCHOOL_FROST) > 100 && pInstance)
                            {
                                pInstance->SetData(DATA_HUNDRED_CLUB, 0);
                                return;
                            }
                        }
                        events.RepeatEvent(5000);
                        return;
                    }
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_sapphiron_frost_explosion : public SpellScriptLoader
{
public:
    spell_sapphiron_frost_explosion() : SpellScriptLoader("spell_sapphiron_frost_explosion") { }

    class spell_sapphiron_frost_explosion_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_sapphiron_frost_explosion_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            Unit* caster = GetCaster();
            if (!caster || !caster->ToCreature())
                return;

            std::list<WorldObject*> tmplist;
            for (auto& target : targets)
            {
                if (CAST_AI(boss_sapphiron::boss_sapphironAI, caster->ToCreature()->AI())->IsValidExplosionTarget(target))
                {
                    tmplist.push_back(target);
                }
            }
            targets.clear();
            for (auto& itr : tmplist)
            {
                targets.push_back(itr);
            }
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sapphiron_frost_explosion_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_sapphiron_frost_explosion_SpellScript();
    }
};

void AddSC_boss_sapphiron()
{
    new boss_sapphiron();
    new spell_sapphiron_frost_explosion();
}
