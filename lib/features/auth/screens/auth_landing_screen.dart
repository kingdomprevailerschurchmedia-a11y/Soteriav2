import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import '../providers/auth_landing_notifier.dart';
import '../widgets/auth_hero_section.dart';

class AuthLandingScreen extends ConsumerWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authLandingProvider);
    final notifier = ref.read(authLandingProvider.notifier);

    ref.listen(authLandingProvider.select((s) => s.error), (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: SoteriaColors.error),
        );
      }
    });

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Ambient Background Glow
            Positioned(
              top: 150.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 300.w,
                  height: 300.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        SoteriaColors.primary.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Spacer(),

                              const Spacer(flex: 2),

                              // Content Area (Pushed to bottom)
                              Column(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: context.displayMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1,
                                        fontSize: 36.sp,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Welcome to\n'),
                                        TextSpan(
                                          text: 'Soteria',
                                          style: TextStyle(
                                            color: SoteriaColors.gold,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  Text(
                                    'Rise through knowledge and\ncompete with the best.',
                                    style: context.bodyLarge.copyWith(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      height: 1.5,
                                      fontSize: 16.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 48.h),

                                  // Primary Login Action (Google)
                                  GestureDetector(
                                    onTap: () => notifier.signInWithGoogle(),
                                    child: Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        gradient: LinearGradient(
                                          colors: [
                                            SoteriaColors.gold
                                                .withValues(alpha: 0.95),
                                            SoteriaColors.gold
                                                .withValues(alpha: 0.8),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: SoteriaColors.gold
                                                .withValues(alpha: 0.2),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: state.isLoading
                                            ? SizedBox(
                                                width: 20.w,
                                                height: 20.w,
                                                child:
                                                    const CircularProgressIndicator(
                                                  color: Color(0xFF090514),
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Text(
                                                'Continue with Google',
                                                style: context.titleMedium
                                                    .copyWith(
                                                  color:
                                                      const Color(0xFF090514),
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  // Secondary Action (Register)
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(navigationServiceProvider)
                                        .push('${SoteriaRoutes.auth}/register'),
                                    child: Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: Colors.white
                                            .withValues(alpha: 0.05),
                                        border: Border.all(
                                          color: Colors.white
                                              .withValues(alpha: 0.08),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Create Account',
                                          style: context.titleMedium.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 24.h),

                                  // Email Login Link
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(navigationServiceProvider)
                                        .push('${SoteriaRoutes.auth}/login'),
                                    child: Text(
                                      'Login with Email',
                                      style: context.bodyMedium.copyWith(
                                        color:
                                            Colors.white.withValues(alpha: 0.4),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 32.h),
                                ],
                              ),

                              // Legal Footer
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 4.w,
                                  children: [
                                    _LegalButton(label: 'Terms', onTap: () {}),
                                    const _LegalDot(),
                                    _LegalButton(
                                        label: 'Privacy', onTap: () {}),
                                    const _LegalDot(),
                                    _LegalButton(
                                        label: 'Guidelines', onTap: () {}),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LegalButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFFD4AF37),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFFD4AF37),
          ),
        ),
      ),
    );
  }
}

class _LegalDot extends StatelessWidget {
  const _LegalDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '•',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
