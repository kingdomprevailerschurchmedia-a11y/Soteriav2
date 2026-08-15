import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';

import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';

class LevelProgressionCard extends StatefulWidget {
  final int initialXP;
  final int xpEarned;
  final int initialLevel;

  const LevelProgressionCard({
    super.key,
    required this.initialXP,
    required this.xpEarned,
    required this.initialLevel,
  });

  @override
  State<LevelProgressionCard> createState() => _LevelProgressionCardState();
}

class _LevelProgressionCardState extends State<LevelProgressionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xpAnimation;

  late int _displayXP;
  late int _displayLevel;
  late double _displayProgress;
  late int _xpRequiredForNext;

  final _engine = LevelEngine();

  @override
  void initState() {
    super.initState();
    _displayXP = widget.initialXP;
    _displayLevel = widget.initialLevel;
    _displayProgress = _engine.calculateLevelProgress(widget.initialXP);
    _xpRequiredForNext = ProgressionConfig.xpCapacityForLevel(_displayLevel);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _xpAnimation =
        Tween<double>(
            begin: widget.initialXP.toDouble(),
            end: (widget.initialXP + widget.xpEarned).toDouble(),
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          )
          ..addListener(() {
            setState(() {
              final currentXP = _xpAnimation.value.toInt();
              _displayXP = currentXP;
              _displayLevel = _engine.calculateLevel(currentXP);
              _displayProgress = _engine.calculateLevelProgress(currentXP);
              _xpRequiredForNext = ProgressionConfig.xpCapacityForLevel(_displayLevel);
            });
          });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xpInLevel = _engine.xpIntoCurrentLevel(_displayXP);

    return Semantics(
      label: 'Level Progression. Currently level $_displayLevel. ${widget.xpEarned} XP earned.',
      child: SoteriaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LEVEL $_displayLevel',
                  style: context.titleMedium.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '$xpInLevel / $_xpRequiredForNext XP',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            SoteriaProgressBar(progress: _displayProgress, hasGlow: true),
            SizedBox(height: SoteriaSpacing.sm),
            Center(
              child: Text(
                '+${widget.xpEarned} XP GAINED',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
