part of 'groundplan_cubit.dart';

class GroundPlanState {
  final GroundPlanModel groundPlan;
  final bool trackUser;

  GroundPlanState({required this.groundPlan, required this.trackUser});

  @override
  String toString() => 'Load Groundplan. Graph has ${groundPlan.graph.nodeCount} nodes.';
}
