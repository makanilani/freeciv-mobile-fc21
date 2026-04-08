# Mobile FFI Library
# Provides C API for mobile clients to access Freeciv21 engine

cmake_minimum_required(VERSION 3.21)

# Create static library for mobile FFI
add_library(freeciv-mobile-ffi STATIC
    ffi_game.cpp
    ffi_state.cpp
    ffi_action.cpp
    ffi_bridge.cpp
)

target_include_directories(freeciv-mobile-ffi
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/engine/common
        ${CMAKE_SOURCE_DIR}/engine/server
        ${CMAKE_SOURCE_DIR}/engine/utility
)

# Link against Freeciv21 engine libraries
target_link_libraries(freeciv-mobile-ffi
    PUBLIC
        freeciv21-common
        freeciv21-server
        freeciv21-utility
)

# Enable C++17
target_compile_features(freeciv-mobile-ffi PUBLIC cxx_std_17)