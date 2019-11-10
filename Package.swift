// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "geos",
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
