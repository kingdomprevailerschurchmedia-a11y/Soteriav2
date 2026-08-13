import 'package:flutter/material.dart';
import '../domain/models/rank_change.dart';
import '../presentation/screens/rank_promotion_screen.dart';
import '../presentation/screens/rank_demotion_screen.dart';
import '../presentation/widgets/competitive_rank_badge.dart';
import '../presentation/widgets/rank_change_details.dart';

class RankExperiencePreviews extends StatelessWidget {
  const RankExperiencePreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rank Experience Previews')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Rank Badges',
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  const CompetitiveRankBadge(
                    tierId: 'bronze',
                    rankName: 'Bronze III',
                  ),
                  const CompetitiveRankBadge(
                    tierId: 'gold',
                    rankName: 'Gold I',
                    hasGlow: true,
                  ),
                  const CompetitiveRankBadge(
                    tierId: 'platinum',
                    rankName: 'Platinum II',
                    size: RankBadgeSize.large,
                  ),
                  const CompetitiveRankBadge(
                    tierId: 'elite',
                    rankName: 'Elite',
                    size: RankBadgeSize.large,
                    hasGlow: true,
                  ),
                ],
              ),
            ],
          ),
          _Section(
            title: 'Rank Change Details',
            children: [
              RankChangeDetails(
                rankChange: RankChange(
                  changeId: '1',
                  userId: 'user',
                  seasonId: '5',
                  previousRank: 'Gold II',
                  newRank: 'Gold I',
                  previousRankPoints: 1300,
                  newRankPoints: 1342,
                  changeAmount: 42,
                  type: RankChangeType.divisionPromotion,
                  createdAt: DateTime.now(),
                ),
              ),
              const Divider(),
              RankChangeDetails(
                rankChange: RankChange(
                  changeId: '2',
                  userId: 'user',
                  seasonId: '5',
                  previousRank: 'Gold I',
                  newRank: 'Gold II',
                  previousRankPoints: 1010,
                  newRankPoints: 985,
                  changeAmount: -25,
                  type: RankChangeType.divisionDemotion,
                  createdAt: DateTime.now(),
                ),
              ),
            ],
          ),
          _Section(
            title: 'Screens (Click to Show)',
            children: [
              ListTile(
                title: const Text('Division Promotion'),
                onTap:
                    () => _showPromotion(
                      context,
                      isTierChange: false,
                      prevRank: 'Gold II',
                      newRank: 'Gold I',
                    ),
              ),
              ListTile(
                title: const Text('Tier Promotion (Gold -> Platinum)'),
                onTap:
                    () => _showPromotion(
                      context,
                      isTierChange: true,
                      prevRank: 'Gold I',
                      newRank: 'Platinum III',
                    ),
              ),
              ListTile(
                title: const Text('Rank Demotion'),
                onTap: () => _showDemotion(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPromotion(
    BuildContext context, {
    required bool isTierChange,
    required String prevRank,
    required String newRank,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => RankPromotionScreen(
            rankChange: RankChange(
              changeId: 'promo',
              userId: 'user',
              seasonId: '5',
              previousRank: prevRank,
              newRank: newRank,
              previousRankPoints: 1980,
              newRankPoints: 2025,
              changeAmount: 45,
              type: RankChangeType.promotion,
              isTierChange: isTierChange,
              createdAt: DateTime.now(),
            ),
            onContinue: () => Navigator.of(context).pop(),
          ),
    );
  }

  void _showDemotion(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => RankDemotionScreen(
            rankChange: RankChange(
              changeId: 'demo',
              userId: 'user',
              seasonId: '5',
              previousRank: 'Gold II',
              newRank: 'Gold III',
              previousRankPoints: 1015,
              newRankPoints: 995,
              changeAmount: -20,
              type: RankChangeType.demotion,
              createdAt: DateTime.now(),
            ),
            onContinue: () => Navigator.of(context).pop(),
          ),
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
          padding: const EdgeInsets.symmetric(vertical: 8),
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
