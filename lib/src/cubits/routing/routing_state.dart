part of 'routing_cubit.dart';

@immutable
abstract class RoutingState extends Equatable {
  RoutingState finish() => RoutingFinished();
  RoutingState singleRouting(RouteToResult<UiNode> route, ShelfCategoryConnector connector) => RoutingSingleRoute(
        route: route,
        connectorPoint: connector,
      );
  RoutingState multiRouting(
          RouteToAllResult<UiNode> routes, List<ShelfCategoryConnector> connectors, int currentSubRoute) =>
      RoutingMultiRoute(
        routes: routes,
        currentDestinationIndex: currentSubRoute,
        connectors: connectors,
      );

  @override
  get props => [];
}

class RoutingInitial extends RoutingState {}

class RoutingFinished extends RoutingState {}

class RoutingSingleRoute extends RoutingState {
  final RouteToResult<UiNode> route;
  final ShelfCategoryConnector connectorPoint;
  RoutingSingleRoute({required this.route, required this.connectorPoint}) {
    debugCubit?.addLog(toString());
  }

  CategoryModel get currentCategory => connectorPoint.category;

  @override
  get props => [route, connectorPoint];

  @override
  String toString() => 'Routing to ${route.route.last} (${route.distance}) via ${route.route}';
}

/// Routing to multiple destinations in one go
class RoutingMultiRoute extends RoutingState {
  final RouteToAllResult<UiNode> routes;
  final List<ShelfCategoryConnector> connectors;
  final int currentDestinationIndex;

  RoutingMultiRoute({required this.routes, required this.currentDestinationIndex, required this.connectors}) {
    debugCubit?.addLog(toString());
  }

  ShelfCategoryConnector get currentDestination {
    final currentDestinationNode = routes.route[currentDestinationIndex].last;
    return connectors.firstWhere((element) => element.node.equals(currentDestinationNode));
  }

  CategoryModel get currentCategory => currentDestination.category;
  int get currentSubRoute => currentDestinationIndex + 1;
  int get destinationCount => routes.route.length;

  @override
  get props => [routes, connectors, currentDestinationIndex];

  @override
  String toString() => 'Multirouting to $destinationCount destinations';
}
