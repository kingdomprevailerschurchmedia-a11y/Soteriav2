import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_empty_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../auth/providers/auth_providers.dart';
import '../providers/activity_providers.dart';
import '../widgets/activity/competitive_activity_card.dart';
import '../../domain/models/competitive_activity_event.dart';
import '../../domain/models/competitive_event.dart';

class CompetitiveActivityScreen extends ConsumerStatefulWidget {
  const CompetitiveActivityScreen({super.key});

  @override
  ConsumerState<CompetitiveActivityScreen> createState() =>
      _CompetitiveActivityScreenState();
}

class _CompetitiveActivityScreenState
    extends ConsumerState<CompetitiveActivityScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(activityFeedProvider(userId).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return _buildError(context);

    final activityAsync = ref.watch(activityFeedProvider(userId));

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('CAREER TIMELINE'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: context.titleMedium.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
      body: Column(
        children: [
          _ActivityFilterBar(),
          Expanded(
            child: activityAsync.when(
              data: (events) => _buildContent(context, events),
              loading: () => _buildLoading(),
              error: (error, _) => _buildError(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<CompetitiveActivityEvent> events,
  ) {
    if (events.isEmpty) {
      return Center(
        child: SoteriaEmptyState(
          title: 'Journey Starting',
          subtitle:
              'Your competitive accomplishments will appear here. Play your first game to start your timeline.',
          icon: Icons.timeline_rounded,
          actionLabel: 'START COMPETING',
          onActionPressed: () => context.go('/app/practice'),
        ),
      );
    }

    final userId = ref.read(authRepositoryProvider).currentUserId!;
    final hasMore = ref.read(activityFeedProvider(userId).notifier).hasMore;
    final groupedEvents = _groupEvents(events);
    final timelineItems = _flattenGroupedEvents(groupedEvents);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(activityFeedProvider(userId).notifier).loadInitial(),
      color: SoteriaColors.primary,
      backgroundColor: SoteriaColors.background,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.lg,
          vertical: SoteriaSpacing.lg,
        ),
        itemCount: timelineItems.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == timelineItems.length) {
            return hasMore ? _buildLoadMoreIndicator() : _buildEndOfList();
          }

          final item = timelineItems[index];
          if (item.isHeader) {
            return _buildGroupHeader(context, item.title!);
          }

          return CompetitiveActivityCard(
            event: item.event!,
            isLast: _isLastInGlobalList(index, timelineItems, hasMore),
            onTap: () => _showEventDetails(context, item.event!),
          );
        },
      ),
    );
  }

  List<_TimelineItem> _flattenGroupedEvents(
    Map<String, List<CompetitiveActivityEvent>> grouped,
  ) {
    final items = <_TimelineItem>[];
    grouped.forEach((title, events) {
      items.add(_TimelineItem.header(title));
      for (final event in events) {
        items.add(_TimelineItem.event(event));
      }
    });
    return items;
  }

  Map<String, List<CompetitiveActivityEvent>> _groupEvents(
    List<CompetitiveActivityEvent> events,
  ) {
    final groups = <String, List<CompetitiveActivityEvent>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final event in events) {
      final eventDate = DateTime(
        event.createdAt.year,
        event.createdAt.month,
        event.createdAt.day,
      );
      String groupTitle;
      if (eventDate == today) {
        groupTitle = 'TODAY';
      } else if (eventDate == yesterday) {
        groupTitle = 'YESTERDAY';
      } else {
        groupTitle = DateFormat('MMMM d, yyyy').format(eventDate).toUpperCase();
      }
      groups.putIfAbsent(groupTitle, () => []).add(event);
    }
    return groups;
  }

  bool _isLastInGlobalList(
    int index,
    List<_TimelineItem> items,
    bool hasMore,
  ) {
    if (hasMore) return false;
    if (index == items.length - 1) return true;
    return items[index + 1].isHeader;
  }

  Widget _buildGroupHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.lg, top: SoteriaSpacing.md),
      child: Row(
        children: [
          Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.lg),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24.w,
        height: 24.w,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: SoteriaColors.primary,
        ),
      ),
    );
  }

  Widget _buildEndOfList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xl),
      child: Center(
        child: Text(
          'END OF CAREER TIMELINE',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted.withValues(alpha: 0.3),
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: SoteriaColors.primary),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 48,
          ),
          SizedBox(height: SoteriaSpacing.md),
          const Text('Failed to load timeline history'),
          TextButton(
            onPressed: () {
              final userId = ref.read(authRepositoryProvider).currentUserId;
              if (userId != null) {
                ref.read(activityFeedProvider(userId).notifier).loadInitial();
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, CompetitiveActivityEvent event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _ActivityEventDetailView(event: event),
    );
  }
}

class _ActivityEventDetailView extends StatelessWidget {
  final CompetitiveActivityEvent event;
  const _ActivityEventDetailView({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(SoteriaRadius.xl)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
          ),
        ],
      ),
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(SoteriaRadius.sm),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Row(
            children: [
              _buildLargeIcon(event),
              SizedBox(width: SoteriaSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      _formatFullDate(event.createdAt),
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            event.description,
            style: context.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const Spacer(),
          if (event.deepLink != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Implementation of navigation based on deepLink
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SoteriaColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SoteriaRadius.md),
                  ),
                ),
                child: const Text('VIEW DETAILS'),
              ),
            ),
          SizedBox(height: SoteriaSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildLargeIcon(CompetitiveActivityEvent event) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: SoteriaColors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Icon(
        _getIconData(event.type),
        color: SoteriaColors.primary,
        size: 36.sp,
      ),
    );
  }

  IconData _getIconData(CompetitiveEventType type) {
    switch (type) {
      case CompetitiveEventType.rankPromoted:
        return Icons.trending_up_rounded;
      case CompetitiveEventType.rankDemoted:
        return Icons.trending_down_rounded;
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.achievementUnlocked:
        return Icons.auto_awesome_rounded;
      case CompetitiveEventType.rewardReceived:
        return Icons.card_giftcard_rounded;
      case CompetitiveEventType.seasonCompleted:
        return Icons.event_available_rounded;
      case CompetitiveEventType.personalBest:
        return Icons.star_rounded;
      case CompetitiveEventType.streakReached:
        return Icons.local_fire_department_rounded;
      default:
        return Icons.stars_rounded;
    }
  }

  String _formatFullDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date) +
        ' at ' +
        DateFormat('HH:mm').format(date);
  }
}

class _ActivityFilterBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(activityFilterProvider);

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.sm),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        itemCount: ActivityFilter.values.length,
        itemBuilder: (context, index) {
          final filter = ActivityFilter.values[index];
          final isSelected = currentFilter == filter;

          return Padding(
            padding: EdgeInsets.only(right: SoteriaSpacing.sm),
            child: GestureDetector(
              onTap: () => ref.read(activityFilterProvider.notifier).state = filter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? SoteriaColors.primary
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(SoteriaRadius.full),
                  border: Border.all(
                    color: isSelected
                        ? SoteriaColors.secondary.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  filter.name.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: isSelected ? Colors.white : SoteriaColors.muted,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TimelineItem {
  final String? title;
  final CompetitiveActivityEvent? event;
  final bool isHeader;

  _TimelineItem.header(this.title)
    : event = null,
      isHeader = true;
  _TimelineItem.event(this.event)
    : title = null,
      isHeader = false;
}
