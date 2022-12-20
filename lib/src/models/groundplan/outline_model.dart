import 'package:store_navigation_map/src/utils/collection_extension.dart';
import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

/// The outline for the store. All shelfs and the graph should be inside these bounds
/// the outline is drawn in order of the [vertices] list
class GroundPlanOutlineModel {
  final List<Vector2> vertices;
  final Vector2 minimalBoundingRectangle;

  GroundPlanOutlineModel({required this.vertices})
      : minimalBoundingRectangle = Vector2(vertices.maxBy((p0) => p0.x).x, vertices.maxBy((p0) => p0.y).y);

  static GroundPlanOutlineModel fromYaml(YamlList outlineYaml) {
    assert(outlineYaml.length >= 3, 'needs at least 3 vertices for a closed shape');

    return GroundPlanOutlineModel(vertices: outlineYaml.map((e) => vectorFromYaml(e)).toList());
  }
}
