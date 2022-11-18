import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class DebugLog extends StatelessWidget {
  const DebugLog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebugCubit, DebugState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.latestMessages
                .map((e) => Text(
                      e,
                      style: TextStyle(color: Globals.colorScheme.error),
                      textAlign: TextAlign.left,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
