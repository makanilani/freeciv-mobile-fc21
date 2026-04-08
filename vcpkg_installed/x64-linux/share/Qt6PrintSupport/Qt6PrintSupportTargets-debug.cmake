#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::PrintSupport" for configuration "Debug"
set_property(TARGET Qt6::PrintSupport APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::PrintSupport PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_MULTIPLICITY_DEBUG "3"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libQt6PrintSupport.a"
  )

list(APPEND _cmake_import_check_targets Qt6::PrintSupport )
list(APPEND _cmake_import_check_files_for_Qt6::PrintSupport "${_IMPORT_PREFIX}/debug/lib/libQt6PrintSupport.a" )

# Import target "Qt6::PrintSupport_resources_1" for configuration "Debug"
set_property(TARGET Qt6::PrintSupport_resources_1 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::PrintSupport_resources_1 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/PrintSupport_resources_1/.qt/rcc/qrc_qprintdialog_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::PrintSupport_resources_1 )
list(APPEND _cmake_import_check_files_for_Qt6::PrintSupport_resources_1 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/PrintSupport_resources_1/.qt/rcc/qrc_qprintdialog_init.cpp.o" )

# Import target "Qt6::PrintSupport_resources_2" for configuration "Debug"
set_property(TARGET Qt6::PrintSupport_resources_2 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::PrintSupport_resources_2 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/PrintSupport_resources_2/.qt/rcc/qrc_qprintdialog1_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::PrintSupport_resources_2 )
list(APPEND _cmake_import_check_files_for_Qt6::PrintSupport_resources_2 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/PrintSupport_resources_2/.qt/rcc/qrc_qprintdialog1_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
