import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

part 'routing_state.dart';

class RoutingCubit extends Cubit<RoutingState> {
  RoutingCubit() : super(RoutingInitial());

  /// finishes the current object (or the complete routing)
  void finish() {
    if (state is RoutingSingleRoute) {
      emit(state.finish());
      return;
    }

    if (state is RoutingMultiRoute) {
      final stateRoute = state as RoutingMultiRoute;
      if (stateRoute.routes.route.length == stateRoute.currentDestinationIndex + 1) {
        emit(state.finish());
        return;
      }

      emit(state.multiRouting(stateRoute.routes, stateRoute.connectors, stateRoute.currentDestinationIndex + 1));
    }
  }

  /// begins routing to a list of categories
  void routeToAll(UiNode start, List<CategoryModel> destinations) {
    final graph = groundPlanCubit.state.groundPlan.graph;
    final shelves = groundPlanCubit.state.groundPlan.shelves;
    final destinationNodes =
        shelves.where((e) => destinations.contains(e.connector.category)).map((e) => e.connector.node).toList();

    final RouteToAllResult<UiNode>? result = graph.routeToAll(start, destinationNodes);
    if (result == null) {
      debugCubit?.addLog('No route found to visit all categories $destinations');
      return;
    }

    emit(state.multiRouting(result, shelves.map((e) => e.connector).toList(), 0));
  }

  /// begins routing to a given category
  void routeTo(UiNode start, CategoryModel destination) {
    final graph = groundPlanCubit.state.groundPlan.graph;
    final shelves = groundPlanCubit.state.groundPlan.shelves;

    /// get first node which has a connection to the category
    final destinationConnector = shelves.firstWhere((element) => element.connector.category == destination).connector;

    final RouteToResult<UiNode>? result = graph.routeTo(start, destinationConnector.node);
    if (result == null) {
      debugCubit?.addLog('No route found betwenn $start and $destination');
      return;
    }

    emit(state.singleRouting(result, destinationConnector));
  }
}
