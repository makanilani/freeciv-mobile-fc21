# Android CMake configuration
cmake_minimum_required(VERSION 3.21)

# Create native library for JNI
add_library(freeciv-mobile SHARED
    jni_bridge.cpp
)

# Link against engine libraries and mobile FFI
target_link_libraries(freeciv-mobile
    PRIVATE
        android
        log
        freeciv-mobile-ffi
        freeciv21-common
        freeciv21-server
)

# Include directories
target_include_directories(freeciv-mobile PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main/cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../../
    ${CMAKE_CURRENT_SOURCE_DIR}/../../mobile_ffi
)
