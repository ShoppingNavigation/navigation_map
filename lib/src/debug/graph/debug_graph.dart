import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/debug/graph/debug_edge.dart';
import 'package:store_navigation_map/src/debug/graph/debug_node.dart';

class DebugGraph extends PositionComponent {

  final NavigationGraph graph;

  DebugGraph({required this.graph});

  @override
  Future<void> onLoad() async {
    for (final edge in graph.generateEdgeTable()) {
      add(DebugEdge(edge: edge));
    }

    for (final node in graph.nodes) {
      add(DebugNode(node: node));
    }

    super.onLoad();
  }

  @override
  void render(Canvas canvas) {}

}