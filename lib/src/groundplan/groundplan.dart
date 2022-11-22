import 'package:flame/components.dart';
import 'package:store_navigation_map/src/groundplan/obstacle.dart';
import 'package:store_navigation_map/src/groundplan/outline.dart';
import 'package:store_navigation_map/src/groundplan/route.dart';
import 'package:store_navigation_map/src/groundplan/shelf.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlan extends Component {

  GroundPlanRoute? _currentDisplayingRoute;

  @override
  Future<void>? onLoad() async {
    final GroundPlanModel groundPlan = groundPlanCubit.state.groundPlan;

    add(GroundPlanOutline(outline: groundPlan.outline));

    for (var element in groundPlan.shelves) {
      add(GroundPlanShelf(shelfModel: element));
    }

    for (var element in groundPlan.obstacles) {
      add(GroundPlanObstacle(obstacle: element));
    }

    _routeListener();

    return super.onLoad();
  }

  void _routeListener() {
    routingCubit?.stream.listen((event) {
      if (event is RoutingSingleRoute) {
        if (_currentDisplayingRoute == null) {
          _currentDisplayingRoute = GroundPlanRoute(route: event.currentRoute.route, connector: event.connectorPoint);
          add(_currentDisplayingRoute!);
          return;
        }


        if (contains(_currentDisplayingRoute!)) {
          remove(_currentDisplayingRoute!);
        }

        _currentDisplayingRoute = GroundPlanRoute(route: event.currentRoute.route, connector: event.connectorPoint);
        add(_currentDisplayingRoute!);
      }
    });
  }
}
