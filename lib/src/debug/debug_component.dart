import 'package:flame/components.dart';
import 'package:store_navigation_map/src/debug/graph/debug_graph.dart';
import 'package:store_navigation_map/src/debug/groundplan/connector_point.dart';
import 'package:store_navigation_map/src/debug/groundplan/user.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugComponent extends Component {
  final List<GroundPlanShelfModel> shelves;
  final NavigationGraph<UiNode> graph;

  DebugComponent({required this.graph, required this.shelves});
  @override
  Future<void>? onLoad() async {
    for (final shelf in shelves) {
      add(DebugShelfConnectorPoint(shelf: shelf));
    }

    add(DebugGraph(graph: graph));
    add(DebugUser());
    return super.onLoad();
  }
}
