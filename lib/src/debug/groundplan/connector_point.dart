import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugShelfConnectorPoint extends Component {
  static final _textSize = 1.0 * groundPlanCubit.state.groundPlan.lineWidth;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );

  final GroundPlanShelfModel shelf;

  DebugShelfConnectorPoint({required this.shelf});

  ShelfCategoryConnector get connector => shelf.connector;
  Vector2 get globalConnectorPosition => shelf.connector.position + shelf.position;

  @override
  void render(Canvas canvas) {
    canvas.drawLine(
        connector.node.position.toOffset(), globalConnectorPosition.toOffset(), DebugGlobals.connectorPointEdgePaint);
    canvas.drawCircle(globalConnectorPosition.toOffset(), 1, DebugGlobals.connectorPointPaint);

    if (connector.hasCategoryAssigned) {
      _textPaint.render(
        canvas,
        connector.category!.name,
        Vector2(
          globalConnectorPosition.x - ((_textSize * connector.category!.name.length / 2) / 2),
          globalConnectorPosition.y - (_textSize / 2),
        ),
      );
    }
  }
}
