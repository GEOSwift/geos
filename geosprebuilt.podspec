Pod::Spec.new do |s|
  s.name	= "geosprebuilt"
  s.version	= "3.4.2"
  s.summary	= "GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS)."
  s.homepage	= "http://trac.osgeo.org/geos/"
  s.license	= { :type => "GNU LGPL 2.1",
		    :file => "COPYING" }
  s.author	= { "Yury Bychkov" => "me@yury.ca",
		    "Martin Davis" => "mbdavis@refractions.net" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.6"
  # s.source  = { :http  => "https://github.com/andreacremaschi/geos-fat-dynamic-bitcode/releases/download/3.4.2-alpha.1/geos-3.4.2.zip" }
  s.source  = { :git  => "https://github.com/andreacremaschi/geos-fat-dynamic-bitcode.git", :tag => "0.1-alpha" }
  s.source_files = "include/geos_c.h"
  s.vendored_libraries = "lib/libgeos_c.dylib", "lib/libgeos.dylib"
  s.public_header_files = "include/geos_c.h"
end
