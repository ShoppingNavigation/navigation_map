import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugEdge extends Component {
  static const double _textSize = 1;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );
  final Edge<UiNode> edge;

  DebugEdge({required this.edge});

  @override
  void render(Canvas canvas) {
    canvas.drawLine(
      edge.first.position.toOffset(),
      edge.second.position.toOffset(),
      DebugGlobals.edgePaint,
    );

    _textPaint.render(canvas, edge.distance.toStringAsFixed(2),
        Vector2(
          (edge.first.position.x + edge.second.position.x) / 2,
          (edge.first.position.y + edge.second.position.y) / 2,
        ));
  }
}
