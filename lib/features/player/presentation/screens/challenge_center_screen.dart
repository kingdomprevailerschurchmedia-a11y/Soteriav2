import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../providers/challenge_providers.dart';
import '../widgets/challenge/incoming_challenge_card.dart';
import '../widgets/challenge/outgoing_challenge_card.dart';
import '../../../../core/navigation/soteria_routes.dart';

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
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIncomingList(incomingAsync),
                _buildOutgoingList(outgoingAsync),
              ],
            ),
          ),
          _buildBottomActionCard(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg, vertical: 16.h),
      child: Column(
        children: [
          Row(
            children: [
              const SoteriaBackButton(),
              const Spacer(),
              Text(
                'CHALLENGE CENTER',
                style: context.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 48), // Equal spacing for center alignment
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, SoteriaColors.secondary.withValues(alpha: 0.5)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: const Icon(Icons.bolt_rounded, color: SoteriaColors.secondary, size: 20),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [SoteriaColors.secondary.withValues(alpha: 0.5), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.4),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
        indicator: _GlowingTabIndicator(
          color: SoteriaColors.secondary,
          width: 3,
        ),
        tabs: const [
          Tab(text: 'INCOMING'),
          Tab(text: 'OUTGOING'),
        ],
      ),
    );
  }

  Widget _buildIncomingList(AsyncValue<List<dynamic>> incomingAsync) {
    return incomingAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) {
          return _buildEmptyState(
            'No pending',
            'invitations',
            "You're all caught up! When someone\nchallenges you, it'll appear here.",
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: challenges.length,
          itemBuilder: (context, index) => IncomingChallengeCard(challenge: challenges[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: SoteriaColors.secondary)),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildOutgoingList(AsyncValue<List<dynamic>> outgoingAsync) {
    return outgoingAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) {
          return _buildEmptyState(
            'No outgoing',
            'challenges',
            "You haven't challenged anyone yet.\nStart a rivalry and rise to the top!",
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: challenges.length,
          itemBuilder: (context, index) => OutgoingChallengeCard(challenge: challenges[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: SoteriaColors.secondary)),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEmptyState(String line1, String line2, String subtext) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Atmospheric Circles
                Container(
                  width: 240.w,
                  height: 240.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
                  ),
                ),
                Container(
                  width: 180.w,
                  height: 180.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
                  ),
                ),
                // Glow Effect
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.secondary.withValues(alpha: 0.3),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
                // Main Icon
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFB980FF), Color(0xFF7C4DFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.bolt_rounded,
                    size: 100.sp,
                    color: Colors.white,
                  ),
                ),
                // Small stars/plus decorations
                ...List.generate(4, (index) {
                  final offsets = [
                    Offset(-100.w, -60.h),
                    Offset(100.w, 40.h),
                    Offset(-80.w, 80.h),
                    Offset(80.w, -80.h),
                  ];
                  return Transform.translate(
                    offset: offsets[index],
                    child: Icon(Icons.add, size: 12.sp, color: Colors.white.withValues(alpha: 0.2)),
                  );
                }),
              ],
            ),
            SizedBox(height: 40.h),
            Text(
              line1,
              style: context.headlineMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32.sp,
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFB980FF), Color(0xFF7C4DFF)],
              ).createShader(bounds),
              child: Text(
                line2,
                style: context.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 32.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              subtext,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SoteriaSpacing.lg),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push(SoteriaRoutes.playerSearch),
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: SoteriaColors.secondary.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: SoteriaColors.secondary.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.person_add_rounded, color: Colors.white, size: 24),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Challenge your friends',
                  style: context.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Start a challenge and compete to earn rewards!',
                  style: context.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: () => context.push('/app/practice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              shadowColor: Colors.transparent,
              side: BorderSide.none,
            ).copyWith(
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(const Color(0xFF2E1A8A).withValues(alpha: 0.8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Go to Practice', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)),
                SizedBox(width: 4.w),
                const Icon(Icons.chevron_right_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowingTabIndicator extends Decoration {
  final Color color;
  final double width;

  const _GlowingTabIndicator({required this.color, required this.width});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GlowingTabPainter(this, onChanged);
  }
}

class _GlowingTabPainter extends BoxPainter {
  final _GlowingTabIndicator decoration;

  _GlowingTabPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final rect = offset & configuration.size!;
    final paint = Paint()
      ..color = decoration.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = decoration.width
      ..strokeCap = StrokeCap.round;

    final indicatorWidth = 40.w;
    final xPos = rect.left + (rect.width - indicatorWidth) / 2;
    final yPos = rect.bottom - decoration.width;

    // Draw Glow
    final glowPaint = Paint()
      ..color = decoration.color.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    
    canvas.drawLine(
      Offset(xPos, yPos),
      Offset(xPos + indicatorWidth, yPos),
      glowPaint,
    );

    // Draw Main Line
    canvas.drawLine(
      Offset(xPos, yPos),
      Offset(xPos + indicatorWidth, yPos),
      paint,
    );
  }
}

