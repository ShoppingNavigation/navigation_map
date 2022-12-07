import 'package:flame/extensions.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

/// This class is an extension to [Node]
/// It contains all the (for the graph itself) unnecessary information
/// that is used for displaying and finding the destination node etc..
class UiNode extends Node {
  final Vector2 position;

  UiNode(super.name, {required this.position});

  static UiNode fromYaml(YamlMap yaml) {
    assert(yaml.containsKey('name'));
    assert(yaml.containsKey('position'));

    return UiNode(yaml['name'], position: vectorFromYaml(yaml['position']));
  }
}
