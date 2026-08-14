import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../providers/challenge_providers.dart';
import '../widgets/challenge/incoming_challenge_card.dart';
import '../widgets/challenge/outgoing_challenge_card.dart';

class ChallengeCenterScreen extends ConsumerStatefulWidget {
  const ChallengeCenterScreen({super.key});

  @override
  ConsumerState<ChallengeCenterScreen> createState() => _ChallengeCenterScreenState();
}

class _ChallengeCenterScreenState extends ConsumerState<ChallengeCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incomingAsync = ref.watch(incomingChallengesProvider);
    final outgoingAsync = ref.watch(outgoingChallengesProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('CHALLENGE CENTER'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: SoteriaColors.primary,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('INCOMING'),
                  if (incomingAsync.valueOrNull?.isNotEmpty ?? false) ...[
                    SizedBox(width: 8.w),
                    _buildBadge(incomingAsync.valueOrNull!.length),
                  ],
                ],
              ),
            ),
            const Tab(text: 'OUTGOING'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIncomingList(incomingAsync),
          _buildOutgoingList(outgoingAsync),
        ],
      ),
    );
  }

  Widget _buildIncomingList(AsyncValue<List<dynamic>> incomingAsync) {
    return incomingAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) return _buildEmptyState('No pending invitations.');
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: challenges.length,
          itemBuilder: (context, index) => IncomingChallengeCard(challenge: challenges[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildOutgoingList(AsyncValue<List<dynamic>> outgoingAsync) {
    return outgoingAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) return _buildEmptyState('You haven\'t challenged anyone yet.');
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: challenges.length,
          itemBuilder: (context, index) => OutgoingChallengeCard(challenge: challenges[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildBadge(int count) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: const BoxDecoration(color: SoteriaColors.error, shape: BoxShape.circle),
      constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
      child: Center(
        child: Text(
          count.toString(),
          style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bolt_rounded, size: 64.w, color: SoteriaColors.muted.withValues(alpha: 0.2)),
          SizedBox(height: SoteriaSpacing.md),
          Text(message, style: context.bodyMedium.copyWith(color: SoteriaColors.muted)),
        ],
      ),
    );
  }
}
