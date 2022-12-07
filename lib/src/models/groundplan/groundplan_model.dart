import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

class GroundPlanModel {
  /// for small groundplans and additional zoom can make sense
  /// to make the map larger by default
  final double additionalZoom;

  /// set the start camera position
  final Vector2? startupPosition;

  final NavigationGraph<UiNode> graph;
  final GroundPlanOutlineModel outline;
  final List<GroundPlanShelfModel> shelves;
  final List<GroundPlanObstacleModel> obstacles;

  const GroundPlanModel({
    required this.outline,
    required this.graph,
    required this.shelves,
    required this.obstacles,
    this.additionalZoom = 0,
    this.startupPosition,
  });

  static GroundPlanModel get empty => GroundPlanModel(
      additionalZoom: 1,
        outline: const GroundPlanOutlineModel(vertices: []),
        graph: NavigationGraph(nodes: []),
        shelves: [],
        obstacles: [],
      );

  /// generates a groundplan from the provided yaml
  static GroundPlanModel fromYaml(String yaml) {
    final yamlContent = loadYaml(yaml);

    assert(yamlContent.containsKey('outline'));

    return GroundPlanModel(
      additionalZoom: 1,
      outline: GroundPlanOutlineModel.fromYaml(yamlContent['outline']),
      graph: NavigationGraph(nodes: []),
      shelves: [],
      obstacles: [],
    );
  }
}
