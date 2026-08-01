import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: SoteriaEmptyState(
        title: '404 - Lost in Space',
        subtitle: 'The destination "$location" does not exist in the Soteria universe.',
        icon: Icons.map_outlined,
        actionLabel: 'Back to Safety',
        onActionPressed: () => context.go('/'),
      ),
    );
  }
}
