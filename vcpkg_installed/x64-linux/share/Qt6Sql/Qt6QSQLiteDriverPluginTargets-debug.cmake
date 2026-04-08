#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QSQLiteDriverPlugin" for configuration "Debug"
set_property(TARGET Qt6::QSQLiteDriverPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QSQLiteDriverPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/sqldrivers/libqsqlite.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QSQLiteDriverPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QSQLiteDriverPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/sqldrivers/libqsqlite.a" )

# Import target "Qt6::QSQLiteDriverPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QSQLiteDriverPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QSQLiteDriverPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/sqldrivers/objects-Debug/QSQLiteDriverPlugin_init/QSQLiteDriverPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QSQLiteDriverPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QSQLiteDriverPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/sqldrivers/objects-Debug/QSQLiteDriverPlugin_init/QSQLiteDriverPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
