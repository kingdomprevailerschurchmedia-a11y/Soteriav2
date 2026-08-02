import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/onboarding/widgets/onboarding_indicator.dart';

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
          'Progress Indicators',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              OnboardingIndicator(currentIndex: 0, itemCount: 4),
              SizedBox(height: 16),
              OnboardingIndicator(currentIndex: 2, itemCount: 4),
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
                'Tablet Mode',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'The onboarding uses PageView and Flexible/Spacer widgets to ensure content stays centered and readable on larger screens without hardcoded pixel overflows.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
