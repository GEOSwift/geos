#!/bin/sh

set -e

rm -rf .update
mkdir .update

pushd .update
curl http://download.osgeo.org/geos/geos-3.9.1.tar.bz2 | bunzip2 | tar --strip-components=1 -x
./configure
popd

rm -rf Sources
mkdir Sources
mkdir Sources/geos
cp .update/COPYING Sources/
cp -R .update/include Sources/geos/
cp -R .update/capi Sources/geos/
cp -R .update/src Sources/geos/
rm -rf .update

pushd Sources/geos
find . ! \( -name '*.cpp' -o -name '*.h' -o -name '*.inl' \) -type f -exec rm -f {} +
find . -type d -empty -delete

mkdir public
mkdir public/geos
mv capi/geos_c.h public/
mv include/geos/export.h public/geos/

echo "\
#pragma clang diagnostic push\n\
#pragma clang diagnostic ignored \"-Wstrict-prototypes\"\n\
$(cat public/geos_c.h)\n\
#pragma clang diagnostic pop" > public/geos_c.h

popd
