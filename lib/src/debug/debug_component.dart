import 'package:flame/components.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/debug/groundplan/connector_point.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugComponent extends Component {
  final NavigationGraph<UiNode> graph;

  DebugComponent({required this.graph});
  @override
  Future<void>? onLoad() async {
    for (final node in graph.nodes.where((element) => element.connectorPoints.isNotEmpty)) {
      for (final connector in node.connectorPoints) {
        add(DebugConnectorPoint(fromNode: node, connector: connector));
      }
    }

    add(DebugGraph(graph: graph));
    return super.onLoad();
  }
}
