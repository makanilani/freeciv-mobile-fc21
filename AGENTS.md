# AGENTS.md - Freeciv Mobile (FC21)

## Project State

**Phase 0: Planning & Architecture.** No implementation code exists yet. This repo contains only documentation, planning artifacts, and an AI agent teamwork framework.

The directories `engine/`, `ios/`, `android/`, `shared/` shown in architecture docs are **planned but not created**.

## What This Repo Is

A mobile adaptation of [Freeciv21](https://github.com/longturn/freeciv21) (modern C++17 fork of classic Freeciv). We fork the engine, remove the Qt6 desktop client, and build native mobile UIs.

## Tech Stack (Decided)

| Layer | Technology |
|-------|------------|
| Engine Core | C++17 (from Freeciv21) |
| iOS UI | SwiftUI + Metal/Filament |
| Android UI | Jetpack Compose + Vulkan/Filament |
| Build | CMake (engine), Gradle (Android), XcodeGen (iOS) |
| Saves | SQLite (inherited from Freeciv21) |
| Multiplayer | WebSocket + Protocol Buffers + CRDT sync |
| License | GPL v3+ |

## Key Decisions (Already Made)

All recorded in `docs/DECISIONS.md`. Critical ones:
- **Fork Freeciv21**, don't extract from original C Freeciv (saves ~4 months)
- **Native UI** (SwiftUI/Compose), not Flutter/React Native/Qt
- **Filament** for rendering (Metal on iOS, Vulkan on Android)
- **Offline-first** architecture with event sourcing + CRDT conflict resolution
- **Deterministic game logic**: fixed-point arithmetic for combat, seeded XorShift RNG
- **Remove Qt6 client** entirely, replace with native mobile clients

## Directory Layout

```
docs/        # Architecture, roadmap, scope, decisions, UX guidelines
design/      # UI/UX wireframes (empty/planned)
planning/    # Task tracking, milestones (empty/planned)
notes/       # Research notes (empty/planned)
teamwork/    # AI agent collaboration framework (see below)
```

## AI Agent Teamwork Framework

Located in `teamwork/`. Defines 5 agent roles with OpenRouter models:
1. **Project Lead** - coordination, architecture
2. **Engine Architect** - C++ game logic, performance
3. **Mobile UI** - SwiftUI/Jetpack Compose
4. **Backend/Multiplayer** - server, networking, sync
5. **QA/Integration** - testing, CI/CD, docs

### Important: Deprecated Models

`teamwork/agent-config.yaml` and `teamwork/launch-agents.sh` reference **non-existent OpenRouter models** (`nvidia/llama-3.1-nemotron-ultra-253b-v1:free`, `qwen/qwen3-32b:free`). These will fail at runtime. Update model IDs before using.

### Required Env

```bash
export OPENROUTER_API_KEY='your-key'
```

## Upstream Relationship

- **Upstream:** https://github.com/longturn/freeciv21
- **Sync strategy:** Add as `upstream` remote, merge monthly
- **Track closely:** `common/`, `server/`, `ai/`, `utility/`, `data/`
- **Ignore:** `client/` (Qt6, being removed)
- **Contribute back:** Bug fixes and perf improvements to shared components

See `docs/FREECIV21_FORK.md` for full strategy.

## Documentation Sources of Truth

| Question | File |
|----------|------|
| Technical decisions & rationale | `docs/DECISIONS.md` |
| System architecture & data flow | `docs/ARCHITECTURE.md` |
| Code organization (planned) | `docs/CODE_ORG.md` |
| MVP scope & priorities | `docs/SCOPE.md` |
| Implementation phases | `docs/ROADMAP.md` |
| Fork strategy vs upstream | `docs/FREECIV21_FORK.md` |
| Mobile UX patterns | `docs/MOBILE_UX.md` |
| Existing projects survey | `docs/PREEXISTING_PROJECTS.md` |
| Agent roles & protocols | `teamwork/README.md` |
| Agent model config | `teamwork/agent-config.yaml` |

## Conventions

- **C++ style:** C++17, RAII, smart pointers, K&R braces, 4-space indent, 100 char line limit
- **Commit format:** `<type>(<scope>): <subject>` (conventional commits)
- **Branch naming:** `feature/[agent]-[description]`, `bugfix/...`, `release/...`
- **Determinism:** No floats in combat, seeded RNG, cross-platform testing required (ARM vs x86)

## What to Do Next

When starting work, check `docs/ROADMAP.md` Phase 0 milestones:
1. Fork Freeciv21 repository
2. Remove Qt6 client code
3. Mobile build configuration (CMake for iOS/Android)
4. CI/CD pipeline for mobile builds
5. Rendering API decision (already decided: Filament)
6. Determinism test framework
