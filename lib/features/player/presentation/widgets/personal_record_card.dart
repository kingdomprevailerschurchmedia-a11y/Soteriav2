import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_text.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../domain/models/competitive_personal_record.dart';
import 'package:intl/intl.dart';

class PersonalRecordCard extends StatelessWidget {
  final CompetitivePersonalRecord record;
  final VoidCallback? onTap;

  const PersonalRecordCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _getSemanticsLabel(),
      child: SoteriaCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        hasGlow: record.isCareerRecord,
        glowColor: SoteriaColors.gold,
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SoteriaText.caption(
                    _formatRecordType(record.type).toUpperCase(),
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 4),
                  SoteriaText.headline(
                    record.displayValue,
                    color: record.isCareerRecord ? SoteriaColors.gold : Colors.white,
                  ),
                  if (record.mode != null) ...[
                    const SizedBox(height: 2),
                    SoteriaText.caption(
                      record.mode!.toUpperCase(),
                      color: SoteriaColors.primary,
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SoteriaText.caption(
                  DateFormat('MMM d, yyyy').format(record.achievedAt),
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                if (record.previousValue != null) ...[
                  const SizedBox(height: 4),
                  _buildImprovement(),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getSemanticsLabel() {
    final type = _formatRecordType(record.type);
    final value = record.displayValue;
    final prefix = record.isCareerRecord ? 'Career best' : 'Season record for';
    
    var label = '$prefix $type, $value.';
    if (record.previousValue != null) {
      final diff = record.value - record.previousValue!;
      if (diff > 0) {
        label += ' Improved by ${_formatDiff(record.type, diff)}.';
      }
    }
    return label;
  }

  Widget _buildIcon() {
    IconData iconData;
    Color color;

    switch (record.type) {
      case CompetitiveRecordType.highestScore:
        iconData = Icons.emoji_events;
        color = SoteriaColors.gold;
        break;
      case CompetitiveRecordType.bestAccuracy:
        iconData = Icons.track_changes;
        color = SoteriaColors.success;
        break;
      case CompetitiveRecordType.longestWinStreak:
        iconData = Icons.local_fire_department;
        color = Colors.orange;
        break;
      case CompetitiveRecordType.bestRankReached:
        iconData = Icons.military_tech;
        color = SoteriaColors.secondary;
        break;
      default:
        iconData = Icons.star;
        color = SoteriaColors.primary;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Icon(iconData, color: color, size: 24),
    );
  }

  Widget _buildImprovement() {
    final diff = record.value - record.previousValue!;
    if (diff <= 0) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.arrow_upward, color: SoteriaColors.success, size: 12),
        const SizedBox(width: 2),
        SoteriaText.caption(
          '+${_formatDiff(record.type, diff)}',
          color: SoteriaColors.success,
        ),
      ],
    );
  }

  String _formatDiff(CompetitiveRecordType type, double diff) {
    if (type == CompetitiveRecordType.bestAccuracy) {
      return '${(diff * 100).toStringAsFixed(1)}%';
    }
    return diff.toInt().toString();
  }

  String _formatRecordType(CompetitiveRecordType type) {
    switch (type) {
      case CompetitiveRecordType.highestScore:
        return 'Highest Score';
      case CompetitiveRecordType.bestAccuracy:
        return 'Best Accuracy';
      case CompetitiveRecordType.longestWinStreak:
        return 'Longest Win Streak';
      case CompetitiveRecordType.mostRankPointsGained:
        return 'Rank Gain';
      case CompetitiveRecordType.bestRankReached:
        return 'Peak Rank';
      case CompetitiveRecordType.bestLeaderboardPosition:
        return 'Leaderboard';
      case CompetitiveRecordType.bestSeasonPosition:
        return 'Season Finish';
      case CompetitiveRecordType.mostWinsInSeason:
        return 'Season Wins';
      case CompetitiveRecordType.bestModeScore:
        return 'Mode Record';
    }
  }
}
