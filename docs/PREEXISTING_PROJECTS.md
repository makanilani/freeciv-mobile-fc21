# Preexisting Projects Survey

## Overview

This document surveys existing Freeciv ports, forks, and related projects. Understanding these projects helps inform design decisions and identify potential collaboration opportunities.

**Important Context:** This is a test project for evaluating AI agent capabilities. The findings below are for reference only and **not a priority** for development decisions. We are building from scratch to test the full design-to-implementation workflow.

---

## Summary Table

| Project | Platform | Stars | Activity | Tech Stack | Relevance |
|---------|----------|-------|----------|------------|-----------|
| Freeciv (upstream) | Desktop/Servers | 980 | ✅ Active | C, Autotools | **High** - Source |
| Freeciv-web | Browser | 2,149 | ✅ Active | Java, JS, WebGL | **High** - Reference |
| Freeciv21 | Desktop | 260 | ✅ Active | C++17, Qt6 | **High** - Modern C++ |
| Freeciv-android | Android | 81 | ❌ Inactive | Python, Kivy | **Medium** - Mobile attempt |
| Longturn.net | Server | - | ✅ Active | Freeciv-based | **Medium** - Community |
| Freeciv-wing | Windows | 8 | ❌ Inactive | C | **Low** |
| Classic Freeciv | Various | - | ✅ Active | C | **Low** |

---

## 1. Freeciv (Upstream)

**Repository:** https://github.com/freeciv/freeciv  
**Website:** https://freeciv.org  
**Stars:** ~980  
**Activity:** Very Active (20+ years of development)  
**License:** GPL v2+

### Description

The original Freeciv project - an open-source civilization-building strategy game inspired by Civilization II. Created in 1996 and continuously developed since.

### Architecture

```
freeciv/
├── common/          # Core game logic (150K LOC)
│   ├── game.c       # Turn processing
│   ├── city.c       # City management
│   ├── unit.c       # Unit actions
│   ├── map.c        # Map/terrain
│   ├── player.c     # Player state
│   ├── tech.c       # Technology
│   └── actions.c    # Action system
├── server/          # Game server (80K LOC)
│   ├── srv_main.c   # Server loop
│   ├── savegame.c   # Save/load
│   └── ai/          # AI implementations
├── client/          # GUI clients (60K LOC)
│   ├── gui-gtk-4.0/
│   ├── gui-qt/
│   ├── gui-sdl2/
│   └── gui-stub/    # Client template
├── ai/              # AI modules (40K LOC)
│   ├── default/     # DAI (Default AI)
│   ├── classic/
│   └── tex/         # AI experimental
├── common/aicore/   # Pathfinding (shared)
│   ├── pathfinding.c
│   └── citymap.c
├── utility/         # Utilities (20K LOC)
├── tools/           # Utilities
├── data/            # Rulesets, tilesets
└── translations/    # i18n
```

### Key Technical Details

| Aspect | Details |
|--------|---------|
| **Language** | C (C99/C11) |
| **Build System** | Autotools (configure.ac), Meson (experimental) |
| **Network** | Custom TCP protocol with delta compression |
| **Save Format** | Custom text format or SQLite (optional) |
| **Modding** | Lua scripting for scenarios |
| **AI** | DAI (Default AI), unit/city/strategy advisors |

### Notable Features

- 50+ nations, 100+ units
- Multiple rulesets (civ1, civ2, civ2civ3, classic)
- Fog of war, diplomacy
- Multiple victory conditions
- Dedicated server architecture

### Lessons for Mobile

| Lesson | Application |
|--------|-------------|
| Modular client architecture | `gui-stub/` provides client template |
| Well-defined server protocol | Can reuse for multiplayer |
| Extensive AI code | Port directly to engine |
| Data-driven rulesets | Convert to JSON for mobile |

---

## 2. Freeciv-web

**Repository:** https://github.com/freeciv/freeciv-web  
**Website:** https://play.freeciv.org  
**Stars:** 2,149  
**Activity:** Active (regular updates)  
**License:** AGPL v3

### Description

A browser-based version of Freeciv that runs entirely in the web browser. Demonstrates successful porting of Freeciv to a new platform.

### Architecture

```
freeciv-web/
├── freeciv/              # Patched Freeciv server
│   └── patches/          # Modifications for web
├── freeciv-proxy/        # Python WebSocket proxy
│   └── pubsub.py          # Real-time event handling
├── freeciv-web/          # Java web application
│   ├── src/main/java/    # Backend (Tomcat 10)
│   └── webapp/           # Frontend
├── tileset-extractor/    # Converts Freeciv tiles to JS
├── freeciv-earth/        # Google Maps integration
└── docker/               # Deployment configs
```

### Technology Stack

| Layer | Technology |
|-------|------------|
| **Backend** | Java 11+, Tomcat 10, MariaDB |
| **Frontend** | JavaScript, WebGL (Three.js) |
| **Protocol** | WebSocket (JSON) |
| **Server** | Modified Freeciv C server |
| **Proxy** | Python Tornado WebSocket |

### Client Implementations

| Client | Rendering | Status |
|--------|-----------|--------|
| 2D isometric | Canvas 2D | ✅ Primary |
| 3D WebGL | Three.js | ⚠️ Experimental |
| Map-generator | Three.js terrain | ✅ Working |

### Key Modifications to Upstream

```diff
# Server patches for web
+ JSON packet encoding (alternative to binary)
+ WebSocket protocol support
+ HTTP savegame import/export
+ Rate limiting for web clients
+ Auto-save to database
```

### Deployment Complexity

```
Required Services:
├── Tomcat 10 (webapp)
├── MariaDB (database)
├── nginx (reverse proxy)
├── Freeciv server (game engine)
├── Python proxy (WebSocket bridge)
└── Docker (optional orchestration)
```

### Lessons for Mobile

| Lesson | Notes |
|--------|-------|
| Client-server separation works | Same architecture viable for mobile |
| JSON protocol simpler than binary | Consider for mobile API |
| WebGL 3D "far from optimal" | Stick to 2D isometric for mobile |
| Complex deployment | Simplify for mobile backend |
| Patch maintenance overhead | Avoid forking if possible |

---

## 3. Freeciv21

**Repository:** https://github.com/longturn/freeciv21  
**Website:** https://longturn.net  
**Stars:** 260  
**Activity:** Very Active (frequent releases)  
**License:** GPL v3

### Description

A modernized fork of Freeciv using C++17 and Qt6. Maintained by the Longturn.net community for competitive multiplayer games. This is the most relevant existing project for mobile development.

### Key Differences from Upstream

| Aspect | Freeciv | Freeciv21 |
|--------|---------|-----------|
| **Language** | C | C++17 |
| **GUI** | GTK/Qt5 | Qt6 |
| **Build** | Autotools | CMake |
| **Networking** | Custom | Qt-based |
| **Tiles** | Square only | Square + Hex |
| **Codebase** | Legacy C | Modern C++ patterns |

### Architecture

```
freeciv21/
├── common/           # Core logic (C++ modernized)
├── server/           # Game server
├── client/           # Qt6-based client
│   ├── client_main.cpp
│   ├── mapview.cpp   # Rendering
│   └── dialogs/      # Qt dialogs
├── ai/               # AI modules
├── tools/            # Utilities
├── data/             # Tilesets, rulesets
└── CMakeLists.txt    # Modern build
```

### Modern C++ Patterns

```cpp
// Example: RAII resource management
class Connection {
    std::unique_ptr<QTcpSocket> socket;
public:
    Connection() : socket(std::make_unique<QTcpSocket>()) {}
    // Automatic cleanup
};

// Example: Smart pointers for game objects
using PlayerPtr = std::shared_ptr<Player>;
using UnitPtr = std::shared_ptr<Unit>;

// Example: STL containers instead of custom lists
std::vector<PlayerPtr> players;
std::unordered_map<int, UnitPtr> units;
```

### Active Features

| Feature | Status |
|---------|--------|
| Longturn games | ✅ Production |
| Multiplayer tournaments | ✅ Active community |
| Metaserver integration | ✅ Working |
| Hex tiles | ✅ Supported |
| Rule changes | ✅ Regular updates |
| CMake build | ✅ Production ready |

### Relevance to Mobile

| Aspect | Opportunity |
|--------|-------------|
| **C++ core** | Could be extracted for engine |
| **CMake build** | Already cross-platform |
| **Qt dependency** | Would need to remove for mobile |
| **Active community** | Potential collaboration |
| **Modern patterns** | Good reference for our engine |

### What Could Be Reused

```
Reusable:
├── common/ logic (C++ modernized)
├── CMake build system
├── AI implementations
├── Savegame format ideas
├── Network protocol concepts
└── Ruleset handling

Not Reusable:
├── Qt-based UI
├── Qt networking
└── Desktop-specific features
```

---

## 4. Freeciv-Android

**Repository:** https://github.com/zielmicha/freeciv-android  
**Author:** Michal Zieliński  
**Stars:** 81  
**Activity:** Inactive (last update ~2020)  
**License:** GPL v2+

### Description

An Android port using Python (Kivy framework) to run Freeciv on mobile devices. Demonstrates technical feasibility but has practical limitations.

### Architecture

```
freeciv-android/
├── android/           # Android packaging
│   └── build.py       # Build script
├── freeciv/           # Embedded Freeciv 2.6.0
├── configure_project/ # Build configuration
│   └── SDL_modify_blending.patch  # Required SDL patch
├── android.py         # Kivy launcher
└── web/proxy.py       # Web proxy for debugging
```

### Technology Stack

| Layer | Technology |
|-------|------------|
| **UI Framework** | Kivy (Python) |
| **Rendering** | SDL2 (requires patched version) |
| **Bridge** | Pyjnius (Python-JNI) |
| **Performance** | Cython (compiled Python) |
| **Engine** | Freeciv 2.6.0 (embedded) |

### Build Requirements

```bash
# From README
Android NDK r12b (specific version required)
SDK >= 26
Java 8
Python 2.7
Cython 0.15

# SDL patching required
patch SDL2 with SDL_modify_blending.patch
```

### Problems Observed

| Problem | Impact |
|---------|--------|
| **Outdated NDK** | Requires NDK r12b (current is r27) |
| **Python overhead** | Performance and memory impact |
| **Patched SDL** | Maintenance complexity |
| **Stale codebase** | No updates in 4+ years |
| **Single author** | Bus factor risk |
| **Complex build** | Many specific version requirements |

### Lessons for Mobile

| Lesson | Our Approach |
|--------|--------------|
| Python adds overhead | Use native Kotlin/Swift |
| SDL patching is fragile | Use platform-native rendering |
| Complex build = brittle | Simplify, use standard tools |
| Specific versions = unmaintainable | Target current SDKs/NDKs |
| Proof of concept ≠ production | Need full mobile-focused design |

---

## 5. Longturn.net Community

**Website:** https://longturn.net  
**Type:** Community / Game Server  
**Activity:** Very Active  
**Platform:** Freeciv21-based

### Description

A dedicated community for long-form multiplayer Freeciv games. Games run continuously with turns lasting hours or days. Maintains custom server infrastructure and community tools.

### Infrastructure

```
Longturn Stack:
├── Metaserver (game browser)
├── Game servers (Freeciv21)
├── Web portal (Django)
├── Discord integration
├── Tournament system
└── Player rankings
```

### Game Types

| Type | Turn Duration | Players |
|------|---------------|---------|
| Longturn | 23 hours | 50+ |
| Blitz | 5-30 minutes | 8-16 |
| Tournament | Scheduled | Variable |

### Relevance

| Aspect | Note |
|--------|------|
| **Community expertise** | Deep knowledge of multiplayer |
| **Server infrastructure** | Proven at scale |
| **Async gameplay** | Same model as mobile |
| **Potential users** | Target audience for mobile |

---

## 6. Other Projects

### Freeciv-wing (Windows Native)

**Repository:** https://github.com/freeciv/freeciv-wing  
**Stars:** 8  
**Status:** Inactive  
**Note:** Windows-native port using Win32 API. Not relevant to mobile.

### Freeciv Classic (Various)

Various distributions and forks for specific platforms (Ubuntu, macOS, Windows). These are packaging efforts rather than forks.

---

## Comparison Matrix

### Technical Approaches

| Project | Language | UI Framework | Build System | Mobile? |
|---------|----------|--------------|--------------|---------|
| Freeciv | C | GTK/SDL | Autotools | ❌ |
| Freeciv-web | C + Java | WebGL | Multiple | ✅ Browser |
| Freeciv21 | C++17 | Qt6 | CMake | ❌ Desktop |
| Freeciv-android | C + Python | Kivy | Custom | ⚠️ Broken |
| **Our project** | C++17 | Native | CMake | ✅ iOS/Android |

### Code Reusability

| Component | Freeciv | Freeciv21 | Freeciv-web |
|-----------|---------|-----------|-------------|
| Game logic | ✅ Direct | ✅ Modernized | ✅ Patched |
| AI | ✅ Direct | ✅ Improved | ✅ Unchanged |
| Network protocol | ⚠️ Binary | ⚠️ Qt-based | ✅ JSON/WebSocket |
| Save format | ⚠️ Custom | ⚠️ Modified | ✅ Database |
| UI patterns | ❌ Desktop | ❌ Desktop | ⚠️ Web |

---

## Lessons Summary

### Technical Lessons

| Lesson | Source | Application |
|--------|--------|-------------|
| Client-server separation works | Freeciv-web | Use same architecture |
| Modern C++ is viable | Freeciv21 | Use C++17 patterns |
| CMake works cross-platform | Freeciv21 | Same build system |
| Python on mobile is problematic | Freeciv-android | Use native languages |
| JSON protocol simpler than binary | Freeciv-web | Consider for API |
| OpenGL ES deprecating | Industry trend | Use Filament/Vulkan |

### Architecture Lessons

| Lesson | Application |
|--------|-------------|
| Don't fork upstream | Patch maintenance is expensive |
| Keep protocol simple | JSON over Protocol Buffers for async |
| Mobile-first design | Cannot just port desktop UI |
| Deterministic logic | Required for multiplayer sync |

---

## Conclusion

The most relevant projects for reference are:

1. **Freeciv21** - Modern C++ patterns, CMake build, active community
2. **Freeciv-web** - Successful port, JSON protocol lessons
3. **Freeciv-android** - Cautionary tale about complexity

However, as noted in the introduction, this is a test project for AI agent evaluation. The above analysis is for reference only - we are proceeding with our own implementation to test the full workflow from design to code.

---

## References

- Freeciv Project: https://freeciv.org
- Freeciv-web: https://play.freeciv.org
- Freeciv21: https://longturn.net
- Longturn Community: https://longturn.net

---

*Document created: 2026-04-06*  
*Purpose: Reference documentation for AI agent test project*
