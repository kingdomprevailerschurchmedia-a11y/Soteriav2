import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/models/verification_type.dart';
import 'package:soteria/features/auth/providers/verification_notifier.dart';
import 'package:soteria/features/auth/models/verification_state.dart';

void main() {
  group('VerificationNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(verificationProvider(VerificationType.emailVerification));
      expect(state.type, VerificationType.emailVerification);
      expect(state.step, VerificationStep.request);
    });

    test('updateTarget updates state', () {
      final notifier = container.read(verificationProvider(VerificationType.emailVerification).notifier);
      notifier.updateTarget('test@example.com');
      expect(container.read(verificationProvider(VerificationType.emailVerification)).target, 'test@example.com');
    });

    test('requestVerification transitions to sent and starts countdown', () async {
      final notifier = container.read(verificationProvider(VerificationType.emailVerification).notifier);
      final repo = container.read(verificationRepositoryProvider);
      
      notifier.updateTarget('test@example.com');
      await notifier.requestVerification(repo);
      
      // Wait for countdown stream update
      await Future.delayed(const Duration(milliseconds: 100));
      
      final state = container.read(verificationProvider(VerificationType.emailVerification));
      expect(state.step, VerificationStep.sent);
      expect(state.countdown, greaterThan(0));
    });
  });
}
