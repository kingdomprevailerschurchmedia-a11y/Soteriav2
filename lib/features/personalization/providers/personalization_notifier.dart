import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/personalization/models/personalization_state.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/question_content/presentation/providers/category_providers.dart';

class PersonalizationNotifier extends Notifier<PersonalizationState> {
  static const _kStorageKey = 'user_personalization';
  bool _mounted = true;

  @override
  PersonalizationState build() {
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    
    // Start async initialization
    Future.microtask(() => _init());
    
    return const PersonalizationState(isLoading: true);
  }

  Future<void> _init() async {
    try {
      await _loadFromLocal();
      await _fetchCategories();
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }

  Future<void> _fetchCategories() async {
    if (!_mounted) return;
    
    // Don't fetch if already have categories, unless retrying
    if (state.categories.isNotEmpty && state.error == null) return;
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final repository = ref.read(categoryRepositoryProvider);
      final categories = await repository.getCategories();
      
      if (_mounted) {
        if (categories.isEmpty) {
          // If repository returns empty, use a final hardcoded fallback here
          final fallbackCategories = _getHardcodedFallback();
          state = state.copyWith(
            categories: fallbackCategories,
            isLoading: false,
            error: null,
          );
        } else {
          state = state.copyWith(
            categories: categories,
            isLoading: false,
            error: null,
          );
        }
      }
    } catch (e, st) {
      LoggerService.e(
        'Failed to fetch categories for personalization',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
      if (_mounted) {
        // Even on error, try to use hardcoded fallback to keep user moving
        final fallbackCategories = _getHardcodedFallback();
        state = state.copyWith(
          categories: fallbackCategories,
          isLoading: false,
          error: null, // Clear error since we have a fallback
        );
      }
    }
  }

  List<Category> _getHardcodedFallback() {
    return [
      Category(id: 'science', name: 'Science', icon: 'science', displayOrder: 1, description: 'Science', slug: 'science'),
      Category(id: 'tech', name: 'Technology', icon: 'technology', displayOrder: 2, description: 'Tech', slug: 'tech'),
      Category(id: 'math', name: 'Mathematics', icon: 'mathematics', displayOrder: 3, description: 'Math', slug: 'math'),
      Category(id: 'history', name: 'History', icon: 'history', displayOrder: 4, description: 'History', slug: 'history'),
      Category(id: 'art', name: 'Arts', icon: 'arts', displayOrder: 5, description: 'Arts', slug: 'art'),
    ];
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

  Future<void> retryFetchCategories() async {
    await _fetchCategories();
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
    final session = ref.read(sessionProvider);
    if (session.isAuthenticated) {
      await syncToFirebase();
      ref.read(appLifecycleProvider.notifier).setReady();
    } else {
      ref.read(navigationServiceProvider).go('${SoteriaRoutes.auth}/register');
    }
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
