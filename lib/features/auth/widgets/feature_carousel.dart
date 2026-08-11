import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class FeatureCarousel extends StatefulWidget {
  const FeatureCarousel({super.key});

  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Leaderboards',
      'icon': Icons.leaderboard_rounded,
      'description': 'Compete nationally and rise to the top.',
    },
    {
      'title': 'Daily Challenges',
      'icon': Icons.bolt_rounded,
      'description': 'Sharpen your mind every single day.',
    },
    {
      'title': 'Achievements',
      'icon': Icons.emoji_events_rounded,
      'description': 'Earn prestigious badges for your growth.',
    },
    {
      'title': 'Tournaments',
      'icon': Icons.military_tech_rounded,
      'description': 'Join high-stakes competitive events.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _features.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final feature = _features[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFF130F26).withValues(alpha: 0.8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    child: Row(
                      children: [
                        // Illustration Placeholder / Large Icon
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1633),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            feature['icon'],
                            color: SoteriaColors.gold,
                            size: 22.sp,
                          ),
                        ),

                        SizedBox(width: 16.w),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                feature['title'],
                                style: context.titleLarge.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                feature['description'],
                                style: context.bodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 13.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Interaction Arrow
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 16.h),

        // Animated Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _features.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? SoteriaColors.primary
                    : Colors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
