import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_text.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/widgets/overlays/soteria_bottom_sheet.dart';
import '../providers/match_history_providers.dart';
import 'match_history/competitive_match_details_sheet.dart';
import '../../domain/models/competitive_personal_record.dart';
import 'package:intl/intl.dart';

class PersonalRecordDetailsSheet extends ConsumerWidget {
  final CompetitivePersonalRecord record;

  const PersonalRecordDetailsSheet({
    super.key,
    required this.record,
  });

  static Future<void> show(BuildContext context, CompetitivePersonalRecord record) {
    return SoteriaBottomSheet.show(
      context,
      title: record.isCareerRecord ? 'Career Best' : 'Season Record',
      child: PersonalRecordDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        _buildHeader(),
        const SizedBox(height: 24),
        _buildDetailGrid(),
        const SizedBox(height: 32),
        if (record.matchId != null)
          SoteriaButton.primary(
            label: 'VIEW MATCH DETAILS',
            onPressed: () async {
              final repository = ref.read(matchHistoryRepositoryProvider);
              final match = await repository.getMatchDetail(record.userId, record.matchId!);
              
              if (context.mounted && match != null) {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => CompetitiveMatchDetailsSheet(match: match),
                );
              }
            },
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SoteriaColors.gold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
          ),
          child: const Icon(Icons.emoji_events, color: SoteriaColors.gold, size: 48),
        ),
        const SizedBox(height: 16),
        SoteriaText.headline(
          record.displayValue,
          color: SoteriaColors.gold,
        ),
        const SizedBox(height: 4),
        SoteriaText.body(
          _formatRecordType(record.type),
          color: Colors.white.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  Widget _buildDetailGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          _buildDetailRow('Value', record.displayValue, isHighlight: true),
          const Divider(height: 32, color: Colors.white10),
          _buildDetailRow('Achieved', DateFormat('MMMM d, yyyy').format(record.achievedAt)),
          const Divider(height: 32, color: Colors.white10),
          if (record.mode != null) ...[
            _buildDetailRow('Mode', record.mode!.toUpperCase()),
            const Divider(height: 32, color: Colors.white10),
          ],
          if (record.previousValue != null)
            _buildDetailRow(
              'Previous Best', 
              _formatValue(record.type, record.previousValue!),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SoteriaText.body(label, color: Colors.white.withValues(alpha: 0.5)),
        SoteriaText.body(
          value,
          color: isHighlight ? SoteriaColors.gold : Colors.white,
        ),
      ],
    );
  }

  String _formatValue(CompetitiveRecordType type, double value) {
    if (type == CompetitiveRecordType.bestAccuracy) {
      return '${(value * 100).toStringAsFixed(1)}%';
    }
    return value.toInt().toString();
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
        return 'Most Rank Points Gained';
      case CompetitiveRecordType.bestRankReached:
        return 'Best Rank Reached';
      case CompetitiveRecordType.bestLeaderboardPosition:
        return 'Best Leaderboard Position';
      case CompetitiveRecordType.bestSeasonPosition:
        return 'Best Season Position';
      case CompetitiveRecordType.mostWinsInSeason:
        return 'Most Wins in Season';
      case CompetitiveRecordType.bestModeScore:
        return 'Best Mode Score';
    }
  }
}
