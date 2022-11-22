part of 'routing_cubit.dart';

@immutable
abstract class RoutingState {
  RoutingState finish() => RoutingFinished();
  RoutingState singleRouting(RouteToResult<UiNode> route, ShelfCategoryConnector connector) => RoutingSingleRoute(
        currentRoute: route,
        connectorPoint: connector,
      );
  RoutingState multiRouting(
          RouteToAllResult<UiNode> routes, List<ShelfCategoryConnector> connectors, int currentSubRoute) =>
      RoutingMultiRoute(
        routes: routes,
        currentDestinationIndex: currentSubRoute,
        connectors: connectors,
      );
}

class RoutingInitial extends RoutingState {}

class RoutingFinished extends RoutingState {}

class RoutingSingleRoute extends RoutingState {
  final RouteToResult<UiNode> currentRoute;
  final ShelfCategoryConnector connectorPoint;
  RoutingSingleRoute({required this.currentRoute, required this.connectorPoint});

  @override
  String toString() => 'Routing to ${currentRoute.route.last} (${currentRoute.distance}) via ${currentRoute.route}';
}

/// Routing to multiple destinations in one go
/// [routes] and [connectors] must be in same order
class RoutingMultiRoute extends RoutingState {
  final RouteToAllResult<UiNode> routes;
  final List<ShelfCategoryConnector> connectors;
  final int currentDestinationIndex;

  RoutingMultiRoute({required this.routes, required this.currentDestinationIndex, required this.connectors});

  CategoryModel get currentDestination => connectors[currentDestinationIndex].category;
  int get currentSubRoute => currentDestinationIndex + 1;
  int get destinationCount => connectors.length;

  @override
  String toString() => 'Multirouting to ${connectors.length} destinations';
}
