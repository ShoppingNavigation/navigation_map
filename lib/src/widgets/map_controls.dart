import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.gps_fixed),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.remove),
        ),
        if (kDebugMode) ...[
          const SizedBox(height: 20),
          FloatingActionButton.small(
            onPressed: () {},
            child: const Icon(Icons.adb),
          ),
        ]
      ],
    );
  }
}
