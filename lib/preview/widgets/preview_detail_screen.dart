import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/preview_item.dart';
import 'device_simulator.dart';
import 'state_switcher.dart';
import 'quality_tools_overlay.dart';

class PreviewDetailScreen extends StatefulWidget {
  final PreviewItem item;
  const PreviewDetailScreen({super.key, required this.item});

  @override
  State<PreviewDetailScreen> createState() => _PreviewDetailScreenState();
}

class _PreviewDetailScreenState extends State<PreviewDetailScreen> {
  DeviceType _selectedDevice = DeviceType.iphone;
  bool _isLandscape = false;
  PreviewState _currentState = PreviewState.success;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
          StateSwitcher(
            current: _currentState,
            onChanged: (state) => setState(() => _currentState = state),
          ),
          IconButton(
            icon: Icon(
              _isLandscape
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
            ),
            onPressed: () => setState(() => _isLandscape = !_isLandscape),
          ),
          DropdownButton<DeviceType>(
            value: _selectedDevice,
            underline: const SizedBox.shrink(),
            items: DeviceType.values
                .map((d) => DropdownMenuItem(value: d, child: Text(d.name)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedDevice = val);
            },
          ),
        ],
      ),
      body: QualityToolsOverlay(
        child: DeviceSimulator(
          device: _selectedDevice,
          isLandscape: _isLandscape,
          child: ProviderScope(
            overrides: [
              // state-based overrides can be added here if needed
            ],
            child: widget.item.builder(context),
          ),
        ),
      ),
    );
  }
}
