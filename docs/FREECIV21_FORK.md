# Freeciv21 Fork Strategy

This document describes how this project forks from and relates to [Freeciv21](https://github.com/longturn/freeciv21).

---

## Overview

Freeciv Mobile is a **fork of Freeciv21** focused on mobile platforms (iOS and Android). We inherit the game engine while replacing the desktop Qt6 client with native mobile UIs.

---

## What We Inherit from Freeciv21

### Core Components (Kept As-Is)

| Directory | Purpose | Changes |
|-----------|---------|---------|
| `common/` | Shared game logic | Minimal (mobile additions) |
| `server/` | Game server, AI, rulesets | Extend for mobile sync |
| `utility/` | Utilities, versioning | Minimal |
| `data/` | Rulesets, tilesets, assets | Add mobile-specific assets |
| `ai/` | AI implementation | Performance optimizations |
| `tools/` | Development tools | Keep |

### Specific Modules We Keep

```
From Freeciv21:
├── common/
│   ├── achievements.cpp/h      # Achievement system
│   ├── actions.cpp/h           # Game actions
│   ├── ai.cpp/h                # AI interface
│   ├── base.cpp/h              # Base game logic
│   ├── city.cpp/h              # City system
│   ├── combat.cpp/h            # Combat calculations
│   ├── diplo.cpp/h             # Diplomacy
│   ├── effects.cpp/h           # Effect system
│   ├── events.cpp/h            # Game events
│   ├── game.cpp/h              # Game state
│   ├── government.cpp/h        # Government types
│   ├── idex.cpp/h              # Index handling
│   ├── map.cpp/h               # Map system
│   ├── movement.cpp/h          # Movement rules
│   ├── nation.cpp/h            # Nation definitions
│   ├── player.cpp/h            # Player management
│   ├── research.cpp/h          # Tech tree
│   ├── requirements.cpp/h      # Requirement system
│   ├── spaceship.cpp/h         # Space race
│   ├── tech.cpp/h              # Technology system
│   ├── terrain.cpp/h           # Terrain types
│   ├── tile.cpp/h              # Tile system
│   ├── unit.cpp/h              # Unit system
│   ├── unittype.cpp/h          # Unit definitions
│   └── victory.cpp/h           # Victory conditions
│
├── server/
│   ├── actiontools.cpp/h       # Action implementation
│   ├── aiiface.cpp/h           # AI interface
│   ├── citytools.cpp/h         # City operations
│   ├── cityturn.cpp/h          # City turn processing
│   ├── civserver.cpp/h         # Server main
│   ├── console.cpp/h           # Server console
│   ├── diplomacy.cpp/h         # Diplomacy handling
│   ├── edetu.cpp/h             # Editor tools
│   ├── game_load.cpp/h         # Game loading
│   ├── generator.cpp/h         # Map generation
│   ├── hand_gen.cpp/h          # Packet handlers
│   ├── maphand.cpp/h           # Map handling
│   ├── meta.cpp/h              # Metaserver
│   ├── notify.cpp/h            # Notifications
│   ├── plrhand.cpp/h           # Player handling
│   ├── report.cpp/h            # Reports
│   ├── ruleset.cpp/h           # Ruleset loading
│   ├── savegame.cpp/h          # Save/load
│   ├── score.cpp/h             # Scoring
│   ├── sernet.cpp/h            # Network
│   ├── settings.cpp/h          # Game settings
│   ├── spacerace.cpp/h         # Space race
│   ├── srv_main.cpp/h          # Server main
│   ├── stdinhand.cpp/h         # Console commands
│   ├── techtools.cpp/h         # Tech operations
│   ├── unittools.cpp/h         # Unit operations
│   └── voting.cpp/h            # Voting system
│
├── ai/
│   ├── adv_attitude.cpp/h      # AI attitude
│   ├── adv_city.cpp/h          # City advisor
│   ├── adv_citizen.cpp/h       # Citizen management
│   ├── adv_diplomacy.cpp/h     # Diplomacy AI
│   ├── adv_domestic.cpp/h      # Domestic advisor
│   ├── adv_economy.cpp/h       # Economy AI
│   ├── adv_military.cpp/h      # Military AI
│   ├── adv_newchoice.cpp/h     # Decision making
│   ├── adv_tools.cpp/h         # AI utilities
│   ├── aiair.cpp/h             # Air unit AI
│   ├── aihand.cpp/h            # AI management
│   ├── aihunt.cpp/h            # Hunting AI
│   ├── ailog.cpp/h             # AI logging
│   ├── aiparatrooper.cpp/h     # Paratrooper AI
│   ├── aiplayer.cpp/h          # Player AI
│   ├── aitech.cpp/h            # Tech AI
│   ├── aitypes.cpp/h           # AI types
│   ├── aiunit.cpp/h            # Unit AI
│   └── daieffects.cpp/h        # Effect handling
│
├── utility/                    # Utilities
│   ├── astring.cpp/h           # String utilities
│   ├── bitvector.cpp/h         # Bit operations
│   ├── bugs.cpp/h              # Bug reporting
│   ├── capability.cpp/h        # Version capabilities
│   ├── deprecations.cpp/h      # Deprecation handling
│   ├── distribute.cpp/h        # Distribution
│   ├── fc_cmdline.cpp/h        # Command line
│   ├── fc_utf8.cpp/h           # UTF-8 handling
│   ├── fcbacktrace.cpp/h       # Backtraces
│   ├── fciconv.cpp/h           # Iconv
│   ├── fcintl.cpp/h            # Internationalization
│   ├── fcthread.cpp/h          # Threading
│   ├── generate_specenum.py    # Enum generation
│   ├── input_stream.cpp/h      # Input handling
│   ├── ioz.cpp/h               # Compression
│   ├── iterator.cpp/h          # Iterator utilities
│   ├── log.cpp/h               # Logging
│   ├── md5.cpp/h               # MD5 hashing
│   ├── mem.cpp/h               # Memory utilities
│   ├── netfile.cpp/h           # Network files
│   ├── netintf.cpp/h           # Network interface
│   ├── rand.cpp/h              # Random numbers
│   ├── registry.cpp/h          # Registry
│   ├── section_file.cpp/h      # Config files
│   ├── shared.cpp/h            # Shared utilities
│   ├── support.cpp/h           # Support functions
│   ├── sys_spec.h              # System specifics
│   ├── timing.cpp/h            # Timing utilities
│   └── version.cpp/h           # Version handling
│
└── data/                       # Game data
    ├── amplio2/                # Tileset
    ├── civ2civ3/               # Ruleset
    ├── classic/                # Ruleset
    ├── default/                # Default settings
    ├── flags/                  # Nation flags
    ├── freeciv21/              # Freeciv21 specific
    ├── graphics/               # UI graphics
    ├── helpdata.txt            # Help text
    ├── misc/                   # Miscellaneous
    ├── music/                  # Music files
    ├── nation/                 # Nation definitions
    ├── overrides/              # Override rules
    ├── scenario/               # Scenarios
    ├── scripts/                # Lua scripts
    ├── sounds/                 # Sound effects
    └── themes/                 # UI themes
```

---

## What We Replace

### Removed Components

| Directory | Purpose | Replacement |
|-----------|---------|-------------|
| `client/` | Qt6 desktop client | Native mobile clients |

### Client Code We Remove

```
Removed from Freeciv21:
├── client/
│   ├── *.cpp, *.h              # Qt6 client code
│   ├── audio/                  # SDL2 audio (may keep)
│   ├── tileset/                # Tileset rendering (reimplement)
│   ├── views/                  # Map views (reimplement)
│   ├── widgets/                # Qt widgets (remove)
│   └── *.ui                    # Qt UI files (remove)
```

### Why We Remove Qt6 Client

1. **Not Touch-Optimized:** Qt6 widgets are desktop-focused
2. **App Size:** Qt framework adds 50-100MB to app size
3. **Performance:** Extra abstraction layer
4. **Native Experience:** Users expect native mobile UI

---

## What We Add

### New Components

| Directory | Purpose |
|-----------|---------|
| `ios/` | iOS native client (SwiftUI) |
| `android/` | Android native client (Compose) |
| `mobile_common/` | Shared mobile-specific code |
| `docs/` | Mobile-specific documentation |

### iOS Client Structure

```
ios/
├── FreecivMobile/
│   ├── App/
│   │   └── FreecivMobileApp.swift
│   ├── Features/
│   │   ├── Game/
│   │   │   ├── GameView.swift
│   │   │   ├── MapRenderer.swift      # Filament/Metal
│   │   │   └── GameViewModel.swift
│   │   ├── City/
│   │   │   └── CityView.swift
│   │   └── Menu/
│   │       └── MenuView.swift
│   ├── Engine/
│   │   └── EngineBridge.swift         # C++ FFI
│   └── Resources/
└── FreecivMobile.xcodeproj
```

### Android Client Structure

```
android/
├── app/
│   └── src/main/
│       ├── java/com/freeciv/mobile/
│       │   ├── ui/
│       │   │   ├── game/
│       │   │   │   ├── GameScreen.kt
│       │   │   │   └── MapRenderer.kt  # Filament/Vulkan
│       │   │   └── menu/
│       │   │       └── MenuScreen.kt
│       │   ├── engine/
│       │   │   └── EngineBridge.kt     # JNI
│       │   └── MainActivity.kt
│       └── jniLibs/                    # Native libraries
└── build.gradle.kts
```

---

## Sync Strategy with Upstream

### Tracking Freeciv21 Changes

We want to benefit from Freeciv21 improvements while maintaining mobile-specific code.

**Strategy:**

1. **Git Remote:** Add Freeciv21 as upstream remote
2. **Regular Merges:** Merge upstream changes monthly
3. **Conflict Resolution:** Prioritize mobile changes in conflicts
4. **Backporting:** Contribute mobile-agnostic fixes back upstream

### Git Configuration

```bash
# Add Freeciv21 as upstream remote
git remote add upstream https://github.com/longturn/freeciv21.git

# Fetch upstream changes
git fetch upstream

# Merge upstream master into our branch
git merge upstream/master
```

### What We Track Closely

| Component | Sync Priority | Reason |
|-----------|---------------|--------|
| `common/` | High | Game logic improvements |
| `server/` | High | Bug fixes, AI improvements |
| `ai/` | High | AI enhancements |
| `utility/` | Medium | Utility improvements |
| `data/` | Medium | Ruleset updates |
| `client/` | None | We replaced this |

### What We Contribute Back

Any improvements to shared components that benefit Freeciv21:
- Bug fixes in `common/`, `server/`, `utility/`
- Performance optimizations in AI
- New ruleset features
- Documentation improvements

---

## Branch Strategy

```
main                    # Stable mobile releases
├── develop             # Mobile development
│   ├── feature/*       # Mobile features
│   ├── bugfix/*        # Bug fixes
│   └── upstream-merge  # Merge point for Freeciv21 updates
└── release/*           # Release branches
```

### Upstream Merge Process

1. Create branch from `develop`
2. Fetch and merge `upstream/master`
3. Resolve conflicts (preserve mobile changes)
4. Run full test suite
5. Merge back to `develop`

---

## Dependency Management

### Freeciv21 Dependencies (Kept)

| Dependency | Version | Purpose |
|------------|---------|---------|
| CMake | 3.21+ | Build system |
| Qt6 | 6.6+ | ~~Removed~~ |
| Lua | 5.3/5.4 | Scripting |
| SQLite | 3.x | Saves |
| SDL2 | 2.x | Audio (may keep) |
| KArchive | 6.x | Compression |

### New Mobile Dependencies

| Dependency | Platform | Purpose |
|------------|----------|---------|
| Filament | Both | Rendering |
| Swift | iOS | Native UI |
| SwiftUI | iOS | Native UI |
| Kotlin | Android | Native UI |
| Compose | Android | Native UI |
| Coroutines | Android | Async |
| Combine | iOS | Async |

---

## Compatibility

### Save File Compatibility

- **Goal:** Freeciv Mobile saves should be readable by Freeciv21
- **Approach:** Use same SQLite schema, version extensions for mobile-specific data

### Network Protocol Compatibility

- **Goal:** Mobile clients can connect to Freeciv21 servers (for standard multiplayer)
- **Approach:** Keep core protocol, add mobile-specific extensions

### Ruleset Compatibility

- **Goal:** Freeciv21 rulesets work in mobile
- **Approach:** Use same ruleset loader, no changes to format

---

## Contributing Back to Freeciv21

We want to be good upstream citizens.

### What We Contribute

1. **Bug Fixes:** Any bugs found in shared code
2. **Performance:** Optimizations that benefit desktop too
3. **Documentation:** Improvements to shared docs
4. **Testing:** Mobile-specific edge cases found

### Contribution Process

1. Identify change that benefits upstream
2. Create clean PR without mobile-specific code
3. Submit to Freeciv21 issue tracker
4. Reference from our changelog

---

## License

GPL v3+ (inherited from Freeciv21).

All code derived from Freeciv21 remains under GPL v3+.
New mobile client code also GPL v3+ for consistency.
