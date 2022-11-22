import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugConnectorPoint extends Component {
  static const _textSize = 1.0;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );

  final UiNode fromNode;
  final ShelfCategoryConnector connector;

  DebugConnectorPoint({required this.fromNode, required this.connector});

  @override
  void render(Canvas canvas) {
    canvas.drawLine(fromNode.position.toOffset(), connector.position.toOffset(), DebugGlobals.connectorPointEdgePaint);
    canvas.drawCircle(connector.position.toOffset(), 1, DebugGlobals.connectorPointPaint);
    _textPaint.render(
      canvas,
      connector.category.name,
      Vector2(
        connector.position.x - ((_textSize * connector.category.name.length / 2) / 2),
        connector.position.y - (_textSize / 2),
      ),
    );
  }
}
