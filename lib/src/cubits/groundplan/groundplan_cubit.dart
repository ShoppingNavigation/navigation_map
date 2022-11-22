import 'package:bloc/bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'groundplan_state.dart';

class GroundPlanCubit extends Cubit<GroundPlanState> {
  GroundPlanCubit(GroundPlanModel groundPlan)
      : super(GroundPlanState(
          groundPlan: groundPlan,
        )); 
}
