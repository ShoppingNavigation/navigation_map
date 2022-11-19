import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

final GroundPlanOutlineModel outline = GroundPlanOutlineModel(vertices: [
  Vector2(0, 0),
  Vector2(1000, 0),
  Vector2(1000, 400),
  Vector2(800, 400),
  Vector2(800, 600),
  Vector2(0, 600),
]);

final GroundPlanModel groundPlan = GroundPlanModel(outline: outline, graph: NavigationGraph(nodes: []));
