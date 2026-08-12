# Fix Google Sign-In Build Errors (v7.2.0 Migration)

The project is using `google_sign_in: ^7.2.0`, which introduced breaking changes compared to older versions. Specifically, the `GoogleSignIn` class now uses a singleton pattern, requires initialization, and has renamed the `signIn()` method to `authenticate()`.

## Proposed Changes

### Auth Feature

#### [MODIFY] [auth_providers.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/features/auth/providers/auth_providers.dart)
- Update `googleSignInProvider` to use `GoogleSignIn.instance` instead of the constructor.
- Remove the hardcoded `serverClientId` from the provider (it will be moved to the initialization step).

#### [MODIFY] [auth_data_source.dart](file:///C:/Users/GiftOgbonna/Joseph Projects/Soteria/lib/core/firebase/data_sources/auth_data_source.dart)
- Update `signInWithGoogle` to call `googleSignIn.initialize()` with the `serverClientId`.
- Change `googleSignIn.signIn()` to `googleSignIn.authenticate()`.
- Remove `dynamic` type workarounds and use proper types.
- Ensure `GoogleSignInException` handling matches the new API.

## Verification Plan

### Automated Tests
- Run `flutter build apk` or `flutter run` to verify that the build succeeds.
- Note: I will use `gradle_build(":app:assembleDebug")` to verify compilation.

### Manual Verification
- The user should test the Google Sign-In flow on a device to ensure the Credential Manager UI appears and authentication works.
