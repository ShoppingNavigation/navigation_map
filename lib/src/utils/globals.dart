import 'package:flutter/material.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';

class Globals {
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF626200));

  /// this wont fail, since we set it in MapWidget
  // ignore: null_check_always_fails
  static NavigationGraph graph = null!;
}