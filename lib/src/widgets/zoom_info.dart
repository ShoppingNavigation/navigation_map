import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/map_controls/map_controls_cubit.dart';

class ZoomInfo extends StatefulWidget {
  const ZoomInfo({super.key});

  @override
  State<ZoomInfo> createState() => _ZoomInfoState();
}

class _ZoomInfoState extends State<ZoomInfo> {
  bool _showZoomChip = false;
  double _zoomValue = 1;
  Timer? _zoomChipDelayTimer;

  void _showNewZoomChip(double newZoom) {
    if (!mounted) {
      return;
    }
    _zoomChipDelayTimer?.cancel();
    setState(() {
      _showZoomChip = true;
      _zoomValue = newZoom;
    });
    _zoomChipDelayTimer = Timer(
      const Duration(seconds: 2),
      () => setState(() {
        if (mounted) {
          _showZoomChip = false;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapControlsCubit, MapControlsState>(
      listener: (context, state) {
        _showNewZoomChip(state.zoom);
      },
      child: AnimatedOpacity(
        opacity: _showZoomChip ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Text('${(_zoomValue * 100).toStringAsFixed(0)}%'),
          ),
        ),
      ),
    );
  }
}
