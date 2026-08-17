import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:go_router/go_router.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'NOTIFICATION SETTINGS',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            SoteriaSpacing.lg,
            kToolbarHeight + SoteriaSpacing.xl,
            SoteriaSpacing.lg,
            SoteriaSpacing.xl,
          ),
          children: [
            _PreferenceSection(
              title: 'COMPETITIVE',
              items: [
                _PreferenceSwitch(
                  title: 'Match Results',
                  subtitle: 'Get notified when your match ends.',
                  value: true,
                  onChanged: (v) {},
                ),
                _PreferenceSwitch(
                  title: 'Rank Changes',
                  subtitle: 'Promotions and demotions.',
                  value: true,
                  onChanged: (v) {},
                ),
                _PreferenceSwitch(
                  title: 'Season Updates',
                  subtitle: 'New seasons and ending reminders.',
                  value: true,
                  onChanged: (v) {},
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.lg),
            _PreferenceSection(
              title: 'LIVE EVENTS',
              items: [
                _PreferenceSwitch(
                  title: 'New Events',
                  subtitle: 'Special weekend events and challenges.',
                  value: true,
                  onChanged: (v) {},
                ),
                _PreferenceSwitch(
                  title: 'Event Reminders',
                  subtitle: 'Reminders for events ending soon.',
                  value: true,
                  onChanged: (v) {},
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.lg),
            _PreferenceSection(
              title: 'SOCIAL & REWARDS',
              items: [
                _PreferenceSwitch(
                  title: 'Challenges',
                  subtitle: 'When someone challenges you to Versus.',
                  value: true,
                  onChanged: (v) {},
                ),
                _PreferenceSwitch(
                  title: 'Achievements',
                  subtitle: 'Milestones and badge unlocks.',
                  value: true,
                  onChanged: (v) {},
                ),
                _PreferenceSwitch(
                  title: 'Rewards',
                  subtitle: 'Confirmations of coins and XP earned.',
                  value: true,
                  onChanged: (v) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _PreferenceSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
        GlassSurface(
          borderRadius: BorderRadius.circular(24),
          opacity: 0.05,
          padding: EdgeInsets.zero,
          child: Material(
            type: MaterialType.transparency,
            child: Column(children: items),
          ),
        ),
      ],
    );
  }
}

class _PreferenceSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PreferenceSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      title: Text(title, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: context.bodySmall.copyWith(color: SoteriaColors.muted)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: SoteriaColors.primary,
      ),
    );
  }
}
