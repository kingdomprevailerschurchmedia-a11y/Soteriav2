import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
import '../../../../core/design_system/components/soteria_card.dart';

import '../../../../core/utils/soteria_responsive.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(navigationCoordinatorProvider);
    final isTablet = SoteriaResponsive.isTablet(context);
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QUICK ACTIONS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See All',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.secondary,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: SoteriaColors.secondary,
                    size: 18.sp,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
          ),
          GridView.count(
            crossAxisCount: isTablet ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: isTablet ? 1.7 : 1.4,
            children: [
              _ActionCard(
                title: 'Practice',
                subtitle: 'Level Up',
                icon: Icons.menu_book_rounded,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E24AA), Color(0xFF512DA8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                delay: 100,
                onTap: nav.playPractice,
              ),
              _ActionCard(
                title: 'Pro Mode',
                subtitle: 'Win Coins',
                icon: Icons.emoji_events_rounded,
                gradient: const LinearGradient(
                  colors: [Color(0xFFF57C00), Color(0xFFE64A19)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                delay: 200,
                onTap: nav.playProMode,
              ),
              _ActionCard(
                title: 'Versus',
                subtitle: '1v1 Match',
                icon: Icons.bolt_rounded,
                gradient: const LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                delay: 300,
                onTap: nav.playVersus,
              ),
              _ActionCard(
                title: 'Tournament',
                subtitle: 'Compete',
                icon: Icons.emoji_events_rounded,
                gradient: const LinearGradient(
                  colors: [Color(0xFF388E3C), Color(0xFF1B5E20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
    required this.gradient,
    required this.delay,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
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
    final isShort = SoteriaResponsive.isShortScreen(context);

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
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradient.colors.first.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: SoteriaCard(
                padding: EdgeInsets.zero,
                borderRadius: 24,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.gradient.colors.first.withValues(alpha: 0.8),
                        widget.gradient.colors.last.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        top: -10,
                        child: Icon(
                          widget.icon,
                          size: 80.sp,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          SoteriaSpacing.adaptive(
                            context,
                            SoteriaSpacing.smStatic,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    widget.icon,
                                    color: Colors.white,
                                    size: isShort ? 16.sp : 20.sp,
                                  ),
                                );
                              },
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.title,
                                          style: context.titleMedium.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontSize: isShort ? 14.sp : 16.sp,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.subtitle,
                                          style: context.labelSmall.copyWith(
                                            color: Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: isShort ? 9.sp : 11.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.white,
                                    size: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
