import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/core/identity/repositories/identity_repository.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/models/user_identity.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/core/identity/models/user_game_profile.dart';
import 'package:soteria/features/auth/domain/repositories/auth_repository.dart';
import 'package:soteria/features/auth/services/auth_coordinator.dart';
import 'package:soteria/features/notifications/services/notification_coordinator.dart';
import 'package:soteria/core/firebase/config/services/configuration_coordinator.dart';

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
  @override
  Future<void> updateUserProfile(String uid, UserProfile profile) async {}

  @override
  Future<void> updateUserGameProfile(String uid, UserGameProfile profile) async {}

  @override
  Future<String> uploadProfilePicture(String uid, String filePath) async => '';
}

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Stream<String?> get userIdChanges => const Stream.empty();
  @override
  String? get currentUserId => null;
  @override
  Future<void> signOut() async {}
}

class MockAuthCoordinator extends Mock implements AuthCoordinator {
  @override
  void startListening() {}
  @override
  void dispose() {}
}

class MockNotificationCoordinator extends Mock
    implements NotificationCoordinator {
  @override
  Future<void> initialize() async {}
}

class MockConfigurationCoordinator extends Mock
    implements ConfigurationCoordinator {
  @override
  Future<void> initialize() async {}
}

class MockAppLifecycleNotifier extends AppLifecycleNotifier {
  final AppStartupState initialState;
  MockAppLifecycleNotifier({this.initialState = AppStartupState.ready});
  @override
  AppStartupState build() => initialState;
}

void setupTestEnvironment() {
  FlutterError.onError = (details) {
    if (details.exception.toString().contains('fonts')) return;
    FlutterError.presentError(details);
  };
}
