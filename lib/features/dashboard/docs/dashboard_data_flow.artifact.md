# Dashboard Data Flow

```mermaid
graph TD
    subgraph "Data Layer (Firebase)"
        Firestore[(Firestore)]
        Auth[Firebase Auth]
    end

    subgraph "Infrastructure Layer"
        PlayerRepo[FirestorePlayerRepository]
        HomeRepo[FirestoreHomeRepository]
    end

    subgraph "Domain Layer"
        ObserveProfileUC[ObservePlayerProfileUseCase]
        GetProgressionUC[GetProgressionUseCase]
        ProgService[ProgressionService]
    end

    subgraph "Presentation Layer (Riverpod)"
        AuthStream[authStateChangesProvider]
        ProfileStream[currentPlayerStreamProvider]
        ProgProvider[playerProgressionProvider]
        DashNotifier[DashboardNotifier]
    end

    subgraph "UI (Widgets)"
        DashScreen[DashboardScreen]
        HeroWidget[HeroCard]
        HeaderWidget[DashboardHeader]
    end

    Firestore -- Real-time Stream --> PlayerRepo
    Auth -- UID --> AuthStream
    AuthStream -- UID --> ProfileStream
    PlayerRepo -- PlayerProfile --> ProfileStream
    ProfileStream -- PlayerProfile --> ProgProvider
    ProgProvider -- Progression --> HeroWidget
    DashNotifier -- DashboardState --> DashScreen
    ProgService -- Calculations --> GetProgressionUC
    GetProgressionUC -- Progression --> ProgProvider
    HomeRepo -- Announcements/Challenges --> DashNotifier
```

## Flow Description
1. **Authentication**: `authDataSourceProvider` detects the user's UID.
2. **Observation**: `ObservePlayerProfileUseCase` starts a real-time Firestore listener for that UID.
3. **Synchronization**: When Firestore updates, `currentPlayerStreamProvider` emits a new `PlayerProfile`.
4. **Calculations**: `playerProgressionProvider` passes the profile to `GetProgressionUseCase`, which uses `ProgressionService` to calculate Level, XP, and Profile Completion.
5. **Animation**: UI widgets receive the new state and trigger `AnimatedNumericCounter` and `XPProgressIndicator` transitions.
6. **Offline**: If the network fails, Firestore returns cached data via the same stream, and the `sessionProvider` flags `isOffline`, showing the dashboard indicator.
