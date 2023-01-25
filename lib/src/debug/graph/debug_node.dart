import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/utils/debug_globals.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugNode extends Component {
  static final double _textSize = 2 * groundPlanCubit.state.groundPlan.lineWidth;
  final TextPaint _textPaint = TextPaint(
    style: TextStyle(
      fontSize: _textSize,
      color: Globals.colorScheme.onBackground,
    ),
  );
  final UiNode node;

  DebugNode({required this.node});

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
        node.position.toOffset(), 2.0 * groundPlanCubit.state.groundPlan.lineWidth, DebugGlobals.nodePaint);
    _textPaint.render(
        canvas, node.name,
      Vector2(
        node.position.x - ((_textSize * node.name.length / 2) / 2),
        node.position.y - (_textSize / 2),
      ),
    );
  }

}