import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      {
        'key': 'daily_challenge',
        'title': 'Daily Challenge',
        'subtitle': 'Never miss a day of practice',
        'icon': Icons.track_changes_rounded,
      },
      {
        'key': 'weekly_tournament',
        'title': 'Weekly Tournament',
        'subtitle': 'Notifications for big events',
        'icon': Icons.emoji_events_outlined,
      },
      {
        'key': 'leaderboard',
        'title': 'Leaderboard Updates',
        'subtitle': 'When someone overtakes you',
        'icon': Icons.leaderboard_outlined,
      },
      {
        'key': 'achievements',
        'title': 'Achievements',
        'subtitle': 'Celebrate your milestones',
        'icon': Icons.military_tech_outlined,
      },
      {
        'key': 'new_content',
        'title': 'New Question Packs',
        'subtitle': 'Fresh content alerts',
        'icon': Icons.library_add_check_outlined,
      },
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        SizedBox(height: SoteriaSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Notification ',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Preferences',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: const Color(0xFF7C4DFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 4.h),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF7C4DFF),
                size: 24,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Stay updated with your progress and competitions.',
          style: context.bodySmall.copyWith(
            color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ...prefs.map(
          (pref) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: GlassSurface(
              borderRadius: BorderRadius.circular(20.r),
              opacity: 0.05,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          pref['icon'] as IconData,
                          color: const Color(0xFF7C4DFF),
                          size: 24.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pref['title'] as String,
                            style: context.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            pref['subtitle'] as String,
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Switch
                    Switch(
                      value: state.notificationPrefs[pref['key']] ?? true,
                      onChanged: (val) =>
                          notifier.updateNotificationPref(pref['key'] as String, val),
                      activeThumbColor: Colors.white,
                      activeTrackColor: const Color(0xFF5B3FD9),
                      inactiveThumbColor: Colors.white.withValues(alpha: 0.5),
                      inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        // Banner
        GlassSurface(
          borderRadius: BorderRadius.circular(24.r),
          opacity: 0.05,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: SoteriaColors.gold,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You're in control",
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'You can change these preferences anytime in settings.',
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bell with badge
                Stack(
                  children: [
                    const Icon(
                      Icons.notifications_rounded,
                      color: Color(0xFF7C4DFF),
                      size: 40,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: SoteriaColors.gold,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
