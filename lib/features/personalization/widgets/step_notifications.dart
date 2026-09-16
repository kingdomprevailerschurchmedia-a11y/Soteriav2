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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(height: 40.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Notification\n',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: const Color(0xFF2E1A8A),
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'Preferences',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: SoteriaColors.gold,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Stay updated with your progress and\ncompetitions. You\'re in control.',
              style: context.bodyLarge.copyWith(
                color: const Color(0xFF2E1A8A).withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...prefs.map(
          (pref) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              height: 66.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.05),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EFFF),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Icon(
                          pref['icon'] as IconData,
                          color: const Color(0xFF2E1A8A),
                          size: 18.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pref['title'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleMedium.copyWith(
                              color: const Color(0xFF2E1A8A),
                              fontWeight: FontWeight.w900,
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            pref['subtitle'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodySmall.copyWith(
                              color:
                                  const Color(0xFF2E1A8A).withValues(alpha: 0.5),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Switch
                    Transform.scale(
                      scale: 0.65,
                      child: Switch(
                        value: state.notificationPrefs[pref['key']] ?? true,
                        onChanged: (val) => notifier.updateNotificationPref(
                          pref['key'] as String,
                          val,
                        ),
                        activeThumbColor: Colors.white,
                        activeTrackColor: SoteriaColors.gold,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.black.withValues(alpha: 0.1),
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Banner
        GlassSurface(
          borderRadius: BorderRadius.circular(16.r),
          opacity: 0.05,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
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
                    size: 16,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You're in control",
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        'You can change these anytime in settings.',
                        style: context.bodySmall.copyWith(
                          color: const Color(0xFF2E1A8A).withValues(
                            alpha: 0.7,
                          ),
                          fontSize: 10.sp,
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
