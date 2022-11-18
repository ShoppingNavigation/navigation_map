import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/map_game.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/src/widgets/map_controls.dart';
import 'package:store_navigation_map/src/widgets/next_category.dart';

class NavigationMap extends StatelessWidget {
  final NavigationGraph graph;

  NavigationMap({super.key, required this.graph}) {
    Globals.graph = graph;
  }

  final game = MapGame();

  @override
  Widget build(BuildContext context) {
    Globals.colorScheme = Theme.of(context).colorScheme;
    Globals.textTheme = Theme.of(context).textTheme;

    return Stack(children: [
      GameWidget(game: game),
      const Positioned(
        top: 10,
        left: 10,
        child: MapControls(),
      ),
      const Positioned(
        bottom: 20,
        right: 10,
        left: 10,
        child: NextCategory(),
      )
    ]);
  }
}