import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class DebugEdge extends Component {
  final Edge edge;

  DebugEdge({required this.edge});

  @override
  void render(Canvas canvas) {
    canvas.drawLine(
      Offset(edge.first.x, edge.first.y),
      Offset(edge.second.x, edge.second.y),
      Paint()
        ..color = Globals.colorScheme.tertiaryContainer
        ..strokeWidth = 5,
    );
  }
}
