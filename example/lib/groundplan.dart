import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

final GroundPlanOutlineModel _outline = GroundPlanOutlineModel(vertices: [
  Vector2(0, 0),
  Vector2(50, 0),
  Vector2(50, 30),
  Vector2(80, 30),
  Vector2(80, 55),
  Vector2(0, 55),
]);

final List<GroundPlanShelfModel> _shelves = [
  GroundPlanShelfModel(position: Vector2(0, 0), vertices: [
    Vector2(20, 0),
    Vector2(0, 5),
    Vector2(-20, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(10, 15), vertices: [
    Vector2(10, 0),
    Vector2(0, 5),
    Vector2(-10, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(10, 20), vertices: [
    Vector2(10, 0),
    Vector2(0, 5),
    Vector2(-10, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(10, 35), vertices: [
    Vector2(30, 0),
    Vector2(0, 5),
    Vector2(-30, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(10, 40), vertices: [
    Vector2(30, 0),
    Vector2(0, 5),
    Vector2(-30, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(55, 30), vertices: [
    Vector2(25, 0),
    Vector2(0, 5),
    Vector2(-25, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(75, 35), vertices: [
    Vector2(5, 0),
    Vector2(0, 20),
    Vector2(-5, 0),
  ]),
  GroundPlanShelfModel(position: Vector2(55, 50), vertices: [
    Vector2(25, 0),
    Vector2(0, 5),
    Vector2(-25, 0),
  ]),
];

final _obstacles = <GroundPlanObstacleModel>[
  GroundPlanObstacleModel(
    position: Vector2(30, 15),
    vertices: [
      Vector2(5, 0),
      Vector2(0, 10),
      Vector2(-5, 0),
    ],
  ),
  GroundPlanObstacleModel(
    position: Vector2(43, 10),
    vertices: [
      Vector2(7, 0),
      Vector2(0, 15),
      Vector2(-7, 0),
    ],
  ),
];

final _start = UiNode('Start', position: Vector2(30, 0));
final _v0 = UiNode('v0', position: Vector2(30, 10));
final _v1 = UiNode('v1', position: Vector2(25, 10));
final _v2 = UiNode('v2', position: Vector2(5, 10));
final _v3 = UiNode('v3', position: Vector2(5, 30));
final _v4 = UiNode('v4', position: Vector2(25, 30));
final _v5 = UiNode('v5', position: Vector2(45, 30));
final _v6 = UiNode('v6', position: Vector2(5, 50));
final _v7 = UiNode('v7', position: Vector2(45, 40));
final _v8 = UiNode('v8', position: Vector2(45, 50));
final _v9 = UiNode('v9', position: Vector2(65, 43));
final _graph = NavigationGraph<UiNode>(nodes: [_start, _v0, _v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9])
  ..connect(_start, _v0, 10)
  ..connect(_v0, _v1, 5)
  ..connect(_v1, _v4, 20)
  ..connect(_v1, _v2, 20)
  ..connect(_v2, _v3, 20)
  ..connect(_v3, _v4, 20)
  ..connect(_v3, _v6, 20)
  ..connect(_v4, _v5, 20)
  ..connect(_v5, _v7, 10)
  ..connect(_v6, _v8, 40)
  ..connect(_v7, _v8, 10)
  ..connect(_v7, _v9, 20);

final GroundPlanModel groundPlan = GroundPlanModel(
  additionalZoom: 3,
  startupPosition: Vector2(100, 100),
  outline: _outline,
  graph: _graph,
  shelves: _shelves,
  obstacles: _obstacles,
);
