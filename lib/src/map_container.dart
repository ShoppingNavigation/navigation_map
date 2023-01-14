import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:store_navigation_map/src/debug/debug_component.dart';
import 'package:store_navigation_map/src/groundplan/groundplan.dart';
import 'package:store_navigation_map/src/groundplan/user.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

/// Container for the flame-game components.
/// This container is moved when the customer "drags the groundplan arround"
class MapContainer extends PositionComponent with Draggable {
  /// Used to display the current drag movement in debug mode
  final List<Vector2> _renderDragTrace = [];

  /// Used to move the container according to all the collected deltas between updates
  final Queue<Vector2> _movementTrace = Queue<Vector2>();

  bool _isDebugViewShown = kDebugMode;
  late DebugComponent _debugGraphComponent;
  
  bool _isGraphShown = kDebugMode;

  @override
  Future<void>? onLoad() async {
    size = groundPlanCubit.state.groundPlan.outline.minimalBoundingRectangle;
    scale = Vector2(1, 1);
    // position = mapControlsCubit.state.startupPosition;

    add(GroundPlan());
    _debugGraphComponent = DebugComponent(
        graph: groundPlanCubit.state.groundPlan.graph, shelves: groundPlanCubit.state.groundPlan.shelves);

    _isDebugViewShown = debugCubit?.state.isDebugEnabled ?? false;
    _isGraphShown = debugCubit?.state.isGraphShown ?? false;
    debugCubit?.stream.listen((event) {
      _isDebugViewShown = event.isDebugEnabled;
      _isGraphShown = event.isGraphShown;
    });

    if (_isGraphShown) {
      add(_debugGraphComponent);
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Globals.colorScheme.surfaceVariant, BlendMode.hardLight);
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
    if (_isGraphShown && !contains(_debugGraphComponent)) {
      add(_debugGraphComponent);
      _isGraphShown = true;
    } else if (!_isGraphShown && contains(_debugGraphComponent)) {
      remove(_debugGraphComponent);
      _isGraphShown = false;
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
    if (groundPlanCubit.state.trackUser) {
      position = Vector2.zero();
    }
    return true;
  }
}
