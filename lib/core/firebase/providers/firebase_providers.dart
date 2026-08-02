import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_interfaces.dart';
import '../services/firebase_services.dart';

// --- Service Implementations ---

final firebaseAuthServiceProvider = Provider<IAuthService>((ref) {
  return FirebaseAuthService();
});

final firestoreDatabaseServiceProvider = Provider<IDatabaseService>((ref) {
  return FirestoreDatabaseService();
});

final firebaseStorageServiceProvider = Provider<IStorageService>((ref) {
  return FirebaseStorageService();
});

final fcmServiceProvider = Provider<IMessagingService>((ref) {
  return FCMService();
});

final remoteConfigServiceProvider = Provider<IRemoteConfigService>((ref) {
  return FirebaseRemoteConfigService();
});

// --- Raw SDK Instances (if needed, though services are preferred) ---

final firebaseAuthProvider = Provider(
  (ref) => ref.watch(firebaseAuthServiceProvider).instance,
);
final firestoreProvider = Provider(
  (ref) => ref.watch(firestoreDatabaseServiceProvider).instance,
);
final storageProvider = Provider(
  (ref) => ref.watch(firebaseStorageServiceProvider).instance,
);
final messagingProvider = Provider(
  (ref) => ref.watch(fcmServiceProvider).instance,
);
final remoteConfigProvider = Provider(
  (ref) => ref.watch(remoteConfigServiceProvider).instance,
);
final analyticsProvider = Provider((ref) => FirebaseAnalytics.instance);
final crashlyticsProvider = Provider((ref) => FirebaseCrashlytics.instance);
