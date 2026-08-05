import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';

class TokenViewer extends StatelessWidget {
  const TokenViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        appBar: const TabBar(
          tabs: [
            Tab(text: 'Colors'),
            Tab(text: 'Typography'),
            Tab(text: 'Spacing'),
          ],
        ),
        body: TabBarView(
          children: [_ColorTab(), _TypographyTab(), _SpacingTab()],
        ),
      ),
    );
  }
}

class _ColorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = {
      'Primary': SoteriaColors.primary,
      'Secondary': SoteriaColors.secondary,
      'Background': SoteriaColors.background,
      'Surface': SoteriaColors.surface,
      'Error': SoteriaColors.error,
      'Success': SoteriaColors.success,
      'Gold': SoteriaColors.gold,
      'Muted': SoteriaColors.muted,
    };

    return ListView(
      padding: const EdgeInsets.all(20),
      children: colors.entries
          .map((e) => _ColorCard(label: e.key, color: e.value))
          .toList(),
    );
  }
}

class _ColorCard extends StatelessWidget {
  final String label;
  final Color color;
  const _ColorCard({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color),
        title: Text(label),
        subtitle: Text(color.toString()),
      ),
    );
  }
}

class _TypographyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Display Large', style: context.displayLarge),
        Text('Display Medium', style: context.displayMedium),
        Text('Title Large', style: context.titleLarge),
        Text('Body Large', style: context.bodyLarge),
        Text('Body Medium', style: context.bodyMedium),
        Text('Label Small', style: context.labelSmall),
      ],
    );
  }
}

class _SpacingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = {
      'XS (4)': SoteriaSpacing.xs,
      'SM (8)': SoteriaSpacing.sm,
      'MD (12)': SoteriaSpacing.md,
      'LG (16)': SoteriaSpacing.lg,
      'XL (24)': SoteriaSpacing.xl,
      'XXL (32)': SoteriaSpacing.xxl,
    };

    return ListView(
      padding: const EdgeInsets.all(20),
      children: spacing.entries
          .map((e) => _SpacingCard(label: e.key, value: e.value))
          .toList(),
    );
  }
}

class _SpacingCard extends StatelessWidget {
  final String label;
  final double value;
  const _SpacingCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 20,
          width: value,
          color: SoteriaColors.primary,
        ),
      ],
    );
  }
}
