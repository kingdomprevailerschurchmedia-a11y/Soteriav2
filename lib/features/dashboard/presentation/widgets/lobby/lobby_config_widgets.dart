import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/animations/soteria_animations.dart';
import '../../../../../core/design_system/animations/soteria_animation_widgets.dart';

class LobbyHeroHeader extends StatelessWidget {
  final String part1;
  final String part2;
  final String part3;
  final String subtitle;
  final List<Color> part2Gradient;
  final List<Color> part3Gradient;

  const LobbyHeroHeader({
    super.key,
    required this.part1,
    required this.part2,
    required this.part3,
    required this.subtitle,
    this.part2Gradient = const [Color(0xFF7C4DFF), Color(0xFFFF4DFF)],
    this.part3Gradient = const [Color(0xFFFFD700), Color(0xFFFFAB40)],
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaFadeIn(
      duration: SoteriaAnimations.medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.school_rounded,
            color: const Color(0xFF7C4DFF),
            size: 48.sp,
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Colors.white,
                fontSize: 36.sp,
              ),
              children: [
                TextSpan(text: '$part1 '),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: part2Gradient,
                    ).createShader(bounds),
                    child: Text(
                      '$part2 ',
                      style: context.headlineLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        color: Colors.white,
                        fontSize: 36.sp,
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: part3Gradient,
                    ).createShader(bounds),
                    child: Text(
                      part3,
                      style: context.headlineLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        color: Colors.white,
                        fontSize: 36.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: context.bodyMedium.copyWith(
              color: Colors.white60,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class LobbyInterestsCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String subtitle;

  const LobbyInterestsCard({
    super.key,
    required this.value,
    required this.onChanged,
    this.title = 'Use My Interests',
    this.subtitle = 'Get personalized practice based on your profile and interests.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          if (value)
            BoxShadow(
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF2E1A8A), Color(0xFF5B3FD9)],
              ),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: SoteriaColors.gold, size: 24),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: context.bodySmall.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: SoteriaColors.gold,
            inactiveThumbColor: Colors.white60,
            inactiveTrackColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}

class LobbySectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? subtitle;

  const LobbySectionHeader({
    super.key,
    required this.label,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: SoteriaColors.gold, size: 20.sp),
        SizedBox(width: 10.w),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w900,
            fontSize: 12.sp,
          ),
        ),
        if (subtitle != null) ...[
          const Spacer(),
          Text(
            subtitle!,
            style: context.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 10.sp,
            ),
          ),
        ],
      ],
    );
  }
}

class LobbyDifficultyCard extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final int dotCount;

  const LobbyDifficultyCard({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.dotCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1045) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF7C4DFF) : Colors.white.withValues(alpha: 0.05),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : color.withValues(alpha: 0.5),
              size: 26.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final bool isActive = index < dotCount;
                return Container(
                  width: 5.r,
                  height: 5.r,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive 
                        ? (isSelected ? color : color.withValues(alpha: 0.4))
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyAdaptiveToggle extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String subtitle;

  const LobbyAdaptiveToggle({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.label = 'Adaptive',
    this.subtitle = 'Adjusts to your performance',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1045) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF7C4DFF) : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFB456FF).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.psychology_rounded,
                color: Color(0xFFB456FF),
                size: 24,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.titleSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isSelected ? const Color(0xFF7C4DFF) : Colors.white24,
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyCategoryCard extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const LobbyCategoryCard({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1045) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF7C4DFF) : Colors.white.withValues(alpha: 0.05),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? SoteriaColors.primary : Colors.white24,
              size: 26.sp,
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelSmall.copyWith(
                  color: isSelected ? Colors.white : Colors.white38,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  fontSize: 8.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyCountCircle extends StatelessWidget {
  final int count;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const LobbyCountCircle({
    super.key,
    required this.count,
    required this.isSelected,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.03),
              border: Border.all(
                color: !isEnabled 
                    ? Colors.white.withValues(alpha: 0.03)
                    : isSelected 
                        ? const Color(0xFFB456FF) 
                        : Colors.white.withValues(alpha: 0.1),
                width: isSelected ? 3.0 : 1.5,
              ),
              boxShadow: (isSelected && isEnabled)
                  ? [
                      BoxShadow(
                        color: const Color(0xFFB456FF).withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Opacity(
                opacity: isEnabled ? 1.0 : 0.2,
                child: Text(
                  count.toString(),
                  style: context.titleMedium.copyWith(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Qns',
            style: context.labelSmall.copyWith(
              color: isSelected ? const Color(0xFFB456FF) : Colors.white24,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LobbyStartAction extends StatelessWidget {
  final bool enabled;
  final bool isLoading;
  final String? error;
  final String label;
  final String helperText;
  final VoidCallback onStart;

  const LobbyStartAction({
    super.key,
    required this.enabled,
    this.isLoading = false,
    this.error,
    required this.label,
    required this.helperText,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            SoteriaColors.background.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: (enabled && !isLoading) ? onStart : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: (enabled && !isLoading) ? 1.0 : 0.5,
              child: Container(
                height: 64.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFAB40), Color(0xFFE58C3D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    if (enabled)
                      BoxShadow(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.black))
                    : Row(
                        children: [
                          const Icon(Icons.bolt_rounded, color: Color(0xFF1E1045), size: 32),
                          const Spacer(),
                          Text(
                            label,
                            style: context.titleSmall.copyWith(
                              color: const Color(0xFF1E1045),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF1E1045), size: 32),
                        ],
                      ),
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
