import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/personalization/models/personalization_state.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/core/logging/logger_service.dart';

class PersonalizationNotifier extends Notifier<PersonalizationState> {
  static const _kStorageKey = 'user_personalization';
  bool _mounted = true;

  @override
  PersonalizationState build() {
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    _loadFromLocal();
    return const PersonalizationState();
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kStorageKey);
    if (data != null && _mounted) {
      try {
        final Map<String, dynamic> map = jsonDecode(data);
        state = state.copyWith(
          academicLevel: map['academicLevel'],
          interests: (map['interests'] as List<dynamic>).cast<String>().toSet(),
          goals: (map['goals'] as List<dynamic>).cast<String>().toSet(),
          notificationPrefs: (map['notificationPrefs'] as Map<String, dynamic>)
              .cast<String, bool>(),
        );
      } catch (_) {
        // Fallback to default
      }
    }
  }

  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({
      'academicLevel': state.academicLevel,
      'interests': state.interests.toList(),
      'goals': state.goals.toList(),
      'notificationPrefs': state.notificationPrefs,
    });
    await prefs.setString(_kStorageKey, data);
  }

  void setAcademicLevel(String level) {
    state = state.copyWith(academicLevel: level);
    _saveToLocal();
  }

  void toggleInterest(String interest) {
    final newInterests = Set<String>.from(state.interests);
    if (newInterests.contains(interest)) {
      newInterests.remove(interest);
    } else {
      newInterests.add(interest);
    }
    state = state.copyWith(interests: newInterests);
    _saveToLocal();
  }

  void toggleGoal(String goal) {
    final newGoals = Set<String>.from(state.goals);
    if (newGoals.contains(goal)) {
      newGoals.remove(goal);
    } else {
      newGoals.add(goal);
    }
    state = state.copyWith(goals: newGoals);
    _saveToLocal();
  }

  void updateNotificationPref(String key, bool value) {
    final newPrefs = Map<String, bool>.from(state.notificationPrefs);
    newPrefs[key] = value;
    state = state.copyWith(notificationPrefs: newPrefs);
    _saveToLocal();
  }

  void setStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    } else {
      complete();
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> syncToFirebase() async {
    final session = ref.read(sessionProvider);
    if (!session.isAuthenticated || session.uid == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(identityRepositoryProvider);
      final currentProfile = await repository.getUserProfile(session.uid!);

      final updatedProfile =
          (currentProfile ??
                  const UserProfile(
                    firstName: '',
                    lastName: '',
                    displayName: '',
                    username: '',
                    email: '',
                  ))
              .copyWith(
                academicLevel: state.academicLevel,
                interests: state.interests.toList(),
                goals: state.goals.toList(),
              );

      await repository.updateUserProfile(session.uid!, updatedProfile);
      LoggerService.i('Personalization synced to Firebase', feature: 'Auth');
    } catch (e, st) {
      LoggerService.e(
        'Failed to sync personalization',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
    } finally {
      if (_mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> complete() async {
    await syncToFirebase();
    // Trigger lifecycle update
    ref.read(appLifecycleProvider.notifier).refresh();
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kStorageKey);
    state = const PersonalizationState();
    ref.read(appLifecycleProvider.notifier).refresh();
  }
}

final personalizationProvider =
    NotifierProvider<PersonalizationNotifier, PersonalizationState>(
      PersonalizationNotifier.new,
    );
