# Code Organization

## Directory Structure

```
freeciv-mobile/
├── docs/                    # This documentation
├── design/                  # UI/UX designs, wireframes
├── planning/                # Task tracking, milestones
├── notes/                   # Meeting notes, research
│
├── engine/                  # Cross-platform game engine (C++)
├── android/                 # Android application (Kotlin)
├── ios/                     # iOS application (Swift)
└── shared/                  # Shared resources (images, fonts)
```

---

## Engine (`engine/`)

Core game logic, extracted and refactored from Freeciv.

```
engine/
├── CMakeLists.txt          # Build configuration
├── include/                 # Public headers
│   ├── freeciv/
│   │   ├── engine.h        # Main engine API
│   │   ├── game_state.h   # Game state access
│   │   ├── actions.h      # Action system
│   │   ├── map.h          # Map/terrain API
│   │   ├── unit.h         # Unit API
│   │   ├── city.h         # City API
│   │   ├── player.h       # Player API
│   │   ├── tech.h         # Tech tree API
│   │   └── ai.h           # AI interface
│   └── freeciv/version.h   # Version info
│
├── src/                    # Implementation
│   ├── CMakeLists.txt
│   │
│   ├── core/               # Core game logic
│   │   ├── game_state.cpp
│   │   ├── turn_processor.cpp
│   │   ├── victory.cpp
│   │   └── events.cpp
│   │
│   ├── map/                # Map and terrain
│   │   ├── map.cpp
│   │   ├── terrain.cpp
│   │   ├── visibility.cpp
│   │   └── generator.cpp   # Map generation
│   │
│   ├── units/              # Unit system
│   │   ├── unit.cpp
│   │   ├── movement.cpp
│   │   ├── combat.cpp
│   │   └── unit_tools.cpp # Unit actions
│   │
│   ├── city/               # City system
│   │   ├── city.cpp
│   │   ├── growth.cpp
│   │   ├── production.cpp
│   │   ├── citizen.cpp
│   │   └── city_tools.cpp
│   │
│   ├── player/             # Player management
│   │   ├── player.cpp
│   │   ├── government.cpp
│   │   ├── diplomacy.cpp
│   │   └── score.cpp
│   │
│   ├── tech/               # Technology
│   │   ├── tech.cpp
│   │   ├── tech_tree.cpp
│   │   └── research.cpp
│   │
│   ├── ruleset/            # Ruleset loading
│   │   ├── ruleset.cpp
│   │   ├── loader.cpp
│   │   ├── validator.cpp
│   │   ├── effects.cpp
│   │   └── data/           # Default rulesets
│   │       ├── civ2civ3.json
│   │       └── classic.json
│   │
│   ├── ai/                 # AI implementation
│   │   ├── ai.cpp          # AI driver
│   │   ├── unit_ai.cpp     # Unit decisions
│   │   ├── city_ai.cpp     # City advisor
│   │   ├── strategy.cpp    # Long-term planning
│   │   └── diplomat_ai.cpp # Diplomacy
│   │
│   ├── aicore/             # AI algorithms
│   │   ├── pathfinding.cpp
│   │   ├── citymap.cpp
│   │   └── pf_tools.cpp
│   │
│   ├── network/             # Multiplayer (future)
│   │   ├── protocol.cpp
│   │   ├── sync.cpp
│   │   └── server.cpp
│   │
│   └── save/               # Save/load
│       ├── save.cpp
│       └── load.cpp
│
├── tests/                  # Unit tests
│   ├── test_game_state.cpp
│   ├── test_map.cpp
│   ├── test_combat.cpp
│   └── CMakeLists.txt
│
└── tools/                  # Build tools
    ├── gen_ruleset/        # Ruleset generator
    └── benchmark/          # Performance benchmarks
```

---

## Android (`android/`)

Native Android application using Kotlin and Jetpack Compose.

```
android/
├── app/
│   ├── build.gradle.kts
│   │
│   ├── src/
│   │   └── main/
│   │       ├── AndroidManifest.xml
│   │       │
│   │       ├── java/com/freeciv/mobile/
│   │       │   │
│   │       │   ├── FreecivApp.kt     # Application class
│   │       │   │
│   │       │   ├── MainActivity.kt   # Entry point
│   │       │   │
│   │       │   ├── ui/              # Compose UI
│   │       │   │   ├── theme/
│   │       │   │   │   ├── Theme.kt
│   │       │   │   │   ├── Color.kt
│   │       │   │   │   └── Typography.kt
│   │       │   │   │
│   │       │   │   ├── navigation/
│   │       │   │   │   └── NavGraph.kt
│   │       │   │   │
│   │       │   │   ├── screens/
│   │       │   │   │   ├── menu/
│   │       │   │   │   │   └── MenuScreen.kt
│   │       │   │   │   ├── game/
│   │       │   │   │   │   ├── GameScreen.kt
│   │       │   │   │   │   └── GameViewModel.kt
│   │       │   │   │   ├── city/
│   │       │   │   │   │   └── CityScreen.kt
│   │       │   │   │   └── settings/
│   │       │   │   │       └── SettingsScreen.kt
│   │       │   │   │   │
│   │       │   │   │   └── components/
│   │       │   │   │       ├── MapView.kt
│   │       │   │   │       ├── UnitPanel.kt
│   │       │   │   │       └── ActionSheet.kt
│   │       │   │   │
│   │       │   │   └── components/      # Reusable
│   │       │   │       ├── Button.kt
│   │       │   │       ├── Card.kt
│   │       │   │       └── BottomSheet.kt
│   │       │   │
│   │       │   ├── engine/             # Engine bindings
│   │       │   │   ├── EngineBridge.kt # JNI wrapper
│   │       │   │   ├── GameState.kt    # State holder
│   │       │   │   └── Actions.kt      # Action dispatch
│   │       │   │
│   │       │   ├── data/               # Data layer
│   │       │   │   ├── repository/
│   │       │   │   │   └── GameRepository.kt
│   │       │   │   ├── local/
│   │       │   │   │   └── GameDatabase.kt
│   │       │   │   └── model/
│   │       │   │       ├── GameSave.kt
│   │       │   │       └── Player.kt
│   │       │   │
│   │       │   ├── di/                  # Dependency injection
│   │       │   │   └── AppModule.kt
│   │       │   │
│   │       │   └── util/               # Utilities
│   │       │       ├── Logger.kt
│   │       │       └── Extensions.kt
│   │       │
│   │       ├── res/
│   │       │   ├── values/
│   │       │   │   ├── strings.xml
│   │       │   │   └── themes.xml
│   │       │   ├── drawable/
│   │       │   └── raw/
│   │       │       └── tiles/          # Tile sprites
│   │       │
│   │       └── jniLibs/               # Engine native lib
│   │           ├── arm64-v8a/
│   │           ├── armeabi-v7a/
│   │           ├── x86/
│   │           └── x86_64/
│   │
│   └── build.gradle.kts
│
├── gradle/
├── build.gradle.kts
├── settings.gradle.kts
└── gradle.properties
```

---

## iOS (`ios/`)

Native iOS application using Swift and SwiftUI.

```
ios/
├── project.yml              # XcodeGen configuration
├── FreecivMobile/
│   │
│   ├── App/
│   │   ├── FreecivMobileApp.swift
│   │   └── AppDelegate.swift
│   │
│   ├── Core/               # Shared with engine
│   │   └── EngineBridge.swift
│   │
│   ├── Features/           # Feature modules
│   │   ├── Menu/
│   │   │   ├── MenuView.swift
│   │   │   └── MenuViewModel.swift
│   │   │
│   │   ├── Game/
│   │   │   ├── GameView.swift
│   │   │   ├── GameViewModel.swift
│   │   │   ├── MapRenderer.swift      # Filament/Metal view
│   │   │   ├── MapViewController.swift
│   │   │   ├── UnitPanelView.swift
│   │   │   └── ActionSheetView.swift
│   │   │
│   │   ├── City/
│   │   │   ├── CityView.swift
│   │   │   └── CityViewModel.swift
│   │   │
│   │   └── Settings/
│   │       ├── SettingsView.swift
│   │       └── SettingsViewModel.swift
│   │
│   ├── Shared/              # Cross-platform components
│   │   ├── Components/
│   │   │   ├── PrimaryButton.swift
│   │   │   ├── GameCard.swift
│   │   │   └── BottomSheet.swift
│   │   │
│   │   ├── Design/
│   │   │   ├── Colors.swift
│   │   │   ├── Typography.swift
│   │   │   └── Spacing.swift
│   │   │
│   │   └── Extensions/
│   │       ├── View+Extensions.swift
│   │       └── Color+Extensions.swift
│   │
│   ├── Engine/              # Engine FFI
│   │   ├── EngineBridge.swift
│   │   ├── GameState.swift
│   │   └── EngineActions.swift
│   │
│   ├── Data/                # Data layer
│   │   ├── Repository/
│   │   │   └── GameRepository.swift
│   │   │
│   │   ├── Local/
│   │   │   ├── GameDatabase.swift
│   │   │   └── UserDefaults+Game.swift
│   │   │
│   │   └── Models/
│   │       ├── GameSave.swift
│   │       └── Player.swift
│   │
│   ├── Resources/
│   │   ├── Assets.xcassets/
│   │   ├── tiles/           # Tile sprites
│   │   ├── units/           # Unit sprites
│   │   └── sounds/          # Audio
│   │
│   └── Info.plist
│
├── FreecivMobileTests/
├── FreecivMobileUITests/
└── Podfile                  # CocoaPods (if needed)
```

---

## Shared Resources (`shared/`)

Resources used by both platforms.

```
shared/
├── tiles/                  # Tile sprites (PNG, 64x64)
│   ├── terrain/
│   │   ├── plains.png
│   │   ├── desert.png
│   │   ├── ocean.png
│   │   ├── forest.png
│   │   ├── mountains.png
│   │   └── tundra.png
│   ├── units/              # Unit icons
│   └── buildings/          # Building icons
│
├── fonts/                  # Custom fonts (if any)
│
├── rulesets/               # Ruleset data
│   ├── civ2civ3/
│   │   ├── ruleset.json
│   │   ├── units.json
│   │   ├── buildings.json
│   │   └── techs.json
│   └── classic/
│
└── sounds/                 # Sound effects (OGG)
    ├── ui/
    ├── combat/
    └── events/
```

---

## Build System

### Engine Build (CMake)

```cmake
# engine/CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(freeciv-engine VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Source files
add_library(freeciv-engine STATIC
    src/core/game_state.cpp
    src/map/map.cpp
    src/units/unit.cpp
    # ... more sources
)

target_include_directories(freeciv-engine PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

# Platform-specific
if(ANDROID)
    # Android NDK setup
elseif(APPLE)
    # iOS/macOS setup
endif()
```

### iOS Build (XcodeGen)

```yaml
# ios/project.yml
name: FreecivMobile
options:
  bundleIdPrefix: com.freeciv
  deploymentTarget:
    iOS: "15.0"

targets:
  FreecivMobile:
    type: application
    platform: iOS
    sources:
      - FreecivMobile
    settings:
      INFOPLIST_FILE: FreecivMobile/Info.plist
      PRODUCT_BUNDLE_IDENTIFIER: com.freeciv.mobile
    dependencies:
      - target: freeciv-engine
        embed: true
```

### Android Build (Gradle)

```kotlin
// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    ndkVersion = "25.1.8937393"
    
    externalNativeBuild {
        cmake {
            path = file("../../engine/CMakeLists.txt")
        }
    }
    
    defaultConfig {
        ndk {
            abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86_64")
        }
    }
}
```

---

## Module Dependencies

```
┌─────────────────────────────────────────────────────────┐
│                      Mobile Apps                         │
│                                                         │
│   ┌─────────────┐              ┌─────────────┐         │
│   │    iOS       │              │   Android   │         │
│   │  (SwiftUI)   │              │  (Compose)  │         │
│   └──────┬──────┘              └──────┬──────┘         │
│          │                            │                │
│          └──────────┬──────────────────┘                │
│                     ▼                                   │
│   ┌─────────────────────────────────────────┐          │
│   │           Engine Bridge (FFI)            │          │
│   │    Swift ←→ C ←→ Kotlin                  │          │
│   └─────────────────────────────────────────┘          │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│                     ENGINE CORE (C++)                    │
│                                                          │
│   ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐          │
│   │  Core  │ │  Map   │ │ Units  │ │ Cities │          │
│   └────────┘ └────────┘ └────────┘ └────────┘          │
│   ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐          │
│   │ Player │ │  Tech  │ │  AI    │ │ Ruleset│          │
│   └────────┘ └────────┘ └────────┘ └────────┘          │
│   ┌────────┐ ┌────────┐ ┌────────┐                    │
│   │ AICore │ │ Network│ │  Save  │                    │
│   └────────┘ └────────┘ └────────┘                    │
└──────────────────────────────────────────────────────────┘
```

---

## Import Conventions

### C++ (Engine)

```cpp
#include <freeciv/engine.h>
#include <freeciv/map.h>
#include <freeciv/unit.h>

namespace freeciv {
    // Implementation
}
```

### Kotlin (Android)

```kotlin
import com.freeciv.mobile.engine.EngineBridge
import com.freeciv.mobile.ui.theme.FreecivTheme

@Composable
fun GameScreen() {
    // Implementation
}
```

### Swift (iOS)

```swift
import SwiftUI
import FreecivEngine

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        // Implementation
    }
}
```
