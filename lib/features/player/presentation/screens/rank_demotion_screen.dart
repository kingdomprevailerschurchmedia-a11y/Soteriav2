import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/rank_change.dart';
import '../widgets/competitive_rank_badge.dart';
import '../widgets/rank_change_details.dart';

class RankDemotionScreen extends StatelessWidget {
  final RankChange rankChange;
  final VoidCallback onContinue;

  const RankDemotionScreen({
    super.key,
    required this.rankChange,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Dim
          GestureDetector(
            onTap: onContinue,
            child: Container(color: Colors.black.withValues(alpha: 0.9)),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'RANK ADJUSTED',
                    style: context.headlineMedium.copyWith(
                      color: SoteriaColors.textPrimary,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.sm),
                  Text(
                    'SEASON ${rankChange.seasonId.toUpperCase()}',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.textSecondary,
                      letterSpacing: 2.0,
                    ),
                  ),

                  SizedBox(height: SoteriaSpacing.xxl),

                  // Rank Badge
                  CompetitiveRankBadge(
                    tierId: rankChange.newRank.split(' ')[0].toLowerCase(),
                    rankName: rankChange.newRank,
                    size: RankBadgeSize.large,
                  ),

                  SizedBox(height: SoteriaSpacing.xxl),

                  // Rank Details
                  RankChangeDetails(rankChange: rankChange),

                  SizedBox(height: SoteriaSpacing.xxxl),

                  // Encouraging Message
                  Text(
                    'Competition is tough. Take a breath, analyze your games, and rise again. Your next climb starts here.',
                    textAlign: TextAlign.center,
                    style: context.bodyLarge.copyWith(
                      color: SoteriaColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: SoteriaSpacing.xxxl),

                  // Action
                  SoteriaButton.secondary(
                    label: 'UNDERSTOOD',
                    onPressed: onContinue,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
