#pragma once

namespace BotAI
{
    class RacialsStrategy : public Strategy
    {
    public:
        RacialsStrategy(PlayerbotAI* ai);
        virtual string getName() { return "racials"; }
    
    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };

}