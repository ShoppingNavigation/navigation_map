import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanShelfModel {
  final Vector2 position;
  final List<Vector2> vertices;
  //final List<ConnectorPoint> connectorPoints;

  const GroundPlanShelfModel({required this.position, required this.vertices});
}
