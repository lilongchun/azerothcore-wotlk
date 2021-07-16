/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ Trinitycore <https://TrinityCore.org/>
 */

#ifndef __CHATTEXT_BUILDER_H
#define __CHATTEXT_BUILDER_H

#include "Common.h"
#include "SharedDefines.h"
#include <string>

class WorldObject;
class WorldPacket;

namespace Acore
{
    class BroadcastTextBuilder
    {
        public:
            BroadcastTextBuilder(WorldObject const* obj, ChatMsg msgType, uint32 textId, uint8 gender, WorldObject const* target = nullptr, uint32 achievementId = 0)
                : _source(obj), _msgType(msgType), _textId(textId), _gender(gender), _target(target), _achievementId(achievementId) { }

            void operator()(WorldPacket& data, LocaleConstant locale) const;
            size_t operator()(WorldPacket* data, LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            uint32 _textId;
            uint8 _gender;
            WorldObject const* _target;
            uint32 _achievementId;
    };

    class CustomChatTextBuilder
    {
        public:
            CustomChatTextBuilder(WorldObject const* obj, ChatMsg msgType, std::string_view text, Language language = LANG_UNIVERSAL, WorldObject const* target = nullptr)
                : _source(obj), _msgType(msgType), _text(text), _language(language), _target(target) { }

            void operator()(WorldPacket& data, LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            std::string _text;
            Language _language;
            WorldObject const* _target;
    };

    class AcoreStringChatBuilder
    {
        public:
            AcoreStringChatBuilder(WorldObject const* obj, ChatMsg msgType, uint32 textId, WorldObject const* target = nullptr, va_list* args = nullptr)
                : _source(obj), _msgType(msgType), _textId(textId), _target(target), _args(args) { }

            void operator()(WorldPacket& data, LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            uint32 _textId;
            WorldObject const* _target;
            va_list* _args;
    };
}
// namespace Acore

#endif // __CHATTEXT_BUILDER_H
