import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/firebase/security/providers/security_providers.dart';
import 'package:soteria/core/firebase/security/models/security_status.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';

class SecurityStatusScreen extends ConsumerWidget {
  const SecurityStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(currentSecurityStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SECURITY STATUS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            _SecuritySection(
              title: 'FIREBASE APP CHECK',
              children: [
                _StatusRow(
                  label: 'Environment',
                  value: status.environment.name.toUpperCase(),
                  isHigh: true,
                ),
                _StatusRow(
                  label: 'Provider',
                  value: status.providerName.toUpperCase(),
                ),
                _StatusRow(
                  label: 'State',
                  value: status.tokenState.name.toUpperCase(),
                  color: _getTokenColor(status.tokenState),
                ),
                _StatusRow(
                  label: 'Initialized',
                  value: status.isInitialized ? 'YES' : 'NO',
                  color: status.isInitialized
                      ? SoteriaColors.success
                      : SoteriaColors.error,
                ),
                if (status.lastRefreshTime != null)
                  _StatusRow(
                    label: 'Last Refresh',
                    value: status.lastRefreshTime!
                        .toLocal()
                        .toString()
                        .split('.')
                        .first,
                  ),
              ],
            ),
            if (status.errorMessage != null) ...[
              SizedBox(height: SoteriaSpacing.xl),
              _SecuritySection(
                title: 'ERROR LOG',
                children: [
                  Text(
                    status.errorMessage!,
                    style: context.bodySmall.copyWith(
                      color: SoteriaColors.error,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: SoteriaSpacing.xl),
            _SecuritySection(
              title: 'ENFORCEMENT READINESS',
              children: const [
                _StatusRow(
                  label: 'Authentication',
                  value: 'PENDING',
                  color: SoteriaColors.gold,
                ),
                _StatusRow(
                  label: 'Cloud Firestore',
                  value: 'PENDING',
                  color: SoteriaColors.gold,
                ),
                _StatusRow(
                  label: 'Firebase Storage',
                  value: 'PENDING',
                  color: SoteriaColors.gold,
                ),
                _StatusRow(
                  label: 'Cloud Functions',
                  value: 'PENDING',
                  color: SoteriaColors.gold,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(securityCoordinatorProvider).initialize(),
        backgroundColor: SoteriaColors.primary,
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }

  Color _getTokenColor(AppCheckTokenState state) {
    switch (state) {
      case AppCheckTokenState.valid:
        return SoteriaColors.success;
      case AppCheckTokenState.error:
        return SoteriaColors.error;
      case AppCheckTokenState.expired:
        return SoteriaColors.gold;
      case AppCheckTokenState.unknown:
        return SoteriaColors.muted;
    }
  }
}

class _SecuritySection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SecuritySection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        SoteriaCard(child: Column(children: children)),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final bool isHigh;

  const _StatusRow({
    required this.label,
    required this.value,
    this.color,
    this.isHigh = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          Text(
            value,
            style: context.bodySmall.copyWith(
              fontWeight: isHigh ? FontWeight.w900 : FontWeight.bold,
              color: color ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
