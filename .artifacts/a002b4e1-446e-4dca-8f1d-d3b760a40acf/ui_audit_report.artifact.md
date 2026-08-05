# UI Audit Report - Soteria

This report provides a comprehensive evaluation of the current user interface, identifying inconsistencies, technical debt, and opportunities for design standardization before embarking on the redesign and the creation of the Developer Preview Gallery.

## 1. Design Inconsistencies

### Colors & Gradients
- **Observation**: While `SoteriaColors` is centralized, functional colors (like `cyanAccent` for event badges) are occasionally hardcoded in local widgets.
- **Issue**: Lack of a unified "event" or "status" color palette beyond the basic primary/gold/error/success.
- **Impact**: Inconsistent branding when new features are added.

### Spacing & Layout
- **Observation**: `SoteriaSpacing` is used, but implementation varies. Some screens use `Padding` widgets, others use `Sizedbox`, and some rely on internal widget padding.
- **Issue**: Vertical rhythm is inconsistent across the dashboard and login screens.
- **Impact**: The app feels slightly disjointed during scrolling.

### Typography
- **Observation**: The `SoteriaTypographyExtension` is powerful, but not all widgets leverage it consistently. Some still use direct `TextStyle` constructor calls.
- **Issue**: Letter spacing and line height are not standardized across all display and title styles.
- **Impact**: Reading experience is uneven.

## 2. Component Duplication

- **Badges/Chips**: Similar badge-like widgets (e.g., `_CoinsDisplay`, `_EventBadge`, `LifelineButton`) are implemented locally within screens.
- **Cards**: Multiple "card" implementations exist (e.g., `HeroCard`, `DailyChallengeCard`, `AnnouncementCard`) with slightly different shadow and border treatments.
- **Inputs**: `LoginForm` and other screens might re-implement input decorations instead of using a single `SoteriaTextField`.

## 3. Animation Issues

- **Inconsistency**: Some screens use `SoteriaSlideUp`, while others use standard `AnimatedSwitcher` or no entrance animations.
- **Lack of Choreography**: Elements often appear all at once or without a unified staggered entrance curve.
- **Performance**: Heavy use of `GlassSurface` without `RepaintBoundary` on static sections might impact frame rates during complex transitions.

## 4. Accessibility & Responsiveness

- **Semantics**: Most custom widgets lack explicit `Semantics` labels, making screen reading difficult for complex cards like the `HeroCard`.
- **Touch Targets**: Some icons and text-only buttons have small hit areas (<48px).
- **Tablet/Landscape**: Layouts primarily focus on portrait phone views. Many sliver-based screens will feel overly wide and sparse on tablets without multi-column support.

## 5. Technical Debt

- **Hardcoded Values**: Border radius (e.g., `32`, `16`) and blur values are occasionally hardcoded instead of using `SoteriaRadius` or `SoteriaBlur`.
- **Scaffold Proliferation**: Different screens use different Scaffold wrappers (`SafeGradientScaffold`, `SoteriaPage`, standard `Scaffold`).
- **Mock Data**: No unified mock data layer, making it hard to develop UI in isolation without the full app state.

---

## 6. Prioritized Recommendations

> [!IMPORTANT]
> **1. Centralize Design Tokens**: Move all hardcoded radius, blur, shadow, and duration values into `core/design_system`.
>
> **2. Component Standardization**: Create a unified `SoteriaCard`, `SoteriaBadge`, and `SoteriaButton` set that supports all current use cases.
>
> **3. Unified Page Wrapper**: Standardize on a single "Shell" that handles background, state (Loading/Error/Offline), and basic accessibility.
>
> **4. Responsive Grid System**: Implement a flex-based or grid-based layout system that adapts to screen width.
>
> **5. Animation Framework**: Define 3-4 standard animation types (Entrance, Success, Failure, Transition) and apply them globally.
