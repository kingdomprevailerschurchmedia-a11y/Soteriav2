import 'package:flutter/material.dart';
import 'package:soteria/core/identity/repositories/identity_repository.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/models/user_identity.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/core/identity/models/user_game_profile.dart';

class MockIdentityRepo extends IdentityRepository {
  @override
  Stream<UserSession?> get sessionChanges => const Stream.empty();

  @override
  Future<UserSession?> getActiveSession() async => null;

  @override
  Future<UserIdentity?> getUserIdentity(String uid) async => null;

  @override
  Future<UserProfile?> getUserProfile(String uid) async => null;

  @override
  Future<UserGameProfile?> getUserGameProfile(String uid) async => null;

  @override
  Future<void> saveSession(UserSession session) async {}

  @override
  Future<void> clearSession() async {}
}

class MockAppLifecycleNotifier extends AppLifecycleNotifier {
  final AppStartupState initialState;
  MockAppLifecycleNotifier({this.initialState = AppStartupState.loading});

  @override
  AppStartupState build() => initialState;
}

void setupTestEnvironment() {
  FlutterError.onError = (details) {
    if (details.exception.toString().contains('fonts')) return;
    FlutterError.presentError(details);
  };
}
