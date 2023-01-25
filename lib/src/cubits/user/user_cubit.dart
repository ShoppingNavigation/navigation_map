import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_navigation_map/src/utils/user_data_provider.dart';
import 'package:store_navigation_map/src/utils/user_graph_mapper.dart';

import '../../../store_navigation_map.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserGraphMapper _ugm;
  final UserDataProvider _userDataProvider = GpsUserDataProvider();

  UserCubit(NavigationGraph<UiNode> graph)
      : _ugm = UserGraphMapper(graph),
        super(UserInitial()) {
    _init();
  }

  void _init() async {
    var stream = await _userDataProvider.getPosition();
    stream.listen((event) async {
      final ugmResult = _ugm.closestPointOnEdge(event);

      bool routeActive = routingCubit!.state is RoutingSingleRoute || routingCubit!.state is RoutingMultiRoute;

      Vector2 destinationPosition = Vector2.zero();
      bool reached = false;
      String categoryName = '';
      if (routeActive && routingCubit!.state is RoutingSingleRoute) {
        final state = (routingCubit!.state as RoutingSingleRoute);
        destinationPosition = state.connectorPoint.node.position;
        reached = state.reached;
        categoryName = state.currentCategory.name;
      } else if (routeActive && routingCubit!.state is RoutingMultiRoute) {
        final state = (routingCubit!.state as RoutingMultiRoute);
        destinationPosition = state.currentConnector.node.position;
        reached = state.reached;
        categoryName = state.currentCategory.name;
      }

      if (routeActive &&
          ugmResult.found &&
          !reached &&
          ugmResult.closestPoint!.distanceTo(destinationPosition) <=
              groundPlanCubit.state.groundPlan.notificationDistance) {
        routingCubit?.reach();
        await NotificationHelper.notifyCloseToNode(
            title: "'$categoryName' erreicht",
            body: routingCubit?.state is RoutingMultiRoute
                ? 'Die nächste Kategorie auf deiner Route wurde erreicht'
                : 'Die Kategorie wurde erreicht');
        debugCubit?.addLog('Sent notification for reaching category');
      }
      emit(UserPositionSet(position: event, mappingResult: ugmResult));
    });
  }
}
