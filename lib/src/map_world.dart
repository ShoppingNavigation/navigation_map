import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class MapWorld extends World {

  @override
  void render(Canvas canvas){
    canvas.drawColor(Globals.colorScheme.surface, BlendMode.hardLight);
  }

}