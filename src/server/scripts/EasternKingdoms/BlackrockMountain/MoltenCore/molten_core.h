/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_MOLTEN_CORE_H
#define DEF_MOLTEN_CORE_H

#define MCScriptName "instance_molten_core"

constexpr uint32 MAX_ENCOUNTER = 10;

enum MCData
{
    DATA_LUCIFRON                   = 0,
    DATA_MAGMADAR                   = 1,
    DATA_GEHENNAS                   = 2,
    DATA_GARR                       = 3,
    DATA_SHAZZRAH                   = 4,
    DATA_GEDDON                     = 5,
    DATA_SULFURON                   = 6,
    DATA_GOLEMAGG                   = 7,
    DATA_MAJORDOMO_EXECUTUS         = 8,
    DATA_RAGNAROS                   = 9,
};

enum MCActions
{
    ACTION_START_RAGNAROS               = -1,
    ACTION_START_RAGNAROS_ALT           = -2,
};

Position const RagnarosTelePos   = {829.159f, -815.773f, -228.972f, 5.30500f};

enum MCCreatures
{
    NPC_LUCIFRON                    = 12118,
    NPC_MAGMADAR                    = 11982,
    NPC_SHAZZRAH                    = 12264,
    NPC_BARON_GEDDON                = 12056,
    NPC_SULFURON_HARBINGER          = 12098,
    NPC_MAJORDOMO_EXECUTUS          = 12018,
    NPC_RAGNAROS                    = 11502,
    NPC_FLAMEWAKER_HEALER           = 11663,
    NPC_FLAMEWAKER_ELITE            = 11664,
    NPC_CORE_HOUND                  = 11671,

    // Garr
    NPC_GARR                        = 12057,
    NPC_FIRESWORN                   = 12099,

    // Gehennas
    NPC_GEHENNAS                    = 12259,
    NPC_FLAMEWALKER                 = 11661,

    // Golemagg
    NPC_GOLEMAGG_THE_INCINERATOR    = 11988,
    NPC_CORE_RAGER                  = 11672,
};

enum MCGameObjects
{
    GO_CACHE_OF_THE_FIRELORD        = 179703,
    GO_CIRCLE_SULFURON              = 178187,
    GO_CIRCLE_GEDDON                = 178188,
    GO_CIRCLE_SHAZZRAH              = 178189,
    GO_CIRCLE_GOLEMAGG              = 178190,
    GO_CIRCLE_GARR                  = 178191,
    GO_CIRCLE_MAGMADAR              = 178192,
    GO_CIRCLE_GEHENNAS              = 178193,
};

template <class AI, class T>
inline AI* GetMoltenCoreAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MCScriptName);
}

#endif
