import 'package:store_navigation_map/src/utils/collection_extension.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanShelfModel {
  final Vector2 position;
  final List<Vector2> vertices;

  /// sets the connector to which the navigation graph connects
  final ShelfCategoryConnector connector;

  GroundPlanShelfModel({required this.position, required this.vertices, required this.connector});

  /// returns the minimal bounding reactangle for this shelfs. Begins at (0,0) and ends at the
  /// returned vector
  Vector2 get minimalBoundingRectangle =>
      _minimalBoundingRectangle ??= Vector2(vertices.maxBy((p0) => p0.x).x, vertices.maxBy((p0) => p0.y).y);

  Vector2? _minimalBoundingRectangle;
}
