import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

final GroundPlanOutlineModel outline = GroundPlanOutlineModel(vertices: [
  Vector2(0, 0),
  Vector2(250, 0),
  Vector2(250, 40),
  Vector2(430, 40),
  Vector2(430, 85),
  Vector2(330, 85),
  Vector2(330, 135),
  Vector2(430, 135),
  Vector2(430, 345),
  Vector2(330, 345),
  Vector2(330, 375),
  Vector2(0, 375),
]);

final GroundPlanModel groundPlan = GroundPlanModel(outline: outline, graph: NavigationGraph(nodes: []));
