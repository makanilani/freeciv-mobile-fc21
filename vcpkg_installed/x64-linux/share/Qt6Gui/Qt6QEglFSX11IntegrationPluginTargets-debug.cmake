#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QEglFSX11IntegrationPlugin" for configuration "Debug"
set_property(TARGET Qt6::QEglFSX11IntegrationPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QEglFSX11IntegrationPlugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/egldeviceintegrations/libqeglfs-x11-integration.a"
  )

list(APPEND _cmake_import_check_targets Qt6::QEglFSX11IntegrationPlugin )
list(APPEND _cmake_import_check_files_for_Qt6::QEglFSX11IntegrationPlugin "${_IMPORT_PREFIX}/debug/Qt6/plugins/egldeviceintegrations/libqeglfs-x11-integration.a" )

# Import target "Qt6::QEglFSX11IntegrationPlugin_init" for configuration "Debug"
set_property(TARGET Qt6::QEglFSX11IntegrationPlugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Qt6::QEglFSX11IntegrationPlugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_DEBUG ""
  IMPORTED_OBJECTS_DEBUG "${_IMPORT_PREFIX}/debug/Qt6/plugins/egldeviceintegrations/objects-Debug/QEglFSX11IntegrationPlugin_init/QEglFSX11IntegrationPlugin_init.cpp.o"
  )

list(APPEND _cmake_import_check_targets Qt6::QEglFSX11IntegrationPlugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QEglFSX11IntegrationPlugin_init "${_IMPORT_PREFIX}/debug/Qt6/plugins/egldeviceintegrations/objects-Debug/QEglFSX11IntegrationPlugin_init/QEglFSX11IntegrationPlugin_init.cpp.o" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
