import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/map_widget.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class GroundPlanUser extends PositionComponent {
  Vector2? _currentPosition = Vector2.zero();

  GroundPlanUser() {
    userCubit.stream.listen((event) {
      _currentPosition = event.mappingResult.found ? event.mappingResult.closestPoint : null;
    });
  }

  @override
  void render(Canvas canvas) {
    if (_currentPosition == null) {
      return;
    }

    canvas.drawCircle(_currentPosition!.toOffset(), 2, Paint()..color = Globals.colorScheme.tertiary);
  }
}
