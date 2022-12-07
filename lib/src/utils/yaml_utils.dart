import 'package:flame/game.dart';

Vector2 yamlToVector(Map yaml) {
  assert(yaml.containsKey('x'));
  assert(yaml.containsKey('y'));

  final num x = yaml['x'];
  final num y = yaml['y'];

  return Vector2(x.toDouble(), y.toDouble());
}
