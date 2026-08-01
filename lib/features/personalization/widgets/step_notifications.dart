import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepNotifications extends ConsumerWidget {
  const StepNotifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final prefs = [
      {'key': 'daily_challenge', 'title': 'Daily Challenge', 'subtitle': 'Never miss a day of practice'},
      {'key': 'weekly_tournament', 'title': 'Weekly Tournament', 'subtitle': 'Notifications for big events'},
      {'key': 'leaderboard', 'title': 'Leaderboard Updates', 'subtitle': 'When someone overtakes you'},
      {'key': 'achievements', 'title': 'Achievements', 'subtitle': 'Celebrate your milestones'},
      {'key': 'new_content', 'title': 'New Question Packs', 'subtitle': 'Fresh content alerts'},
    ];

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text(
          'Notification Preferences',
          style: context.headlineMedium,
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          'Stay updated with your progress and competitions.',
          style: context.bodySmall.copyWith(color: Colors.grey),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ...prefs.map((pref) => Padding(
          padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
          child: GlassSurface(
            child: Material(
              color: Colors.transparent,
              child: SwitchListTile(
                value: state.notificationPrefs[pref['key']] ?? true,
                onChanged: (val) => notifier.updateNotificationPref(pref['key']!, val),
                title: Text(pref['title']!, style: context.labelLarge),
                subtitle: Text(pref['subtitle']!, style: context.bodySmall.copyWith(fontSize: 10)),
                activeTrackColor: SoteriaColors.gold.withValues(alpha: 0.5),
                activeThumbColor: SoteriaColors.gold,
                inactiveThumbColor: SoteriaColors.muted,
                inactiveTrackColor: SoteriaColors.muted.withValues(alpha: 0.2),
                contentPadding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
