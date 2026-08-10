import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_button.dart';

class OnboardingPreviewPage extends StatelessWidget {
  const OnboardingPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Launch Full Onboarding',
          onPressed: () => context.push(SoteriaRoutes.onboarding),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        Text(
          'Components',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              Text('Pagination Indicators'),
              SizedBox(height: 16),
              OnboardingIndicator(currentIndex: 0, itemCount: 4),
              SizedBox(height: 16),
              OnboardingIndicator(currentIndex: 2, itemCount: 4),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          child: Column(
            children: [
              const Text('Premium Buttons'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SoteriaOnboardingButton(
                    label: 'Skip',
                    variant: OnboardingButtonVariant.skip,
                    onPressed: () {},
                  ),
                  SoteriaOnboardingButton(
                    label: 'Next',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        Text('Responsiveness', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Layout Strategy',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'The onboarding uses LayoutBuilder, Flexible, and Spacer to ensure content fits naturally on all viewports. On tablets, content is constrained to a maximum width of 500dp to maintain premium proportions.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
