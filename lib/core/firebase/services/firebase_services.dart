import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_messaging/firebase_messaging.dart' as messaging;
import 'package:firebase_remote_config/firebase_remote_config.dart' as rc;
import 'firebase_interfaces.dart';

class FirebaseAuthService implements IAuthService {
  @override
  auth.FirebaseAuth get instance => auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get authStateChanges => instance.authStateChanges();

  @override
  auth.User? get currentUser => instance.currentUser;

  @override
  Future<void> signOut() => instance.signOut();
}

class FirestoreDatabaseService implements IDatabaseService {
  @override
  firestore.FirebaseFirestore get instance =>
      firestore.FirebaseFirestore.instance;

  @override
  firestore.CollectionReference<Map<String, dynamic>> collection(String path) =>
      instance.collection(path);

  @override
  firestore.DocumentReference<Map<String, dynamic>> doc(String path) =>
      instance.doc(path);

  @override
  Future<void> enablePersistence() async {
    // Persistence is enabled by default on Android/iOS in newer SDKs,
    // but we can explicitly set settings if needed.
    instance.settings = const firestore.Settings(
      persistenceEnabled: true,
      cacheSizeBytes: firestore.Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}

class FirebaseStorageService implements IStorageService {
  @override
  storage.FirebaseStorage get instance => storage.FirebaseStorage.instance;

  @override
  storage.Reference ref([String? path]) => instance.ref(path);
}

class FCMService implements IMessagingService {
  @override
  messaging.FirebaseMessaging get instance =>
      messaging.FirebaseMessaging.instance;

  @override
  Future<String?> getToken() => instance.getToken();

  @override
  Stream<messaging.RemoteMessage> get onMessage =>
      messaging.FirebaseMessaging.onMessage;
}

class FirebaseRemoteConfigService implements IRemoteConfigService {
  @override
  rc.FirebaseRemoteConfig get instance => rc.FirebaseRemoteConfig.instance;

  @override
  Future<void> fetchAndActivate() => instance.fetchAndActivate();

  @override
  Future<void> setDefaults(Map<String, dynamic> defaults) =>
      instance.setDefaults(defaults);

  @override
  String getString(String key) => instance.getString(key);

  @override
  bool getBool(String key) => instance.getBool(key);

  @override
  int getInt(String key) => instance.getInt(key);

  @override
  double getDouble(String key) => instance.getDouble(key);
}
