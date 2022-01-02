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

#ifndef _AUCTION_HOUSE_MGR_H
#define _AUCTION_HOUSE_MGR_H

#include "Common.h"
#include "DBCStructure.h"
#include "DatabaseEnv.h"
#include "EventProcessor.h"
#include "ObjectGuid.h"
#include "WorldPacket.h"
#include <unordered_map>

class Item;
class Player;

#define MIN_AUCTION_TIME (12*HOUR)
#define MAX_AUCTION_ITEMS 160

enum AuctionError
{
    ERR_AUCTION_OK                  = 0,
    ERR_AUCTION_INVENTORY           = 1,
    ERR_AUCTION_DATABASE_ERROR      = 2,
    ERR_AUCTION_NOT_ENOUGHT_MONEY   = 3,
    ERR_AUCTION_ITEM_NOT_FOUND      = 4,
    ERR_AUCTION_HIGHER_BID          = 5,
    ERR_AUCTION_BID_INCREMENT       = 7,
    ERR_AUCTION_BID_OWN             = 10,
    ERR_AUCTION_RESTRICTED_ACCOUNT  = 13
};

enum AuctionAction
{
    AUCTION_SELL_ITEM   = 0,
    AUCTION_CANCEL      = 1,
    AUCTION_PLACE_BID   = 2
};

enum MailAuctionAnswers
{
    AUCTION_OUTBIDDED           = 0,
    AUCTION_WON                 = 1,
    AUCTION_SUCCESSFUL          = 2,
    AUCTION_EXPIRED             = 3,
    AUCTION_CANCELLED_TO_BIDDER = 4,
    AUCTION_CANCELED            = 5,
    AUCTION_SALE_PENDING        = 6
};

enum AuctionHouses
{
    AUCTIONHOUSE_ALLIANCE       = 2,
    AUCTIONHOUSE_HORDE          = 6,
    AUCTIONHOUSE_NEUTRAL        = 7
};

enum AuctionSortOrder
{
    AUCTION_SORT_MINLEVEL       = 0,
    AUCTION_SORT_RARITY         = 1,
    AUCTION_SORT_BUYOUT         = 2,
    AUCTION_SORT_TIMELEFT       = 3,
    AUCTION_SORT_UNK4           = 4,
    AUCTION_SORT_ITEM           = 5,
    AUCTION_SORT_MINBIDBUY      = 6,
    AUCTION_SORT_OWNER          = 7,
    AUCTION_SORT_BID            = 8,
    AUCTION_SORT_STACK          = 9,
    AUCTION_SORT_BUYOUT_2       = 10,

    AUCTION_SORT_MAX
};

struct AuctionSortInfo
{
    AuctionSortInfo()  = default;

    AuctionSortOrder sortOrder{AUCTION_SORT_MAX};
    bool isDesc{true};
};

typedef std::vector<AuctionSortInfo> AuctionSortOrderVector;

struct AuctionEntry
{
    uint32 Id;
    uint8 houseId;
    ObjectGuid item_guid;
    uint32 item_template;
    uint32 itemCount;
    ObjectGuid owner;
    uint32 startbid;                                        //maybe useless
    uint32 bid;
    uint32 buyout;
    time_t expire_time;
    ObjectGuid bidder;
    uint32 deposit;                                         //deposit can be calculated only when creating auction
    AuctionHouseEntry const* auctionHouseEntry;             // in AuctionHouse.dbc

    // helpers
    [[nodiscard]] auto GetHouseId() const -> uint8 { return houseId; }
    [[nodiscard]] auto GetAuctionCut() const -> uint32;
    [[nodiscard]] auto GetAuctionOutBid() const -> uint32;
    auto BuildAuctionInfo(WorldPacket& data) const -> bool;
    void DeleteFromDB(CharacterDatabaseTransaction trans) const;
    void SaveToDB(CharacterDatabaseTransaction trans) const;
    auto LoadFromDB(Field* fields) -> bool;
    [[nodiscard]] auto BuildAuctionMailSubject(MailAuctionAnswers response) const -> std::string;
    static auto BuildAuctionMailBody(ObjectGuid guid, uint32 bid, uint32 buyout, uint32 deposit = 0, uint32 cut = 0, uint32 moneyDelay = 0, uint32 eta = 0) -> std::string;
};

//this class is used as auctionhouse instance
class AuctionHouseObject
{
public:
    // Initialize storage
    AuctionHouseObject() { next = AuctionsMap.begin(); }
    ~AuctionHouseObject()
    {
        for (auto & itr : AuctionsMap)
            delete itr.second;
    }

    typedef std::map<uint32, AuctionEntry*> AuctionEntryMap;

    [[nodiscard]] auto Getcount() const -> uint32 { return AuctionsMap.size(); }

    auto GetAuctionsBegin() -> AuctionEntryMap::iterator { return AuctionsMap.begin(); }
    auto GetAuctionsEnd() -> AuctionEntryMap::iterator { return AuctionsMap.end(); }
    auto GetAuctions() -> AuctionEntryMap const& { return AuctionsMap; }

    [[nodiscard]] auto GetAuction(uint32 id) const -> AuctionEntry*
    {
        AuctionEntryMap::const_iterator itr = AuctionsMap.find(id);
        return itr != AuctionsMap.end() ? itr->second : nullptr;
    }

    void AddAuction(AuctionEntry* auction);

    auto RemoveAuction(AuctionEntry* auction) -> bool;

    void Update();

    void BuildListBidderItems(WorldPacket& data, Player* player, uint32& count, uint32& totalcount);
    void BuildListOwnerItems(WorldPacket& data, Player* player, uint32& count, uint32& totalcount);
    auto BuildListAuctionItems(WorldPacket& data, Player* player,
                               std::wstring const& searchedname, uint32 listfrom, uint8 levelmin, uint8 levelmax, uint8 usable,
                               uint32 inventoryType, uint32 itemClass, uint32 itemSubClass, uint32 quality,
                               uint32& count, uint32& totalcount, uint8 getAll, AuctionSortOrderVector const& sortOrder) -> bool;

private:
    AuctionEntryMap AuctionsMap;

    // storage for "next" auction item for next Update()
    AuctionEntryMap::const_iterator next;
};

class AuctionHouseMgr
{
private:
    AuctionHouseMgr();
    ~AuctionHouseMgr();

public:
    typedef std::unordered_map<ObjectGuid, Item*> ItemMap;

    static auto instance() -> AuctionHouseMgr*;

    auto GetAuctionsMap(uint32 factionTemplateId) -> AuctionHouseObject*;
    auto GetAuctionsMapByHouseId(uint8 auctionHouseId) -> AuctionHouseObject*;
    auto GetBidsMap(uint32 factionTemplateId) -> AuctionHouseObject*;

    auto GetAItem(ObjectGuid itemGuid) -> Item*
    {
        ItemMap::const_iterator itr = mAitems.find(itemGuid);
        if (itr != mAitems.end())
            return itr->second;

        return nullptr;
    }

    //auction messages
    void SendAuctionWonMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionSalePendingMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);
    void SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionExpiredMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionOutbiddedMail(AuctionEntry* auction, uint32 newPrice, Player* newBidder, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionCancelledToBidderMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);

    static auto GetAuctionDeposit(AuctionHouseEntry const* entry, uint32 time, Item* pItem, uint32 count) -> uint32;
    static auto GetAuctionHouseEntry(uint32 factionTemplateId) -> AuctionHouseEntry const*;
    static auto GetAuctionHouseEntryFromHouse(uint8 houseId) -> AuctionHouseEntry const*;

public:
    //load first auction items, because of check if item exists, when loading
    void LoadAuctionItems();
    void LoadAuctions();

    void AddAItem(Item* it);
    auto RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB = false, CharacterDatabaseTransaction* trans = nullptr) -> bool;

    void Update();

private:
    AuctionHouseObject mHordeAuctions;
    AuctionHouseObject mAllianceAuctions;
    AuctionHouseObject mNeutralAuctions;

    ItemMap mAitems;
};

#define sAuctionMgr AuctionHouseMgr::instance()

#endif
