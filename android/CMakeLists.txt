# Android CMake configuration
cmake_minimum_required(VERSION 3.21)

# Create native library
add_library(freeciv-mobile SHARED
    # Add your Kotlin/JNI bridge files here
    # src/main/cpp/native-lib.cpp
)

# Link against engine libraries
target_link_libraries(freeciv-mobile
    PRIVATE
        android
        log
        freeciv21-common
        freeciv21-server
)

# Set include directories for JNI headers
target_include_directories(freeciv-mobile PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main/cpp
)
