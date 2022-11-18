import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:flutter/foundation.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/utils/map_state.dart';

class MapWorld extends World {

  bool _isDebugViewShown = kDebugMode;
  late DebugGraph _graph;

  @override
  Future<void> onLoad() async {
    _graph = DebugGraph(graph: Globals.graph);
    if (_isDebugViewShown) {
      add(_graph);
    }

    super.onLoad();
  }

  @override
  void render(Canvas canvas){
    canvas.drawColor(Globals.colorScheme.surface, BlendMode.hardLight);
  }

  @override
  void update(double dt) {
    if (MapState.showDebugView && !_isDebugViewShown) {
      add(_graph);
      _isDebugViewShown = true;
    } else if (!MapState.showDebugView && _isDebugViewShown) {
      remove(_graph);
      _isDebugViewShown = false;
    }
  }

}