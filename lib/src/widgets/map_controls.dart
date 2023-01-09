import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/src/cubits/map_controls/map_controls_cubit.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class MapControls extends StatelessWidget {

  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloatingActionButton.small(
          onPressed: () async {
            await NotificationHelper.notify(title: 'Hallo', body: 'Hello world how are u');
          },
          child: const Icon(Icons.gps_fixed),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.small(
          onPressed: () {
            context.read<MapControlsCubit>().zoom(0.1);
          },
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.small(
          onPressed: () {
            context.read<MapControlsCubit>().zoom(-0.1);
          },
          child: const Icon(Icons.remove),
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
              child: const Icon(Icons.route)
          ),
        ]
      ],
    );
  }
}
