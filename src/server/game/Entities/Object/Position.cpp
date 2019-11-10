/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2015 TrinityCore <http://www.trinitycore.org/>
 */

#include "Position.h"
#include "ByteBuffer.h"
#include "Util.h"
#include <G3D/g3dmath.h>
#include <sstream>

bool Position::operator==(Position const& a)
{
    return (G3D::fuzzyEq(a.m_positionX, m_positionX) &&
        G3D::fuzzyEq(a.m_positionY, m_positionY) &&
        G3D::fuzzyEq(a.m_positionZ, m_positionZ) &&
        G3D::fuzzyEq(a.m_orientation, m_orientation));
}

bool Position::HasInLine(Position const* pos, float width) const
{
    if (!HasInArc(M_PI, pos))
        return false;

    float angle = GetRelativeAngle(pos);
    return std::fabs(std::sin(angle)) * GetExactDist2d(pos->GetPositionX(), pos->GetPositionY()) < width;
}

std::string Position::ToString() const
{
    std::stringstream sstr;
    sstr << "X: " << m_positionX << " Y: " << m_positionY << " Z: " << m_positionZ << " O: " << m_orientation;
    return sstr.str();
}

ByteBuffer& operator>>(ByteBuffer& buf, Position::PositionXYZOStreamer const& streamer)
{
    float x, y, z, o;
    buf >> x >> y >> z >> o;
    streamer.m_pos->Relocate(x, y, z, o);
    return buf;
}

ByteBuffer& operator<<(ByteBuffer& buf, Position::PositionXYZStreamer const& streamer)
{
    float x, y, z;
    streamer.m_pos->GetPosition(x, y, z);
    buf << x << y << z;
    return buf;
}

ByteBuffer& operator>>(ByteBuffer& buf, Position::PositionXYZStreamer const& streamer)
{
    float x, y, z;
    buf >> x >> y >> z;
    streamer.m_pos->Relocate(x, y, z);
    return buf;
}

ByteBuffer& operator<<(ByteBuffer& buf, Position::PositionXYZOStreamer const& streamer)
{
    float x, y, z, o;
    streamer.m_pos->GetPosition(x, y, z, o);
    buf << x << y << z << o;
    return buf;
}

void Position::RelocateOffset(const Position& offset)
{
    m_positionX = GetPositionX() + (offset.GetPositionX() * cos(GetOrientation()) + offset.GetPositionY() * sin(GetOrientation() + M_PI));
    m_positionY = GetPositionY() + (offset.GetPositionY() * cos(GetOrientation()) + offset.GetPositionX() * sin(GetOrientation()));
    m_positionZ = GetPositionZ() + offset.GetPositionZ();
    m_orientation = GetOrientation() + offset.GetOrientation();
}

void Position::GetPositionOffsetTo(const Position& endPos, Position& retOffset) const
{
    float dx = endPos.GetPositionX() - GetPositionX();
    float dy = endPos.GetPositionY() - GetPositionY();

    retOffset.m_positionX = dx * cos(GetOrientation()) + dy * sin(GetOrientation());
    retOffset.m_positionY = dy * cos(GetOrientation()) - dx * sin(GetOrientation());
    retOffset.m_positionZ = endPos.GetPositionZ() - GetPositionZ();
    retOffset.m_orientation = endPos.GetOrientation() - GetOrientation();
}

float Position::GetAngle(const Position* obj) const
{
    if (!obj)
        return 0;

    return GetAngle(obj->GetPositionX(), obj->GetPositionY());
}

// Return angle in range 0..2*pi
float Position::GetAngle(const float x, const float y) const
{
    float dx = x - GetPositionX();
    float dy = y - GetPositionY();

    float ang = atan2(dy, dx);
    ang = (ang >= 0) ? ang : 2 * M_PI + ang;
    return ang;
}

void Position::GetSinCos(const float x, const float y, float& vsin, float& vcos) const
{
    float dx = GetPositionX() - x;
    float dy = GetPositionY() - y;

    if (fabs(dx) < 0.001f && fabs(dy) < 0.001f)
    {
        float angle = (float)rand_norm() * static_cast<float>(2 * M_PI);
        vcos = cos(angle);
        vsin = sin(angle);
    }
    else
    {
        float dist = sqrt((dx * dx) + (dy * dy));
        vcos = dx / dist;
        vsin = dy / dist;
    }
}

bool Position::IsWithinBox(const Position& center, float xradius, float yradius, float zradius) const
{
    // rotate the WorldObject position instead of rotating the whole cube, that way we can make a simplified
    // is-in-cube check and we have to calculate only one point instead of 4

    // 2PI = 360*, keep in mind that ingame orientation is counter-clockwise
    double rotation = 2 * M_PI - center.GetOrientation();
    double sinVal = std::sin(rotation);
    double cosVal = std::cos(rotation);

    float BoxDistX = GetPositionX() - center.GetPositionX();
    float BoxDistY = GetPositionY() - center.GetPositionY();

    float rotX = float(center.GetPositionX() + BoxDistX * cosVal - BoxDistY * sinVal);
    float rotY = float(center.GetPositionY() + BoxDistY * cosVal + BoxDistX * sinVal);

    // box edges are parallel to coordiante axis, so we can treat every dimension independently :D
    float dz = GetPositionZ() - center.GetPositionZ();
    float dx = rotX - center.GetPositionX();
    float dy = rotY - center.GetPositionY();
    if ((std::fabs(dx) > xradius) ||
        (std::fabs(dy) > yradius) ||
        (std::fabs(dz) > zradius))
        return false;

    return true;
}

bool Position::HasInArc(float arc, const Position* obj, float targetRadius) const
{
    // always have self in arc
    if (obj == this)
        return true;

    // move arc to range 0.. 2*pi
    arc = Position::NormalizeOrientation(arc);

    float angle = GetAngle(obj);
    angle -= m_orientation;

    // move angle to range -pi ... +pi
    angle = Position::NormalizeOrientation(angle);
    if (angle > M_PI)
        angle -= 2.0f * M_PI;

    float lborder = -1 * (arc / 2.0f);                        // in range -pi..0
    float rborder = (arc / 2.0f);                             // in range 0..pi

    // pussywizard: take into consideration target size 
    if (targetRadius > 0.0f)
    {
        float distSq = GetExactDist2dSq(obj);

        // pussywizard: at least a part of target's model is in every direction 
        if (distSq < targetRadius * targetRadius)
            return true;

        float angularRadius = 2.0f * atan(targetRadius / (2.0f * sqrt(distSq)));
        lborder -= angularRadius;
        rborder += angularRadius;
    }

    return ((angle >= lborder) && (angle <= rborder));
}

bool Position::IsPositionValid() const
{
    return Trinity::IsValidMapCoord(m_positionX, m_positionY, m_positionZ, m_orientation);
}
