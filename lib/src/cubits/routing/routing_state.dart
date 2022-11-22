part of 'routing_cubit.dart';

@immutable
abstract class RoutingState {
  RoutingState singleRouting(RouteToResult<UiNode> route) => RoutingSingleRoute(currentRoute: route);
}

class RoutingInitial extends RoutingState {}

class RoutingSingleRoute extends RoutingState {
  final RouteToResult<UiNode> currentRoute;
  RoutingSingleRoute({required this.currentRoute});

  @override
  String toString() => 'Routing to ${currentRoute.route.last} (${currentRoute.distance}) via ${currentRoute.route}';
}
