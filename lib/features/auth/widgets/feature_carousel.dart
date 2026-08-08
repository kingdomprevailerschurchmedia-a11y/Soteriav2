import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

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
          height: 170.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final feature = _features[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GlassSurface(
                  opacity: 0.1,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  child: Stack(
                    children: [
                      // Subtile Glow
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: SoteriaColors.primary.withValues(alpha: 0.1),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          children: [
                            // Illustration Placeholder / Large Icon
                            Container(
                              width: 90.w,
                              height: 90.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    SoteriaColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    SoteriaColors.secondary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Icon(
                                feature['icon'],
                                color: SoteriaColors.primary,
                                size: 48.sp,
                              ),
                            ),

                            SizedBox(width: 20.w),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      feature['title'],
                                      style: context.titleLarge.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    feature['description'],
                                    style: context.bodySmall.copyWith(
                                      color: SoteriaColors.textSecondary,
                                      fontSize: 14.sp,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 12.w),

                            // Interaction Arrow
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: SoteriaColors.primary.withValues(
                                  alpha: 0.15,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: SoteriaColors.secondary,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),

        // Animated Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _features.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24.w : 8.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _currentPage == index
                    ? SoteriaColors.primary
                    : SoteriaColors.muted.withValues(alpha: 0.3),
                boxShadow: [
                  if (_currentPage == index)
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
