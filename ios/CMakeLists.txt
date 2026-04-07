# iOS CMake configuration
cmake_minimum_required(VERSION 3.21)

set(CMAKE_OSX_DEPLOYMENT_TARGET "15.0")
set(CMAKE_OSX_ARCHITECTURES "arm64;arm64e")

# Find required frameworks
find_library(UIKIT UIKit)
find_library(FOUNDATION Foundation)
find_library(SWIFTUI SwiftUI)

# Freeciv21 engine as static library
add_library(freeciv21-ios STATIC
    ${FREE_CIV21_COMMON_SOURCES}
    ${FREE_CIV21_SERVER_SOURCES}
)

target_link_libraries(freeciv21-ios
    ${UIKIT}
    ${FOUNDATION}
    ${SWIFTUI}
    Filament::filament
)

# Create the iOS app bundle
add_executable(FreecivMobile MACOSX_BUNDLE
    ios/FreecivMobile/App/FreecivMobileApp.swift
    ios/FreecivMobile/Engine/EngineBridge.swift
    # ... other Swift source files
)

target_link_libraries(FreecivMobile
    freeciv21-ios
)

# Set bundle properties
set_target_properties(FreecivMobile PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.freecivmobile.ios"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
)
