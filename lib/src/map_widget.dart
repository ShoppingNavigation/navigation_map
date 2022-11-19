import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/cubit_observer.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/src/cubits/groundplan/groundplan_cubit.dart';
import 'package:store_navigation_map/src/cubits/map_controls/map_controls_cubit.dart';
import 'package:store_navigation_map/src/debug/widget/debug_log.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/widgets/map_controls.dart';
import 'package:store_navigation_map/src/widgets/next_category.dart';
import 'package:store_navigation_map/src/widgets/zoom_info.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

DebugCubit? debugCubit;
late MapControlsCubit mapControlsCubit;
late GroundPlanCubit groundPlanCubit;

class NavigationMap extends StatelessWidget {
  final GroundPlanModel groundplan;

  NavigationMap({super.key, required this.groundplan}) {
    Bloc.observer = DebugObserver();
    debugCubit = DebugCubit();
    mapControlsCubit = MapControlsCubit();
    groundPlanCubit = GroundPlanCubit(groundplan);
  }

  final game = MapGame();

  @override
  Widget build(BuildContext context) {
    Globals.colorScheme = Theme.of(context).colorScheme;
    Globals.textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mapControlsCubit),
        BlocProvider.value(value: debugCubit!),
        BlocProvider.value(value: groundPlanCubit),
      ],
      child: Stack(children: [
        GameWidget(game: game),
        const Positioned(
          top: 10,
          left: 10,
          child: MapControls(),
        ),
        const Positioned(
          top: 10,
          right: 10,
          child: ZoomInfo(),
        ),
        BlocBuilder<DebugCubit, DebugState>(
          builder: (context, state) {
            if (!state.isDebugEnabled) {
              return Container();
            }

            return Positioned(
              bottom: 10,
              left: 10,
              child: DebugLog(
                logs: state.latestMessages,
              ),
            );
          },
        ),
        const Positioned(
          bottom: 20,
          right: 10,
          left: 10,
          child: NextCategory(),
        )
      ]),
    );
  }
}
