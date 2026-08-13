# Competitive Rank System

Soteria uses a unified, server-authoritative rank system to provide a consistent and motivating competitive experience.

## Architecture

The system is built on a single source of truth:

1.  **Rank Configuration**: Centralized tier and division definitions in `ProgressionConfig` and `RankingConfig`.
2.  **Ranking Engine**: `CompetitiveRankingEngine` authoritatively calculates rank from points, determines progress, and handles ordering.
3.  **Rank Progress Model**: `RankProgress` exposes all derived data (percentage, next rank, RP to next) for consistent UI rendering.

## Rank Hierarchy

- **Tier**: Major competitive brackets (Bronze, Silver, Gold, etc.).
- **Division**: Sub-brackets within a tier (III, II, I). Lower number is higher rank.
- **Rank Points (RP)**: The numeric value that determines tier and division.

## Components

### CompetitiveRankBadge
High-fidelity representation of the player's rank. Supports multiple sizes and optional glow for elite tiers.

### RankProgressBar
Authoritative progress visualization. Handles:
- **Clamping**: Always between 0.0 and 1.0.
- **Semantics**: Full accessibility labels for screen readers.
- **Boundary States**: Explicit "Unranked" and "Max Rank" handling.

### CompetitiveRankCard
The standard premium card for displaying rank on Dashboard and Profile. Links directly to the Rank Overview.

## Edge Cases

- **Unranked**: Players with < 100 RP. Progress shows distance to Bronze III.
- **Elite (Max Rank)**: The highest possible tier. Progress is fixed at 100%. "Next Rank" is hidden.
- **Unknown Rank**: Handled gracefully via safe fallbacks and logging.

## Verification

### Logic Tests
`test/features/player/rank_logic_test.dart` verifies:
- Mathematical correctness of progress percentage.
- Correct threshold boundaries.
- Authoritative rank ordering.

### Preview Gallery
Fixtures for all states are available in the **Rank Progression Polish** preview item.
