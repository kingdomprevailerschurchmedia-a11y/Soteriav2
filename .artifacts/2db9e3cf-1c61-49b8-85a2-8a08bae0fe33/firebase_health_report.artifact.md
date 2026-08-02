# Firebase Health Report — Soteria

Detailed status of every integrated Firebase service.

| Service | Status | Integration Level | Notes |
| :--- | :--- | :--- | :--- |
| **Auth** | HEALTHY | Full | Email, Google, Session Persistence, Error Mapping. |
| **Firestore** | HEALTHY | Full | Offline persistence, unified `users` collection, DTO mapping. |
| **Cloud Messaging**| HEALTHY | Core | Token management, Notification Center, Deep-link parsing. |
| **Analytics** | HEALTHY | Full | Type-safe events, automatic screen tracking, standard context. |
| **Crashlytics** | HEALTHY | Full | Global error handlers, breadcrumbs from events, log forwarding. |
| **Performance** | HEALTHY | Core | Automatic startup & network monitoring, custom trace helper. |
| **Remote Config** | HEALTHY | Full | Strongly typed config model, feature flags, fast-start strategy. |
| **App Check** | HEALTHY | Monitoring | Environment-aware providers, token refresh listeners. |

## Feature Status
- **Registration**: Device registration with FCM verified.
- **Bootstrapping**: Automatic profile creation on first login verified.
- **Sync**: Real-time snapshot updates active for player profile.
- **Feature Flags**: 9 active flags ready for dynamic control.
