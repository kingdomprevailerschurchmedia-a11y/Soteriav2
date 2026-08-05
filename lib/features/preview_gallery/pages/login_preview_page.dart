import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/auth/widgets/login_hero_section.dart';

class LoginPreviewPage extends StatelessWidget {
  const LoginPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Launch Full Login Screen',
          onPressed: () => context.push('${SoteriaRoutes.auth}/login'),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        Text(
          'Hero Section (Default)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SoteriaCard(padding: EdgeInsets.zero, child: LoginHeroSection()),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Hero Section (Personalized)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SoteriaCard(
          padding: EdgeInsets.zero,
          child: LoginHeroSection(userName: 'Koffi'),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Identity Abstraction',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Text(
            'The login architecture is decoupled from the backend. The UI interacts with a LoginRepository interface, allowing for seamless transition from mock data to real authentication services.',
          ),
        ),
      ],
    );
  }
}
