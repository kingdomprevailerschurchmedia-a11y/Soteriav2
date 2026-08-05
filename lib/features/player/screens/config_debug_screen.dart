import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';

class ConfigDebugScreen extends ConsumerWidget {
  const ConfigDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configurationProvider);
    final repo = ref.watch(configurationRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURATION DEBUG'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            _InfoSection(
              title: 'FETCH INFO',
              children: [
                _InfoRow(
                  label: 'Last Fetch',
                  value: repo.getLastFetchTime().toIso8601String(),
                ),
                _InfoRow(label: 'Source', value: 'Firebase Remote Config'),
              ],
            ),
            SizedBox(height: SoteriaSpacing.xl),
            _ConfigSection(
              title: 'FEATURE FLAGS',
              data: {
                'Practice': config.features.enablePractice,
                'Pro Mode': config.features.enableProMode,
                'Tournament': config.features.enableTournament,
                'Versus': config.features.enableVersus,
                'Marketplace': config.features.enableMarketplace,
                'AI Coach': config.features.enableAICoach,
                'Premium': config.features.enablePremium,
              },
            ),
            SizedBox(height: SoteriaSpacing.xl),
            _ConfigSection(
              title: 'GAMEPLAY',
              data: {
                'Default Timer': config.gameplay.defaultQuestionTimer,
                'Min Timer': config.gameplay.minTimer,
                'Max Timer': config.gameplay.maxTimer,
                'Transition Delay': config.gameplay.questionTransitionDelay,
                'Points Correct': config.gameplay.pointsPerCorrect,
                'Wrong Penalty': config.gameplay.wrongAnswerPenalty,
              },
            ),
            SizedBox(height: SoteriaSpacing.xl),
            _ConfigSection(
              title: 'MAINTENANCE',
              data: {
                'Enabled': config.maintenance.isEnabled,
                'Message': config.maintenance.message,
                'Min App Version': config.maintenance.minAppVersion,
                'Force Upgrade': config.maintenance.forceUpgrade,
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(configurationCoordinatorProvider).initialize(),
        backgroundColor: SoteriaColors.primary,
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _InfoSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        SoteriaCard(child: Column(children: children)),
      ],
    );
  }
}

class _ConfigSection extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;
  const _ConfigSection({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        SoteriaCard(
          child: Column(
            children: data.entries
                .map((e) => _InfoRow(label: e.key, value: e.value.toString()))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          Flexible(
            child: Text(
              value,
              style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
              textAlign: Alignment.centerRight.x == 1.0
                  ? TextAlign.right
                  : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
