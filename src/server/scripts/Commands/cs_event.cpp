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
 Name: event_commandscript
 %Complete: 100
 Comment: All event related commands
 Category: commandscripts
 EndScriptData */

#include "Chat.h"
#include "GameEventMgr.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Timer.h"

using namespace Acore::ChatCommands;

using EventEntry = Variant<Hyperlink<gameevent>, uint16>;

class event_commandscript : public CommandScript
{
public:
    event_commandscript() : CommandScript("event_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable eventCommandTable =
        {
            { "activelist", HandleEventActiveListCommand, SEC_GAMEMASTER, Console::Yes },
            { "start",      HandleEventStartCommand,      SEC_GAMEMASTER, Console::Yes },
            { "stop",       HandleEventStopCommand,       SEC_GAMEMASTER, Console::Yes },
            { "info",       HandleEventInfoCommand,       SEC_GAMEMASTER, Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "event", eventCommandTable }
        };
        return commandTable;
    }

    static bool HandleEventActiveListCommand(ChatHandler* handler)
    {
        uint32 counter = 0;

        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();

        char const* active = handler->GetAcoreString(LANG_ACTIVE);

        for (uint16 eventId : activeEvents)
        {
            GameEventData const& eventData = events[eventId];

            if (handler->GetSession())
            {
                handler->PSendSysMessage(LANG_EVENT_ENTRY_LIST_CHAT, eventId, eventId, eventData.description.c_str(), active);
            }
            else
            {
                handler->PSendSysMessage(LANG_EVENT_ENTRY_LIST_CONSOLE, eventId, eventData.description.c_str(), active);
            }

            ++counter;
        }

        if (counter == 0)
        {
            handler->SendSysMessage(LANG_NOEVENTFOUND);
        }

        handler->SetSentErrorMessage(true);

        return true;
    }

    static bool HandleEventInfoCommand(ChatHandler* handler, EventEntry const eventId)
    {
        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();

        if (std::size_t(eventId) >= events.size())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventData const& eventData = events[eventId];
        if (!eventData.isValid())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();
        bool active = activeEvents.find(eventId) != activeEvents.end();
        char const* activeStr = active ? handler->GetAcoreString(LANG_ACTIVE) : "";

        std::string startTimeStr = Acore::Time::TimeToTimestampStr(Seconds(eventData.start));
        std::string endTimeStr = Acore::Time::TimeToTimestampStr(Seconds(eventData.end));

        uint32 delay = sGameEventMgr->NextCheck(eventId);
        time_t nextTime = time(nullptr) + delay;
        std::string nextStr = nextTime >= eventData.start && nextTime < eventData.end ? Acore::Time::TimeToTimestampStr(Seconds(time(nullptr) + delay)) : "-";

        std::string occurenceStr = secsToTimeString(eventData.occurence * MINUTE, true);
        std::string lengthStr = secsToTimeString(eventData.length * MINUTE, true);

        handler->PSendSysMessage(LANG_EVENT_INFO, uint16(eventId), eventData.description.c_str(), activeStr,
            startTimeStr.c_str(), endTimeStr.c_str(), occurenceStr.c_str(), lengthStr.c_str(),
            nextStr.c_str());

        return true;
    }

    static bool HandleEventStartCommand(ChatHandler* handler, EventEntry const eventId)
    {
        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();

        if (*eventId < 1 || *eventId >= events.size())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventData const& eventData = events[eventId];
        if (!eventData.isValid())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();
        if (activeEvents.find(eventId) != activeEvents.end())
        {
            handler->PSendSysMessage(LANG_EVENT_ALREADY_ACTIVE, uint16(eventId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        sGameEventMgr->StartEvent(eventId, true);
        return true;
    }

    static bool HandleEventStopCommand(ChatHandler* handler, EventEntry const eventId)
    {
        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();

        if (*eventId < 1 || *eventId >= events.size())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventData const& eventData = events[eventId];
        if (!eventData.isValid())
        {
            handler->SendSysMessage(LANG_EVENT_NOT_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();

        if (activeEvents.find(eventId) == activeEvents.end())
        {
            handler->PSendSysMessage(LANG_EVENT_NOT_ACTIVE, uint16(eventId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        sGameEventMgr->StopEvent(eventId, true);
        return true;
    }
};

void AddSC_event_commandscript()
{
    new event_commandscript();
}
