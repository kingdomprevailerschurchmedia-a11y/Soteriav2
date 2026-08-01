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
      'title': 'Daily Challenges',
      'icon': Icons.bolt_rounded,
      'description': 'Sharpen your mind every single day.'
    },
    {
      'title': 'Leaderboards',
      'icon': Icons.leaderboard_rounded,
      'description': 'Compete nationally and rise to the top.'
    },
    {
      'title': 'Achievements',
      'icon': Icons.emoji_events_rounded,
      'description': 'Earn prestigious badges for your growth.'
    },
    {
      'title': 'Tournaments',
      'icon': Icons.military_tech_rounded,
      'description': 'Join high-stakes competitive events.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _features.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
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
          height: 100.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final feature = _features[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: GlassSurface(
                  opacity: 0.05,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        Icon(feature['icon'], color: SoteriaColors.gold, size: 24.w),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feature['title'],
                                style: context.labelLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                feature['description'],
                                style: context.bodySmall.copyWith(
                                  color: SoteriaColors.textSecondary,
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
              );
            },
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _features.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? SoteriaColors.gold
                    : SoteriaColors.muted.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
