import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
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
    storage: ref.watch(firebaseStorageServiceProvider),
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
    return asyncSession.valueOrNull ?? const UserSession(status: SessionStatus.guest);
  }

  void setSession(UserSession session) {
    state = session;
    // We don't save to repository here as repo is the source of truth via authStateChanges
  }

  Future<void> logout() async {
    // We don't set state manually here.
    // The repository's clearSession will trigger authStateChangesProvider.
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

  Future<void> updateAvatar(String avatarId) async {
    final session = ref.read(sessionProvider);
    if (!session.isAuthenticated || session.uid == null || state == null) {
      return;
    }

    final updatedProfile = state!.copyWith(
      selectedAvatarId: avatarId,
      avatarUrl: '', // Clear custom photo if selecting preset avatar
    );
    await ref
        .read(identityRepositoryProvider)
        .updateUserProfile(session.uid!, updatedProfile);
    state = updatedProfile;
  }

  Future<void> updateProfilePicture(XFile image) async {
    final session = ref.read(sessionProvider);
    if (!session.isAuthenticated || session.uid == null || state == null) {
      return;
    }

    ref.read(profileUploadProvider.notifier).state = true;
    try {
      final downloadUrl = await ref
          .read(identityRepositoryProvider)
          .uploadProfilePicture(session.uid!, image.path);

      final updatedProfile = state!.copyWith(
        avatarUrl: downloadUrl,
        selectedAvatarId: '', // Clear avatar ID if using custom photo
      );

      await ref
          .read(identityRepositoryProvider)
          .updateUserProfile(session.uid!, updatedProfile);
      state = updatedProfile;
    } catch (e) {
      LoggerService.e('Failed to upload profile picture', error: e);
      rethrow;
    } finally {
      ref.read(profileUploadProvider.notifier).state = false;
    }
  }
}

final profileUploadProvider = StateProvider<bool>((ref) => false);

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
    // Listen to session changes to automatically progress the lifecycle
    ref.listen(sessionProvider, (previous, next) {
      if (next.isAuthenticated && state == AppStartupState.auth) {
        state = AppStartupState.ready;
      }
    });

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
    if (_isInitializing) return;
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
    } catch (e, st) {
      LoggerService.e(
        'Lifecycle initialization failed',
        error: e,
        stackTrace: st,
      );
      // Fallback to auth on error to avoid being stuck on splash
      state = AppStartupState.auth;
    } finally {
      _isInitializing = false;
      // Always remove splash after first init attempt
      // FlutterNativeSplash.remove(); // Handled by Custom Splash
    }
  }
}

final appLifecycleProvider =
    NotifierProvider<AppLifecycleNotifier, AppStartupState>(
      AppLifecycleNotifier.new,
    );
