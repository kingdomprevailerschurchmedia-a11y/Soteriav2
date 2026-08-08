import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/spacing/soteria_spacing.dart';
import '../../core/design_system/typography/soteria_typography.dart';
import '../../core/identity/providers/identity_providers.dart';

class SoteriaPage extends ConsumerWidget {
  const SoteriaPage({
    super.key,
    required this.child,
    this.isLoading = false,
    this.error,
    this.onRetry,
    this.showOfflineBanner = true,
  });

  final Widget child;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;
  final bool showOfflineBanner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final isOffline = session.isOffline;

    return Stack(
      children: [
        child,
        if (showOfflineBanner && isOffline)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: SoteriaColors.gold.withValues(alpha: 0.1),
                child: Center(
                  child: Text(
                    'OFFLINE MODE • DATA FROM CACHE',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (isLoading)
          const ColoredBox(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(color: SoteriaColors.primary),
            ),
          ),
        if (error != null)
          ColoredBox(
            color: SoteriaColors.background,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: SoteriaColors.error,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'SYSTEM ERROR',
                        style: context.headlineSmall.copyWith(
                          color: SoteriaColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      if (onRetry != null) ...[
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: onRetry,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SoteriaColors.error.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: SoteriaColors.error,
                            side: const BorderSide(color: SoteriaColors.error),
                          ),
                          child: const Text('RETRY'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
