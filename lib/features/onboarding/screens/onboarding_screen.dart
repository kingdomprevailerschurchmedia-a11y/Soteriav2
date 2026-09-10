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
    final style = (isShort ? context.headlineLarge : context.displayMedium)
        .copyWith(
          color: SoteriaColors.textPrimary,
          height: 1.1,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(
              offset: const Offset(0, 4),
              blurRadius: 10.0,
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ],
        );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: style,
        children: [
          const TextSpan(text: 'Compete.\n'),
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
        description: "Africa's premium competitive learning platform.",
        pageController: _pageController,
        index: 0,
        illustrationScale: 2.00,
        illustration: Image.asset(
          'assets/images/rise.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Challenge Yourself',
        description:
            'Practice daily, compete with peers, and grow your knowledge faster.',
        pageController: _pageController,
        index: 1,
        illustrationScale: 2.00,
        illustration: Image.asset(
          'assets/images/challenge.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Earn Recognition',
        description:
            'Climb the leaderboards, earn exclusive badges, and build your reputation.',
        pageController: _pageController,
        index: 2,
        illustration: Image.asset(
          'assets/images/recognition.png',
          fit: BoxFit.contain,
        ),
      ),
      OnboardingPage(
        title: 'Ready to Begin?',
        description:
            'Join the community of innovators and start your journey today.',
        pageController: _pageController,
        index: 3,
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
                        color: Colors.white.withValues(alpha: 0.6),
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
                    SoteriaSpacing.containerPadding(context),
                    SoteriaSpacing.xl,
                    SoteriaSpacing.containerPadding(context),
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
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
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
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isLastPage ? 'GET STARTED' : 'CONTINUE',
                                  style: context.titleMedium.copyWith(
                                    color: const Color(0xFF090514),
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Color(0xFF090514),
                                  size: 22,
                                ),
                              ],
                            ),
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
