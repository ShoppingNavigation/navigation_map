import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugShelfMinimalBoundingRect extends PositionComponent {
  final GroundPlanShelfModel shelf;

  DebugShelfMinimalBoundingRect({required this.shelf}) {
    position = shelf.position;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromPoints(
          Vector2.all(0).toOffset(),
          shelf.minimalBoundingRectangle.toOffset(),
        ),
        DebugGlobals.minimalBoundingRectanglePaint);
  }
}
