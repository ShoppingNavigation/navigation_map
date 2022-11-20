import 'dart:ui';

import 'package:flame/components.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanRoute extends Component {
  final List<UiNode> route;
  late Path _routePath;

  GroundPlanRoute({required this.route}) {
    _routePath = _buildPath(route);
  }

  @override
  void render(Canvas canvas) {
    for (int i = 1; i < route.length; i++) {
      canvas.drawPath(
          _routePath,
          Paint()
            ..color = Globals.colorScheme.tertiary
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke);
    }
  }

  Path _buildPath(List<UiNode> route) {
    final path = Path();
    path.moveTo(route.first.position.x, route.first.position.y);

    for (final vert in route.skip(1)) {
      path.lineTo(vert.position.x, vert.position.y);
    }

    return path;
  }
}
