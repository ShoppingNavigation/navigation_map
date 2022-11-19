import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

final GroundPlanOutlineModel outline = GroundPlanOutlineModel(vertices: [
  Vector2(0, 0),
  Vector2(50, 0),
  Vector2(50, 30),
  Vector2(80, 30),
  Vector2(80, 55),
  Vector2(0, 55),
]);

final List<GroundPlanShelfModel> shelves = [
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

final GroundPlanModel groundPlan = GroundPlanModel(
  additionalZoom: 3,
  outline: outline,
  graph: NavigationGraph(nodes: []),
  shelves: shelves,
);
