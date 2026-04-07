# Mobile UX Design Guidelines

## Design Principles

### 1. Strategic Depth, Mobile Simplicity

> "Freeciv's complexity should feel optional, not overwhelming."

- Show essential information by default
- Hide advanced options behind expandable sections
- Progressive disclosure of depth

### 2. Touch-First, Not Touch-Only

- Large touch targets (min 44pt)
- Swipe gestures for common actions
- Avoid edge-of-screen interactions
- Support both portrait and landscape

### 3. Respect the Player's Time

- Quick actions in < 3 taps
- Obvious End Turn location
- Minimize modal interruptions
- Async-first design

### 4. Consistency Across Platforms

- Same interaction patterns on iOS/Android
- Native feel per platform (iOS: SF, Android: Material)
- Shared iconography and terminology

---

## Screen Layouts

### Main Menu (Portrait)

```
┌────────────────────────┐
│                        │
│      [LOGO]            │
│      Freeciv           │
│                        │
│   ┌──────────────────┐ │
│   │   New Game       │ │
│   └──────────────────┘ │
│   ┌──────────────────┐ │
│   │   Continue       │ │
│   └──────────────────┘ │
│   ┌──────────────────┐ │
│   │   Settings       │ │
│   └──────────────────┘ │
│                        │
│   Version 1.0.0        │
└────────────────────────┘
```

**Design Notes:**
- Large, centered buttons
- Minimal options (no game settings here)
- Last played game highlighted
- Auto-continues from auto-save

### New Game Setup (Portrait)

```
┌────────────────────────┐
│ ← New Game             │
├────────────────────────┤
│ Players          [+]   │
│ ┌────────────────────┐ │
│ │ You (Human)    [👤]│ │
│ │ AI 1          [🤖]│ │
│ │ AI 2          [🤖]│ │
│ └────────────────────┘ │
├────────────────────────┤
│ Difficulty        Easy │
│ ◄━━━━━━━━━━○──────►   │
├────────────────────────┤
│ Map Size         Medium│
│ ◄━━━━━━━○───────────►  │
├────────────────────────┤
│ Ruleset       civ2civ3 │
├────────────────────────┤
│ Nation           Random│
│ ◄━━━○───────────────►  │
├────────────────────────┤
│                        │
│   [  START GAME  ]     │
│                        │
└────────────────────────┘
```

**Design Notes:**
- Stepper controls for numeric options
- Scrollable for many AI players
- Nation selector with previews

### Game Screen (Portrait)

```
┌────────────────────────┐
│ 🌎 T12  ⚔️ +3  💰50   │ ← Status bar
├────────────────────────┤
│                        │
│                        │
│      [MAP VIEW]        │
│                        │
│                        │
│                        │
├────────────────────────┤
│ ┌────┐  ┌────────────┐ │
│ │unit│  │ CITY INFO  │ │ ← Context panel
│ │info│  │  L:3 H:12  │ │    (when selected)
│ └────┘  └────────────┘ │
├────────────────────────┤
│ [🏠] [⚙️]    [🔄END]  │ ← Action bar
└────────────────────────┘
```

**Design Notes:**
- Status bar: Turn, combat indicator, gold
- Map is primary (80%+ of screen)
- Context panel slides up when needed
- End Turn always visible, prominent

### Game Screen (Landscape)

```
┌────────────────────────────────────────┐
│ 🌎T12 ⚔️+3 💰50 │ [🏠][📊][⚙️]        │
├────────────────┬───────────────────────┤
│                │  Unit: Warriors       │
│                │  HP: 3/3              │
│   [MAP VIEW]   │  Move: 2/2           │
│                ├───────────────────────┤
│                │  [MOVE] [ATTACK]     │
│                │  [FORTIFY] [DISBAND] │
├────────────────┴───────────────────────┤
│        [  🔄 END TURN  ]              │
└───────────────────────────────────────┘
```

**Design Notes:**
- Side panel for selection details
- Wider map view
- All actions visible without scrolling

### City View (Modal Sheet)

```
┌────────────────────────┐
│ ≡  Rome         [X]   │
├────────────────────────┤
│ 💰 25 │ 🍖 8 │ 📈 +3 │
├────────────────────────┤
│ [Production] [Citizens]│
│ [Buildings]  [Raze]    │
├────────────────────────┤
│ ┌────────────────────┐ │
│ │  Building: Granary │ │
│ │  Progress: ████░░  │ │
│ └────────────────────┘ │
│                        │
│ Choose Production:     │
│ ┌────────────────────┐ │
│ │ ⚔️ Swordsmen (10)  │ │
│ │ 🛡️ Warriors  (8)   │ │
│ │ 🏛️ Temple    (12)  │ │
│ └────────────────────┘ │
└────────────────────────┘
```

**Design Notes:**
- Bottom sheet pattern
- Tab navigation for sections
- Clear production progress
- Tap to change production

### Unit Action Sheet

```
┌────────────────────────┐
│ ┌────┐ Warrior (1/1)    │
│ │ 👤 │ at (12, 34)      │
│ └────┘ HP: 3/3 Mov: 1/2│
├────────────────────────┤
│                        │
│  ┌────────┐ ┌────────┐ │
│  │  MOVE  │ │ ATTACK │ │
│  │   →    │ │   ⚔️   │ │
│  └────────┘ └────────┘ │
│                        │
│  ┌────────┐ ┌────────┐ │
│  │FORTIFY │ │ GOTO   │ │
│  │   🛡️   │ │   🎯   │ │
│  └────────┘ └────────┘ │
│                        │
│  ┌────────────────┐    │
│  │    DISBAND     │    │
│  └────────────────┘    │
└────────────────────────┘
```

**Design Notes:**
- Large icon buttons
- Disabled actions grayed out
- Contextual actions based on unit type

---

## Interaction Patterns

### Map Gestures

| Gesture | Action | Feedback |
|---------|--------|----------|
| Single tap | Select tile/unit/city | Highlight + panel |
| Double tap | Quick attack (if enemy) | Attack animation |
| Long press | Context menu | Haptic + menu |
| Pinch | Zoom | Smooth zoom |
| Two-finger drag | Pan (alternative) | Map follows |
| Fling | Fast pan | Momentum scrolling |

### Selection Flow

```
Tap tile
  │
  ├─► Empty land → Show terrain info
  │
  ├─► Own unit → Unit panel + action buttons
  │
  ├─► Own city → City modal sheet
  │
  ├─► Enemy unit → Enemy info (strength, type)
  │               + Attack button if in range
  │
  └─► Enemy city → City info (name, size, production)
```

### Turn Flow

```
┌─────────────────────────────────┐
│ 1. Review units                 │
│    └─ Move units, attack        │
│                                 │
│ 2. Manage cities                │
│    └─ Change production         │
│    └─ Set city focus            │
│                                 │
│ 3. Research tech (if needed)    │
│    └─ Tap research indicator    │
│                                 │
│ 4. End Turn                     │
│    └─ Tap END TURN button       │
│                                 │
│ 5. Watch animations             │
│    └─ Combat, movement          │
│                                 │
│ 6. Repeat                        │
└─────────────────────────────────┘
```

---

## Information Hierarchy

### What to Show (Always)

- Current turn number
- Selected unit/city name
- HP for units
- Production for cities
- Movement points
- End Turn button

### What to Show (When Relevant)

- Attack/defense strength
- Production progress
- Resource income
- Tech research progress
- Visibility status (fog)
- Unit queue

### What to Hide (Accessible)

- Full stats (tap to expand)
- Advanced actions (long press)
- Strategy hints (settings toggle)
- Debug info (dev mode only)

---

## Color System

### Base Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Primary | `#2563EB` | Buttons, highlights |
| Secondary | `#64748B` | Secondary actions |
| Success | `#16A34A` | Positive indicators |
| Warning | `#EA580C` | Warnings, alerts |
| Danger | `#DC2626` | Destructive actions |
| Surface | `#FFFFFF` | Cards, panels |
| Background | `#F8FAFC` | Screen backgrounds |
| Text Primary | `#0F172A` | Main text |
| Text Secondary | `#64748B` | Descriptions |

### Game-Specific Colors

| Element | Hex | Usage |
|---------|-----|-------|
| Land | `#8BB174` | Plains terrain |
| Ocean | `#3B82F6` | Sea terrain |
| Desert | `#EAB308` | Desert terrain |
| Mountains | `#6B7280` | Mountain terrain |
| Forest | `#22C55E` | Forest terrain |
| Selected | `#FBBF24` | Selection highlight |
| Enemy | `#EF4444` | Enemy units/cities |
| Neutral | `#A1A1AA` | Neutral players |

---

## Typography

### Font Stack

```
iOS:    SF Pro → SF Pro Display → System
Android: Roboto → Noto Sans → System
```

### Type Scale

| Style | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| H1 | 28pt | Bold | 34pt | Screen titles |
| H2 | 22pt | Semibold | 28pt | Section headers |
| H3 | 18pt | Medium | 24pt | Card titles |
| Body | 16pt | Regular | 22pt | Main content |
| Caption | 14pt | Regular | 18pt | Secondary info |
| Label | 12pt | Medium | 16pt | Tags, badges |

### Game-Specific

| Element | Size | Notes |
|---------|------|-------|
| Turn number | 20pt bold | Always visible |
| Unit stats | 14pt | In selection panel |
| City name | 18pt bold | On city marker |
| Map labels | 12pt | Optional overlay |

---

## Component Specifications

### Buttons

| Size | Height | Min Width | Corner Radius | Touch Target |
|------|--------|-----------|---------------|--------------|
| Large | 56pt | 120pt | 12pt | Yes |
| Medium | 48pt | 88pt | 10pt | Yes |
| Small | 36pt | 64pt | 8pt | Yes |

**States:**
- Default: Primary color, white text
- Pressed: 10% darker, scale 0.98
- Disabled: 50% opacity
- Loading: Spinner overlay

### Cards

- Corner radius: 16pt
- Shadow: `0 2px 8px rgba(0,0,0,0.1)`
- Padding: 16pt
- Background: Surface color

### Touch Targets

```
Minimum: 44pt × 44pt
Preferred: 48pt × 48pt
Icons with labels: Icon 24pt + 16pt text + 4pt spacing
```

---

## Animations

### Standard Durations

| Animation | Duration | Curve |
|-----------|----------|-------|
| Tap feedback | 100ms | ease-out |
| Panel slide | 300ms | ease-in-out |
| Map zoom | 200ms | ease-out |
| Unit move | 400ms | linear |
| Combat | 600ms | ease-in-out |
| Turn transition | 800ms | ease-in-out |

### Animation Principles

1. **Functional first** - Animations guide, not distract
2. **Fast** - No animation > 1 second
3. **Interruptible** - Can skip/end early
4. **Consistent** - Same action = same animation

---

## Accessibility

### Requirements

| Feature | Implementation |
|---------|----------------|
| VoiceOver/TalkBack | Semantic labels on all elements |
| Dynamic Type | Scales with system setting |
| Reduce Motion | Disables animations |
| Color blind | Icons + color, not color alone |
| Minimum contrast | 4.5:1 for text |

### Screen Reader Labels

```swift
// iOS example
Button("Move Unit") {
    moveUnit()
}
.accessibilityLabel("Move selected warrior to target tile")
.accessibilityHint("Double tap to execute move")

// Android example
Button(onClick = { moveUnit() }) {
    Text("Move Unit")
}
.contentDescription("Move selected warrior to target tile")
}

### Keyboard Navigation (Tablet)

- D-pad for unit movement
- Enter for select/confirm
- Back for cancel
- Tab for next unit
```

---

## Error States

### Network Error

```
┌────────────────────────┐
│     ⚠️ Connection Lost  │
│                        │
│  Your turn couldn't be │
│  sent. Will retry...   │
│                        │
│  ┌──────────────────┐  │
│  │   Retry Now      │  │
│  └──────────────────┘  │
│                        │
│  [Save & Quit]         │
└────────────────────────┘
```

### Invalid Action

```
┌────────────────────────┐
│   ❌ Action Failed     │
│                        │
│   Unit has no movement │
│   points remaining.    │
│                        │
│   [OK]                 │
└────────────────────────┘
```

---

## Loading States

### Turn Processing

```
┌────────────────────────┐
│                        │
│     Processing Turn... │
│                        │
│  ✓ Cities produced     │
│  ✓ Units moved         │
│  → Combat pending...   │
│                        │
│     ████████░░ 80%     │
│                        │
└────────────────────────┘
```

---

## Responsive Breakpoints

| Device | Width | Layout |
|--------|-------|--------|
| Phone Portrait | < 428pt | Single column |
| Phone Landscape | 428-926pt | Side panel |
| Tablet Portrait | 768-1024pt | Expanded panels |
| Tablet Landscape | > 1024pt | Multi-panel |
