// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "geos",
    platforms: [.iOS(.v9), .macOS("10.9"), .tvOS(.v9)],
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
                .headerSearchPath("include")])
    ],
    cxxLanguageStandard: .cxx11
)
