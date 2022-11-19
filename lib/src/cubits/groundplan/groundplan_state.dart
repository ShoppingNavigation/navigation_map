part of 'groundplan_cubit.dart';

class GroundPlanState {
  final GroundPlanModel groundPlan;

  const GroundPlanState({required this.groundPlan});

  @override
  String toString() => 'Load Groundplan. Graph has ${groundPlan.graph.nodeCount} nodes.';
}
