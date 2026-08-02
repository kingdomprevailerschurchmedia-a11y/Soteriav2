import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../personalization/providers/personalization_notifier.dart';
import '../models/registration_draft.dart';
import '../repositories/registration_repository.dart';
import '../repositories/firebase_registration_repository.dart';
import '../../../core/identity/providers/firebase_providers.dart';
import '../../../core/utils/identity_validator.dart';

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
    state = state.copyWith(
      email: email,
      username: username,
    );
  }

  void updateSecurity({String? password, String? confirm}) {
    state = state.copyWith(
      password: password,
      confirmPassword: confirm,
    );
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

  Future<void> completeRegistration(RegistrationRepository repository) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kFirstNameKey, state.firstName);
    
    await repository.register(state);
  }
}

final registrationProvider =
    NotifierProvider<RegistrationNotifier, RegistrationDraft>(RegistrationNotifier.new);

final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) {
  return FirebaseRegistrationRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});
