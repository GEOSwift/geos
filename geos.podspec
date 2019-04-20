Pod::Spec.new do |s|
  s.name = 'geos'
  s.version = '4.0.0'
  s.summary = 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  s.homepage = 'http://trac.osgeo.org/geos'
  s.license = {
    type: 'GNU LGPL 2.1',
    file: 'geos/COPYING'
  }
  s.author = {
    'Yury Bychkov' => 'me@yury.ca',
    'Martin Davis' => 'mbdavis@refractions.net'
  }
  s.source = {
    git: 'https://github.com/GEOSwift/geos.git',
    tag: s.version
  }
  s.platforms = { :ios => "8.0", :osx => "10.7", :tvos => "9.0" }
  s.preserve_paths = 'geos/**/*.{h,inl}'
  s.source_files = 'geos/{include,src,capi}/**/*.cpp', 'geos/capi/geos_c.h', 'geos/include/geos/export.h'
  s.exclude_files = 'geos/**/*tests*'
  s.public_header_files = 'geos/capi/geos_c.h', 'geos/include/geos/export.h'
  s.user_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => 'GEOS_USE_ONLY_R_API'
  }
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/geos/geos/include ${PODS_ROOT}/geos/geos/capi',
    'CLANG_WARN_STRICT_PROTOTYPES' => 'NO',
    'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES',
  }
  s.prepare_command = 'sh prepare.sh'
end
