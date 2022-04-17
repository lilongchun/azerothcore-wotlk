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

#include "Mail.h"
#include "ObjectMgr.h"
#include "QueryResult.h"

class ServerMailReward : public PlayerScript
{
public:
    ServerMailReward() : PlayerScript("ServerMailReward") { }

    // CHARACTER_LOGIN = 8
    void OnLogin(Player* player) override
    {
        for (auto const& servMail : sObjectMgr->GetAllServerMailStore())
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL_SERVER_CHARACTER);
            stmt->SetData(0, player->GetGUID().GetCounter());
            stmt->SerData(1, servMail.second.id);

            PreparedQueryResult result = CharacterDatabase.Query(stmt);

            if (result)
            {
                do
                {
                    sObjectMgr->SendServerMail(player, servMail.second.id, servMail.second.reqLevel, servMail.second.reqPlayTime, servMail.second.moneyA, servMail.second.moneyH, servMail.second.itemA, servMail.second.itemCountA, servMail.second.itemH, servMail.second.itemCountH, servMail.second.subject, servMail.second.body, servMail.second.active);
                } while (result->NextRow());
            }
        }
    }
};

void AddSC_server_mail()
{
    new ServerMailReward();
}
