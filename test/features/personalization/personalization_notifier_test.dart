import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

void main() {
  group('PersonalizationNotifier', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(personalizationProvider);
      expect(state.currentStep, 0);
      expect(state.academicLevel, isNull);
      expect(state.interests, isEmpty);
    });

    test('setting academic level updates state and persists', () async {
      final notifier = container.read(personalizationProvider.notifier);
      notifier.setAcademicLevel('University');

      expect(
        container.read(personalizationProvider).academicLevel,
        'University',
      );
      expect(container.read(personalizationProvider).isLevelValid, true);
    });

    test('toggling interests updates state', () {
      final notifier = container.read(personalizationProvider.notifier);
      notifier.toggleInterest('Science');
      expect(
        container.read(personalizationProvider).interests,
        contains('Science'),
      );

      notifier.toggleInterest('Science');
      expect(container.read(personalizationProvider).interests, isEmpty);
    });

    test('validation works for each step', () {
      final notifier = container.read(personalizationProvider.notifier);
      final stateBefore = container.read(personalizationProvider);
      expect(stateBefore.isStepValid(0), false);

      notifier.setAcademicLevel('Secondary School');
      expect(container.read(personalizationProvider).isStepValid(0), true);
    });
  });
}
