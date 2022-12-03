import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/cubits/user/user_cubit.dart';
import 'package:store_navigation_map/src/map_widget.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';

class DebugUser extends PositionComponent {
  UserState? event;

  DebugUser() {
    userCubit.stream.listen((event) {
      this.event = event;
    });
  }

  @override
  void render(Canvas canvas) {
    if (event == null) {
      return;
    }

    canvas.drawCircle(event!.position.toOffset(), 1, DebugGlobals.userPaint);
    canvas.drawLine(event!.position.toOffset(), event!.edgePosition.toOffset(), DebugGlobals.userPaint);
  }
}
