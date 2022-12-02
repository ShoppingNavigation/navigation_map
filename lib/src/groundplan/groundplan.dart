import 'package:flame/components.dart';
import 'package:store_navigation_map/src/groundplan/obstacle.dart';
import 'package:store_navigation_map/src/groundplan/outline.dart';
import 'package:store_navigation_map/src/groundplan/route.dart';
import 'package:store_navigation_map/src/groundplan/shelf.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class GroundPlan extends PositionComponent {

  GroundPlanRoute? _currentDisplayingRoute;

  @override
  Future<void>? onLoad() async {
    position = Vector2.all(0);
    scale = Vector2.all(1);

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
          GroundPlanRoute(route: initialState.route.route, connector: initialState.connectorPoint);
      add(_currentDisplayingRoute!);
    }

    routingCubit?.stream.listen((event) {
      if (event is RoutingSingleRoute) {
        _showRoute(event.route.route, event.connectorPoint);
        return;
      }

      if (event is RoutingMultiRoute) {
        _showRoute(event.routes.route[event.currentDestinationIndex], event.currentConnector);
        return;
      }

      if (event is RoutingFinished && _currentDisplayingRoute != null && contains(_currentDisplayingRoute!)) {
        remove(_currentDisplayingRoute!);
      }
    });
  }

  void _showRoute(List<UiNode> route, ShelfCategoryConnector connector) {
    if (_currentDisplayingRoute == null) {
      _currentDisplayingRoute = GroundPlanRoute(route: route, connector: connector);
      add(_currentDisplayingRoute!);
      return;
    }


    if (contains(_currentDisplayingRoute!)) {
      remove(_currentDisplayingRoute!);
    }

    _currentDisplayingRoute = GroundPlanRoute(route: route, connector: connector);
    add(_currentDisplayingRoute!);
  }
}
