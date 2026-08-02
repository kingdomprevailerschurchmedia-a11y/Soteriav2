# Analytics Event Catalog — Soteria

This catalog documents all custom analytics events tracked within the Soteria application.

## Base Parameters (Attached to every event)
- `session_id`: Unique identifier for the current app session.
- `app_version`: Current version of the app (e.g., 1.0.0).
- `app_build_number`: Current build number.
- `platform`: OS platform (android, ios).
- `is_debug`: Boolean indicating if the build is a debug build.

## Events

| Event Name | Parameters | Trigger Condition |
| :--- | :--- | :--- |
| `app_open` | None | When the application is launched. |
| `screen_view` | `screen_name`, `screen_class` | Automatically tracked on screen transitions. |
| `login` | `method` | Successful user authentication. |
| `sign_up` | `method` | Successful new account creation. |
| `logout` | None | User initiated sign out. |
| `practice_started` | `category_id`, `difficulty` | When a user starts a practice session. |
| `question_answered` | `question_id`, `is_correct`, `response_time_ms` | After a user submits an answer. |
| `achievement_earned`| `achievement_id` | When a new achievement is unlocked. |
| `level_up` | `new_level` | When a player reaches a new level. |
| `notification_opened`| `notification_type`, `action` | When a user taps on a push notification. |

## Future Usage
- **Funnel Analysis**: Track progression from `app_open` -> `practice_started` -> `question_answered`.
- **Retention**: Monitor `app_open` frequency.
- **Engagement**: Analyze `practice_started` by `category_id`.
