/**********************************************************************
 *
 * GEOS - Geometry Engine Open Source
 * http://geos.osgeo.org
 *
 * Copyright (C) 2024 ISciences, LLC
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU Lesser General Public Licence as published
 * by the Free Software Foundation.
 * See the COPYING file for more information.
 *
 **********************************************************************/

#pragma once

#include <geos/export.h>
#include <geos/geom/Coordinate.h>
#include <geos/geom/Envelope.h>

namespace geos {
namespace algorithm {

class GEOS_DLL CircularArcs {
public:

    /// Return the circle center of an arc defined by three points
    static geom::CoordinateXY getCenter(const geom::CoordinateXY& p0, const geom::CoordinateXY& p1,
                                        const geom::CoordinateXY& p2);

    /// Expand an envelope to include an arc defined by three points
    static void expandEnvelope(geom::Envelope& e, const geom::CoordinateXY& p0, const geom::CoordinateXY& p1,
                               const geom::CoordinateXY& p2);
};

}
}
