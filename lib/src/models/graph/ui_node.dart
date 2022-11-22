import 'package:flame/extensions.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/models/connectors/shelf_category_connector.dart';

/// This class is an extension to [Node]
/// It contains all the (for the graph itself) unnecessary information
/// that is used for displaying and finding the destination node etc..
class UiNode extends Node {
  final Vector2 position;

  /// stores with which shelves (and therefore categories) the Node is connected
  final List<ShelfCategoryConnector> connectorPoints;

  UiNode(super.name, {required this.position, this.connectorPoints = const []});
}
