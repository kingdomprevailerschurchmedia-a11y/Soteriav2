import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

import '../../../../core/utils/soteria_responsive.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    required this.pageController,
    required this.index,
    this.badgeLabel,
    this.titleWidget,
    this.backgroundGlowColor,
    this.illustrationScale = 1.0,
  });

  final String title;
  final String description;
  final Widget illustration;
  final PageController pageController;
  final int index;
  final String? badgeLabel;
  final Widget? titleWidget;
  final Color? backgroundGlowColor;
  final double illustrationScale;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final isTablet = SoteriaResponsive.isTablet(context);

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double offset = 0.0;
        if (pageController.hasClients) {
          offset = (pageController.page ?? 0.0) - index;
        }

        final double opacity = (1.0 - offset.abs()).clamp(0.0, 1.0);
        final double scale = (1.0 - (offset.abs() * 0.05)).clamp(0.9, 1.0);

        return Stack(
          children: [
            if (backgroundGlowColor != null)
              Positioned(
                top: -100.h,
                right: -100.w,
                child: Opacity(
                  opacity: opacity,
                  child: AmbientGlow(
                    color: backgroundGlowColor!.withValues(alpha: 0.1),
                    size: 500.w,
                    blur: 120,
                  ),
                ),
              ),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight;
                final maxWidth = constraints.maxWidth;
                final isLandscape = maxWidth > maxHeight;

                // Content width constraint for tablets
                final contentWidth = isTablet ? 500.0 : maxWidth;

                return Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SoteriaSpacing.containerPadding(context),
                      ),
                      child: Column(
                        children: [
                          // Top Spacing
                          if (isLandscape)
                            SizedBox(height: 16.h)
                          else
                            const Spacer(flex: 4),

                          // Illustration Area
                          Flexible(
                            flex: isLandscape ? 4 : 6,
                            child: Opacity(
                              opacity: opacity,
                              child: Transform.scale(
                                scale: scale,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: isLandscape
                                        ? maxHeight * 0.3
                                        : maxHeight * 0.35,
                                    maxWidth: isLandscape
                                        ? contentWidth * 0.4
                                        : contentWidth * 0.85,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24.r),
                                      child: Transform.scale(
                                        scale: illustrationScale,
                                        child: illustration,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Spacing between Illustration and Text
                          if (isLandscape)
                            SizedBox(height: 12.h)
                          else
                            SizedBox(height: 16.h),

                          // Content Area
                          Opacity(
                            opacity: opacity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (badgeLabel != null) ...[
                                  _buildBadge(context, badgeLabel!),
                                  SizedBox(height: 24.h),
                                ],
                                if (titleWidget != null)
                                  titleWidget!
                                else
                                  _buildDefaultTitle(context, title),
                                SizedBox(
                                  height:
                                      isLandscape ? 12.h : SoteriaSpacing.lg,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: Text(
                                    description,
                                    style: (isShort || isLandscape
                                            ? context.bodyMedium
                                            : context.bodyLarge)
                                        .copyWith(
                                          color: SoteriaColors.textSecondary,
                                          height: 1.6,
                                          fontSize: 16.sp,
                                        ),
                                    textAlign: TextAlign.center,
                                    maxLines: isLandscape ? 2 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Bottom Spacing for Controls
                          if (isLandscape)
                            SizedBox(height: 16.h)
                          else if (isShort)
                            SizedBox(height: 140.h)
                          else
                            SizedBox(height: 200.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: SoteriaColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.military_tech, color: SoteriaColors.gold, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultTitle(BuildContext context, String text) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final style = (isShort ? context.headlineLarge : context.displayMedium)
        .copyWith(
          color: SoteriaColors.textPrimary,
          height: 1.1,
          fontWeight: FontWeight.w900,
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
