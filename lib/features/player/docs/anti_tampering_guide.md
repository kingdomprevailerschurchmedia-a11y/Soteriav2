# Anti-Tampering & Data Integrity Guide — Soteria

Soteria employs a defense-in-depth strategy to protect player progression and ensure fair competition.

## 1. Principle of Least Privilege
The Firestore security rules follow a "Deny by Default" policy. No operation is permitted unless explicitly granted in `firestore.rules`.

## 2. Server-Authoritative Progression
Sensitive fields (XP, Coins, Level, Achievements) are marked as **Server Only** in the Security Ownership Matrix.
- **Current State**: Security rules block all client-side writes to these fields.
- **Future State**: Cloud Functions will intercept gameplay completion events, validate the results, and update these fields.

## 3. Defense Against Privilege Escalation
The `role` field is protected by `isAdmin()` and `isModerator()` checks.
- A client cannot update their own role.
- Even if a user attempts to "Bootstrap" a new account with `role: 'admin'`, the security rules enforce `request.resource.data.role == 'user'` during the `create` operation.

## 4. Input Validation
All client-writable fields are subject to validation:
- `displayName`: Must be a string with a maximum length.
- `settings`: Must be a valid map structure.
- `lastLogin`: Must be a valid timestamp.

## 5. App Check Integration
Soteria is prepared for **Firebase App Check**. This will ensure that only requests originating from an authentic, untampered version of the Soteria app can access Firestore, effectively blocking botting and unauthorized API access.

## 6. Audit Logging
Every sensitive change (eventually via Cloud Functions) is logged, allowing for retroactive abuse detection and account recovery.
