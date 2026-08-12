import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../domain/models/reward_grant.dart';
import '../../domain/models/season_reward_definition.dart';

class RewardCard extends StatelessWidget {
  final RewardGrant grant;
  final VoidCallback? onTap;
  final VoidCallback? onClaim;
  final bool isClaiming;

  const RewardCard({
    super.key,
    required this.grant,
    this.onTap,
    this.onClaim,
    this.isClaiming = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SoteriaColors.border),
        boxShadow: [
          if (grant.status == GrantStatus.eligible ||
              grant.status == GrantStatus.granted)
            BoxShadow(
              color: _getTypeColor(grant.type).withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTypeName(grant.type),
                      style: const TextStyle(
                        color: SoteriaColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Season Reward',
                      style: TextStyle(
                        color: SoteriaColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+${grant.amount}',
                    style: TextStyle(
                      color: _getTypeColor(grant.type),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              if (grant.status == GrantStatus.eligible ||
                  grant.status == GrantStatus.granted) ...[
                const SizedBox(width: 12),
                _buildClaimButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color = _getTypeColor(grant.type);

    switch (grant.type) {
      case RewardType.xp:
        icon = Icons.bolt;
        break;
      case RewardType.coins:
        icon = Icons.monetization_on;
        break;
      case RewardType.tokens:
        icon = Icons.token;
        break;
      case RewardType.badge:
        icon = Icons.verified;
        break;
      case RewardType.achievement:
        icon = Icons.emoji_events;
        break;
      default:
        icon = Icons.card_giftcard;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildStatusBadge() {
    String text;
    Color color;

    switch (grant.status) {
      case GrantStatus.claimed:
        text = 'CLAIMED';
        color = SoteriaColors.success;
        break;
      case GrantStatus.pending:
        text = 'PENDING';
        color = SoteriaColors.warning;
        break;
      case GrantStatus.failed:
        text = 'FAILED';
        color = SoteriaColors.error;
        break;
      default:
        text = 'READY';
        color = SoteriaColors.info;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildClaimButton() {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: isClaiming ? null : onClaim,
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isClaiming
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Text('CLAIM'),
      ),
    );
  }

  Color _getTypeColor(RewardType type) {
    switch (type) {
      case RewardType.xp:
        return SoteriaColors.xpColor;
      case RewardType.coins:
        return SoteriaColors.coinColor;
      case RewardType.tokens:
        return SoteriaColors.secondary;
      case RewardType.badge:
      case RewardType.achievement:
        return SoteriaColors.gold;
      default:
        return SoteriaColors.primary;
    }
  }

  String _getTypeName(RewardType type) {
    switch (type) {
      case RewardType.xp:
        return 'Experience Points';
      case RewardType.coins:
        return 'Soteria Coins';
      case RewardType.tokens:
        return 'Competitive Tokens';
      case RewardType.badge:
        return 'Season Badge';
      case RewardType.achievement:
        return 'Achievement';
      default:
        return 'Reward';
    }
  }
}
