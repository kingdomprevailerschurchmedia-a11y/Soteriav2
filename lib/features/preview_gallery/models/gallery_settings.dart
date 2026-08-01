import 'package:flutter/material.dart';

enum PreviewDevice {
  smallPhone('Small Phone', Size(320, 568)),
  largePhone('Large Phone', Size(414, 896)),
  foldable('Foldable', Size(673, 841)),
  tablet('Tablet', Size(768, 1024)),
  desktop('Desktop Width', Size(1280, 800));

  final String label;
  final Size size;
  const PreviewDevice(this.label, this.size);
}

class GallerySettings {
  final PreviewDevice device;
  final Orientation orientation;
  final double textScale;
  final double animationSpeed;
  final bool showLayoutBounds;
  final bool showSpacingGrid;
  final bool showSafeAreas;
  final bool showSemantics;
  final bool reducedMotion;
  final bool highContrast;

  const GallerySettings({
    this.device = PreviewDevice.largePhone,
    this.orientation = Orientation.portrait,
    this.textScale = 1.0,
    this.animationSpeed = 1.0,
    this.showLayoutBounds = false,
    this.showSpacingGrid = false,
    this.showSafeAreas = false,
    this.showSemantics = false,
    this.reducedMotion = false,
    this.highContrast = false,
  });

  GallerySettings copyWith({
    PreviewDevice? device,
    Orientation? orientation,
    double? textScale,
    double? animationSpeed,
    bool? showLayoutBounds,
    bool? showSpacingGrid,
    bool? showSafeAreas,
    bool? showSemantics,
    bool? reducedMotion,
    bool? highContrast,
  }) {
    return GallerySettings(
      device: device ?? this.device,
      orientation: orientation ?? this.orientation,
      textScale: textScale ?? this.textScale,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      showLayoutBounds: showLayoutBounds ?? this.showLayoutBounds,
      showSpacingGrid: showSpacingGrid ?? this.showSpacingGrid,
      showSafeAreas: showSafeAreas ?? this.showSafeAreas,
      showSemantics: showSemantics ?? this.showSemantics,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      highContrast: highContrast ?? this.highContrast,
    );
  }
}
