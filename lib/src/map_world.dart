import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

/// Contains the groundplan flame-world
class MapWorld extends World {
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Globals.colorScheme.surfaceVariant, BlendMode.hardLight);
  }
}
