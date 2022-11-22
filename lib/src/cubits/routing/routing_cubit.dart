import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
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
      if (stateRoute.connectors.length == stateRoute.currentDestinationIndex + 1) {
        emit(state.finish());
        return;
      }

      emit(state.multiRouting(stateRoute.routes, stateRoute.connectors, stateRoute.currentDestinationIndex + 1));
    }
  }

  /// begins routing to a list of categories
  void routeToAll(UiNode start, List<CategoryModel> destinations) {
    final graph = groundPlanCubit.state.groundPlan.graph;
    final destinationNodes = destinations
        .map(
          (e) => graph.nodes.firstWhere(
            (element) => element.connectorPoints.any((element) => element.category.id == e.id),
          ),
        )
        .toList();

    final RouteToAllResult<UiNode>? result = graph.routeToAll(start, destinationNodes);
    if (result == null) {
      debugCubit?.addLog('No route found to visit all categories $destinations');
      return;
    }

    final routeIds = destinations.map((e) => e.id);
    final destinationConnectors = <ShelfCategoryConnector>[];
    for (final partRoute in result.route) {
      destinationConnectors
          .add(partRoute.last.connectorPoints.firstWhere((element) => routeIds.contains(element.category.id)));
    }

    emit(state.multiRouting(result, destinationConnectors, 0));
  }

  /// begins routing to a given category
  void routeTo(UiNode start, CategoryModel destination) {
    final graph = groundPlanCubit.state.groundPlan.graph;

    /// get first node which has a connection to the category
    final destinationNode = graph.nodes.firstWhere(
      (element) => element.connectorPoints.any((element) => element.category.id == destination.id),
    );

    final RouteToResult<UiNode>? result = graph.routeTo(start, destinationNode);
    if (result == null) {
      debugCubit?.addLog('No route found betwenn $start and $destination');
      return;
    }

    emit(state.singleRouting(
      result,
      destinationNode.connectorPoints.firstWhere((element) => element.category.id == destination.id),
    ));
  }
}
