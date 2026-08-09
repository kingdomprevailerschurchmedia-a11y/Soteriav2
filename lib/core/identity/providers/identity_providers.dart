import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';
import '../models/user_permissions.dart';
import '../repositories/identity_repository.dart';
import '../repositories/firebase_identity_repository.dart';
import '../../logging/logger_service.dart';
import '../../firebase/providers/firebase_providers.dart';

// --- Repositories ---
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  return FirebaseIdentityRepository(
    auth: ref.watch(firebaseAuthServiceProvider),
    database: ref.watch(firestoreDatabaseServiceProvider),
  );
});

// --- Session ---
final authStateChangesProvider = StreamProvider<UserSession?>((ref) {
  return ref.watch(identityRepositoryProvider).sessionChanges;
});

class SessionNotifier extends Notifier<UserSession> {
  @override
  UserSession build() {
    final asyncSession = ref.watch(authStateChangesProvider);
    return asyncSession.value ?? const UserSession(status: SessionStatus.guest);
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

final sessionProvider = NotifierProvider<SessionNotifier, UserSession>(
  SessionNotifier.new,
);

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
    final profile = await ref
        .read(identityRepositoryProvider)
        .getUserProfile(uid);
    state = profile;
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, UserProfile?>(
  ProfileNotifier.new,
);

// --- Game Profile ---
class GameProfileNotifier extends Notifier<UserGameProfile> {
  @override
  UserGameProfile build() {
    return const UserGameProfile();
  }
}

final gameProfileProvider =
    NotifierProvider<GameProfileNotifier, UserGameProfile>(
      GameProfileNotifier.new,
    );

// --- Permissions ---
final permissionsProvider = Provider<UserPermissions>((ref) {
  // Logic to determine permissions based on profile/subscription
  return const UserPermissions();
});

// --- App Lifecycle / Startup ---
enum AppStartupState { loading, onboarding, personalization, auth, ready }

class AppLifecycleNotifier extends Notifier<AppStartupState> {
  SharedPreferences? _prefs;
  bool _isInitializing = false;

  @override
  AppStartupState build() {
    final session = ref.watch(sessionProvider);
    if (session.isAuthenticated) {
      return AppStartupState.ready;
    }

    // Defer initialization to avoid reading 'state' before build() completes.
    Future.microtask(() => _init());
    return AppStartupState.loading;
  }

  void refresh() {
    _init();
  }

  void bypassToAuth() {
    state = AppStartupState.auth;
  }

  Future<void> _init() async {
    // Prevent overlapping initialization cycles
    if (_isInitializing || state == AppStartupState.ready) return;
    _isInitializing = true;

    try {
      _prefs ??= await SharedPreferences.getInstance();

      final onboardingCompleted =
          _prefs!.getBool('onboarding_completed') ?? false;
      final personalizationCompleted =
          _prefs!.getString('user_personalization') != null;

      final session = await ref
          .read(identityRepositoryProvider)
          .getActiveSession();

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

      FlutterNativeSplash.remove();
    } catch (e, st) {
      LoggerService.e(
        'Lifecycle initialization failed',
        error: e,
        stackTrace: st,
      );
      // Fallback to auth on error to avoid being stuck on splash
      state = AppStartupState.auth;
      FlutterNativeSplash.remove();
    } finally {
      _isInitializing = false;
    }
  }
}

final appLifecycleProvider =
    NotifierProvider<AppLifecycleNotifier, AppStartupState>(
      AppLifecycleNotifier.new,
    );
