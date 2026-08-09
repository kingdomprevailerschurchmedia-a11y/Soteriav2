import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/onboarding/providers/onboarding_notifier.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_page.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return SafeGradientScaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => notifier.setPage(index),
            children: [
              OnboardingPage(
                title: 'Compete. Learn. Rise.',
                description: "Africa's premium competitive learning platform.",
                offset: _currentPage - 0,
                backgroundGlowColor: SoteriaColors.primary,
                illustration: _OnboardingIllustration(
                  icon: Icons.rocket_launch_rounded,
                  color: SoteriaColors.primary,
                ),
              ),
              OnboardingPage(
                title: 'Challenge Yourself',
                description:
                    'Practice daily, compete with peers, and grow your knowledge faster.',
                offset: _currentPage - 1,
                backgroundGlowColor: SoteriaColors.secondary,
                illustration: _OnboardingIllustration(
                  icon: Icons.psychology_rounded,
                  color: SoteriaColors.secondary,
                ),
              ),
              OnboardingPage(
                title: 'Earn Recognition',
                description:
                    'Climb the leaderboards, earn exclusive badges, and build your reputation.',
                offset: _currentPage - 2,
                backgroundGlowColor: SoteriaColors.gold,
                illustration: _OnboardingIllustration(
                  icon: Icons.emoji_events_rounded,
                  color: SoteriaColors.gold,
                ),
              ),
              OnboardingPage(
                title: 'Ready to Begin?',
                description:
                    'Join the community of innovators and start your journey today.',
                offset: _currentPage - 3,
                backgroundGlowColor: SoteriaColors.success,
                illustration: _OnboardingIllustration(
                  icon: Icons.auto_awesome_rounded,
                  color: SoteriaColors.success,
                ),
              ),
            ],
          ),

          // Navigation Controls
          Positioned(
            bottom: SoteriaSpacing.xl,
            left: SoteriaSpacing.xl,
            right: SoteriaSpacing.xl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OnboardingIndicator(
                  currentIndex: state.currentPage,
                  itemCount: 4,
                ),
                SizedBox(height: SoteriaSpacing.xl),
                if (state.currentPage < 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SoteriaButton.text(
                        label: 'Skip',
                        onPressed: () => notifier.skip(),
                      ),
                      SoteriaButton.primary(
                        label: 'Next',
                        isFullWidth: false,
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      SoteriaButton.primary(
                        label: 'Get Started',
                        onPressed: () => notifier.complete(),
                      ),
                      SizedBox(height: SoteriaSpacing.md),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SoteriaButton.text(
                            label: 'Sign In',
                            onPressed: () => notifier.completeAndLogin(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              '|',
                              style: TextStyle(
                                color: SoteriaColors.muted.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                          ),
                          SoteriaButton.text(
                            label: 'Create Account',
                            onPressed: () => notifier.completeAndRegister(),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = 280.w.clamp(200.0, 320.0);
    final iconSize = 100.w.clamp(60.0, 120.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: GlassSurface(
          borderRadius: BorderRadius.circular(40.r),
          padding: EdgeInsets.all(size * 0.15),
          child: Icon(icon, size: iconSize, color: color),
        ),
      ),
    );
  }
}
