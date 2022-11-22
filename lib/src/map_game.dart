import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:store_navigation_map/src/map_container.dart';
import 'package:store_navigation_map/src/map_world.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class MapGame extends FlameGame with HasDraggables, ScaleDetector {

  @override
  Future<void> onLoad() async {
    final world = MapWorld()..add(MapContainer());

    final camera = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.topLeft;
      
    add(world);
    add(camera);

    return super.onLoad();
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    mapControlsCubit.zoom((info.delta.game.x * 0.02).clamp(-0.01, 0.01));
  }

}