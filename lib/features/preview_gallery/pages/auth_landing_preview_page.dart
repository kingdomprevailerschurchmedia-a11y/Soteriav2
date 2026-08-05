import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/auth/widgets/auth_hero_section.dart';
import 'package:soteria/features/auth/widgets/feature_carousel.dart';

class AuthLandingPreviewPage extends StatelessWidget {
  const AuthLandingPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Launch Full Auth Landing',
          onPressed: () => context.push(SoteriaRoutes.auth),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        Text('Hero Section', style: Theme.of(context).textTheme.titleMedium),
        const SoteriaCard(padding: EdgeInsets.zero, child: AuthHeroSection()),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Feature Carousel',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const FeatureCarousel(),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Platform Buttons',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              Text(
                'Note: Apple button hidden on non-iOS by default in component logic.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
