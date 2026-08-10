import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/premium_background.dart';
import 'package:soteria/shared/widgets/soteria_divider.dart';
import '../models/identity_provider.dart';
import '../providers/auth_landing_notifier.dart';
import '../widgets/auth_hero_section.dart';
import '../widgets/auth_provider_button.dart';
import '../widgets/feature_carousel.dart';

import 'package:soteria/core/utils/soteria_responsive.dart';

class AuthLandingScreen extends ConsumerWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authLandingProvider);
    final notifier = ref.read(authLandingProvider.notifier);
    final isShort = SoteriaResponsive.isShortScreen(context);

    ref.listen(authLandingProvider.select((s) => s.error), (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: SoteriaColors.error),
        );
      }
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcomescreen_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.adaptive(
                context,
                SoteriaSpacing.xlStatic,
              ),
            ),
            child: Column(
              children: [
                const AuthHeroSection(),

                // Primary Login Actions
                AuthProviderButton(
                  provider: const IdentityProvider(
                    id: 'google',
                    name: 'Continue with Google',
                    icon: Icons.g_mobiledata_rounded,
                    type: IdentityProviderType.google,
                  ),
                  onTap: () => notifier.signInWithGoogle(),
                  isLoading: state.isLoading,
                ),

                const SoteriaDivider(),

                AuthProviderButton(
                  provider: const IdentityProvider(
                    id: 'email',
                    name: 'Continue with Email',
                    icon: Icons.mail_outline_rounded,
                    type: IdentityProviderType.email,
                  ),
                  onTap: () => ref
                      .read(navigationServiceProvider)
                      .push('${SoteriaRoutes.auth}/login'),
                ),

                SizedBox(height: 24.h),

                // Feature Highlights
                const FeatureCarousel(),

                SizedBox(height: 40.h),

                // Secondary Navigation
                Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => ref
                          .read(navigationServiceProvider)
                          .push('${SoteriaRoutes.auth}/register'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create one',
                            style: context.titleMedium.copyWith(
                              color: SoteriaColors.secondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: SoteriaColors.secondary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Guest Access
                _GuestAction(),

                SizedBox(height: 40.h),

                // Legal Footer
                Text(
                  'By continuing, you agree to our',
                  style: context.bodySmall.copyWith(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4.w,
                  children: [
                    _LegalButton(label: 'Terms', onTap: () {}),
                    const _LegalDot(),
                    _LegalButton(label: 'Privacy', onTap: () {}),
                    const _LegalDot(),
                    _LegalButton(label: 'Guidelines', onTap: () {}),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GuestAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Center(
        child: Text(
          'Continue as Guest (Coming Soon)',
          style: context.titleSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.4),
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
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
