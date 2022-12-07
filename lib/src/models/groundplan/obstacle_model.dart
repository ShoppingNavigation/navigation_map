import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

/// draws an obstacle (for example a wall or the cash register)
class GroundPlanObstacleModel {
  final Vector2 position;
  final List<Vector2> vertices;

  const GroundPlanObstacleModel({required this.position, required this.vertices});

  static GroundPlanObstacleModel fromYaml(YamlMap yaml) {
    assert(yaml.containsKey('position'));
    assert(yaml.containsKey('vertices') && yaml['vertices'] is YamlList);

    return GroundPlanObstacleModel(
        position: vectorFromYaml(yaml['position']),
        vertices: (yaml['vertices'] as YamlList).map((element) => vectorFromYaml(element)).toList());
  }
}
