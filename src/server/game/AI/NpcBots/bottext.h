#ifndef BOTTEXT_H
#define BOTTEXT_H

#include "Define.h"

enum BotTexts : uint32
{
    GOSSIP_NORMAL_SERVE_MASTER          = 70001,//"I live only to serve the master."
    GOSSIP_GREET_NEED_SMTH              = 70002,//"You need something?"
    GOSSIP_GREET_MURDER                 = 70003,//"Mortals... usually I kill wretches like you at sight"
    GOSSIP_GREET_CUSTOM_SPHYNX          = 70004,
    GOSSIP_NORMAL_CUSTOM_SPHYNX         = 70005,
    GOSSIP_GREET_CUSTOM_DREADLORD       = 70006,
    GOSSIP_NORMAL_CUSTOM_DREADLORD      = 70007,
    GOSSIP_GREET_CUSTOM_DARKRANGER      = 70008,
    GOSSIP_NORMAL_CUSTOM_DARKRANGER     = 70009,
    GOSSIP_GREET_CUSTOM_SEAWITCH        = 70010,
    GOSSIP_NORMAL_CUSTOM_SEAWITCH       = 70011,
    GOSSIP_GREET_CUSTOM_CRYPTLORD       = 70012,
    GOSSIP_NORMAL_CUSTOM_CRYPTLORD      = 70013,
    //70012-70100 reserved for bot gossip texts (not selectable)
    GOSSIP_CLASSDESC_BM                 = 70101,
    GOSSIP_CLASSDESC_SPHYNX             = 70102,
    GOSSIP_CLASSDESC_ARCHMAGE           = 70103,
    GOSSIP_CLASSDESC_DREADLORD          = 70104,
    GOSSIP_CLASSDESC_SPELLBREAKER       = 70105,
    GOSSIP_CLASSDESC_DARKRANGER         = 70106,
    GOSSIP_CLASSDESC_NECROMANCER        = 70107,
    GOSSIP_CLASSDESC_SEAWITCH           = 70108,
    GOSSIP_CLASSDESC_CRYPTLORD          = 70109,
    //70109-70200 reserved for bot class descriptions gossip texts (not selectable)
    GOSSIP_BOTGIVER_GREET               = 70201,
    GOSSIP_BOTGIVER_HIRE                = 70202,
    GOSSIP_BOTGIVER_HIRE_CLASS          = 70203,
    GOSSIP_BOTGIVER_HIRE_EMPTY          = 70204,
    //70205-70299 reserved for botgiver gossip texts (not selectable)
    BOT_TEXT_DIE                        = 70300, //"Die!"
    BOT_TEXT_REZZING_YOU                = 70301, //"Rezzing You"
    BOT_TEXT_REZZING_                   = 70302, //"Rezzing "
    BOT_TEXT_YOUR_BOT                   = 70303, //"your bot"
    BOT_TEXT__S_BOT                     = 70304, //"'s bot"
    BOT_TEXT_CANT_CONJURE_WATER_YET     = 70305, //"I can't conjure water yet"
    BOT_TEXT_CANT_CONJURE_FOOD_YET      = 70306, //"I can't conjure food yet"
    BOT_TEXT_CANT_RIGHT_NOW             = 70307, //"I can't do it right now"
    BOT_TEXT_HERE_YOU_GO                = 70308, //"Here you go..."
    BOT_TEXT_DISABLED                   = 70309, //"Disabled"
    BOT_TEXT_NOT_READY_YET              = 70310, //"Not ready yet"
    BOT_TEXT_INVALID_OBJECT_TYPE        = 70311, //"Invalid object type"
    BOT_TEXT_FAILED                     = 70312, //"Failed"
    BOT_TEXT_DONE                       = 70313, //"Done"
    BOT_TEXT_NOT_SHAPESHIFTED           = 70314, //"I am not shapeshifted"
    BOT_TEXT_NO_HEALTHSTONE             = 70315, //"I don't have a healthstone"
    BOT_TEXT_CANT_CREATE_HEALTHSTONE    = 70316, //"I can't create healthstones yet!"
    BOT_TEXT_NO_LOCKPICKING             = 70317, //"WTF I don't have lockpicking!"
    BOT_TEXT_SKILL_LEVEL_TOO_LOW        = 70318, //"My skill level in not high enough"
    BOT_TEXT_CHANGING_MY_SPEC_TO_       = 70319, //"Changing my spec to "
    BOT_TEXT_SPEC_ARMS                  = 70320, //"Arms"
    BOT_TEXT_SPEC_FURY                  = 70321, //"Fury"
    BOT_TEXT_SPEC_PROTECTION            = 70322, //"Protection"
    BOT_TEXT_SPEC_RETRIBUTION           = 70323, //"Retribution"
    BOT_TEXT_SPEC_BEASTMASTERY          = 70324, //"Beast Mastery"
    BOT_TEXT_SPEC_MARKSMANSHIP          = 70325, //"Marksmanship"
    BOT_TEXT_SPEC_SURVIVAL              = 70326, //"Survival"
    BOT_TEXT_SPEC_ASSASINATION          = 70327, //"Assassination"
    BOT_TEXT_SPEC_COMBAT                = 70328, //"Combat"
    BOT_TEXT_SPEC_SUBTLETY              = 70329, //"Subtlety"
    BOT_TEXT_SPEC_DISCIPLINE            = 70330, //"Discipline"
    BOT_TEXT_SPEC_HOLY                  = 70331, //"Holy"
    BOT_TEXT_SPEC_SHADOW                = 70332, //"Shadow"
    BOT_TEXT_SPEC_BLOOD                 = 70333, //"Blood"
    BOT_TEXT_SPEC_FROST                 = 70334, //"Frost"
    BOT_TEXT_SPEC_UNHOLY                = 70335, //"Unholy"
    BOT_TEXT_SPEC_ELEMENTAL             = 70336, //"Elemental"
    BOT_TEXT_SPEC_ENHANCEMENT           = 70337, //"Enhancement"
    BOT_TEXT_SPEC_RESTORATION           = 70338, //"Restoration"
    BOT_TEXT_SPEC_ARCANE                = 70339, //"Arcane"
    BOT_TEXT_SPEC_FIRE                  = 70340, //"Fire"
    BOT_TEXT_SPEC_AFFLICTION            = 70341, //"Affliction"
    BOT_TEXT_SPEC_DEMONOLOGY            = 70342, //"Demonology"
    BOT_TEXT_SPEC_DESTRUCTION           = 70343, //"Destruction"
    BOT_TEXT_SPEC_BALANCE               = 70344, //"Balance"
    BOT_TEXT_SPEC_FERAL                 = 70345, //"Feral Combat"
    BOT_TEXT_SPEC_UNKNOWN               = 70346, //"Unknown"
    BOT_TEXT_HIREDENY_DK                = 70347, //"Go away, weakling"
    BOT_TEXT_HIREDENY_SPHYNX            = 70348, //" is not convinced"
    BOT_TEXT_HIREDENY_ARCHMAGE          = 70349, //"I am not going to waste my time on just anything"
    BOT_TEXT_HIREDENY_DREADLORD         = 70350, //NIY
    BOT_TEXT_HIREDENY_SPELLBREAKER      = 70351, //NIY
    BOT_TEXT_HIREDENY_DARKRANGER        = 70352, //NIY
    BOT_TEXT_HIRE_SUCCESS               = 70353, //"I am ready"
    BOT_TEXT_HIREDENY_MY_MASTER_IS_     = 70354, //"Go away. I serve my master "
    BOT_TEXT_UNKNOWN                    = 70355, //"unknown"
    BOT_TEXT__ON_YOU                    = 70356, //" on You!"
    BOT_TEXT__ON_MYSELF                 = 70357, //" on myself!"
    BOT_TEXT__ON_                       = 70358, //" on "
    BOT_TEXT__USED                      = 70359, //" used!"
    BOT_TEXT_BOT_TANK                   = 70360, //"bot tank"
    BOT_TEXT_CLASS                      = 70361, //"class"
    BOT_TEXT_PLAYER                     = 70362, //"player"
    BOT_TEXT_MASTER                     = 70363, //"master"
    BOT_TEXT_NONE                       = 70364, //"none"
    BOT_TEXT_RANK                       = 70365, //"Rank"
    BOT_TEXT_TALENT                     = 70366, //"talent"
    BOT_TEXT_PASSIVE                    = 70367, //"passive"
    BOT_TEXT_HIDDEN                     = 70368, //"hidden"
    BOT_TEXT_KNOWN                      = 70369, //"known"
    BOT_TEXT_ABILITY                    = 70370, //"ability"
    BOT_TEXT_STAT_STR                   = 70371, //"str"
    BOT_TEXT_STAT_AGI                   = 70372, //"agi"
    BOT_TEXT_STAT_STA                   = 70373, //"sta"
    BOT_TEXT_STAT_INT                   = 70374, //"int"
    BOT_TEXT_STAT_SPI                   = 70375, //"spi"
    BOT_TEXT_STAT_UNK                   = 70376, //"unk stat"
    BOT_TEXT_TOTAL                      = 70377, //"total"
    BOT_TEXT_MELEE_AP                   = 70378, //"Melee AP"
    BOT_TEXT_RANGED_AP                  = 70379, //"Ranged AP"
    BOT_TEXT_ARMOR                      = 70380, //"armor"
    BOT_TEXT_CRIT                       = 70381, //"crit"
    BOT_TEXT_DEFENSE                    = 70382, //"defense"
    BOT_TEXT_MISS                       = 70383, //"miss"
    BOT_TEXT_DODGE                      = 70384, //"dodge"
    BOT_TEXT_PARRY                      = 70385, //"parry"
    BOT_TEXT_BLOCK                      = 70386, //"block"
    BOT_TEXT_BLOCKVALUE                 = 70387, //"block value"
    BOT_TEXT_DMG_TAKEN_MELEE            = 70388, //"Damage taken melee"
    BOT_TEXT_DMG_TAKEN_SPELL            = 70389, //"Damage taken spell"
    BOT_TEXT_DMG_RANGE_MAINHAND         = 70390, //"Damage range mainhand"
    BOT_TEXT_DMG_MULT_MAINHAND          = 70391, //"Damage mult mainhand"
    BOT_TEXT_ATTACK_TIME_MAINHAND       = 70392, //"Attack time mainhand"
    BOT_TEXT_DMG_RANGE_OFFHAND          = 70393, //"Damage range offhand"
    BOT_TEXT_DMG_MULT_OFFHAND           = 70394, //"Damage mult offhand"
    BOT_TEXT_ATTACK_TIME_OFFHAND        = 70395, //"Attack time offhand"
    BOT_TEXT_DMG_RANGE_RANGED           = 70396, //"Damage range ranged"
    BOT_TEXT_DMG_MULT_RANGED            = 70397, //"Damage mult ranged"
    BOT_TEXT_ATTACK_TIME_RANGED         = 70398, //"Attack time ranged"
    BOT_TEXT_MIN                        = 70399, //"min"
    BOT_TEXT_MAX                        = 70400, //"max"
    BOT_TEXT_DPS                        = 70401, //"DPS"
    BOT_TEXT_BASE_HP                    = 70402, //"base hp"
    BOT_TEXT_TOTAL_HP                   = 70403, //"total hp"
    BOT_TEXT_BASE_MP                    = 70404, //"base mana"
    BOT_TEXT_TOTAL_MP                   = 70405, //"total mana"
    BOT_TEXT_CURR_MP                    = 70406, //"current mana"
    BOT_TEXT_SPELLPOWER                 = 70407, //"spell power"
    BOT_TEXT_REGEN_HP                   = 70408, //"health regen_5 bonus"
    BOT_TEXT_REGEN_MP_CAST              = 70409, //"mana regen_5 no cast"
    BOT_TEXT_REGEN_MP_NOCAST            = 70410, //"mana regen_5 casting"
    BOT_TEXT_HASTE                      = 70411, //"haste"
    BOT_TEXT_HIT                        = 70412, //"hit"
    BOT_TEXT_EXPERTISE                  = 70413, //"expertise"
    BOT_TEXT_ARMOR_PEN                  = 70414, //"armor penetration"
    BOT_TEXT_SPELL_PEN                  = 70415, //"spell penetration"
    BOT_TEXT_PCT                        = 70416, //"pct"
    BOT_TEXT_HOLY                       = 70417, //"holy"
    BOT_TEXT_FIRE                       = 70418, //"fire"
    BOT_TEXT_NATURE                     = 70419, //"nature"
    BOT_TEXT_FROST                      = 70420, //"frost"
    BOT_TEXT_SHADOW                     = 70421, //"shadow"
    BOT_TEXT_ARCANE                     = 70422, //"arcane"
    BOT_TEXT_RESISTANCE                 = 70423, //"Resistance"
    BOT_TEXT_COMMAND_STATES             = 70424, //"Command states"
    BOT_TEXT_COMMAND_FOLLOW             = 70425, //"Follow"
    BOT_TEXT_COMMAND_ATTACK             = 70426, //"Attack"
    BOT_TEXT_COMMAND_STAY               = 70427, //"Stay"
    BOT_TEXT_COMMAND_RESET              = 70428, //"Reset"
    BOT_TEXT_COMMAND_FULLSTOP           = 70429, //"FullStop"
    BOT_TEXT_FOLLOW_DISTANCE            = 70430, //"Follow distance"
    BOT_TEXT_SPEC                       = 70431, //"Spec"
    BOT_TEXT_BOT_ROLEMASK_MAIN          = 70432, //"Bot roles mask main"
    BOT_TEXT_BOT_ROLEMASK_GATHERING     = 70433, //"Bot roles mask gathering"
    BOT_TEXT_PVP_KILLS                  = 70434, //"PvP kills"
    BOT_TEXT_PLAYERS                    = 70435, //"players"
    BOT_TEXT_DIED_                      = 70436, //"Died "
    BOT_TEXT__TIMES                     = 70437, //" times"
    BOT_TEXT_BOT_TICKLED                = 70438, //"%s (bot) calms down"
    BOT_TEXT_DEBUG                      = 70439, //"<Debug>"
    BOT_TEXT_HIREWARN_SPHYNX_1          = 70440, //"Are you sure you want to risk drawing "
    BOT_TEXT_HIREWARN_SPHYNX_2          = 70441, //"'s attention?"
    BOT_TEXT_HIREOPTION_SPHYNX          = 70442, //"<Insert Coin>"
    BOT_TEXT_HIREWARN_DREADLORD         = 70443, //"Do you want to entice "
    BOT_TEXT_HIREOPTION_DREADLORD       = 70444, //"<Try to make an offering>"
    BOT_TEXT_HIREWARN_DEFAULT           = 70445, //"Do you wish to hire "
    BOT_TEXT_HIREOPTION_DEFAULT         = 70446, //"<Hire bot>"
    BOT_TEXT_MANAGE_EQUIPMENT           = 70447, //"Manage equipment..."
    BOT_TEXT_MANAGE_ROLES               = 70448, //"Manage roles..."
    BOT_TEXT_MANAGE_FORMATION           = 70449, //"Manage formation..."
    BOT_TEXT_MANAGE_ABILITIES           = 70450, //"Manage abilities..."
    BOT_TEXT_MANAGE_TALENTS             = 70451, //"Manage talents..."
    BOT_TEXT_GIVE_CONSUMABLE            = 70452, //"Give consumable..."
    BOT_TEXT_CREATE_GROUP               = 70453, //"<Create group>"
    BOT_TEXT_CREATE_GROUP_ALL           = 70454, //"<Create group (all bots)>"
    BOT_TEXT_ADD_TO_GROUP               = 70455, //"<Add to group>"
    BOT_TEXT_ADD_TO_GROUP_ALL           = 70456, //"<Add all bots to group>"
    BOT_TEXT_REMOVE_FROM_GROUP          = 70457, //"<Remove from group>"
    BOT_TEXT_FOLLOW_ME                  = 70458, //"Follow me"
    BOT_TEXT_HOLD_POSITION              = 70459, //"Hold your position"
    BOT_TEXT_STAY_HERE                  = 70460, //"Stay here and don't do anything"
    BOT_TEXT_MAGE_FOOD                  = 70461, //"I need food"
    BOT_TEXT_MAGE_DRINK                 = 70462, //"I need water"
    BOT_TEXT_MAGE_TABLE                 = 70463, //"I need a refreshment table"
    BOT_TEXT_ROGUE_PICKLOCK             = 70464, //"Help me pick a lock"
    BOT_TEXT_WARLOCK_HEALTHSTONE        = 70465, //"I need your your healthstone"
    BOT_TEXT_WARLOCK_SOULWELL           = 70466, //"I need a soulwell"
    BOT_TEXT_ROGUE_POISON_REFRESH       = 70467, //"I need you to refresh poisons"
    BOT_TEXT_ROGUE_POISON_MH            = 70468, //"<Choose poison (Main Hand)>"
    BOT_TEXT_ROGUE_POISON_OH            = 70469, //"<Choose poison (Offhand)>"
    BOT_TEXT_SHAMAN_ENCH_REFRESH        = 70470, //"I need you to refresh enchants"
    BOT_TEXT_SHAMAN_ENCH_MH             = 70471, //"<Choose enchant (Main Hand)>"
    BOT_TEXT_SHAMAN_ENCH_OH             = 70472, //"<Choose enchant (Offhand)>"
    BOT_TEXT_REMOVE_SHAPESHIFT          = 70473, //"I need you to remove shapeshift"
    BOT_TEXT_CHOOSE_PET_TYPE            = 70474, //"<Choose pet type>"
    BOT_TEXT_UR_DISMISSED               = 70475, //"You are dismissed"
    BOT_TEXT_ABANDON_WARN_1             = 70476, //"Are you going to abandon "
    BOT_TEXT_ABANDON_WARN_2             = 70477, //"You may regret it..."
    BOT_TEXT_PULL_URSELF                = 70478, //"Pull yourself together, damnit"
    BOT_TEXT_STUDY_CREATURE             = 70479, //"<Study the creature>"
    BOT_TEXT_NEVERMIND                  = 70480, //"Nevermind"
    BOT_TEXT_DISTANCE_SHORT             = 70481, //"dist"
    BOT_TEXT_BACK                       = 70482, //"BACK"
    BOT_TEXT_AUTO                       = 70483, //"<Auto>"
    BOT_TEXT_NONE2                      = 70484, //"<None>"
    BOT_TEXT_RANDOMPET_CUNNING          = 70485, //"Random (Cunning)"
    BOT_TEXT_RANDOMPET_FEROCITY         = 70486, //"Random (Ferocity)"
    BOT_TEXT_RANDOMPET_TENACITY         = 70487, //"Random (Tenacity)"
    BOT_TEXT_SHOW_INVENTORY             = 70488, //"Show me your inventory"
    BOT_TEXT_AUTOEQUIP                  = 70489, //"Auto-equip"
    BOT_TEXT_SLOT_MH                    = 70490, //"Main hand"
    BOT_TEXT_SLOT_OH                    = 70491, //"Off-hand"
    BOT_TEXT_SLOT_RH                    = 70492, //"Ranged"
    BOT_TEXT_SLOT_RELIC                 = 70493, //"Relic"
    BOT_TEXT_SLOT_HEAD                  = 70494, //"Head"
    BOT_TEXT_SLOT_SHOULDERS             = 70495, //"Shoulders"
    BOT_TEXT_SLOT_CHEST                 = 70496, //"Chest"
    BOT_TEXT_SLOT_WAIST                 = 70497, //"Waist"
    BOT_TEXT_SLOT_LEGS                  = 70498, //"Legs"
    BOT_TEXT_SLOT_FEET                  = 70499, //"Feet"
    BOT_TEXT_SLOT_WRIST                 = 70500, //"Wrist"
    BOT_TEXT_SLOT_HANDS                 = 70501, //"Hands"
    BOT_TEXT_SLOT_BACK                  = 70502, //"Back"
    BOT_TEXT_SLOT_SHIRT                 = 70503, //"Shirt"
    BOT_TEXT_SLOT_FINGER1               = 70504, //"Finger1"
    BOT_TEXT_SLOT_FINGER2               = 70505, //"Finger2"
    BOT_TEXT_SLOT_TRINKET1              = 70506, //"Trinket1"
    BOT_TEXT_SLOT_TRINKET2              = 70507, //"Trinket2"
    BOT_TEXT_SLOT_NECK                  = 70508, //"Neck"
    BOT_TEXT_UNEQUIP_ALL                = 70509, //"Unequip all"
    BOT_TEXT_UPDATE_VISUAL              = 70510, //"Update visual"
    BOT_TEXT_VISUALONLY                 = 70511, //"visual only"
    BOT_TEXT_EQUIPPED                   = 70512, //"Equipped"
    BOT_TEXT_NOTHING                    = 70513, //"nothing"
    BOT_TEXT_USE_OLD_EQUIPMENT          = 70514, //"Use your old equipment"
    BOT_TEXT_UNEQUIP                    = 70515, //"Unequip it"
    BOT_TEXT_NOTHING_TO_GIVE            = 70516, //"Hm... I have nothing to give you"
    BOT_TEXT_GATHERING                  = 70517, //"Gathering"
    BOT_TEXT_ABILITIES_STATUS           = 70518, //"Abilities status"
    BOT_TEXT_ALLOWED_ABILITIES          = 70519, //"Manage allowed abilities"
    BOT_TEXT_USE_                       = 70520, //"Use "
    BOT_TEXT_UPDATE                     = 70521, //"Update"
    BOT_TEXT_DAMAGE                     = 70522, //"Damage"
    BOT_TEXT_CONTROL                    = 70523, //"Control"
    BOT_TEXT_HEAL                       = 70524, //"Heal"
    BOT_TEXT_OTHER                      = 70525, //"Other"
    BOT_TEXT_HIRE_EMOTE_SPHYNX          = 70526, //" makes a grinding sound and begins to follow "
    BOT_TEXT_HIREFAIL_OWNED             = 70527, //"%s will not join you until dismissed by the owner"
    BOT_TEXT_HIREFAIL_LVL60             = 70528, //"%s will not join you until you are level 60"
    BOT_TEXT_HIREFAIL_LVL55             = 70529, //"%s will not join you until you are level 55"
    BOT_TEXT_HIREFAIL_LVL40             = 70530, //"%s will not join you until you are level 40"
    BOT_TEXT_HIREFAIL_LVL20             = 70531, //"%s will not join you until you are level 20"
    BOT_TEXT_HIREFAIL_MAXBOTS           = 70532, //"You exceed max npcbots (%u)"
    BOT_TEXT_HIREFAIL_COST              = 70533, //"You don't have enough money"
    BOT_TEXT_HIREFAIL_MAXCLASSBOTS      = 70534, //"You cannot have more bots of that class! %u of %u"
    BOT_TEXT_CANT_DISMISS_EQUIPMENT     = 70535, //"Cannot reset equipment in slot %u (%s)! Cannot dismiss bot!"
    BOT_TEXT_CURRENT                    = 70536, //"current"
    BOT_TEXT_ATTACK_DISTANCE            = 70537, //"Attack distance"
    BOT_TEXT_SHORT_RANGE_ATTACKS        = 70538, //"Short range attacks"
    BOT_TEXT_LONG_RANGE_ATTACKS         = 70539, //"Long range attacks"
    BOT_TEXT_EXACT                      = 70540, //"Exact"
    BOT_TEXT_REMOVE_BUFF                = 70541, //"Remove buff"
    BOT_TEXT_FIX_POWER                  = 70542, //"Fix your power type"
    BOT_TEXT_CANT_UNEQUIP_MAILING       = 70543, //"Cannot unequip %s for some stupid reason! Sending through mail"
    BOT_TEXT_TANK                       = 70544, //"Tank"
    BOT_TEXT_RANGED                     = 70545, //"Ranged"
    BOT_TEXT_MINER                      = 70546, //"Miner"
    BOT_TEXT_HERBALIST                  = 70547, //"Herbalist"
    BOT_TEXT_SKINNER                    = 70548, //"Skinner"
    BOT_TEXT_ENGINEER                   = 70549, //"Engineer"
    BOT_TEXT_OWNERSHIP_EXPIRED          = 70550, //"Bot ownership expired due to inactivity"
    BOT_TEXT_BOTADDFAIL_DISABLED        = 70551, //"NpcBot system is currently disabled. Please contact administration."
    BOT_TEXT_BOTADDFAIL_OWNED           = 70552, //"%s will not join you, already has master: %s"
    BOT_TEXT_BOTADDFAIL_TELEPORTED      = 70553, //"%s cannot join you while about to teleport"
    BOT_TEXT_ASPECT                     = 70554, //"Aspect"
    BOT_TEXT_MONKEY                     = 70555, //"Monkey"
    BOT_TEXT_HAWK                       = 70556, //"Hawk"
    BOT_TEXT_CHEETAH                    = 70557, //"Cheetah"
    BOT_TEXT_VIPER                      = 70558, //"Viper"
    BOT_TEXT_BEAST                      = 70559, //"Beast"
    BOT_TEXT_PACK                       = 70560, //"Pack"
    BOT_TEXT_WILD                       = 70561, //"Wild"
    BOT_TEXT_DRAGONHAWK                 = 70562, //"Dragonhawk"
    BOT_TEXT_NOASPECT                   = 70563, //"No Aspect"
    BOT_TEXT_AURA                       = 70564, //"Aura"
    BOT_TEXT_DEVOTION                   = 70565, //"Devotion"
    BOT_TEXT_CONCENTRATION              = 70566, //"Concentration"
    BOT_TEXT_FIRERESISTANCE             = 70567, //"Fire Resistance"
    BOT_TEXT_FROSTRESISTANCE            = 70568, //"Frost Resistance"
    BOT_TEXT_SHADOWRESISTANCE           = 70569, //"Shadow Resistance"
    BOT_TEXT_RETRIBUTION                = 70570, //"Retribution"
    BOT_TEXT_CRUSADER                   = 70571, //"Crusader"
    BOT_TEXT_NOAURA                     = 70572, //"No Aura"
    BOT_TEXT_CRIPPLING                  = 70573, //"Crippling"
    BOT_TEXT_INSTANT                    = 70574, //"Instant"
    BOT_TEXT_DEADLY                     = 70575, //"Deadly"
    BOT_TEXT_WOUND                      = 70576, //"Wound"
    BOT_TEXT_MINDNUMBING                = 70577, //"Mind-Numbing"
    BOT_TEXT_ANESTHETIC                 = 70578, //"Anesthetic"
    BOT_TEXT_NOTHING_C                  = 70579, //"Nothing"
    BOT_TEXT_FLAMETONGUE                = 70580, //"Flametongue"
    BOT_TEXT_FROSTBRAND                 = 70581, //"Frostbrand"
    BOT_TEXT_WINDFURY                   = 70582, //"Windfury"
    BOT_TEXT_EARTHLIVING                = 70583, //"Earthliving"
    BOT_TEXT_BOTGIVER_SERVICE           = 70584, //"I need your services"
    BOT_TEXT_BOTGIVER_TOO_MANY_BOTS     = 70585, //"You have too many bots"
    BOT_TEXT_BOTGIVER_WISH_TO_HIRE_     = 70586, //"Do you wish to hire "
    BOT_TEXT_BOTGIVER__BOT_BUSY         = 70587, //" is a bit busy at the moment, try again later."
    BOT_TEXT_BOTGIVER_HIRESUCCESS       = 70588, //"Pleasure doing business with you"
    BOT_TEXT_CLASS_WARRIOR_PLU          = 70589, //"Warriors"
    BOT_TEXT_CLASS_PALADIN_PLU          = 70590, //"Paladins"
    BOT_TEXT_CLASS_MAGE_PLU             = 70591, //"Mages"
    BOT_TEXT_CLASS_PRIEST_PLU           = 70592, //"Priests"
    BOT_TEXT_CLASS_WARLOCK_PLU          = 70593, //"Warlocks"
    BOT_TEXT_CLASS_DRUID_PLU            = 70594, //"Druids"
    BOT_TEXT_CLASS_DEATH_KNIGHT_PLU     = 70595, //"Death Knights"
    BOT_TEXT_CLASS_ROGUE_PLU            = 70596, //"Rogues"
    BOT_TEXT_CLASS_SHAMAN_PLU           = 70597, //"Shamans"
    BOT_TEXT_CLASS_HUNTER_PLU           = 70598, //"Hunters"
    BOT_TEXT_CLASS_BM_PLU               = 70599, //"Blademasters"
    BOT_TEXT_CLASS_SPHYNX_PLU           = 70600, //"Destroyers"
    BOT_TEXT_CLASS_ARCHMAGE_PLU         = 70601, //"Archmagi"
    BOT_TEXT_CLASS_DREADLORD_PLU        = 70602, //"Dreadlords"
    BOT_TEXT_CLASS_SPELLBREAKER_PLU     = 70603, //"Spell Breakers"
    BOT_TEXT_CLASS_DARK_RANGER_PLU      = 70604, //"Dark Rangers"
    BOT_TEXT_CLASS_WARRIOR              = 70605, //"Warrior"
    BOT_TEXT_CLASS_PALADIN              = 70606, //"Paladin"
    BOT_TEXT_CLASS_MAGE                 = 70607, //"Mage"
    BOT_TEXT_CLASS_PRIEST               = 70608, //"Priest"
    BOT_TEXT_CLASS_WARLOCK              = 70609, //"Warlock"
    BOT_TEXT_CLASS_DRUID                = 70610, //"Druid"
    BOT_TEXT_CLASS_DEATH_KNIGHT         = 70611, //"Death Knight"
    BOT_TEXT_CLASS_ROGUE                = 70612, //"Rogue"
    BOT_TEXT_CLASS_SHAMAN               = 70613, //"Shaman"
    BOT_TEXT_CLASS_HUNTER               = 70614, //"Hunter"
    BOT_TEXT_CLASS_BM                   = 70615, //"Blademaster"
    BOT_TEXT_CLASS_SPHYNX               = 70616, //"Destroyer"
    BOT_TEXT_CLASS_ARCHMAGE             = 70617, //"Archmage"
    BOT_TEXT_CLASS_DREADLORD            = 70618, //"Dreadlord"
    BOT_TEXT_CLASS_SPELLBREAKER         = 70619, //"Spell Breaker"
    BOT_TEXT_CLASS_DARK_RANGER          = 70620, //"Dark Ranger"
    BOT_TEXT_GENDER_MALE                = 70621, //"Male"
    BOT_TEXT_GENDER_FEMALE              = 70622, //"Female"
    BOT_TEXT_RACE_HUMAN                 = 70623, //"Human"
    BOT_TEXT_RACE_ORC                   = 70624, //"Orc"
    BOT_TEXT_RACE_DWARF                 = 70625, //"Dwarf"
    BOT_TEXT_RACE_NELF                  = 70626, //"Night Elf"
    BOT_TEXT_RACE_UNDEAD                = 70627, //"Undead"
    BOT_TEXT_RACE_TAUREN                = 70628, //"Tauren"
    BOT_TEXT_RACE_GNOME                 = 70629, //"Gnome"
    BOT_TEXT_RACE_TROLL                 = 70630, //"Troll"
    BOT_TEXT_RACE_BELF                  = 70631, //"Blood Elf"
    BOT_TEXT_RACE_DRAENEI               = 70632, //"Draenei"
    BOT_TEXT_RACE_UNKNOWN               = 70633, //"Unknown"
    BOT_TEXT_LOOTING                    = 70634, //"Looting"
    BOT_TEXT_POOR                       = 70635, //"Poor"
    BOT_TEXT_COMMON                     = 70636, //"Common"
    BOT_TEXT_UNCOMMON                   = 70637, //"Uncommon"
    BOT_TEXT_RARE                       = 70638, //"Rare"
    BOT_TEXT_EPIC                       = 70639, //"Epic"
    BOT_TEXT_LEGENDARY                  = 70640, //"Legendary"
    BOT_TEXT_ENGAGE_BEHAVIOR            = 70641, //"Engage behavior"
    BOT_TEXT_DELAY_ATTACK_BY            = 70642, //"Delay attack by"
    BOT_TEXT_DELAY_HEALING_BY           = 70643, //"Delay healing by"
    BOT_TEXT_SECOND_SHORT               = 70644, //"s"
    BOT_TEXT_TANK_OFF                   = 70645, //"Off-Tank"
    BOT_TEXT_CLASS_NECROMANCER_PLU      = 70646, //"Necromancers"
    BOT_TEXT_CLASS_NECROMANCER          = 70647, //"Necromancer"
    BOT_TEXT_ATTACK_ANGLE               = 70648, //"Attack angle"
    BOT_TEXT_NORMAL                     = 70649, //"Normal"
    BOT_TEXT_AVOID_FRONTAL_AOE          = 70650, //"Avoid frontal AOE"
    BOT_TEXT_HIREDENY_SEAWITCH          = 70651, //NIY
    BOT_TEXT_HIREWARN_SEAWITCH          = 70652, //"Are you sure this is gonna work? It's better be the best water in the world..."
    BOT_TEXT_HIREOPTION_SEAWITCH        = 70653, //"Seems like you could really use a drink of fresh water."
    BOT_TEXT_CLASS_SEAWITCH_PLU         = 70654, //"Sea Witches"
    BOT_TEXT_CLASS_SEAWITCH             = 70655, //"Sea Witch"
    BOT_TEXT_MANA_PER_DAMAGE            = 70656, //"Mana per damage"
    BOT_TEXT_DAMAGE_PER_MANA            = 70657, //"Damage per mana"
    BOT_TEXT_TRANSMOGRIFICATION         = 70658, //"Transmogrification..."
    BOT_TEXT_DISABLE_COMBAT_POSITIONING = 70659, //"DISABLE combat positioning"
    BOT_TEXT_PRIORITY_TARGET            = 70660, //"Priority target"
    BOT_TEXT_BOT_GEAR_BANK              = 70661, //"Bot gear bank..."
    BOT_TEXT_DEPOSIT_ITEMS              = 70662, //"Deposit items..."
    BOT_TEXT_WITHDRAW_ITEMS             = 70663, //"Withdraw items..."
    BOT_TEXT_BANK_IS_EMPTY              = 70664, //"Bank is empty"
    BOT_TEXT_PREVIOUS_PAGE              = 70665, //"Previous page"
    BOT_TEXT_NEXT_PAGE                  = 70666, //"Next page"
    BOT_TEXT_HIREWARN_CRYPTLORD         = 70667, //"Do you really want to spend all this money to make Crypt Lord move again?"
    BOT_TEXT_HIREOPTION_CRYPTLORD       = 70668, //"I doubt your ability to do much harm in your current state, but I am willing to lead you and help you restore your powers."
    BOT_TEXT_CLASS_CRYPT_LORD_PLU       = 70669, //"Crypt Lords"
    BOT_TEXT_CLASS_CRYPT_LORD           = 70670, //"Crypt Lord"
    BOT_TEXT_REFLECT                    = 70671, //"Reflect"
    BOT_TEXT_LOCUSTS                    = 70672, //"Locusts"
    //70673-70799 reserved for custom localization strings
};

#endif //BOTTEXT_H
