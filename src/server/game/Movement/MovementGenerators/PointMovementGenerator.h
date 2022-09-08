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

#ifndef ACORE_POINTMOVEMENTGENERATOR_H
#define ACORE_POINTMOVEMENTGENERATOR_H

#include "FollowerReference.h"
#include "MovementGenerator.h"

template<class T>
class PointMovementGenerator : public MovementGeneratorMedium< T, PointMovementGenerator<T> >
{
public:
    PointMovementGenerator(uint32 _id, float _x, float _y, float _z, float _speed = 0.0f, float orientation = 0.0f, const Movement::PointsArray* _path = nullptr,
        bool generatePath = false, bool forceDestination = false, ObjectGuid chargeTargetGUID = ObjectGuid::Empty)
        : id(_id), _x(_x), _y(_y), _z(_z), speed(_speed), _orientation(orientation), _generatePath(generatePath), _forceDestination(forceDestination),
        _chargeTargetGUID(chargeTargetGUID)
    {
        if (_path)
            _precomputedPath = *_path;
    }

    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, uint32);

    void MovementInform(T*);

    void unitSpeedChanged() { _recalculateSpeed = true; }

    MovementGeneratorType GetMovementGeneratorType() { return POINT_MOTION_TYPE; }

    bool GetDestination(float& x, float& y, float& z) const { x = _x; y = _y; z = _z; return true; }
private:
    uint32 id;
    float _x, _y, _z;
    float speed;
    float _orientation;
    bool _recalculateSpeed;
    Movement::PointsArray _precomputedPath;
    bool _generatePath;
    bool _forceDestination;
    ObjectGuid _chargeTargetGUID;
};

class AssistanceMovementGenerator : public PointMovementGenerator<Creature>
{
public:
    AssistanceMovementGenerator(float _x, float _y, float _z) :
        PointMovementGenerator<Creature>(0, _x, _y, _z) {}

    MovementGeneratorType GetMovementGeneratorType() { return ASSISTANCE_MOTION_TYPE; }
    void Finalize(Unit*);
};

// Does almost nothing - just doesn't allows previous movegen interrupt current effect.
class EffectMovementGenerator : public MovementGenerator
{
public:
    explicit EffectMovementGenerator(uint32 Id) : _Id(Id) {}
    void Initialize(Unit*) override {}
    void Finalize(Unit*) override;
    void Reset(Unit*) override {}
    bool Update(Unit*, uint32) override;
    MovementGeneratorType GetMovementGeneratorType() override { return EFFECT_MOTION_TYPE; }
private:
    uint32 _Id;
};

#endif
