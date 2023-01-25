import 'package:flame/game.dart';
import 'package:store_navigation_map/src/groundplan/user.dart';
import 'package:store_navigation_map/src/map_container.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class MapGame extends FlameGame with HasDraggables, HasTappables {
  late final GroundPlanUser _user;

  @override
  Future<void> onLoad() async {
    _user = GroundPlanUser();
    add(MapContainer(user: _user));

    if (groundPlanCubit.state.trackUser) {
      camera.followComponent(_user);
    }

    camera.zoom = mapControlsCubit.state.zoom;
    mapControlsCubit.stream.listen((event) {
      camera.zoom = event.zoom;
    });

    return super.onLoad();
  }
}
