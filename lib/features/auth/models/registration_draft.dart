import 'package:flutter/foundation.dart';

enum RegistrationStep { personal, account, security, review, success }

@immutable
class RegistrationDraft {
  final String firstName;
  final String lastName;
  final String? displayName;
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  // From Personalization
  final String? academicLevel;
  final Set<String> interests;
  final Set<String> goals;

  final bool acceptedTerms;
  final RegistrationStep step;
  final bool isLoading;
  final String? error;

  const RegistrationDraft({
    this.firstName = '',
    this.lastName = '',
    this.displayName,
    this.email = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
    this.academicLevel,
    this.interests = const {},
    this.goals = const {},
    this.acceptedTerms = false,
    this.step = RegistrationStep.personal,
    this.isLoading = false,
    this.error,
  });

  RegistrationDraft copyWith({
    String? firstName,
    String? lastName,
    String? displayName,
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    String? academicLevel,
    Set<String>? interests,
    Set<String>? goals,
    bool? acceptedTerms,
    RegistrationStep? step,
    bool? isLoading,
    String? error,
  }) {
    return RegistrationDraft(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      academicLevel: academicLevel ?? this.academicLevel,
      interests: interests ?? this.interests,
      goals: goals ?? this.goals,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
