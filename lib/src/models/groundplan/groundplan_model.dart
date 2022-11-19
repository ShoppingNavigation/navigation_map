import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanModel {
  final NavigationGraph<UiNode> graph;
  final GroundPlanOutlineModel outline;

  const GroundPlanModel({required this.outline, required this.graph});

  static GroundPlanModel get empty => GroundPlanModel(
        outline: const GroundPlanOutlineModel(vertices: []),
        graph: NavigationGraph(nodes: []),
      );
}
