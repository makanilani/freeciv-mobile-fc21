# Freeciv Mobile - Root CMakeLists.txt
cmake_minimum_required(VERSION 3.21...4.3 FATAL_ERROR)

project(freeciv-mobile VERSION 0.0.1 LANGUAGES C CXX)

# Set up cmake search path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/engine/cmake)

# Always generate the compilation database by default
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# Include engine dependencies and configuration
include(${CMAKE_SOURCE_DIR}/engine/cmake/FreecivDependencies.cmake)

# Include engine's CMakeLists
add_subdirectory(engine)

# Mobile FFI bridge library (required by both iOS and Android)
add_subdirectory(mobile_ffi)

# Mobile clients - conditionally add based on platform
if(IOS)
  message(STATUS "Building for iOS")
  add_subdirectory(ios)
elseif(ANDROID)
  message(STATUS "Building for Android")
  add_subdirectory(android)
endif()

# Include data subdirectory
add_subdirectory(data)
