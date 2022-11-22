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

    _initializeRouteAndListener();

    return super.onLoad();
  }

  void _initializeRouteAndListener() {
    final initialState = routingCubit?.state;
    if (initialState != null && initialState is RoutingSingleRoute) {
      _currentDisplayingRoute =
          GroundPlanRoute(route: initialState.currentRoute.route, connector: initialState.connectorPoint);
      add(_currentDisplayingRoute!);
    }

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

      if (event is RoutingFinished && _currentDisplayingRoute != null && contains(_currentDisplayingRoute!)) {
        remove(_currentDisplayingRoute!);
      }
    });
  }
}
