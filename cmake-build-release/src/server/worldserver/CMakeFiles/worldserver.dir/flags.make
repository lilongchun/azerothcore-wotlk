# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# compile CXX with /usr/bin/clang++-6.0
CXX_FLAGS = -O3 -DNDEBUG   -include /home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/src/server/worldserver/cotire/worldserver_CXX_prefix.hxx -Wno-narrowing -Wno-deprecated-register -std=gnu++17

CXX_DEFINES = -DCONFIG_FILE_LIST="\"\\\"\\\"\"" -DDEBUG=1 -DENABLE_EXTRAS -DENABLE_VMAP_CHECKS -DNO_BUFFERPOOL -DSCRIPTS -D_BUILD_DIRECTIVE=\"Release\" -D_CONF_DIR="\"\\\"/usr/local/etc\\\"\"" -D_TRINITY_CORE_CONFIG=\"/usr/local/etc/worldserver.conf\"

CXX_INCLUDES = -I/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/src/server/worldserver -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/worldserver -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/worldserver/CommandLine -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/worldserver/RemoteAccess -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/worldserver/TCSoap -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/worldserver/WorldThread -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/authserver -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/authserver/Authentication -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/authserver/Realms -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/authserver/Server -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/AI -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/AI/CoreAI -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/AI/ScriptedAI -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/AI/SmartScripts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Accounts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Achievements -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Addons -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/ArenaSpectator -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/AuctionHouse -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Battlefield -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Battlefield/Zones -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Battlegrounds -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Battlegrounds/Zones -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Calendar -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Chat -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Chat/Channels -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Combat -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Conditions -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/DataStores -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/DungeonFinding -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Corpse -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Creature -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/DynamicObject -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/GameObject -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Item -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Item/Container -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Object -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Object/Updates -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Pet -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Player -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Totem -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Transport -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Unit -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Entities/Vehicle -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Events -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Globals -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Grids -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Grids/Cells -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Grids/Notifiers -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Groups -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Guilds -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Handlers -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Instances -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Loot -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Mails -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Maps -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Misc -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Miscellaneous -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Motd -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Movement -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Movement/MovementGenerators -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Movement/Spline -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Movement/Waypoints -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/OutdoorPvP -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Petitions -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Pools -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Quests -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Reputation -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Scripting -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Server -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Server/Protocol -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Skills -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Spells -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Spells/Auras -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Texts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Tickets -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Tools -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Warden -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Warden/Modules -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/Weather -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/game/World -I/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release -I/home/cristian/Documents/AzerothCore/azerothcore/src/common -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Collision -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Collision/Management -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Collision/Maps -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Collision/Models -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Configuration -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Cryptography -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Cryptography/Authentication -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/DataStores -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Database -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Database/Implementation -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Debugging -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Dynamic -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Dynamic/LinkedReference -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Logging -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Packets -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Threading -I/home/cristian/Documents/AzerothCore/azerothcore/src/common/Utilities -I/home/cristian/Documents/AzerothCore/azerothcore/deps/g3dlite/include -I/home/cristian/Documents/AzerothCore/azerothcore/deps/recastnavigation/Detour/Include -I/home/cristian/Documents/AzerothCore/azerothcore/deps/SFMT -I/home/cristian/Documents/AzerothCore/azerothcore/deps/utf8cpp -I/home/cristian/Documents/AzerothCore/azerothcore/deps/fmt -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Commands -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Custom -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/AlteracValley -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/BlackrockMountain -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/BlackrockMountain/BlackrockDepths -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/BlackrockMountain/BlackrockSpire -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/BlackrockMountain/BlackwingLair -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/BlackrockMountain/MoltenCore -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Deadmines -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Gnomeregan -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Karazhan -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/MagistersTerrace -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/ScarletEnclave -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/ScarletMonastery -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Scholomance -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/ShadowfangKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Stratholme -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/SunkenTemple -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/SunwellPlateau -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/TheStockade -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/Uldaman -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/ZulAman -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/EasternKingdoms/ZulGurub -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Events -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/BlackfathomDeeps -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/CavernsOfTime -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/CavernsOfTime/BattleForMountHyjal -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/CavernsOfTime/CullingOfStratholme -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/CavernsOfTime/TheBlackMorass -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/DireMaul -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/Maraudon -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/OnyxiasLair -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/RagefireChasm -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/RazorfenDowns -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/RazorfenKraul -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/RuinsOfAhnQiraj -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/TempleOfAhnQiraj -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/WailingCaverns -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Kalimdor/ZulFarrak -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/AzjolNerub -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/AzjolNerub/AzjolNerub -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/AzjolNerub/ahnkahet -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/ChamberOfAspects -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/ChamberOfAspects/ObsidianSanctum -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/ChamberOfAspects/RubySanctum -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/CrusadersColiseum -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/CrusadersColiseum/TrialOfTheChampion -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/CrusadersColiseum/TrialOfTheCrusader -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/DraktharonKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/FrozenHalls -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/FrozenHalls/ForgeOfSouls -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/FrozenHalls/HallsOfReflection -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/FrozenHalls/PitOfSaron -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Gundrak -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/IcecrownCitadel -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Naxxramas -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Nexus -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Nexus/EyeOfEternity -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Nexus/Nexus -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Nexus/Oculus -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Ulduar -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Ulduar/HallsOfLightning -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Ulduar/HallsOfStone -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/Ulduar/Ulduar -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/UtgardeKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/UtgardeKeep/UtgardeKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/UtgardeKeep/UtgardePinnacle -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/VaultOfArchavon -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Northrend/VioletHold -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/OutdoorPvP -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/Auchindoun -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/Auchindoun/AuchenaiCrypts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/Auchindoun/ManaTombs -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/Auchindoun/SethekkHalls -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/Auchindoun/ShadowLabyrinth -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/BlackTemple -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/CoilfangReservoir -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/CoilfangReservoir/SerpentShrine -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/CoilfangReservoir/SlavePens -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/CoilfangReservoir/SteamVault -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/CoilfangReservoir/underbog -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/GruulsLair -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/HellfireCitadel -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/HellfireCitadel/BloodFurnace -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/HellfireCitadel/HellfireRamparts -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/HellfireCitadel/MagtheridonsLair -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/HellfireCitadel/ShatteredHalls -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/TempestKeep -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/TempestKeep/Eye -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/TempestKeep/Mechanar -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/TempestKeep/arcatraz -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Outland/TempestKeep/botanica -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Pet -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/Spells -I/home/cristian/Documents/AzerothCore/azerothcore/src/server/scripts/World -I/home/cristian/Documents/AzerothCore/azerothcore/deps/gsoap -isystem /usr/include/mysql 

