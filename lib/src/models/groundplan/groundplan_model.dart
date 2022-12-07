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
    final YamlMap yamlContent = loadYaml(yaml);

    assert(yamlContent.containsKey('outline'));
    assert(yamlContent.containsKey('shelves') && yamlContent['shelves'] is YamlList);
    assert(yamlContent.containsKey('obstacles') && yamlContent['obstacles'] is YamlList);

    return GroundPlanModel(
      additionalZoom: yamlContent['additionalZoom'] as double? ?? 1,
      outline: GroundPlanOutlineModel.fromYaml(yamlContent['outline']),
      graph: NavigationGraph(nodes: []),
      shelves: (yamlContent['shelves'] as YamlList).map((element) => GroundPlanShelfModel.fromYaml(element)).toList(),
      obstacles:
          (yamlContent['obstacles'] as YamlList).map((element) => GroundPlanObstacleModel.fromYaml(element)).toList(),
    );
  }
}
