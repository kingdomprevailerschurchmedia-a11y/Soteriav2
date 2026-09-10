import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

import '../../../../core/utils/soteria_responsive.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    required this.pageController,
    required this.index,
    this.titleWidget,
    this.illustrationScale = 1.0,
  });

  final String title;
  final String description;
  final Widget illustration;
  final PageController pageController;
  final int index;
  final Widget? titleWidget;
  final double illustrationScale;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _illustrationFade;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _descriptionFade;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _illustrationFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _titleFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 40),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _descriptionFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    // Trigger animation if this is the first page or when the page is selected
    if (widget.index == 0) {
      _entranceController.forward();
    }

    widget.pageController.addListener(_handlePageScroll);
  }

  void _handlePageScroll() {
    if (!mounted) return;
    if (widget.pageController.page?.round() == widget.index) {
      if (!_entranceController.isAnimating &&
          _entranceController.status != AnimationStatus.completed) {
        _entranceController.forward();
      }
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_handlePageScroll);
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final isTablet = SoteriaResponsive.isTablet(context);

    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            final isLandscape = maxWidth > maxHeight;

            // Content width constraint for tablets
            final contentWidth = isTablet ? 500.0 : maxWidth;

            return AnimatedBuilder(
              animation: widget.pageController,
              builder: (context, child) {
                double position = 0.0;
                if (widget.pageController.hasClients) {
                  position = (widget.pageController.page ?? 0.0) - widget.index;
                }

                // Calculate fade and a slight horizontal drift for a premium feel
                final double opacity = (1.0 - position.abs()).clamp(0.0, 1.0);
                // Negate the PageView translation to keep the page stationary (fade-only)
                final double translateX = position * constraints.maxWidth;

                return Transform.translate(
                  offset: Offset(translateX, 0),
                  child: Opacity(
                    opacity: opacity,
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                SoteriaSpacing.containerPadding(context),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Top Spacing
                              if (isLandscape)
                                SizedBox(height: 16.h)
                              else
                                const Spacer(flex: 7),

                              // Illustration Area
                              FadeTransition(
                                opacity: _illustrationFade,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RepaintBoundary(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: isLandscape
                                            ? maxHeight * 0.45
                                            : maxHeight * 0.48,
                                        maxWidth: isLandscape
                                            ? contentWidth * 0.5
                                            : contentWidth,
                                      ),
                                      child: Transform.scale(
                                        scale: widget.illustrationScale,
                                        child: widget.illustration,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Spacing between Illustration and Text
                              if (isLandscape)
                                SizedBox(height: 12.h)
                              else
                                const Spacer(flex: 1),

                              // Content Area
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimatedBuilder(
                                    animation: _entranceController,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: _titleFade.value,
                                        child: Transform.translate(
                                          offset: _titleSlide.value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: RepaintBoundary(
                                      child: widget.titleWidget ??
                                          _buildDefaultTitle(
                                            context,
                                            widget.title,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: isLandscape ? 12.h : 16.h,
                                  ),
                                  FadeTransition(
                                    opacity: _descriptionFade,
                                    child: RepaintBoundary(
                                      child: Text(
                                        widget.description,
                                        style: (isShort || isLandscape
                                                ? context.bodyMedium
                                                : context.bodyLarge)
                                            .copyWith(
                                              color:
                                                  SoteriaColors.textSecondary,
                                              height: 1.5,
                                              fontSize: 16.sp,
                                            ),
                                        textAlign: TextAlign.center,
                                        maxLines: isLandscape ? 2 : 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Bottom Spacing for Controls
                              if (isLandscape)
                                SizedBox(height: 16.h)
                              else if (isShort)
                                SizedBox(height: 130.h)
                              else
                                SizedBox(height: 160.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDefaultTitle(BuildContext context, String text) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final style = (isShort ? context.headlineLarge : context.displayMedium)
        .copyWith(
          color: SoteriaColors.textPrimary,
          height: 1.1,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(
              offset: const Offset(0, 4),
              blurRadius: 10.0,
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ],
        );

    final words = text.split(' ');
    if (words.length >= 2) {
      final firstPart = words.sublist(0, words.length - 1).join(' ');
      final lastPart = words.last;

      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: style,
          children: [
            TextSpan(text: '$firstPart\n'),
            TextSpan(
              text: lastPart,
              style: style.copyWith(color: SoteriaColors.secondary),
            ),
          ],
        ),
      );
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
