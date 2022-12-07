import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:yaml/yaml.dart';

/// either x or y must be set.
/// If one of them is not set, it will default to 0
/// If both of them are not set, it will fail
Vector2 vectorFromYaml(YamlMap yaml) {
  assert(yaml.containsKey('x') || yaml.containsKey('y'));

  final num? x = yaml['x'];
  final num? y = yaml['y'];

  return Vector2(x?.toDouble() ?? 0.0, y?.toDouble() ?? 0.0);
}

/// generates the navigation graph with uiNodes from a provided yaml
NavigationGraph<UiNode> graphFromTaml(YamlMap yaml) {
  assert(yaml.containsKey('nodes') && yaml['nodes'] is YamlList);
  assert(yaml.containsKey('connections') && yaml['connections'] is YamlList);
  final graph = NavigationGraph(nodes: (yaml['nodes'] as YamlList).map((element) => UiNode.fromYaml(element)).toList());

  for (YamlMap connection in yaml['connections'] as YamlList) {
    assert(connection.containsKey('first'));
    assert(connection.containsKey('second'));
    assert(connection.containsKey('distance'));

    final num distance = connection['distance'];
    graph.connectNamed(connection['first'], connection['second'], distance.toDouble());
  }

  return graph;
}
