# Session Initialization Flow

```mermaid
sequenceDiagram
    participant P as Player
    participant L as PracticeLobby (UI)
    participant N as LobbyNotifier (State)
    participant V as SessionValidator
    participant R as PracticeRepository
    participant F as Firestore

    P->>L: Selects Category & Difficulty
    L->>N: Update Config
    N->>V: validate(config, profile)
    V-->>N: validationStatus
    N-->>L: Update UI (Summary & Start Button)

    P->>L: Taps START PRACTICE
    L->>N: startSession()
    activate N
    N->>R: createSession(session)
    R->>F: setDoc(/practice_sessions/id)
    F-->>R: success
    R-->>N: success
    deactivate N
    N-->>L: sessionReady
    L->>P: Navigates to Game Screen
```

## Error Handling
- **Network Failure**: Session metadata is stored with Firestore offline persistence enabled; the game can proceed if questions are cached.
- **Validation Failure**: The "START" button is disabled and a clear error message is displayed (e.g., "Level 10 required").
