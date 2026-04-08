# iOS CMake configuration
cmake_minimum_required(VERSION 3.21)

set(CMAKE_OSX_DEPLOYMENT_TARGET "15.0")
set(CMAKE_OSX_ARCHITECTURES "arm64;arm64e")

# Find required frameworks
find_library(UIKIT UIKit)
find_library(FOUNDATION Foundation)
find_library(SWIFTUI SwiftUI)
find_library(METAL Metal)
find_library(METALKIT MetalKit)

# Create iOS app bundle
add_executable(FreecivMobile MACOSX_BUNDLE
    FreecivMobile/App/FreecivMobileApp.swift
    FreecivMobile/Engine/EngineBridge.swift
)

# Link against engine libraries and mobile FFI
target_link_libraries(FreecivMobile
    PRIVATE
        ${UIKIT}
        ${FOUNDATION}
        ${SWIFTUI}
        ${METAL}
        ${METALKIT}
        freeciv-mobile-ffi
        freeciv21-common
        freeciv21-server
)

# Set bundle properties
set_target_properties(FreecivMobile PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.freecivmobile.ios"
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/FreecivMobile/Info.plist
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2"
    XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "15.0"
)
