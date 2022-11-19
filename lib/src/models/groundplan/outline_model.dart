import 'package:store_navigation_map/store_navigation_map.dart';

/// The outline for the store. All shelfs and the graph should be inside these bounds
/// the outline is drawn in order of the [vertices] list
class GroundPlanOutlineModel {
  final List<Vector2> vertices;

  const GroundPlanOutlineModel({required this.vertices});
}
