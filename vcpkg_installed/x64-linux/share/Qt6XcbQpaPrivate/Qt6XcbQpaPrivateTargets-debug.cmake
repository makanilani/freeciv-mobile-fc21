#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::XcbQpaPrivate" for configuration "Debug"
set_property(TARGET Qt6::XcbQpaPrivate APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::XcbQpaPrivate PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C;CXX"
  IMPORTED_LINK_INTERFACE_MULTIPLICITY_DEBUG "3"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libQt6XcbQpa.a"
  )

list(APPEND _cmake_import_check_targets Qt6::XcbQpaPrivate )
list(APPEND _cmake_import_check_files_for_Qt6::XcbQpaPrivate "${_IMPORT_PREFIX}/debug/lib/libQt6XcbQpa.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
