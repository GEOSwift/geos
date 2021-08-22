// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "geos",
    platforms: [.iOS(.v9), .macOS("10.9"), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(
            name: "geos",
            type: .dynamic,
            targets: ["geos"]),
    ],
    targets: [
        .target(
            name: "geos",
            exclude: ["include/geos/geom/PrecisionModel.inl",
                      "include/geos/geomgraph/Depth.inl",
                      "include/geos/geom/Coordinate.inl",
                      "include/geos/geomgraph/index/SegmentIntersector.inl",
                      "include/geos/operation/overlayng/Edge.inl",
                      "include/geos/noding/snapround/HotPixel.inl",
                      "include/geos/noding/SegmentNode.inl",
                      "include/geos/geomgraph/TopologyLocation.inl",
                      "include/geos/operation/overlayng/OverlayEdge.inl",
                      "include/geos/io/ByteOrderDataInStream.inl",
                      "include/geos/geomgraph/GeometryGraph.inl",
                      "include/geos/algorithm/LineIntersector.inl",
                      "include/geos/noding/NodingIntersectionFinder.inl",
                      "include/geos/geom/GeometryFactory.inl",
                      "include/geos/geom/Envelope.inl",
                      "include/geos/operation/overlay/MinimalEdgeRing.inl",
                      "include/geos/geomgraph/DirectedEdge.inl",
                      "include/geos/noding/MCIndexNoder.inl",
                      "include/geos/geom/MultiPolygon.inl",
                      "include/geos/io/WKTReader.inl",
                      "include/geos/algorithm/ConvexHull.inl",
                      "include/geos/operation/overlayng/EdgeKey.inl",
                      "include/geos/noding/BasicSegmentString.inl",
                      "include/geos/noding/NodedSegmentString.inl",
                      "include/geos/geom/LineSegment.inl",
                      "include/geos/geomgraph/Label.inl",
                      "include/geos/operation/overlayng/OverlayLabel.inl",
                      "include/geos/algorithm/CGAlgorithmsDD.inl",
                      "include/geos/geom/GeometryCollection.inl",
                      "include/geos/geom/Quadrant.inl",
                      "include/geos/geom/MultiLineString.inl",
                      "include/geos/geom/CoordinateArraySequenceFactory.inl"],
            publicHeadersPath: "public",
            cxxSettings: [
                .define("USE_UNSTABLE_GEOS_CPP_API"),
                .define("GEOS_INLINE"),
                .define("NDEBUG"),
                .headerSearchPath("include"),
                .headerSearchPath("src/deps")])
    ],
    cxxLanguageStandard: .cxx11
)
