import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/onboarding/models/onboarding_state.dart';

class OnboardingNotifier extends Notifier<OnboardingState> {
  static const _kOnboardingCompletedKey = 'onboarding_completed';

  @override
  OnboardingState build() {
    _loadState();
    return const OnboardingState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool(_kOnboardingCompletedKey) ?? false;
    if (ref.mounted) {
      state = state.copyWith(isCompleted: isCompleted);
    }
  }

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void nextPage() {
    if (state.currentPage < 3) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    } else {
      complete();
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  Future<void> skip() async {
    state = state.copyWith(isSkipped: true);
    await complete();
  }

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingCompletedKey, true);
    state = state.copyWith(isCompleted: true);
    
    // Navigate to Personalization
    ref.read(navigationServiceProvider).go(SoteriaRoutes.personalization);
  }
}

final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(OnboardingNotifier.new);
