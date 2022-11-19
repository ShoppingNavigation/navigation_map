import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/models/groundplan/shelf_model.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class GroundPlanShelf extends Component {
  final GroundPlanShelfModel shelfModel;
  late final Path _shelfPath;

  GroundPlanShelf({required this.shelfModel}) {
    _shelfPath = _buildPath(shelfModel.position, shelfModel.vertices);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        _shelfPath,
        Paint()
          ..color = Globals.colorScheme.primaryContainer
          ..style = PaintingStyle.fill);
  }

  Path _buildPath(Vector2 start, List<Vector2> vertices) {
    final path = Path();
    path.moveTo(start.x, start.y);

    for (final vert in vertices) {
      path.relativeLineTo(vert.x, vert.y);
    }

    return path..close();
  }
}
