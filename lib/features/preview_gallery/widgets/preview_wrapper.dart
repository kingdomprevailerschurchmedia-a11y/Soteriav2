import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';

enum PreviewState { loading, success, empty, error, offline }

class PreviewWrapper extends StatefulWidget {
  final Widget Function(BuildContext, PreviewState) builder;
  final String title;

  const PreviewWrapper({super.key, required this.builder, required this.title});

  @override
  State<PreviewWrapper> createState() => _PreviewWrapperState();
}

class _PreviewWrapperState extends State<PreviewWrapper> {
  PreviewState _state = PreviewState.success;
  bool _isTablet = false;
  bool _isLandscape = false;

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        actions: [_buildStateSelector(), _buildResponsiveToggle()],
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isTablet ? 1024 : (_isLandscape ? 844 : 390),
          height: _isTablet ? 768 : (_isLandscape ? 390 : 844),
          decoration: BoxDecoration(
            border: Border.all(
              color: SoteriaColors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: ClipRect(child: _buildCurrentState(context)),
        ),
      ),
    );
  }

  Widget _buildCurrentState(BuildContext context) {
    switch (_state) {
      case PreviewState.loading:
        return const SoteriaLoadingView();
      case PreviewState.empty:
        return const SoteriaEmptyView(
          title: 'NO DATA FOUND',
          message: 'It looks like there is nothing to display here yet.',
          icon: Icons.inbox_rounded,
        );
      case PreviewState.offline:
        return SoteriaOfflineView(onRetry: () {});
      case PreviewState.error:
        return const SoteriaEmptyView(
          title: 'SOMETHING WENT WRONG',
          message:
              'We encountered an unexpected error. Please try again later.',
          icon: Icons.error_outline_rounded,
        );
      case PreviewState.success:
        return widget.builder(context, _state);
    }
  }

  Widget _buildStateSelector() {
    return PopupMenuButton<PreviewState>(
      icon: const Icon(Icons.settings_suggest_rounded),
      onSelected: (state) => setState(() => _state = state),
      itemBuilder: (context) => PreviewState.values.map((state) {
        return PopupMenuItem(
          value: state,
          child: Text(state.name.toUpperCase()),
        );
      }).toList(),
    );
  }

  Widget _buildResponsiveToggle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isTablet ? Icons.tablet_rounded : Icons.phone_iphone_rounded,
          ),
          onPressed: () => setState(() => _isTablet = !_isTablet),
        ),
        IconButton(
          icon: Icon(
            _isLandscape
                ? Icons.screen_lock_landscape_rounded
                : Icons.screen_lock_portrait_rounded,
          ),
          onPressed: () => setState(() => _isLandscape = !_isLandscape),
        ),
      ],
    );
  }
}
