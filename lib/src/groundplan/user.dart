import 'dart:ui';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/map_widget.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/utils/user_data_provider.dart';

class GroundPlanUser extends PositionComponent with HasGameRef<MapGame> {
  late final Path arrowPath;

  GroundPlanUser() {
    anchor = Anchor.center;

    position = userCubit.state.calculatedPosition;
    userCubit.stream.listen((event) {
      position = event.calculatedPosition;
    });

    GpsUserDataProvider().getRotation().listen((event) {
      assert(event <= 180 && event >= -180);
      angle = event * (math.pi / 180.0);
    });
  }

  @override
  void render(Canvas canvas) {
    final lineWidth = 2 * groundPlanCubit.state.groundPlan.lineWidth;
    canvas.drawCircle(
        Offset.zero, lineWidth, Paint()..color = Globals.colorScheme.tertiary);

    canvas.drawLine(
      Offset.zero,
      Offset(0, -lineWidth),
      Paint()..color = Globals.colorScheme.surface,
    );
  }
}
