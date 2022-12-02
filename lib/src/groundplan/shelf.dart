import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/models/groundplan/shelf_model.dart';
import 'package:store_navigation_map/src/utils/collection_extension.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanShelf extends PositionComponent with Tappable {
  final GroundPlanShelfModel shelfModel;
  late final Path _shelfPath;

  GroundPlanShelf({required this.shelfModel}) {
    _shelfPath = _buildPath(shelfModel.position, shelfModel.vertices);

    position = shelfModel.position;

    size = _calculateMinimalBoundingRectangle(shelfModel.vertices);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        _shelfPath,
        Paint()
          ..color = Globals.colorScheme.primaryContainer
          ..style = PaintingStyle.fill);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    debugCubit?.addLog('tap ${shelfModel.connector.category.name}');
    return true;
  }

  Path _buildPath(Vector2 start, List<Vector2> vertices) {
    final path = Path();
    path.moveTo(0, 0);

    for (final vert in vertices) {
      path.relativeLineTo(vert.x, vert.y);
    }

    return path..close();
  }

  Vector2 _calculateMinimalBoundingRectangle(List<Vector2> vertices) {
    return Vector2(vertices.maxBy((p0) => p0.x).x, vertices.maxBy((p0) => p0.y).y);
  }

}
