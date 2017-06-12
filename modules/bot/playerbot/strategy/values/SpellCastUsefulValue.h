#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{
   
    class SpellCastUsefulValue : public BoolCalculatedValue, public Qualified
	{
	public:
        SpellCastUsefulValue(PlayerbotAI* ai) : BoolCalculatedValue(ai) {}
      
    public:
        virtual bool Calculate();

    };
}
