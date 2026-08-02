import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';
import '../models/user_permissions.dart';
import '../repositories/identity_repository.dart';
import '../repositories/firebase_identity_repository.dart';
import 'firebase_providers.dart';

// --- Repositories ---
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  return FirebaseIdentityRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

// --- Session ---
class SessionNotifier extends Notifier<UserSession> {
  @override
  UserSession build() {
    return const UserSession();
  }

  void setSession(UserSession session) {
    state = session;
    ref.read(identityRepositoryProvider).saveSession(session);
  }

  Future<void> logout() async {
    state = const UserSession(status: SessionStatus.guest);
    await ref.read(identityRepositoryProvider).clearSession();
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, UserSession>(SessionNotifier.new);

// --- Profile ---
class ProfileNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() {
    final session = ref.watch(sessionProvider);
    if (session.isAuthenticated && session.uid != null) {
      _loadProfile(session.uid!);
    }
    return null;
  }

  Future<void> _loadProfile(String uid) async {
    final profile = await ref.read(identityRepositoryProvider).getUserProfile(uid);
    if (ref.mounted) state = profile;
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, UserProfile?>(ProfileNotifier.new);

// --- Game Profile ---
class GameProfileNotifier extends Notifier<UserGameProfile> {
  @override
  UserGameProfile build() {
    return const UserGameProfile();
  }
}

final gameProfileProvider = NotifierProvider<GameProfileNotifier, UserGameProfile>(GameProfileNotifier.new);

// --- Permissions ---
final permissionsProvider = Provider<UserPermissions>((ref) {
  // Logic to determine permissions based on profile/subscription
  return const UserPermissions();
});

// --- App Lifecycle / Startup ---
enum AppStartupState { loading, onboarding, personalization, auth, ready }

class AppLifecycleNotifier extends Notifier<AppStartupState> {
  @override
  AppStartupState build() {
    _init();
    return AppStartupState.loading;
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    if (!ref.mounted) return;

    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
    final personalizationCompleted = prefs.getString('user_personalization') != null;
    
    final session = await ref.read(identityRepositoryProvider).getActiveSession();
    if (!ref.mounted) return;
    
    if (!onboardingCompleted) {
      state = AppStartupState.onboarding;
    } else if (!personalizationCompleted) {
      state = AppStartupState.personalization;
    } else if (session == null || !session.isAuthenticated) {
      state = AppStartupState.auth;
    } else {
      ref.read(sessionProvider.notifier).setSession(session);
      state = AppStartupState.ready;
    }
  }
}

final appLifecycleProvider = NotifierProvider<AppLifecycleNotifier, AppStartupState>(AppLifecycleNotifier.new);
