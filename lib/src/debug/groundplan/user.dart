import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/map_widget.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';

class DebugUser extends PositionComponent {
  Vector2 _currentPosition = Vector2.zero();

  DebugUser() {
    userCubit.stream.listen((event) {
      _currentPosition = event.position;
    });
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(_currentPosition.toOffset(), 2, DebugGlobals.userPaint);
  }
}
