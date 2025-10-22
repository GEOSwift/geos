# GEOS

[![Swift Package Manager Compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/geos.svg)](https://cocoapods.org)
[![Platform](https://img.shields.io/cocoapods/p/geos.svg?style=flat)](https://github.com/GEOSwift/geos)
[![GEOSwift/geos](https://github.com/GEOSwift/geos/actions/workflows/main.yml/badge.svg)](https://github.com/GEOSwift/geos/actions/workflows/main.yml)

GEOS is an open source C++ library for working with geospatial geometry. Learn
more on its [homepage](https://libgeos.org). This repo makes its C interface
available through Swift Package Manager and CocoaPods so you can use
it in your Swift or Objective-C project. It is commonly used via
[GEOSwift](https://github.com/GEOSwift/GEOSwift).

## Minimum Requirements

* iOS 12.0, macOS 10.13, tvOS 12.0, watchOS 4.0, Linux
* Swift 5.9 compiler

> GEOS is licensed under LGPL 2.1 and its compatibility with static linking is
at least controversial. Use of geos without dynamic linking is discouraged.

## Upstream Version

GEOSwift/geos 10.0.0 packages [libgeos/geos](https://github.com/libgeos/geos) 3.14.0

## Installing with CocoaPods

1. Update your `Podfile` to include:

        use_frameworks!
        pod 'geos'

2. Run `$ pod install`

## Installing with Swift Package Manager

1. Update the top-level dependencies in your `Package.swift` to include:

        .package(url: "https://github.com/GEOSwift/geos.git", from: "10.0.0")

2. Update the target dependencies in your `Package.swift` to include

        "geos"

## History

Starting with tag 3.7.0 in this repo, the Podspec here should match the one in
the CocoaPods specs repo. This has not always been the case. For example, the
3.5.0 tag in this repo does not actually represent what you get if you install
3.5.0 from CocoaPods. Alas, this situation should be remedied as we move
forward.

Version 3.7.0 is based on the actually-published 3.5.0 podspec.

Through version 3.7.1, the version numbers in this repo were designed to match
the corresponding version numbers in GEOS itself. Starting with version 4.0.0,
we are breaking with this pattern and will instead use semantic versioning on
this build configuration itself rather than trying to match the underlying geos
version. This allows us more flexibilty to improve the build config
independently of the geos release cycle.

## License

The build configurations provided in this repo are licensed under the GPL 2.0.
See [LICENSE](LICENSE) for full details.

The contents of the Sources directory are taken from the GEOS project which is
licensed under the LGPL 2.1. See [Sources/COPYING](Sources/COPYING) for full
details.

## Developing

The most common development activity is updating to a new version of GEOS. To
get started:

1. Install cmake: `$ brew install cmake`
2. Modify `update.sh` to indicate the version of GEOS that you wish to use.
3. Run `update.sh`
4. Debug any issues. The script may need to be modified to work with newer
versions of the library. Please keep it up-to-date so that we have a record of
how to get from the GEOS source to the end result in this repo.
5. Update `Package.swift` and `geos.podspec` to ensure
continued support for Swift Package Manager and CocoaPods.
6. Test all your changes on the full matrix of supported configs
(Swift Package Manager, CocoaPods) x (iOS, macOS, tvOS, watchOS) + Swift
Package Manager x Linux.
7. Update the version numbers in `geos.podspec` and `README.md`
8. Update this README with any relevant information.
