import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/components/soteria_avatar.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/components/soteria_stats_widgets.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

class DashboardRedesignPreview extends StatelessWidget {
  const DashboardRedesignPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final player = MockDataFactory.createMockPlayer();

    return PreviewWrapper(
      title: 'Dashboard Redesign',
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            _buildAppBar(context, player),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),
            _buildHeroCard(context, player),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),
            _buildQuickActions(context),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),
            _buildDailyChallenge(context),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),
            _buildRecentActivity(context),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl)),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, dynamic player) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      sliver: SliverToBoxAdapter(
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GOOD MORNING,',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    player.displayName.split(' ')[0],
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SoteriaStreakWidget(streak: player.currentStreak),
                  SizedBox(width: SoteriaSpacing.md),
                  SoteriaAvatar(url: player.photoUrl, isOnline: true, size: 44),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, dynamic player) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: SoteriaCard(
          hasGlow: true,
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SoteriaBadge(
                    label: player.role,
                    variant: SoteriaBadgeVariant.gold,
                  ),
                  SoteriaCoinWidget(amount: player.coins),
                ],
              ),
              SizedBox(height: SoteriaSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: SoteriaXPBar(
                      currentXP: player.xp,
                      nextLevelXP: 5000,
                      level: player.level,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.6,
        children: [
          _ActionCard(
            label: 'PRACTICE',
            icon: Icons.school_rounded,
            color: SoteriaColors.primary,
          ),
          _ActionCard(
            label: 'GO PRO',
            icon: Icons.workspace_premium_rounded,
            color: SoteriaColors.gold,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallenge(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: SoteriaCard(
          borderColor: SoteriaColors.primary.withValues(alpha: 0.2),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: SoteriaColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flash_on_rounded,
                  color: SoteriaColors.primary,
                ),
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DAILY CHALLENGE',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'Encryption Master',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SoteriaBadge(
                label: '+100 XP',
                variant: SoteriaBadgeVariant.info,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RECENT ACTIVITY',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            _ActivityRow(label: 'Completed Practice', time: '2h ago', xp: 50),
            _ActivityRow(label: 'Unlocked Badge', time: '5h ago', xp: 150),
          ],
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brFull,
        border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Colors.orange,
            size: 16,
          ),
          SizedBox(width: 4.w),
          Text(
            streak.toString(),
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularXP extends StatelessWidget {
  final double progress;
  const _CircularXP({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 54.w,
          height: 54.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            backgroundColor: Colors.white10,
            color: SoteriaColors.primary,
          ),
        ),
        const Icon(Icons.bolt_rounded, color: SoteriaColors.primary, size: 20),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            label,
            style: context.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String label;
  final String time;
  final int xp;

  const _ActivityRow({
    required this.label,
    required this.time,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: SoteriaColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: SoteriaColors.muted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+$xp XP',
            style: const TextStyle(
              color: SoteriaColors.info,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
