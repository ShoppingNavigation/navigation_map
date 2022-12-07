import 'package:flame/game.dart';

/// either x or y must be set.
/// If one of them is not set, it will default to 0
/// If both of them are not set, it will fail
Vector2 vectorFromYaml(Map yaml) {
  assert(yaml.containsKey('x') || yaml.containsKey('y'));

  final num? x = yaml['x'];
  final num? y = yaml['y'];

  return Vector2(x?.toDouble() ?? 0.0, y?.toDouble() ?? 0.0);
}
