import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_messaging/firebase_messaging.dart' as messaging;
import 'package:firebase_remote_config/firebase_remote_config.dart' as rc;
import 'package:firebase_performance/firebase_performance.dart' as perf;

/// Abstract interface for Firebase Authentication
abstract interface class IAuthService {
  auth.FirebaseAuth get instance;
  Stream<auth.User?> get authStateChanges;
  auth.User? get currentUser;
  Future<void> signOut();
}

/// Abstract interface for Firestore Database
abstract interface class IDatabaseService {
  firestore.FirebaseFirestore get instance;
  firestore.CollectionReference<Map<String, dynamic>> collection(String path);
  firestore.DocumentReference<Map<String, dynamic>> doc(String path);
  Future<void> enablePersistence();
}

/// Abstract interface for Firebase Storage
abstract interface class IStorageService {
  storage.FirebaseStorage get instance;
  storage.Reference ref([String? path]);
}

/// Abstract interface for Cloud Messaging
abstract interface class IMessagingService {
  messaging.FirebaseMessaging get instance;
  Future<String?> getToken();
  Stream<messaging.RemoteMessage> get onMessage;
}

/// Abstract interface for Remote Config
abstract interface class IRemoteConfigService {
  rc.FirebaseRemoteConfig get instance;
  Future<void> fetchAndActivate();
  Future<void> setDefaults(Map<String, dynamic> defaults);
  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
}

/// Abstract interface for Firebase Analytics
abstract interface class IAnalyticsService {
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  });
  Future<void> setUserId(String? id);
  Future<void> setUserProperty({required String name, required String? value});
  Future<void> setAnalyticsCollectionEnabled(bool enabled);
}

/// Abstract interface for Firebase Crashlytics
abstract interface class ICrashlyticsService {
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    bool fatal = false,
  });
  Future<void> log(String message);
  Future<void> setCustomKey(String key, Object value);
  Future<void> setUserId(String identifier);
}

/// Abstract interface for Firebase Performance Monitoring
abstract interface class IPerformanceService {
  perf.Trace newTrace(String name);
  Future<void> setPerformanceCollectionEnabled(bool enabled);
}
