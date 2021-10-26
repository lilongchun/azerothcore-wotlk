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
Name: gm_commandscript
%Complete: 100
Comment: All gm related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "Chat.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "Realm.h"
#include "ScriptMgr.h"
#include "World.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class gm_commandscript : public CommandScript
{
public:
    gm_commandscript() : CommandScript("gm_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable gmCommandTable =
        {
            { "chat",           SEC_GAMEMASTER,      false, &HandleGMChatCommand,              "" },
            { "fly",            SEC_GAMEMASTER,      false, &HandleGMFlyCommand,               "" },
            { "ingame",         SEC_PLAYER,          true,  &HandleGMListIngameCommand,        "" },
            { "list",           SEC_GAMEMASTER,      true,  &HandleGMListFullCommand,          "" },
            { "visible",        SEC_GAMEMASTER,      false, &HandleGMVisibleCommand,           "" },
            { "",               SEC_MODERATOR,       false, &HandleGMCommand,                  "" }
        };
        static ChatCommandTable commandTable =
        {
            { "gm",             SEC_MODERATOR,      false, nullptr,                     "", gmCommandTable }
        };
        return commandTable;
    }

    // Enables or disables hiding of the staff badge
    static bool HandleGMChatCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            WorldSession* session = handler->GetSession();
            if (!AccountMgr::IsPlayerAccount(session->GetSecurity()) && session->GetPlayer()->isGMChat())
                session->SendNotification(LANG_GM_CHAT_ON);
            else
                session->SendNotification(LANG_GM_CHAT_OFF);
            return true;
        }

        std::string param = (char*)args;

        if (param == "on")
        {
            handler->GetSession()->GetPlayer()->SetGMChat(true);
            handler->GetSession()->SendNotification(LANG_GM_CHAT_ON);
            return true;
        }

        if (param == "off")
        {
            handler->GetSession()->GetPlayer()->SetGMChat(false);
            handler->GetSession()->SendNotification(LANG_GM_CHAT_OFF);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleGMFlyCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target =  handler->getSelectedPlayer();
        if (!target || AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();

        WorldPacket data(12);
        if (strncmp(args, "on", 3) == 0)
        {
            data.SetOpcode(SMSG_MOVE_SET_CAN_FLY);
            sScriptMgr->AnticheatSetCanFlybyServer(target, true);
        }
        else if (strncmp(args, "off", 4) == 0)
        {
            data.SetOpcode(SMSG_MOVE_UNSET_CAN_FLY);
            sScriptMgr->AnticheatSetCanFlybyServer(target, false);
        }
        else
        {
            handler->SendSysMessage(LANG_USE_BOL);
            return false;
        }
        data << target->GetPackGUID();
        data << uint32(0);                                      // unknown
        target->SendMessageToSet(&data, true);
        handler->PSendSysMessage(LANG_COMMAND_FLYMODE_STATUS, handler->GetNameLink(target).c_str(), args);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleGMListIngameCommand(ChatHandler* handler, char const* /*args*/)
    {
        bool first = true;
        bool footer = false;

        std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
        HashMapHolder<Player>::MapType const& m = ObjectAccessor::GetPlayers();
        for (HashMapHolder<Player>::MapType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
        {
            AccountTypes itrSec = itr->second->GetSession()->GetSecurity();
            if ((itr->second->IsGameMaster() || (!AccountMgr::IsPlayerAccount(itrSec) && itrSec <= AccountTypes(sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_GM_LIST)))) &&
                    (!handler->GetSession() || itr->second->IsVisibleGloballyFor(handler->GetSession()->GetPlayer())))
            {
                if (first)
                {
                    first = false;
                    footer = true;
                    handler->SendSysMessage(LANG_GMS_ON_SRV);
                    handler->SendSysMessage("========================");
                }
                std::string const& name = itr->second->GetName();
                uint8 size = name.size();
                uint8 security = itrSec;
                uint8 max = ((16 - size) / 2);
                uint8 max2 = max;
                if ((max + max2 + size) == 16)
                    max2 = max - 1;
                if (handler->GetSession())
                    handler->PSendSysMessage("|    %s GMLevel %u", name.c_str(), security);
                else
                    handler->PSendSysMessage("|%*s%s%*s|   %u  |", max, " ", name.c_str(), max2, " ", security);
            }
        }
        if (footer)
            handler->SendSysMessage("========================");
        if (first)
            handler->SendSysMessage(LANG_GMS_NOT_LOGGED);
        return true;
    }

    /// Display the list of GMs
    static bool HandleGMListFullCommand(ChatHandler* handler, char const* /*args*/)
    {
        ///- Get the accounts with GM Level >0
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_GM_ACCOUNTS);
        stmt->setUInt8(0, uint8(SEC_MODERATOR));
        stmt->setInt32(1, int32(realm.Id.Realm));
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        if (result)
        {
            handler->SendSysMessage(LANG_GMLIST);
            handler->SendSysMessage("========================");
            ///- Cycle through them. Display username and GM level
            do
            {
                Field* fields = result->Fetch();
                char const* name = fields[0].GetCString();
                uint8 security = fields[1].GetUInt8();
                uint8 max = (16 - strlen(name)) / 2;
                uint8 max2 = max;
                if ((max + max2 + strlen(name)) == 16)
                    max2 = max - 1;
                if (handler->GetSession())
                    handler->PSendSysMessage("|    %s GMLevel %u", name, security);
                else
                    handler->PSendSysMessage("|%*s%s%*s|   %u  |", max, " ", name, max2, " ", security);
            } while (result->NextRow());
            handler->SendSysMessage("========================");
        }
        else
            handler->PSendSysMessage(LANG_GMLIST_EMPTY);
        return true;
    }

    //Enable\Disable Invisible mode
    static bool HandleGMVisibleCommand(ChatHandler* handler, char const* args)
    {
        Player* _player = handler->GetSession()->GetPlayer();

        if (!*args)
        {
            handler->PSendSysMessage(LANG_YOU_ARE, _player->isGMVisible() ? handler->GetAcoreString(LANG_VISIBLE) : handler->GetAcoreString(LANG_INVISIBLE));
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string param = (char*)args;

        if (param == "on")
        {
            _player->SetGMVisible(true);
            //_player->UpdateObjectVisibility();
            handler->GetSession()->SendNotification(LANG_INVISIBLE_VISIBLE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (param == "off")
        {
            _player->SetGMVisible(false);
            //_player->UpdateObjectVisibility();
            handler->GetSession()->SendNotification(LANG_INVISIBLE_INVISIBLE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    //Enable\Disable GM Mode
    static bool HandleGMCommand(ChatHandler* handler, char const* args)
    {
        Player* _player = handler->GetSession()->GetPlayer();

        if (!*args)
        {
            handler->GetSession()->SendNotification(_player->IsGameMaster() ? LANG_GM_ON : LANG_GM_OFF);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string param = (char*)args;

        if (param == "on")
        {
            _player->SetGameMaster(true);
            handler->GetSession()->SendNotification(LANG_GM_ON);
            _player->UpdateTriggerVisibility();
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (param == "off")
        {
            _player->SetGameMaster(false);
            handler->GetSession()->SendNotification(LANG_GM_OFF);
            _player->UpdateTriggerVisibility();
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }
};

void AddSC_gm_commandscript()
{
    new gm_commandscript();
}
