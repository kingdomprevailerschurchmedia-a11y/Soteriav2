import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import '../providers/match_lifecycle_providers.dart';

class MatchCountdownView extends ConsumerWidget {
  final VersusMatch match;
  const MatchCountdownView({super.key, required this.match});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdownAsync = ref.watch(matchCountdownProvider);
    final count = countdownAsync.value ?? 3;

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: SoteriaColors.backgroundGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GET READY',
                style: context.headlineSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
              SoteriaScaleIn(
                key: ValueKey(count),
                duration: const Duration(milliseconds: 600),
                child: Text(
                  count == 0 ? 'GO!' : count.toString(),
                  style: context.displayLarge.copyWith(
                    fontSize: 120.sp,
                    fontWeight: FontWeight.w900,
                    color: count == 0 ? SoteriaColors.success : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
