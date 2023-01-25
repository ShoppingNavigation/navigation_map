import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:store_navigation_map/src/cubits/admin/admin_cubit.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlanShelf extends PositionComponent {
  Paint _shelfPaint = Globals.defaultShelfPaint;

  final GroundPlanShelfModel shelf;
  late final Path _shelfPath;

  GroundPlanShelf({required this.shelf}) {
    _shelfPath = _buildPath(shelf.position, shelf.vertices);

    position = shelf.position;

    adminCubit.stream.listen((event) {
      if (event is AdminShelfSelected) {
        if (event.selectedShelf.equals(shelf)) {
          _shelfPaint = Paint()..color = Globals.colorScheme.secondaryContainer;
        } else {
          _shelfPaint = Globals.defaultShelfPaint..color = Globals.colorScheme.primaryContainer;
        }
      }
    });
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        _shelfPath,
        _shelfPaint);
  }

  Path _buildPath(Vector2 start, List<Vector2> vertices) {
    final path = Path();
    path.moveTo(0, 0);

    for (final vert in vertices) {
      path.relativeLineTo(vert.x, vert.y);
    }

    return path..close();
  }

}
