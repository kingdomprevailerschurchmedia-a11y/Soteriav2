import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_empty_state.dart';
import '../../../auth/providers/auth_providers.dart';
import '../providers/activity_providers.dart';
import '../widgets/activity/competitive_activity_card.dart';
import '../../domain/models/competitive_activity_event.dart';

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
        title: const Text('Career Timeline'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: activityAsync.when(
        data: (events) => _buildContent(context, events),
        loading: () => _buildLoading(),
        error: (error, _) => _buildError(context),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<CompetitiveActivityEvent> events,
  ) {
    if (events.isEmpty) {
      return const Center(
        child: SoteriaEmptyState(
          title: 'Journey Starting',
          subtitle:
              'Your competitive accomplishments will appear here. Play your first game to start your timeline.',
          icon: Icons.timeline_rounded,
        ),
      );
    }

    final userId = ref.read(authRepositoryProvider).currentUserId!;
    final hasMore = ref.read(activityFeedProvider(userId).notifier).hasMore;

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(activityFeedProvider(userId).notifier).loadInitial(),
      color: SoteriaColors.primary,
      backgroundColor: SoteriaColors.background,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.lg,
          vertical: SoteriaSpacing.xl,
        ),
        itemCount: events.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == events.length) {
            return hasMore ? _buildLoadMoreIndicator() : _buildEndOfList();
          }

          final event = events[index];
          return CompetitiveActivityCard(
            event: event,
            isLast: index == events.length - 1 && !hasMore,
            onTap: () => _showEventDetails(context, event),
          );
        },
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
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: SoteriaColors.backgroundTopLeft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
                color: Colors.white12,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Row(
            children: [
              _buildLargeIcon(event),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
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
            style: context.bodyLarge.copyWith(color: Colors.white70),
          ),
          const Spacer(),
          if (event.deepLink != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
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
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.stars_rounded,
        color: SoteriaColors.primary,
        size: 32.sp,
      ),
    );
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
