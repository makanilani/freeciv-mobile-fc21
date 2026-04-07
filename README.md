# Freeciv Mobile (Freeciv21 Fork)

A mobile adaptation of [Freeciv21](https://github.com/longturn/freeciv21), the modern C++ fork of the classic Freeciv turn-based strategy game.

## Overview

Freeciv Mobile brings the deep 4X strategy experience to iOS and Android with touch-optimized controls, modern UI patterns, and multiplayer support.

**This project forks from [Freeciv21](https://github.com/longturn/freeciv21)**, benefiting from:
- ✅ Modern C++17 codebase (already refactored from original C)
- ✅ Working CMake build system
- ✅ Complete game logic, AI, and ruleset systems
- ✅ Active Longturn.net community and development

**What we add:**
- 🆕 Native mobile UI (SwiftUI for iOS, Jetpack Compose for Android)
- 🆕 Touch-optimized controls and mobile UX
- 🆕 Modern rendering (Filament or Metal/Vulkan)
- 🆕 Offline-first async multiplayer

**Core Goals:**
- Preserve the deep, strategic gameplay of Freeciv21
- Design for touch-first mobile interaction
- Cross-platform: iOS and Android initially
- Multiplayer: async (email-style) + optional real-time

## Project Status

**Phase:** Phase 0: Fork Setup & Restructure  
**Current:** Project restructured with Freeciv21 fork in `engine/`, mobile clients scaffolded, mobile-focused CI/CD configured.

## Documentation

| Document | Purpose |
|----------|---------|
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Technical architecture and system design |
| [ROADMAP.md](docs/ROADMAP.md) | Implementation phases and timeline |
| [SCOPE.md](docs/SCOPE.md) | MVP scope and feature prioritization |
| [DECISIONS.md](docs/DECISIONS.md) | Key technical and design decisions |
| [MOBILE_UX.md](docs/MOBILE_UX.md) | Touch UI patterns and interactions |
| [CODE_ORG.md](docs/CODE_ORG.md) | Code organization and module structure |
| [FREECIV21_FORK.md](docs/FREECIV21_FORK.md) | Fork strategy and upstream relationship |
| [PREEXISTING_PROJECTS.md](docs/PREEXISTING_PROJECTS.md) | Survey of existing Freeciv ports (reference) |

## Tech Stack

| Layer | Technology | Notes |
|-------|------------|-------|
| **Engine Core** | C++17 | From Freeciv21 (no extraction needed!) |
| **Server** | C++17 | From Freeciv21 (AI, rulesets, game logic) |
| **iOS UI** | SwiftUI | Native mobile UI |
| **Android UI** | Jetpack Compose | Native mobile UI |
| **Rendering** | Filament / Metal / Vulkan | Modern cross-platform graphics |
| **Networking** | WebSocket + Protocol Buffers | From Freeciv21, extended for mobile |
| **Offline Storage** | SQLite | From Freeciv21 save system |
| **Multiplayer Sync** | CRDT-based | New for async mobile play |
| **Build** | CMake + Gradle / Xcode | From Freeciv21, extended |

## What's Different from Freeciv21

| Component | Freeciv21 | Freeciv Mobile |
|-----------|-----------|----------------|
| Desktop UI (Qt6) | ✅ | ❌ Replaced |
| Mobile native UI | ❌ | ✅ New |
| Touch controls | ❌ | ✅ New |
| Mobile rendering | ❌ | ✅ New |
| Offline-first sync | ❌ | ✅ New |
| Async multiplayer | ❌ | ✅ New |
| Game logic | ✅ | ✅ Shared |
| AI system | ✅ | ✅ Shared |
| Rulesets | ✅ | ✅ Shared |
| Save system | ✅ | ✅ Shared |

## Project Structure

```
freeciv-mobile-fc21/
├── engine/                  # Freeciv21 game engine (from upstream)
│   ├── common/              # Shared game logic
│   ├── server/              # Game server, AI, rulesets
│   ├── ai/                  # AI system
│   ├── utility/             # Utilities, versioning
│   ├── data/                # Ruleset data, tilesets
│   ├── tools/               # Build tools
│   └── cmake/               # CMake modules
│
├── ios/                     # iOS application (SwiftUI)
│   ├── FreecivMobile/       # SwiftUI app
│   └── CMakeLists.txt       # iOS build config
│
├── android/                 # Android application (Compose)
│   ├── app/                 # Kotlin app
│   └── CMakeLists.txt       # Android build config
│
├── docs/                    # Documentation
│   ├── ARCHITECTURE.md      # Technical architecture
│   ├── ROADMAP.md           # Implementation timeline
│   ├── SCOPE.md             # MVP definition
│   └── ...                  # Other documentation
│
├── planning/                # Task tracking
│   ├── backlog.md           # Feature backlog
│   └── milestones.md        # Project milestones
│
├── design/                  # UI/UX designs (planned)
├── notes/                   # Research notes
├── teamwork/                # AI agent collaboration framework
│
├── scripts/                 # Helper scripts
├── .github/                 # CI/CD workflows
└── README.md                # This file
```

## Timeline

| Phase | Duration | Description |
|-------|----------|-------------|
| **Phase 0: Fork Setup** | Month 0 | Fork Freeciv21, setup mobile build |
| **Phase 1: Mobile UI** | Months 1-4 | Native mobile UI, touch controls |
| **Phase 2: Integration** | Months 4-6 | Connect UI to engine, game actions |
| **Phase 3: Multiplayer** | Months 6-9 | Backend, async sync, notifications |
| **Phase 4: Polish** | Months 9-12 | Performance, UX polish, launch |

**Total: 12 months** (3 months saved by forking vs extracting!)

## Inspiration

- [Freeciv21](https://github.com/longturn/freeciv21) - Our upstream project
- [Freeciv Web](https://github.com/freeciv/freeciv-web) - Browser version reference
- [Civilization VI](https://civilization.com/) - Mobile-optimized 4X reference
- [Old School RuneScape Mobile](https://oldschool.runescape.com/) - Desktop→Mobile port example

## License

GPL v3+ (inherited from Freeciv21). All game logic is derived from the Freeciv21 project.

## Contributing

Not yet open for contributions. Follow this repository for updates.

## Acknowledgments

- **Freeciv21 Team** - For the excellent modern C++ codebase we build upon
- **Longturn.net Community** - For maintaining and developing Freeciv21
- **Original Freeciv Project** - For creating the game we love
