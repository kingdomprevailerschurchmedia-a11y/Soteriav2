import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/integrity/providers/integrity_providers.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:intl/intl.dart';

class IntegrityTimeline extends ConsumerWidget {
  const IntegrityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kReleaseMode) return const SizedBox.shrink();

    final signals = ref.watch(integrityProvider.notifier).allSignals;

    if (signals.isEmpty) {
      return const Center(child: Text('No integrity signals captured.'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: signals.length,
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white10),
      itemBuilder: (context, index) {
        final signal = signals[index];
        return ListTile(
          dense: true,
          leading: Icon(
            _getIconForType(signal.type),
            color: SoteriaColors.gold,
            size: 20,
          ),
          title: Text(
            signal.type.name,
            style: SoteriaTypography.label.copyWith(fontSize: 12),
          ),
          subtitle: Text(
            DateFormat('HH:mm:ss.SSS').format(signal.timestamp),
            style: SoteriaTypography.caption,
          ),
          trailing: signal.metadata.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.info_outline, size: 16),
                  onPressed: () => _showDetails(context, signal),
                )
              : null,
        );
      },
    );
  }

  IconData _getIconForType(dynamic type) {
    return Icons.warning_amber_rounded;
  }

  void _showDetails(BuildContext context, dynamic signal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SoteriaColors.surface,
        title: Text(signal.type.name),
        content: Text(signal.metadata.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
