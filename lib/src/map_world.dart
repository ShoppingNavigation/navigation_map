import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class MapWorld extends World {

  @override
  Future<void> onLoad() async {
    add(DebugGraph(graph: Globals.graph));

    super.onLoad();
  }

  @override
  void render(Canvas canvas){
    canvas.drawColor(Globals.colorScheme.surface, BlendMode.hardLight);
  }

}