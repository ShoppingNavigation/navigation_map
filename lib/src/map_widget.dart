import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/cubits/admin/admin_cubit.dart';
import 'package:store_navigation_map/src/cubits/cubit_observer.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/src/cubits/groundplan/groundplan_cubit.dart';
import 'package:store_navigation_map/src/cubits/map_controls/map_controls_cubit.dart';
import 'package:store_navigation_map/src/cubits/user/user_cubit.dart';
import 'package:store_navigation_map/src/debug/widget/debug_log.dart';
import 'package:store_navigation_map/src/debug/widget/debug_values.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/widgets/map_controls.dart';
import 'package:store_navigation_map/src/widgets/next_category.dart';
import 'package:store_navigation_map/src/widgets/zoom_info.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

DebugCubit? debugCubit;
late MapControlsCubit mapControlsCubit;
late GroundPlanCubit groundPlanCubit;
late AdminCubit adminCubit;
late UserCubit userCubit;
RoutingCubit? routingCubit;

bool isInForeground = true;

/// Top level Widget for navigation map. This widget contains the map itself, the map controls and
/// the navigation controls
class NavigationMap extends StatefulWidget {
  final GroundPlanModel groundplan;
  final bool canShowDebug;

  /// when [canShowDebug] is true, this will automatically default to [true], even if explicitly set to [false]
  final bool canShowGraph;

  NavigationMap(
      {super.key,
      required this.groundplan,
      bool adminActive = false,
      void Function(UiNode)? onShelfSelected,
      this.canShowDebug = false,
      this.canShowGraph = false,
      List<CategoryModel> categories = const []}) {
    if (canShowDebug && !kDebugMode) {
      throw Exception('Cannot set "canShowDebug" to true, when not in debug mode');
    }

    if (adminActive && onShelfSelected == null) {
      throw Exception('Cannot set adminActive to true without providing onShelfSelected function');
    }


    Bloc.observer = DebugObserver();
    debugCubit = DebugCubit(canShowDebug: canShowDebug, canShowGraph: canShowGraph);
    mapControlsCubit = MapControlsCubit(
      additionalZoom: groundplan.additionalZoom,
      startupPosition: groundplan.startupPosition,
    );
    groundPlanCubit = GroundPlanCubit(groundplan, categories: categories);
    adminCubit = AdminCubit(active: adminActive, onShelfSelected: onShelfSelected ?? (node) {});
    userCubit = UserCubit(groundplan.graph);
  }

  @override
  State<NavigationMap> createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> with WidgetsBindingObserver {
  final game = MapGame();

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    isInForeground = state == AppLifecycleState.resumed;
    log('changed app forground state to: $isInForeground');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Globals.colorScheme = Theme.of(context).colorScheme;
    Globals.textTheme = Theme.of(context).textTheme;
    routingCubit ??= context.read<RoutingCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mapControlsCubit),
        BlocProvider.value(value: debugCubit!),
        BlocProvider.value(value: groundPlanCubit),
      ],
      child: Stack(children: [
        GameWidget(game: game),
        BlocBuilder<DebugCubit, DebugState>(
          builder: (context, state) {
            if (!widget.canShowDebug || !state.isDebugEnabled) {
              return Container();
            }

            return Positioned(
              top: 10,
              right: 10,
              child: DebugValues(
                debugValues: state.debugValues,
              ),
            );
          },
        ),
        Positioned(
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
            if (!widget.canShowDebug || !state.isDebugEnabled) {
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
          bottom: 10,
          right: 10,
          left: 10,
          child: NextCategory(),
        )
      ]),
    );
  }
}
