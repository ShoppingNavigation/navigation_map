part of 'routing_cubit.dart';

@immutable
abstract class RoutingState {
  RoutingState finish() => RoutingFinished();
  RoutingState singleRouting(RouteToResult<UiNode> route, ShelfCategoryConnector connector) => RoutingSingleRoute(
        currentRoute: route,
        connectorPoint: connector,
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
