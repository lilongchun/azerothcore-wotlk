#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetPerksInspectHandler : public ForgeTopicHandler
{
public:
    GetPerksInspectHandler(ForgeCache* cache, ForgeCommonMessage* common) : ForgeTopicHandler(ForgeTopic::GET_INSPECT_PERKS)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        Unit* target = iam.player->GetTargetUnit();
        if (target == nullptr || !target->IsPlayer())
            return;
        
        Player* targetPlayer = target->ToPlayer();

        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            std::vector<CharacterSpecPerk*> specVec;
            fc->TryGetCharacterPerks(targetPlayer, spec->Id, specVec);
            std::string clientMsg = std::to_string(spec->Id) + "^";
            clientMsg += cm->DoBuildPerks(specVec, targetPlayer);
            iam.player->SendForgeUIMsg(ForgeTopic::GET_INSPECT_PERKS, clientMsg);
        }
    }

private:
    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
