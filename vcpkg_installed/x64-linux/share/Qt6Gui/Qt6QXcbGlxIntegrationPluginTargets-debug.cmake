#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QXcbGlxIntegrationPlugin" for configuration "Debug"
set_property(TARGET Qt6::QXcbGlxIntegrationPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QXcbGlxIntegrationPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/xcbglintegrations/libqxcb-glx-integration.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QXcbGlxIntegrationPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QXcbGlxIntegrationPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/xcbglintegrations/libqxcb-glx-integration.a" )

# Import target "Qt6::QXcbGlxIntegrationPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QXcbGlxIntegrationPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QXcbGlxIntegrationPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/xcbglintegrations/objects-Debug/QXcbGlxIntegrationPlugin_init/QXcbGlxIntegrationPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QXcbGlxIntegrationPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QXcbGlxIntegrationPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/xcbglintegrations/objects-Debug/QXcbGlxIntegrationPlugin_init/QXcbGlxIntegrationPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
