Pod::Spec.new do |s|
  s.name	= "geos"
  s.version	= "3.5.1"
  s.summary	= "GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS)."
  s.homepage	= "http://trac.osgeo.org/geos/"
  s.license	= { :type => "GNU LGPL 2.1",
		    :file => "geos/COPYING" }
  s.author	= { "Yury Bychkov" => "me@yury.ca",
		    "Martin Davis" => "mbdavis@refractions.net" }
  s.source	= { :git => "https://github.com/GEOSwift/geos.git", :tag => s.version }

  s.ios.deployment_target = "4.0"
  s.osx.deployment_target = "10.6"

  # gross hack to make this work with AFNetworking
  s.compiler_flags = '-D_SYSTEMCONFIGURATION_H -D__MOBILECORESERVICES__ -D__CORESERVICES__'

  s.prepare_command = <<-CMD
    git submodule update --init --recursive
    make
  CMD

  s.preserve_paths = 'src/**/*.h', 'include/**/*.{h,inl,in}', 'capi/*.{h,in}'
  
  s.source_files = 'src/**/*.cpp', 'capi/*.cpp', 'geos_svn_revision.h', 'capi/geos_c.h', 'include/geos/export.h'
  s.exclude_files = '**/*tests*'
  
  s.public_header_files = 'capi/geos_c.h', 'include/geos/export.h'

  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/geos/include ${PODS_ROOT}/geos/capi', 'CLANG_CXX_LIBRARY' => 'libstdc++'}

end

