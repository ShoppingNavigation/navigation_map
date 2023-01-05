import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:store_navigation_map/src/map_container.dart';
import 'package:store_navigation_map/src/map_world.dart';

class MapGame extends FlameGame with HasDraggables, HasTappables {

  @override
  Future<void> onLoad() async {
    final world = MapWorld()..add(MapContainer());

    final camera = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.topLeft;
      
    add(world);
    add(camera);

    return super.onLoad();
  }

}