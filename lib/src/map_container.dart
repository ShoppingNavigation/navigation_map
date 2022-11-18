import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class MapContainer extends PositionComponent with Draggable {
  /// Used to display the current drag movement in debug mode
  final List<Vector2> _renderDragTrace = [];

  /// Used to move the container according to all the collected deltas between updates
  final Queue<Vector2> _movementTrace = Queue<Vector2>();

  bool _isDebugViewShown = kDebugMode;
  late DebugGraph _graph;

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(1000);
    scale = Vector2(0.8, 0.8);
    position = Vector2(0, 0);

    _graph = DebugGraph(graph: graphCubit.state.graph);
    if (_isDebugViewShown) {
      add(_graph);
    }

    mapControlsCubit.stream.listen((event) {
      if (event.zoom != scale.x) {
        scale = Vector2(event.zoom, event.zoom);
      }
    });

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    if (_isDebugViewShown) {
      _renderTrace(canvas);
    }
  }

  @override
  void update(double dt) {

    _handleDragPosition();
    _checkDebugModeSwap();
  }

  void _renderTrace(Canvas canvas) {
    if (_renderDragTrace.length >= 2) {
      for (var i = 1; i < _renderDragTrace.length; i++) {
        canvas.drawLine(_renderDragTrace[i - 1].toOffset(), _renderDragTrace[i].toOffset(),
            Paint()..color = Globals.colorScheme.error);
      }
    }
  }

  void _handleDragPosition() {
    // This is necessary, because there can be more than one update per update
    if (_movementTrace.isNotEmpty) {
      Vector2 summedMovement = Vector2(0, 0);
      while (_movementTrace.isNotEmpty) {
        summedMovement += _movementTrace.removeFirst();
      }

      position += summedMovement;
    }
  }

  void _checkDebugModeSwap() {
    if (debugCubit!.state.isDebugEnabled && !_isDebugViewShown) {
      add(_graph);
      _isDebugViewShown = true;
    } else if (!debugCubit!.state.isDebugEnabled && _isDebugViewShown) {
      remove(_graph);
      _isDebugViewShown = false;
    }
  }

  @override
  bool onDragStart(DragStartInfo info) {
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    _renderDragTrace.add(info.eventPosition.game);
    _movementTrace.addLast(info.delta.game);
    return true;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    _renderDragTrace.clear();
    return true;
  }
}
