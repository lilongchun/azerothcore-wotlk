/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ObjectPosSelector.h"

ObjectPosSelector::ObjectPosSelector(float x, float y, float size, float dist)
: m_center_x(x), m_center_y(y), m_size(size), m_dist(dist)
{
    m_anglestep = acos(m_dist/(m_dist+2*m_size));

    m_nextUsedPos[USED_POS_PLUS]  = m_UsedPosLists[USED_POS_PLUS].end();
    m_nextUsedPos[USED_POS_MINUS] = m_UsedPosLists[USED_POS_MINUS].end();

    m_smallStepAngle[USED_POS_PLUS]  = 0;
    m_smallStepAngle[USED_POS_MINUS] = 0;

    m_smallStepOk[USED_POS_PLUS]  = false;
    m_smallStepOk[USED_POS_MINUS] = false;

    m_smallStepNextUsedPos[USED_POS_PLUS]  = NULL;
    m_smallStepNextUsedPos[USED_POS_MINUS] = NULL;
}

ObjectPosSelector::UsedPosList::value_type const* ObjectPosSelector::nextUsedPos(UsedPosType uptype)
{
    UsedPosList::const_iterator itr = m_nextUsedPos[uptype];
    if (itr!=m_UsedPosLists[uptype].end())
        ++itr;

    if (itr==m_UsedPosLists[uptype].end())
    {
        if (!m_UsedPosLists[~uptype].empty())
            return &*m_UsedPosLists[~uptype].rbegin();
        else
            return NULL;
    }
    else
        return &*itr;
}

void ObjectPosSelector::AddUsedPos(float size, float angle, float dist)
{
    if (angle >= 0)
        m_UsedPosLists[USED_POS_PLUS].insert(UsedPosList::value_type(angle, UsedPos(1.0f, size, dist)));
    else
        m_UsedPosLists[USED_POS_MINUS].insert(UsedPosList::value_type(-angle, UsedPos(-1.0f, size, dist)));
}

void ObjectPosSelector::InitializeAngle()
{
    m_nextUsedPos[USED_POS_PLUS]  = m_UsedPosLists[USED_POS_PLUS].begin();
    m_nextUsedPos[USED_POS_MINUS] = m_UsedPosLists[USED_POS_MINUS].begin();

    m_smallStepAngle[USED_POS_PLUS]  = 0;
    m_smallStepAngle[USED_POS_MINUS] = 0;

    m_smallStepOk[USED_POS_PLUS]  = true;
    m_smallStepOk[USED_POS_MINUS] = true;
}

bool ObjectPosSelector::FirstAngle(float& angle)
{
    if (m_UsedPosLists[USED_POS_PLUS].empty() && !m_UsedPosLists[USED_POS_MINUS].empty())
        return NextAngleFor(*m_UsedPosLists[USED_POS_MINUS].begin(), 1.0f, USED_POS_PLUS, angle);
    else if (m_UsedPosLists[USED_POS_MINUS].empty() && !m_UsedPosLists[USED_POS_PLUS].empty())
        return NextAngleFor(*m_UsedPosLists[USED_POS_PLUS].begin(), -1.0f, USED_POS_MINUS, angle);

    return false;
}

bool ObjectPosSelector::NextAngle(float& angle)
{
    while (m_nextUsedPos[USED_POS_PLUS]!=m_UsedPosLists[USED_POS_PLUS].end() ||
        m_nextUsedPos[USED_POS_MINUS]!=m_UsedPosLists[USED_POS_MINUS].end() ||
        m_smallStepOk[USED_POS_PLUS] || m_smallStepOk[USED_POS_MINUS] )
    {
        // calculate next possible angle
        if (NextPosibleAngle(angle))
            return true;
    }

    return false;
}

bool ObjectPosSelector::NextUsedAngle(float& angle)
{
    while (m_nextUsedPos[USED_POS_PLUS]!=m_UsedPosLists[USED_POS_PLUS].end() ||
        m_nextUsedPos[USED_POS_MINUS]!=m_UsedPosLists[USED_POS_MINUS].end())
    {
        // calculate next possible angle
        if (!NextPosibleAngle(angle))
            return true;
    }

    return false;
}

bool ObjectPosSelector::NextPosibleAngle(float& angle)
{
    // ++ direction less updated
    if (m_nextUsedPos[USED_POS_PLUS]!=m_UsedPosLists[USED_POS_PLUS].end() &&
        (m_nextUsedPos[USED_POS_MINUS]==m_UsedPosLists[USED_POS_MINUS].end() || m_nextUsedPos[USED_POS_PLUS]->first <= m_nextUsedPos[USED_POS_MINUS]->first))
    {
        bool ok;
        if (m_smallStepOk[USED_POS_PLUS])
            ok = NextSmallStepAngle(1.0f, USED_POS_PLUS, angle);
        else
            ok = NextAngleFor(*m_nextUsedPos[USED_POS_PLUS], 1.0f, USED_POS_PLUS, angle);

        if (!ok)
            ++m_nextUsedPos[USED_POS_PLUS];                 // increase. only at fail (original or checked)
        return ok;
    }
    // -- direction less updated
    else if (m_nextUsedPos[USED_POS_MINUS]!=m_UsedPosLists[USED_POS_MINUS].end())
    {
        bool ok;
        if (m_smallStepOk[USED_POS_MINUS])
            ok = NextSmallStepAngle(-1.0f, USED_POS_MINUS, angle);
        else
            ok = NextAngleFor(*m_nextUsedPos[USED_POS_MINUS], -1.0f, USED_POS_MINUS, angle);

        if (!ok)
            ++m_nextUsedPos[USED_POS_MINUS];
        return ok;
    }
    else                                                    // both list empty
    {
        if (m_smallStepOk[USED_POS_PLUS] && (!m_smallStepOk[USED_POS_MINUS] || m_smallStepAngle[USED_POS_PLUS] <= m_smallStepAngle[USED_POS_MINUS]))
            return NextSmallStepAngle(1.0f, USED_POS_PLUS, angle);
        // -- direction less updated
        else if (m_smallStepOk[USED_POS_MINUS])
            return NextSmallStepAngle(-1.0f, USED_POS_MINUS, angle);
    }

    // no angles
    return false;
}
