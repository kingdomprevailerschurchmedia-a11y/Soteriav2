import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/features/player/domain/models/player_presence.dart';
import 'package:soteria/features/player/presentation/providers/presence_providers.dart';

class PresenceLabel extends ConsumerWidget {
  final String userId;

  const PresenceLabel({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenceAsync = ref.watch(playerPresenceProvider(userId));

    return presenceAsync.when(
      data: (presence) {
        if (presence == null || presence.status == PresenceStatus.hidden) {
          return _buildText('Status hidden', SoteriaColors.muted);
        }
        
        return _buildText(_getStatusText(presence), _getStatusColor(presence));
      },
      loading: () => _buildText('...', SoteriaColors.muted),
      error: (_, __) => _buildText('Unavailable', SoteriaColors.muted),
    );
  }

  Widget _buildText(String text, Color color) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1,
      ),
    );
  }

  String _getStatusText(PlayerPresence presence) {
    switch (presence.status) {
      case PresenceStatus.online:
        return 'Online';
      case PresenceStatus.inMatch:
        return 'In Match';
      case PresenceStatus.recentlyActive:
        return 'Recently Active';
      case PresenceStatus.offline:
        return 'Offline';
      case PresenceStatus.unavailable:
        return 'Unavailable';
      case PresenceStatus.hidden:
        return 'Hidden';
    }
  }

  Color _getStatusColor(PlayerPresence presence) {
    switch (presence.status) {
      case PresenceStatus.online:
        return SoteriaColors.success;
      case PresenceStatus.inMatch:
        return SoteriaColors.primary;
      case PresenceStatus.recentlyActive:
        return SoteriaColors.warning;
      default:
        return SoteriaColors.muted;
    }
  }
}
