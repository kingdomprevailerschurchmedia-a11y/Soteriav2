import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/auth/providers/registration_notifier.dart';
import 'package:soteria/features/auth/models/registration_draft.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/personalization/models/personalization_state.dart';

class MockPersonalizationNotifier extends PersonalizationNotifier {
  @override
  PersonalizationState build() => const PersonalizationState(
    academicLevel: 'University',
    interests: {'Science'},
  );
}

void main() {
  group('RegistrationNotifier', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(
        overrides: [
          personalizationProvider.overrideWith(MockPersonalizationNotifier.new),
        ],
      );
    });

    test('prefills from personalization', () {
      final state = container.read(registrationProvider);
      expect(state.academicLevel, 'University');
      expect(state.interests, contains('Science'));
    });

    test('validation works for each step', () {
      final notifier = container.read(registrationProvider.notifier);
      
      // Personal Step
      expect(notifier.isStepValid(RegistrationStep.personal), false);
      notifier.updatePersonal(first: 'John', last: 'Doe');
      expect(notifier.isStepValid(RegistrationStep.personal), true);

      // Account Step
      notifier.updateAccount(email: 'john@example.com', username: 'johndoe');
      expect(notifier.isStepValid(RegistrationStep.account), true);
    });
  });
}
