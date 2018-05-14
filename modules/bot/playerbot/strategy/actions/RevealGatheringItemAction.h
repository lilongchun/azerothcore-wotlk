#pragma once

#include "../Action.h"
#include "MovementActions.h"
#include "../values/LastMovementValue.h"

namespace BotAI
{
    class RevealGatheringItemAction : public Action {
    public:
        RevealGatheringItemAction(PlayerbotAI* ai) : Action(ai, "reveal gathering item") {}

        virtual bool Execute(Event event);
    };

}
