import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/premium_background.dart';
import 'package:soteria/features/onboarding/providers/onboarding_notifier.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_page.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_button.dart';

import 'package:soteria/core/utils/soteria_responsive.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
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

    return Scaffold(
      body: PremiumBackground(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) => notifier.setPage(index),
              children: [
                OnboardingPage(
                  title: 'Compete. Learn. Rise.',
                  titleWidget: _buildRichHeadline(context),
                  description:
                      "Africa's premium competitive learning platform.",
                  offset: _currentPage - 0,
                  backgroundGlowColor: SoteriaColors.primary,
                  illustration: Image.asset(
                    'assets/images/rise.png',
                    fit: BoxFit.contain,
                  ),
                ),
                OnboardingPage(
                  title: 'Challenge Yourself',
                  description:
                      'Practice daily, compete with peers, and grow your knowledge faster.',
                  offset: _currentPage - 1,
                  backgroundGlowColor: SoteriaColors.secondary,
                  illustrationScale: 2,
                  illustration: Image.asset(
                    'assets/images/challenge.png',
                    fit: BoxFit.contain,
                  ),
                ),
                OnboardingPage(
                  title: 'Earn Recognition',
                  description:
                      'Climb the leaderboards, earn exclusive badges, and build your reputation.',
                  offset: _currentPage - 2,
                  backgroundGlowColor: SoteriaColors.gold,
                  illustrationScale: 2,
                  illustration: Image.asset(
                    'assets/images/recognition.png',
                    fit: BoxFit.contain,
                  ),
                ),
                OnboardingPage(
                  title: 'Ready to Begin?',
                  description:
                      'Join the community of innovators and start your journey today.',
                  offset: _currentPage - 3,
                  backgroundGlowColor: SoteriaColors.success,
                  illustrationScale: 2,
                  illustration: Image.asset(
                    'assets/images/ready.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
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
                      SoteriaSpacing.xxl,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnboardingIndicator(
                          currentIndex: state.currentPage,
                          itemCount: 4,
                        ),
                        SizedBox(height: 48.h.clamp(32.0, 64.0)),
                        Row(
                          mainAxisAlignment: state.currentPage == 3
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (state.currentPage < 3)
                              SoteriaOnboardingButton(
                                label: 'Skip',
                                variant: OnboardingButtonVariant.skip,
                                onPressed: () => notifier.skip(),
                              ),
                            SoteriaOnboardingButton(
                              label: state.currentPage == 3 ? 'Start' : 'Next',
                              onPressed: () {
                                if (state.currentPage < 3) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOutQuint,
                                  );
                                } else {
                                  notifier.complete();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
