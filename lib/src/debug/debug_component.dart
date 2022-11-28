import 'package:flame/components.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/debug/groundplan/connector_point.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugComponent extends Component {
  final List<GroundPlanShelfModel> shelves;
  final NavigationGraph<UiNode> graph;

  DebugComponent({required this.graph, required this.shelves});
  @override
  Future<void>? onLoad() async {
    for (final shelf in shelves) {
      add(DebugShelfConnectorPoint(connector: shelf.connector));
    }

    add(DebugGraph(graph: graph));
    return super.onLoad();
  }
}
