import 'package:flutter/foundation.dart';

@immutable
class OnboardingState {
  final int currentPage;
  final bool isCompleted;
  final bool isSkipped;

  const OnboardingState({
    this.currentPage = 0,
    this.isCompleted = false,
    this.isSkipped = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isCompleted,
    bool? isSkipped,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isCompleted: isCompleted ?? this.isCompleted,
      isSkipped: isSkipped ?? this.isSkipped,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          isCompleted == other.isCompleted &&
          isSkipped == other.isSkipped;

  @override
  int get hashCode => currentPage.hashCode ^ isCompleted.hashCode ^ isSkipped.hashCode;
}
