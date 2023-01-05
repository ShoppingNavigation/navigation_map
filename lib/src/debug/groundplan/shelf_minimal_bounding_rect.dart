import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugShelfMinimalBoundingRect extends PositionComponent {
  final GroundPlanShelfModel shelf;

  DebugShelfMinimalBoundingRect({required this.shelf}) {
    position = shelf.minimalBoundingRectangle.anchor;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromPoints(
          Offset.zero,
          shelf.minimalBoundingRectangle.size.toOffset(),
        ),
        DebugGlobals.minimalBoundingRectanglePaint);
  }
}
