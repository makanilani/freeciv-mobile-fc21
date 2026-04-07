# Milestones & Releases

## Overview

| Milestone | Target | Status | Key Deliverables |
|-----------|--------|--------|-----------------|
| M1: Foundation | Month 1 | 🔄 In Progress | Repo, CI, Architecture |
| M2: Engine Core | Month 5 | ⏳ Planned | Full game logic |
| M3: Mobile UI | Month 7 | ⏳ Planned | Render, controls |
| M4: Integration | Month 9 | ⏳ Planned | Playable MVP |
| M5: Multiplayer | Month 12 | ⏳ Planned | Online play |
| M6: Launch | Month 15 | ⏳ Planned | App Store |

---

## M1: Foundation (Month 1)

**Goal:** Establish project infrastructure and finalize architecture.

### Deliverables

- [ ] Project repository with structure
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Build system functional (CMake)
- [ ] Architecture documentation approved
- [ ] Team onboarded

### Exit Criteria

```
✓ Can build empty shell for iOS and Android
✓ All team members can run dev builds
✓ Architecture approved by all stakeholders
✓ Decision log complete
```

---

## M2: Engine Core (Month 5)

**Goal:** Extract and refactor Freeciv game logic into standalone engine.

### Deliverables

- [ ] Map/Terrain system
- [ ] Unit system (movement, combat)
- [ ] City system (production, growth)
- [ ] Player/Government system
- [ ] Technology tree
- [ ] AI core (unit AI, city AI, strategy)
- [ ] Ruleset loader
- [ ] Save/Load system

### Exit Criteria

```
✓ Engine can simulate complete game
✓ AI plays against itself successfully
✓ Save files created and loaded correctly
✓ Unit tests > 80% coverage
✓ No memory leaks under sustained play
```

---

## M3: Mobile UI (Month 7)

**Goal:** Build rendering and basic UI for both platforms.

### Deliverables

- [ ] OpenGL ES renderer (60 FPS)
- [ ] Touch input system
- [ ] Map gestures (zoom, pan, tap)
- [ ] Unit/City selection
- [ ] Unit action panel
- [ ] City management view
- [ ] Main menu
- [ ] Settings screen

### Exit Criteria

```
✓ Map renders at 60 FPS on target devices
✓ Touch selection responsive (< 100ms)
✓ UI follows design guidelines
✓ Portrait and landscape functional
✓ Haptic feedback working
```

---

## M4: Integration (Month 9)

**Goal:** Connect UI to engine, playable hotseat game.

### Deliverables

- [ ] All unit actions from mobile UI
- [ ] Full city management
- [ ] Turn progression
- [ ] AI vs Human gameplay
- [ ] Hotseat 2+ players
- [ ] Tutorial (optional)

### Exit Criteria

```
✓ All Freeciv actions possible
✓ Turn flow intuitive
✓ No action dead-ends
✓ AI provides reasonable challenge
✓ 3 full playthroughs without crash
```

---

## M5: Multiplayer (Month 12)

**Goal:** Enable online multiplayer.

### Deliverables

- [ ] Game server
- [ ] User authentication
- [ ] Game lobby
- [ ] Async turn sync
- [ ] Push notifications
- [ ] Real-time mode (optional)

### Exit Criteria

```
✓ Complete async game with 2+ players
✓ No desyncs or state corruption
✓ Notifications reliable
✓ Server handles 1000 concurrent games
✓ < 1% action failure rate
```

---

## M6: Launch (Month 15)

**Goal:** App Store and Play Store release.

### Deliverables

- [ ] Performance optimized
- [ ] Bug-free (< 0.1% crash rate)
- [ ] App Store assets
- [ ] Store listings
- [ ] Privacy policy
- [ ] Support channels

### Exit Criteria

```
✓ 60 FPS on iPhone 12 / Pixel 5
✓ Crash-free sessions > 99%
✓ Tutorial completion > 70%
✓ Store rating > 4.0 at launch
✓ < 100MB download size
✓ No critical bugs first week
```

---

## Release Schedule

```
2026-05-05  M1: Foundation ✓
2026-09-05  M2: Engine Core
2026-11-05  M3: Mobile UI
2027-01-05  M4: Integration
2027-04-05  M5: Multiplayer
2027-07-05  M6: Launch
```

---

## Version Plan

| Version | When | Content |
|---------|------|---------|
| 0.1.0 | M2 | Engine-only test binary |
| 0.5.0 | M3 | UI prototype |
| 0.8.0 | M4 | Hotseat MVP |
| 1.0.0 | M5 | Async multiplayer |
| 1.1.0 | M6+ | Real-time, polish |

---

## Changelog

| Date | Version | Changes |
|------|---------|---------|
| 2026-04-05 | - | Project initialized |
