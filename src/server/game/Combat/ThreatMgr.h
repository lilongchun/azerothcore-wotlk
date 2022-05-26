/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _THREATMANAGER
#define _THREATMANAGER

#include "Common.h"
#include "ObjectGuid.h"
#include "Reference.h"
#include "SharedDefines.h"
#include "UnitEvents.h"
#include <list>

//==============================================================

class Unit;
class Creature;
class ThreatMgr;
class SpellInfo;

#define THREAT_UPDATE_INTERVAL 2 * IN_MILLISECONDS    // Server should send threat update to client periodically each second

//==============================================================
// Class to calculate the real threat based

struct ThreatCalcHelper
{
    static float calcThreat(Unit* hatedUnit, Unit* hatingUnit, float threat, SpellSchoolMask schoolMask = SPELL_SCHOOL_MASK_NORMAL, SpellInfo const* threatSpell = nullptr);
    static bool isValidProcess(Unit* hatedUnit, Unit* hatingUnit, SpellInfo const* threatSpell = nullptr);
};

//==============================================================
class HostileReference : public Reference<Unit, ThreatMgr>
{
public:
    HostileReference(Unit* refUnit, ThreatMgr* threatMgr, float threat);

    //=================================================
    void addThreat(float modThreat);

    void setThreat(float threat) { addThreat(threat - getThreat()); }

    void addThreatPercent(int32 percent);

    [[nodiscard]] float getThreat() const { return iThreat; }

    [[nodiscard]] bool isOnline() const { return iOnline; }

    // used for temporary setting a threat and reducting it later again.
    // the threat modification is stored
    void setTempThreat(float threat)
    {
        addTempThreat(threat - getThreat());
    }

    void addTempThreat(float threat)
    {
        iTempThreatModifier = threat;
        if (iTempThreatModifier != 0.0f)
            addThreat(iTempThreatModifier);
    }

    void resetTempThreat()
    {
        if (iTempThreatModifier != 0.0f)
        {
            addThreat(-iTempThreatModifier);
            iTempThreatModifier = 0.0f;
        }
    }

    float getTempThreatModifier() { return iTempThreatModifier; }

    //=================================================
    // check, if source can reach target and set the status
    void updateOnlineStatus();

    void setOnlineOfflineState(bool isOnline);
    //=================================================

    bool operator == (const HostileReference& hostileRef) const { return hostileRef.getUnitGuid() == getUnitGuid(); }

    //=================================================

    [[nodiscard]] ObjectGuid getUnitGuid() const { return iUnitGuid; }

    //=================================================
    // reference is not needed anymore. realy delete it !

    void removeReference();

    //=================================================

    HostileReference* next() { return ((HostileReference*) Reference<Unit, ThreatMgr>::next()); }

    //=================================================

    // Tell our refTo (target) object that we have a link
    void targetObjectBuildLink() override;

    // Tell our refTo (taget) object, that the link is cut
    void targetObjectDestroyLink() override;

    // Tell our refFrom (source) object, that the link is cut (Target destroyed)
    void sourceObjectDestroyLink() override;
private:
    // Inform the source, that the status of that reference was changed
    void fireStatusChanged(ThreatRefStatusChangeEvent& threatRefStatusChangeEvent);

    Unit* GetSourceUnit();
private:
    float iThreat;
    float iTempThreatModifier;                          // used for taunt
    ObjectGuid iUnitGuid;
    bool iOnline;
};

//==============================================================
class ThreatMgr;

class ThreatContainer
{
    friend class ThreatMgr;

public:
    typedef std::list<HostileReference*> StorageType;

    ThreatContainer() = default;

    ~ThreatContainer() { clearReferences(); }

    HostileReference* addThreat(Unit* victim, float threat);

    void modifyThreatPercent(Unit* victim, int32 percent);

    HostileReference* selectNextVictim(Creature* attacker, HostileReference* currentVictim) const;

    void setDirty(bool isDirty) { iDirty = isDirty; }

    [[nodiscard]] bool isDirty() const { return iDirty; }

    [[nodiscard]] bool empty() const
    {
        return iThreatList.empty();
    }

    [[nodiscard]] HostileReference* getMostHated() const
    {
        return iThreatList.empty() ? nullptr : iThreatList.front();
    }

    HostileReference* getReferenceByTarget(Unit* victim) const;

    [[nodiscard]] StorageType const& getThreatList() const { return iThreatList; }

private:
    void remove(HostileReference* hostileRef)
    {
        iThreatList.remove(hostileRef);
    }

    void addReference(HostileReference* hostileRef)
    {
        iThreatList.push_back(hostileRef);
    }

    void clearReferences();

    // Sort the list if necessary
    void update();

    StorageType iThreatList;
    bool iDirty{false};
};

//=================================================

class ThreatMgr
{
public:
    friend class HostileReference;

    explicit ThreatMgr(Unit* owner);

    ~ThreatMgr() { clearReferences(); }

    void clearReferences();

    void addThreat(Unit* victim, float threat, SpellSchoolMask schoolMask = SPELL_SCHOOL_MASK_NORMAL, SpellInfo const* threatSpell = nullptr);

    void doAddThreat(Unit* victim, float threat);

    void modifyThreatPercent(Unit* victim, int32 percent);

    float getThreat(Unit* victim, bool alsoSearchOfflineList = false);

    float getThreatWithoutTemp(Unit* victim, bool alsoSearchOfflineList = false);

    [[nodiscard]] bool isThreatListEmpty() const { return iThreatContainer.empty(); }
    [[nodiscard]] bool areThreatListsEmpty() const { return iThreatContainer.empty() && iThreatOfflineContainer.empty(); }

    void processThreatEvent(ThreatRefStatusChangeEvent* threatRefStatusChangeEvent);

    bool isNeedUpdateToClient(uint32 time);

    [[nodiscard]] HostileReference* getCurrentVictim() const { return iCurrentVictim; }

    [[nodiscard]] Unit* GetOwner() const { return iOwner; }

    Unit* getHostileTarget();

    void tauntApply(Unit* taunter);
    void tauntFadeOut(Unit* taunter);

    void setCurrentVictim(HostileReference* hostileRef);

    void setDirty(bool isDirty) { iThreatContainer.setDirty(isDirty); }

    // Reset all aggro without modifying the threadlist.
    void resetAllAggro();

    // -- compatibility layer for combat rewrite
    void ResetAllThreat() { resetAllAggro(); }

    void ClearAllThreat();

    // Reset all aggro of unit in threadlist satisfying the predicate.
    template<class PREDICATE> void resetAggro(PREDICATE predicate)
    {
        ThreatContainer::StorageType& threatList = iThreatContainer.iThreatList;
        if (threatList.empty())
            return;

        for (auto ref : threatList)
        {
            if (predicate(ref->getTarget()))
            {
                ref->setThreat(0);
                setDirty(true);
            }
        }
    }

    // methods to access the lists from the outside to do some dirty manipulation (scriping and such)
    // I hope they are used as little as possible.
    [[nodiscard]] ThreatContainer::StorageType const& getThreatList() const { return iThreatContainer.getThreatList(); }
    [[nodiscard]] ThreatContainer::StorageType const& getOfflineThreatList() const { return iThreatOfflineContainer.getThreatList(); }
    ThreatContainer& getOnlineContainer() { return iThreatContainer; }
    ThreatContainer& getOfflineContainer() { return iThreatOfflineContainer; }
private:
    void _addThreat(Unit* victim, float threat);

    HostileReference* iCurrentVictim;
    Unit* iOwner;
    uint32 iUpdateTimer;
    ThreatContainer iThreatContainer;
    ThreatContainer iThreatOfflineContainer;
};

//=================================================

namespace Acore
{
    // Binary predicate for sorting HostileReferences based on threat value
    class ThreatOrderPred
    {
    public:
        ThreatOrderPred(bool ascending = false) : m_ascending(ascending) {}
        bool operator() (HostileReference const* a, HostileReference const* b) const
        {
            return m_ascending ? a->getThreat() < b->getThreat() : a->getThreat() > b->getThreat();
        }
    private:
        const bool m_ascending;
    };
}
#endif
