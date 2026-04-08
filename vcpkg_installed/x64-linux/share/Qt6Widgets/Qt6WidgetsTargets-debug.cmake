#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::Widgets" for configuration "Debug"
set_property(TARGET Qt6::Widgets APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Widgets PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_MULTIPLICITY_DEBUG "3"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libQt6Widgets.a"
  )

list(APPEND _cmake_import_check_targets Qt6::Widgets )
list(APPEND _cmake_import_check_files_for_Qt6::Widgets "${_IMPORT_PREFIX}/debug/lib/libQt6Widgets.a" )

# Import target "Qt6::Widgets_resources_1" for configuration "Debug"
set_property(TARGET Qt6::Widgets_resources_1 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Widgets_resources_1 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_1/.qt/rcc/qrc_qstyle_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::Widgets_resources_1 )
list(APPEND _cmake_import_check_files_for_Qt6::Widgets_resources_1 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_1/.qt/rcc/qrc_qstyle_init.cpp.o" )

# Import target "Qt6::Widgets_resources_2" for configuration "Debug"
set_property(TARGET Qt6::Widgets_resources_2 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Widgets_resources_2 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_2/.qt/rcc/qrc_qstyle1_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::Widgets_resources_2 )
list(APPEND _cmake_import_check_files_for_Qt6::Widgets_resources_2 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_2/.qt/rcc/qrc_qstyle1_init.cpp.o" )

# Import target "Qt6::Widgets_resources_3" for configuration "Debug"
set_property(TARGET Qt6::Widgets_resources_3 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Widgets_resources_3 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_3/.qt/rcc/qrc_qstyle_fusion_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::Widgets_resources_3 )
list(APPEND _cmake_import_check_files_for_Qt6::Widgets_resources_3 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_3/.qt/rcc/qrc_qstyle_fusion_init.cpp.o" )

# Import target "Qt6::Widgets_resources_4" for configuration "Debug"
set_property(TARGET Qt6::Widgets_resources_4 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Widgets_resources_4 PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_4/.qt/rcc/qrc_qmessagebox_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::Widgets_resources_4 )
list(APPEND _cmake_import_check_files_for_Qt6::Widgets_resources_4 "${_IMPORT_PREFIX}/debug/lib/objects-Debug/Widgets_resources_4/.qt/rcc/qrc_qmessagebox_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
