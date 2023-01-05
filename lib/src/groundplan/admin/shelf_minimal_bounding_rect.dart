import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

/// This component is used for the shelf-category connection
class GroundplanAdminShelfMinimalBoundingRect extends PositionComponent with Tappable {
  final GroundPlanShelfModel shelf;

  GroundplanAdminShelfMinimalBoundingRect({required this.shelf}) {
    position = shelf.minimalBoundingRectangle.anchor;
    size = shelf.minimalBoundingRectangle.anchor;
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

  @override
  bool onTapUp(TapUpInfo info) {
    adminCubit.selectShelf(shelf);
    return true;
  }
}
