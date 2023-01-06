part of 'groundplan_cubit.dart';

class GroundPlanState {
  final GroundPlanModel groundPlan;

  GroundPlanState({required this.groundPlan}) : super();

  @override
  String toString() => 'Load Groundplan. Graph has ${groundPlan.graph.nodeCount} nodes.';
}
