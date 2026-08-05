import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';

class RegistrationActionBox extends StatelessWidget {
  final TournamentStatus status;
  final bool isRegistered;
  final VoidCallback onAction;
  final bool isLoading;

  const RegistrationActionBox({
    super.key,
    required this.status,
    required this.isRegistered,
    required this.onAction,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Tournament registration actions',
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        decoration: BoxDecoration(
          color: SoteriaColors.navigation,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMessage(context),
              SizedBox(height: SoteriaSpacing.md),
              SoteriaButton(
                label: _getButtonLabel(),
                onPressed: _isActionEnabled() ? onAction : null,
                isLoading: isLoading,
                variant: isRegistered
                    ? SoteriaButtonVariant.danger
                    : SoteriaButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    String message = '';
    IconData? icon;
    Color color = SoteriaColors.textSecondary;

    if (status == TournamentStatus.registrationOpen) {
      if (isRegistered) {
        message = 'You are registered for this tournament.';
        icon = Icons.check_circle_rounded;
        color = SoteriaColors.success;
      } else {
        message = 'Registration is open until full.';
      }
    } else if (status == TournamentStatus.live) {
      message = 'Tournament is currently live.';
      color = SoteriaColors.error;
    } else if (status == TournamentStatus.completed) {
      message = 'Tournament has ended.';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16.sp, color: color),
          SizedBox(width: 8.w),
        ],
        Text(message, style: context.bodySmall.copyWith(color: color)),
      ],
    );
  }

  String _getButtonLabel() {
    if (status == TournamentStatus.live ||
        status == TournamentStatus.startingSoon) {
      if (isRegistered) return 'Enter Lobby';
      return 'Watch Live';
    }
    if (isRegistered) return 'Leave Tournament';
    if (status == TournamentStatus.registrationOpen) return 'Join Tournament';
    return 'Registration Closed';
  }

  bool _isActionEnabled() {
    if (status == TournamentStatus.registrationOpen) return true;
    if (status == TournamentStatus.live ||
        status == TournamentStatus.startingSoon)
      return true;
    return false;
  }
}
