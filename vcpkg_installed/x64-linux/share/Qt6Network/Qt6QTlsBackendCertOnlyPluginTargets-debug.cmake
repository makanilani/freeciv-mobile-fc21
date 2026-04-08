#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QTlsBackendCertOnlyPlugin" for configuration "Debug"
set_property(TARGET Qt6::QTlsBackendCertOnlyPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QTlsBackendCertOnlyPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/libqcertonlybackend.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QTlsBackendCertOnlyPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QTlsBackendCertOnlyPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/libqcertonlybackend.a" )

# Import target "Qt6::QTlsBackendCertOnlyPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QTlsBackendCertOnlyPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QTlsBackendCertOnlyPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/objects-Debug/QTlsBackendCertOnlyPlugin_init/QTlsBackendCertOnlyPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QTlsBackendCertOnlyPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QTlsBackendCertOnlyPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/tls/objects-Debug/QTlsBackendCertOnlyPlugin_init/QTlsBackendCertOnlyPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
