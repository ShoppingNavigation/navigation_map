import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

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
    return GameWidget(game: game);
  }
}