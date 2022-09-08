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

/* ScriptData
SDName: Boss_Cthun
SD%Complete: 95
SDComment: Darkglare tracking issue
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    // ***** Main Phase 1 ********
    //Eye Spells
    SPELL_FREEZE_ANIM                           = 16245,
    SPELL_GREEN_BEAM                            = 26134,
    SPELL_DARK_GLARE                            = 26029,
    SPELL_RED_COLORATION                        = 22518,        //Probably not the right spell but looks similar

    //Eye Tentacles Spells
    SPELL_MIND_FLAY                             = 26143,

    //Claw Tentacles Spells
    SPELL_GROUND_RUPTURE                        = 26139,
    SPELL_HAMSTRING                             = 26141,

    // ***** Main Phase 2 ******
    //Body spells
    SPELL_CARAPACE_CTHUN                        = 26156,     // Server-side
    SPELL_TRANSFORM                             = 26232,
    SPELL_PURPLE_COLORATION                     = 22581,     //Probably not the right spell but looks similar

    //Eye Tentacles Spells
    //SAME AS PHASE1

    //Giant Claw Tentacles
    SPELL_MASSIVE_GROUND_RUPTURE                = 26478,

    //Also casts Hamstring
    SPELL_THRASH                                = 3391,

    //Giant Eye Tentacles
    //CHAIN CASTS "SPELL_GREEN_BEAM"

    //Stomach Spells
    SPELL_MOUTH_TENTACLE                        = 26332,
    SPELL_EXIT_STOMACH_KNOCKBACK                = 25383,
    SPELL_DIGESTIVE_ACID                        = 26476,

    // Tentacles
    SPELL_SUBMERGE_VISUAL                       = 26234,
    SPELL_BIRTH                                 = 26262,

    // Areatriggers
    SPELL_SPIT_OUT                              = 25383,
    SPELL_EXIT_STOMACH                          = 26221,
    SPELL_RUBBLE_ROCKY                          = 26271
};

enum Actions
{
    ACTION_FLESH_TENTACLE_KILLED                = 1,

    ACTION_SPAWN_EYE_TENTACLES                  = 1,
};

enum Misc
{
    MAX_TENTACLE_GROUPS                         = 5,
    GROUP_BEAM_PHASE                            = 1,
    NPC_TRIGGER                                 = 15384,
    PHASE_BODY                                  = 2
};

enum Yells
{
    //Text emote
    EMOTE_WEAKENED                              = 0,

    // ****** Out of Combat ******
    // Random Wispers - No txt only sound
    // The random sound is chosen by the client.
    RANDOM_SOUND_WHISPER                        = 8663,
};

//Stomach Teleport positions
#define STOMACH_X                           -8562.0f
#define STOMACH_Y                           2037.0f
#define STOMACH_Z                           -70.0f
#define STOMACH_O                           5.05f

//Flesh tentacle positions
const Position FleshTentaclePos[2] =
{
    { -8571.0f, 1990.0f, -98.0f, 1.22f},
    { -8525.0f, 1994.0f, -98.0f, 2.12f},
};

class NotInStomachSelector
{
public:
    NotInStomachSelector() { }

    bool operator()(Unit* unit) const
    {
        if (unit->GetTypeId() != TYPEID_PLAYER || unit->HasAura(SPELL_DIGESTIVE_ACID))
            return false;

        return true;
    }
};

//Kick out position
const Position KickPos = { -8545.0f, 1984.0f, -96.0f, 0.0f};

struct boss_eye_of_cthun : public BossAI
{
    boss_eye_of_cthun(Creature* creature) : BossAI(creature, DATA_CTHUN), _summons(creature)
    {
        SetCombatMovement(false);
    }

    void Reset() override
    {
        //Dark Beam phase 35 seconds (each tick = 1 second, 35 ticks)
        DarkGlareTick = 0;
        DarkGlareAngle = 0;
        ClockWise = false;

        _eyeTentacleCounter = 0;

        //Reset flags
        me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);
        me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetVisible(true);

        //Reset Phase
        instance->SetData(DATA_CTHUN_PHASE, PHASE_NOT_STARTED);

        //to avoid having a following void zone
        Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10);
        if (pPortal)
            pPortal->SetReactState(REACT_PASSIVE);

        _summons.DespawnAll();
        _scheduler.CancelAll();

        BossAI::Reset();
    }

    void JustDied(Unit* /*killer*/) override { }

    void EnterCombat(Unit* who) override
    {
        DoZoneInCombat();
        ScheduleTasks();
        instance->SetData(DATA_CTHUN_PHASE, PHASE_EYE_GREEN_BEAM);
        BossAI::EnterCombat(who);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->GetTypeId() == TYPEID_PLAYER && !me->IsInCombat())
        {
            // Z checks are necessary here because AQ maps do funky stuff.
            if (me->IsWithinLOSInMap(who) && me->IsWithinDist2d(who, 50.0f) && who->GetPositionZ() > 100.0f)
            {
                AttackStart(who);
            }
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_SPAWN_EYE_TENTACLES)
        {
            me->SummonCreatureGroup(_eyeTentacleCounter);
            _eyeTentacleCounter++;

            if (_eyeTentacleCounter >= MAX_TENTACLE_GROUPS)
            {
                _eyeTentacleCounter = 0;
            }
        }
    }

    void ScheduleTasks()
    {
        _scheduler.
            Schedule(3s, [this](TaskContext task)
            {
                DoCastRandomTarget(SPELL_GREEN_BEAM);
                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            })
            .Schedule(12s, [this](TaskContext task)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    if (Creature* tentacle = me->SummonCreature(NPC_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 1000))
                    {
                        tentacle->AI()->AttackStart(target);
                    }
                }

                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            })
            .Schedule(45s, [this](TaskContext task)
            {
                DoAction(ACTION_SPAWN_EYE_TENTACLES);
                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            })
            .Schedule(50s, [this](TaskContext /*task*/)
            {
                _scheduler.CancelGroup(GROUP_BEAM_PHASE);

                me->StopMoving();
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(false);
                me->SetTarget(ObjectGuid::Empty);

                _scheduler.Schedule(1s, [this](TaskContext /*task*/)
                {
                    //Select random target for dark beam to start on
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        //Face our target
                        DarkGlareAngle = me->GetAngle(target);
                        DarkGlareTick = 0;
                        ClockWise = RAND(true, false);

                        me->SetTarget(target->GetGUID());

                        //Add red coloration to C'thun
                        DoCast(me, SPELL_RED_COLORATION, true);

                        //Freeze animation
                        DoCast(me, SPELL_FREEZE_ANIM, true);

                        me->StopMoving();
                        me->SetFacingToObject(target);
                        me->SetOrientation(DarkGlareAngle);
                    }

                    _scheduler.Schedule(3s, [this](TaskContext tasker)
                    {
                        me->SetTarget(ObjectGuid::Empty);
                        me->StopMoving();

                        if (ClockWise)
                        {
                            me->SetFacingTo(DarkGlareAngle + DarkGlareTick * float(M_PI) / 35);
                            me->SetOrientation(DarkGlareAngle + DarkGlareTick * float(M_PI) / 35);

                        }
                        else
                        {
                            me->SetFacingTo(DarkGlareAngle - DarkGlareTick * float(M_PI) / 35);
                            me->SetOrientation(DarkGlareAngle - DarkGlareTick * float(M_PI) / 35);
                        }

                        DoCastSelf(SPELL_DARK_GLARE);
                        ++DarkGlareTick;

                        if (tasker.GetRepeatCounter() >= 35)
                        {
                            _scheduler.CancelAll();
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);
                            me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                            me->InterruptNonMeleeSpells(false);
                            ScheduleTasks();
                        }
                        else
                            tasker.Repeat(1s);
                    });
                });
            });
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        summon->SetInCombatWithZone();
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        switch (instance->GetData(DATA_CTHUN_PHASE))
        {
            //Transition phase
            case PHASE_CTHUN_TRANSITION:
                //Remove any target
                me->SetTarget();
                me->SetHealth(0);
                me->SetVisible(false);
                break;

            //Dead phase
            case PHASE_CTHUN_DONE:
                if (Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10))
                {
                    pPortal->DespawnOrUnsummon();
                }

                me->DespawnOrUnsummon();
                break;
        }

        _scheduler.Update(diff);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        switch (instance->GetData(DATA_CTHUN_PHASE))
        {
            case PHASE_EYE_GREEN_BEAM:
            case PHASE_EYE_RED_BEAM:
                //Only if it will kill
                if (damage < me->GetHealth())
                    return;

                //Fake death in phase 0 or 1 (green beam or dark glare phase)
                me->InterruptNonMeleeSpells(false);

                //Remove Red coloration from c'thun
                me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);

                //Reset to normal emote state and prevent select and attack
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                //Remove Target field
                me->SetTarget();

                //Death animation/respawning;
                instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_TRANSITION);

                me->SetHealth(0);
                damage = 0;

                me->InterruptNonMeleeSpells(true);
                me->RemoveAllAuras();
                _scheduler.CancelAll();
                break;

            case PHASE_CTHUN_DONE:
                //Allow death here
                return;

            default:
                //Prevent death in these phases
                damage = 0;
                return;
        }
    }

private:
    //Dark Glare phase
    uint32 DarkGlareTick;
    float DarkGlareAngle;
    bool ClockWise;

    uint32 _eyeTentacleCounter;
    TaskScheduler _scheduler;
    SummonList _summons;
};

struct boss_cthun : public BossAI
{
    boss_cthun(Creature* creature) : BossAI(creature, DATA_CTHUN)
    {
        SetCombatMovement(false);
    }

    //Out of combat whisper timer
    uint32 WisperTimer;

    //Global variables
    uint32 PhaseTimer;

    //-------------------

    //Phase transition
    ObjectGuid HoldPlayer;

    //Body Phase
    uint32 EyeTentacleTimer;
    uint8 _fleshTentaclesKilled;
    uint32 GiantClawTentacleTimer;
    uint32 GiantEyeTentacleTimer;
    TaskScheduler _scheduler;

    void Reset() override
    {
        //One random wisper every 90 - 300 seconds
        WisperTimer = 90000;

        //Phase information
        PhaseTimer = 10000;                                 //Emerge in 10 seconds

        //No hold player for transition
        HoldPlayer.Clear();

        //Body Phase
        EyeTentacleTimer = 30000;
        _fleshTentaclesKilled = 0;
        GiantClawTentacleTimer = 15000;                     //15 seconds into body phase (1 min repeat)
        GiantEyeTentacleTimer = 45000;                      //15 seconds into body phase (1 min repeat)

        //Reset flags
        me->RemoveAurasDueToSpell(SPELL_TRANSFORM);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetVisible(false);

        instance->SetData(DATA_CTHUN_PHASE, PHASE_NOT_STARTED);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void ScheduleTasks(uint8 phase)
    {
        switch (phase)
        {
            case PHASE_BODY:
                _scheduler.Schedule(13800ms, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_DIGESTIVE_ACID))
                    {
                        target->CastSpell(target, SPELL_MOUTH_TENTACLE, true, nullptr, nullptr, me->GetGUID());

                        target->m_Events.AddEventAtOffset([target, this]()
                        {
                            DoTeleportPlayer(target, STOMACH_X, STOMACH_Y, STOMACH_Z, STOMACH_O);
                            //Cast digestive acid on them
                            DoCast(target, SPELL_DIGESTIVE_ACID, true);
                        }, 3800ms);
                    }

                    context.Repeat();
                });
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
        {
            //No target so we'll use this section to do our random wispers instance wide
            //WisperTimer
            if (WisperTimer <= diff)
            {
                Map* map = me->GetMap();
                if (!map->IsDungeon())
                    return;

                //Play random sound to the zone
                Map::PlayerList const& PlayerList = map->GetPlayers();

                if (!PlayerList.IsEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
                    {
                        if (Player* pPlr = itr->GetSource())
                            pPlr->PlayDirectSound(RANDOM_SOUND_WHISPER, pPlr);
                    }
                }

                //One random wisper every 90 - 300 seconds
                WisperTimer = urand(90000, 300000);
            }
            else WisperTimer -= diff;

            return;
        }

        me->SetTarget();

        uint32 currentPhase = instance->GetData(DATA_CTHUN_PHASE);
        if (currentPhase == PHASE_CTHUN_STOMACH || currentPhase == PHASE_CTHUN_WEAK)
        {
            // EyeTentacleTimer
            if (EyeTentacleTimer <= diff)
            {
                if (Creature* eye = instance->GetCreature(DATA_EYE_OF_CTHUN))
                {
                    eye->AI()->DoAction(ACTION_SPAWN_EYE_TENTACLES);
                }

                EyeTentacleTimer = 30000; // every 30sec in phase 2
            }
            else EyeTentacleTimer -= diff;
        }

        switch (currentPhase)
        {
                //Transition phase
            case PHASE_CTHUN_TRANSITION:
                //PhaseTimer
                if (PhaseTimer <= diff)
                {
                    //Switch
                    instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_STOMACH);

                    //Switch to c'thun model
                    me->InterruptNonMeleeSpells(false);
                    DoCast(me, SPELL_TRANSFORM, false);
                    me->SetFullHealth();

                    me->SetVisible(true);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                    //Emerging phase
                    //AttackStart(ObjectAccessor::GetUnit(*me, HoldpPlayer));
                    DoZoneInCombat();

                    //Spawn flesh tentacle
                    for (uint8 i = 0; i < 2; i++)
                    {
                        me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_DESPAWN);
                    }

                    PhaseTimer = 0;
                }
                else PhaseTimer -= diff;

                break;

                //Body Phase
            case PHASE_CTHUN_STOMACH:
                //Remove Target field
                me->SetTarget();

                //GientClawTentacleTimer
                if (GiantClawTentacleTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_DIGESTIVE_ACID))
                    {
                        //Spawn claw tentacle on the random target
                        if (Creature* spawned = me->SummonCreature(NPC_GIANT_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 500))
                            if (spawned->AI())
                                spawned->AI()->AttackStart(target);
                    }

                    //One giant claw tentacle every minute
                    GiantClawTentacleTimer = 60000;
                }
                else GiantClawTentacleTimer -= diff;

                //GiantEyeTentacleTimer
                if (GiantEyeTentacleTimer <= diff)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_DIGESTIVE_ACID))
                    {
                        //Spawn claw tentacle on the random target
                        if (Creature* spawned = me->SummonCreature(NPC_GIANT_EYE_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 500))
                            if (spawned->AI())
                                spawned->AI()->AttackStart(target);
                    }

                    //One giant eye tentacle every minute
                    GiantEyeTentacleTimer = 60000;
                }
                else GiantEyeTentacleTimer -= diff;

                break;

                //Weakened state
            case PHASE_CTHUN_WEAK:
                //PhaseTimer
                if (PhaseTimer <= diff)
                {
                    //Switch
                    instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_STOMACH);

                    //Remove purple coloration
                    me->RemoveAurasDueToSpell(SPELL_PURPLE_COLORATION);

                    //Spawn flesh tentacle
                    for (uint8 i = 0; i < 2; i++)
                    {
                        me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_DESPAWN);
                    }

                    PhaseTimer = 0;
                }
                else PhaseTimer -= diff;

                break;
        }
    }

    void JustDied(Unit* killer) override
    {
        instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_DONE);
        BossAI::JustDied(killer);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        switch (instance->GetData(DATA_CTHUN_PHASE))
        {
            case PHASE_CTHUN_STOMACH:
                //Not weakened so reduce damage by 99%
                damage /= 100;
                if (damage == 0)
                    damage = 1;

                //Prevent death in non-weakened state
                if (damage >= me->GetHealth())
                    damage = 0;

                return;

            case PHASE_CTHUN_WEAK:
                //Weakened - takes normal damage
                return;

            default:
                damage = 0;
                break;
        }
    }

    void SummonedCreatureDies(Creature* creature, Unit* /*killer*/) override
    {
        if (creature->GetEntry() == NPC_FLESH_TENTACLE)
        {
            ++_fleshTentaclesKilled;

            if (_fleshTentaclesKilled > 1)
            {
                _fleshTentaclesKilled = 0;

                instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_WEAK);

                Talk(EMOTE_WEAKENED);
                PhaseTimer = 45000;

                DoCast(me, SPELL_PURPLE_COLORATION, true);
            }
        }
    }
};

struct npc_eye_tentacle : public ScriptedAI
{
    npc_eye_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();
        }

        SetCombatMovement(false);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
        {
            Unit::Kill(p, p);
        }
    }

    void Reset() override
    {
        _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_GROUND_RUPTURE);
            })
            .Schedule(5min, [this](TaskContext /*task*/)
            {
                me->DespawnOrUnsummon();
            })
            .Schedule(1s, 5s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u) { return u && u->GetTypeId() == TYPEID_PLAYER && !u->HasAura(SPELL_DIGESTIVE_ACID) && !u->HasAura(SPELL_MIND_FLAY); }))
                {
                    DoCast(target, SPELL_MIND_FLAY);
                }

                context.Repeat(10s, 15s);
            });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
    ObjectGuid _portalGUID;
};

struct npc_claw_tentacle : public ScriptedAI
{
    npc_claw_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
        {
            Unit::Kill(p, p);
        }
    }

    void Reset() override
    {
        _scheduler.Schedule(Milliseconds(500), [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_GROUND_RUPTURE);
            }).Schedule(Minutes(5), [this](TaskContext /*task*/)
            {
                me->DespawnOrUnsummon();
            });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoZoneInCombat();

        _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMSTRING);
                context.Repeat(5s);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    ObjectGuid _portalGUID;
};

struct npc_giant_claw_tentacle : public ScriptedAI
{
    npc_giant_claw_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
        {
            Unit::Kill(p, p);
        }
    }

    void Reset() override
    {
        _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
            });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoZoneInCombat();

        _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMSTRING);
                context.Repeat(10s);
            }).Schedule(5s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_THRASH);
                context.Repeat(10s);
            });
    }

    void ScheduleMeleeCheck()
    {
        // Check if a target is in melee range
        _scheduler.Schedule(10s, [this](TaskContext task)
            {
                if (Unit* target = me->GetVictim())
                {
                    if (!target->IsWithinMeleeRange(me))
                    {
                        // Main target not found within melee range, try to select a new one
                        if (Player* newTarget = me->SelectNearestPlayer(5.0f))
                        {
                            AttackStart(newTarget);
                        }
                        else // Main target not found, and failed to acquire a new target... Submerge
                        {
                            Submerge();
                        }
                    }
                }

                task.Repeat();
            });
    }

    void Submerge()
    {
        if (me->SelectNearestPlayer(5.0f))
        {
            return;
        }

        // Despawn portal
        if (Creature* p = ObjectAccessor::GetCreature(*me, _portalGUID))
        {
            p->DespawnOrUnsummon();
        }

        DoCastSelf(SPELL_SUBMERGE_VISUAL);
        me->SetHealth(me->GetMaxHealth());
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

        _scheduler.CancelAll();

        _scheduler.Schedule(5s, [this](TaskContext /*task*/)
            {
                Emerge();
            });
    }

    void Emerge()
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
        {
            Position pos = target->GetPosition();
            me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), 0);
            if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, pos, TEMPSUMMON_CORPSE_DESPAWN))
            {
                portal->SetReactState(REACT_PASSIVE);
                _portalGUID = portal->GetGUID();
            }

            me->RemoveAurasDueToSpell(SPELL_SUBMERGE_VISUAL);
            DoCastSelf(SPELL_BIRTH);
            DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE, true);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

            ScheduleMeleeCheck();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    ObjectGuid _portalGUID;
};

struct npc_giant_eye_tentacle : public ScriptedAI
{
    npc_giant_eye_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
        {
            Unit::Kill(p, p);
        }
    }

    void Reset() override
    {
        _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
            }).Schedule(1s, 5s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_DIGESTIVE_ACID))
                {
                    DoCast(target, SPELL_GREEN_BEAM);
                }

                context.Repeat(2100ms);
            });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
    ObjectGuid _portalGUID;
};

class ExitStomachPortEvent : public BasicEvent
{
public:
    ExitStomachPortEvent(Creature* invoker, ObjectGuid playerGuid) : _invoker(invoker), _playerGuid(playerGuid) { }

    bool Execute(uint64 /*time*/, uint32 /*diff*/)
    {
        if (Player* player = ObjectAccessor::GetPlayer(*_invoker, _playerGuid))
            _invoker->AI()->SetGUID(_playerGuid, 0);
        return true;
    }

private:
    Creature* _invoker;
    ObjectGuid _playerGuid;
};

class ExitStomachJumpEvent : public BasicEvent
{
public:
    ExitStomachJumpEvent(Player* invoker) : _invoker(invoker) { }

    bool Execute(uint64 /*time*/, uint32 /*diff*/)
    {
        if (_invoker)
            _invoker->JumpTo(0.0f, 80.0f, false);

        return true;
    }

private:
    Player* _invoker;
};

// 4033 - At C'thun's stomach
class at_cthun_stomach_exit : public AreaTriggerScript
{
public:
    at_cthun_stomach_exit() : AreaTriggerScript("at_cthun_stomach_exit") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
            {
                player->CastSpell(player, SPELL_RUBBLE_ROCKY, true);

                player->m_Events.AddEventAtOffset([player]()
                {
                    if (Creature* trigger = player->FindNearestCreature(NPC_TRIGGER, 15.0f))
                    {
                        trigger->CastSpell(player, SPELL_EXIT_STOMACH, true);
                    }
                }, 3s);

                cthun->m_Events.AddEvent(new ExitStomachPortEvent(cthun, player->GetGUID()), cthun->m_Events.CalculateTime(4000));
            }
        }

        return true;
    }
};

void AddSC_boss_cthun()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_eye_of_cthun);
    RegisterTempleOfAhnQirajCreatureAI(boss_cthun);
    RegisterTempleOfAhnQirajCreatureAI(npc_eye_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_claw_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_giant_claw_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_giant_eye_tentacle);
    new at_cthun_stomach_exit();
}
