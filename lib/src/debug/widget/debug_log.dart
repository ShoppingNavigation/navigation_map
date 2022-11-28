import 'package:flutter/material.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class DebugLog extends StatelessWidget {
  final Iterable<String> logs;

  const DebugLog({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: logs
            .map((e) => Text(
                  e,
                  style: TextStyle(color: Globals.colorScheme.error),
                  textAlign: TextAlign.left,
                ))
            .toList(),
      ),
    );
  }
}
