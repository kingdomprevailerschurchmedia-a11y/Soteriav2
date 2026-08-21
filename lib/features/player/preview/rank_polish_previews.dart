import 'package:flutter/material.dart';
import '../domain/models/rank_progress.dart';
import '../domain/models/rank_tier.dart';
import '../presentation/widgets/competitive_rank_card.dart';
import '../presentation/widgets/rank_progress_bar.dart';

class RankPolishPreviews extends StatelessWidget {
  const RankPolishPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rank Progression Polish')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Competitive Rank Cards',
            children: [
              CompetitiveRankCard(
                rankProgress: _mockProgress(
                  rank: 'Gold II',
                  tierId: 'gold',
                  rp: 1450,
                  min: 1333,
                  max: 1665,
                  percentage: 0.35,
                  next: 'Gold I',
                  toNext: 216,
                ),
              ),
              const SizedBox(height: 16),
              CompetitiveRankCard(
                rankProgress: _mockProgress(
                  rank: 'Platinum I',
                  tierId: 'platinum',
                  rp: 3450,
                  min: 3000,
                  max: 3499,
                  percentage: 0.9,
                  next: 'Diamond III',
                  toNext: 50,
                ),
              ),
              const SizedBox(height: 16),
              CompetitiveRankCard(
                rankProgress: _mockProgress(
                  rank: 'Elite',
                  tierId: 'elite',
                  rp: 8500,
                  min: 7500,
                  max: 999999,
                  percentage: 1.0,
                  isMax: true,
                ),
              ),
            ],
          ),
          _Section(
            title: 'Progress Bar Variants',
            children: [
              const Text('Default'),
              RankProgressBar(
                progress: _mockProgress(
                  rank: 'Silver II',
                  tierId: 'silver',
                  rp: 750,
                  min: 666,
                  max: 832,
                  percentage: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Large'),
              RankProgressBar(
                variant: RankProgressVariant.large,
                progress: _mockProgress(
                  rank: 'Gold III',
                  tierId: 'gold',
                  rp: 1100,
                  min: 1000,
                  max: 1332,
                  percentage: 0.3,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Hero'),
              RankProgressBar(
                variant: RankProgressVariant.hero,
                progress: _mockProgress(
                  rank: 'Diamond I',
                  tierId: 'diamond',
                  rp: 4900,
                  min: 4500,
                  max: 4999,
                  percentage: 0.8,
                  next: 'Master III',
                ),
              ),
            ],
          ),
          _Section(
            title: 'Unranked State',
            children: [
              CompetitiveRankCard(
                rankProgress: _mockProgress(
                  rank: 'Unranked',
                  tierId: 'unranked',
                  rp: 45,
                  min: 0,
                  max: 99,
                  percentage: 0.45,
                  next: 'Bronze III',
                  toNext: 55,
                  isUnranked: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  RankProgress _mockProgress({
    required String rank,
    required String tierId,
    required int rp,
    required int min,
    required int max,
    required double percentage,
    String? next,
    int? toNext,
    bool isMax = false,
    bool isUnranked = false,
  }) {
    return RankProgress(
      currentRank: rank,
      currentRP: rp,
      minimumRP: min,
      maximumRP: max,
      progressPercentage: percentage,
      nextRank: next,
      rpToNextRank: toNext,
      isMaxRank: isMax,
      isUnranked: isUnranked,
      tier: RankTier(
        id: tierId,
        name: tierId.toUpperCase(),
        minPoints: min,
        maxPoints: max,
        displayOrder: 1, // Simplified for mock
        promotionThreshold: max + 1,
        demotionThreshold: min - 1,
        visualToken: '',
      ),
      division: 1,
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }
}
