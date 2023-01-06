import 'package:bloc/bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

part 'groundplan_state.dart';

class GroundPlanCubit extends Cubit<GroundPlanState> {
  GroundPlanCubit(GroundPlanModel groundPlan, {List<CategoryModel> categories = const []})
      : super(GroundPlanState(groundPlan: groundPlan)) {
    if (categories.isEmpty) {
      return;
    }

    groundPlan.shelves = groundPlan.shelves
        .map((e) => e
          ..connector =
              (e.connector..category = categories.firstWhere((element) => element.nodeId == e.connector.nodeId)))
        .toList();
    emit(GroundPlanState(groundPlan: groundPlan));
  }
}
