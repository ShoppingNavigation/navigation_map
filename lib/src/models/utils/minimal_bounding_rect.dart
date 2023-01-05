import 'package:flame/widgets.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class MinimalBoundingRect {
  final Vector2 anchor;
  final Vector2 size;

  MinimalBoundingRect(this.anchor, this.size);

  Anchor get typedAnchor => Anchor(anchor.x, anchor.y);
}
