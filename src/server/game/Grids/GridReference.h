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

#ifndef _GRIDREFERENCE_H
#define _GRIDREFERENCE_H

#include "LinkedReference/Reference.h"

template<class OBJECT>
class GridRefMgr;

template<class OBJECT>
class GridReference : public Reference<GridRefMgr<OBJECT>, OBJECT>
{
protected:
    void targetObjectBuildLink() override
    {
        // called from link()
        this->getTarget()->insertFirst(this);
        this->getTarget()->incSize();
    }
    void targetObjectDestroyLink() override
    {
        // called from unlink()
        if (this->isValid()) this->getTarget()->decSize();
    }
    void sourceObjectDestroyLink() override
    {
        // called from invalidate()
        this->getTarget()->decSize();
    }
public:
    GridReference() : Reference<GridRefMgr<OBJECT>, OBJECT>() {}
    ~GridReference() override { this->unlink(); }
    auto next() -> GridReference* { return (GridReference*)Reference<GridRefMgr<OBJECT>, OBJECT>::next(); }
};
#endif
