#!/bin/bash
#
# Build script for Freeciv Mobile
# Supports iOS and Android builds
#

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    echo_info "Checking prerequisites..."
    
    if ! command -v cmake &> /dev/null; then
        echo_error "CMake not found. Install CMake 3.21+"
        exit 1
    fi
    
    if ! command -v ninja &> /dev/null; then
        echo_warn "Ninja not found, will use make"
        CMAKE_GENERATOR="Unix Makefiles"
    else
        CMAKE_GENERATOR="Ninja"
    fi
    
    echo_info "CMake: $(cmake --version | head -n1)"
    echo_info "Generator: ${CMAKE_GENERATOR}"
}

# Build for Linux (engine only)
build_linux() {
    echo_info "Building for Linux (engine test)..."
    
    cd "${PROJECT_ROOT}"
    rm -rf build-linux
    mkdir -p build-linux
    cd build-linux
    
    cmake .. -G "${CMAKE_GENERATOR}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr
    
    cmake --build . --parallel $(nproc 2>/dev/null || echo 4)
    
    echo_info "Linux build complete"
}

# Build for iOS (requires macOS)
build_ios() {
    echo_info "Building for iOS..."
    
    if [[ "$(uname)" != "Darwin" ]]; then
        echo_error "iOS builds require macOS. Skipping."
        return
    fi
    
    cd "${PROJECT_ROOT}"
    rm -rf build-ios
    mkdir -p build-ios
    cd build-ios
    
    cmake .. -G Xcode \
        -DCMAKE_SYSTEM_NAME=iOS \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0 \
        -DCMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY="iPhone Developer" \
        -DIOS=ON
    
    cmake --build . --config Release
    
    echo_info "iOS build complete"
}

# Build for Android
build_android() {
    echo_info "Building for Android..."
    
    if [[ -z "${ANDROID_NDK_HOME}" && -z "${ANDROID_NDK}" ]]; then
        echo_error "ANDROID_NDK_HOME or ANDROID_NDK not set. Please set Android NDK path."
        exit 1
    fi
    
    ANDROID_NDK_PATH="${ANDROID_NDK:-${ANDROID_NDK_HOME}}"
    
    cd "${PROJECT_ROOT}"
    rm -rf build-android
    mkdir -p build-android
    cd build-android
    
    cmake .. -G "${CMAKE_GENERATOR}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake" \
        -DANDROID=ON \
        -DANDROID_ABI=arm64-v8a \
        -DANDROID_PLATFORM=android-26
    
    cmake --build . --parallel $(nproc 2>/dev/null || echo 4)
    
    echo_info "Android build complete"
}

# Main
main() {
    local target="${1:-all}"
    
    echo_info "Freeciv Mobile Build System"
    echo_info "Project root: ${PROJECT_ROOT}"
    
    case "${target}" in
        linux)
            check_prerequisites
            build_linux
            ;;
        ios)
            check_prerequisites
            build_ios
            ;;
        android)
            check_prerequisites
            build_android
            ;;
        all)
            check_prerequisites
            build_linux
            build_ios
            build_android
            ;;
        *)
            echo "Usage: $0 [linux|ios|android|all]"
            exit 1
            ;;
    esac
    
    echo_info "Build successful!"
}

main "$@"