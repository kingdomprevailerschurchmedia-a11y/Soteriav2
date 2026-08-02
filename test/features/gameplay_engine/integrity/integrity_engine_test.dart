import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/integrity/services/integrity_engine.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/integrity_signal.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/integrity_policy.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/risk_assessment.dart';

void main() {
  group('IntegrityEngine Tests', () {
    final policy = ProIntegrityPolicy();

    test('initial risk is low', () {
      final assessment = IntegrityEngine.evaluate(signals: [], policy: policy);
      expect(assessment.level, RiskLevel.low);
      expect(assessment.score, 0.0);
    });

    test('weighted signals increase risk score', () {
      final signals = [
        IntegritySignal(
          type: IntegritySignalType.appBackgrounded,
          timestamp: DateTime.now(),
          metadata: {'durationMs': 15000},
        ),
      ];

      final assessment = IntegrityEngine.evaluate(
        signals: signals,
        policy: policy,
      );
      // Pro policy: appBackgrounded (0.3) * multiplier(1.0) = 0.3
      expect(assessment.score, 0.3);
    });

    test('risk level transitions based on thresholds', () {
      // Create many background signals to cross the moderate threshold (2.0)
      final signals = List.generate(
        7,
        (index) => IntegritySignal(
          type: IntegritySignalType.appBackgrounded,
          timestamp: DateTime.now(),
          metadata: {'durationMs': 15000},
        ),
      );

      final assessment = IntegrityEngine.evaluate(
        signals: signals,
        policy: policy,
      );
      // 7 * 0.3 = 2.1
      expect(assessment.level, RiskLevel.moderate);
    });

    test('grace period reduces impact of quick switches', () {
      final signals = [
        IntegritySignal(
          type: IntegritySignalType.appBackgrounded,
          timestamp: DateTime.now(),
          metadata: {'durationMs': 500}, // 0.5s switch
        ),
      ];

      final assessment = IntegrityEngine.evaluate(
        signals: signals,
        policy: policy,
      );
      // 0.3 * 0.1 = 0.03
      expect(assessment.score, closeTo(0.03, 0.001));
    });
  });
}
