# Freeciv Research Notes

*Collected during codebase study - 2026-04-05*

## Freeciv Codebase Overview

### Language & Build
- **Language:** C (primary), some C++
- **Build:** Autotools (configure.ac) + Meson
- **Standards:** C99/C11

### Key Directories

| Directory | Lines (est.) | Purpose |
|-----------|-------------|---------|
| `common/` | 150K | Core game logic |
| `server/` | 80K | Game server |
| `client/` | 60K | GUI clients |
| `ai/` | 40K | AI implementations |
| `tools/` | 30K | Utilities (ruledit, etc.) |
| `utility/` | 20K | Shared utilities |

### Critical Files to Extract

#### Core Logic
- `common/game.c` - Turn processing, victory
- `common/city.c` - City management
- `common/unit.c` - Unit actions
- `common/map.c` - Map/terrain
- `common/player.c` - Player state
- `common/tech.c` - Technology tree
- `common/actions.c` - Action system

#### AI Core
- `common/aicore/pathfinding.[ch]` - A* pathfinding
- `common/aicore/citymap.[ch]` - City optimization
- `ai/default/` - DAI (Default AI)

#### Data
- `data/` - Rulesets (civ1, civ2, civ2civ3, etc.)
- `common/tech.c` - Tech tree data
- `common/unittype.c` - Unit definitions

### Dependencies to Handle

1. **Lua** - Scripting (`common/scriptcore/`)
2. **SDL2_gfx** - Graphics primitives
3. **SQLite** - Save games (via utility/shared)
4. **Network** - Custom packet system

### Porting Challenges

#### 1. Memory Management
- Heavy use of `malloc/free`
- Need wrapper with leak detection
- Consider arena allocator for performance

#### 2. Floating Point Determinism
- Random number generation
- Combat calculations
- Map generation
- **Must use fixed-point or seeded RNG**

#### 3. Internationalization
- Uses `fc_internal` system
- Large `.po` translation files
- Can defer i18n for MVP

#### 4. Network Protocol
- Custom binary protocol in `common/networking/`
- Delta compression for efficiency
- Complex packet types

### Architecture Patterns Found

#### 1. Callback-based Events
```c
// Universal hash/callback system
struct callback_list *callbacks[CB_LAST];
callback_list_call_1(callbacks[CB_UNIT_BUILT], &punit);
```

#### 2. Iteration Macros
```c
// Custom iterator macros
players_iterate(pplayer) { ... } players_iterate_end;
units_iterate(punit) { ... } units_iterate_end;
```

#### 3. Property System
```c
// Base class with type-specific accessors
struct universal {
    enum unit_type type;
    void *data;
};
```

#### 4. Effect System
```c
// Ruleset-defined effects
struct effect {
    int value;
    enum effect_type type;
    enum effect_range range;
};
```

### Performance Considerations

| System | Bottleneck | Mobile Approach |
|--------|-----------|-----------------|
| Pathfinding | A* called frequently | Cache results, limit iterations |
| Fog of War | Recalculated each turn | Incremental updates |
| Combat | Many calculations | Pre-compute tables |
| Map Gen | Slow perlin noise | Background thread |
| AI | Deep search | Parallel, limited depth |

### Testing Strategy

- `tests/` - CMocka unit tests
- `test/` - Integration tests
- Python-based client testing
- **Extract to Google Test or Catch2**

---

## Mobile Adaptation Ideas

### Simplified MVP Ruleset

Initial focus on `civ2civ3` subset:

**Units (MVP):**
- Settlers, Workers
- Warriors, Archers, Swordsmen
- Horsemen, Phalanx
- Galley, Trireme
- Catapult, Chariot
- Legion, Horsemen
- Phalanx, Pikemen
- Cruiser, Ironclad
- Cannon, Artillery

**Buildings (MVP):**
- Granary, Warehouse
- Barracks, City Walls
- Library, University
- Temple, Cathedral
- Marketplace, Bank
- Workshop, Factory
- Courthouse
- Aqueduct, Sewer

**Techs (MVP):**
- ~30 core technologies
- Simple prerequisites

### Rendering Strategy

1. **Sprite Sheets** - Pre-render tiles as PNGs
2. **Batched Drawing** - Minimize GL calls
3. **LOD** - Lower detail at distance
4. **Culling** - Only render visible tiles

---

## Next Steps

- [ ] Detailed code extraction plan
- [ ] Identify exact dependencies
- [ ] Prototype engine build
- [ ] Define FFI interface
