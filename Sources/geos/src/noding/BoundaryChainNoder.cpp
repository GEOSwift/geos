/**********************************************************************
 *
 * GEOS - Geometry Engine Open Source
 * http://geos.osgeo.org
 *
 * Copyright (C) 2022 Martin Davis
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU Lesser General Licence as published
 * by the Free Software Foundation.
 * See the COPYING file for more information.
 *
 **********************************************************************/

#include <geos/noding/BoundaryChainNoder.h>

#include <geos/geom/Coordinate.h>
#include <geos/geom/CoordinateSequence.h>
#include <geos/noding/NodedSegmentString.h>
#include <geos/noding/SegmentString.h>


using geos::geom::CoordinateSequence;
using geos::geom::Coordinate;


namespace geos {   // geos
namespace noding { // geos::noding

/* public */
void
BoundaryChainNoder::computeNodes(std::vector<SegmentString*>* segStrings)
{
    SegmentSet boundarySegSet;
    std::vector<BoundaryChainMap> boundaryChains;
    boundaryChains.reserve(segStrings->size());
    addSegments(segStrings, boundarySegSet, boundaryChains);
    markBoundarySegments(boundarySegSet);
    m_chainList = extractChains(boundaryChains);

    Coordinate::UnorderedSet nodePts = findNodePts(m_chainList);
    if (!nodePts.empty()) {
        std::vector<SegmentString*>* tmplist = nodeChains(m_chainList, nodePts);
        // At this point we have copied all the SegmentString*
        // we want to keep, so t container needs to go away and be replaced
        delete m_chainList;
        m_chainList = tmplist;
    }
}

/* private */
Coordinate::UnorderedSet
BoundaryChainNoder::findNodePts(const std::vector<SegmentString*>* segStrings) const
{
    Coordinate::UnorderedSet interiorVertices;
    Coordinate::UnorderedSet nodes;
    for (const SegmentString* ss : *segStrings) {
        //-- endpoints are nodes
        nodes.insert(ss->getCoordinate(0));
        nodes.insert(ss->getCoordinate(ss->size() - 1));

        //-- check for duplicate interior points
        for (std::size_t i = 1; i < ss->size() - 1; i++) {
            const Coordinate& p = ss->getCoordinate(i);
            if (interiorVertices.find(p) != interiorVertices.end()) {
                nodes.insert(p);
            }
            interiorVertices.insert(p);
        }
    }
    return nodes;
}

/* private */
std::vector<SegmentString*>*
BoundaryChainNoder::nodeChains(
    const std::vector<SegmentString*>* chains,
    const Coordinate::UnorderedSet& nodePts)
{
    std::vector<SegmentString*>* nodedChains = new std::vector<SegmentString*>();
    for (SegmentString* chain : *chains) {
        nodeChain(chain, nodePts, nodedChains);
    }
    return nodedChains;
}


/* private */
void
BoundaryChainNoder::nodeChain(
    SegmentString* chain,
    const Coordinate::UnorderedSet& nodePts,
    std::vector<SegmentString*>* nodedChains)
{
    std::size_t start = 0;
    while (start < chain->size() - 1) {
        std::size_t end = findNodeIndex(chain, start, nodePts);
        //-- if no interior nodes found, keep original chain
        if (start == 0 && end == chain->size() - 1) {
            nodedChains->push_back(chain);
            return;
        }
        nodedChains->push_back(substring(chain, start, end));
        start = end;
    }
    // We replaced this SegmentString with substrings,
    // and we are discarding the containing vector later
    // so get rid of this chain now
    delete chain;
}

/* private static */
BasicSegmentString*
BoundaryChainNoder::substring(const SegmentString* segString, std::size_t start, std::size_t end)
{
    // m_substrings.emplace_back(new CoordinateSequence());
    // CoordinateSequence* pts = m_substrings.back().get();
    CoordinateSequence* pts = new CoordinateSequence();
    for (std::size_t i = start; i < end + 1; i++) {
        pts->add(segString->getCoordinate(i));
    }
    return new BasicSegmentString(pts, segString->getData());
}


/* private */
std::size_t
BoundaryChainNoder::findNodeIndex(
    const SegmentString* chain,
    std::size_t start,
    const Coordinate::UnorderedSet& nodePts) const
{
    for (std::size_t i = start + 1; i < chain->size(); i++) {
        if (nodePts.find(chain->getCoordinate(i)) != nodePts.end())
            return i;
    }
    return chain->size() - 1;
}


/* public */
std::vector<SegmentString*>*
BoundaryChainNoder::getNodedSubstrings() const
{
    return m_chainList;
}

/* private */
void
BoundaryChainNoder::addSegments(
    std::vector<SegmentString*>* segStrings,
    SegmentSet& segSet,
    std::vector<BoundaryChainMap>& boundaryChains)
{
    for (SegmentString* ss : *segStrings) {
        m_constructZ |= ss->getCoordinates()->hasZ();
        m_constructM |= ss->getCoordinates()->hasM();

        boundaryChains.emplace_back(ss);
        BoundaryChainMap& chainMap = boundaryChains.back();
        addSegments(ss, chainMap, segSet);
    }
}

/* private static */
bool
BoundaryChainNoder::segSetContains(SegmentSet& segSet, Segment& seg)
{
    auto search = segSet.find(seg);
    if(search != segSet.end()) {
        return true;
    }
    else {
        return false;
    }
}

/* private static */
void
BoundaryChainNoder::addSegments(
    SegmentString* segString,
    BoundaryChainMap& chainMap,
    SegmentSet& segSet)
{
    const CoordinateSequence& segCoords = *segString->getCoordinates();

    for (std::size_t i = 0; i < segString->size() - 1; i++) {
        Segment seg(segCoords, chainMap, i);
        if (segSetContains(segSet, seg)) {
            segSet.erase(seg);
        }
        else {
            segSet.insert(seg);
        }
    }
}


/* private static */
void
BoundaryChainNoder::markBoundarySegments(SegmentSet& segSet)
{
    for (const Segment& seg : segSet) {
        seg.markBoundary();
    }
}

/* private */
std::vector<SegmentString*>*
BoundaryChainNoder::extractChains(std::vector<BoundaryChainMap>& boundaryChains) const
{
    std::vector<SegmentString*>* chains = new std::vector<SegmentString*>();
    for (BoundaryChainMap& chainMap : boundaryChains) {
        chainMap.createChains(*chains, m_constructZ, m_constructM);
    }
    return chains;
}

/*************************************************************************
 * BoundarySegmentMap
 */

/* public */
void
BoundaryChainNoder::BoundaryChainMap::setBoundarySegment(std::size_t index)
{
    isBoundary[index] = true;
}

/* public */
void
BoundaryChainNoder::BoundaryChainMap::createChains(
    std::vector<SegmentString*>& chains,
    bool constructZ,
    bool constructM)
{
    std::size_t endIndex = 0;
    while (true) {
        std::size_t startIndex = findChainStart(endIndex);
        if (startIndex >= segString->size() - 1)
            break;
        endIndex = findChainEnd(startIndex);
        SegmentString* ss = createChain(segString, startIndex, endIndex, constructZ, constructM);
        chains.push_back(ss);
    }
}


/* private static */
SegmentString*
BoundaryChainNoder::BoundaryChainMap::createChain(
    const SegmentString* segString,
    std::size_t startIndex,
    std::size_t endIndex,
    bool constructZ,
    bool constructM)
{
    auto npts = endIndex - startIndex + 1;
    auto pts = detail::make_unique<CoordinateSequence>(0, constructZ, constructM);
    pts->reserve(npts);
    pts->add(*segString->getCoordinates(), startIndex, endIndex);

    return new NodedSegmentString(pts.release(), constructZ, constructM, segString->getData());
}

/* private */
std::size_t
BoundaryChainNoder::BoundaryChainMap::findChainStart(std::size_t index) const
{
    while (index < isBoundary.size() && ! isBoundary[index]) {
        index++;
    }
    return index;
}

/* private */
std::size_t
BoundaryChainNoder::BoundaryChainMap::findChainEnd(std::size_t index) const
{
    index++;
    while (index < isBoundary.size() && isBoundary[index]) {
        index++;
    }
    return index;
}


} // geos::noding
} // geos
