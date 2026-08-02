import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../providers/login_notifier.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SoteriaTextField(
          label: 'Email Address',
          hintText: 'name@example.com',
          onChanged: notifier.updateEmail,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          enabled: !state.isLoading,
        ),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          label: 'Password',
          hintText: 'Enter your password',
          obscureText: true,
          onChanged: notifier.updatePassword,
          autofillHints: const [AutofillHints.password],
          enabled: !state.isLoading,
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: state.rememberMe,
                    onChanged: state.isLoading
                        ? null
                        : notifier.toggleRememberMe,
                    activeColor: SoteriaColors.gold,
                  ),
                ),
                SizedBox(width: SoteriaSpacing.sm),
                Text(
                  'Remember Me',
                  style: context.bodySmall.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: state.isLoading
                  ? null
                  : () => ref
                        .read(navigationServiceProvider)
                        .push('${SoteriaRoutes.auth}/verify/passwordRecovery'),
              child: Text(
                'Forgot Password?',
                style: context.labelSmall.copyWith(color: SoteriaColors.gold),
              ),
            ),
          ],
        ),
        if (state.error != null) ...[
          SizedBox(height: SoteriaSpacing.md),
          Text(
            state.error!,
            style: context.bodySmall.copyWith(color: SoteriaColors.error),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaButton.primary(
          label: 'Sign In',
          isLoading: state.isLoading,
          onPressed: () => notifier.login(),
        ),
      ],
    );
  }
}
