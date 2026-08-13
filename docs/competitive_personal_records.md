# Competitive Personal Records & Career Bests

This system tracks and celebrates a player's best historical performances in Soteria. It distinguishes between all-time Career Bests and Season-specific records.

## Architecture

Personal records are derived from authoritative competitive results processed through the `PersonalRecordService`.

### Data Flow
1. `ProcessCompetitiveResultUseCase` is executed after a match.
2. It records the result and applies progression changes.
3. It invokes `PersonalRecordService.evaluateMatch()`.
4. The service compares the current match performance (score, accuracy, etc.) against existing records in `FirebasePersonalRecordRepository`.
5. If a new record is achieved, it is persisted to Firestore in the `users/{uid}/personal_records` collection.
6. `CompetitiveEventObserver` detects the new record and triggers a notification/celebration.

## Record Types

| Type | Better condition | Mode Specific |
| :--- | :--- | :--- |
| `highestScore` | Higher is better | No (Overall) |
| `bestAccuracy` | Higher is better | No (Overall) |
| `longestWinStreak` | Higher is better | No |
| `mostRankPointsGained`| Higher is better | No |
| `bestRankReached` | Higher tier is better | No |
| `bestLeaderboardPos` | Lower is better | No |
| `bestModeScore` | Higher is better | Yes |

## Storage & ID Generation

Records are stored with deterministic IDs to allow easy replacement and avoid duplicates:
- Career: `career_{type}_{mode?}`
- Season: `season_{seasonId}_{type}_{mode?}`

## Integration

### UI Components
- `PersonalRecordCard`: A premium card displaying record value, improvement, and date.
- `PersonalRecordDetailsSheet`: Shows match evidence and allows navigation to the source match.
- `PersonalRecordsScreen`: The main gallery to view all records.

### Notifications
The system triggers "New Career Best!" notifications for all all-time records.

## Security & Authority
- Client evaluation is for immediate feedback and redundancy.
- Authoritative records should ideally be calculated/verified by Firebase Cloud Functions.
- Users have read-only access to their records via security rules (except for the authorized service account).

## Testing
- Domain tests in `test/features/player/personal_record_service_test.dart` cover comparison logic, idempotency, and out-of-order results.
- UI tests in `test/features/player/personal_records_ui_test.dart` verify the gallery and empty states.
