import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class DebugNode extends Component {
  static const double _textSize = 20;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );
  final Node node;

  DebugNode({required this.node});

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(node.x, node.y), 20.0, Paint()..color = Globals.colorScheme.tertiary);
    _textPaint.render(
        canvas, node.name, Vector2(node.x - ((_textSize * node.name.length / 2) / 2), node.y - (_textSize / 2)));
  }

}