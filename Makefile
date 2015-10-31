XCODE_DEVELOPER = $(shell xcode-select --print-path)
IOS_PLATFORM ?= iPhoneOS

# Pick latest SDK in the directory
IOS_PLATFORM_DEVELOPER = ${XCODE_DEVELOPER}/Platforms/${IOS_PLATFORM}.platform/Developer
IOS_SDK = ${IOS_PLATFORM_DEVELOPER}/SDKs/$(shell ls ${IOS_PLATFORM_DEVELOPER}/SDKs | sort -r | head -n1)

all: lib/libgeos.dylib
lib/libgeos.dylib: build_arches
	mkdir -p lib
	mkdir -p include

	# Copy includes
	cp -R build/armv7/include/geos include
	cp -R build/armv7/include/*.h include
	patch include/geos_c.h < patch-geos_c.h.diff

	# Make fat libraries for all architectures
	for file in build/armv7/lib/*.dylib; \
		do name=`basename $$file .dylib`; \
		lipo -create \
			-arch armv7 build/armv7/lib/$$name.dylib \
			-arch armv7s build/armv7s/lib/$$name.dylib \
			-arch arm64 build/arm64/lib/$$name.dylib \
			-arch i386 build/i386/lib/$$name.dylib \
			-arch x86_64 build/x86_64/lib/$$name.dylib \
			-output lib/$$name.dylib \
		; \
		install_name_tool -id @rpath/$$name.dylib lib/$$name.dylib; \
		done;

# Build separate architectures
build_arches:
	${MAKE} arch ARCH=armv7 IOS_PLATFORM=iPhoneOS HOST=arm-apple-darwin
	${MAKE} arch ARCH=armv7s IOS_PLATFORM=iPhoneOS HOST=arm-apple-darwin
	${MAKE} arch ARCH=arm64 IOS_PLATFORM=iPhoneOS HOST=arm-apple-darwin
	${MAKE} arch ARCH=i386 IOS_PLATFORM=iPhoneSimulator HOST=i386-apple-darwin
	${MAKE} arch ARCH=x86_64 IOS_PLATFORM=iPhoneSimulator HOST=x86_64-apple-darwin

PREFIX = ${CURDIR}/build/${ARCH}
LIBDIR = ${PREFIX}/lib
BINDIR = ${PREFIX}/bin
INCLUDEDIR = ${PREFIX}/include

CXX = ${XCODE_DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
CC = ${XCODE_DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
CFLAGS = -isysroot ${IOS_SDK} -I${IOS_SDK}/usr/include -arch ${ARCH} -I${INCLUDEDIR} -miphoneos-version-min=7.0 -fembed-bitcode -Wl,-bitcode_bundle
CXXFLAGS = -stdlib=libc++ -std=c++11 -isysroot ${IOS_SDK} -I${IOS_SDK}/usr/include -arch ${ARCH} -I${INCLUDEDIR} -miphoneos-version-min=7.0 -fembed-bitcode -Wl,-bitcode_bundle
LDFLAGS = -stdlib=libc++ -isysroot ${IOS_SDK} -L${LIBDIR} -L${IOS_SDK}/usr/lib -arch ${ARCH} -miphoneos-version-min=7.0

arch: ${LIBDIR}/libgeos.dylib

${LIBDIR}/libgeos.dylib: ${CURDIR}/geos
	echo "Building geos for architecture ${ARCH}..."
	cd geos && sh autogen.sh && env \
	CXX=${CXX} \
	CC=${CC} \
	CFLAGS="${CFLAGS}" \
	CXXFLAGS="${CXXFLAGS}" \
	LDFLAGS="${LDFLAGS}" ./configure --host=${HOST} --prefix=${PREFIX} --disable-static && patch libtool < ../patch-libtool.diff && make clean install 		
	# patches libtool generated file before making, since it contains an error: it should add the "bind_at_load" flag to the linker only on OSX 10.0 -> 10.3,
	# but it would apply it even on OSX > 10.9 (and it is incompatible with -fembed-bitcode)

${CURDIR}/geos:
	svn export --non-interactive --trust-server-cert --force https://svn.osgeo.org/geos/tags/3.4.2 geos
	
clean:
	rm -rf build geos proj spatialite sqlite3 include lib
