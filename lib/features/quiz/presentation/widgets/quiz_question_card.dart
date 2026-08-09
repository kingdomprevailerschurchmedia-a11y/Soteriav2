import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../domain/models/quiz_enums.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({
    super.key,
    required this.text,
    required this.category,
    required this.difficulty,
    this.imageUrl,
  });

  final String text;
  final String category;
  final Difficulty difficulty;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge(
                context,
                category.toUpperCase(),
                SoteriaColors.primary,
              ),
              _buildBadge(
                context,
                difficulty.name.toUpperCase(),
                _getDifficultyColor(),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(SoteriaRadius.md),
              child: Image.network(
                imageUrl!,
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180.h,
                  color: Colors.white10,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
          ],
          Text(
            text,
            style: context.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SoteriaRadius.full),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Color _getDifficultyColor() {
    switch (difficulty) {
      case Difficulty.easy:
        return SoteriaColors.success;
      case Difficulty.medium:
        return SoteriaColors.warning;
      case Difficulty.hard:
        return SoteriaColors.error;
      case Difficulty.expert:
        return SoteriaColors.gold;
    }
  }
}
