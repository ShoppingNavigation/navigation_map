import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

class ShelfCategoryConnector {
  final Vector2 position;
  final CategoryModel category;
  final UiNode node;

  const ShelfCategoryConnector({required this.position, required this.category, required this.node});

  @override
  String toString() => '${category.name} connected to $node';
}
