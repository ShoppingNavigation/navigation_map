import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/src/cubits/map_controls/map_controls_cubit.dart';

class MapControls extends StatelessWidget {

  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.gps_fixed),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.small(
          onPressed: () {
            context.read<MapControlsCubit>().zoom(0.1);
          },
          child: const Icon(Icons.add),
        ),
        FloatingActionButton.small(
          onPressed: () {
            context.read<MapControlsCubit>().zoom(-0.1);
          },
          child: const Icon(Icons.remove),
        ),
        if (kDebugMode) ...[
          const SizedBox(height: 20),
          FloatingActionButton.small(
            onPressed: () {
              context.read<DebugCubit>().changeVisibility();
            },
            child: const Icon(Icons.adb),
          ),
        ]
      ],
    );
  }
}
