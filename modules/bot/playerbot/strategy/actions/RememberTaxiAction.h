#pragma once

namespace BotAI
{
	class RememberTaxiAction : public Action {
	public:
		RememberTaxiAction(PlayerbotAI* ai) : Action(ai, "remember taxi") {}

    public:
        virtual bool Execute(Event event);
    };

}