import 'package:bloc/bloc.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'groundplan_state.dart';

class GroundPlanCubit extends Cubit<GroundPlanState> {
  GroundPlanCubit(GroundPlanModel groundPlan)
      : super(GroundPlanState(
          groundPlan: groundPlan,
        ));


  /// begins routing to a given node
  void routeTo(UiNode start, UiNode destination) {
    final RouteToResult<UiNode>? result = state.groundPlan.graph.routeTo(start, destination);
    if (result == null) {
      debugCubit?.addLog('No route found betwenn $start and $destination');
      return;
    }

    emit(state.routing(result));
  }
}
