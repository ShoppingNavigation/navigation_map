import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

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

const obst = CategoryModel(id: 'grt', name: 'Obst', nodeId: 'v1_2');
const gemuse = CategoryModel(id: 'asdf', name: 'Gemüse', nodeId: 'v2');
const brot = CategoryModel(id: 'bjdfgeth', name: 'Brot', nodeId: 'v3_4');
const konserven = CategoryModel(id: 'gdsfkljb', name: 'Konserven', nodeId: 'v4');
const getranke = CategoryModel(id: 'asdfftrh', name: 'Getränke', nodeId: 'v6_7');
const milch = CategoryModel(id: 'vertniou', name: 'Milchprodukte', nodeId: 'v9');
const fleisch = CategoryModel(id: 'fdghytjit7y', name: 'Fleischprodukte', nodeId: 'v9');
const fisch = CategoryModel(id: 'sgtyrjr6', name: 'Fischprodukte', nodeId: 'v9');

const List<CategoryModel> categories = [obst, gemuse, brot, konserven, getranke, milch, fleisch, fisch];

final startNode = UiNode('Start', position: Vector2(30, 0));
final _v0 = UiNode('v0', position: Vector2(30, 10));
final _v1 = UiNode('v1', position: Vector2(25, 10));
final _v1_2 = UiNode('v1_2', position: Vector2(15, 10), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(15, 17.5),
    category: obst,
  ),
]);
final _v2 = UiNode('v2', position: Vector2(5, 10), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(5, 2.5),
    category: gemuse,
  ),
]);
final _v3 = UiNode('v3', position: Vector2(5, 30));
final _v3_4 = UiNode('v3_4', position: Vector2(15, 30), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(15, 22.5),
    category: brot,
  ),
]);
final _v4 = UiNode('v4', position: Vector2(25, 30), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(25, 37.5),
    category: konserven,
  ),
]);
final _v5 = UiNode('v5', position: Vector2(45, 30));
final _v6 = UiNode('v6', position: Vector2(5, 50));
final _v6_7 = UiNode('v6_7', position: Vector2(25, 50), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(25, 42.5),
    category: getranke,
  )
]);
final _v7 = UiNode('v7', position: Vector2(45, 50));
final _v8 = UiNode('v8', position: Vector2(45, 40));
final _v9 = UiNode('v9', position: Vector2(65, 42.5), connectorPoints: [
  ShelfCategoryConnector(
    position: Vector2(65, 32.5),
    category: milch,
  ),
  ShelfCategoryConnector(
    position: Vector2(65, 52.5),
    category: fleisch,
  ),
  ShelfCategoryConnector(
    position: Vector2(77.5, 42.5),
    category: fisch,
  ),
]);
final _graph = NavigationGraph<UiNode>(nodes: [
  startNode,
  _v0,
  _v1,
  _v1_2,
  _v2,
  _v3,
  _v3_4,
  _v4,
  _v5,
  _v6,
  _v6_7,
  _v7,
  _v8,
  _v9,
])
  ..connect(startNode, _v0, 10)
  ..connect(_v0, _v1, 5)
  ..connect(_v1, _v1_2, 10)
  ..connect(_v1_2, _v2, 10)
  ..connect(_v1, _v4, 20)
  ..connect(_v2, _v3, 20)
  ..connect(_v3, _v3_4, 10)
  ..connect(_v3_4, _v4, 10)
  ..connect(_v3, _v6, 20)
  ..connect(_v4, _v5, 20)
  ..connect(_v5, _v8, 10)
  ..connect(_v6, _v6_7, 20)
  ..connect(_v6_7, _v7, 20)
  ..connect(_v8, _v7, 10)
  ..connect(_v8, _v9, 20);

final GroundPlanModel groundPlan = GroundPlanModel(
  additionalZoom: 5,
  startupPosition: Vector2(75, 100),
  outline: _outline,
  graph: _graph,
  shelves: _shelves,
  obstacles: _obstacles,
);
