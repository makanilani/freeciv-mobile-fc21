#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QTlsBackendOpenSSLPlugin" for configuration "Debug"
set_property(TARGET Qt6::QTlsBackendOpenSSLPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QTlsBackendOpenSSLPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/libqopensslbackend.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QTlsBackendOpenSSLPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QTlsBackendOpenSSLPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/libqopensslbackend.a" )

# Import target "Qt6::QTlsBackendOpenSSLPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QTlsBackendOpenSSLPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QTlsBackendOpenSSLPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/objects-Debug/QTlsBackendOpenSSLPlugin_init/QTlsBackendOpenSSLPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QTlsBackendOpenSSLPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QTlsBackendOpenSSLPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/objects-Debug/QTlsBackendOpenSSLPlugin_init/QTlsBackendOpenSSLPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
