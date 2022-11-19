import 'package:flame/components.dart';
import 'package:store_navigation_map/src/groundplan/outline.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlan extends Component {
  @override
  Future<void>? onLoad() async {
    final GroundPlanModel groundPlan = groundPlanCubit.state.groundPlan;

    add(GroundPlanOutline(outline: groundPlan.outline));

    return super.onLoad();
  }
}
