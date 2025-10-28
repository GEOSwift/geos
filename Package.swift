// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "geos",
    platforms: [.iOS(.v12), .macOS(.v10_13), .tvOS(.v12), .watchOS(.v4), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "geos",
            type: .dynamic,
            targets: ["geos"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "geos",
            publicHeadersPath: "public",
            cxxSettings: [
                .define("USE_UNSTABLE_GEOS_CPP_API"),
                .define("NDEBUG"),
                .headerSearchPath("include"),
                .headerSearchPath("src/deps")
            ]
        )
    ],
    cxxLanguageStandard: .cxx17
)
