import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';

class SoteriaLoadingPage extends StatelessWidget {
  const SoteriaLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SoteriaLoader(size: 48),
              SizedBox(height: SoteriaSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
