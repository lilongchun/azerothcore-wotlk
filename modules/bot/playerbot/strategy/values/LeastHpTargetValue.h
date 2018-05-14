#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{
    class LeastHpTargetValue : public TargetValue
	{
	public:
        LeastHpTargetValue(PlayerbotAI* ai) : TargetValue(ai) {}

    public:
        Unit* Calculate();
    };
}
