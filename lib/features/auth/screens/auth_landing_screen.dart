import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/shared/widgets/soteria_divider.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
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

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SoteriaSpacing.adaptive(
                        context,
                        SoteriaSpacing.xlStatic,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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

                            SizedBox(height: 4.h),

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

                            SizedBox(height: 12.h),

                            // Feature Highlights
                            const FeatureCarousel(),

                            SizedBox(height: 16.h),

                            // Secondary Navigation
                            Column(
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: context.bodyMedium.copyWith(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 16.h),
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
                                          color: SoteriaColors.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          letterSpacing: 1.2,
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

                            SizedBox(height: 20.h),

                            // Guest Access
                            _GuestAction(),
                          ],
                        ),

                        // Legal Footer (Pushed to bottom)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
                          child: Column(
                            children: [
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
      ),
    );
  }
}

class _GuestAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'CONTINUE AS GUEST (COMING SOON)',
      style: context.labelLarge.copyWith(
        color: Colors.white.withValues(alpha: 0.4),
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
        letterSpacing: 1.2,
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
