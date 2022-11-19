import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanOutline extends PositionComponent {
  final GroundPlanOutlineModel outline;
  late Path _outlinePath;

  GroundPlanOutline({required this.outline}) {
    _outlinePath = _buildPath(outline.vertices);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        _outlinePath,
        Paint()
          ..color = Globals.colorScheme.surface
          ..strokeWidth = 10
          ..style = PaintingStyle.fill);
  }

  Path _buildPath(List<Vector2> vertices) {
    final path = Path();
    path.moveTo(vertices.first.x, vertices.first.y);

    for (final vert in vertices.skip(1)) {
      path.lineTo(vert.x, vert.y);
    }

    path.close();
    return path;
  }
}
