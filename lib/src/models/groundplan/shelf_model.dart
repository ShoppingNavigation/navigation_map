import 'package:store_navigation_map/src/utils/collection_extension.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

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

}
