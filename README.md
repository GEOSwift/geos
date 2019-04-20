# GEOS

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/geos.svg)](https://img.shields.io/cocoapods/v/geos.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/geos.svg?style=flat)](https://github.com/GEOSwift/geos)

## Supported Platforms

- iOS 8.0+
- macOS 10.7+
- tvOS 9.0+

## Podspec

GEOS is an open source C++ library for working with geospatial geometry. Learn more on its
[homepage](http://trac.osgeo.org/geos). This repo hosts a [CocoaPods](https://cocoapods.org/)
Podspec that allows you to use GEOS's threadsafe C interface in your Swift or Objective-C project.
It is commonly used via [GEOSwift](https://github.com/GEOSwift/GEOSwift). We also support
Carthage by hosting an Xcode project that builds geos as a framework.

## Requirements

* iOS 8.0+, macOS 10.7+, tvOS 9.0+
* Xcode 9+
* CocoaPods or Carthage

## Installing with CocoaPods

1. Install autotools: `$ brew install autoconf automake libtool`
2. Update your `Podfile` to include:

```
use_frameworks!
pod 'geos'
```

3. Run `$ pod install`

> GEOS is a configure/install project licensed under LGPL 2.1: it is difficult to build for iOS and
its compatibility with static linking is at least controversial. Use of geos without
dynamic-framework-based CocoaPods and with a project targeting iOS 7, even if possible, is advised
against.

## How this Podspec works

When you install this pod, GEOS is integrated into your Xcode project in a few steps:

1. Downloads the GEOS source from the project's [official git
repo](https://git.osgeo.org/gitea/geos/geos) via git submodules.
2. Runs the autotools build system (but doesn't run `make`) to configure the project files for the
system you're developing on.
3. Patches a few files to make things work.
4. The resulting source and header files are built by Xcode when you build your project.

## Installing with Carthage

1. Install autotools: `$ brew install autoconf automake libtool`
2. Add the following to your Cartfile:

```
github "GEOSwift/geos" ~> 4.0.0
```

3. Finish updating your project by following the [typical Carthage
workflow](https://github.com/Carthage/Carthage#quick-start).

## History

Starting with tag 3.7.0 in this repo, the Podspec here should match the one in the CocoaPods specs
repo. This has not always been the case. For example, the 3.5.0 tag in this repo does not actually
represent what you get if you install 3.5.0 from CocoaPods. Alas, this situation should be remedied
as we move forward.

Version 3.7.0 is based on the actually-published 3.5.0 podspec.

Through version 3.7.1, the version numbers in this repo were designed to match the corresponding
version numbers in GEOS itself. Starting with version 4.0.0, we are breaking with this pattern
and will instead use semantic versioning on this build configuration itself rather than trying to
match the underlying geos version. This allows us the flexibilty to improve the build config
independently of the geos release cycle.
