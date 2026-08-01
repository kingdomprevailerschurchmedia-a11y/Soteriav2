import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/personalization/models/personalization_state.dart';

class PersonalizationNotifier extends Notifier<PersonalizationState> {
  static const _kStorageKey = 'user_personalization';

  @override
  PersonalizationState build() {
    _loadFromLocal();
    return const PersonalizationState();
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kStorageKey);
    if (data != null && ref.mounted) {
      try {
        final Map<String, dynamic> map = jsonDecode(data);
        state = state.copyWith(
          academicLevel: map['academicLevel'],
          interests: (map['interests'] as List<dynamic>).cast<String>().toSet(),
          goals: (map['goals'] as List<dynamic>).cast<String>().toSet(),
          notificationPrefs: (map['notificationPrefs'] as Map<String, dynamic>).cast<String, bool>(),
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

  void complete() {
    ref.read(navigationServiceProvider).go(SoteriaRoutes.auth);
  }
}

final personalizationProvider = NotifierProvider<PersonalizationNotifier, PersonalizationState>(PersonalizationNotifier.new);
