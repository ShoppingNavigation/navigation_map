import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/widgets/map_controls.dart';

class NavigationMap extends StatelessWidget {
  final ColorScheme? overrideColorScheme;
  final NavigationGraph graph;

  NavigationMap({super.key, required this.graph, this.overrideColorScheme}){
    if(overrideColorScheme != null){
      Globals.colorScheme = overrideColorScheme!;
    }

    Globals.graph = graph;
  }

  final game = MapGame();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GameWidget(game: game),
      const Positioned(
        top: 10,
        left: 10,
        child: MapControls(),
      ),
    ]);
  }
}