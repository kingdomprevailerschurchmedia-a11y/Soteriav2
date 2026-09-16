import 'package:flutter/foundation.dart' hide Category;
import 'package:soteria/features/question_content/domain/entities/category.dart';

@immutable
class PersonalizationState {
  final String? academicLevel;
  final Set<String> interests;
  final Set<String> goals;
  final Map<String, bool> notificationPrefs;
  final int currentStep;
  final bool isLoading;
  final List<Category> categories;
  final String? error;

  const PersonalizationState({
    this.academicLevel,
    this.interests = const {},
    this.goals = const {},
    this.notificationPrefs = const {
      'daily_challenge': true,
      'weekly_tournament': true,
      'leaderboard': true,
      'achievements': true,
      'new_content': true,
    },
    this.currentStep = 0,
    this.isLoading = false,
    this.categories = const [],
    this.error,
  });

  bool get isLevelValid => academicLevel != null;
  bool get isInterestsValid => interests.isNotEmpty;
  bool get isGoalsValid => goals.isNotEmpty;

  bool isStepValid(int step) {
    switch (step) {
      case 0:
        return isLevelValid;
      case 1:
        return isInterestsValid;
      case 2:
        return isGoalsValid;
      case 3:
        return true; // Notifications optional
      default:
        return true;
    }
  }

  double get progress => (currentStep + 1) / 5.0;

  PersonalizationState copyWith({
    String? academicLevel,
    Set<String>? interests,
    Set<String>? goals,
    Map<String, bool>? notificationPrefs,
    int? currentStep,
    bool? isLoading,
    List<Category>? categories,
    String? error,
  }) {
    return PersonalizationState(
      academicLevel: academicLevel ?? this.academicLevel,
      interests: interests ?? this.interests,
      goals: goals ?? this.goals,
      notificationPrefs: notificationPrefs ?? this.notificationPrefs,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      error: error, // Don't use ?? this.error to allow clearing error
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalizationState &&
          runtimeType == other.runtimeType &&
          academicLevel == other.academicLevel &&
          setEquals(interests, other.interests) &&
          setEquals(goals, other.goals) &&
          mapEquals(notificationPrefs, other.notificationPrefs) &&
          currentStep == other.currentStep &&
          isLoading == other.isLoading &&
          listEquals(categories, other.categories) &&
          error == other.error;

  @override
  int get hashCode =>
      academicLevel.hashCode ^
      interests.hashCode ^
      goals.hashCode ^
      notificationPrefs.hashCode ^
      currentStep.hashCode ^
      isLoading.hashCode ^
      categories.hashCode ^
      error.hashCode;
}
