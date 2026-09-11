import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/onboarding/providers/onboarding_notifier.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_page.dart';
import 'package:soteria/shared/widgets/soteria_background.dart';

import 'package:soteria/core/utils/soteria_responsive.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildRichHeadline(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final style = (isShort ? context.headlineSmall : context.headlineLarge)
        .copyWith(
          color: SoteriaColors.textPrimary,
          height: 1.1,
          fontWeight: FontWeight.w900,
        );

    final shadowStyle = style.copyWith(
      shadows: [
        Shadow(
          offset: const Offset(0, 2),
          blurRadius: 1.0,
          color: Colors.black.withValues(alpha: 0.3),
        ),
        Shadow(
          offset: const Offset(0, 2),
          blurRadius: 5.0,
          color: Colors.black.withValues(alpha: 0.3),
        ),
      ],
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: 'Compete.\n', style: shadowStyle),
          TextSpan(
            text: 'Learn. ',
            style: style.copyWith(color: SoteriaColors.secondary),
          ),
          TextSpan(
            text: 'Rise.',
            style: style.copyWith(color: SoteriaColors.gold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    final isTablet = SoteriaResponsive.isTablet(context);

    final pages = [
      OnboardingPage(
        title: 'Compete. Learn. Rise.',
        titleWidget: _buildRichHeadline(context),
        description: "Africa's premium competitive\nlearning platform.",
        pageController: _pageController,
        index: 0,
        illustrationScale: 1.75,
        illustration: Image.asset(
          'assets/images/rise.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Challenge Yourself',
        description:
            'Practice daily, compete with peers,\nand grow your knowledge faster.',
        pageController: _pageController,
        index: 1,
        illustrationScale: 1.75,
        illustration: Image.asset(
          'assets/images/challenge.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Earn Recognition',
        description:
            'Climb the leaderboards, earn exclusive\nbadges, and build your reputation.',
        pageController: _pageController,
        index: 2,
        illustrationScale: 1.55,
        illustration: Image.asset(
          'assets/images/recognition.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Ready to Begin?',
        description:
            'Join the community of innovators\nand start your journey today.',
        pageController: _pageController,
        index: 3,
        illustrationScale: 1.05,
        illustration: Image.asset(
          'assets/images/ready.png',
          fit: BoxFit.contain,
        ),
      ),
    ];

    final isLastPage = state.currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Premium Background Image
          const SoteriaBackground(
            imagePath: 'assets/images/onboarding_bg.webp',
            showOverlay: false,
          ),
          
          PageView(
            controller: _pageController,
            onPageChanged: (index) => notifier.setPage(index),
            children: pages,
          ),

          // Skip Button at Top Right
          if (!isLastPage)
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SoteriaSpacing.containerPadding(context),
                    vertical: 8.h,
                  ),
                  child: TextButton(
                    onPressed: () => notifier.skip(),
                    child: Text(
                      'Skip',
                      style: context.labelLarge.copyWith(
                        color: const Color(0xFF8A55FD),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Navigation Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Center(
                child: Container(
                  width: isTablet ? 500 : double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    SoteriaSpacing.lg,
                    SoteriaSpacing.xl,
                    SoteriaSpacing.lg,
                    SoteriaSpacing.xl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OnboardingIndicator(
                        currentIndex: state.currentPage,
                        itemCount: pages.length,
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: () {
                          if (!isLastPage) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOutQuint,
                            );
                          } else {
                            notifier.complete();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 52.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFD8B24A),
                                Color(0xFFB8860B),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isLastPage ? 'GET STARTED' : 'CONTINUE',
                                style: context.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  fontSize: 17.sp,
                                ),
                              ),
                              SizedBox(
                                width: 42.w,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Positioned(
                                      right: 16.w,
                                      child: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white.withValues(alpha: 0.2),
                                        size: 26.sp,
                                      ),
                                    ),
                                    Positioned(
                                      right: 8.w,
                                      child: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white.withValues(alpha: 0.5),
                                        size: 26.sp,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white,
                                      size: 26.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
