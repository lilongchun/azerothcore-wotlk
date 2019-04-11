#include "../generic/NonCombatStrategy.h"
#pragma once

namespace BotAI
{
    class AttackEnemyPlayersStrategy : public NonCombatStrategy
    {
    public:
        AttackEnemyPlayersStrategy(PlayerbotAI* ai) : NonCombatStrategy(ai) {}
        virtual string getName() { return "pvp"; }

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };

}
