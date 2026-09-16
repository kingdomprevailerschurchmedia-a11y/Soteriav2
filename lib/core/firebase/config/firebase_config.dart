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
  final FirebaseOptions? customOptions;

  FirebaseConfig({
    required this.environment,
    this.customOptions,
  });

  FirebaseOptions get options {
    if (customOptions != null) return customOptions!;

    // In production, you would typically use a separate Firebase project.
    // Replace DefaultFirebaseOptions.currentPlatform with ProductionFirebaseOptions.currentPlatform
    // when you have a separate project for production.
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
