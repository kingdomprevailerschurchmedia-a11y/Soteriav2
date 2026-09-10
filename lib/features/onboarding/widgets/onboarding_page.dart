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

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SoteriaSpacing.containerPadding(context),
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
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedBuilder(
                          animation: pageController,
                          builder: (context, child) {
                            double offset = 0.0;
                            if (pageController.hasClients) {
                              offset = (pageController.page ?? 0.0) - index;
                            }
                            final double opacity = (1.0 - offset.abs()).clamp(0.0, 1.0);
                            final double scale = (1.0 - (offset.abs() * 0.05)).clamp(0.9, 1.0);
                            return Opacity(
                              opacity: opacity,
                              child: Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                            );
                          },
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
                              scale: illustrationScale,
                              child: illustration,
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
                      AnimatedBuilder(
                        animation: pageController,
                        builder: (context, child) {
                          double offset = 0.0;
                          if (pageController.hasClients) {
                            offset = (pageController.page ?? 0.0) - index;
                          }
                          final double opacity = (1.0 - offset.abs()).clamp(0.0, 1.0);
                          return Opacity(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (titleWidget != null)
                              titleWidget!
                            else
                              _buildDefaultTitle(context, title),
                            SizedBox(
                              height:
                                  isLandscape ? 12.h : 16.h,
                            ),
                            Text(
                              description,
                              style: (isShort || isLandscape
                                      ? context.bodyMedium
                                      : context.bodyLarge)
                                  .copyWith(
                                    color: SoteriaColors.textSecondary,
                                    height: 1.5,
                                    fontSize: 16.sp,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: isLandscape ? 2 : 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
