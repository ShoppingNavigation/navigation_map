import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/map_widget.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class GroundPlanUser extends PositionComponent with HasGameRef<MapGame> {

  GroundPlanUser() {
    userCubit.stream.listen((event) {
      position = event.mappingResult.found ? event.mappingResult.closestPoint! : event.position;
    });
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
        Offset.zero, 2 * groundPlanCubit.state.groundPlan.lineWidth,
        Paint()..color = Globals.colorScheme.tertiary);
  }
}
