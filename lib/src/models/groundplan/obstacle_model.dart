import 'package:store_navigation_map/store_navigation_map.dart';

/// draws an obstacle (for example a wall or the cash register)
class GroundPlanObstacleModel {
  final Vector2 position;
  final List<Vector2> vertices;

  const GroundPlanObstacleModel({required this.position, required this.vertices});
}
