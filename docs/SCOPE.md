# MVP Scope Definition

## What is the MVP?

**Freeciv Mobile MVP** is a playable single-player strategy game that captures the core Freeciv experience with a touch-optimized interface.

### Must Have (MVP)

#### Core Gameplay
- [ ] **Map exploration** - Visible terrain, fog of war
- [ ] **Unit management** - Move, attack, fortify, disband
- [ ] **City building** - Settle, grow, produce units/buildings
- [ ] **Technology research** - Tech tree progression
- [ ] **Combat system** - Attack, defense, terrain modifiers
- [ ] **Resource management** - Food, production, trade, gold
- [ ] **Government types** - monarchy, republic, democracy, etc.

#### Game Features
- [ ] **Hotseat multiplayer** - 2+ players on same device
- [ ] **Save/load games** - Persistent offline saves
- [ ] **Victory conditions** - Conquest, space race, culture
- [ ] **Game settings** - Map size, difficulty, ruleset

#### Mobile UX
- [ ] **Touch map controls** - Pinch zoom, pan, tap select
- [ ] **Responsive UI** - Adapts to phone/tablet orientations
- [ ] **Turn indicator** - Clear "End Turn" action
- [ ] **Action feedback** - Visual confirmation of actions

### Should Have (Post-MVP)

#### Multiplayer
- [ ] Async multiplayer (email-style turns)
- [ ] Turn notifications (push)
- [ ] Game lobby

#### Content
- [ ] Multiple rulesets (civ2civ3, classic)
- [ ] Expanded unit roster
- [ ] More terrain types

#### UX Enhancements
- [ ] Tutorial mode
- [ ] Sound effects
- [ ] Quick commands (attack, road)
- [ ] Minimap

### Nice to Have (Later)

- Real-time multiplayer
- Cloud saves
- Achievements
- Leaderboards
- Mod support
- AI personality types
- Voice commands

---

## Out of Scope (MVP)

### Features NOT in MVP

| Feature | Reason |
|---------|--------|
| Online multiplayer | Complex backend, defer to phase 2 |
| Cross-platform saves | Storage format needs stabilization |
| Mod support | Need stable ruleset system first |
| Custom maps | Start with procedural generation |
| LAN play | Focus on async cloud multiplayer |
| Replays | Can add after save/load stable |
| Spectator mode | Needs multiplayer first |

### Ruleset Elements (Simplified MVP)

For the initial ruleset, we include:

**Included:**
- 7 terrain types (plains, desert, ocean, etc.)
- ~15 unit types (settlers, warriors, archers, etc.)
- ~20 buildings (barracks, temple, library, etc.)
- ~30 technologies
- 5 government types
- Basic wonders (Pyramids, Library, etc.)

**Deferred:**
- Additional terrain (ice, glacier)
- Aircraft, missiles
- Advanced wonders
- Nation-specific units/buildings
- Terraforming rulesets

---

## User Stories

### Core Player

```
As a new player,
I want to start a game quickly,
so I can play without reading instructions.

Acceptance Criteria:
- Single tap to start new game
- AI opponents fill remaining slots
- Default settings are balanced
- First turn begins immediately
```

```
As a returning player,
I want to see my saved games,
so I can continue where I left off.

Acceptance Criteria:
- Saved games listed on main menu
- Shows game state preview (turn, score)
- One tap to resume
- Auto-save on app background
```

### Strategy Player

```
As a strategy player,
I want to plan unit movements,
so I can execute complex tactics.

Acceptance Criteria:
- Movement range visible on map
- Path preview before confirming
- Undo movement before End Turn
- Attack strength shown
```

### Mobile-First Player

```
As a mobile user,
I want to play in short sessions,
so I can enjoy the game during commutes.

Acceptance Criteria:
- Turn can be completed in < 2 minutes
- Async play available
- Notifications remind of turns
- Portrait mode fully playable
```

---

## Technical Constraints

### Platform Support (MVP)

| Platform | Minimum Version | Target Device |
|----------|---------------|---------------|
| iOS | 15.0 | iPhone 12+ |
| Android | API 26 (8.0) | Pixel 4+ |
| Tablet | Both | iPad 8+, Galaxy Tab S6+ |

### Performance Budget

| Metric | Target | Hard Limit |
|--------|--------|------------|
| Frame rate | 60 FPS | 30 FPS minimum |
| Cold start | < 5s | 10s |
| Turn calc | < 500ms | 2s |
| Memory | < 300MB | 512MB |
| Save size | < 5MB | 20MB |
| Download | < 100MB | 200MB |

### Determinism Requirements

For multiplayer sync and replay functionality:

| System | Requirement |
|--------|------------|
| **Combat calculations** | Fixed-point arithmetic (no floats) |
| **Random number generation** | Seeded, deterministic RNG |
| **Map generation** | Identical with same seed |
| **AI decisions** | Deterministic with same game state |
| **Pathfinding** | Consistent tie-breaking |

**Testing Requirements:**
- Combat results must be identical on ARM and x86
- Map generation must be identical with same seed across platforms
- AI must make same decisions given same game state

### Storage

- **Local saves:** SQLite in app sandbox
- **Settings:** SharedPreferences (Android) / UserDefaults (iOS)
- **Cache:** Auto-cleared after 30 days

### Offline-First Requirements

| Requirement | Implementation |
|-------------|----------------|
| **Offline play** | Full single-player without network |
| **Optimistic updates** | Actions applied locally immediately |
| **Background sync** | Queue actions when online |
| **Conflict resolution** | Server-authoritative for multiplayer |
| **Offline indicator** | Clear status in UI |

**Offline Indicator States:**
- 🟢 **Online** - All features available, sync active
- 🟡 **Degraded** - Limited features, sync pending
- 🔴 **Offline** - Single-player only, changes queued

---

## UI/UX Boundaries

### Screen Inventory (MVP)

| Screen | Purpose | Complexity |
|--------|---------|-----------|
| Main Menu | Start, load, settings | Simple |
| Game Screen | Main play area | Complex |
| City View | City management | Medium |
| Tech Tree | Research selection | Medium |
| Diplomacy | Contact/peace | Simple |
| Settings | Options | Simple |
| Tutorial | First-time guidance | Medium |

### Navigation

```
Main Menu
├── New Game → Game Screen
├── Load Game → Game Screen
├── Settings → Settings Screen
└── About → About Screen

Game Screen
├── [City Tap] → City View (modal)
├── [Unit Tap] → Action Sheet (bottom)
├── [End Turn] → Next Turn
└── [Menu] → Pause Menu

City View
├── Production Tab
├── Citizens Tab
├── Buildings Tab
└── [X] → Close
```

### Control Scheme

| Gesture | Action |
|---------|--------|
| Tap | Select unit/city/tile |
| Double-tap | Quick attack (unit) |
| Long-press | Context menu |
| Pinch | Zoom in/out |
| Two-finger pan | Scroll map |
| Swipe from edge | Minimap |

### Information Density

- **Portrait mode:** Single column, essential info only
- **Landscape mode:** Side panel for details
- **Tablet:** Multi-panel layout

---

## Game Balance (MVP)

### Difficulty Levels

| Level | AI Aggression | AI Cheats |
|-------|---------------|-----------|
| Easy | Low | Research -50% |
| Normal | Medium | None |
| Hard | High | Units +50% |
| Brutal | Very High | All +50% |

### Map Generation

- **Default size:** 80x50 tiles
- **Land ratio:** 30-40%
- **Resources:** Standard density
- **Climate:** Balanced

### Starting Conditions

- **Units:** 1 settler, 2 warriors
- **City:** Named by player
- **Vision:** 2 tile radius
- **Gold:** 0

---

## Success Criteria for MVP

### Must Ship

- [ ] Complete game from start to victory
- [ ] All unit types functional
- [ ] All building types functional
- [ ] All victory paths achievable
- [ ] Hotseat 2-player works
- [ ] Save/load reliable
- [ ] 60 FPS on target devices
- [ ] Crash-free (< 0.1%)

### Quality Gates

1. **Playtest 0:** Internal team, full playthrough
2. **Playtest 1:** 10 external testers, 1 week
3. **Playtest 2:** 50 testers, 2 weeks
4. **Beta:** Public beta, bug fixes only
5. **Release:** Store submission

---

## Scope Change Process

### Adding to Scope

1. Write user story with acceptance criteria
2. Estimate effort (story points)
3. Prioritize against backlog
4. Identify dependencies
5. Adjust timeline if needed
6. PM + Tech Lead approval required

### Removing from Scope

1. Identify blocking dependency or risk
2. Document why feature is deferred
3. Move to "Post-MVP" backlog
4. Update documentation
5. Stakeholder communication

### Scope Boundaries

**PM cannot add:**
- Network protocol changes
- Engine architecture changes
- Platform support additions

**Tech Lead cannot remove:**
- Core gameplay mechanics
- Performance requirements
- Security features
