import 'package:store_navigation_map/store_navigation_map.dart';

final v0 = UiNode('v0', position: Vector2(20, 0));
final v1 = UiNode('v1', position: Vector2(0, 10));
final v2 = UiNode('v2', position: Vector2(20, 20));
final v3 = UiNode('v3', position: Vector2(40, 10));
final v4 = UiNode('v4', position: Vector2(0, 20));
final v5 = UiNode('v5', position: Vector2(40, 30));
final v6 = UiNode('v6', position: Vector2(0, 30));
final v7 = UiNode('v7', position: Vector2(40, 40));
final v8 = UiNode('v8', position: Vector2(0, 40));
final v9 = UiNode('v9', position: Vector2(20, 50));
final unconnected = UiNode('unconnected', position: Vector2(20, 60));

final _graph = NavigationGraph<UiNode>(nodes: [v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, unconnected])
  ..connect(v0, v1, 3)
  ..connect(v0, v2, 5)
  ..connect(v0, v3, 1)
  ..connect(v1, v4, 1)
  ..connect(v4, v6, 1)
  ..connect(v6, v8, 2)
  ..connect(v6, v9, 4)
  ..connect(v8, v9, 3)
  ..connect(v2, v9, 3)
  ..connect(v2, v5, 4)
  ..connect(v3, v5, 2)
  ..connect(v5, v7, 1)
  ..connect(v5, v9, 3)
  ..connect(v7, v9, 3);

final groundPlanOnlyGraph = GroundPlanModel(
  anchorCoordinates: Vector2.zero(),
  additionalZoom: 5,
  startupPosition: Vector2(100, 100),
  outline: GroundPlanOutlineModel(vertices: [Vector2(0, 0), Vector2(40, 0), Vector2(40, 60), Vector2(0, 60)]),
  graph: _graph,
  shelves: [],
  obstacles: [],
);
