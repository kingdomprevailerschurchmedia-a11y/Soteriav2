# Dashboard Component Catalog — Soteria

This document catalogs the reusable components used to build the Soteria Premium Home Dashboard.

## 1. DashboardHeader
- **Purpose**: Displays player greeting, identity, and mini-stats.
- **Inputs**: `greeting`, `playerName`, `level`, `streak`, `avatarUrl`.
- **Motion**: Slide-left entrance for identity; scale-in for stats.

## 2. HeroCard
- **Purpose**: Main progression overview with animated progress ring.
- **Inputs**: `level`, `xp`, `totalXpRequired`, `coins`, `rank`.
- **Design**: Glassmorphism surface with premium gold accents.
- **Future**: Support for "Double XP" or "Event" overlays.

## 3. QuickActionsGrid
- **Purpose**: Fast entry points into primary game modes.
- **Components**: `ActionCard` (staggered scaling entrance).
- **Design**: Multi-gradient borders and glass backgrounds.

## 4. DailyChallengeCard
- **Purpose**: Encourages daily engagement via rewards.
- **Inputs**: `title`, `description`, `xpReward`, `progress`.
- **Interaction**: Direct "Start" button for the specific challenge.

## 5. StatsGrid
- **Purpose**: Low-priority detailed performance overview.
- **Inputs**: `questionsAnswered`, `accuracy`, `gamesPlayed`, `highestStreak`.
- **Design**: Compact glass tiles with soft semantic coloring.

## 6. AchievementCarousel
- **Purpose**: Horizontal showcase of recent player trophies.
- **States**: Locked (desaturated) / Unlocked (gold glowing).

## 7. LeaderboardPreview
- **Purpose**: Social proof and competitive drive.
- **Design**: Integrated list with distinct styling for the "Current Player" row.

## 8. DashboardSkeleton
- **Purpose**: Shimmer placeholder used during initial Firebase data fetch.
- **Constraint**: Must match the aspect ratios of the final loaded widgets to prevent layout shift.

## 9. SoteriaBottomNavBar
- **Purpose**: App-wide floating navigation anchor.
- **Design**: Offset glass container with haptic-ready touch targets.
