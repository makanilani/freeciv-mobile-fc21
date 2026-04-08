#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::Core" for configuration "Debug"
set_property(TARGET Qt6::Core APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::Core PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C;CXX"
  IMPORTED_LINK_INTERFACE_MULTIPLICITY_DEBUG "3"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/libQt6Core.a"
  )

list(APPEND _cmake_import_check_targets Qt6::Core )
list(APPEND _cmake_import_check_files_for_Qt6::Core "${_IMPORT_PREFIX}/debug/lib/libQt6Core.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
