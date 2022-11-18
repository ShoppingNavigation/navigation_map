import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:store_navigation_map/src/map_world.dart';

class MapGame extends FlameGame {

  @override
  Future<void> onLoad() async {
    final world = MapWorld();

    final camera = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.topLeft;
      
    add(world);
    add(camera);
  }


}