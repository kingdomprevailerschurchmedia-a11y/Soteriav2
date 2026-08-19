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
        SizedBox(height: 16.h),
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
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Preferences',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
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
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Stay updated with your progress and competitions.',
          style: context.bodySmall.copyWith(
            color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: SoteriaSpacing.lg),
        ...prefs.map(
          (pref) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: GlassSurface(
              borderRadius: BorderRadius.circular(16.r),
              opacity: 0.05,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          pref['icon'] as IconData,
                          color: const Color(0xFF7C4DFF),
                          size: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
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
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            pref['subtitle'] as String,
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary.withValues(
                                alpha: 0.6,
                              ),
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Switch
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: state.notificationPrefs[pref['key']] ?? true,
                        onChanged: (val) => notifier.updateNotificationPref(
                          pref['key'] as String,
                          val,
                        ),
                        activeThumbColor: Colors.white,
                        activeTrackColor: const Color(0xFF5B3FD9),
                        inactiveThumbColor: Colors.white.withValues(alpha: 0.5),
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Banner
        GlassSurface(
          borderRadius: BorderRadius.circular(20.r),
          opacity: 0.05,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: SoteriaColors.gold.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: SoteriaColors.gold,
                    size: 20,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You're in control",
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'You can change these anytime in settings.',
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.textSecondary.withValues(
                            alpha: 0.7,
                          ),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
