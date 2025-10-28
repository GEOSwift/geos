# GEOS

This library is an SPM-compatible repackaging of the source code from [libgeos/geos](https://github.com/libgeos/geos):

> GEOS is a C++ library for performing operations on two-dimensional vector
> geometries. It is primarily a port of the [JTS Topology
> Suite](https://github.com/locationtech/jts) Java library.  It provides many of
> the algorithms used by [PostGIS](http://www.postgis.net/), the
> [Shapely](https://pypi.org/project/Shapely/) package for Python, the
> [sf](https://github.com/r-spatial/sf) package for R, and others.

## Versioning

Currently `main` packages [libgeos/geos 3.14.1](https://github.com/libgeos/geos/releases/tag/3.14.1).

This package follows [SemVer](https://semver.org) principles and therefore its versions don't map 1:1 with the underlying geos library. When a geos release identifies any changes as breaking, we will release a new major version of this library.

## Licensing

The source code contained in this repo is released under a dual license:
* The contents of the `Sources` directory are taken from [libgeos/geos](https://github.com/libgeos/geos) and distributed under the LGPL 2.1 license (see [COPYING](https://github.com/GEOSwift/geos/blob/main/Sources/COPYING)).
* The other content of this repo is distributed under the MIT [LICENSE](https://github.com/GEOSwift/geos/blob/main/LICENSE).

## Releasing a new version

* Create a new branch.
* Modify `update.sh` to successfully pull the new version of geos and construct an SPM-compatible `Sources` directory. This only entails pointing at a new source archive unless geos releases a new version with different build structure (rare).
* Run `update.sh`.
* Commit all modifications and open a PR.
* Once merged, release a new version numbered according to [SemVer](https://semver.org) principles. If the underlying geos release contains *any* breaking changes, increment the major release here. Minor and patch version increments are at your discretion.

