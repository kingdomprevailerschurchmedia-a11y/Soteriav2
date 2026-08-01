import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../providers/login_notifier.dart';
import '../widgets/login_hero_section.dart';
import '../widgets/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    return SafeGradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
        child: Column(
          children: [
            LoginHeroSection(userName: state.userName),
            const LoginForm(),
            SizedBox(height: SoteriaSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
                SoteriaButton.text(
                  label: 'Create One',
                  onPressed: state.isLoading 
                    ? null 
                    : () => ref.read(navigationServiceProvider).push('${SoteriaRoutes.auth}/register'),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
