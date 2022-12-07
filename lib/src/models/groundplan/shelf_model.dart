import 'package:store_navigation_map/src/utils/collection_extension.dart';
import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

class GroundPlanShelfModel {
  final String id;
  final Vector2 position;
  final List<Vector2> vertices;

  /// sets the connector to which the navigation graph connects
  final ShelfCategoryConnector connector;
  
  /// returns the minimal bounding reactangle for this shelfs. Begins at (0,0) and ends at the
  /// returned vector
  final Vector2 minimalBoundingRectangle;

  GroundPlanShelfModel({required this.id, required this.position, required this.vertices, required this.connector})
      : minimalBoundingRectangle = Vector2(vertices.maxBy((p0) => p0.x).x, vertices.maxBy((p0) => p0.y).y);

  bool equals(GroundPlanShelfModel other) => id == other.id;

  static GroundPlanShelfModel fromYaml(YamlMap yaml) {
    assert(yaml.containsKey('id'));
    assert(yaml.containsKey('position'));
    assert(yaml.containsKey('vertices') && yaml['vertices'] is YamlList);
    assert(yaml.containsKey('connector'));

    return GroundPlanShelfModel(
      id: yaml['id'],
      position: vectorFromYaml(yaml['position']),
      vertices: (yaml['vertices'] as YamlList).map((element) => vectorFromYaml(element)).toList(),
      connector: ShelfCategoryConnector.fromYaml(yaml['connector']),
    );
  }

}
