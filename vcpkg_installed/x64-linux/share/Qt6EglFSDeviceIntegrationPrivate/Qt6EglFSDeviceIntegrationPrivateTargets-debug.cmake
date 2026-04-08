#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::EglFSDeviceIntegrationPrivate" for configuration "Debug"
set_property(TARGET Qt6::EglFSDeviceIntegrationPrivate APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::EglFSDeviceIntegrationPrivate PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_MULTIPLICITY_DEBUG "3"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libQt6EglFSDeviceIntegration.a"
  )

list(APPEND _cmake_import_check_targets Qt6::EglFSDeviceIntegrationPrivate )
list(APPEND _cmake_import_check_files_for_Qt6::EglFSDeviceIntegrationPrivate "${_IMPORT_PREFIX}/debug/lib/libQt6EglFSDeviceIntegration.a" )

# Import target "Qt6::EglFSDeviceIntegrationPrivate_resources_1" for configuration "Debug"
set_property(TARGET Qt6::EglFSDeviceIntegrationPrivate_resources_1 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::EglFSDeviceIntegrationPrivate_resources_1 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/EglFSDeviceIntegrationPrivate_resources_1/.qt/rcc/qrc_cursor_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::EglFSDeviceIntegrationPrivate_resources_1 )
list(APPEND _cmake_import_check_files_for_Qt6::EglFSDeviceIntegrationPrivate_resources_1 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/EglFSDeviceIntegrationPrivate_resources_1/.qt/rcc/qrc_cursor_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
