#!/bin/sh

set -e

rm -rf .update
mkdir .update

pushd .update
curl https://download.osgeo.org/geos/geos-3.11.1.tar.bz2 | bunzip2 | tar --strip-components=1 -x
cmake -DCMAKE_BUILD_TYPE=Release .
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
find . ! \( -name '*.cpp' -o -name '*.c' -o -name '*.h' -o -name '*.hpp' \) -type f -exec rm -f {} +
find . -type d -empty -delete

mkdir public
mkdir public/geos
mv capi/geos_c.h public/
mv include/geos/export.h public/geos/

popd
