import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';

class MatchHistoryEmptyState extends StatelessWidget {
  const MatchHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SoteriaEmptyState(
      title: 'NO MATCHES YET',
      subtitle:
          'Your competitive journey starts here. Compete in tournaments or versus matches to see your history.',
      icon: Icons.history_rounded,
      actionLabel: 'START COMPETING',
      onActionPressed: () => Navigator.pop(context), // Back to lobby
    );
  }
}
