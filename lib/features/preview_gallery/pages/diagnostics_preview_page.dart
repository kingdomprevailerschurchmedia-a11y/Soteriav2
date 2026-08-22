import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:soteria/core/services/performance_service.dart';
import 'package:soteria/core/errors/soteria_exception.dart';
import 'package:soteria/core/widgets/errors/error_screens.dart';

class DiagnosticsPreviewPage extends StatefulWidget {
  const DiagnosticsPreviewPage({super.key});

  @override
  State<DiagnosticsPreviewPage> createState() => _DiagnosticsPreviewPageState();
}

class _DiagnosticsPreviewPageState extends State<DiagnosticsPreviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: SoteriaColors.gold,
          unselectedLabelColor: SoteriaColors.muted,
          indicatorColor: SoteriaColors.gold,
          isScrollable: true,
          tabs: const [
            Tab(text: 'LOGS'),
            Tab(text: 'DEVICE'),
            Tab(text: 'PERFORMANCE'),
            Tab(text: 'SIMULATE'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const _LiveLogViewer(),
              const _DeviceInfoViewer(),
              const _PerformanceDashboard(),
              const _ErrorSimulator(),
            ],
          ),
        ),
      ],
    );
  }
}

class _LiveLogViewer extends StatelessWidget {
  const _LiveLogViewer();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LogEntry>(
      stream: LoggerService.logStream,
      builder: (context, snapshot) {
        final logs = LoggerService.memoryLogs.reversed.toList();
        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: logs.length,
          separatorBuilder: (context, index) =>
              const Divider(color: SoteriaColors.border, height: 1),
          itemBuilder: (context, index) {
            final entry = logs[index];
            return _LogEntryTile(entry: entry);
          },
        );
      },
    );
  }
}

class _LogEntryTile extends StatelessWidget {
  final LogEntry entry;
  const _LogEntryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final color = _getLogLevelColor(entry.level);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  entry.level.name.toUpperCase(),
                  style: SoteriaTypography.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${entry.timestamp.hour}:${entry.timestamp.minute}:${entry.timestamp.second}',
                style: SoteriaTypography.caption.copyWith(
                  color: SoteriaColors.hints,
                ),
              ),
              const Spacer(),
              if (entry.feature != null)
                Text(
                  '#${entry.feature}',
                  style: SoteriaTypography.caption.copyWith(
                    color: SoteriaColors.gold.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            entry.message,
            style: SoteriaTypography.body.copyWith(
              fontSize: 13.sp,
              color: SoteriaColors.textPrimary,
            ),
          ),
          if (entry.error != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                'Error: ${entry.error}',
                style: SoteriaTypography.caption.copyWith(
                  color: SoteriaColors.error.withValues(alpha: 0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getLogLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.trace:
        return Colors.grey;
      case LogLevel.debug:
        return Colors.blue;
      case LogLevel.info:
        return Colors.green;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.critical:
        return Colors.purple;
    }
  }
}

class _DeviceInfoViewer extends StatelessWidget {
  const _DeviceInfoViewer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDiagnostics>(
      future: DiagnosticsService.getDiagnostics(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!.toMap();
        return ListView(
          padding: EdgeInsets.all(16.w),
          children: data.entries
              .map((e) => _DiagnosticTile(label: e.key, value: e.value))
              .toList(),
        );
      },
    );
  }
}

class _DiagnosticTile extends StatelessWidget {
  final String label;
  final String value;
  const _DiagnosticTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: SoteriaTypography.body.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: SoteriaTypography.label.copyWith(
              color: SoteriaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceDashboard extends StatelessWidget {
  const _PerformanceDashboard();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PerformanceMetrics>(
      stream: PerformanceService.metricsStream,
      builder: (context, snapshot) {
        final metrics = snapshot.data;
        return ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            _DiagnosticTile(
              label: 'STARTUP DURATION',
              value: DiagnosticsService.startupDuration,
            ),
            const Divider(color: SoteriaColors.border),
            _DiagnosticTile(
              label: 'FPS',
              value: metrics?.fps.toStringAsFixed(1) ?? '...',
            ),
            _DiagnosticTile(
              label: 'FRAME BUILD',
              value:
                  '${metrics?.frameBuildTimeMs.toStringAsFixed(2) ?? '...'} ms',
            ),
            _DiagnosticTile(
              label: 'FRAME RASTER',
              value:
                  '${metrics?.frameRasterTimeMs.toStringAsFixed(2) ?? '...'} ms',
            ),
          ],
        );
      },
    );
  }
}

class _ErrorSimulator extends StatelessWidget {
  const _ErrorSimulator();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _SimulateButton(
          label: 'LOG INFO EVENT',
          onPressed: () => LoggerService.i(
            'Manual test event triggered from simulator',
            feature: 'Simulator',
          ),
        ),
        _SimulateButton(
          label: 'SIMULATE NETWORK FAILURE',
          onPressed: () {
            LoggerService.w('Simulating network failure', feature: 'Simulator');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PremiumErrorScreen(
                  exception: const NetworkException(),
                  onRetry: () => Navigator.of(context).pop(),
                ),
              ),
            );
          },
        ),
        _SimulateButton(
          label: 'SIMULATE SYSTEM ANOMALY',
          onPressed: () {
            LoggerService.critical(
              'Simulating system anomaly',
              feature: 'Simulator',
            );
            throw const UnexpectedException();
          },
          isCritical: true,
        ),
        _SimulateButton(
          label: 'SIMULATE TIMEOUT',
          onPressed: () => LoggerService.e(
            'Request timed out after 30000ms',
            error: const TimeoutException(),
            stackTrace: StackTrace.current,
            feature: 'Simulator',
          ),
        ),
        _SimulateButton(
          label: 'SIMULATE AUTH FAILURE',
          onPressed: () => LoggerService.e(
            'Session expired. Redirecting to login.',
            error: const AuthenticationException(),
            feature: 'Auth',
          ),
        ),
      ],
    );
  }
}

class _SimulateButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isCritical;

  const _SimulateButton({
    required this.label,
    required this.onPressed,
    this.isCritical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isCritical
              ? SoteriaColors.error
              : SoteriaColors.gold,
          side: BorderSide(
            color: (isCritical ? SoteriaColors.error : SoteriaColors.gold)
                .withValues(alpha: 0.3),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(label, style: SoteriaTypography.label),
      ),
    );
  }
}
