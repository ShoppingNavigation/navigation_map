import 'package:flutter/material.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

void main() {
  final v0 = Node('v0', x: 200, y: 40);
  final v1 = Node('v1', x: 40, y: 100);
  final v2 = Node('v2', x: 200, y: 200);
  final v3 = Node('v3', x: 360, y: 100);
  final v4 = Node('v4', x: 40, y: 200);
  final v5 = Node('v5', x: 360, y: 300);
  final v6 = Node('v6', x: 40, y: 300);
  final v7 = Node('v7', x: 360, y: 400);
  final v8 = Node('v8', x: 40, y: 400);
  final v9 = Node('v9', x: 200, y: 500);
  final unconnected = Node('U', x: 200, y: 600);

  final graph = NavigationGraph(nodes: [v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, unconnected]);
  graph.connect(v0, v1, 3);
  graph.connect(v0, v2, 5);
  graph.connect(v0, v3, 1);
  graph.connect(v1, v4, 1);
  graph.connect(v4, v6, 1);
  graph.connect(v6, v8, 2);
  graph.connect(v6, v9, 4);
  graph.connect(v8, v9, 3);
  graph.connect(v2, v9, 3);
  graph.connect(v2, v5, 4);
  graph.connect(v3, v5, 2);
  graph.connect(v5, v7, 1);
  graph.connect(v5, v9, 3);
  graph.connect(v7, v9, 3);
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF626200))),
    home: Scaffold(
      appBar: AppBar(title: const Text('Navigation Map Example')),
      body: NavigationMap(
        graph: graph,
      ),
    ),
  ));
}
