# Product Backlog

## Quick Links

- [Sprint Board](#sprint-board) - Active sprint
- [Icebox](#icebox) - Backlog items
- [Completed](#completed) - Done items

---

## Sprint Board

*Current Sprint: Sprint 1 (Month 1)*

### Sprint Goal
**Foundation Complete** - Project structure, CI/CD, and engine architecture finalized.

| ID | Story | Points | Status | Assignee |
|----|-------|--------|--------|----------|
| SP1-01 | Project repo setup | 2 | TODO | |
| SP1-02 | CI/CD pipeline | 3 | TODO | |
| SP1-03 | Engine directory structure | 5 | TODO | |
| SP1-04 | Freeciv codebase audit | 8 | TODO | |
| SP1-05 | Architecture doc review | 3 | TODO | |
| SP1-06 | Build system (CMake) | 5 | TODO | |

---

## Icebox

### Priority 1 - MVP Core

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| CORE-01 | Map terrain system | Extract terrain types, tile data | 8 | SP1-03 |
| CORE-02 | Unit system | Unit creation, movement, combat | 13 | CORE-01 |
| CORE-03 | City system | City building, growth, production | 13 | CORE-01 |
| CORE-04 | Player management | Nations, governments, diplomacy | 8 | None |
| CORE-05 | Tech tree | Research, prerequisites, effects | 8 | CORE-04 |
| CORE-06 | Turn processor | Turn cycle, phase management | 5 | CORE-02, CORE-03 |
| CORE-07 | Victory conditions | Conquest, space race, score | 5 | CORE-06 |
| CORE-08 | Save/Load | SQLite-based save format | 8 | CORE-06 |

### Priority 2 - AI

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| AI-01 | Pathfinding | A* implementation with turn cost | 8 | CORE-01 |
| AI-02 | Unit AI | Unit decision making | 13 | AI-01, CORE-02 |
| AI-03 | City AI | Production advisor | 8 | CORE-03, AI-01 |
| AI-04 | Strategy AI | Long-term planning | 13 | AI-02, AI-03 |
| AI-05 | AI vs AI | Self-play for testing | 3 | AI-04 |

### Priority 3 - Ruleset

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| RULESET-01 | Schema design | JSON schema for rulesets | 5 | None |
| RULESET-02 | Loader | Ruleset parsing and validation | 8 | RULESET-01 |
| RULESET-03 | civ2civ3 port | Port default ruleset | 8 | RULESET-02 |
| RULESET-04 | Effects system | Building/tech effects | 13 | RULESET-02 |

### Priority 4 - Mobile UI

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| UI-01 | OpenGL setup | Basic GL context | 5 | None |
| UI-02 | Tile renderer | Basic isometric tiles | 8 | UI-01 |
| UI-03 | Camera controls | Zoom, pan, gestures | 5 | UI-02 |
| UI-04 | Selection system | Tap to select | 5 | UI-03 |
| UI-05 | Unit panel | Show unit info, actions | 5 | UI-04 |
| UI-06 | City view | City management modal | 8 | UI-04 |
| UI-07 | Turn UI | End turn, status bar | 3 | UI-05 |
| UI-08 | Menu screens | Main menu, settings | 5 | None |

### Priority 5 - Integration

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| INT-01 | Engine-UI bridge | Connect engine to UI | 8 | CORE-06, UI-04 |
| INT-02 | Hotseat play | 2+ players local | 5 | INT-01 |
| INT-03 | Action targeting | Movement, attack UI | 8 | INT-01 |
| INT-04 | AI turns | Show AI thinking | 3 | AI-04, INT-02 |

### Priority 6 - Multiplayer (Post-MVP)

| ID | Title | Description | Points | Dependencies |
|----|-------|-------------|--------|--------------|
| MP-01 | Backend server | Game state authority | 13 | INT-02 |
| MP-02 | Auth system | User accounts | 8 | MP-01 |
| MP-03 | Lobby | Game room management | 8 | MP-02 |
| MP-04 | Async sync | Turn-based sync | 13 | MP-01 |
| MP-05 | Notifications | Push for turns | 5 | MP-04 |

---

## Completed

| ID | Title | Completed | Notes |
|----|-------|-----------|-------|
| - | Initial documentation | 2026-04-05 | README, Architecture, Roadmap, Scope |
| - | Technical decisions | 2026-04-05 | ADRs 001-009 |
| - | UX guidelines | 2026-04-05 | Mobile UX patterns |
| - | Code organization | 2026-04-05 | Directory structure |

---

## Icebox (Future Ideas)

*Lower priority items that might be valuable later*

| ID | Title | Description | Value |
|----|-------|-------------|-------|
| FUTURE-01 | Tutorial mode | Interactive first-time tutorial | High |
| FUTURE-02 | Sound effects | Audio feedback | Medium |
| FUTURE-03 | Music | Background music | Medium |
| FUTURE-04 | Replays | Watch completed games | Low |
| FUTURE-05 | Mod support | Lua scripting | High |
| FUTURE-06 | Real-time mode | Live multiplayer | High |
| FUTURE-07 | Spectator mode | Watch live games | Low |
| FUTURE-08 | Achievements | Unlockable goals | Medium |
| FUTURE-09 | Leaderboards | Competitive rankings | Medium |
| FUTURE-10 | Cloud saves | Cross-device sync | High |

---

## Estimation Guidelines

| Points | Complexity | Description |
|--------|------------|-------------|
| 1 | Trivial | Simple fix, single file |
| 2 | Easy | Small feature, no unknowns |
| 3 | Medium | Standard feature, clear path |
| 5 | Complex | Multi-file, some uncertainty |
| 8 | Hard | Significant complexity, research |
| 13 | Epic | Major feature, many unknowns |

---

## Definition of Done

- [ ] Code written and compiles
- [ ] Unit tests added (if applicable)
- [ ] No memory leaks (sanitized)
- [ ] Follows coding standards
- [ ] PR reviewed and merged
- [ ] Documentation updated
