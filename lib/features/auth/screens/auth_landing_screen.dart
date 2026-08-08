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

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
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
                  variant: AuthProviderButtonVariant.glow,
                ),

                const SoteriaDivider(),

                AuthProviderButton(
                  provider: const IdentityProvider(
                    id: 'email',
                    name: 'Continue with Email',
                    icon: Icons.email_rounded,
                    type: IdentityProviderType.email,
                  ),
                  onTap: () => ref
                      .read(navigationServiceProvider)
                      .push('${SoteriaRoutes.auth}/login'),
                  variant: AuthProviderButtonVariant.outline,
                ),

                SizedBox(height: SoteriaSpacing.xxl),

                // Feature Highlights
                const FeatureCarousel(),

                SizedBox(height: 40.h),

                // Secondary Navigation
                Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () => ref
                          .read(navigationServiceProvider)
                          .push('${SoteriaRoutes.auth}/register'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CREATE ONE',
                            style: context.titleMedium.copyWith(
                              color: SoteriaColors.gold,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: SoteriaColors.gold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SoteriaDivider(),

                // Guest Access
                _GuestAction(),

                SizedBox(height: 50.h),

                // Legal Footer
                Text(
                  'By continuing, you agree to our',
                  style: context.bodySmall.copyWith(
                    fontSize: 12.sp,
                    color: SoteriaColors.muted,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4.w,
                  runSpacing: 8.h,
                  children: [
                    _LegalButton(label: 'Terms', onTap: () {}),
                    const _LegalDot(),
                    _LegalButton(label: 'Privacy', onTap: () {}),
                    const _LegalDot(),
                    _LegalButton(label: 'Guidelines', onTap: () {}),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.xxl),
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
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person_outline_rounded,
            color: SoteriaColors.primary,
            size: 28.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'CONTINUE AS GUEST',
              style: context.titleSmall.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
                fontSize: 16.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: SoteriaColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'COMING SOON',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: const TextStyle(
            color: SoteriaColors.gold,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            decoration: TextDecoration.underline,
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
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: SoteriaColors.muted.withValues(alpha: 0.4),
      ),
    );
  }
}
