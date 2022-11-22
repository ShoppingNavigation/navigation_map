import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

part 'routing_state.dart';

class RoutingCubit extends Cubit<RoutingState> {
  RoutingCubit() : super(RoutingInitial());

  /// begins routing to a given node
  void routeTo(UiNode start, CategoryModel destination) {
    final graph = groundPlanCubit.state.groundPlan.graph;

    /// get first node which has a connection to the category
    final destinationNode = graph.nodes.firstWhere(
      (element) => element.connectorPoints.any((element) => element.category.id == destination.id),
    );

    final RouteToResult<UiNode>? result = groundPlanCubit.state.groundPlan.graph.routeTo(start, destinationNode);
    if (result == null) {
      debugCubit?.addLog('No route found betwenn $start and $destination');
      return;
    }

    emit(state.singleRouting(result));
  }
}
