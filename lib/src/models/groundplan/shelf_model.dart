import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanShelfModel {
  final Vector2 position;
  final List<Vector2> vertices;

  /// sets the connector to which the navigation graph connects
  final ShelfCategoryConnector connector;

  const GroundPlanShelfModel({required this.position, required this.vertices, required this.connector});
}
