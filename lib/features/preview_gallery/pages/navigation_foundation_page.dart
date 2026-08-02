import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';

class NavigationFoundationPage extends ConsumerWidget {
  const NavigationFoundationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(navigationServiceProvider);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('ROUTE SYSTEM'),
        SizedBox(height: SoteriaSpacing.md),
        _buildRouteItem('Splash', SoteriaRoutes.splash),
        _buildRouteItem('Gallery', SoteriaRoutes.previewGallery),
        _buildRouteItem('Tokens', SoteriaRoutes.tokens),

        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('NAVIGATION ACTIONS'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.primary(
          label: 'Go to Tokens (Fade)',
          onPressed: () => nav.go(SoteriaRoutes.tokens),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'Go to Unknown Route (404)',
          onPressed: () => nav.go('/this-path-does-not-exist'),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('GUARD SIMULATION'),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaText.body(
          'Guards are abstracted and ready for business logic integration.',
        ),
      ],
    );
  }

  Widget _buildRouteItem(String name, String path) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            path,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
