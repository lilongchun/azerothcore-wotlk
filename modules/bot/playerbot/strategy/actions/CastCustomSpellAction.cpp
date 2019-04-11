#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "CastCustomSpellAction.h"

using namespace BotAI;

bool CastCustomSpellAction::Execute(Event event)
{
    Unit* target = NULL;

    Player* master = GetMaster();
    if (master)
        target = master->GetSelectedUnit();

    if (!target)
        target = bot;

    string text = event.getParam();

    uint32 spell = chat->parseSpell(text);

    ostringstream msg;
    if (!ai->CanCastSpell(spell, target))
    {
        msg << "Cannot cast " << text << " on " << target->GetName();
		bot->Say(msg.str(), LANG_UNIVERSAL);
        return false;
    }

    bool result = false;
    if (spell)
        result = ai->CastSpell(spell, target);
    else
        ai->CastSpell(text, target);

    if (result)
    {
        msg << "Casting " << text << " on " << target->GetName();
		bot->Say(msg.str(), LANG_UNIVERSAL);
    }
    else
    {
        msg << "Cast " << text << " on " << target->GetName() << " is failed";
		bot->Say(msg.str(), LANG_UNIVERSAL);
    }

    return result;
}
