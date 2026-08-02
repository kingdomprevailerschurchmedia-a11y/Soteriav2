import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/preview_gallery/models/gallery_settings.dart';
import 'package:soteria/features/preview_gallery/providers/gallery_providers.dart';

class GalleryShell extends ConsumerStatefulWidget {
  const GalleryShell({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  ConsumerState<GalleryShell> createState() => _GalleryShellState();
}

class _GalleryShellState extends ConsumerState<GalleryShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = GoRouterState.of(context).matchedLocation;
      ref.read(galleryRecentProvider.notifier).add(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(gallerySettingsProvider);

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      appBar: AppBar(
        title: Text(widget.title, style: context.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Device Canvas
          Expanded(
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: settings.orientation == Orientation.portrait
                    ? settings.device.size.width.w
                    : settings.device.size.height.w,
                height: settings.orientation == Orientation.portrait
                    ? settings.device.size.height.h
                    : settings.device.size.width.h,
                decoration: BoxDecoration(
                  color: SoteriaColors.backgroundBottomRight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.1),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: ClipRect(
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      // ignore: deprecated_member_use
                      textScaleFactor: settings.textScale,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        visualDensity: settings.highContrast
                            ? VisualDensity.comfortable
                            : VisualDensity.standard,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(child: widget.child),
                          if (settings.showLayoutBounds)
                            _buildLayoutBoundsOverlay(),
                          if (settings.showSpacingGrid) _buildGridOverlay(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: SoteriaColors.elevatedSurface,
      builder: (context) => const _GallerySettingsPanel(),
    );
  }

  Widget _buildLayoutBoundsOverlay() {
    return IgnorePointer(
      child: CustomPaint(painter: _LayoutBoundsPainter(), size: Size.infinite),
    );
  }

  Widget _buildGridOverlay() {
    return IgnorePointer(
      child: CustomPaint(painter: _GridPainter(), size: Size.infinite),
    );
  }
}

class _GallerySettingsPanel extends ConsumerWidget {
  const _GallerySettingsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(gallerySettingsProvider);
    final notifier = ref.read(gallerySettingsProvider.notifier);

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lgStatic),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PREVIEW SETTINGS',
            style: context.labelLarge.copyWith(color: SoteriaColors.gold),
          ),
          SizedBox(height: SoteriaSpacing.lgStatic),

          // Device Selection
          _buildDropdown<PreviewDevice>(
            label: 'Device',
            value: settings.device,
            items: PreviewDevice.values,
            onChanged: (val) => notifier.update((s) => s.copyWith(device: val)),
            itemLabel: (d) => d.label,
          ),

          // Orientation
          SwitchListTile(
            title: const Text('Landscape'),
            value: settings.orientation == Orientation.landscape,
            onChanged: (val) => notifier.update(
              (s) => s.copyWith(
                orientation: val ? Orientation.landscape : Orientation.portrait,
              ),
            ),
          ),

          // Text Scale
          Text('Text Scale: ${settings.textScale.toStringAsFixed(1)}'),
          Slider(
            value: settings.textScale,
            min: 0.5,
            max: 2.5,
            divisions: 20,
            onChanged: (val) =>
                notifier.update((s) => s.copyWith(textScale: val)),
          ),

          const Divider(),

          // Dev Tools
          CheckboxListTile(
            title: const Text('Show Layout Bounds'),
            value: settings.showLayoutBounds,
            onChanged: (val) =>
                notifier.update((s) => s.copyWith(showLayoutBounds: val)),
          ),
          CheckboxListTile(
            title: const Text('Show Spacing Grid (8px)'),
            value: settings.showSpacingGrid,
            onChanged: (val) =>
                notifier.update((s) => s.copyWith(showSpacingGrid: val)),
          ),

          SizedBox(height: SoteriaSpacing.xlStatic),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) itemLabel,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.mdStatic),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: SoteriaColors.muted),
          ),
          DropdownButton<T>(
            value: value,
            isExpanded: true,
            underline: Container(height: 1, color: SoteriaColors.border),
            items: items
                .map(
                  (i) => DropdownMenuItem(value: i, child: Text(itemLabel(i))),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += 8) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 8) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LayoutBoundsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
