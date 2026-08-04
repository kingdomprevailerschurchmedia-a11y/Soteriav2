# Soteria Route Catalog

## Navigation Strategy
- **Framework**: GoRouter with Riverpod integration.
- **State Management**: `StatefulShellRoute` for bottom navigation (Tab persistence).
- **Transitions**: Centralized `SoteriaPageTransitions` (Fade, Scale, SlideUp).

## Screen Inventory

### 1. Foundation & Auth
| Route | Path | Guard | Transition | Status |
| :--- | :--- | :--- | :--- | :--- |
| Splash | `/` | None | None | Live |
| Onboarding | `/onboarding` | Uncompleted | Fade | Live |
| Personalization | `/personalization` | Uncompleted | Fade | Live |
| Auth Landing | `/auth` | Unauthenticated | Fade | Live |
| Login | `/auth/login` | Unauthenticated | Fade | Live |

### 2. Main Dashboard (Stateful Shell)
| Route | Path | Branch | Transition | Status |
| :--- | :--- | :--- | :--- | :--- |
| Home | `/app` | `dashboard` | Fade | Live |
| Play | `/app/play` | `play` | Fade | Coming Soon |
| Leaderboard | `/app/leaderboard` | `leaderboard` | Fade | Coming Soon |
| Rewards | `/app/wallet` | `rewards` | Fade | Coming Soon |
| Profile | `/app/profile` | `profile` | Fade | Live (Placeholder) |

### 3. Dashboard Features (Deep Routes)
| Route | Path | Type | Transition | Status |
| :--- | :--- | :--- | :--- | :--- |
| Practice | `/app/practice` | Sub-page | SlideUp | Coming Soon |
| Pro Mode | `/app/pro-mode` | Sub-page | SlideUp | Coming Soon |
| Versus | `/app/versus` | Sub-page | SlideUp | Coming Soon |
| Tournament | `/app/tournament` | Sub-page | SlideUp | Coming Soon |
| Settings | `/app/settings` | Modal Overlay | SlideUp | Live (Functional) |
| Notifications | `/notifications` | Root Modal | Fade | Live |

## Guard Conditions
- `AppStartupState`: Orchestrates boot sequence (Splash -> Onboarding -> Personalization -> Auth -> Ready).
- `SessionStatus`: Ensures protected routes are only accessible by authenticated users.
- `VerificationGuard`: Redirects unverified users to the email verification screen.
