part of 'groundplan_cubit.dart';

class GroundPlanState {
  final GroundPlanModel groundPlan;

  const GroundPlanState({required this.groundPlan});

  GroundPlanState routing(RouteToResult<UiNode> route) =>
      GroundPlanRoutingState(groundPlan: groundPlan, currentRoute: route);

  @override
  String toString() => 'Load Groundplan. Graph has ${groundPlan.graph.nodeCount} nodes.';
}

class GroundPlanRoutingState extends GroundPlanState {
  final RouteToResult<UiNode> currentRoute;
  const GroundPlanRoutingState({required super.groundPlan, required this.currentRoute});

  @override
  String toString() => 'Routing to ${currentRoute.route.last} (${currentRoute.distance}) via ${currentRoute.route}';
}
