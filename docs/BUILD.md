# Build Guide for Freeciv Mobile

This guide covers building Freeciv Mobile for iOS and Android platforms.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Repository Setup](#repository-setup)
3. [Building the Engine](#building-the-engine)
4. [Building for iOS](#building-for-ios)
5. [Building for Android](#building-for-android)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Common Requirements

- **CMake** 3.21 or higher
- **Ninja** (recommended) or GNU Make
- **Git**
- **C++17 compatible compiler** (GCC 7+, Clang 5+, MSVC 2017+)
- **Python** 3.x (for code generation scripts)

### Platform-Specific Requirements

#### iOS (macOS only)

- macOS 11.0 (Big Sur) or later
- Xcode 13.0 or later
- iOS SDK 15.0+
- Command Line Tools (`xcode-select --install`)

#### Android (Linux/macOS/Windows)

- **Android NDK** r21 or later
- **Android SDK** with API level 26 (Android 8.0)
- **Java Development Kit (JDK)** 11 or 17
- **Gradle** (usually automatically installed by Android Studio)

Set environment variables:

```bash
export ANDROID_NDK_HOME=/path/to/android-ndk
# or
export ANDROID_NDK=/path/to/android-ndk
```

---

## Repository Setup

### 1. Clone and Configure Upstream

```bash
# Clone your fork
git clone https://github.com/your-org/freeciv-mobile-fc21.git
cd freeciv-mobile-fc21

# Add Freeciv21 as upstream remote
git remote add upstream https://github.com/longturn/freeciv21.git

# Fetch upstream sources
git fetch upstream
```

The repository structure includes:

- `engine/` - Freeciv21 game engine (forked)
- `ios/` - iOS SwiftUI client
- `android/` - Android Jetpack Compose client
- `mobile_ffi/` - C/C++ FFI bridge for mobile clients
- `scripts/` - Build and utility scripts
- `data/` - Game assets and rulesets

---

## Building the Engine

You can test that the engine builds correctly on your development machine before targeting mobile platforms.

### Linux Build (Engine Only)

```bash
./scripts/build.sh linux
```

This builds the core engine libraries (`freeciv21-common`, `freeciv21-server`, etc.) for your local system. Useful for testing that dependencies are correctly installed.

---

## Building for iOS

### Requirements Check

```bash
# Verify Xcode command line tools
xcode-select -p

# Check iOS SDK
xcodebuild -showsdks | grep iOS
```

### Build Steps

```bash
# Build for iOS (from macOS)
./scripts/build.sh ios
```

**What gets built:**

- Static libraries: `libfreeciv21-common.a`, `libfreeciv21-server.a`, `libfreeciv-mobile-ffi.a`
- iOS app bundle: `build-ios/FreecivMobile.app`

### Opening in Xcode

```bash
open build-ios/FreecivMobile.xcodeproj
```

From Xcode, you can:
- Run on iOS simulator
- Deploy to physical device (requires signing)
- Archive for App Store submission

### Code Signing

For deployment to devices, configure code signing in Xcode:

1. Select `FreecivMobile` target
2. Go to **Signing & Capabilities**
3. Select your development team
4. Ensure "Automatically manage signing" is enabled

---

## Building for Android

### Environment Setup

```bash
# Install Android Studio (recommended)
# It provides SDK Manager, NDK, and Gradle

# Or manually:
# 1. Install Android SDK
# 2. Install Android NDK (r21+)
# 3. Install OpenJDK 11/17

# Set environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/25.1.8937393
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
```

### Build Steps

```bash
# Build for Android
./scripts/build.sh android
```

**What gets built:**

- Native libraries: `libfreeciv21-common.a`, `libfreeciv21-server.a`, `libfreeciv-mobile-ffi.a`, `libfreeciv-mobile.so`
- The native `.so` files are placed in `build-android/` and will be packaged by Gradle

### Building Full APK with Gradle

The native libraries built by CMake need to be packaged into an APK:

```bash
# Build the full Android app (requires Android Studio/gradle)
cd android
./gradlew assembleDebug
```

The APK will be at: `android/app/build/outputs/apk/debug/app-debug.apk`

### Installing on Device

```bash
# Install APK to connected device/emulator
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

---

## CMake Configuration Details

### Root CMakeLists.txt

The root `CMakeLists.txt` orchestrates the build:

```cmake
add_subdirectory(engine)        # Freeciv21 engine
add_subdirectory(mobile_ffi)    # Mobile FFI bridge
if(IOS)
    add_subdirectory(ios)
elseif(ANDROID)
    add_subdirectory(android)
endif()
add_subdirectory(data)          # Game assets
```

### FFI Library (`mobile_ffi/`)

Provides C-compatible API that both iOS (Swift) and Android (Kotlin/JNI) use:

- `ffi_types.h` - C structs (game settings, actions, state)
- `ffi_bridge.cpp` - Implementation of FFI functions
- `ffi_game.cpp` - Game lifecycle (create/destroy)
- `ffi_action.cpp` - Action execution
- `ffi_state.cpp` - State extraction

### Mobile Clients

- **iOS** (`ios/`): SwiftUI app with `EngineBridge.swift` wrapping FFI
- **Android** (`android/`): Jetpack Compose app with JNI bridge `jni_bridge.cpp`

---

## Troubleshooting

### Common Issues

#### "Cannot find engine libraries"

Make sure the `engine/` subdirectory is present and properly initialized. The engine is included as a submodule.

```bash
git submodule update --init --recursive
```

#### "packets_gen.h not found"

The Freeciv21 engine uses generated headers. They should be in `engine/common/`. If missing:

```bash
cd engine
# Some files may need generation - check Freeciv21 build docs
```

#### iOS Build Fails: "Framework not found"

Ensure Xcode command line tools are installed:

```bash
xcode-select --install
```

#### Android Build Fails: "NDK not found"

Verify `ANDROID_NDK_HOME` is set correctly:

```bash
echo $ANDROID_NDK_HOME
ls $ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake
```

#### CMake Cannot Find Dependencies

Install dependencies:

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y \
    cmake \
    ninja-build \
    g++ \
    python3 \
    gettext \
    liblua5.3-dev \
    libsqlite3-dev \
    libsdl2-mixer-dev
```

**macOS:**
```bash
brew install cmake ninja python3 gettext lua sqlite sdl2_mixer
```

---

## Build Options

### CMake Cache Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CMAKE_BUILD_TYPE` | Release | Build configuration (Debug, Release) |
| `CMAKE_INSTALL_PREFIX` | `/usr` | Installation prefix for Linux builds |
| `ANDROID_ABI` | `arm64-v8a` | Android ABI (for NDK builds) |
| `ANDROID_PLATFORM` | `android-26` | Minimum Android API level |

### Custom Build

```bash
# Example: Debug build for iOS
cmake -B build-ios -G Xcode \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0 \
    -DIOS=ON

cmake --build build-ios --config Debug
```

---

## Testing Build

After building, verify the libraries exist:

```bash
# Linux
ls build-linux/*.a

# iOS  
ls build-ios/*.a

# Android
ls build-android/*.a
ls build-android/*.so
```

---

## Next Steps

- [Phase 1: Mobile UI Foundation](docs/ROADMAP.md#phase-1-mobile-ui-foundation-month-1-4)
- [FFI Integration](docs/ARCHITECTURE.md#ffi-layer)
- [Filament Rendering Setup](docs/DECISIONS.md#adr-003-rendering-strategy-filament-or-native)

---

## Getting Help

- Check [Freeciv21 documentation](https://github.com/longturn/freeciv21)
- Review [Architecture docs](docs/ARCHITECTURE.md)
- Open an issue on GitHub