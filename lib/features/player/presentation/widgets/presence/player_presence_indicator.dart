import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/features/player/domain/models/player_presence.dart';
import 'package:soteria/features/player/presentation/providers/presence_providers.dart';

class PlayerPresenceIndicator extends ConsumerWidget {
  final String userId;
  final double size;

  const PlayerPresenceIndicator({
    super.key,
    required this.userId,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenceAsync = ref.watch(playerPresenceProvider(userId));

    return presenceAsync.when(
      data: (presence) {
        if (presence == null || !presence.showOnlineStatus) return const SizedBox.shrink();
        if (presence.status == PresenceStatus.inMatch) {
          return _buildIcon(Icons.flash_on_rounded, SoteriaColors.primary);
        }
        if (presence.status == PresenceStatus.recentlyActive) {
          return _buildDot(SoteriaColors.warning, isHollow: true);
        }
        return _buildDot(_getStatusColor(presence.status));
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDot(Color color, {bool isHollow = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isHollow ? Colors.transparent : color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isHollow ? color : SoteriaColors.background, 
          width: 2,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: SoteriaColors.background,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Color _getStatusColor(PresenceStatus status) {
    switch (status) {
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
