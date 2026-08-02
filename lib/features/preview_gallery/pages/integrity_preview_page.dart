import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/integrity/widgets/risk_inspector.dart';
import 'package:soteria/features/gameplay_engine/integrity/widgets/integrity_timeline.dart';
import 'package:soteria/features/gameplay_engine/integrity/providers/integrity_providers.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/risk_assessment.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/integrity_signal.dart';

class IntegrityPreviewPage extends StatelessWidget {
  const IntegrityPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Risk Inspector States', [
            _MockIntegrity(
              assessment: RiskAssessment(
                score: 0.5,
                level: RiskLevel.low,
                signalCount: 1,
                lastEvaluated: DateTime.now(),
              ),
              child: const RiskInspector(),
            ),
            const SizedBox(height: 16),
            _MockIntegrity(
              assessment: RiskAssessment(
                score: 3.2,
                level: RiskLevel.moderate,
                signalCount: 3,
                lastEvaluated: DateTime.now(),
              ),
              child: const RiskInspector(),
            ),
            const SizedBox(height: 16),
            _MockIntegrity(
              assessment: RiskAssessment(
                score: 7.5,
                level: RiskLevel.high,
                signalCount: 8,
                lastEvaluated: DateTime.now(),
              ),
              child: const RiskInspector(),
            ),
            const SizedBox(height: 16),
            _MockIntegrity(
              assessment: RiskAssessment(
                score: 12.0,
                level: RiskLevel.critical,
                signalCount: 12,
                lastEvaluated: DateTime.now(),
              ),
              child: const RiskInspector(),
            ),
          ]),
          _buildSection('Integrity Timeline', [
            _MockIntegrity(
              signals: [
                IntegritySignal(
                  type: IntegritySignalType.appBackgrounded,
                  timestamp: DateTime.now().subtract(
                    const Duration(minutes: 5),
                  ),
                ),
                IntegritySignal(
                  type: IntegritySignalType.appResumed,
                  timestamp: DateTime.now().subtract(
                    const Duration(minutes: 4),
                  ),
                  metadata: {'durationMs': 60000},
                ),
                IntegritySignal(
                  type: IntegritySignalType.tooFastAnswer,
                  timestamp: DateTime.now().subtract(
                    const Duration(minutes: 2),
                  ),
                  metadata: {'responseTimeMs': 120},
                ),
              ],
              child: const IntegrityTimeline(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SoteriaTypography.headline.copyWith(
            color: SoteriaColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
        const SizedBox(height: 32),
        const Divider(color: Colors.white10),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _MockIntegrity extends StatelessWidget {
  final RiskAssessment? assessment;
  final List<IntegritySignal>? signals;
  final Widget child;

  const _MockIntegrity({this.assessment, this.signals, required this.child});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        integrityProvider.overrideWith(
          (ref) => IntegrityNotifierMock(assessment, signals),
        ),
      ],
      child: child,
    );
  }
}

class IntegrityNotifierMock extends IntegrityNotifier {
  final RiskAssessment? mockAssessment;
  final List<IntegritySignal>? mockSignals;

  IntegrityNotifierMock(this.mockAssessment, this.mockSignals) : super() {
    if (mockAssessment != null) state = mockAssessment!;
  }

  @override
  List<IntegritySignal> get allSignals => mockSignals ?? [];
}
