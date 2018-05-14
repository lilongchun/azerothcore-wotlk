#pragma once

#include "../Action.h"
#include "MovementActions.h"

namespace BotAI
{
	class FollowAction : public MovementAction {
	public:
		FollowAction(PlayerbotAI* ai) : MovementAction(ai, "follow") {}
		virtual bool Execute(Event event);
        virtual bool isUseful();
	};
}
