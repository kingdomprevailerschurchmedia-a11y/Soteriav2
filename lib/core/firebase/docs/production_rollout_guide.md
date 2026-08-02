# App Check Production Rollout Guide — Soteria

This guide outlines the recommended sequence for enabling Firebase App Check enforcement in the Soteria production environment.

## Phase 1: Integration & Monitoring (Active)
- **Status**: COMPLETED.
- **Actions**:
    - App Check SDK integrated and initialized during bootstrap.
    - `Play Integrity` (Android) and `DeviceCheck/App Attest` (iOS) configured in code.
    - `SecurityStatusScreen` implemented for internal verification.
- **Goal**: Collect metrics in the Firebase Console without blocking any traffic.

## Phase 2: Registration
- **Prerequisites**:
    - Register SHA-256 fingerprints in Firebase for all production keystores.
    - Enable Play Integrity API in the Google Cloud Console.
    - Link Firebase project to the Google Play Store.
- **Verification**: Use the `Security Status` debug screen to ensure `isInitialized` is true on real devices.

## Phase 3: Gradual Enforcement
Enable enforcement in the Firebase Console in the following order, waiting 24-48 hours between steps to monitor metrics.

1.  **Authentication**: Protects against unauthorized account creation and brute-force attempts.
2.  **Cloud Firestore**: Protects player profiles and progression data.
3.  **Firebase Storage**: Secures avatars and downloadable content.
4.  **Cloud Functions**: (Future) Protects authoritative gameplay logic.
5.  **Cloud Messaging**: (Future) Prevents unauthorized notification triggering.

## Phase 4: Full Enforcement
- All Firebase services require a valid App Check token.
- Unsigned requests from non-genuine app instances are rejected at the edge.

## Recovery Strategy
If a bug in App Check blocks legitimate users:
1.  Navigate to the Firebase Console -> App Check.
2.  Disable enforcement for the affected service.
3.  Traffic will resume immediately using standard security rules.
