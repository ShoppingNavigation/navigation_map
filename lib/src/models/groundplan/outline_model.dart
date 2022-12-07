import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

/// The outline for the store. All shelfs and the graph should be inside these bounds
/// the outline is drawn in order of the [vertices] list
class GroundPlanOutlineModel {
  final List<Vector2> vertices;

  const GroundPlanOutlineModel({required this.vertices});

  static GroundPlanOutlineModel fromYaml(YamlList outlineYaml) {
    assert(outlineYaml.length >= 3, 'needs at least 3 vertices for a closed shape');

    return GroundPlanOutlineModel(vertices: outlineYaml.map((e) => yamlToVector(e)).toList());
  }
}
