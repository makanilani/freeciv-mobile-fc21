#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QLinuxFbIntegrationPlugin" for configuration "Debug"
set_property(TARGET Qt6::QLinuxFbIntegrationPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QLinuxFbIntegrationPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/libqlinuxfb.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QLinuxFbIntegrationPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QLinuxFbIntegrationPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/libqlinuxfb.a" )

# Import target "Qt6::QLinuxFbIntegrationPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QLinuxFbIntegrationPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QLinuxFbIntegrationPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/objects-Debug/QLinuxFbIntegrationPlugin_init/QLinuxFbIntegrationPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QLinuxFbIntegrationPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QLinuxFbIntegrationPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/platforms/objects-Debug/QLinuxFbIntegrationPlugin_init/QLinuxFbIntegrationPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
