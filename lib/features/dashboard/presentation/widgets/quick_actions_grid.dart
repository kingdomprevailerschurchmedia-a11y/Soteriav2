import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
import '../../../../core/utils/soteria_responsive.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(navigationCoordinatorProvider);
    final isTablet = SoteriaResponsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/quick_action_icon_transparent.png',
                width: 28.w,
                height: 28.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10.w),
              Text(
                'QUICK ACTIONS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GridView.count(
            crossAxisCount: isTablet ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.25,
            children: [
              _ActionCard(
                title: 'Practice',
                subtitle: 'Level Up',
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF9155FD),
                delay: 100,
                onTap: nav.playPractice,
              ),
              _ActionCard(
                title: 'Pro Mode',
                subtitle: 'Win Coins',
                icon: Icons.emoji_events_rounded,
                color: const Color(0xFFFF9F43),
                delay: 200,
                onTap: nav.playProMode,
              ),
              _ActionCard(
                title: 'Versus',
                subtitle: '1v1 Match',
                icon: Icons.flash_on_rounded,
                color: const Color(0xFF2196F3),
                delay: 300,
                onTap: nav.playVersus,
              ),
              _ActionCard(
                title: 'Tournament',
                subtitle: 'Compete',
                icon: Icons.workspace_premium_rounded,
                color: const Color(0xFF4CAF50),
                delay: 400,
                onTap: nav.playTournament,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatefulWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.delay,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int delay;
  final VoidCallback onTap;

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoteriaFadeIn(
      delay: Duration(milliseconds: widget.delay),
      child: SoteriaScaleIn(
        delay: Duration(milliseconds: widget.delay),
        begin: 0.95,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          onTap: widget.onTap,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white.withValues(alpha: 0.03),
                border: Border.all(
                  color: widget.color.withValues(alpha: 0.2),
                  width: 1.2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Stack(
                  children: [
                    // Ghost Icon
                    Positioned(
                      right: -10.w,
                      top: 15.h,
                      child: Opacity(
                        opacity: 0.05,
                        child: Icon(
                          widget.icon,
                          size: 80.sp,
                          color: widget.color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Glowing Icon Container
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: widget.color.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: widget.color.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.color.withValues(alpha: 0.6),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.title,
                            style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 16.sp,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: context.labelSmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action Arrow Button
                    Positioned(
                      right: 16.w,
                      bottom: 16.h,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
