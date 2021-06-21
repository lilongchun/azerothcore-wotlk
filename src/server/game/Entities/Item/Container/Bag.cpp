/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Bag.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "UpdateData.h"

Bag::Bag(): Item()
{
    m_objectType |= TYPEMASK_CONTAINER;
    m_objectTypeId = TYPEID_CONTAINER;

    m_valuesCount = CONTAINER_END;

    memset(m_bagslot, 0, sizeof(Item*) * MAX_BAG_SIZE);
}

Bag::~Bag()
{
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
        if (Item* item = m_bagslot[i])
        {
            if (item->IsInWorld())
            {
                LOG_FATAL("entities.item", "Item %u (slot %u, bag slot %u) in bag %u (slot %u, bag slot %u, m_bagslot %u) is to be deleted but is still in world.",
                               item->GetEntry(), (uint32)item->GetSlot(), (uint32)item->GetBagSlot(),
                               GetEntry(), (uint32)GetSlot(), (uint32)GetBagSlot(), (uint32)i);
                item->RemoveFromWorld();
            }
            delete m_bagslot[i];
        }
}

void Bag::AddToWorld()
{
    Item::AddToWorld();

    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            m_bagslot[i]->AddToWorld();
}

void Bag::RemoveFromWorld()
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            m_bagslot[i]->RemoveFromWorld();

    Item::RemoveFromWorld();
}

bool Bag::Create(ObjectGuid::LowType guidlow, uint32 itemid, Player const* owner)
{
    ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(itemid);

    if (!itemProto || itemProto->ContainerSlots > MAX_BAG_SIZE)
        return false;

    Object::_Create(guidlow, 0, HighGuid::Item);

    SetEntry(itemid);
    SetObjectScale(1.0f);

    SetGuidValue(ITEM_FIELD_OWNER, owner ? owner->GetGUID() : ObjectGuid::Empty);
    SetGuidValue(ITEM_FIELD_CONTAINED, owner ? owner->GetGUID() : ObjectGuid::Empty);

    SetUInt32Value(ITEM_FIELD_MAXDURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_DURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_STACK_COUNT, 1);

    // Setting the number of Slots the Container has
    SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, itemProto->ContainerSlots);

    // Cleaning 20 slots
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
    {
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (i * 2), ObjectGuid::Empty);
        m_bagslot[i] = nullptr;
    }

    return true;
}

void Bag::SaveToDB(SQLTransaction& trans)
{
    Item::SaveToDB(trans);
}

bool Bag::LoadFromDB(ObjectGuid::LowType guid, ObjectGuid owner_guid, Field* fields, uint32 entry)
{
    if (!Item::LoadFromDB(guid, owner_guid, fields, entry))
        return false;

    ItemTemplate const* itemProto = GetTemplate(); // checked in Item::LoadFromDB
    SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, itemProto->ContainerSlots);
    // cleanup bag content related item value fields (its will be filled correctly from `character_inventory`)
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
    {
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (i * 2), ObjectGuid::Empty);
        delete m_bagslot[i];
        m_bagslot[i] = nullptr;
    }

    return true;
}

void Bag::DeleteFromDB(SQLTransaction& trans)
{
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
        if (m_bagslot[i])
            m_bagslot[i]->DeleteFromDB(trans);

    Item::DeleteFromDB(trans);
}

uint32 Bag::GetFreeSlots() const
{
    uint32 slots = 0;
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (!m_bagslot[i])
            ++slots;

    return slots;
}

void Bag::RemoveItem(uint8 slot, bool /*update*/)
{
    ASSERT(slot < MAX_BAG_SIZE);

    if (m_bagslot[slot])
        m_bagslot[slot]->SetContainer(nullptr);

    m_bagslot[slot] = nullptr;
    SetGuidValue(CONTAINER_FIELD_SLOT_1 + (slot * 2), ObjectGuid::Empty);
}

void Bag::StoreItem(uint8 slot, Item* pItem, bool /*update*/)
{
    ASSERT(slot < MAX_BAG_SIZE);

    if (pItem && pItem->GetGUID() != this->GetGUID())
    {
        m_bagslot[slot] = pItem;
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (slot * 2), pItem->GetGUID());
        pItem->SetGuidValue(ITEM_FIELD_CONTAINED, GetGUID());
        pItem->SetGuidValue(ITEM_FIELD_OWNER, GetOwnerGUID());
        pItem->SetContainer(this);
        pItem->SetSlot(slot);
    }
}

void Bag::BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) const
{
    Item::BuildCreateUpdateBlockForPlayer(data, target);

    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            m_bagslot[i]->BuildCreateUpdateBlockForPlayer(data, target);
}

// If the bag is empty returns true
bool Bag::IsEmpty() const
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            return false;

    return true;
}

uint32 Bag::GetItemCount(uint32 item, Item* eItem) const
{
    Item* pItem;
    uint32 count = 0;
    for (uint32 i = 0; i < GetBagSize(); ++i)
    {
        pItem = m_bagslot[i];
        if (pItem && pItem != eItem && pItem->GetEntry() == item)
            count += pItem->GetCount();
    }

    if (eItem && eItem->GetTemplate()->GemProperties)
    {
        for (uint32 i = 0; i < GetBagSize(); ++i)
        {
            pItem = m_bagslot[i];
            if (pItem && pItem != eItem && pItem->GetTemplate()->Socket[0].Color)
                count += pItem->GetGemCountWithID(item);
        }
    }

    return count;
}

uint32 Bag::GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem) const
{
    uint32 count = 0;
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (Item* pItem = m_bagslot[i])
            if (pItem != skipItem)
                if (ItemTemplate const* pProto = pItem->GetTemplate())
                    if (pProto->ItemLimitCategory == limitCategory)
                        count += m_bagslot[i]->GetCount();

    return count;
}

uint8 Bag::GetSlotByItemGUID(ObjectGuid guid) const
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i] != 0)
            if (m_bagslot[i]->GetGUID() == guid)
                return i;

    return NULL_SLOT;
}

Item* Bag::GetItemByPos(uint8 slot) const
{
    if (slot < GetBagSize())
        return m_bagslot[slot];

    return nullptr;
}
