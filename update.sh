#!/bin/sh

set -e

rm -rf .update
git clone https://git.osgeo.org/gitea/geos/geos.git .update

cd .update
git checkout 3.8.1
sh autogen.sh
./configure

cd ..
mkdir Sources.new
mkdir Sources.new/geos
cp .update/COPYING Sources.new/
cp -R .update/include Sources.new/geos/
cp -R .update/capi Sources.new/geos/
cp -R .update/src Sources.new/geos/
rm -rf .update

cd Sources.new/geos
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

cd ../..
mv Sources Sources.old
mv Sources.new Sources
