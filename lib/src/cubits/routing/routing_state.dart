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
  final bool reached;

  RoutingSingleRoute({required this.route, required this.connectorPoint, this.reached = false}) {
    debugCubit?.addLog(toString());
  }

  CategoryModel get currentCategory => connectorPoint.category!;

  RoutingSingleRoute reach() => RoutingSingleRoute(route: route, connectorPoint: connectorPoint, reached: true);

  @override
  get props => [route, connectorPoint];

  @override
  String toString() => 'Routing to ${route.route.last} (${route.distance})';
}

/// Routing to multiple destinations in one go
class RoutingMultiRoute extends RoutingState {
  final RouteToAllResult<UiNode> routes;
  final List<ShelfCategoryConnector> connectors;
  final int currentDestinationIndex;
  final bool reached;

  RoutingMultiRoute(
      {required this.routes, required this.currentDestinationIndex, required this.connectors, this.reached = false}) {
    debugCubit?.addLog(toString());
  }

  ShelfCategoryConnector get currentConnector {
    final currentDestinationNode = routes.route[currentDestinationIndex].last;
    final res = connectors.firstWhere((element) => element.node.equals(currentDestinationNode));
    return res;
  }

  CategoryModel get currentCategory => currentConnector.category!;
  int get currentSubRoute => currentDestinationIndex + 1;
  int get destinationCount => routes.route.length;

  RoutingMultiRoute reach() => RoutingMultiRoute(
      routes: routes, currentDestinationIndex: currentDestinationIndex, connectors: connectors, reached: true);

  @override
  get props => [routes, connectors, currentDestinationIndex];

  @override
  String toString() =>
      'Multirouting to ${currentCategory.name} ($currentSubRoute/$destinationCount). Connector to ${currentConnector.node}';
}
