# Implementation Roadmap

## Overview

Estimated timeline: **12 months** for full MVP  
Team: 3-4 developers (1 mobile iOS, 1 mobile Android, 1 backend, 1 shared)

**Key Advantage:** By forking Freeciv21, we skip 4 months of engine extraction work!

---

## Phase 0: Fork Setup (Month 0)

*Goal: Fork Freeciv21 and establish mobile build infrastructure*

### Milestones

- [ ] **M0.1** Fork Freeciv21 repository
- [ ] **M0.2** Remove Qt6 client code
- [ ] **M0.3** Mobile build configuration (CMake for iOS/Android)
- [ ] **M0.4** CI/CD pipeline for mobile builds
- [ ] **M0.5** Rendering API decision (Filament vs Native)
- [ ] **M0.6** Determinism test framework

### Deliverables

| Item | Description |
|------|-------------|
| Forked repo | Freeciv21 fork with mobile structure |
| Build configs | CMake iOS/Android toolchains |
| CI pipeline | GitHub Actions for mobile builds |
| Decision log | Rendering API finalized |

### Success Criteria

- Engine builds for iOS simulator and Android emulator
- Server builds and runs locally
- Test suite passes

---

## Phase 1: Mobile UI Foundation (Month 1-4)

*Goal: Build native mobile UI layer with rendering*

### 1.1 Rendering Layer (Month 1-2)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Filament integration (iOS) | 2 weeks | M0.5 decision |
| Filament integration (Android) | 2 weeks | iOS integration |
| Tile rendering pipeline | 2 weeks | Filament setup |
| Isometric projection | 2 weeks | Tile rendering |
| Camera controls (zoom/pan) | 1 week | Projection |
| Layer system (units, cities) | 1 week | Tile rendering |
| Performance profiling | 1 week | All rendering |

### 1.2 Touch Input System (Month 2-3)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Tap detection | 1 week | Rendering |
| Selection system | 1 week | Tap detection |
| Gesture recognizers | 2 weeks | Selection |
| Action targeting | 2 weeks | Gesture system |
| Long-press context menus | 1 week | Gesture system |

### 1.3 Core UI Components (Month 3-4)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Main menu screen | 1 week | None |
| Game screen shell | 2 weeks | Rendering |
| Bottom sheet system | 1 week | Game screen |
| Unit action menu | 1 week | Bottom sheets |
| City info panel | 1 week | Game screen |
| Minimap component | 1 week | Rendering |
| Turn indicator HUD | 1 week | Game screen |
| Settings screen | 1 week | Main menu |

### Phase 1 Deliverables

- [ ] **D1.1** Map renders at 60 FPS on target devices
- [ ] **D1.2** Touch selection responsive (< 100ms)
- [ ] **D1.3** Core UI components functional
- [ ] **D1.4** Both iOS and Android UI shells complete

### Success Criteria

- Map renders fluidly on mid-range devices
- Touch interaction feels native
- UI follows platform guidelines
- Portrait and landscape both work

---

## Phase 2: Engine Integration (Month 4-6)

*Goal: Connect mobile UI to Freeciv21 engine*

### 2.1 FFI Layer (Month 4-5)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Swift C++ bridge | 2 weeks | Phase 1 |
| Kotlin JNI bridge | 2 weeks | Phase 1 |
| Game state sync | 2 weeks | FFI bridges |
| Action dispatch | 2 weeks | State sync |

### 2.2 Action System (Month 5-6)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Unit movement UI | 2 weeks | FFI, Input system |
| Combat UI | 1 week | Movement UI |
| Build/road UI | 1 week | Movement UI |
| Unit goto pathfinding | 2 weeks | Pathfinding from engine |
| City production UI | 2 weeks | FFI |
| Citizen management | 1 week | City UI |

### 2.3 Turn Flow (Month 6)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Turn progression UI | 1 week | FFI |
| AI turn indicator | 1 week | Turn progression |
| Turn summary dialog | 1 week | Events system |
| Victory/defeat screens | 1 week | Victory conditions |
| Save/load UI | 2 weeks | Save system from engine |

### Phase 2 Deliverables

- [ ] **D2.1** Complete unit command UI
- [ ] **D2.2** Full city management UI
- [ ] **D2.3** Working hotseat multiplayer
- [ ] **D2.4** AI vs human play functional
- [ ] **D2.5** Save/load working

### Success Criteria

- All Freeciv21 actions possible from mobile UI
- Turn flow is intuitive and clear
- No action dead-ends (all actions reachable)
- AI provides reasonable challenge
- Saves compatible with Freeciv21

---

## Phase 3: Backend & Multiplayer (Month 6-9)

*Goal: Enable async multiplayer with offline-first*

### 3.1 Backend Infrastructure (Month 6-7)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Mobile game server setup | 2 weeks | Freeciv21 server |
| Account/auth system | 1 week | Server |
| Game room management | 2 weeks | Auth |
| Turn sync protocol | 2 weeks | Room management |
| Offline-first sync layer | 2 weeks | Turn sync |
| Conflict resolution (CRDT) | 1 week | Sync layer |

### 3.2 Async Multiplayer (Month 7-8)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Game state sync | 2 weeks | Offline-first sync |
| Push notifications (iOS) | 1 week | Auth |
| Push notifications (Android) | 1 week | Auth |
| Turn timer system | 1 week | Notifications |
| Game lobby UI | 2 weeks | Room management |

### 3.3 Real-time Mode (Optional) (Month 8-9)

| Task | Effort | Dependencies |
|------|--------|-------------|
| WebSocket integration | 2 weeks | Backend |
| Live action broadcast | 1 week | WebSocket |
| Presence indicators | 1 week | Broadcast |
| Turn timer (optional) | 1 week | Presence |

### Phase 3 Deliverables

- [ ] **D3.1** Async multiplayer functional
- [ ] **D3.2** Account system working
- [ ] **D3.3** Game lobby UI complete
- [ ] **D3.4** Offline play works
- [ ] **D3.5** Optional: Real-time mode

### Success Criteria

- Can complete full async game with 2+ players
- Notifications arrive reliably
- No desyncs or state corruption
- Server handles 1000 concurrent games
- Offline play syncs when reconnected

---

## Phase 4: Polish & Launch (Month 9-12)

*Goal: App store readiness, launch prep*

### 4.1 Performance Optimization (Month 9-10)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Memory profiling | 1 week | All systems |
| Render profiling | 1 week | Map system |
| AI performance (mobile) | 1 week | AI from engine |
| Battery optimization | 1 week | All systems |
| Determinism verification | 1 week | All systems |

### 4.2 UX Polish (Month 10-11)

| Task | Effort | Dependencies |
|------|--------|-------------|
| Tutorial system | 2 weeks | All UI |
| Sound effects integration | 1 week | SDL mixer from engine |
| Music integration | 1 week | Sound |
| Haptic feedback | 1 week | Controls |
| Loading screens | 1 week | All systems |
| Error handling UI | 1 week | All systems |

### 4.3 Store Prep (Month 11-12)

| Task | Effort | Dependencies |
|------|--------|-------------|
| App store assets | 1 week | Design team |
| Store listing copy | 1 week | Marketing |
| Privacy policy / ToS | 1 week | Legal |
| Beta testing (TestFlight + Play Store) | 3 weeks | All systems |
| Launch marketing | 1 week | Marketing |
| App store submission | 1 week | Beta complete |

### Phase 4 Deliverables

- [ ] **D4.1** Performance meets targets
- [ ] **D4.2** Tutorial functional
- [ ] **D4.3** Audio complete
- [ ] **D4.4** Live on App Store & Play Store

### Success Criteria

- 60 FPS sustained on iPhone 12 / Pixel 5 equivalent
- Tutorial completion rate > 70%
- Store rating > 4.0 at launch
- No critical bugs in first week

---

## Timeline Visualization

```
Month:    0   1   2   3   4   5   6   7   8   9  10  11  12
Phase 0:  [=FORK SETUP=]
Phase 1:       [========MOBILE UI========]
Phase 2:                 [====INTEGRATION====]
Phase 3:                       [==MULTIPLAYER==]
Phase 4:                             [===POLISH===]
```

---

## Resource Requirements

| Role | Months | Responsibilities |
|------|--------|------------------|
| iOS Developer | 12 | SwiftUI, Filament/Metal, engine bridge |
| Android Developer | 12 | Compose, Filament/Vulkan, engine bridge |
| Backend Developer | 6 | Multiplayer server, auth, sync |
| Shared Dev | 12 | C++ engine integration, AI optimization |
| UX Designer | 4 | UI/UX, wireframes, polish |
| PM | 6 | Coordination, planning |

**Total:** ~4 FTE-years (vs 5 FTE-years for extraction approach)

---

## Risk Register

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Filament learning curve | Medium | Medium | Prototype early, allocate extra time |
| FFI complexity | Medium | High | Use established patterns, thorough testing |
| Determinism issues across ARM/x86 | Medium | High | Fixed-point math, seeded RNG, test framework |
| Network state sync conflicts | Medium | Medium | CRDT-based conflict resolution |
| Qt code removal side effects | Low | Medium | Careful audit, comprehensive tests |
| Upstream merge conflicts | Medium | Low | Clean separation, regular merges |
| Mobile performance | Medium | Medium | Profile early, optimize AI for mobile |
| Scope creep | High | High | Strict MVP boundaries |

---

## Success Metrics

### Engine Quality (Inherited from Freeciv21)
- [x] All Freeciv units available
- [x] All Freeciv buildings available
- [x] All Freeciv techs available
- [x] Victory conditions match Freeciv

### Mobile Quality
- [ ] 60 FPS on target devices
- [ ] Touch accuracy > 95%
- [ ] Crash-free sessions > 99%
- [ ] Battery drain < 10%/hour
- [ ] Cold start < 5s

### Business Quality
- [ ] DAU/MAU > 0.3
- [ ] Avg session > 15 minutes
- [ ] Multiplayer retention > 40%
- [ ] Store rating > 4.0

---

## Comparison: Fork vs Extract

| Metric | Extract from Freeciv | Fork from Freeciv21 |
|--------|---------------------|---------------------|
| **Timeline** | 15 months | 12 months |
| **Engine Work** | 4 months extraction | 0 months (done!) |
| **Risk Level** | High (extraction complexity) | Medium (integration focus) |
| **Team Size** | 5 developers | 4 developers |
| **Upstream Sync** | None | Can merge improvements |
| **Code Quality** | Unknown (new extraction) | Proven (Freeciv21 tested) |

**Savings:** 3 months, 1 developer FTE, lower risk
