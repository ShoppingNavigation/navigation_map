import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/src/utils/user_data_provider.dart';
import 'package:store_navigation_map/src/utils/user_graph_mapper.dart';

import '../../../store_navigation_map.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserGraphMapper _ugm;

  UserCubit(NavigationGraph<UiNode> graph)
      : _ugm = UserGraphMapper(graph),
        super(UserInitial()) {
    FakeUserDataProvider().getPosition().listen((event) {
      emit(UserPositionSet(position: event, edgePosition: _ugm.closestPointOnEdge(event)));
    });
  }
}