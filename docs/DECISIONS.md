# Technical Decision Records

This document records significant technical decisions for Freeciv Mobile.

---

## ADR-001: Fork from Freeciv21 (Not Extract from Original Freeciv)

**Status:** ✅ Accepted

**Context:**

We need a modern C++ game engine for mobile development. Options:
1. Extract game logic from original Freeciv (C codebase, ~380K LOC)
2. Fork from Freeciv21 (already modernized C++ codebase)

**Decision:**

Fork from [Freeciv21](https://github.com/longturn/freeciv21).

**Rationale:**

| Factor | Original Freeciv | Freeciv21 |
|--------|------------------|-----------|
| Language | C (procedural) | C++17 (modern) |
| Modernization needed | ~5 months | ~0 months |
| Build system | Autotools | CMake 3.21+ |
| Active development | Maintenance only | Active (Longturn.net) |
| Code quality | Legacy patterns | Modern C++ patterns |
| Cross-platform | Limited | Windows, macOS, Linux, FreeBSD |
| Community | Small | Active multiplayer community |

**Consequences:**

- ✅ **Positive:** Saves 3-4 months of engine extraction work
- ✅ **Positive:** Benefits from ongoing Freeciv21 improvements
- ✅ **Positive:** CMake build system already works
- ✅ **Positive:** Modern C++17 code is easier to maintain
- ⚠️ **Negative:** Must track upstream changes (or diverge)
- ⚠️ **Negative:** Qt6 client code must be removed/replaced

**Timeline Impact:** 12 months instead of 15 months (-3 months)

---

## ADR-002: Native Mobile UI Frameworks

**Status:** ✅ Accepted

**Context:**

We need UI frameworks for iOS and Android that provide:
- Native look and feel
- Touch-first interaction
- Good performance
- Modern development experience

**Decision:**

- **iOS:** SwiftUI (with UIKit interop for rendering)
- **Android:** Jetpack Compose

**Rationale:**

Both are:
- Official platform recommendations from Apple and Google
- Declarative UI frameworks (modern paradigm)
- Well-supported with active development
- Capable of complex UIs needed for strategy games

Alternatives considered:
- **Flutter:** Adds abstraction layer, larger app size, less native feel
- **React Native:** JavaScript overhead, not ideal for game UI
- **Qt Quick (from Freeciv21):** Not touch-optimized, mobile support limited

**Consequences:**

- ✅ Native look and feel on each platform
- ✅ Best performance (native code)
- ✅ Platform-specific optimizations available
- ⚠️ Two codebases to maintain (but shared engine)
- ⚠️ Platform-specific bugs possible

---

## ADR-003: Rendering Strategy (Filament or Native)

**Status:** ✅ Accepted

**Context:**

We need a cross-platform rendering solution that:
- Works on both iOS and Android
- Provides good performance for tile-based 2D/2.5D rendering
- Is future-proof (OpenGL ES deprecated on iOS)

**Decision:**

**Primary:** Google Filament (cross-platform abstraction)  
**Fallback:** Platform-native (Metal for iOS, Vulkan for Android)

**Rationale:**

| API | iOS Support | Android Support | Complexity |
|-----|-------------|-----------------|------------|
| OpenGL ES 3.0 | ⚠️ Deprecated | ⚠️ ANGLE only | Low |
| **Filament** | ✅ Metal backend | ✅ Vulkan backend | Medium |
| Metal (native) | ✅ Native | ❌ N/A | Medium |
| Vulkan (native) | ❌ N/A | ✅ Native | Medium |

Filament advantages:
- Cross-platform with native backends (Metal/Vulkan)
- Open source, actively maintained by Google
- Good documentation and examples
- Designed for mobile-first

**Consequences:**

- ✅ Future-proof on both platforms
- ✅ Good performance (native backends)
- ✅ Single API for both platforms
- ⚠️ Learning curve for Filament API
- ⚠️ Additional dependency

---

## ADR-004: SQLite for Save Format

**Status:** ✅ Accepted (From Freeciv21)

**Context:**

Need a save format that is:
- Reliable and corruption-resistant
- Queryable for debugging
- Cross-platform compatible
- Already used in Freeciv21

**Decision:**

Use SQLite (`.fcsave` files), inherited from Freeciv21.

**Rationale:**

Freeciv21 already uses SQLite for saves. Benefits:
- Atomic transactions (no corruption)
- Efficient binary format
- Works offline
- Can query for debugging
- Well-tested in Freeciv21

**Consequences:**

- ✅ No need to build new save system
- ✅ Compatible with Freeciv21 saves (potentially)
- ✅ Well-understood technology
- ⚠️ Need to version schema for mobile additions

---

## ADR-005: Network Protocol

**Status:** ✅ Accepted (Extended from Freeciv21)

**Context:**

Need network protocol for multiplayer that supports:
- Real-time and async play
- Mobile-specific constraints (intermittent connectivity)
- Efficient binary format

**Decision:**

Extend Freeciv21's Protocol Buffers-based protocol with:
- WebSocket transport for mobile clients
- Offline-first sync layer
- CRDT-based conflict resolution

**Rationale:**

Freeciv21 already uses Protocol Buffers. We extend with:
- WebSocket for mobile-friendly transport
- Offline queue for async play
- CRDT for conflict resolution

**Consequences:**

- ✅ Leverage existing Freeciv21 protocol
- ✅ Efficient binary serialization
- ✅ Mobile-friendly transport
- ⚠️ New sync layer needed for offline-first

---

## ADR-006: Game State Sync (Event Sourcing + CRDT)

**Status:** ✅ Accepted

**Context:**

For async multiplayer, we need:
- Offline-first capability
- Conflict resolution when re-syncing
- No data loss

**Decision:**

Event sourcing with CRDT-based conflict resolution.

**Rationale:**

- **Event Sourcing:** Store actions, not just state
- **CRDT (Conflict-free Replicated Data Types):** Resolve conflicts automatically
- **Server Authoritative:** Final truth comes from server

**Consequences:**

- ✅ Works offline
- ✅ Automatic conflict resolution
- ✅ Can replay game history
- ⚠️ More complex than simple state sync
- ⚠️ Need careful design of CRDT types

---

## ADR-007: AI System (From Freeciv21)

**Status:** ✅ Accepted (From Freeciv21)

**Context:**

Need AI for single-player games.

**Decision:**

Use Freeciv21's existing AI system (C++ implementation).

**Rationale:**

Freeciv21 has mature, well-tested AI:
- Multiple advisors (city, unit, diplomat)
- Pathfinding (A* implementation)
- Strategic planning
- Configurable difficulty

**Consequences:**

- ✅ No AI development needed
- ✅ Mature, tested AI
- ✅ Tunable difficulty levels
- ⚠️ May need performance optimization for mobile

---

## ADR-008: Build System (CMake)

**Status:** ✅ Accepted (From Freeciv21)

**Context:**

Need build system that:
- Works for C++ engine
- Integrates with iOS (Xcode) and Android (Gradle)

**Decision:**

Use CMake, inherited from Freeciv21.

**Rationale:**

Freeciv21 already uses CMake 3.21+:
- Cross-platform
- Good IDE integration
- Supports iOS and Android NDK
- ExternalProject support for dependencies

**Consequences:**

- ✅ Proven build system
- ✅ Works with Freeciv21 code
- ✅ Good mobile tooling support
- ⚠️ Need platform-specific configurations

---

## ADR-009: Ruleset Format (JSON/Server-side)

**Status:** ✅ Accepted (From Freeciv21)

**Context:**

Freeciv uses rulesets to define game rules (units, buildings, techs).

**Decision:**

Use Freeciv21's ruleset system (server-side parsing, JSON-like format).

**Rationale:**

Freeciv21's ruleset system:
- Data-driven game rules
- Multiple rulesets supported (civ2civ3, classic, etc.)
- Effect system for complex rules
- Already working and tested

**Consequences:**

- ✅ Compatible with Freeciv21 rulesets
- ✅ Can add mobile-specific rulesets
- ✅ No ruleset work needed
- ⚠️ Ruleset files bundled with app

---

## ADR-010: Offline-First Architecture

**Status:** ✅ Accepted

**Context:**

Mobile users expect apps to work offline.

**Decision:**

Design for offline-first:
- Local-first state management
- Optimistic updates
- Background sync when online
- Clear offline indicator in UI

**Rationale:**

Mobile reality:
- Intermittent connectivity
- Users expect apps to work offline
- Async multiplayer should feel seamless

**Consequences:**

- ✅ Works offline (single-player)
- ✅ Smooth async multiplayer experience
- ⚠️ More complex state management
- ⚠️ Need conflict resolution (CRDT)

---

## ADR-011: Deterministic Game Logic

**Status:** ✅ Accepted

**Context:**

For multiplayer sync and replays, game logic must be deterministic across platforms.

**Decision:**

Ensure determinism:
- Fixed-point arithmetic for combat (no floats)
- Seeded RNG (XorShift)
- Consistent tie-breaking heuristics
- Cross-platform testing (ARM vs x86)

**Rationale:**

Floating-point arithmetic can differ between ARM (mobile) and x86 (desktop/server). This breaks:
- Multiplayer sync
- Replay functionality
- AI consistency

**Consequences:**

- ✅ Reliable multiplayer sync
- ✅ Cross-platform consistency
- ✅ Replays work correctly
- ⚠️ Need to audit existing Freeciv21 code for float usage
- ⚠️ Performance impact from fixed-point (minimal)

---

## ADR-012: Remove Qt6 Client

**Status:** ✅ Accepted

**Context:**

Freeciv21 uses Qt6 for its desktop client. We need mobile native UI.

**Decision:**

Remove Qt6 client code, replace with native mobile clients.

**Rationale:**

- Qt6 mobile support is limited
- Not touch-optimized for strategy game
- Increases app size significantly
- Native UI provides better user experience

**What we remove:**
- `client/` directory (Qt6-based)
- Qt dependencies

**What we keep:**
- `common/` (shared logic)
- `server/` (game server, AI)
- `utility/` (utilities)
- `data/` (rulesets, assets)

**Consequences:**

- ✅ Smaller app size
- ✅ Native mobile experience
- ⚠️ Lose desktop client (could be added later)
- ⚠️ Need to reimplement UI layer

---

## Decision Process

### How Decisions Are Made

1. **Identify:** Document the context and options
2. **Analyze:** Evaluate trade-offs
3. **Decide:** Choose and document rationale
4. **Review:** Revisit if circumstances change

### Decision Template

```markdown
## ADR-XXX: [Title]

**Status:** [Proposed | Accepted | Deprecated | Superseded]

**Context:**
[Why this decision is needed]

**Decision:**
[What we decided]

**Rationale:**
[Why we made this choice]

**Consequences:**
- ✅ Positive outcomes
- ⚠️ Trade-offs or risks
```

---

## Future Decisions Needed

| Topic | Priority | Notes |
|-------|----------|-------|
| Tileset format | Medium | Keep Freeciv21 format or convert? |
| Audio system | Low | SDL2 mixer from Freeciv21 or native? |
| Minimap implementation | Medium | Native or use Filament? |
| Tutorial system | Low | Lua scripts or native code? |
| Push notifications | High | Firebase vs platform-native? |

---

## Changelog

| Date | ADR | Change |
|------|-----|--------|
| 2025-04-06 | ADR-001 | Changed from "Extract from Freeciv" to "Fork from Freeciv21" |
| 2025-04-06 | ADR-003 | Updated from OpenGL ES to Filament/Native |
| 2025-04-06 | ADR-010 | Added Offline-First Architecture |
| 2025-04-06 | ADR-011 | Added Deterministic Game Logic |
| 2025-04-06 | ADR-012 | Added Qt6 Removal decision |
