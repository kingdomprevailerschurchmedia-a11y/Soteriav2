import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_text_field.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';

class LoginRedesignPreview extends StatelessWidget {
  const LoginRedesignPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Login Redesign',
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME\nBACK',
                style: context.displayLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 0.9,
                  letterSpacing: -2,
                ),
              ),
              SizedBox(height: SoteriaSpacing.sm),
              Text(
                'Enter your credentials to continue your journey.',
                style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              const SoteriaTextField(
                label: 'Email Address',
                hintText: 'name@example.com',
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: SoteriaSpacing.lg),
              const SoteriaTextField(
                label: 'Password',
                hintText: '••••••••',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: true,
              ),
              SizedBox(height: SoteriaSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SoteriaSpacing.xl),
              SoteriaButton(label: 'Sign In', onPressed: () {}),
              SizedBox(height: SoteriaSpacing.lg),
              const _Divider(),
              SizedBox(height: SoteriaSpacing.lg),
              SoteriaButton.secondary(
                label: 'Continue with Google',
                icon: Icons.g_mobiledata_rounded,
                onPressed: () {},
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: context.bodySmall.copyWith(
                      color: SoteriaColors.muted,
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Create One',
                        style: TextStyle(
                          color: SoteriaColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.05))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
          child: Text(
            'OR',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.hints,
              fontSize: 10,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.05))),
      ],
    );
  }
}
