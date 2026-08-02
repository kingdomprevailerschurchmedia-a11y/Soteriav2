import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/auth/widgets/password_strength_indicator.dart';

class RegistrationPreviewPage extends StatelessWidget {
  const RegistrationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Launch Full Registration',
          onPressed: () => context.push('${SoteriaRoutes.auth}/register'),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        Text(
          'Password Strength States',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              PasswordStrengthIndicator(password: 'weak'),
              SizedBox(height: 24),
              PasswordStrengthIndicator(password: 'Medium123'),
              SizedBox(height: 24),
              PasswordStrengthIndicator(password: 'Strong!12345'),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Guided Journey Architecture',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Text(
            'The registration flow uses a PageView with NeverScrollableScrollPhysics to enforce validation at each step, preventing users from skipping required information.',
          ),
        ),
      ],
    );
  }
}
