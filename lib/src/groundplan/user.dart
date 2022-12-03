import 'package:flame/components.dart';
import 'package:store_navigation_map/src/map_widget.dart';

class GroundPlanUser extends PositionComponent {
  Vector2 _currentPosition = Vector2.zero();

  GroundPlanUser() {
    userCubit.stream.listen((event) {
      _currentPosition = event.edgePosition;
    });
  }
}
