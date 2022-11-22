import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'routing_state.dart';

class RoutingCubit extends Cubit<RoutingState> {
  RoutingCubit() : super(RoutingInitial());

  /// begins routing to a given node
  void routeTo(UiNode start, UiNode destination) {
    final RouteToResult<UiNode>? result = groundPlanCubit.state.groundPlan.graph.routeTo(start, destination);
    if (result == null) {
      debugCubit?.addLog('No route found betwenn $start and $destination');
      return;
    }

    emit(state.singleRouting(result));
  }
}
