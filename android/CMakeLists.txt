# Android CMake configuration
cmake_minimum_required(VERSION 3.21)

# Freeciv21 engine as static library
add_library(freeciv21-android STATIC
    ${FREE_CIV21_COMMON_SOURCES}
    ${FREE_CIV21_SERVER_SOURCES}
)

# Link against Android NDK libraries
target_link_libraries(freeciv21-android
    android
    log
    Filament::filament
)
