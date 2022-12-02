import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/models/groundplan/obstacle_model.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class GroundPlanObstacle extends PositionComponent {
  final GroundPlanObstacleModel obstacle;
  late final Path _obstaclePath;

  GroundPlanObstacle({required this.obstacle}) {
    _obstaclePath = _buildPath(obstacle.position, obstacle.vertices);

    position = obstacle.position;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        _obstaclePath,
        Paint()
          ..color = Globals.colorScheme.onSurfaceVariant
          ..style = PaintingStyle.fill);
  }

  Path _buildPath(Vector2 start, List<Vector2> vertices) {
    final path = Path();
    path.moveTo(0, 0);

    for (final vert in vertices) {
      path.relativeLineTo(vert.x, vert.y);
    }

    return path..close();
  }
}
