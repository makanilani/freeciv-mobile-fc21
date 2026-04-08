#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QComposePlatformInputContextPlugin" for configuration "Debug"
set_property(TARGET Qt6::QComposePlatformInputContextPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QComposePlatformInputContextPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforminputcontexts/libcomposeplatforminputcontextplugin.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QComposePlatformInputContextPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QComposePlatformInputContextPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforminputcontexts/libcomposeplatforminputcontextplugin.a" )

# Import target "Qt6::QComposePlatformInputContextPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QComposePlatformInputContextPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QComposePlatformInputContextPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforminputcontexts/objects-Debug/QComposePlatformInputContextPlugin_init/QComposePlatformInputContextPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QComposePlatformInputContextPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QComposePlatformInputContextPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforminputcontexts/objects-Debug/QComposePlatformInputContextPlugin_init/QComposePlatformInputContextPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
