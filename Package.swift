// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "geos",
    platforms: [.iOS(.v12), .macOS(.v10_13), .tvOS(.v12), .watchOS(.v4), .visionOS(.v1)],
    products: [
        .library(
            name: "geos",
            type: .dynamic,
            targets: ["geos"]),
    ],
    targets: [
        .target(
            name: "geos",
            publicHeadersPath: "public",
            cxxSettings: [
                .define("USE_UNSTABLE_GEOS_CPP_API"),
                .define("NDEBUG"),
                .headerSearchPath("include"),
                .headerSearchPath("src/deps")])
    ],
    cxxLanguageStandard: .cxx17
)
