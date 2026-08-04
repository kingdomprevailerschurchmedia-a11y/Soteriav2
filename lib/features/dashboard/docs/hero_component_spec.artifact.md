# Hero Component Design Specification

## Overview
The `HeroCard` is the visual center of the Soteria dashboard, providing immediate feedback on player progression, wealth, and status. It uses a glassmorphic design language to maintain a premium feel while delivering dense information.

## Visual Elements

### 1. Rank & Wealth Header
- **Current Rank**: High-contrast gold typography (`headlineMedium`).
- **Coins Counter**: Animated numeric display with a glowing gold icon.
- **Surface**: Subtle translucency with a 1px white border (10% opacity).

### 2. XP Progression Engine
- **XP Progress Ring**:
  - 90px diameter circular indicator.
  - Soteria Primary color for active progress.
  - Smooth 500ms `easeOutBack` animation.
  - Centered level counter.
- **XP Progress Bar**:
  - Horizontal linear indicator.
  - 600ms `easeOutCubic` animation.
- **XP Details**:
  - Dynamic "Next Unlock" countdown.
  - Previous vs Threshold values with `AnimatedNumericCounter`.

## Interaction & Motion

### Animations
| Element | Duration | Curve | Trigger |
| :--- | :--- | :--- | :--- |
| Card Entrance | 500ms | SlideUp | Initial Load |
| XP Ring | 500ms | EaseOutBack | Data Change |
| XP Bar | 600ms | EaseOutCubic | Data Change |
| Counters | 350ms | EaseOutCubic | Data Change |

### Interaction States
- **Loading**: Represented by `DashboardSkeleton`.
- **Empty**: Default to Level 1, 0 XP, "Scholar" rank.
- **Offline**: Data displayed from Firestore cache with an overlay indicator.

## Future Extension Points

- **Seasonal Themes**: The `GlassSurface` can accept a `gradient` or `backgroundImage` for seasonal events (e.g., Winter Tournament).
- **Double XP Events**: Implemented via the `isDoubleXp` flag, displaying a cyan bolt icon and special badge.
- **Tournament Banners**: Optional slot for active tournament registration status.

## Accessibility
- **Semantics**: The entire card is wrapped in a `Semantics` node describing current level and progress.
- **Contrast**: Maintains a minimum 4.5:1 ratio for all text against the background.
- **Scale**: Supports system font scaling without layout breakage.
