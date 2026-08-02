import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../../../firebase_options.dart';

enum FirebaseEnvironment {
  dev,
  staging,
  production;

  static FirebaseEnvironment fromString(String value) {
    return FirebaseEnvironment.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => FirebaseEnvironment.dev,
    );
  }
}

class FirebaseConfig {
  final FirebaseEnvironment environment;

  FirebaseConfig({required this.environment});

  FirebaseOptions get options {
    // In a real multi-project setup, this would return different options
    // for each environment. For now, we use the default generated options.
    return DefaultFirebaseOptions.currentPlatform;
  }

  bool get useEmulator =>
      environment == FirebaseEnvironment.dev && !kReleaseMode;

  static FirebaseConfig fromEnvironment() {
    const envString = String.fromEnvironment(
      'FIREBASE_ENV',
      defaultValue: 'dev',
    );
    return FirebaseConfig(
      environment: FirebaseEnvironment.fromString(envString),
    );
  }
}
