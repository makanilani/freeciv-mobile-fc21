# Architecture Overview

## High-Level Design

```
┌─────────────────────────────────────────────────────────────┐
│                      MOBILE APPS                             │
│  ┌─────────────────┐           ┌─────────────────┐          │
│  │   Android       │           │      iOS        │          │
│  │   (Kotlin)     │           │     (Swift)     │          │
│   └────────┬────────┘           └────────┬────────┘          │
└───────────┼──────────────────────────────┼──────────────────┘
            │                              │
┌───────────┴──────────────────────────────┴──────────────────┐
│                    MOBILE UI LAYER                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Map View   │  │   Controls  │  │   Dialogs    │     │
│  │  (Filament/  │  │   (Touch)   │  │  (Native     │     │
│  │   Native)    │  │             │  │   UI)        │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────┬───────────────────────────────────┘
                          │ FFI (Swift C++ / JNI)
┌─────────────────────────┴───────────────────────────────────┐
│                  FREECIV21 ENGINE (C++17)                   │
│              (Forked from github.com/longturn/freeciv21)    │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Server      │  │   AI Core    │  │  Ruleset     │     │
│  │  (game loop) │  │   (tactics) │  │   Loader     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Common      │  │  Pathfinding │  │   Network    │     │
│  │  (game logic)│  │   (aicore)   │  │   Protocol   │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────────┐
│                      DATA LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   SQLite    │  │   Ruleset    │  │    Assets    │     │
│  │  (saves)    │  │   (JSON)     │  │   (tilesets) │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

---

## Source: Freeciv21 Fork

This project forks from [Freeciv21](https://github.com/longturn/freeciv21), inheriting:

| Component | Directory | Status |
|-----------|-----------|--------|
| Game Logic | `common/` | ✅ Kept as-is |
| Game Server | `server/` | ✅ Kept, extended for mobile |
| AI System | `ai/` | ✅ Kept as-is |
| Utilities | `utility/` | ✅ Kept as-is |
| Rulesets | `data/` | ✅ Kept, extended |
| Build System | `CMakeLists.txt` | ✅ Kept, extended |
| Qt6 Client | `client/` | ❌ Removed |
| Tools | `tools/` | ✅ Kept |

See [FREECIV21_FORK.md](FREECIV21_FORK.md) for detailed fork strategy.

---

## Module Breakdown

### 1. Freeciv21 Engine Core (`common/`, `server/`, `ai/`)

Inherited from Freeciv21, minimal changes.

| Module | Responsibility | Key APIs |
|--------|---------------|----------|
| `game` | Turn management, victory | `advance_turn()`, `check_victory()` |
| `map` | Terrain, coordinates, fog of war | `map_get_tile()`, `fog_of_war()` |
| `unit` | Unit creation, movement, combat | `unit_move()`, `unit_do_action()` |
| `city` | City management, production | `city_build()`, `city_growth()` |
| `player` | Diplomacy, statistics | `player_diplomacy()`, `player_score()` |
| `tech` | Technology tree, research | `tech_research()`, `tech_available()` |
| `combat` | Battle resolution | `calculate_combat()` |
| `trade` | Trade routes, commerce | `establish_trade()` |
| `events` | Game events, notifications | `emit_event()` |

### 2. AI Core (`ai/`)

Inherited from Freeciv21, complete implementation.

| Module | Responsibility |
|--------|---------------|
| `adv_city` | City advisor |
| `adv_military` | Military advisor |
| `adv_diplomacy` | Diplomacy AI |
| `adv_economy` | Economy advisor |
| `aiunit` | Unit decision making |
| `aihand` | Strategic planning |
| `aitech` | Technology prioritization |

### 3. Pathfinding (`common/aicore/`)

Inherited from Freeciv21.

| Module | Purpose |
|--------|---------|
| `pathfinding` | A* implementation with turn cost |
| `citymap` | City management optimization |
| `pf_tools` | Pathfinding utilities |

### 4. Ruleset System (`server/`, `data/`)

Inherited from Freeciv21, data-driven game rules.

```
data/
├── civ2civ3/           # Modern ruleset (default)
│   ├── units.ruleset
│   ├── buildings.ruleset
│   ├── techs.ruleset
│   └── ...
├── classic/            # Classic Freeciv rules
├── nation/             # 500+ nation definitions
├── amplio2/            # Tileset graphics
└── sounds/             # Sound effects
```

### 5. Network Protocol (`common/network/`)

Extended from Freeciv21.

| Component | Technology | Purpose |
|-----------|------------|---------|
| Protocol | Protocol Buffers | Efficient serialization |
| Transport | WebSocket | Mobile-friendly connection |
| Sync | Event sourcing + CRDT | Offline-first multiplayer |

### 6. New Mobile UI Layer (`ios/`, `android/`)

**New code**, replacing Qt6 client.

#### iOS Client (`ios/`)

```
ios/
├── FreecivMobile/
│   ├── App/
│   │   └── FreecivMobileApp.swift      # Entry point
│   │
│   ├── Features/                        # Feature modules
│   │   ├── Menu/
│   │   │   ├── MenuView.swift
│   │   │   └── MenuViewModel.swift
│   │   │
│   │   ├── Game/
│   │   │   ├── GameView.swift          # Main game screen
│   │   │   ├── GameViewModel.swift
│   │   │   ├── MapRenderer.swift       # Filament/Metal rendering
│   │   │   ├── UnitPanelView.swift
│   │   │   └── ActionSheetView.swift
│   │   │
│   │   ├── City/
│   │   │   ├── CityView.swift
│   │   │   └── CityViewModel.swift
│   │   │
│   │   └── Settings/
│   │       └── SettingsView.swift
│   │
│   ├── Engine/                          # C++ FFI
│   │   ├── EngineBridge.swift          # Swift ↔ C++
│   │   ├── GameState.swift             # State holder
│   │   └── EngineActions.swift         # Action dispatch
│   │
│   ├── Data/                            # Data layer
│   │   ├── Repository/
│   │   └── Models/
│   │
│   └── Resources/
│       ├── Assets.xcassets/
│       └── tilesets/                    # Tile sprites
```

#### Android Client (`android/`)

```
android/
├── app/
│   └── src/main/
│       ├── java/com/freeciv/mobile/
│       │   │
│       │   ├── FreecivApp.kt           # Application class
│       │   ├── MainActivity.kt         # Entry point
│       │   │
│       │   ├── ui/                      # Compose UI
│       │   │   ├── theme/
│       │   │   │   ├── Theme.kt
│       │   │   │   └── Color.kt
│       │   │   │
│       │   │   ├── screens/
│       │   │   │   ├── menu/
│       │   │   │   │   └── MenuScreen.kt
│       │   │   │   │
│       │   │   │   ├── game/
│       │   │   │   │   ├── GameScreen.kt
│       │   │   │   │   ├── GameViewModel.kt
│       │   │   │   │   ├── MapRenderer.kt   # Filament/Vulkan
│       │   │   │   │   └── UnitPanel.kt
│       │   │   │   │
│       │   │   │   └── city/
│       │   │   │       └── CityScreen.kt
│       │   │   │
│       │   │   └── components/           # Reusable
│       │   │       ├── ActionSheet.kt
│       │   │       └── BottomSheet.kt
│       │   │
│       │   ├── engine/                   # C++ JNI
│       │   │   ├── EngineBridge.kt      # Kotlin ↔ C++
│       │   │   ├── GameState.kt
│       │   │   └── Actions.kt
│       │   │
│       │   └── data/                     # Data layer
│       │       ├── repository/
│       │       └── model/
│       │
│       ├── res/
│       │   └── drawable/
│       │       └── tiles/               # Tile sprites
│       │
│       └── jniLibs/                     # Native libraries
│           ├── arm64-v8a/
│           └── x86_64/
```

---

## Data Flow

### Single Player (Local)

```
User Input → Mobile UI → FFI → Engine (C++) → State Update → Render
     ↑                                           ↓
     └───────────── UI Update ←───────────────────┘
```

### Multiplayer (Async) - Offline-First

```
┌─────────────────────────────────────────────────────────────┐
│                      CLIENT (Offline-First)                  │
│                                                              │
│  User Action → Local State Update → UI Update                │
│       ↓                                                      │
│  Add to Sync Queue                                           │
│       ↓                                                      │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              SYNC QUEUE (Persistent)                  │    │
│  │  [action_1, action_2, action_3, ...]                 │    │
│  └─────────────────────────────────────────────────────┘    │
│       ↓ (when online)                                        │
│  Send to Server → Receive Confirmation → Remove from Queue   │
└─────────────────────────────────────────────────────────────┘

                          ↕ WebSocket

┌─────────────────────────────────────────────────────────────┐
│                   SERVER (Freeciv21 Extended)               │
│                                                              │
│  Receive Actions → Validate → Apply → Broadcast to Others   │
│                                                              │
│  Conflict Resolution: Server-authoritative with timestamps   │
└─────────────────────────────────────────────────────────────┘
```

### Conflict Resolution (CRDT-Based)

```
┌─────────────────────────────────────────────────────────────┐
│                    CONFLICT RESOLUTION                       │
│                                                              │
│  1. Server is authoritative for game state                   │
│  2. Actions are idempotent with unique IDs                   │
│  3. Timestamp-based ordering for concurrent actions          │
│  4. Server resolves conflicts, client reconciles             │
│                                                              │
│  Example:                                                    │
│    Client A: Move unit to (5,5) @ T=100                      │
│    Client B: Move same unit to (6,6) @ T=101                 │
│    Server: Accepts later action (B), rejects A               │
│    Client A: Receives rejection, updates local state         │
└─────────────────────────────────────────────────────────────┘
```

---

## State Management

### Game State Structure (Inherited from Freeciv21)

```cpp
// From common/game.h
struct Game {
    int turn;                       // Current turn number
    int year;                       // Game year (e.g., -4000 BCE)
    
    struct players players;         // All players
    struct cities cities;           // All cities
    struct units units;             // All units
    struct map map;                 // World map
    
    struct ruleset_settings ruleset;// Active ruleset
    struct server_settings server;  // Server configuration
};

// From common/tile.h
struct Tile {
    struct coordinate pos;          // (x, y) position
    Terrain terrain;                // Terrain type
    Resource resource;              // Special resource
    Player *owner;                  // Owning player
    City *worked;                   // City working this tile
    UnitList units;                 // Units on tile
    int visibility[MAX_PLAYERS];    // Visibility per player
};
```

### Save Format (Inherited from Freeciv21)

- **Format:** SQLite database (`.fcsave`)
- **Schema:** Normalized game state + action log
- **Compatibility:** Versioned, forward-compatible

---

## Determinism Guarantees

For multiplayer sync and replay functionality, the engine must be deterministic:

| System | Implementation |
|--------|----------------|
| **Combat** | Fixed-point arithmetic (16.16 format) |
| **RNG** | Seeded XorShift algorithm |
| **Map Gen** | Identical with same seed |
| **AI** | Deterministic with same game state |
| **Pathfinding** | Consistent tie-breaking heuristics |

**Cross-Platform Testing:**
- Unit tests verify combat results identical on ARM and x86
- Integration tests verify map generation with same seed
- CI runs determinism checks on every build

---

## Platform-Specific Considerations

### iOS

| Aspect | Technology |
|--------|------------|
| **Language** | Swift 5.9+ |
| **UI Framework** | SwiftUI with UIKit interop |
| **Rendering** | Metal via Filament OR native Metal |
| **Architecture** | MVVM with Combine |
| **Storage** | Core Data / SQLite |
| **Game Center** | Multiplayer discovery (optional) |

### Android

| Aspect | Technology |
|--------|------------|
| **Language** | Kotlin 1.9+ |
| **UI Framework** | Jetpack Compose |
| **Rendering** | Vulkan via Filament OR native Vulkan |
| **Architecture** | MVVM with Kotlin Flows |
| **Storage** | Room (SQLite) |
| **Play Games** | Multiplayer discovery (optional) |

### Shared Considerations

- **Screen sizes:** Support phones and tablets
- **Orientation:** Portrait primary, landscape supported
- **Performance target:** 60 FPS on mid-range devices
- **Memory limit:** ~512MB for game state + assets

---

## Build System

### Inherited from Freeciv21

```cmake
# CMakeLists.txt (from Freeciv21)
cmake_minimum_required(VERSION 3.21...4.3)
project(freeciv21 VERSION X.Y.Z LANGUAGES C CXX)

# Core components (kept)
add_subdirectory(utility)
add_subdirectory(common)
add_subdirectory(server)
add_subdirectory(ai)
add_subdirectory(data)

# Qt6 client (removed)
# add_subdirectory(client)  # REMOVED

# Mobile clients (new)
if(IOS)
    add_subdirectory(ios)
elseif(ANDROID)
    add_subdirectory(android)
endif()
```

### iOS Build (New)

```cmake
# ios/CMakeLists.txt
if(IOS)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "15.0")
    
    # Filament library
    find_package(Filament REQUIRED)
    
    # Freeciv21 engine as static library
    target_link_libraries(freeciv-mobile-ios
        freeciv21-common
        freeciv21-server
        Filament::filament
    )
endif()
```

### Android Build (New)

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
            path = file("../../CMakeLists.txt")
        }
    }
}
```

---

## FFI Layer

### Swift C++ Bridge (iOS)

```swift
// ios/FreecivMobile/Engine/EngineBridge.swift
import Foundation

@_silgen_name("freeciv_create_game")
func freecivCreateGame(_ settings: UnsafePointer<GameSettings>) -> OpaquePointer

@_silgen_name("freeciv_do_action")
func freecivDoAction(_ game: OpaquePointer, _ action: UnsafePointer<Action>) -> Int32

class EngineBridge {
    private var game: OpaquePointer?
    
    func createGame(settings: GameSettings) {
        var cSettings = settings.toC()
        game = freecivCreateGame(&cSettings)
    }
    
    func doAction(_ action: Action) -> ActionResult {
        var cAction = action.toC()
        let result = freecivDoAction(game!, &cAction)
        return ActionResult(from: result)
    }
}
```

### Kotlin JNI Bridge (Android)

```kotlin
// android/app/src/main/java/com/freeciv/mobile/engine/EngineBridge.kt
package com.freeciv.mobile.engine

class EngineBridge {
    init {
        System.loadLibrary("freeciv21")
    }
    
    external fun createGame(settings: GameSettings): Long
    external fun doAction(gamePtr: Long, action: Action): Int
    external fun getState(gamePtr: Long): GameState
    external fun destroyGame(gamePtr: Long)
}
```

---

## Security Considerations

- **Save files:** Signed with HMAC to prevent tampering
- **Multiplayer:** TLS for all connections
- **Anti-cheat:** Server authoritative for competitive modes
- **Permissions:** Minimal (network, notifications only)

---

## Performance Targets

| Metric | Target |
|--------|--------|
| Frame rate | 60 FPS sustained |
| Turn calculation | < 100ms for 500 cities |
| Map render | < 16ms per frame |
| Load time | < 5s cold start |
| Memory | < 300MB active play |
| Save size | < 10MB typical |

---

## Extensibility Points

1. **Rulesets:** Drop-in ruleset files (inherited from Freeciv21)
2. **Tilesets:** Custom tileset graphics (inherited)
3. **AI:** Pluggable AI interface (inherited)
4. **Mods:** Lua scripting for scenarios (inherited)
5. **Themes:** Mobile UI theming (new)
