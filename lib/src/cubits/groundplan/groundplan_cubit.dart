import 'package:bloc/bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

part 'groundplan_state.dart';

class GroundPlanCubit extends Cubit<GroundPlanState> {
  GroundPlanCubit(GroundPlanModel groundPlan,
      {List<CategoryModel> categories = const [], bool trackUser = true})
      : super(GroundPlanState(groundPlan: groundPlan, trackUser: trackUser)) {
    emit(GroundPlanState(
        groundPlan: _mapCategoriesToGroundplan(groundPlan, categories),
        trackUser: trackUser));
  }

  GroundPlanModel _mapCategoriesToGroundplan(
      GroundPlanModel groundPlan, List<CategoryModel> categories) {
    for (var category in categories) {
      try {
        var shelf = groundPlan.shelves.firstWhere(
            (element) => element.connector.nodeId == category.nodeId);
        shelf.connector.category = category;
      } on StateError catch (_) {}
    }
    return groundPlan;
  }

  void updateCategories(List<CategoryModel> categories,
      {GroundPlanModel? groundPlan}) {
    emit(GroundPlanState(
        groundPlan: _mapCategoriesToGroundplan(
            groundPlan ?? state.groundPlan, categories),
        trackUser: state.trackUser));
  }
}
