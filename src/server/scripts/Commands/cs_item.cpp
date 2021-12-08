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
Name: item_commandscript
%Complete: 0
Comment: All item related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Language.h"

using namespace Acore::ChatCommands;

class item_commandscript : public CommandScript
{
public:
    item_commandscript() : CommandScript("item_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable HandleItemRestoreCommandTable =
        {
            { "list",      HandleItemRestoreListCommand,        SEC_GAMEMASTER,    Console::Yes },
            { "",          HandleItemRestoreCommand,            SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable itemCommandTable =
        {
            { "restore",   HandleItemRestoreCommandTable },
            { "move",      HandleItemMoveCommand,               SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "item",      itemCommandTable }
        };
        return commandTable;
    }

    static bool HandleItemRestoreCommand(ChatHandler* handler, PlayerIdentifier player, uint32 restoreId)
    {
        if (!restoreId)
        {
            return false;
        }

        if (!HasItemDeletionConfig())
        {
            handler->SendSysMessage(LANG_COMMAND_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Check existence of item in recovery table
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM);
        stmt->setUInt32(0, restoreId);
        PreparedQueryResult fields = CharacterDatabase.Query(stmt);

        if (!fields || !(*fields)[0].GetUInt32())
        {
            handler->SendSysMessage(LANG_ITEM_RESTORE_MISSING);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Mail item to player
        uint32 itemEntry  = (*fields)[0].GetUInt32();
        uint32 itemCount = (*fields)[0].GetUInt32();
        MailSender sender(MAIL_NORMAL, player.GetGUID().GetCounter(), MAIL_STATIONERY_GM);
        MailDraft draft("subject", "text");

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        // Save to prevent loss at next mail load. Item deletes on fail
        if (Item* item = Item::CreateItem(itemEntry, itemCount, 0))
        {
            item->SaveToDB(trans);
            draft.AddItem(item);
        }

        draft.SendMailTo(trans, MailReceiver(player.GetGUID().GetCounter()), sender);
        CharacterDatabase.CommitTransaction(trans);

        // Remove from recovery table
        CharacterDatabasePreparedStatement* delStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM_BY_RECOVERY_ID);
        delStmt->setUInt32(0, player.GetGUID().GetCounter());
        CharacterDatabase.Execute(delStmt);

        std::string nameLink = handler->playerLink(player.GetName());
        handler->PSendSysMessage(LANG_MAIL_SENT, nameLink.c_str());
        return true;
    }

    static bool HandleItemRestoreListCommand(ChatHandler* handler, PlayerIdentifier player)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM_LIST);
        stmt->setUInt32(0, player.GetGUID().GetCounter());
        PreparedQueryResult disposedItems = CharacterDatabase.Query(stmt);

        if (!disposedItems)
        {
            handler->SendSysMessage(LANG_ITEM_RESTORE_LIST_EMPTY);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Field* fields = disposedItems->Fetch();
        do {
            uint32 id        = fields[0].GetUInt32();
            uint32 itemId    = fields[1].GetUInt32();
            uint32 count     = fields[2].GetUInt32();
            handler->PSendSysMessage(LANG_ITEM_RESTORE_LIST, id, itemId, count);
        } while (disposedItems->NextRow());

        return true;
    }

    // TODO - move item to other slot
    static bool HandleItemMoveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* param1 = strtok((char*)args, " ");
        if (!param1)
            return false;

        char const* param2 = strtok(nullptr, " ");
        if (!param2)
            return false;

        uint8 srcSlot = uint8(atoi(param1));
        uint8 dstSlot = uint8(atoi(param2));

        if (srcSlot == dstSlot)
            return true;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, srcSlot, true))
            return false;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, dstSlot, false))
            return false;

        uint16 src = ((INVENTORY_SLOT_BAG_0 << 8) | srcSlot);
        uint16 dst = ((INVENTORY_SLOT_BAG_0 << 8) | dstSlot);

        handler->GetSession()->GetPlayer()->SwapItem(src, dst);

        return true;
    }

    static bool HasItemDeletionConfig()
    {
      return sWorld->getBoolConfig(CONFIG_ITEMDELETE_METHOD) || sWorld->getBoolConfig(CONFIG_ITEMDELETE_VENDOR);
    }
};

void AddSC_item_commandscript()
{
    new item_commandscript();
}
