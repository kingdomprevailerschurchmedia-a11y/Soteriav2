# Remote Config Catalog — Soteria

This catalog documents all parameters available via Firebase Remote Config for dynamic app control.

## 1. Gameplay Parameters

| Key | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `gameplay_default_timer` | `int` | `15` | Default duration for a question in seconds. |
| `gameplay_min_timer` | `int` | `5` | Minimum allowed timer duration. |
| `gameplay_max_timer` | `int` | `60` | Maximum allowed timer duration. |
| `gameplay_transition_delay`| `double`| `1.5` | Seconds between questions. |
| `gameplay_points_per_correct`| `int` | `100`| Base points for a correct answer. |
| `gameplay_wrong_penalty` | `int` | `25` | Points deducted for a wrong answer. |
| `gameplay_streak_bonus` | `int` | `10` | Additional points per streak level. |
| `gameplay_perfect_round_bonus`| `int` | `500` | Bonus for 100% accuracy in a session. |

## 2. Feature Flags

| Key | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `feature_enable_practice` | `bool` | `true` | Enable Practice Mode accessibility. |
| `feature_enable_pro_mode` | `bool` | `false` | Enable competitive Pro Mode. |
| `feature_enable_tournament` | `bool` | `false` | Enable global Tournament access. |
| `feature_enable_versus` | `bool` | `false` | Enable 1v1 Versus matchmaking. |
| `feature_enable_marketplace`| `bool` | `false` | Enable Avatar/Frame store. |
| `feature_enable_ai_coach` | `bool` | `false` | Enable AI Learning Insights. |
| `feature_enable_premium` | `bool` | `false` | Enable subscription check/UI. |

## 3. Rewards & Economy

| Key | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `reward_daily_free_games` | `int` | `5` | Free Pro Mode games per day for guest/standard. |
| `reward_practice_xp_mult` | `double`| `1.0` | XP multiplier for Practice sessions. |
| `reward_tournament_xp_mult`| `double`| `2.5` | XP multiplier for Tournament sessions. |
| `reward_leaderboard_refresh`| `int` | `300` | Leaderboard refresh interval (seconds). |

## 4. Maintenance & Safety

| Key | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `maintenance_enabled` | `bool` | `false` | Globally disable app access for maintenance. |
| `maintenance_message` | `string` | `"Soteria is..."`| Message shown during maintenance. |
| `maintenance_min_version` | `string` | `"1.0.0"` | Minimum required app version. |
| `maintenance_force_upgrade`| `bool` | `false` | Redirect to App Store if version mismatch. |

## Rollout Strategy
- **New Features**: Always start with `false` and rollout to specific user percentages or regions.
- **Balancing**: Adjust `points_per_correct` live based on economy health.
