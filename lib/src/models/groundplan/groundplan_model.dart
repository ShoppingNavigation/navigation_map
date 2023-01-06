import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

class GroundPlanModel {
  /// for small groundplans and additional zoom can make sense
  /// to make the map larger by default
  final double additionalZoom;

  /// make the lineWidth thicker for large maps
  final double lineWidth;

  final Vector2 anchorCoordinates;

  /// set the start camera position
  final Vector2? startupPosition;

  final NavigationGraph<UiNode> graph;
  final GroundPlanOutlineModel outline;

  /// non-final, because the mapping between shelves and categories is done during runtime
  List<GroundPlanShelfModel> shelves;
  final List<GroundPlanObstacleModel> obstacles;

  GroundPlanModel({
    required this.outline,
    required this.graph,
    required this.shelves,
    required this.obstacles,
    required this.anchorCoordinates,
    this.additionalZoom = 0,
    this.lineWidth = 1,
    this.startupPosition,
  });

  static GroundPlanModel get empty => GroundPlanModel(
        additionalZoom: 1,
        anchorCoordinates: Vector2.zero(),
        outline: GroundPlanOutlineModel(vertices: []),
        graph: NavigationGraph(nodes: []),
        shelves: [],
        obstacles: [],
      );

  /// generates a groundplan from the provided yaml
  static GroundPlanModel fromYaml(String yaml) {
    final YamlMap yamlContent = loadYaml(yaml);

    assert(yamlContent.containsKey('graph'));
    assert(yamlContent.containsKey('outline'));
    assert(yamlContent.containsKey('shelves') && yamlContent['shelves'] is YamlList);
    assert(yamlContent.containsKey('obstacles') && yamlContent['obstacles'] is YamlList);

    return GroundPlanModel(
      anchorCoordinates: vectorFromYaml(yamlContent['anchorGeoCoordinates']),
      additionalZoom: (yamlContent['additionalZoom'] as num?)?.toDouble() ?? 0,
      lineWidth: (yamlContent['lineWidth'] as num?)?.toDouble() ?? 1,
      startupPosition: vectorFromYaml(yamlContent['startupPosition']),
      outline: GroundPlanOutlineModel.fromYaml(yamlContent['outline']),
      graph: graphFromTaml(yamlContent['graph']),
      shelves: (yamlContent['shelves'] as YamlList).map((element) => GroundPlanShelfModel.fromYaml(element)).toList(),
      obstacles:
          (yamlContent['obstacles'] as YamlList).map((element) => GroundPlanObstacleModel.fromYaml(element)).toList(),
    );
  }
}
