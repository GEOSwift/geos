Pod::Spec.new do |s|
  s.name = 'geos'
  s.version = '7.0.0'
  s.summary = 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  s.homepage = 'http://trac.osgeo.org/geos'
  s.license = {
    type: 'GNU LGPL 2.1',
    file: 'Sources/COPYING',
  }
  s.authors = 'Sandro Santilli', 'Martin Davis', 'Howard Butler', 'Regina Obe', 'Dale Lutz', 'Paul Ramsey', 'Dan Baston'
  s.source = {
    git: 'https://github.com/GEOSwift/geos.git',
    tag: s.version,
  }
  s.platforms = {
    ios: '9.0',
    osx: '10.9',
    tvos: '9.0',
    watchos: '2.0',
  }
  s.preserve_paths = 'Sources/geos/**/*'
  s.source_files = 'Sources/geos/{src,capi,public}/**/*'
  s.public_header_files = 'Sources/geos/public/**/*'
  s.user_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => 'GEOS_USE_ONLY_R_API',
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
  }
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/geos/Sources/geos/include ${PODS_ROOT}/geos/Sources/geos/public ${PODS_ROOT}/geos/Sources/geos/src/deps',
    'GCC_PREPROCESSOR_DEFINITIONS' => 'USE_UNSTABLE_GEOS_CPP_API GEOS_INLINE NDEBUG',
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
    'CLANG_WARN_UNREACHABLE_CODE' => 'NO',
  }
end
