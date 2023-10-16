#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "Pet.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>
#include "ForgeCommonMessage.h"

class LearnTalentHandler : public ForgeTopicHandler
{
public:
    LearnTalentHandler(ForgeCache* cache, ForgeCommonMessage*  common) : ForgeTopicHandler(ForgeTopic::LEARN_TALENT)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;
        
        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 2 || !fc->isNumber(results[0]) || !fc->isNumber(results[1]))
            return;

        uint32 tabId = static_cast<uint32>(std::stoul(results[0]));
        uint32 spellId = static_cast<uint32>(std::stoul(results[1]));
        ForgeTalentTab* tab;
        ForgeCharacterSpec* spec;
        CharacterPointType tabType;

        if (fc->TryGetTabPointType(tabId, tabType) &&
            fc->TryGetTalentTab(iam.player, tabId, tab) &&
            fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            if (tabType == CharacterPointType::PET_TALENT) {
                if (Pet* pet = iam.player->GetPet()) {
                    if (pet->getPetType() == HUNTER_PET) {
                        if (auto ct = pet->GetCreatureTemplate()) {
                            CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(ct->family);
                            if (!pet_family || pet_family->petTalentType < 0)
                                return;
                            else if ((1 << pet_family->petTalentType) == 2 && tabId != 409)
                                return;
                            else if ((1 << pet_family->petTalentType) == 1 && tabId != 410)
                                return;
                            else if ((1 << pet_family->petTalentType) == 4 && tabId != 411)
                                return;
                        }
                        else return;
                    }
                    else return;
                }
                else return;
            }

            ForgeCharacterPoint* curPoints = fc->GetSpecPoints(iam.player, tabType, spec->Id);

            if (~tab->ClassMask & iam.player->getClassMask())
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "You are attempting to learn a talent from a another class; abuse of game systems will result in a ban.");
            }

            if (curPoints->Sum == 0)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Not enough talent points available. Available: " + std::to_string(curPoints->Sum));
                return;
            }

            // check dependants, rank requirements
            auto talItt = tab->Talents.find(spellId);

            if (talItt == tab->Talents.end())
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Unknown Talent");
                return;
            }

            auto ft = talItt->second;

            if (curPoints->Sum < ft->RankCost)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Not enough points available. Available: " + std::to_string(curPoints->Sum));
                return;
            }

            if (ft->RequiredLevel > iam.player->getLevel())
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Not high enough level");
                return;
            }

            ForgeCharacterPoint* pointMax = fc->GetMaxPointDefaults(tabType);

            if (pointMax->Sum != 0 && spec->PointsSpent[tabId] + ft->RankCost > pointMax->Sum)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Cost is over max allowed skill points for this tab.");
                return;
            }

            if (spec->PointsSpent[tabId] < ft->TabPointReq)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "You need to spend more points in this tree to be able to invest.");
                return;
            }

            auto sklTItt = spec->Talents.find(tabId);
            std::unordered_map<uint32, ForgeCharacterTalent*> skillTabs;

            if (sklTItt == spec->Talents.end())
            {
                skillTabs = spec->Talents[tabId];
            }
            else
                skillTabs = sklTItt->second;

            int reqsNotMet = 0;

            for (auto& preReq : ft->Prereqs)
            {
                if (preReq->RequiredRank == 0)
                    continue;

                auto preReqTalent = tab->Talents.find(preReq->Talent);

                if (preReqTalent == tab->Talents.end())
                    continue;

                if (preReqTalent->second->NumberOfRanks == 0)
                    continue;

                if (tabId == preReq->TalentTabId)
                {
                    auto slillItt = skillTabs.find(preReq->Talent);

                    if (slillItt == skillTabs.end() || preReq->RequiredRank > slillItt->second->CurrentRank)
                    {
                        reqsNotMet++;
                        continue;
                    }
                }
                else
                {
                    auto fsItt = spec->Talents.find(tabId);

                    if (fsItt == spec->Talents.end())
                    {
                        auto tsItt = spec->Talents.find(tabId);

                        if (tsItt == spec->Talents.end())
                        {
                            reqsNotMet++;
                            continue;
                        }

                        auto typeItt = tsItt->second.find(preReq->reqId);

                        if (typeItt == tsItt->second.end())
                        {
                            reqsNotMet++;
                            continue;
                        }

                        if (typeItt->second->CurrentRank < preReq->RequiredRank)
                        {
                            reqsNotMet++;
                            continue;
                        }
                    }
                    else
                    {
                        auto typeItt = fsItt->second.find(preReq->reqId);

                        if (typeItt == fsItt->second.end())
                        {
                            reqsNotMet++;
                            continue;
                        }

                        if (typeItt->second->CurrentRank < preReq->RequiredRank)
                        {
                            reqsNotMet++;
                            continue;
                        }
                    }
                }
            }

            if (reqsNotMet != 0)
            {
                if (ft->PreReqType == PereqReqirementType::ALL)
                {
                    RequirementsNotMet(iam);
                    return;
                }
                else if (ft->Prereqs.size() == reqsNotMet)
                {
                    RequirementsNotMet(iam);
                    return;
                }
            }

            // TODO: FIX
            //for (auto& exclu : ft->Choices)
            //{
            //    auto typeItt = skillTabs.find(exclu);

            //    if (typeItt != skillTabs.end() && typeItt->second->CurrentRank > 0)
            //    {
            //        RequirementsNotMet(iam);
            //        return;
            //    }
            //}

            auto spellItter = skillTabs.find(ft->SpellId);
            ForgeCharacterTalent* ct = new ForgeCharacterTalent();

            if (spellItter == skillTabs.end())
            {
                ct->CurrentRank = 0;
                ct->SpellId = ft->SpellId;
                ct->TabId = tabId;
                spec->Talents[tabId][ft->SpellId] = ct;
            }
            else
                ct = spellItter->second;

            if (ft->NumberOfRanks == ct->CurrentRank)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Spell at Max Level");
                return;
            }

            spec->PointsSpent[tabId] += ft->RankCost;
            curPoints->Sum -= ft->RankCost;

            auto ranksItt = ft->Ranks.find(ct->CurrentRank);

            // unlearn old
            if (tabType == CharacterPointType::PET_TALENT) {
                auto pet = iam.player->GetPet();
                for (auto s : ft->UnlearnSpells) {
                    pet->unlearnSpell(s, false);
                    pet->RemoveSpell(s);
                }

                if (ranksItt != ft->Ranks.end()) {
                    pet->unlearnSpell(ranksItt->second, false);
                    pet->RemoveSpell(ranksItt->second);
                }
            }
            else {
                for (auto s : ft->UnlearnSpells) {
                    iam.player->removeSpell(s, SPEC_MASK_ALL, false);
                    iam.player->RemoveSpell(s);
                }

                if (ranksItt != ft->Ranks.end()) {
                    iam.player->removeSpell(ranksItt->second, SPEC_MASK_ALL, false);
                    iam.player->RemoveSpell(ranksItt->second);
                }
            }
            ct->CurrentRank++;
            ranksItt = ft->Ranks.find(ct->CurrentRank);

            if (ranksItt != ft->Ranks.end()) {
                if (tabType == CharacterPointType::PET_TALENT) {
                    auto pet = iam.player->GetPet();
                    pet->learnSpell(ranksItt->second);
                } else {
                    auto spellInfo = sSpellMgr->GetSpellInfo(ranksItt->second);

                    if (!iam.player->HasSpell(ranksItt->second)) {
                        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL) {
                                if (!iam.player->HasSpell(spellInfo->Effects[i].TriggerSpell))
                                    iam.player->learnSpell(spellInfo->Effects[i].TriggerSpell, spellInfo->IsPassive());
                            }

                        iam.player->learnSpell(ranksItt->second, spellInfo->IsPassive());
                    }
                }
            }

            fc->UpdateCharPoints(iam.player, curPoints);
            fc->UpdateCharacterSpec(iam.player, spec);
            cm->SendSpecInfo(iam.player);
            cm->SendTalents(iam.player);

            iam.player->SendPlaySpellVisual(179); // 53 SpellCastDirected
            iam.player->SendPlaySpellImpact(iam.player->GetGUID(), 362); // 113 EmoteSalute
        }
        else
            iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Unknown Tab");

    }


    void RequirementsNotMet(ForgeAddonMessage& iam)
    {
        iam.player->SendForgeUIMsg(ForgeTopic::LEARN_TALENT_ERROR, "Requrements not met");
    }

private:
    ForgeCommonMessage* cm;
    ForgeCache* fc;
};
