#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QEvdevTouchScreenPlugin" for configuration "Debug"
set_property(TARGET Qt6::QEvdevTouchScreenPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QEvdevTouchScreenPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/generic/libqevdevtouchplugin.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QEvdevTouchScreenPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QEvdevTouchScreenPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/generic/libqevdevtouchplugin.a" )

# Import target "Qt6::QEvdevTouchScreenPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QEvdevTouchScreenPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QEvdevTouchScreenPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/generic/objects-Debug/QEvdevTouchScreenPlugin_init/QEvdevTouchScreenPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QEvdevTouchScreenPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QEvdevTouchScreenPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/generic/objects-Debug/QEvdevTouchScreenPlugin_init/QEvdevTouchScreenPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
