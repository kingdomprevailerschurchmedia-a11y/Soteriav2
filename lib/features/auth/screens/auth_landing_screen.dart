import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
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

    return SafeGradientScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeroSection(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Column(
                children: [
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
                  AuthProviderButton(
                    provider: const IdentityProvider(
                      id: 'apple',
                      name: 'Continue with Apple',
                      icon: Icons.apple_rounded,
                      type: IdentityProviderType.apple,
                    ),
                    onTap: () {},
                  ),
                  SoteriaButton.ghost(
                    label: 'Continue with Email',
                    icon: Icons.email_outlined,
                    onPressed: () => ref
                        .read(navigationServiceProvider)
                        .push('${SoteriaRoutes.auth}/login'),
                  ),
                  SizedBox(height: SoteriaSpacing.lg),

                  // Feature Carousel
                  const FeatureCarousel(),

                  SizedBox(height: SoteriaSpacing.xxl),

                  // Secondary Actions
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.muted,
                        ),
                      ),
                      SoteriaButton.text(
                        label: 'Create One',
                        onPressed: () => ref
                            .read(navigationServiceProvider)
                            .push('${SoteriaRoutes.auth}/register'),
                      ),
                    ],
                  ),
                  SoteriaButton.text(
                    label: 'Continue as Guest (Coming Soon)',
                    onPressed: null,
                  ),

                  SizedBox(height: SoteriaSpacing.xl),

                  // Legal
                  Text(
                    'By continuing, you agree to our',
                    style: context.bodySmall.copyWith(
                      fontSize: 10,
                      color: SoteriaColors.muted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegalLink(label: 'Terms', onTap: () {}),
                      const _LegalDivider(),
                      _LegalLink(label: 'Privacy', onTap: () {}),
                      const _LegalDivider(),
                      _LegalLink(label: 'Guidelines', onTap: () {}),
                    ],
                  ),
                  SizedBox(height: SoteriaSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LegalLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          label,
          style: const TextStyle(
            color: SoteriaColors.gold,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _LegalDivider extends StatelessWidget {
  const _LegalDivider();

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: TextStyle(
        color: SoteriaColors.muted.withValues(alpha: 0.5),
        fontSize: 8,
      ),
    );
  }
}
