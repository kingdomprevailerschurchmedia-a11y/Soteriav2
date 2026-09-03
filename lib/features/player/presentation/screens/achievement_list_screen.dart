import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_stats_widgets.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../auth/providers/auth_providers.dart';
import '../providers/achievement_providers.dart';
import '../providers/milestone_providers.dart';
import '../widgets/milestone_card.dart';
import '../widgets/milestone_celebration.dart';
import '../widgets/competitive_milestone_details.dart';
import '../../domain/models/achievement.dart';
import '../../domain/models/milestone.dart';
import '../../providers/player_providers.dart';

class AchievementListScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const AchievementListScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<AchievementListScreen> createState() => _AchievementListScreenState();
}

class _AchievementListScreenState extends ConsumerState<AchievementListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: Column(
        children: [
          _Header(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _AchievementsTab(),
                _MilestonesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  final TabController tabController;

  const _Header({required this.tabController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SoteriaBackButton(),
                Text(
                  'ACHIEVEMENTS',
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 18.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1638).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: SoteriaCoinWidget(amount: player?.coins ?? 0, size: 16),
                ),
              ],
            ),
          ),
          TabBar(
            controller: tabController,
            indicatorColor: SoteriaColors.gold,
            labelColor: Colors.white,
            unselectedLabelColor: SoteriaColors.muted,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            labelStyle: context.labelSmall.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
            tabs: const [
              Tab(text: 'CAREER'),
              Tab(text: 'SEASONAL'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(achievementProgressProvider);

    return progressAsync.when(
      data: (list) {
        final completed = list.where((p) => p.isCompleted).toList();
        final inProgress = list.where((p) => !p.isCompleted).toList();
        final earnedCount = completed.length;
        final totalCount = list.length;

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          children: [
            _CompletionSummary(
              earned: earnedCount,
              total: totalCount,
              title: 'CAREER ACHIEVEMENTS',
            ),
            if (inProgress.isNotEmpty) ...[
              _SectionHeader(title: 'IN PROGRESS'),
              ...inProgress.map((p) => _AchievementListItem(progress: p)),
            ],
            if (completed.isNotEmpty) ...[
              _SectionHeader(title: 'COMPLETED'),
              ...completed.map((p) => _AchievementListItem(progress: p)),
            ],
            SoteriaSpacing.gapXXXL,
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}

class _MilestonesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger evaluation
    ref.watch(milestoneEvaluationProvider);
    final progressAsync = ref.watch(milestoneProgressProvider);

    return progressAsync.when(
      data: (list) {
        final completed = list.where((p) => p.isCompleted).toList();
        final inProgress = list.where((p) => !p.isCompleted).toList();
        final earnedCount = completed.length;
        final totalCount = list.length;

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          children: [
            _CompletionSummary(
              earned: earnedCount,
              total: totalCount,
              title: 'SEASONAL MILESTONES',
            ),
            if (inProgress.isNotEmpty) ...[
              _SectionHeader(title: 'IN PROGRESS'),
              ...inProgress.map(
                (p) => Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: MilestoneCard(
                    progress: p,
                    onTap: () => _showMilestoneDetails(context, ref, p),
                  ),
                ),
              ),
            ],
            if (completed.isNotEmpty) ...[
              _SectionHeader(title: 'COMPLETED'),
              ...completed.map(
                (p) => Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: MilestoneCard(
                    progress: p,
                    onTap: () => _showMilestoneDetails(context, ref, p),
                    onClaim: p.playerState?.status == MilestoneStatus.completed
                        ? () => _claimMilestoneReward(context, ref, p)
                        : null,
                    isClaiming: ref.watch(milestoneClaimControllerProvider).isLoading,
                  ),
                ),
              ),
            ],
            SoteriaSpacing.gapXXXL,
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }

  void _showMilestoneDetails(BuildContext context, WidgetRef ref, MilestoneProgress p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CompetitiveMilestoneDetails(
        progress: p,
        onClaim: p.playerState?.status == MilestoneStatus.completed
            ? () => _claimMilestoneReward(context, ref, p)
            : null,
        isClaiming: ref.watch(milestoneClaimControllerProvider).isLoading,
      ),
    );
  }

  Future<void> _claimMilestoneReward(
    BuildContext context,
    WidgetRef ref,
    MilestoneProgress p,
  ) async {
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    await ref.read(milestoneClaimControllerProvider.notifier).claim(
      userId: userId,
      milestoneId: p.definition.id,
    );

    if (context.mounted) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      MilestoneCelebration.show(context, definition: p.definition);
    }
  }
}

class _CompletionSummary extends StatelessWidget {
  final int earned;
  final int total;
  final String title;

  const _CompletionSummary({
    required this.earned,
    required this.total,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? earned / total : 0.0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xl),
      child: Column(
        children: [
          Text(
            '${(progress * 100).toInt()}%',
            style: context.displaySmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            '$earned of $total unlocked',
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SoteriaSpacing.lg,
        bottom: SoteriaSpacing.md,
      ),
      child: Text(
        title,
        style: context.labelSmall.copyWith(
          color: SoteriaColors.gold,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _AchievementListItem extends ConsumerWidget {
  final AchievementProgress progress;
  const _AchievementListItem({required this.progress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final def = progress.definition;
    final isCompleted = progress.isCompleted;
    final isClaimed = progress.isClaimed;

    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: SoteriaCard(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                _AchievementIcon(definition: def, isUnlocked: isCompleted),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        def.title,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? Colors.white : SoteriaColors.muted,
                        ),
                      ),
                      Text(
                        def.description,
                        style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                      ),
                    ],
                  ),
                ),
                if (isCompleted && !isClaimed)
                  Icon(
                    Icons.check_circle_rounded,
                    color: SoteriaColors.success,
                    size: 20.sp,
                  ),
                if (isClaimed)
                   Text(
                    'CLAIMED',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      fontWeight: FontWeight.w900,
                      fontSize: 8.sp,
                    ),
                  ),
              ],
            ),
            if (!isCompleted) ...[
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress.progressPercentage,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
                  minHeight: 2.h,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PROGRESS',
                    style: context.labelSmall.copyWith(color: Colors.white24, fontSize: 8.sp),
                  ),
                  Text(
                    '${progress.playerState.currentValue.toInt()} / ${def.threshold.toInt()}',
                    style: context.labelSmall.copyWith(color: Colors.white70, fontSize: 8.sp),
                  ),
                ],
              ),
            ],
            if (isCompleted && !isClaimed) ...[
              SizedBox(height: 12.h),
              SoteriaButton.reward(
                label: 'CLAIM ${def.coinReward} COINS',
                onPressed: () => _claimAchievement(context, ref),
                isLoading: ref.watch(achievementClaimControllerProvider).isLoading,
                size: SoteriaButtonSize.sm,
                isFullWidth: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _claimAchievement(BuildContext context, WidgetRef ref) async {
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    await ref.read(achievementClaimControllerProvider.notifier).claim(
          userId: userId,
          achievementId: progress.definition.id,
        );

    if (context.mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Claimed reward for ${progress.definition.title}!'),
          backgroundColor: SoteriaColors.success,
        ),
      );
    }
  }
}

class _AchievementIcon extends StatelessWidget {
  final AchievementDefinition definition;
  final bool isUnlocked;

  const _AchievementIcon({
    required this.definition,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.r,
      height: 44.r,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: isUnlocked
            ? SoteriaColors.gold.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.03),
        shape: BoxShape.circle,
        border: Border.all(
          color: isUnlocked ? SoteriaColors.gold.withValues(alpha: 0.2) : Colors.white10,
        ),
      ),
      child: (definition.id == 'first_game' || definition.id == 'welcome_bonus') && isUnlocked
          ? Image.asset(
              definition.id == 'first_game'
                  ? 'assets/icons/first_step_icon.png'
                  : 'assets/icons/star_icon.png',
              fit: BoxFit.contain,
            )
          : Icon(
              _getIcon(definition.icon),
              color: isUnlocked ? SoteriaColors.gold : SoteriaColors.muted,
              size: 20.sp,
            ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'stars_rounded':
        return Icons.stars_rounded;
      case 'military_tech_rounded':
        return Icons.military_tech_rounded;
      case 'workspace_premium_rounded':
        return Icons.workspace_premium_rounded;
      case 'local_fire_department_rounded':
        return Icons.local_fire_department_rounded;
      case 'bolt_rounded':
        return Icons.bolt_rounded;
      case 'trending_up_rounded':
        return Icons.trending_up_rounded;
      case 'shield_rounded':
        return Icons.shield_rounded;
      case 'play_arrow_rounded':
        return Icons.play_arrow_rounded;
      case 'sports_esports_rounded':
        return Icons.sports_esports_rounded;
      case 'emoji_events_rounded':
        return Icons.emoji_events_rounded;
      case 'psychology_rounded':
        return Icons.psychology_rounded;
      case 'auto_awesome_rounded':
        return Icons.auto_awesome_rounded;
      case 'calendar_today_rounded':
        return Icons.calendar_today_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
