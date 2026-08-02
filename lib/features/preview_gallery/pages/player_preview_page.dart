import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';

class PlayerPreviewPage extends StatelessWidget {
  const PlayerPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockProfile = PlayerProfile(
      uid: 'mock-uid',
      displayName: 'Archimedes',
      email: 'archimedes@soteria.com',
      level: 42,
      xp: 12500,
      coins: 850,
      currentStreak: 7,
      highestStreak: 21,
      totalQuestionsAnswered: 450,
      correctAnswers: 380,
      accuracy: 0.84,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
      achievements: ['First Win', 'Knowledge Seeker'],
      badges: ['Beta Tester'],
    );

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text(
          'Player Identity Card',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        _IdentityCard(profile: mockProfile),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Progression Stats',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        _StatsGrid(profile: mockProfile),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Achievements & Badges',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: SoteriaSpacing.md),
        _AchievementsList(profile: mockProfile),
      ],
    );
  }
}

class _IdentityCard extends StatelessWidget {
  final PlayerProfile profile;
  const _IdentityCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: SoteriaColors.primary.withValues(alpha: 0.2),
            child: const Icon(
              Icons.person_rounded,
              color: SoteriaColors.primary,
              size: 32,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName.toUpperCase(),
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  profile.email,
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
                SizedBox(height: SoteriaSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: SoteriaColors.gold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'LEVEL ${profile.level}',
                    style: const TextStyle(
                      color: SoteriaColors.gold,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final PlayerProfile profile;
  const _StatsGrid({required this.profile});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        _StatItem(
          label: 'Coins',
          value: profile.coins.toString(),
          icon: Icons.monetization_on_rounded,
          color: SoteriaColors.gold,
        ),
        _StatItem(
          label: 'Streak',
          value: '${profile.currentStreak} Days',
          icon: Icons.local_fire_department_rounded,
          color: Colors.orange,
        ),
        _StatItem(
          label: 'Accuracy',
          value: '${(profile.accuracy * 100).toInt()}%',
          icon: Icons.track_changes_rounded,
          color: SoteriaColors.success,
        ),
        _StatItem(
          label: 'Questions',
          value: profile.totalQuestionsAnswered.toString(),
          icon: Icons.quiz_rounded,
          color: SoteriaColors.primary,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: SoteriaSpacing.sm),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementsList extends StatelessWidget {
  final PlayerProfile profile;
  const _AchievementsList({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...profile.badges.map((b) => _BadgeChip(label: b, isBadge: true)),
        ...profile.achievements.map(
          (a) => _BadgeChip(label: a, isBadge: false),
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;
  final bool isBadge;
  const _BadgeChip({required this.label, required this.isBadge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isBadge
            ? SoteriaColors.primary.withValues(alpha: 0.1)
            : Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBadge
              ? SoteriaColors.primary.withValues(alpha: 0.3)
              : Colors.white24,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isBadge ? SoteriaColors.primary : Colors.white70,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
