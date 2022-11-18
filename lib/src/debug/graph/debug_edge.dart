import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class DebugEdge extends Component {
  static const double _textSize = 10;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );
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

    _textPaint.render(canvas, edge.distance.toStringAsFixed(2),
        Vector2((edge.first.x + edge.second.x) / 2, (edge.first.y + edge.second.y) / 2));
  }
}
