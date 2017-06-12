#pragma once
#include "../Value.h"
#include "PartyMemberValue.h"

namespace BotAI
{
    class PartyMemberToHeal : public PartyMemberValue
	{
	public:
        PartyMemberToHeal(PlayerbotAI* ai) : 
          PartyMemberValue(ai) {}
    
    protected:
        virtual Unit* Calculate();
        bool CanHealPet(Pet* pet);
	};
}
