import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../../core/identity/models/user_profile.dart';
import '../../domain/models/player_profile.dart';
import '../../providers/player_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';

class ProfileEditState {
  final UserProfile? originalUserProfile;
  final PlayerProfile? originalPlayerProfile;
  final UserProfile? editedUserProfile;
  final PlayerProfile? editedPlayerProfile;
  final String accountEmail;
  final bool isSaving;
  final String? error;
  final bool isSaved;
  final String? usernameError;
  final bool isUsernameChecking;
  final bool isUsernameAvailable;
  final bool isInitialized;

  ProfileEditState({
    this.originalUserProfile,
    this.originalPlayerProfile,
    this.editedUserProfile,
    this.editedPlayerProfile,
    this.accountEmail = '',
    this.isSaving = false,
    this.error,
    this.isSaved = false,
    this.usernameError,
    this.isUsernameChecking = false,
    this.isUsernameAvailable = true,
    this.isInitialized = false,
  });

  bool get hasChanges {
    if (!isInitialized) return false;
    return editedUserProfile != originalUserProfile || 
           editedPlayerProfile != originalPlayerProfile;
  }

  bool get canSave {
    return isInitialized &&
           hasChanges && 
           !isSaving && 
           usernameError == null && 
           !isUsernameChecking &&
           isUsernameAvailable;
  }

  ProfileEditState copyWith({
    UserProfile? originalUserProfile,
    PlayerProfile? originalPlayerProfile,
    UserProfile? editedUserProfile,
    PlayerProfile? editedPlayerProfile,
    String? accountEmail,
    bool? isSaving,
    String? error,
    bool? isSaved,
    String? usernameError,
    bool? isUsernameChecking,
    bool? isUsernameAvailable,
    bool? isInitialized,
  }) {
    return ProfileEditState(
      originalUserProfile: originalUserProfile ?? this.originalUserProfile,
      originalPlayerProfile: originalPlayerProfile ?? this.originalPlayerProfile,
      editedUserProfile: editedUserProfile ?? this.editedUserProfile,
      editedPlayerProfile: editedPlayerProfile ?? this.editedPlayerProfile,
      accountEmail: accountEmail ?? this.accountEmail,
      isSaving: isSaving ?? this.isSaving,
      error: error,
      isSaved: isSaved ?? this.isSaved,
      usernameError: usernameError,
      isUsernameChecking: isUsernameChecking ?? this.isUsernameChecking,
      isUsernameAvailable: isUsernameAvailable ?? this.isUsernameAvailable,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class ProfileEditNotifier extends Notifier<ProfileEditState> {
  Timer? _debounceTimer;

  @override
  ProfileEditState build() {
    final userProfile = ref.watch(profileProvider);
    final playerProfile = ref.watch(currentPlayerProvider);
    final authUser = ref.watch(firebaseAuthProvider).currentUser;
    
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    // We only initialize once to avoid overwriting user edits when the background stream updates
    if (playerProfile != null && !state.isInitialized) {
      final effectiveUserProfile = userProfile ?? _createNewProfile(authUser, playerProfile);
      
      return ProfileEditState(
        originalUserProfile: userProfile, 
        originalPlayerProfile: playerProfile,
        editedUserProfile: effectiveUserProfile,
        editedPlayerProfile: playerProfile,
        accountEmail: authUser?.email ?? playerProfile.email,
        isInitialized: true,
      );
    }

    return state;
  }

  UserProfile _createNewProfile(auth.User? user, PlayerProfile player) {
    final names = (user?.displayName ?? player.displayName).split(' ');
    return UserProfile(
      firstName: names.first,
      lastName: names.length > 1 ? names.last : '',
      displayName: user?.displayName ?? player.displayName,
      username: player.username,
      email: user?.email ?? player.email,
    );
  }

  void updateFirstName(String value) {
    if (state.editedUserProfile == null) return;
    state = state.copyWith(
      editedUserProfile: state.editedUserProfile!.copyWith(firstName: value.trim()),
    );
  }

  void updateLastName(String value) {
    if (state.editedUserProfile == null) return;
    state = state.copyWith(
      editedUserProfile: state.editedUserProfile!.copyWith(lastName: value.trim()),
    );
  }

  void updateDisplayName(String value) {
    if (state.editedUserProfile == null || state.editedPlayerProfile == null) return;
    state = state.copyWith(
      editedUserProfile: state.editedUserProfile!.copyWith(displayName: value.trim()),
      editedPlayerProfile: state.editedPlayerProfile!.copyWith(displayName: value.trim()),
    );
  }

  void updateBio(String value) {
    if (state.editedUserProfile == null) return;
    state = state.copyWith(
      editedUserProfile: state.editedUserProfile!.copyWith(bio: value.trim()),
    );
  }

  void updateUsername(String value) {
    if (state.editedUserProfile == null || state.editedPlayerProfile == null) return;
    
    final normalized = value.trim().toLowerCase();
    state = state.copyWith(
      editedUserProfile: state.editedUserProfile!.copyWith(username: normalized),
      editedPlayerProfile: state.editedPlayerProfile!.copyWith(username: normalized),
      usernameError: _validateUsernameFormat(normalized),
      isUsernameAvailable: normalized == (state.originalUserProfile?.username.toLowerCase() ?? state.originalPlayerProfile?.username.toLowerCase()),
    );

    if (state.usernameError == null && normalized != (state.originalUserProfile?.username.toLowerCase() ?? state.originalPlayerProfile?.username.toLowerCase())) {
      _checkUsernameAvailability(normalized);
    }
  }

  String? _validateUsernameFormat(String username) {
    if (username.isEmpty) return 'Username cannot be empty';
    if (username.length < 3) return 'Username too short';
    if (username.length > 20) return 'Username too long';
    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(username)) {
      return 'Only letters, numbers and underscores allowed';
    }
    return null;
  }

  void _checkUsernameAvailability(String username) {
    _debounceTimer?.cancel();
    state = state.copyWith(isUsernameChecking: true);
    
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final isAvailable = await ref.read(profileRepositoryProvider).checkUsernameAvailability(username);
        state = state.copyWith(
          isUsernameChecking: false,
          isUsernameAvailable: isAvailable,
          usernameError: isAvailable ? null : 'Username is already taken',
        );
      } catch (e) {
        state = state.copyWith(
          isUsernameChecking: false,
          error: 'Failed to check username availability',
        );
      }
    });
  }

  Future<void> save() async {
    if (!state.canSave) return;
    
    state = state.copyWith(isSaving: true, error: null);

    try {
      final session = ref.read(sessionProvider);
      if (session.uid == null) throw Exception('Unauthenticated');

      await ref.read(profileRepositoryProvider).updateProfile(
        userId: session.uid!,
        userProfile: state.editedUserProfile!,
        playerProfile: state.editedPlayerProfile!,
        oldUsername: state.originalUserProfile?.username ?? state.originalPlayerProfile?.username,
      );

      // Refresh source providers
      ref.read(profileProvider.notifier).refresh();
      ref.invalidate(currentPlayerStreamProvider);

      state = state.copyWith(
        isSaving: false,
        isSaved: true,
        originalUserProfile: state.editedUserProfile,
        originalPlayerProfile: state.editedPlayerProfile,
      );
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
    }
  }
}

final profileEditProvider = NotifierProvider<ProfileEditNotifier, ProfileEditState>(ProfileEditNotifier.new);
