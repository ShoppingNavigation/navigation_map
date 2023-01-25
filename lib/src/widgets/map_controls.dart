import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

//ignore: must_be_immutable
class MapControls extends StatelessWidget {
  Timer? _zoomTicker;

  MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () => _startZoomLongpress(1),
          onLongPressEnd: (details) => _stopZoomLongpress(),
          child: FloatingActionButton.small(
            onPressed: () {
              _zoom(1);
            },
            child: const Icon(Icons.add),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onLongPress: () => _startZoomLongpress(-1),
          onLongPressEnd: (details) => _stopZoomLongpress(),
          child: FloatingActionButton.small(
            onPressed: () {
              _zoom(-1);
            },
            child: const Icon(Icons.remove),
          ),
        ),
        if (debugCubit != null && debugCubit!.state.canShowDebug) ...[
          const SizedBox(height: 20),
          FloatingActionButton.small(
            onPressed: () {
              context.read<DebugCubit>().changeVisibility();
            },
            child: const Icon(Icons.adb),
          )
        ],
        if (debugCubit != null && debugCubit!.state.canShowGraph) ...[
          SizedBox(height: debugCubit!.state.canShowDebug ? 10 : 20),
          FloatingActionButton.small(
              onPressed: () {
                context.read<DebugCubit>().changeGraphVisibility();
              },
              child: const Icon(Icons.route)),
        ]
      ],
    );
  }

  /// zoom must either be [-1] or [1]
  void _startZoomLongpress(int zoom) {
    _zoomTicker = Timer.periodic(
        const Duration(milliseconds: 250), (timer) => _zoom(zoom));
  }

  void _stopZoomLongpress() {
    _zoomTicker?.cancel();
  }

  /// zoom must either be [-1] or [1]
  void _zoom(int zoom) {
    assert(zoom == -1 || zoom == 1);
    mapControlsCubit.zoom(zoom * 0.1);
  }
}
