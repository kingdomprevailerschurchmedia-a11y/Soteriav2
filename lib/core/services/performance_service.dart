import 'dart:async';
import 'package:flutter/scheduler.dart';

class PerformanceMetrics {
  final double fps;
  final double frameBuildTimeMs;
  final double frameRasterTimeMs;

  PerformanceMetrics({
    required this.fps,
    required this.frameBuildTimeMs,
    required this.frameRasterTimeMs,
  });
}

class PerformanceService {
  static final _metricsController = StreamController<PerformanceMetrics>.broadcast();
  static Stream<PerformanceMetrics> get metricsStream => _metricsController.stream;

  static void init() {
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      if (timings.isEmpty) return;

      final lastFrame = timings.last;
      final buildTime = lastFrame.buildDuration.inMicroseconds / 1000.0;
      final rasterTime = lastFrame.rasterDuration.inMicroseconds / 1000.0;
      final totalTime = lastFrame.totalSpan.inMicroseconds / 1000.0;
      
      final fps = totalTime > 0 ? 1000.0 / totalTime : 0.0;

      _metricsController.add(PerformanceMetrics(
        fps: fps > 60 ? 60 : fps,
        frameBuildTimeMs: buildTime,
        frameRasterTimeMs: rasterTime,
      ));
    });
  }
}
