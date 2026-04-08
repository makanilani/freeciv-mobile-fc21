#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QVncIntegrationPlugin" for configuration "Debug"
set_property(TARGET Qt6::QVncIntegrationPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QVncIntegrationPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/libqvnc.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QVncIntegrationPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QVncIntegrationPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/libqvnc.a" )

# Import target "Qt6::QVncIntegrationPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QVncIntegrationPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QVncIntegrationPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/objects-Debug/QVncIntegrationPlugin_init/QVncIntegrationPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QVncIntegrationPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QVncIntegrationPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/objects-Debug/QVncIntegrationPlugin_init/QVncIntegrationPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
