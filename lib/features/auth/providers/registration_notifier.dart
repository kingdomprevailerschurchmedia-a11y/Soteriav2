import 'dart:async';
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
  bool _mounted = true;
  Timer? _debounceTimer;

  @override
  RegistrationDraft build() {
    _mounted = true;
    ref.onDispose(() {
      _mounted = false;
      _debounceTimer?.cancel();
    });
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
    if (username != null) {
      final normalized = username.trim().toLowerCase();
      state = state.copyWith(
        email: email?.trim(),
        username: normalized,
        usernameError: _validateUsernameFormat(normalized),
        isUsernameAvailable: false,
      );

      if (state.usernameError == null) {
        _checkUsernameAvailability(normalized);
      }
    } else {
      state = state.copyWith(email: email?.trim());
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
    state = state.copyWith(isUsernameChecking: true, usernameError: null);

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final isAvailable =
            await ref.read(usernameServiceProvider).isUsernameAvailable(username);
        if (_mounted) {
          state = state.copyWith(
            isUsernameChecking: false,
            isUsernameAvailable: isAvailable,
            usernameError: isAvailable ? null : 'Username is already taken',
          );
        }
      } catch (e) {
        if (_mounted) {
          state = state.copyWith(
            isUsernameChecking: false,
            usernameError: 'Failed to check availability',
          );
        }
      }
    });
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
            IdentityValidator.isValidUsername(state.username) &&
            state.isUsernameAvailable &&
            !state.isUsernameChecking;
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

      if (_mounted) {
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
      if (_mounted) {
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
      if (_mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

final registrationProvider =
    NotifierProvider<RegistrationNotifier, RegistrationDraft>(
      RegistrationNotifier.new,
    );
