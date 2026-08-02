import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../personalization/providers/personalization_notifier.dart';
import '../models/registration_draft.dart';
import '../models/identity_exception.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/utils/identity_validator.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'auth_providers.dart';

class RegistrationNotifier extends Notifier<RegistrationDraft> {
  static const _kFirstNameKey = 'user_first_name';

  @override
  RegistrationDraft build() {
    final personalization = ref.watch(personalizationProvider);
    return RegistrationDraft(
      academicLevel: personalization.academicLevel,
      interests: personalization.interests,
      goals: personalization.goals,
    );
  }

  void updatePersonal({String? first, String? last, String? display}) {
    state = state.copyWith(
      firstName: first,
      lastName: last,
      displayName: display,
    );
  }

  void updateAccount({String? email, String? username}) {
    state = state.copyWith(email: email, username: username);
  }

  void updateSecurity({String? password, String? confirm}) {
    state = state.copyWith(password: password, confirmPassword: confirm);
  }

  void toggleTerms(bool accepted) {
    state = state.copyWith(acceptedTerms: accepted);
  }

  void setStep(RegistrationStep step) {
    state = state.copyWith(step: step);
  }

  bool isStepValid(RegistrationStep step) {
    switch (step) {
      case RegistrationStep.personal:
        return state.firstName.isNotEmpty && state.lastName.isNotEmpty;
      case RegistrationStep.account:
        return IdentityValidator.isValidEmail(state.email) &&
            IdentityValidator.isValidUsername(state.username);
      case RegistrationStep.security:
        return IdentityValidator.getPasswordStrength(state.password) >= 1.0 &&
            state.password == state.confirmPassword;
      case RegistrationStep.review:
        return state.acceptedTerms;
      default:
        return true;
    }
  }

  Future<void> completeRegistration() async {
    state = state.copyWith(isLoading: true, error: null);
    final stopwatch = Stopwatch()..start();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kFirstNameKey, state.firstName);

      final useCase = ref.read(signUpUseCaseProvider);
      final result = await useCase.execute(state.email, state.password);

      if (ref.mounted) {
        if (result.isSuccess) {
          ref.read(analyticsProvider).logSignUp(signUpMethod: 'email');
          LoggerService.i('Registration successful', feature: 'Auth');
        } else {
          state = state.copyWith(
            error: result.error?.userMessage ?? 'Registration failed.',
          );
        }
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = state.copyWith(
          error: e is IdentityException
              ? e.userMessage
              : 'Registration failed. Please check your configuration.',
        );
      }
      ref
          .read(crashlyticsProvider)
          .recordError(e, st, reason: 'Registration Failure');
      LoggerService.e(
        'Registration failed',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
    } finally {
      stopwatch.stop();
      if (ref.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

final registrationProvider =
    NotifierProvider<RegistrationNotifier, RegistrationDraft>(
      RegistrationNotifier.new,
    );
