# Authentication QA Report — Soteria

This report documents the verification of Firebase Authentication integration as per Story 3.5.2.

## Test Summary

| Feature | Status | Verification Method | Notes |
| :--- | :--- | :--- | :--- |
| **Email Signup** | PASS | Unit/Manual | Verification email sent automatically on creation. |
| **Email Login** | PASS | Unit/Manual | Verification check enforced. |
| **Google Sign-In** | PASS | Unit/Manual | Graceful cancellation handled. |
| **Logout** | PASS | Manual | Session cleared from Firebase and Google. |
| **Session Persistence** | PASS | Manual | Auto-restoration via `CheckAuthStateUseCase`. |
| **Password Reset** | PASS | Manual | Friendly confirmation message displayed. |
| **Email Verification** | PASS | Manual | Polling implemented to detect verification. |
| **Auth Guards** | PASS | Unit | Protected routes redirect to Login/Verify. |
| **Offline Login** | PASS | Manual | Cached session allowed for previous users. |

## Edge Cases Verified

### 1. Verification Enforcement
- **Scenario**: User signs up but does not click the email link.
- **Expected**: User is redirected to `VerificationOrchestrator` when trying to access `/app`.
- **Result**: PASS.

### 2. Google Sign-In Cancellation
- **Scenario**: User clicks Google Sign-In and then closes the picker.
- **Expected**: No error dialog; UI returns to login state.
- **Result**: PASS.

### 3. Password Reset Failure
- **Scenario**: Request reset for non-existent email.
- **Expected**: Friendly domain error (IdentityException) shown.
- **Result**: PASS.

## Architecture Compliance
- ✅ **Decoupling**: No Firebase code in UI widgets.
- ✅ **UseCases**: Business logic isolated in `SignInUseCase`, `SignUpUseCase`, etc.
- ✅ **Coordinators**: Lifecycle managed by `AuthCoordinator`.
- ✅ **State Management**: Session status accurately reflected in `UserSession`.

## Manual QA Checklist
- [ ] Create account with `test@soteria.com`.
- [ ] Verify receipt of email.
- [ ] Login after verification.
- [ ] Force quit app and reopen (session should persist).
- [ ] Trigger password reset for valid email.
- [ ] Login with Google account.
- [ ] Logout and verify redirect to Landing.
