import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

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
  late int _currentXP;
  late int _displayXP;
  late int _currentLevel;
  late double _progress;

  // Logic: 1000 XP per level for simplicity in mock
  final int _xpPerLevel = 1000;

  @override
  void initState() {
    super.initState();
    _currentXP = widget.initialXP;
    _displayXP = widget.initialXP;
    _currentLevel = widget.initialLevel;
    _progress = (widget.initialXP % _xpPerLevel) / _xpPerLevel;

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    int remainingToGain = widget.xpEarned;
    while (remainingToGain > 0 && mounted) {
      int xpToNextLevel = _xpPerLevel - (_currentXP % _xpPerLevel);
      int gain = remainingToGain > 10 ? 10 : remainingToGain; // Increment step

      setState(() {
        _currentXP += gain;
        _displayXP = _currentXP;
        _progress = (_currentXP % _xpPerLevel) / _xpPerLevel;

        if (_currentXP ~/ _xpPerLevel > _currentLevel) {
          _currentLevel++;
          // Trigger Level Up Effect here
        }
      });

      remainingToGain -= gain;
      await Future.delayed(const Duration(milliseconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LEVEL $_currentLevel',
                style: context.titleMedium.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '${_currentXP % _xpPerLevel} / $_xpPerLevel XP',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaProgressBar(progress: _progress, hasGlow: true),
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
    );
  }
}
